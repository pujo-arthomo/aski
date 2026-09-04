-- ============================================================================
-- SEED: ITEM_PERTANYAAN & PILIHAN_JAWABAN
-- Auto-generated oleh scripts/extract_items.py — JANGAN edit manual di sini,
-- edit sumbernya (file xlsx form ASKI) lalu generate ulang.
-- Jalankan file ini SETELAH supabase/schema.sql (butuh aspek_penilaian & sub_aspek).
-- ============================================================================

-- 1. [UP] Penciptaan — Pen-A.1
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pen-A.1', 'elektronik', 'Unit pengolah membuat naskah dinas sesuai dengan tata naskah dinas yang berlaku.', 1
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Penciptaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Seluruh sampel naskah dinas belum sesuai dengan tata naskah dinas yang berlaku.', 0, 0 from itm
  union all select id, 'b', 'Sebanyak 1 s.d. 3 sampel naskah dinas sesuai dengan tata naskah dinas yang berlaku.', 1, 20 from itm
  union all select id, 'c', 'Sebanyak 4 s.d. 6 sampel naskah dinas sesuai dengan tata naskah dinas yang berlaku.', 2, 50 from itm
  union all select id, 'd', 'Sebanyak 7 s.d. 9 sampel naskah dinas sesuai dengan tata naskah dinas yang berlaku.', 3, 70 from itm
  union all select id, 'e', 'Seluruh sampel naskah dinas sesuai dengan tata naskah dinas yang berlaku.', 4, 100 from itm;

-- 2. [UP] Penciptaan — Pen-A.2
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pen-A.2', 'elektronik', 'Pimpinan unit pengolah menandatangani naskah dinas yang dibuat oleh unit pengolah menggunakan Tanda Tangan Elektronik (TTE) terverifikasi.', 2
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Penciptaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Seluruh sampel naskah dinas belum ditandatangani menggunakan TTE terverifikasi.', 0, 0 from itm
  union all select id, 'b', 'Sebanyak 1 s.d. 3 sampel naskah dinas telah ditandatangani menggunakan TTE terverifikasi.', 1, 20 from itm
  union all select id, 'c', 'Sebanyak 4 s.d. 6 sampel naskah dinas telah ditandatangani menggunakan TTE terverifikasi.', 2, 50 from itm
  union all select id, 'd', 'Sebanyak 7 s.d. 9 sampel naskah dinas telah ditandatangani menggunakan TTE terverifikasi.', 3, 70 from itm
  union all select id, 'e', 'Seluruh sampel naskah dinas telah ditandatangani menggunakan TTE terverifikasi.', 4, 100 from itm;

-- 3. [UP] Penciptaan — Pen-A.3
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pen-A.3', 'elektronik', 'Jumlah naskah dinas yang telah ditandatangani dan dikirim oleh pimpinan unit pengolah melalui aplikasi SRIKANDI/aplikasi sejenis SRIKANDI.', 3
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Penciptaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum terdapat naskah dinas yang ditandatangani dan dikirim melalui aplikasi SRIKANDI/aplikasi sejenis SRIKANDI.', 0, 0 from itm
  union all select id, 'b', 'Terdapat lebih dari 0% s.d. 50% naskah dinas yang ditandatangani dan dikirim melalui aplikasi SRIKANDI/aplikasi sejenis SRIKANDI.', 1, 20 from itm
  union all select id, 'c', 'Terdapat lebih dari 50% s.d. 70% naskah dinas yang ditandatangani dan dikirim melalui aplikasi SRIKANDI/aplikasi sejenis SRIKANDI.', 2, 50 from itm
  union all select id, 'd', 'Terdapat lebih dari 70% s.d. 90% naskah dinas yang ditandatangani dan dikirim melalui aplikasi SRIKANDI/aplikasi sejenis SRIKANDI.', 3, 70 from itm
  union all select id, 'e', 'Terdapat lebih dari 90% s.d. 100% naskah dinas yang ditandatangani dan dikirim melalui aplikasi SRIKANDI/aplikasi sejenis SRIKANDI.', 4, 100 from itm;

-- 4. [UP] Penciptaan — Pen-A.4
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pen-A.4', 'elektronik', 'Jumlah naskah dinas yang telah ditindaklanjuti oleh pimpinan unit pengolah melalui aplikasi SRIKANDI/aplikasi sejenis SRIKANDI.', 4
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Penciptaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum terdapat naskah dinas yang ditindaklanjuti melalui aplikasi SRIKANDI/aplikasi sejenis SRIKANDI.', 0, 0 from itm
  union all select id, 'b', 'Terdapat lebih dari 0% s.d. 50% naskah dinas yang ditindaklanjuti melalui aplikasi SRIKANDI/aplikasi sejenis SRIKANDI.', 1, 20 from itm
  union all select id, 'c', 'Terdapat lebih dari 50% s.d. 70% naskah dinas yang ditindaklanjuti melalui aplikasi SRIKANDI/aplikasi sejenis SRIKANDI.', 2, 50 from itm
  union all select id, 'd', 'Terdapat lebih dari 70% s.d. 90% naskah dinas yang ditindaklanjuti melalui aplikasi SRIKANDI/aplikasi sejenis SRIKANDI.', 3, 70 from itm
  union all select id, 'e', 'Terdapat lebih dari 90% s.d. 100% naskah dinas yang ditindaklanjuti melalui aplikasi SRIKANDI/aplikasi sejenis SRIKANDI.', 4, 100 from itm;

-- 5. [UP] Penciptaan — Pen-B.5
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pen-B.5', 'konvensional', 'Pembuatan naskah dinas sesuai dengan Tata Naskah Dinas yang berlaku.', 5
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Penciptaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Seluruh sampel naskah dinas belum sesuai dengan tata naskah dinas yang berlaku.', 0, 0 from itm
  union all select id, 'b', 'Sebanyak 1 s.d. 3 sampel naskah dinas sesuai dengan tata naskah dinas yang berlaku.', 1, 20 from itm
  union all select id, 'c', 'Sebanyak 4 s.d. 6 sampel naskah dinas sesuai dengan tata naskah dinas yang berlaku.', 2, 50 from itm
  union all select id, 'd', 'Sebanyak 7 s.d. 9 sampel naskah dinas sesuai dengan tata naskah dinas yang berlaku.', 3, 70 from itm
  union all select id, 'e', 'Seluruh sampel naskah dinas sesuai dengan tata naskah dinas yang berlaku.', 4, 100 from itm;

