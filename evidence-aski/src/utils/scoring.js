// ============================================================================
// scoring.js — kalkulator skor ASKI
//
// Formula ini di-reverse-engineer dari sheet REKAPITULASI form ASKI UP1 &
// ASKI UK asli (Sekretariat Daerah, 2026) dan dicocokkan angka per angka
// sampai persis sama dengan hasil resmi. Contoh pengecekan (UP1 Bagian PBJ,
// sub-aspek Penciptaan): nilai_standar=700, jumlah skor yang tercapai=510,
// bobot sub-aspek=0.2 -> (510/700)*0.2*100 = 14.5714..., cocok dengan nilai
// di kolom "NILAI SUB-ASPEK" pada file aslinya.
//
// Alurnya 3 tingkat:
//   1. Per sub-aspek : (total skor tercapai / nilai standar) * bobot sub-aspek * 100
//   2. Per aspek     : jumlah semua nilai sub-aspek di bawahnya
//   3. Nilai akhir   : jumlah (nilai aspek * bobot aspek) untuk semua aspek
// ============================================================================

/**
 * @param {number} totalSkorTercapai - jumlah skor (0/20/50/70/100 dst) dari
 *   semua item yang SUDAH dijawab di sub-aspek ini. Item yang belum dijawab
 *   dianggap skor 0, bukan dikeluarkan dari pembagi.
 * @param {number} nilaiStandar - poin maksimum sub-aspek ini (dari master data)
 * @param {number} bobotSubAspek - bobot sub-aspek dalam aspeknya (0-1)
 * @returns {number} nilai sub-aspek, skala 0-100 * bobot
 */
export function hitungNilaiSubAspek(totalSkorTercapai, nilaiStandar, bobotSubAspek) {
  if (!nilaiStandar) return 0
  return (totalSkorTercapai / nilaiStandar) * bobotSubAspek * 100
}

/**
 * Hitung skor lengkap satu objek pengawasan (satu OPD/UP/UK).
 *
 * @param {Array} aspekList - daftar aspek beserta sub_aspek di bawahnya, bentuk:
 *   [{ id, nama, bobot, urutan, subAspek: [{ id, nama, bobot, nilai_standar, urutan }] }]
 * @param {Object} itemsBySubAspek - { [sub_aspek_id]: [item_id, ...] }
 * @param {Object} skorByItemId - { [item_id]: skor }  (skor pilihan_jawaban yang dipilih;
 *   item yang belum dijawab TIDAK perlu ada di object ini)
 * @returns {{ subAspekDetail, aspekDetail, nilaiAkhir, kategori }}
 */
export function hitungSkorASKI({ aspekList, itemsBySubAspek, skorByItemId }) {
  const subAspekDetail = []
  const aspekDetail = []
  let nilaiAkhir = 0

  for (const aspek of aspekList) {
    let nilaiAspek = 0

    for (const sa of aspek.subAspek) {
      const itemIds = itemsBySubAspek[sa.id] || []
      const totalSkor = itemIds.reduce((sum, itemId) => sum + (skorByItemId[itemId] || 0), 0)
      const jumlahDijawab = itemIds.filter((id) => skorByItemId[id] !== undefined).length
      const nilaiSubAspek = hitungNilaiSubAspek(totalSkor, sa.nilai_standar, sa.bobot)

      nilaiAspek += nilaiSubAspek
      subAspekDetail.push({
        subAspekId: sa.id,
        nama: sa.nama,
        aspekId: aspek.id,
        totalItem: itemIds.length,
        jumlahDijawab,
        totalSkor,
        nilaiStandar: sa.nilai_standar,
        bobot: sa.bobot,
        nilaiSubAspek,
      })
    }

    const nilaiAspekBerbobot = nilaiAspek * aspek.bobot
    nilaiAkhir += nilaiAspekBerbobot
    aspekDetail.push({
      aspekId: aspek.id,
      nama: aspek.nama,
      bobot: aspek.bobot,
      nilaiSubAspekSum: nilaiAspek,
      nilaiAkhirAspek: nilaiAspekBerbobot,
    })
  }

  return {
    subAspekDetail,
    aspekDetail,
    nilaiAkhir,
    kategori: kategoriDariNilai(nilaiAkhir),
  }
}

// ----------------------------------------------------------------------------
// PERHATIAN: ambang batas kategori di bawah ini BELUM dikonfirmasi dari
// pedoman resmi ANRI/Dispusipda — di sumber yang ada, hanya kategori
// "C (KURANG)" yang muncul (untuk nilai di kisaran 30-50). Batas di bawah
// ini pakai pola umum yang lazim dipakai instansi pemerintah (skema AA-D),
// GANTI angka ini begitu dapat pedoman/tabel kategori resmi ASKI.
// ----------------------------------------------------------------------------
export function kategoriDariNilai(nilai) {
  if (nilai >= 90) return 'AA (Sangat Memuaskan)'
  if (nilai >= 80) return 'A (Memuaskan)'
  if (nilai >= 70) return 'BB (Sangat Baik)'
  if (nilai >= 60) return 'B (Baik)'
  if (nilai >= 50) return 'CC (Cukup)'
  if (nilai >= 30) return 'C (Kurang)'
  return 'D (Sangat Kurang)'
}
