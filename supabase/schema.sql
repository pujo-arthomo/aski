-- ============================================================================
-- EVIDENCE ASKI — SKEMA DATABASE (Supabase / PostgreSQL)
-- ============================================================================
-- Cara pakai:
-- 1. Buka project Supabase > SQL Editor
-- 2. Tempel seluruh isi file ini, klik Run
-- 3. Cek tab "Table Editor" — 8 tabel di bawah ini akan muncul
--
-- Urutan tabel sengaja dari yang paling "atas" (master data instrumen ASKI,
-- jarang berubah) sampai yang paling "bawah" (data transaksi harian OPD).
-- ============================================================================


-- ----------------------------------------------------------------------------
-- 1. OBJEK_PENGAWASAN
-- Satu baris = satu OPD/UP/UK yang dinilai ASKI di satu tahun.
-- Contoh: "Bagian Pengadaan Barang dan Jasa" (jenis UP), "Sekretariat Daerah" (UK).
-- ----------------------------------------------------------------------------
create table objek_pengawasan (
  id            uuid primary key default gen_random_uuid(),
  nama_opd      text not null,
  jenis         text not null check (jenis in ('UP', 'UK')),
  tahun         int  not null default extract(year from now()),
  created_at    timestamptz not null default now()
);

-- ----------------------------------------------------------------------------
-- 2. PROFILES
-- Menempel ke auth.users bawaan Supabase. Menentukan siapa "admin" (Diskarpus)
-- dan siapa "operator" (staf OPD), dan operator itu jawab checklist untuk
-- objek_pengawasan yang mana.
-- ----------------------------------------------------------------------------
create table profiles (
  id                    uuid primary key references auth.users(id) on delete cascade,
  nama                  text not null,
  role                  text not null check (role in ('admin', 'operator')),
  created_at            timestamptz not null default now()
);

-- ----------------------------------------------------------------------------
-- 2b. AKSES_OBJEK
-- Relasi banyak-ke-banyak: satu akun (profiles) bisa punya akses ke lebih
-- dari satu objek_pengawasan (unit). Dipakai misalnya untuk Diskarpus sendiri
-- yang dinilai dengan 2 instrumen sekaligus (Unit Pengolah & Unit Kearsipan)
-- tapi cukup 1 akun operator yang bisa switch antar unit di aplikasi.
-- Untuk OPD lain yang cuma punya 1 unit, cukup 1 baris di tabel ini.
-- ----------------------------------------------------------------------------
create table akses_objek (
  id          uuid primary key default gen_random_uuid(),
  profile_id  uuid not null references profiles(id) on delete cascade,
  objek_id    uuid not null references objek_pengawasan(id) on delete cascade,
  created_at  timestamptz not null default now(),
  unique (profile_id, objek_id)
);

-- ----------------------------------------------------------------------------
-- 3. ASPEK_PENILAIAN
-- Master data — 2 aspek, bobotnya beda antara instrumen UP dan UK.
-- ----------------------------------------------------------------------------
create table aspek_penilaian (
  id                uuid primary key default gen_random_uuid(),
  jenis_instrumen   text not null check (jenis_instrumen in ('UP', 'UK')),
  nama              text not null,
  bobot             numeric not null,
  urutan            int not null
);

-- ----------------------------------------------------------------------------
-- 4. SUB_ASPEK
-- Master data — di bawah tiap aspek. bobot dan nilai_standar diambil
-- langsung dari sheet REKAPITULASI form ASKI asli.
-- ----------------------------------------------------------------------------
create table sub_aspek (
  id              uuid primary key default gen_random_uuid(),
  aspek_id        uuid not null references aspek_penilaian(id) on delete cascade,
  nama            text not null,
  bobot           numeric not null,
  nilai_standar   numeric not null,
  urutan          int not null
);

-- ----------------------------------------------------------------------------
-- 5. ITEM_PERTANYAAN
-- Master data — satu baris = satu nomor pertanyaan di form ASKI.
-- Diisi lewat scripts/extract_items.py (lihat README), bukan diketik manual.
-- ----------------------------------------------------------------------------
create table item_pertanyaan (
  id              uuid primary key default gen_random_uuid(),
  sub_aspek_id    uuid not null references sub_aspek(id) on delete cascade,
  nomor           text not null,             -- contoh: "1.4-B.2"
  bagian          text check (bagian in ('elektronik', 'konvensional')),
  pernyataan      text not null,
  urutan          int not null
);

-- ----------------------------------------------------------------------------
-- 6. PILIHAN_JAWABAN
-- Master data — pilihan a-e untuk tiap item, dengan level (0-4) dan skor
-- (0/20/50/70/100) sesuai referensi nilai di form ASKI asli.
-- ----------------------------------------------------------------------------
create table pilihan_jawaban (
  id        uuid primary key default gen_random_uuid(),
  item_id   uuid not null references item_pertanyaan(id) on delete cascade,
  kode      text not null check (kode in ('a', 'b', 'c', 'd', 'e')),
  label     text not null,
  level     int not null check (level between 0 and 4),
  skor      numeric not null
);