-- 6. [UP] Penciptaan — Pen-B.6
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pen-B.6', 'konvensional', 'Unit pengolah mengendalikan naskah dinas masuk konvensional.', 6
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Penciptaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan pengendalian naskah dinas masuk konvensional.', 0, 0 from itm
  union all select id, 'b', 'Telah melaksanakan 1 kegiatan pengendalian naskah dinas masuk konvensional.', 1, 20 from itm
  union all select id, 'c', 'Telah melaksanakan 2 kegiatan pengendalian naskah dinas masuk konvensional.', 2, 50 from itm
  union all select id, 'd', 'Telah melaksanakan 3 kegiatan pengendalian naskah dinas masuk konvensional.', 3, 70 from itm
  union all select id, 'e', 'Telah melaksanakan seluruh kegiatan pengendalian naskah dinas masuk konvensional.', 4, 100 from itm;

-- 7. [UP] Penciptaan — Pen-B.7
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pen-B.7', 'konvensional', 'Unit pengolah mengendalikan naskah dinas keluar konvensional.', 7
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Penciptaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan pengendalian naskah dinas keluar konvensional.', 0, 0 from itm
  union all select id, 'b', 'Telah melaksanakan 1 kegiatan pengendalian naskah dinas keluar konvensional.', 1, 20 from itm
  union all select id, 'c', 'Telah melaksanakan 2 kegiatan pengendalian naskah dinas keluar konvensional.', 2, 50 from itm
  union all select id, 'd', 'Telah melaksanakan 3 kegiatan pengendalian naskah dinas keluar konvensional.', 3, 70 from itm
  union all select id, 'e', 'Telah melaksanakan seluruh kegiatan pengendalian naskah dinas keluar konvensional.', 4, 100 from itm;

-- 8. [UP] Penggunaan — Pen-A.1
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pen-A.1', 'elektronik', 'Unit pengolah melayankan arsip aktif pada aplikasi SRIKANDI/aplikasi sejenis SRIKANDI berdasarkan Sistem Klasifikasi Keamanan dan Akses Arsip Dinamis (SKKAAD)', 8
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Penggunaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum terdapat daftar arsip aktif untuk kegiatan layanan arsip aktif.', 0, 0 from itm
  union all select id, 'b', 'Terdapat daftar arsip aktif untuk kegiatan layanan arsip aktif.', 1, 20 from itm
  union all select id, 'c', 'Terdapat daftar arsip aktif untuk kegiatan layanan arsip aktif berdasarkan SKKAAD.', 2, 50 from itm
  union all select id, 'd', 'Terdapat daftar arsip aktif untuk kegiatan layanan arsip aktif berdasarkan SKKAAD dan sarana pencatatan layanan arsip.', 3, 70 from itm
  union all select id, 'e', 'Terdapat daftar arsip aktif untuk kegiatan layanan arsip aktif berdasarkan SKKAAD dan melaksanakan layanan yang dicatat pada sarana pencatatan layanan arsip yang tersedia.', 4, 100 from itm;

-- 9. [UP] Penggunaan — Pen-B.2
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pen-B.2', 'konvensional', 'Unit pengolah melayankan arsip aktif konvensional berdasarkan Sistem Klasifikasi Keamanan dan Akses Arsip Dinamis (SKKAAD).', 9
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Penggunaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum terdapat daftar arsip aktif untuk kegiatan layanan arsip aktif.', 0, 0 from itm
  union all select id, 'b', 'Terdapat daftar arsip aktif untuk kegiatan layanan arsip aktif.', 1, 20 from itm
  union all select id, 'c', 'Terdapat daftar arsip aktif untuk kegiatan layanan arsip aktif berdasarkan SKKAAD.', 2, 50 from itm
  union all select id, 'd', 'Terdapat daftar arsip aktif untuk kegiatan layanan arsip aktif berdasarkan SKKAAD dan sarana pencatatan layanan arsip.', 3, 70 from itm
  union all select id, 'e', 'Terdapat daftar arsip aktif untuk kegiatan layanan arsip aktif berdasarkan SKKAAD dan melaksanakan layanan yang dicatat pada sarana pencatatan layanan arsip yang tersedia.', 4, 100 from itm;

-- 10. [UP] Pemeliharaan — Pem-A.1
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pem-A.1', 'elektronik', 'Unit pengolah memberkaskan arsip aktif pada aplikasi SRIKANDI/aplikasi sejenis SRIKANDI.', 10
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Pemeliharaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan pemberkasan arsip aktif pada aplikasi SRIKANDI/aplikasi sejenis SRIKANDI.', 0, 0 from itm
  union all select id, 'b', 'Telah membuat folder pemberkasan pada aplikasi SRIKANDI/aplikasi sejenis SRIKANDI, tetapi belum terdapat arsip aktif yang diberkaskan.', 1, 20 from itm
  union all select id, 'c', 'Telah melaksanakan pemberkasan pada aplikasi SRIKANDI/aplikasi sejenis SRIKANDI terhadap naskah masuk atau naskah keluar.', 2, 50 from itm
  union all select id, 'd', 'Telah melaksanakan pemberkasan pada aplikasi SRIKANDI/aplikasi sejenis SRIKANDI terhadap terhadap naskah masuk dan naskah keluar.', 3, 70 from itm
  union all select id, 'e', 'Telah melaksanakan pemberkasan pada aplikasi SRIKANDI/aplikasi sejenis SRIKANDI terhadap terhadap naskah masuk dan naskah keluar sesuai dengan klasifikasi arsip.', 4, 100 from itm;

