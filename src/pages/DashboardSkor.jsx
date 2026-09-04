import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { supabase } from '../lib/supabaseClient'
import { useAuth } from '../lib/useAuth'
import { hitungSkorASKI } from '../utils/scoring'
import ScoreBadge from '../components/ScoreBadge'

export default function DashboardSkor() {
  const { profile } = useAuth()
  const objek = profile?.objek_pengawasan

  const [aspekList, setAspekList] = useState([])
  const [itemsBySubAspek, setItemsBySubAspek] = useState({})
  const [skorByItemId, setSkorByItemId] = useState({})
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (objek) load()
  }, [objek?.id])

  async function load() {
    setLoading(true)

    const { data: aspekData } = await supabase
      .from('aspek_penilaian')
      .select('*, sub_aspek(*)')
      .eq('jenis_instrumen', objek.jenis)
      .order('urutan')
    const aspekSorted = (aspekData || []).map((a) => ({
      ...a,
      subAspek: [...a.sub_aspek].sort((x, y) => x.urutan - y.urutan),
    }))
    setAspekList(aspekSorted)

    const subAspekIds = aspekSorted.flatMap((a) => a.subAspek.map((s) => s.id))

    const { data: itemData } = await supabase
      .from('item_pertanyaan')
      .select('id, sub_aspek_id')
      .in('sub_aspek_id', subAspekIds)

    const bySA = {}
    for (const it of itemData || []) {
      bySA[it.sub_aspek_id] = bySA[it.sub_aspek_id] || []
      bySA[it.sub_aspek_id].push(it.id)
    }
    setItemsBySubAspek(bySA)

    const { data: jawabanData } = await supabase
      .from('jawaban_opd')
      .select('item_id, pilihan_jawaban(skor)')
      .eq('objek_id', objek.id)
      .not('pilihan_id', 'is', null)

    const skorMap = {}
    for (const j of jawabanData || []) {
      if (j.pilihan_jawaban) skorMap[j.item_id] = j.pilihan_jawaban.skor
    }
    setSkorByItemId(skorMap)

    setLoading(false)
  }

  const hasil = useMemo(() => {
    if (aspekList.length === 0) return null
    return hitungSkorASKI({ aspekList, itemsBySubAspek, skorByItemId })
  }, [aspekList, itemsBySubAspek, skorByItemId])

  if (!objek) return <div className="p-8 text-sm text-gray-500">Profil belum terhubung ke objek pengawasan.</div>
  if (loading || !hasil) return <div className="p-8 text-sm text-gray-500">Menghitung skor...</div>

  return (
    <div className="max-w-3xl mx-auto px-4 py-8">
      <div className="flex items-start justify-between mb-6 gap-4">
        <div>
          <p className="text-xs uppercase tracking-wide text-gray-500">{objek.jenis} · Dashboard Skor</p>
          <h1 className="text-xl font-semibold text-ink">{objek.nama_opd}</h1>
        </div>
        <Link to="/checklist" className="text-sm text-accent hover:underline whitespace-nowrap">
          ← kembali ke checklist
        </Link>
      </div>

      <div className="bg-white border border-gray-200 rounded-lg p-6 mb-8 flex items-center justify-between">
        <div>
          <p className="text-4xl font-semibold text-ink tabular-nums">{hasil.nilaiAkhir.toFixed(2)}</p>
          <p className="text-xs text-gray-500 mt-1">dari skala 0–100, dihitung live dari jawaban tersimpan</p>
        </div>
        <ScoreBadge kategori={hasil.kategori} className="text-sm px-3 py-1.5" />
      </div>

      {hasil.aspekDetail.map((aspek) => (
        <div key={aspek.aspekId} className="mb-6">
          <div className="flex items-center justify-between mb-2">
            <h2 className="text-sm font-semibold text-ink">{aspek.nama}</h2>
            <span className="text-sm font-mono tabular-nums text-gray-500">
              {aspek.nilaiAkhirAspek.toFixed(2)} <span className="text-gray-400">(bobot {aspek.bobot})</span>
            </span>
          </div>
          <div className="h-1.5 bg-gray-100 rounded-full overflow-hidden mb-3">
            <div
              className="h-full bg-operator rounded-full"
              style={{ width: `${Math.min(100, (aspek.nilaiAkhirAspek / (aspek.bobot * 100)) * 100)}%` }}
            />
          </div>

          <div className="space-y-1.5">
            {hasil.subAspekDetail
              .filter((sa) => sa.aspekId === aspek.aspekId)
              .map((sa) => (
                <div key={sa.subAspekId} className="flex items-center justify-between text-xs text-gray-600 px-1">
                  <span>
                    {sa.nama}{' '}
                    <span className="text-gray-400">
                      ({sa.jumlahDijawab}/{sa.totalItem} item dijawab)
                    </span>
                  </span>
                  <span className="font-mono tabular-nums">
                    {sa.totalSkor}/{sa.nilaiStandar} → {sa.nilaiSubAspek.toFixed(2)}
                  </span>
                </div>
              ))}
          </div>
        </div>
      ))}
    </div>
  )
}
