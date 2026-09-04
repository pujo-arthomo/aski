import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { supabase, EVIDENCE_BUCKET } from '../lib/supabaseClient'
import { useAuth } from '../lib/useAuth'
import { hitungSkorASKI } from '../utils/scoring'
import ChecklistItem from '../components/ChecklistItem'
import ScoreBadge from '../components/ScoreBadge'

export default function Checklist() {
  const { profile } = useAuth()
  const objek = profile?.objek_pengawasan

  const [aspekList, setAspekList] = useState([])
  const [itemsBySubAspek, setItemsBySubAspek] = useState({})
  const [itemMap, setItemMap] = useState({}) // item_id -> item lengkap (dengan pilihan)
  const [jawabanMap, setJawabanMap] = useState({}) // item_id -> { id (jawaban_opd.id), pilihan_id }
  const [evidenceMap, setEvidenceMap] = useState({}) // jawaban_opd.id -> [evidence_file]
  const [loading, setLoading] = useState(true)
  const [savingItemId, setSavingItemId] = useState(null)

  useEffect(() => {
    if (objek) loadSemuaData()
  }, [objek?.id])

  async function loadSemuaData() {
    setLoading(true)

    // 1. Struktur instrumen (aspek -> sub-aspek) sesuai jenis objek (UP/UK)
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

    // 2. Item + pilihan jawaban untuk sub-aspek itu
    const { data: itemData } = await supabase
      .from('item_pertanyaan')
      .select('*, pilihan_jawaban(*)')
      .in('sub_aspek_id', subAspekIds)
      .order('urutan')

    const bySA = {}
    const iMap = {}
    for (const it of itemData || []) {
      bySA[it.sub_aspek_id] = bySA[it.sub_aspek_id] || []
      bySA[it.sub_aspek_id].push(it.id)
      iMap[it.id] = { ...it, pilihan: [...it.pilihan_jawaban].sort((a, b) => a.level - b.level) }
    }
    setItemsBySubAspek(bySA)
    setItemMap(iMap)

    // 3. Jawaban yang sudah diisi objek ini + evidence file-nya
    const { data: jawabanData } = await supabase
      .from('jawaban_opd')
      .select('*, evidence_file(*)')
      .eq('objek_id', objek.id)

    const jMap = {}
    const eMap = {}
    for (const j of jawabanData || []) {
      jMap[j.item_id] = { id: j.id, pilihan_id: j.pilihan_id }
      eMap[j.id] = j.evidence_file || []
    }
    setJawabanMap(jMap)
    setEvidenceMap(eMap)

    setLoading(false)
  }

  const skorByItemId = useMemo(() => {
    const map = {}
    for (const [itemId, j] of Object.entries(jawabanMap)) {
      if (!j.pilihan_id) continue
      const item = itemMap[itemId]
      const pilihan = item?.pilihan.find((p) => p.id === j.pilihan_id)
      if (pilihan) map[itemId] = pilihan.skor
    }
    return map
  }, [jawabanMap, itemMap])

  const hasil = useMemo(() => {
    if (aspekList.length === 0) return null
    return hitungSkorASKI({ aspekList, itemsBySubAspek, skorByItemId })
  }, [aspekList, itemsBySubAspek, skorByItemId])

  async function handlePilih(itemId, pilihanId) {
    setSavingItemId(itemId)
    const existing = jawabanMap[itemId]

    const { data, error } = await supabase
      .from('jawaban_opd')
      .upsert(
        {
          id: existing?.id,
          objek_id: objek.id,
          item_id: itemId,
          pilihan_id: pilihanId,
          diisi_oleh: profile.id,
          updated_at: new Date().toISOString(),
        },
        { onConflict: 'objek_id,item_id' }
      )
      .select()
      .single()

    setSavingItemId(null)
    if (error) {
      alert('Gagal menyimpan jawaban: ' + error.message)
      return
    }
    setJawabanMap((prev) => ({ ...prev, [itemId]: { id: data.id, pilihan_id: data.pilihan_id } }))
  }

  async function handleUpload(itemId, fileList) {
    setSavingItemId(itemId)
    let jawaban = jawabanMap[itemId]

    // Kalau item ini belum punya jawaban_opd sama sekali, buat dulu (tanpa
    // pilihan) supaya evidence_file punya jawaban_id untuk direlasikan.
    if (!jawaban) {
      const { data, error } = await supabase
        .from('jawaban_opd')
        .upsert(
          { objek_id: objek.id, item_id: itemId, diisi_oleh: profile.id, updated_at: new Date().toISOString() },
          { onConflict: 'objek_id,item_id' }
        )
        .select()
        .single()
      if (error) {
        setSavingItemId(null)
        alert('Gagal menyiapkan slot evidence: ' + error.message)
        return
      }
      jawaban = { id: data.id, pilihan_id: data.pilihan_id }
      setJawabanMap((prev) => ({ ...prev, [itemId]: jawaban }))
    }

    const uploaded = []
    for (const file of fileList) {
      const path = `${objek.id}/${itemId}/${Date.now()}-${file.name}`
      const { error: upErr } = await supabase.storage.from(EVIDENCE_BUCKET).upload(path, file)
      if (upErr) {
        alert(`Gagal unggah ${file.name}: ${upErr.message}`)
        continue
      }
      const { data: row, error: insErr } = await supabase
        .from('evidence_file')
        .insert({
          jawaban_id: jawaban.id,
          nama_file: file.name,
          tipe_file: file.type,
          storage_path: path,
          uploaded_by: profile.id,
        })
        .select()
        .single()
      if (!insErr) uploaded.push(row)
    }

    setEvidenceMap((prev) => ({ ...prev, [jawaban.id]: [...(prev[jawaban.id] || []), ...uploaded] }))
    setSavingItemId(null)
  }

  if (!objek) {
    return <div className="p-8 text-sm text-gray-500">Profil belum terhubung ke objek pengawasan. Hubungi Admin Diskarpus.</div>
  }
  if (loading) {
    return <div className="p-8 text-sm text-gray-500">Memuat checklist...</div>
  }

  return (
    <div className="max-w-3xl mx-auto px-4 py-8">
      <div className="flex items-start justify-between mb-6 gap-4">
        <div>
          <p className="text-xs uppercase tracking-wide text-gray-500">{objek.jenis} · Checklist ASKI</p>
          <h1 className="text-xl font-semibold text-ink">{objek.nama_opd}</h1>
        </div>
        <Link to="/dashboard" className="text-sm text-accent hover:underline whitespace-nowrap">
          Lihat dashboard skor →
        </Link>
      </div>

      {hasil && (
        <div className="bg-white border border-gray-200 rounded-lg p-4 mb-6 flex items-center justify-between">
          <div>
            <p className="text-2xl font-semibold text-ink tabular-nums">{hasil.nilaiAkhir.toFixed(2)}</p>
            <p className="text-xs text-gray-500">nilai ASKI saat ini (dihitung live)</p>
          </div>
          <ScoreBadge kategori={hasil.kategori} />
        </div>
      )}

      {aspekList.map((aspek) => (
        <div key={aspek.id} className="mb-8">
          <h2 className="text-sm font-semibold text-ink mb-3 pb-2 border-b border-gray-200">
            {aspek.nama} <span className="text-gray-400 font-normal">· bobot {aspek.bobot}</span>
          </h2>
          {aspek.subAspek.map((sa) => (
            <div key={sa.id} className="mb-5">
              <h3 className="text-xs font-medium text-gray-500 uppercase tracking-wide mb-2">{sa.nama}</h3>
              <div className="space-y-3">
                {(itemsBySubAspek[sa.id] || []).map((itemId) => {
                  const item = itemMap[itemId]
                  const jawaban = jawabanMap[itemId]
                  if (!item) return null
                  return (
                    <ChecklistItem
                      key={itemId}
                      item={item}
                      pilihanId={jawaban?.pilihan_id}
                      evidenceFiles={jawaban ? evidenceMap[jawaban.id] : []}
                      onPilih={handlePilih}
                      onUpload={handleUpload}
                      saving={savingItemId === itemId}
                    />
                  )
                })}
              </div>
            </div>
          ))}
        </div>
      ))}
    </div>
  )
}