-- ----------------------------------------------------------------------------
-- 7. JAWABAN_OPD
-- Transaksi — satu baris = jawaban satu OPD untuk satu item pertanyaan.
-- unique(objek_id, item_id): satu OPD hanya boleh punya satu jawaban aktif
-- per item (isi ulang = update baris ini, bukan tambah baris baru).
-- ----------------------------------------------------------------------------
create table jawaban_opd (
  id            uuid primary key default gen_random_uuid(),
  objek_id      uuid not null references objek_pengawasan(id) on delete cascade,
  item_id       uuid not null references item_pertanyaan(id) on delete cascade,
  pilihan_id    uuid references pilihan_jawaban(id),
  diisi_oleh    uuid references auth.users(id),
  updated_at    timestamptz not null default now(),
  unique (objek_id, item_id)
);

-- ----------------------------------------------------------------------------
-- 8. EVIDENCE_FILE
-- Transaksi — file yang di-upload untuk satu jawaban. Satu jawaban boleh
-- punya banyak file evidence (misal 3 screenshot untuk 1 item).
-- File-nya sendiri disimpan di Supabase Storage (bucket 'evidence-files'),
-- baris ini cuma menyimpan path & metadata-nya.
-- ----------------------------------------------------------------------------
create table evidence_file (
  id              uuid primary key default gen_random_uuid(),
  jawaban_id      uuid not null references jawaban_opd(id) on delete cascade,
  nama_file       text not null,
  tipe_file       text,
  storage_path    text not null,     -- path di bucket, contoh: "<objek_id>/<item_id>/bukti1.jpg"
  uploaded_by     uuid references auth.users(id),
  created_at      timestamptz not null default now()
);

create index idx_akses_profile on akses_objek(profile_id);
create index idx_akses_objek on akses_objek(objek_id);
create index idx_jawaban_objek on jawaban_opd(objek_id);
create index idx_jawaban_item on jawaban_opd(item_id);
create index idx_evidence_jawaban on evidence_file(jawaban_id);
create index idx_subaspek_aspek on sub_aspek(aspek_id);
create index idx_item_subaspek on item_pertanyaan(sub_aspek_id);
create index idx_pilihan_item on pilihan_jawaban(item_id);


-- ============================================================================
-- SEED: ASPEK & SUB-ASPEK
-- Angka bobot & nilai_standar di bawah ini diambil langsung dari sheet
-- REKAPITULASI di form ASKI UP1 dan ASKI UK asli (Sekretariat Daerah, 2026).
-- ============================================================================

-- --- Instrumen UP (Unit Pengolah) ---
with a1 as (
  insert into aspek_penilaian (jenis_instrumen, nama, bobot, urutan)
  values ('UP', 'Pengelolaan Arsip Dinamis', 0.7, 1)
  returning id
), a2 as (
  insert into aspek_penilaian (jenis_instrumen, nama, bobot, urutan)
  values ('UP', 'Sumber Daya Kearsipan', 0.3, 2)
  returning id
)
insert into sub_aspek (aspek_id, nama, bobot, nilai_standar, urutan)
select id, 'Penciptaan', 0.2, 700, 1 from a1
union all select id, 'Penggunaan', 0.2, 200, 2 from a1
union all select id, 'Pemeliharaan', 0.35, 1100, 3 from a1
union all select id, 'Penyusutan', 0.25, 200, 4 from a1
union all select id, 'Sumber Daya Manusia Kearsipan', 0.5, 200, 1 from a2
union all select id, 'Sarana dan Prasarana Kearsipan', 0.5, 100, 2 from a2;

-- --- Instrumen UK (Unit Kearsipan) ---
with a1 as (
  insert into aspek_penilaian (jenis_instrumen, nama, bobot, urutan)
  values ('UK', 'Pengelolaan Arsip Dinamis', 0.6, 1)
  returning id
), a2 as (
  insert into aspek_penilaian (jenis_instrumen, nama, bobot, urutan)
  values ('UK', 'Sumber Daya Kearsipan', 0.4, 2)
  returning id
)
insert into sub_aspek (aspek_id, nama, bobot, nilai_standar, urutan)
select id, 'Pengendalian Naskah Dinas', 0.1, 200, 1 from a1
union all select id, 'Penggunaan', 0.25, 100, 2 from a1
union all select id, 'Pemeliharaan', 0.35, 600, 3 from a1
union all select id, 'Penyusutan', 0.3, 400, 4 from a1
union all select id, 'Sumber Daya Manusia Kearsipan', 0.5, 300, 1 from a2
union all select id, 'Sarana dan Prasarana Kearsipan', 0.5, 200, 2 from a2;

