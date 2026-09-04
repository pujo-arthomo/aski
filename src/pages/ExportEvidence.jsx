import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { supabase, EVIDENCE_BUCKET } from '../lib/supabaseClient'
import { useAuth } from '../lib/useAuth'
import UnitSwitcher from '../components/UnitSwitcher'

// MVP: daftar semua evidence tersusun per aspek/sub-aspek/item dengan link
// unduh langsung. Belum bikin file .zip terkompilasi otomatis — supaya
// itu jalan, tambahkan library "jszip" lalu loop daftar di bawah ini
// mengunduh tiap file (signed URL) dan memasukkannya ke folder di dalam zip
// sesuai path aspek/sub-aspek/nomor item. Untuk versi awal ini, urutan &
// pengelompokan yang rapi sudah cukup banyak membantu dibanding kondisi
// sekarang (semua evidence tercecer di WhatsApp/folder pribadi staf).
export default function ExportEvidence() {
  const { activeObjek: objek } = useAuth()
  const [rows, setRows] = useState([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (objek) load()
  }, [objek?.id])

  async function load() {
    setLoading(true)
    const { data } = await supabase
      .from('jawaban_opd')
      .select('id, item_pertanyaan(nomor, pernyataan, sub_aspek_id, sub_aspek(nama, aspek_id, aspek_penilaian(nama))), evidence_file(*)')
      .eq('objek_id', objek.id)
      .not('evidence_file', 'is', null)

    const withUrls = []
    for (const j of data || []) {
      for (const f of j.evidence_file || []) {
        const { data: signed } = await supabase.storage
          .from(EVIDENCE_BUCKET)
          .createSignedUrl(f.storage_path, 60 * 60) // berlaku 1 jam
        withUrls.push({
          aspek: j.item_pertanyaan?.sub_aspek?.aspek_penilaian?.nama,
          subAspek: j.item_pertanyaan?.sub_aspek?.nama,
          nomor: j.item_pertanyaan?.nomor,
          pernyataan: j.item_pertanyaan?.pernyataan,
          namaFile: f.nama_file,
          url: signed?.signedUrl,
        })
      }
    }
    withUrls.sort((a, b) => (a.nomor || '').localeCompare(b.nomor || ''))
    setRows(withUrls)
    setLoading(false)
  }

  if (!objek) return <div className="p-8 text-sm text-gray-500">Profil belum terhubung ke objek pengawasan.</div>

  return (
    <div className="max-w-3xl mx-auto px-4 py-8">
      <div className="flex items-start justify-between mb-4 gap-4">
        <div>
          <p className="text-xs uppercase tracking-wide text-gray-500">{objek.jenis} · Export Evidence</p>
          <h1 className="text-xl font-semibold text-ink">{objek.nama_opd}</h1>
        </div>
        <Link to="/checklist" className="text-sm text-accent hover:underline whitespace-nowrap">
          ← kembali ke checklist
        </Link>
      </div>

      <UnitSwitcher />

      {loading && <p className="text-sm text-gray-500">Menyiapkan link unduhan...</p>}

      {!loading && rows.length === 0 && (
        <p className="text-sm text-gray-500">Belum ada evidence yang diunggah.</p>
      )}

      <div className="space-y-2">
        {rows.map((r, i) => (
          <div key={i} className="flex items-center justify-between border border-gray-200 rounded-lg bg-white px-4 py-3">
            <div className="min-w-0">
              <p className="text-xs text-gray-400">
                {r.aspek} · {r.subAspek} · {r.nomor}
              </p>
              <p className="text-sm text-ink truncate">{r.namaFile}</p>
            </div>
            <a
              href={r.url}
              target="_blank"
              rel="noreferrer"
              className="text-xs text-accent hover:underline flex-shrink-0 ml-3"
            >
              Unduh
            </a>
          </div>
        ))}
      </div>
    </div>
  )
}