-- 11. [UP] Pemeliharaan — Pem-A.2
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pem-A.2', 'elektronik', 'Rata-rata persentase pemberkasan arsip aktif yang dilaksanakan oleh unit pengolah pada aplikasi SRIKANDI/aplikasi sejenis SRIKANDI.', 11
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Pemeliharaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan pemberkasan arsip aktif pada aplikasi SRIKANDI/aplikasi sejenis SRIKANDI.', 0, 0 from itm
  union all select id, 'b', 'Rata-rata persentase pemberkasan arsip aktif pada aplikasi SRIKANDI/aplikasi sejenis SRIKANDI mencapai lebih dari 0% s.d. 50%.', 1, 20 from itm
  union all select id, 'c', 'Rata-rata persentase pemberkasan arsip aktif pada aplikasi SRIKANDI/aplikasi sejenis SRIKANDI mencapai lebih dari 50% s.d. 70%.', 2, 50 from itm
  union all select id, 'd', 'Rata-rata persentase pemberkasan arsip aktif pada aplikasi SRIKANDI/aplikasi sejenis SRIKANDI mencapai lebih dari 70% s.d. 90%.', 3, 70 from itm
  union all select id, 'e', 'Rata-rata persentase pemberkasan arsip aktif pada aplikasi SRIKANDI/aplikasi sejenis SRIKANDI mencapai lebih dari 90% s.d. 100%.', 4, 100 from itm;

-- 12. [UP] Pemeliharaan — Pem-A.3
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pem-A.3', 'elektronik', 'Unit pengolah menyusun dan menyampaikan daftar arsip aktif pada aplikasi SRIKANDI/aplikasi sejenis SRIKANDI kepada unit kearsipan.', 12
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Pemeliharaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum menyusun daftar arsip aktif.', 0, 0 from itm
  union all select id, 'b', 'Telah menyusun daftar arsip, tetapi belum sesuai ketentuan.', 1, 20 from itm
  union all select id, 'c', 'Telah menyusun daftar arsip aktif yang terdiri dari daftar berkas dan daftar isi berkas sesuai ketentuan.', 2, 50 from itm
  union all select id, 'd', 'Telah menyusun daftar arsip aktif yang terdiri dari daftar berkas dan daftar isi berkas sesuai ketentuan, tetapi belum menyampaikan kepada unit kearsipan secara rutin.', 3, 70 from itm
  union all select id, 'e', 'Telah menyusun daftar arsip aktif yang terdiri dari daftar berkas dan daftar isi berkas sesuai ketentuan, serta menyampaikan kepada unit kearsipan secara rutin.', 4, 100 from itm;

-- 13. [UP] Pemeliharaan — Pem-A.4
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pem-A.4', 'elektronik', 'Berkas yang telah ditutup oleh unit pengolah pada aplikasi SRIKANDI/aplikasi sejenis SRIKANDI tidak melewati retensi aktif sesuai Jadwal Retensi Arsip (JRA).', 13
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Pemeliharaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum terdapat berkas yang ditutup.', 0, 0 from itm
  union all select id, 'b', 'Terdapat berkas yang telah ditutup dengan akhir retensi aktif lebih dari 2 tahun dari tahun pengawasan.', 1, 20 from itm
  union all select id, 'c', 'Terdapat berkas yang telah ditutup dengan akhir retensi aktif sampai dengan 2 tahun dari tahun pengawasan.', 2, 50 from itm
  union all select id, 'd', 'Terdapat berkas yang telah ditutup dengan akhir retensi aktif sampai dengan 1 tahun dari tahun pengawasan.', 3, 70 from itm
  union all select id, 'e', 'Terdapat berkas yang telah ditutup dengan akhir retensi aktif tidak melebihi tahun pengawasan.', 4, 100 from itm;

-- 14. [UP] Pemeliharaan — Pem-B.5
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pem-B.5', 'konvensional', 'Unit pengolah memberkaskan arsip aktif konvensional.', 14
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Pemeliharaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan pemberkasan arsip aktif.', 0, 0 from itm
  union all select id, 'b', 'Telah merencanakan pemberkasan arsip aktif.', 1, 20 from itm
  union all select id, 'c', 'Telah melaksanakan pemberkasan terhadap arsip yang dibuat atau arsip yang diterima.', 2, 50 from itm
  union all select id, 'd', 'Telah melaksanakan pemberkasan terhadap arsip yang dibuat dan arsip yang diterima.', 3, 70 from itm
  union all select id, 'e', 'Telah melaksanakan pemberkasan terhadap arsip yang dibuat dan arsip yang diterima, sesuai dengan klasifikasi arsip.', 4, 100 from itm;

-- 15. [UP] Pemeliharaan — Pem-B.6
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pem-B.6', 'konvensional', 'Persentase pemberkasan arsip aktif konvensional oleh unit pengolah.', 15
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Pemeliharaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan pemberkasan arsip aktif konvensional.', 0, 0 from itm
  union all select id, 'b', 'Rata-rata pemberkasan arsip aktif konvensional mencapai lebih dari 0% s.d. 50%.', 1, 20 from itm
  union all select id, 'c', 'Rata-rata pemberkasan arsip aktif konvensional mencapai lebih dari 50% s.d. 70%.', 2, 50 from itm
  union all select id, 'd', 'Rata-rata pemberkasan arsip aktif konvensional mencapai lebih dari 70% s.d. 90%.', 3, 70 from itm
  union all select id, 'e', 'Rata-rata pemberkasan arsip aktif mencapai lebih dari 90% s.d. 100%.', 4, 100 from itm;

-- 16. [UP] Pemeliharaan — Pem-B.7
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pem-B.7', 'konvensional', 'Unit pengolah menyusun dan menyampaikan daftar arsip aktif konvensional kepada unit kearsipan.', 16
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Pemeliharaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum menyusun daftar arsip aktif.', 0, 0 from itm
  union all select id, 'b', 'Telah menyusun daftar arsip, tetapi belum sesuai ketentuan.', 1, 20 from itm
  union all select id, 'c', 'Telah menyusun daftar arsip aktif yang terdiri dari daftar berkas dan daftar isi berkas sesuai ketentuan.', 2, 50 from itm
  union all select id, 'd', 'Telah menyusun daftar arsip aktif yang terdiri dari daftar berkas dan daftar isi berkas sesuai ketentuan, tetapi belum menyampaikan kepada unit kearsipan secara rutin.', 3, 70 from itm
  union all select id, 'e', 'Telah menyusun daftar arsip aktif yang terdiri dari daftar berkas dan daftar isi berkas sesuai ketentuan, serta menyampaikan kepada unit kearsipan secara rutin.', 4, 100 from itm;

