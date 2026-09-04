import { useEffect, useMemo, useState } from 'react'
import { supabase } from '../lib/supabaseClient'
import { hitungSkorASKI } from '../utils/scoring'
import ScoreBadge from '../components/ScoreBadge'

// Rekap semua OPD untuk Admin Diskarpus — satu query besar per tabel
// (bukan satu query per OPD) supaya tetap ringan walau 39 objek pengawasan.
export default function DashboardAdmin() {
  const [objekList, setObjekList] = useState([])
  const [aspekByJenis, setAspekByJenis] = useState({ UP: [], UK: [] })
  const [itemsBySubAspek, setItemsBySubAspek] = useState({})
  const [skorByObjekItem, setSkorByObjekItem] = useState({}) // { objek_id: { item_id: skor } }
  const [loading, setLoading] = useState(true)
  const [sortBy, setSortBy] = useState('nilai_asc')

  useEffect(() => {
    load()
  }, [])

  async function load() {
    setLoading(true)

    const { data: objek } = await supabase.from('objek_pengawasan').select('*').order('nama_opd')
    setObjekList(objek || [])

    const { data: aspekData } = await supabase.from('aspek_penilaian').select('*, sub_aspek(*)').order('urutan')
    const grouped = { UP: [], UK: [] }
    for (const a of aspekData || []) {
      grouped[a.jenis_instrumen].push({ ...a, subAspek: [...a.sub_aspek].sort((x, y) => x.urutan - y.urutan) })
    }
    setAspekByJenis(grouped)

    const allSubAspekIds = (aspekData || []).flatMap((a) => a.sub_aspek.map((s) => s.id))
    const { data: itemData } = await supabase.from('item_pertanyaan').select('id, sub_aspek_id').in('sub_aspek_id', allSubAspekIds)
    const bySA = {}
    for (const it of itemData || []) {
      bySA[it.sub_aspek_id] = bySA[it.sub_aspek_id] || []
      bySA[it.sub_aspek_id].push(it.id)
    }
    setItemsBySubAspek(bySA)

    const { data: jawabanData } = await supabase
      .from('jawaban_opd')
      .select('objek_id, item_id, pilihan_jawaban(skor)')
      .not('pilihan_id', 'is', null)
    const byObjek = {}
    for (const j of jawabanData || []) {
      byObjek[j.objek_id] = byObjek[j.objek_id] || {}
      if (j.pilihan_jawaban) byObjek[j.objek_id][j.item_id] = j.pilihan_jawaban.skor
    }
    setSkorByObjekItem(byObjek)

    setLoading(false)
  }

  const rekap = useMemo(() => {
    return objekList.map((o) => {
      const aspekList = aspekByJenis[o.jenis] || []
      const hasil = hitungSkorASKI({
        aspekList,
        itemsBySubAspek,
        skorByItemId: skorByObjekItem[o.id] || {},
      })
      const subAspekTerlemah = [...hasil.subAspekDetail].sort((a, b) => {
        const pctA = a.nilaiStandar ? a.totalSkor / a.nilaiStandar : 0
        const pctB = b.nilaiStandar ? b.totalSkor / b.nilaiStandar : 0
        return pctA - pctB
      })[0]
      return { objek: o, ...hasil, subAspekTerlemah }
    })
  }, [objekList, aspekByJenis, itemsBySubAspek, skorByObjekItem])

  const sorted = useMemo(() => {
    const arr = [...rekap]
    if (sortBy === 'nilai_asc') arr.sort((a, b) => a.nilaiAkhir - b.nilaiAkhir)
    if (sortBy === 'nilai_desc') arr.sort((a, b) => b.nilaiAkhir - a.nilaiAkhir)
    if (sortBy === 'nama') arr.sort((a, b) => a.objek.nama_opd.localeCompare(b.objek.nama_opd))
    return arr
  }, [rekap, sortBy])

  const rataRata = rekap.length ? rekap.reduce((s, r) => s + r.nilaiAkhir, 0) / rekap.length : 0

  if (loading) return <div className="p-8 text-sm text-gray-500">Memuat rekap semua OPD...</div>

  return (
    <div className="max-w-4xl mx-auto px-4 py-8">
      <div className="flex items-start justify-between mb-6 gap-4">
        <div>
          <p className="text-xs uppercase tracking-wide text-gray-500">Admin Diskarpus</p>
          <h1 className="text-xl font-semibold text-ink">Dashboard Agregat — {objekList.length} Objek Pengawasan</h1>
        </div>
        <div className="text-right">
          <p className="text-2xl font-semibold text-ink tabular-nums">{rataRata.toFixed(2)}</p>
          <p className="text-xs text-gray-500">rata-rata nilai</p>
        </div>
      </div>

      <div className="flex gap-2 mb-4">
        {[
          ['nilai_asc', 'Terendah dulu'],
          ['nilai_desc', 'Tertinggi dulu'],
          ['nama', 'Nama OPD'],
        ].map(([key, label]) => (
          <button
            key={key}
            onClick={() => setSortBy(key)}
            className={`text-xs px-3 py-1.5 rounded-full border ${
              sortBy === key ? 'bg-ink text-white border-ink' : 'border-gray-300 text-gray-600'
            }`}
          >
            {label}
          </button>
        ))}
      </div>

      <div className="space-y-1.5">
        {sorted.map((r) => (
          <div key={r.objek.id} className="flex items-center justify-between border border-gray-200 rounded-lg bg-white px-4 py-3">
            <div className="min-w-0">
              <p className="text-sm text-ink truncate">
                {r.objek.nama_opd} <span className="text-xs text-gray-400">({r.objek.jenis})</span>
              </p>
              {r.subAspekTerlemah && (
                <p className="text-xs text-gray-400">
                  Sub-aspek terlemah: {r.subAspekTerlemah.nama} ({r.subAspekTerlemah.totalSkor}/{r.subAspekTerlemah.nilaiStandar})
                </p>
              )}
            </div>
            <div className="flex items-center gap-3 flex-shrink-0">
              <span className="text-sm font-mono tabular-nums text-ink">{r.nilaiAkhir.toFixed(2)}</span>
              <ScoreBadge kategori={r.kategori} />
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}