-- item_pertanyaan & pilihan_jawaban SENGAJA tidak di-seed manual di sini —
-- jumlahnya ratusan baris per instrumen. Jalankan scripts/extract_items.py
-- untuk generate seed_items.sql dari file xlsx form ASKI asli, lalu jalankan
-- file itu terpisah setelah schema.sql ini. Lihat README bagian "Import soal".


-- ============================================================================
-- STORAGE — bucket untuk file evidence
-- ============================================================================
insert into storage.buckets (id, name, public)
values ('evidence-files', 'evidence-files', false)
on conflict (id) do nothing;


-- ============================================================================
-- ROW LEVEL SECURITY
-- Aturan intinya:
--   - admin (Diskarpus)  -> boleh baca semua, tulis semua
--   - operator (OPD)     -> boleh baca semua master data (instrumen),
--                           tapi hanya boleh baca/tulis jawaban & evidence
--                           milik objek_pengawasan yang ditugaskan ke dia
-- ============================================================================

create or replace function is_admin()
returns boolean language sql stable security definer as $$
  select exists (
    select 1 from profiles where id = auth.uid() and role = 'admin'
  );
$$;

create or replace function has_akses(p_objek_id uuid)
returns boolean language sql stable security definer as $$
  select exists (
    select 1 from akses_objek where profile_id = auth.uid() and objek_id = p_objek_id
  );
$$;

alter table objek_pengawasan enable row level security;
alter table profiles enable row level security;
alter table akses_objek enable row level security;
alter table aspek_penilaian enable row level security;
alter table sub_aspek enable row level security;
alter table item_pertanyaan enable row level security;
alter table pilihan_jawaban enable row level security;
alter table jawaban_opd enable row level security;
alter table evidence_file enable row level security;

-- Master data & daftar objek pengawasan: siapa saja yang login boleh baca
-- (dipakai admin untuk dashboard agregat, operator untuk lihat checklist).
-- Hanya admin yang boleh ubah.
create policy "read master - semua login" on objek_pengawasan for select using (auth.role() = 'authenticated');
create policy "write master - admin only" on objek_pengawasan for all using (is_admin());

create policy "read master - semua login" on aspek_penilaian for select using (auth.role() = 'authenticated');
create policy "write master - admin only" on aspek_penilaian for all using (is_admin());

create policy "read master - semua login" on sub_aspek for select using (auth.role() = 'authenticated');
create policy "write master - admin only" on sub_aspek for all using (is_admin());

create policy "read master - semua login" on item_pertanyaan for select using (auth.role() = 'authenticated');
create policy "write master - admin only" on item_pertanyaan for all using (is_admin());

create policy "read master - semua login" on pilihan_jawaban for select using (auth.role() = 'authenticated');
create policy "write master - admin only" on pilihan_jawaban for all using (is_admin());

-- profiles: tiap orang lihat profil sendiri; admin lihat semua
create policy "lihat profil sendiri" on profiles for select using (id = auth.uid() or is_admin());
create policy "admin kelola profil" on profiles for all using (is_admin());

-- akses_objek: tiap orang lihat akses miliknya sendiri; admin kelola semua
create policy "lihat akses sendiri" on akses_objek for select using (profile_id = auth.uid() or is_admin());
create policy "admin kelola akses" on akses_objek for all using (is_admin());

-- jawaban_opd: admin bebas; operator hanya untuk objek_id yang ada di akses_objek miliknya
create policy "operator baca jawaban sendiri" on jawaban_opd for select using (is_admin() or has_akses(objek_id));
create policy "operator tulis jawaban sendiri" on jawaban_opd for insert with check (is_admin() or has_akses(objek_id));
create policy "operator update jawaban sendiri" on jawaban_opd for update using (is_admin() or has_akses(objek_id));

-- evidence_file: ikut aturan jawaban_opd terkait (join lewat jawaban_id)
create policy "operator baca evidence sendiri" on evidence_file for select using (
  is_admin() or exists (
    select 1 from jawaban_opd j where j.id = evidence_file.jawaban_id and has_akses(j.objek_id)
  )
);
create policy "operator tulis evidence sendiri" on evidence_file for insert with check (
  is_admin() or exists (
    select 1 from jawaban_opd j where j.id = evidence_file.jawaban_id and has_akses(j.objek_id)
  )
);

-- storage.objects: file harus di-upload ke folder "<objek_id yang saya punya akses>/..."
create policy "operator upload ke folder sendiri" on storage.objects for insert with check (
  bucket_id = 'evidence-files'
  and (is_admin() or has_akses((storage.foldername(name))[1]::uuid))
);
create policy "operator baca file sendiri" on storage.objects for select using (
  bucket_id = 'evidence-files'
  and (is_admin() or has_akses((storage.foldername(name))[1]::uuid))
);