-- 17. [UP] Pemeliharaan — Pem-B.8
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pem-B.8', 'konvensional', 'Arsip yang disimpan oleh unit pengolah tidak melewati retensi aktif sesuai Jadwal Retensi Arsip (JRA).', 17
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Pemeliharaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Terdapat arsip yang disimpan dengan akhir retensi aktif lebih dari 3 tahun dari masa audit.', 0, 0 from itm
  union all select id, 'b', 'Terdapat arsip yang disimpan dengan akhir retensi aktif sampai dengan 3 tahun dari masa audit.', 1, 20 from itm
  union all select id, 'c', 'Terdapat arsip yang disimpan dengan akhir retensi aktif sampai dengan 2 tahun dari masa audit.', 2, 50 from itm
  union all select id, 'd', 'Terdapat arsip yang disimpan dengan akhir retensi aktif sampai dengan 1 tahun dari masa audit.', 3, 70 from itm
  union all select id, 'e', 'Terdapat arsip yang disimpan dengan akhir retensi aktif tidak melebihi masa audit.', 4, 100 from itm;

-- 18. [UP] Pemeliharaan — Pem-B.9
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pem-B.9', 'konvensional', 'Unit pengolah menyimpan arsip aktif konvensional sesuai ketentuan.', 18
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Pemeliharaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan penyimpanan arsip aktif konvensional sesuai ketentuan.', 0, 0 from itm
  union all select id, 'b', 'Telah melaksanakan penyimpanan arsip aktif konvensional sesuai ketentuan dengan memenuhi 1 kriteria penyimpanan.', 1, 20 from itm
  union all select id, 'c', 'Telah melaksanakan penyimpanan arsip aktif konvensional sesuai ketentuan dengan memenuhi 2 s.d. 3 kriteria penyimpanan.', 2, 50 from itm
  union all select id, 'd', 'Telah melaksanakan penyimpanan arsip aktif konvensional sesuai ketentuan dengan memenuhi 4 s.d. 5 kriteria penyimpanan.', 3, 70 from itm
  union all select id, 'e', 'Telah melaksanakan penyimpanan arsip aktif konvensional sesuai ketentuan dengan memenuhi seluruh kriteria penyimpanan.', 4, 100 from itm;

-- 19. [UP] Pemeliharaan — Pem-B.10
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pem-B.10', 'konvensional', 'Unit pengolah melaksanakan alih media arsip aktif sesuai dengan prioritas (berpotensi permananen berdasarkan JRA yang berlaku) dan ketentuan.', 19
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Pemeliharaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan alih media arsip aktif.', 0, 0 from itm
  union all select id, 'b', 'Merencanakan kegiatan alih media arsip aktif.', 1, 20 from itm
  union all select id, 'c', 'Melaksanakan alih media arsip aktif dengan memenuhi 1 s.d. 2 kriteria.', 2, 50 from itm
  union all select id, 'd', 'Melaksanakan alih media arsip aktif dengan memenuhi 3 s.d. 4 kriteria.', 3, 70 from itm
  union all select id, 'e', 'Melaksanakan alih media arsip aktif dengan memenuhi seluruh kriteria.', 4, 100 from itm;

-- 20. [UP] Pemeliharaan — Pem-B.11
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pem-B.11', 'konvensional', 'Unit pengolah mengelola arsip vital.', 20
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Pemeliharaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan pengelolaan arsip vital.', 0, 0 from itm
  union all select id, 'b', 'Melaksanakan identifikasi jenis arsip vital atau unit kearsipan telah berkoordinasi dengan unit pengolah terkait identifikasi jenis arsip vital di lingkungannya.', 1, 20 from itm
  union all select id, 'c', 'Melaksanakan pengelolaan arsip vital dengan memenuhi 1 kriteria.', 2, 50 from itm
  union all select id, 'd', 'Melaksanakan pengelolaan arsip vital dengan memenuhi 2 s.d. 3 kriteria.', 3, 70 from itm
  union all select id, 'e', 'Melaksanakan pengelolaan arsip vital dengan memenuhi seluruh kriteria.', 4, 100 from itm;

-- 21. [UP] Penyusutan — Pen-B.2
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pen-B.2', 'konvensional', 'Unit pengolah memindahkan arsip inaktif konvensional sesuai dengan prosedur dalam kurun waktu 5 tahun terakhir.', 21
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Penyusutan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan pemindahan arsip inaktif konvensional sesuai dengan prosedur dalam kurun waktu 5 tahun terakhir.', 0, 0 from itm
  union all select id, 'b', 'Telah melaksanakan pemindahan arsip inaktif konvensional dengan memenuhi 1 prosedur dalam kurun waktu 5 tahun terakhir.', 1, 20 from itm
  union all select id, 'c', 'Telah melaksanakan pemindahan arsip inaktif konvensional dengan memenuhi 2 prosedur dalam kurun waktu 5 tahun terakhir.', 2, 50 from itm
  union all select id, 'd', 'Telah melaksanakan pemindahan arsip inaktif konvensional dengan memenuhi 3 s.d. 4 prosedur dalam kurun waktu 5 tahun terakhir.', 3, 70 from itm
  union all select id, 'e', 'Telah melaksanakan pemindahan arsip inaktif konvensional dengan memenuhi seluruh prosedur dalam kurun waktu 5 tahun terakhir.', 4, 100 from itm;

-- 22. [UP] Penyusutan — Pen-B.3
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pen-B.3', 'konvensional', 'Intensitas pemindahan arsip inaktif konvensional oleh unit pengolah dalam kurun waktu 5 tahun terakhir.', 22
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Penyusutan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan pemindahan arsip inaktif dalam kurun waktu 5 tahun terakhir.', 0, 0 from itm
  union all select id, 'b', 'Telah melaksanakan pemindahan arsip inaktif sebanyak 1 kali dalam kurun waktu 5 tahun terakhir.', 1, 20 from itm
  union all select id, 'c', 'Telah melaksanakan pemindahan arsip inaktif sebanyak 2 kali dalam kurun waktu 5 tahun terakhir.', 2, 50 from itm
  union all select id, 'd', 'Telah melaksanakan pemindahan arsip inaktif sebanyak 3 kali dalam kurun waktu 5 tahun terakhir.', 3, 70 from itm
  union all select id, 'e', 'Telah melaksanakan pemindahan arsip inaktif sebanyak 4 kali dalam kurun waktu 5 tahun terakhir.', 4, 100 from itm;

