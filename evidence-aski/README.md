# Evidence ASKI

Checklist digital + kalkulator skor otomatis untuk instrumen ASKI (Audit Sistem Kearsipan Internal). Operator OPD isi checklist dan unggah evidence yang relate per item — tanpa validasi AI, sistem tidak menilai kesesuaian, cukup mengumpulkan dan menghitung skor secara real-time seperti form Excel aslinya.

Stack: React 19 + Vite + Tailwind CSS v4 + Supabase — sama seperti [E-Arsip/APPAREL](../e-arsip), supaya tidak mulai dari nol lagi.

Lihat blueprint proses bisnis, alur, dan struktur datanya di artifact "Evidence ASKI" yang sudah dibuat sebelumnya.

---

## 0. Yang perlu disiapkan

- Akun [Supabase](https://supabase.com) (gratis untuk mulai)
- Node.js sudah terpasang di komputer (cek dengan `node --version` di terminal — kalau belum ada, download dari [nodejs.org](https://nodejs.org))
- Python 3 + `pip install openpyxl` (cuma dipakai sekali di langkah 3, untuk generate soal dari xlsx)

---

## 1. Buat project Supabase

1. Buka [supabase.com](https://supabase.com) → **New Project**.
2. Kasih nama (misal `evidence-aski`), pilih region Singapore (paling dekat ke Indonesia), buat password database (simpan baik-baik, dipakai kalau nanti perlu akses langsung ke database).
3. Tunggu 1-2 menit sampai project selesai dibuat.

## 2. Jalankan skema database

1. Di dashboard Supabase, buka menu **SQL Editor** (ikon di sidebar kiri).
2. Klik **New query**.
3. Buka file `supabase/schema.sql` di komputer, copy semua isinya, tempel ke SQL Editor.
4. Klik **Run** (atau Ctrl+Enter).
5. Kalau berhasil, buka menu **Table Editor** — akan muncul 8 tabel: `objek_pengawasan`, `profiles`, `aspek_penilaian`, `sub_aspek`, `item_pertanyaan`, `pilihan_jawaban`, `jawaban_opd`, `evidence_file`. Tabel `aspek_penilaian` dan `sub_aspek` sudah otomatis terisi (itu bagian dari schema.sql).

## 3. Import soal ASKI dari file xlsx

Tabel `item_pertanyaan` dan `pilihan_jawaban` sengaja dikosongkan dulu di langkah 2 — isinya ratusan pertanyaan resmi, jadi diambil otomatis dari file xlsx form ASKI, bukan diketik manual.

```bash
pip install openpyxl
python3 scripts/extract_items.py \
  --file "1. FORM ASKI UP1 2026.xlsx" --sheet "ASKI UP1" --jenis UP \
  --file "3. FORM ASKI UK 2026.xlsx"  --sheet "ASKI UK"  --jenis UK \
  --out supabase/seed_items.sql
```

**File `supabase/seed_items.sql` sudah saya generate dan disertakan di repo ini** (dari file xlsx yang sudah dibagikan sebelumnya) — jadi langkah di atas opsional, cuma perlu dijalankan ulang kalau instrumen ASKI-nya berubah tahun depan.

Yang perlu dilakukan sekarang tinggal:

1. Buka `supabase/seed_items.sql`, copy semua isinya.
2. Tempel di SQL Editor Supabase (query baru), klik **Run**.
3. Cek tabel `item_pertanyaan` — akan muncul 45 baris (25 dari instrumen UP, 19 dari UK — 1 lagi kelewat karena pola skornya beda dari biasanya, lihat catatan di bawah).

> **Catatan jujur soal cakupan:** script ini otomatis menangkap 45 dari kira-kira 47 pertanyaan asli. Ada 2 item dengan skema skor khusus (bukan pola standar a-e → level 0-4) yang dilewati supaya tidak salah masuk data — dicetak di terminal saat script dijalankan (cari baris "PERLU DICEK MANUAL"). Item itu perlu ditambah manual lewat Table Editor Supabase, atau ceritakan ke saya nomornya dan saya bantu buatkan SQL insert-nya.

## 4. Isi file `.env`

1. Di dashboard Supabase: **Project Settings** (ikon gear) → **API**.
2. Copy **Project URL** dan **anon public key**.
3. Di folder project, copy `.env.example` jadi `.env`:
   ```bash
   cp .env.example .env
   ```
4. Buka `.env`, isi dua nilai itu.

## 5. Buat akun admin & operator pertama

Supabase Auth belum otomatis mengisi tabel `profiles` — ini perlu dilakukan sekali di awal per pengguna.

1. **Authentication** → **Users** → **Add user** → isi email + password, buat 1 akun untuk diri sendiri (jadi admin) dan boleh 1 lagi untuk coba sebagai operator.
2. Buka **Table Editor** → `objek_pengawasan` → **Insert row** → isi 1 baris contoh, misal `nama_opd: "Bagian Pengadaan Barang dan Jasa"`, `jenis: "UP"`, `tahun: 2026`. Catat `id`-nya (kolom UUID paling kiri).
3. Buka tabel `profiles` → **Insert row**:
   - Untuk akun admin: `id` = user id dari langkah 1 (lihat di Authentication → Users, klik usernya), `role` = `admin`, `objek_pengawasan_id` boleh kosong.
   - Untuk akun operator: `role` = `operator`, `objek_pengawasan_id` = id dari langkah 2.

(Langkah ini akan dibuatkan halaman admin-nya sendiri di iterasi berikutnya — supaya Admin Diskarpus tidak perlu buka Supabase langsung tiap mau tambah OPD baru.)

## 6. Jalankan di komputer

```bash
npm install
npm run dev
```

Buka `http://localhost:5173` — login pakai akun operator dari langkah 5, akan masuk ke halaman Checklist.

## 7. Deploy ke Vercel (kalau sudah siap dipakai beneran)

1. Push folder ini ke repo GitHub baru.
2. Buka [vercel.com](https://vercel.com) → **Add New Project** → pilih repo itu.
3. Di bagian **Environment Variables**, tambahkan `VITE_SUPABASE_URL` dan `VITE_SUPABASE_ANON_KEY` (nilai yang sama seperti di `.env`).
4. Deploy.

---

## Struktur folder

```
supabase/schema.sql       - skema database + seed aspek/sub-aspek
supabase/seed_items.sql   - soal ASKI (hasil extract_items.py)
scripts/extract_items.py  - importer soal dari xlsx
src/lib/                  - koneksi Supabase & auth
src/utils/scoring.js      - kalkulator skor (formula ASKI)
src/pages/                - 5 halaman: Login, Checklist, DashboardSkor, ExportEvidence, DashboardAdmin
src/components/           - ChecklistItem (1 blok soal), ScoreBadge
```

## Yang masih perlu dikerjakan (belum di versi ini)

- Halaman admin untuk kelola daftar OPD & buat akun operator (sekarang masih manual lewat Supabase Table Editor, lihat langkah 5)
- Export evidence sebagai satu file `.zip` terkompilasi (sekarang baru daftar link unduh satu-satu — lihat catatan di `src/pages/ExportEvidence.jsx`)
- 2 item pertanyaan yang skema skornya khusus (lihat catatan di langkah 3)
- Kategori nilai (A/B/C/K) di `src/utils/scoring.js` pakai ambang batas perkiraan — perlu dicocokkan ke pedoman resmi ASKI kalau ada tabelnya

## Kategori nilai (`kategoriDariNilai`)

Ambang batas di `src/utils/scoring.js` masih perkiraan (lihat komentar di file itu) — dari 3 file yang sudah dibagikan cuma kelihatan kategori "C (Kurang)" untuk nilai di kisaran 30-50, jadi belum bisa dipastikan persis batas B/A-nya. Kalau ada pedoman resmi ASKI yang mencantumkan tabel kategori lengkap, tinggal update fungsi itu.