-- 23. [UP] Sumber Daya Manusia Kearsipan — Sum.1
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Sum.1', null, 'Ketersediaan arsiparis tersertifikasi pada unit pengolah.', 23
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Sumber Daya Manusia Kearsipan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum tersedia arsiparis.', 0, 0 from itm
  union all select id, 'b', 'Mengusulkan pengadaan arsiparis.', 1, 20 from itm
  union all select id, 'c', 'Tidak tersedia arsiparis, tetapi tersedia pengelola arsip yang ditetapkan melalui surat tugas/surat keputusan.', 2, 50 from itm
  union all select id, 'd', 'Tersedia arsiparis pada unit pengolah, tetapi belum terdapat arsiparis yang telah tersertifikasi.', 3, 70 from itm
  union all select id, 'e', 'Tersedia arsiparis pada unit pengolah dan terdapat arsiparis yang telah tersertifikasi.', 4, 100 from itm;

-- 24. [UP] Sumber Daya Manusia Kearsipan — Sum.2
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Sum.2', null, 'Jumlah arsiparis pada unit pengolah yang telah tersertifikasi.', 24
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Sumber Daya Manusia Kearsipan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum terdapat arsiparis yang telah tersertifikasi.', 0, 0 from itm
  union all select id, 'b', 'Mengusulkan sertifikasi arsiparis pada unit pengolah melalui unit dengan fungsi pengembangan kompetensi.', 1, 20 from itm
  union all select id, 'c', 'Arsiparis pada unit pengolah dalam proses sertifikasi arsiparis.', 2, 50 from itm
  union all select id, 'd', 'Sebagian arsiparis pada unit pengolah telah mengikuti dan lulus sertifikasi arsiparis.', 3, 70 from itm
  union all select id, 'e', 'Seluruh arsiparis pada unit pengolah telah mengikuti dan lulus sertifikasi arsiparis.', 4, 100 from itm;

-- 25. [UP] Sumber Daya Manusia Kearsipan — Sum.3
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Sum.3', null, 'Kompetensi teknis pengelola arsip pada unit pengolah.', 25
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Sumber Daya Manusia Kearsipan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Pengelola arsip belum memenuhi kompetensi.', 0, 0 from itm
  union all select id, 'b', 'Pengelola arsip telah diusulkan untuk mengikuti pendidikan dan pelatihan teknis kearsipan ke unit terkait di lingkungan pemerintah daerah', 1, 20 from itm
  union all select id, 'c', 'Pengelola arsip telah mendapatkan kepastian untuk mengikuti pendidikan dan pelatihan teknis kearsipan.', 2, 50 from itm
  union all select id, 'd', 'Pengelola arsip sedang mengikuti pendidikan dan pelatihan teknis kearsipan.', 3, 70 from itm
  union all select id, 'e', 'Pengelola arsip telah mengikuti dan lulus pendidikan dan pelatihan teknis kearsipan.', 4, 100 from itm;

-- 26. [UP] Sarana dan Prasarana Kearsipan — Sar-B.1
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Sar-B.1', 'konvensional', 'Ketersediaan sarana penyimpanan arsip aktif konvensional sesuai dengan kriteria.', 26
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UP' and sa.nama = 'Sarana dan Prasarana Kearsipan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Sarana penyimpanan arsip aktif konvensional belum sesuai kriteria.', 0, 0 from itm
  union all select id, 'b', 'Terdapat 1 sarana penyimpanan arsip aktif konvensional memenuhi kriteria.', 1, 20 from itm
  union all select id, 'c', 'Terdapat 2 sarana penyimpanan arsip aktif konvensional memenuhi kriteria.', 2, 50 from itm
  union all select id, 'd', 'Terdapat 3 sarana penyimpanan arsip aktif konvensional memenuhi kriteria.', 3, 70 from itm
  union all select id, 'e', 'Seluruh sarana penyimpanan arsip aktif konvensional memenuhi kriteria.', 4, 100 from itm;

-- 27. [UK] Pengendalian Naskah Dinas — Pen.1
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pen.1', null, 'Pengendalian naskah dinas masuk', 27
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Pengendalian Naskah Dinas'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan pengendalian naskah dinas masuk', 0, 0 from itm
  union all select id, 'b', 'Telah melaksanakan 1 kegiatan pengendalian naskah dinas masuk', 1, 20 from itm
  union all select id, 'c', 'Telah melaksanakan 2 kegiatan pengendalian naskah dinas masuk', 2, 50 from itm
  union all select id, 'd', 'Telah melaksanakan 3 kegiatan pengendalian naskah dinas masuk', 3, 70 from itm
  union all select id, 'e', 'Telah melaksanakan seluruh kegiatan pengendalian naskah dinas.', 4, 100 from itm;

-- 28. [UK] Pengendalian Naskah Dinas — Pen.2
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pen.2', null, 'Pengendalian naskah dinas keluar', 28
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Pengendalian Naskah Dinas'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan pengendalian naskah dinas keluar', 0, 0 from itm
  union all select id, 'b', 'Telah melaksanakan 1 kegiatan pengendalian naskah dinas keluar', 1, 20 from itm
  union all select id, 'c', 'Telah melaksanakan 2 kegiatan pengendalian naskah dinas keluar', 2, 50 from itm
  union all select id, 'd', 'Telah melaksanakan 3 kegiatan pengendalian naskah dinas.', 3, 70 from itm
  union all select id, 'e', 'Telah melaksanakan seluruh kegiatan pengendalian naskah dinas.', 4, 100 from itm;

-- 29. [UK] Penggunaan — Pen.1
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pen.1', null, 'Unit kearsipan melayankan arsip inaktif berdasarkan Sistem Klasifikasi Keamanan dan Akses Arsip Dinamis (SKKAAD).', 29
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Penggunaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum terdapat daftar arsip inaktif untuk kegiatan layanan arsip inaktif.', 0, 0 from itm
  union all select id, 'b', 'Terdapat daftar arsip inaktif untuk kegiatan layanan arsip inaktif.', 1, 20 from itm
  union all select id, 'c', 'Terdapat daftar arsip inaktif untuk kegiatan layanan arsip inaktif berdasarkan SKKAAD.', 2, 50 from itm
  union all select id, 'd', 'Terdapat daftar arsip inaktif untuk kegiatan layanan arsip inaktif berdasarkan SKKAAD dan sarana pencatatan layanan arsip yang tersedia, dengan frekuensi penggunaan kurang dari 3 (tiga) pengguna dalam kurun satu tahun terakhir.', 3, 70 from itm
  union all select id, 'e', 'Terdapat daftar arsip inaktif untuk kegiatan layanan arsip inaktif berdasarkan SKKAAD dan melaksanakan layanan yang dicatat pada sarana pencatatan layanan arsip yang tersedia, minimal terhadap 3 (tiga) pengguna dalam kurun waktu satu tahun terakhir.', 4, 100 from itm;

-- 30. [UK] Pemeliharaan — Pem.1
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pem.1', null, 'Unit Kearsipan melaksanakan penataan arsip inaktif.', 30
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Pemeliharaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan penataan arsip inaktif.', 0, 0 from itm
  union all select id, 'b', 'Melaksanakan pengaturan fisik arsip inaktif, tetapi belum sesuai dengan prinsip asas usul dan aturan asli.', 1, 20 from itm
  union all select id, 'c', 'Melaksanakan pengaturan fisik arsip inaktif sesuai dengan prinsip asal usul dan aturan asli lebih dari 0% sd 70%.', 2, 50 from itm
  union all select id, 'd', 'Melaksanakan pengaturan fisik arsip inaktif yang dikelola sesuai dengan prinsip asal usul dan aturan asli lebih dari 70% sd 90%.', 3, 70 from itm
  union all select id, 'e', 'Melaksanakan pengaturan fisik arsip inaktif yang dikelola sesuai dengan prinsip asal usul dan aturan asli lebih dari 90 sd 100%.', 4, 100 from itm;

-- 31. [UK] Pemeliharaan — Pem.2
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pem.2', null, 'Unit Kearsipan menjamin ketersediaan akses arsip yang dikelola melalui penyusunan daftar arsip inaktif.', 31
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Pemeliharaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum menyusun daftar arsip inaktif terhadap arsip inaktif yang dipindahkan.', 0, 0 from itm
  union all select id, 'b', 'Telah menyusun daftar arsip inaktif terhadap lebih dari 0% s.d. 50% arsip inaktif yang telah dipindahkan.', 1, 20 from itm
  union all select id, 'c', 'Telah menyusun daftar arsip inaktif terhadap lebih dari 50% s.d. 70% arsip inaktif yang telah dipindahkan.', 2, 50 from itm
  union all select id, 'd', 'Telah menyusun daftar arsip inaktif terhadap lebih dari 70% s.d. 90% arsip inaktif yang telah dipindahkan.', 3, 70 from itm
  union all select id, 'e', 'Telah menyusun daftar arsip inaktif terhadap lebih dari 90% s.d. 100% arsip inaktif yang telah dipindahkan.', 4, 100 from itm;

-- 32. [UK] Pemeliharaan — Pem.3
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pem.3', null, 'Persentase daftar arsip inaktif yang disusun sesuai dengan ketentuan.', 32
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Pemeliharaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum terdapat daftar arsip inaktif yang sesuai ketentuan', 0, 0 from itm
  union all select id, 'b', 'Telah terdapat lebih dari 0% s.d. 50% daftar arsip inaktif sesuai ketentuan.', 1, 20 from itm
  union all select id, 'c', 'Telah terdapat lebih dari 50% s.d. 70% daftar arsip inaktif sesuai ketentuan.', 2, 50 from itm
  union all select id, 'd', 'Telah terdapat lebih dari 70% s.d. 90% daftar arsip inaktif sesuai ketentuan.', 3, 70 from itm
  union all select id, 'e', 'Telah terdapat lebih dari 90% s.d. 100% daftar arsip inaktif sesuai ketentuan.', 4, 100 from itm;

-- 33. [UK] Pemeliharaan — Pem.4
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pem.4', null, 'Arsip yang disimpan oleh unit kearsipan tidak melewati retensi arsip inaktif sesuai Jadwal Retensi Arsip (JRA).', 33
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Pemeliharaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Terdapat arsip yang disimpan dengan akhir retensi inaktif lebih dari 5 tahun dari masa audit.', 0, 0 from itm
  union all select id, 'b', 'Terdapat arsip yang disimpan dengan akhir retensi aktif sampai dengan 5 tahun dari masa audit.', 1, 20 from itm
  union all select id, 'c', 'Terdapat arsip yang disimpan dengan akhir retensi inaktif sampai dengan 3 tahun dari masa audit.', 2, 50 from itm
  union all select id, 'd', 'Terdapat arsip yang disimpan dengan akhir retensi inaktif sampai dengan 1 tahun dari masa audit.', 3, 70 from itm
  union all select id, 'e', 'Terdapat arsip yang disimpan dengan akhir retensi inaktif tidak melebihi masa audit.', 4, 100 from itm;

-- 34. [UK] Pemeliharaan — Pem.5
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pem.5', null, 'Penyimpanan arsip inaktif menggunakan sarana penyimpanan yang sesuai dengan bentuk dan media.', 34
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Pemeliharaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan penyimpanan arsip inaktif sesuai dengan bentuk dan media.', 0, 0 from itm
  union all select id, 'b', 'Telah menyimpan lebih dari 0% s.d. 30% arsip inaktif menggunakan sarana penyimpanan yang sesuai dengan bentuk dan media.', 1, 20 from itm
  union all select id, 'c', 'Telah menyimpan lebih dari 30% s.d. 60% arsip inaktif menggunakan sarana penyimpanan yang sesuai dengan bentuk dan media.', 2, 50 from itm
  union all select id, 'd', 'Telah menyimpan lebih dari 60% s.d. kurang dari 100% arsip inaktif menggunakan sarana penyimpanan yang sesuai dengan bentuk dan media.', 3, 70 from itm
  union all select id, 'e', 'Telah menyimpan seluruh arsip inaktif menggunakan sarana penyimpanan yang sesuai dengan bentuk dan media.', 4, 100 from itm;

-- 35. [UK] Pemeliharaan — Pem.6
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pem.6', null, 'Unit Kearsipan melaksanakan alih media arsip inaktif sesuai dengan prioritas (berpotensi permananen berdasarkan JRA yang berlaku) dan ketentuan.', 35
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Pemeliharaan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan alih media arsip inaktif.', 0, 0 from itm
  union all select id, 'b', 'Telah merencanakan kegiatan alih media arsip inaktif.', 1, 20 from itm
  union all select id, 'c', 'Telah melaksanakan alih media arsip inaktif dengan memenuhi 1 s.d. 2 kriteria.', 2, 50 from itm
  union all select id, 'd', 'Telah melaksanakan alih media arsip inaktif dengan memenuhi 3 s.d. 4 kriteria.', 3, 70 from itm
  union all select id, 'e', 'Telah melaksanakan alih media arsip inaktif dengan memenuhi seluruh kriteria.', 4, 100 from itm;

-- 36. [UK] Penyusutan — Pen.1
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pen.1', null, 'Unit pengolah yang sudah memindahkan arsip inaktif dengan retensi dibawah 10 (sepuluh) tahun ke unit kearsipan.', 36
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Penyusutan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum terdapat Unit Pengolah yang melaksanakan pemindahan arsip inaktif ke Unit Kearsipan.', 0, 0 from itm
  union all select id, 'b', 'Terdapat lebih dari 0% s.d. 40% Unit Pengolah yang melaksanakan pemindahan arsip inaktif ke Unit Kearsipan.', 1, 20 from itm
  union all select id, 'c', 'Terdapat lebih dari 40% s.d. 60% Unit Pengolah yang melaksanakan pemindahan arsip inaktif ke Unit Kearsipan.', 2, 50 from itm
  union all select id, 'd', 'Terdapat lebih dari 60% s.d. kurang dari 100% Unit Pengolah yang melaksanakan pemindahan arsip inaktif ke Unit Kearsipan.', 3, 70 from itm
  union all select id, 'e', 'Seluruh Unit Pengolah telah melaksanakan pemindahan arsip inaktif ke Unit Kearsipan.', 4, 100 from itm;

-- 37. [UK] Penyusutan — Pen.2
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pen.2', null, 'Unit  Kearsipan perangkat daerah melaksanakan pemindahan arsip inaktif sekurang-kurangnya 10 (sepuluh)  tahun ke unit kearsipan I pemerintah daerah.', 37
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Penyusutan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan pemindahan arsip inaktif dengan retensi sekurang-kurangnya 10 tahun ke Unit Kearsipan I.', 0, 0 from itm
  union all select id, 'b', 'Telah melaksanakan identifikasi arsip inaktif dengan retensi sekurang-kurangnya 10 tahun ke Unit Kearsipan I.', 1, 20 from itm
  union all select id, 'c', 'Telah melaksanakan penyusunan daftar arsip inaktif dengan retensi sekurang-kurangnya 10 tahun.', 2, 50 from itm
  union all select id, 'd', 'Telah melaksanakan pemindahan arsip inaktif dengan retensi sekurang-kurangnya 10 tahun sebanyak 1 kali dalam kurun waktu 5 tahun terakhir.', 3, 70 from itm
  union all select id, 'e', 'Telah melaksanakan pemindahan arsip inaktif  dengan retensi sekurang-kurangnya 10 tahun sebanyak 2 kali atau lebih dalam kurun waktu 5 tahun terakhir.', 4, 100 from itm;

-- 38. [UK] Penyusutan — Pen.3
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pen.3', null, 'Unit Kearsipan II perangkat daerah melaksakan pemusnahan arsip inaktif dengan retensi dibawah 10 (sepuluh) tahun sesuai dengan prosedur dalam kurun waktu 5 (lima) tahun terakhir dari masa audit.', 38
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Penyusutan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan pemusnahan arsip inaktif', 0, 0 from itm
  union all select id, 'b', 'Telah merencanakan pemusnahan arsip inaktif.', 1, 20 from itm
  union all select id, 'c', 'Sedang dalam proses pemusnahan arsip inaktif.', 2, 50 from itm
  union all select id, 'd', 'Telah melaksanakan pemusnahan arsip inaktif sebanyak 1 kali dalam kurun waktu 5 (lima) tahun terakhir sesuai prosedur.', 3, 70 from itm
  union all select id, 'e', 'Telah melaksanakan pemusnahan arsip inaktif sebanyak 2 kali dalam kurun waktu 5 (lima) tahun terakhir sesuai prosedur.', 4, 100 from itm;

-- 39. [UK] Penyusutan — Pen.4
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Pen.4', null, 'Unit Kearsipan II perangkat daerah melaksanakan penyerahan arsip statis ke Lembaga Kearsipan Daerah sesuai dengan prosedur dalam kurun waktu 5 (lima) tahun terakhir.', 39
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Penyusutan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum melaksanakan penyerahan arsip statis.', 0, 0 from itm
  union all select id, 'b', 'Dalam proses melaksanakan penyerahan arsip statis.', 1, 20 from itm
  union all select id, 'c', 'Telah melaksanakan penyerahan arsip statis dengan memenuhi kriteria 4.5, 4.6, 4.7, 4.8', 2, 50 from itm
  union all select id, 'd', 'Telah melaksanakan penyerahan arsip statis sebanyak 1 kali dengan memenuhi seluruh prosedur dalam kurun waktu 5 (lima) tahun terakhir.', 3, 70 from itm
  union all select id, 'e', 'Telah melaksanakan penyerahan arsip statis sebanyak 2 kali dengan memenuhi seluruh prosedur dalam kurun waktu 5 (lima) tahun terakhir.', 4, 100 from itm;

-- 40. [UK] Sumber Daya Manusia Kearsipan — Sum.1
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Sum.1', null, 'Ketersediaan arsiparis tersertifikasi pada unit kearsipan.', 40
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Sumber Daya Manusia Kearsipan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum memiliki arsiparis.', 0, 0 from itm
  union all select id, 'b', 'Unit kearsipan mengusulkan pengadaan arsiparis.', 1, 20 from itm
  union all select id, 'c', 'Tersedia arsiparis pada unit kearsipan yang belum tersertifikasi.', 2, 50 from itm
  union all select id, 'd', 'Tersedia arsiparis pada unit kearsipan yang dalam proses sertifikasi.', 3, 70 from itm
  union all select id, 'e', 'Tersedia arsiparis pada unit kearsipan yang telah tersertifikasi.', 4, 100 from itm;

-- 41. [UK] Sumber Daya Manusia Kearsipan — Sum.2
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Sum.2', null, 'Jumlah arsiparis pada unit kearsipan yang telah tersertifikasi.', 41
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Sumber Daya Manusia Kearsipan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Belum terdapat arsiparis yang telah tersertifikasi.', 0, 0 from itm
  union all select id, 'b', 'Mengusulkan sertifikasi arsiparis pada unit kearsipan kepada ANRI.', 1, 20 from itm
  union all select id, 'c', 'Arsiparis pada unit kearsipan dalam proses sertifikasi arsiparis.', 2, 50 from itm
  union all select id, 'd', 'Sebagian arsiparis pada unit kearsipan telah mengikuti dan lulus sertifikasi arsiparis.', 3, 70 from itm
  union all select id, 'e', 'Seluruh arsiparis pada unit kearsipan telah mengikuti dan lulus sertifikasi arsiparis.', 4, 100 from itm;

-- 42. [UK] Sumber Daya Manusia Kearsipan — Sum.3
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Sum.3', null, 'Pengembangan kompetensi arsiparis pada unit kearsipan.', 42
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Sumber Daya Manusia Kearsipan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Arsiparis belum mengikuti pengembangan kompetensi.', 0, 0 from itm
  union all select id, 'b', 'Arsiparis telah diusulkan untuk mengikuti pengembangan kompetensi.', 1, 20 from itm
  union all select id, 'c', 'Arsiparis telah mengikuti sosialisasi dan bimtek kearsipan.', 2, 50 from itm
  union all select id, 'd', 'Sebagian arsiparis pada unit kearsipan telah mengikuti dan lulus pendidikan dan pelatihan teknis kearsipan.', 3, 70 from itm
  union all select id, 'e', 'Seluruh arsiparis pada unit kearsipan telah mengikuti dan lulus pendidikan dan pelatihan teknis kearsipan.', 4, 100 from itm;

-- 43. [UK] Sumber Daya Manusia Kearsipan — Sum.4
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Sum.4', null, 'Kompetensi teknis pengelola arsip pada unit kearsipan.', 43
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Sumber Daya Manusia Kearsipan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Pengelola arsip belum memenuhi kompetensi.', 0, 0 from itm
  union all select id, 'b', 'Pengelola arsip telah diusulkan untuk mengikuti pendidikan dan pelatihan teknis kearsipan ke unit terkait.', 1, 20 from itm
  union all select id, 'c', 'Pengelola arsip telah mendapatkan kepastian untuk mengikuti pendidikan dan pelatihan teknis kearsipan.', 2, 50 from itm
  union all select id, 'd', 'Pengelola arsip sedang mengikuti pendidikan dan pelatihan teknis kearsipan.', 3, 70 from itm
  union all select id, 'e', 'Pengelola arsip telah mengikuti dan lulus pendidikan dan pelatihan teknis kearsipan.', 4, 100 from itm;

-- 44. [UK] Sarana dan Prasarana Kearsipan — Sar.1
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Sar.1', null, 'Ketersediaan ruangan penyimpanan arsip Inaktif sesuai dengan kriteria.', 44
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Sarana dan Prasarana Kearsipan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Ruangan penyimpanan arsip inaktif belum sesuai kriteria.', 0, 0 from itm
  union all select id, 'b', 'Ruangan penyimpanan arsip inaktif memenuhi 1 kriteria.', 1, 20 from itm
  union all select id, 'c', 'Ruangan penyimpanan arsip inaktif memenuhi 2 kriteria.', 2, 50 from itm
  union all select id, 'd', 'Ruangan penyimpanan arsip inaktif memenuhi 3 s.d. 4 kriteria.', 3, 70 from itm
  union all select id, 'e', 'Ruangan penyimpanan arsip inaktif memenuhi seluruh kriteria.', 4, 100 from itm;

-- 45. [UK] Sarana dan Prasarana Kearsipan — Sar.2
with itm as (
  insert into item_pertanyaan (sub_aspek_id, nomor, bagian, pernyataan, urutan)
  select sa.id, 'Sar.2', null, 'Ketersediaan peralatan penyimpanan arsip inaktif sesuai dengan kriteria dan berfungsi dengan baik.', 45
  from sub_aspek sa join aspek_penilaian ap on ap.id = sa.aspek_id
  where ap.jenis_instrumen = 'UK' and sa.nama = 'Sarana dan Prasarana Kearsipan'
  returning id
)
insert into pilihan_jawaban (item_id, kode, label, level, skor)
select id, 'a', 'Peralatan penyimpanan arsip inaktif belum sesuai kriteria.', 0, 0 from itm
  union all select id, 'b', 'Peralatan penyimpanan arsip inaktif memenuhi 1 s.d. 3 kriteria.', 1, 20 from itm
  union all select id, 'c', 'Peralatan penyimpanan arsip inaktif memenuhi 4 s.d. 6 kriteria.', 2, 50 from itm
  union all select id, 'd', 'Peralatan penyimpanan arsip inaktif memenuhi 7 s.d. 9 kriteria.', 3, 70 from itm
  union all select id, 'e', 'Peralatan penyimpanan arsip inaktif memenuhi seluruh kriteria.', 4, 100 from itm;
