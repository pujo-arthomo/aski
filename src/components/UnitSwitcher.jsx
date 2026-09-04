import { useAuth } from '../lib/useAuth'

// Label singkat dari nama_opd, ambil teks dalam kurung kalau ada
// (contoh: "Dinas Kearsipan dan Perpustakaan (Unit Pengolah)" -> "Unit Pengolah").
function labelUnit(objek) {
  const match = objek.nama_opd.match(/\(([^)]+)\)/)
  return match ? match[1] : objek.nama_opd
}

// Tombol pilih unit — cuma muncul kalau akun ini punya akses ke lebih dari
// 1 objek pengawasan (misal Diskarpus: Unit Pengolah & Unit Kearsipan).
export default function UnitSwitcher() {
  const { objekList, activeObjek, pilihUnit } = useAuth()
  if (objekList.length < 2) return null

  return (
    <div className="flex gap-2 mb-4">
      {objekList.map((o) => (
        <button
          key={o.id}
          onClick={() => pilihUnit(o.id)}
          className={`text-xs px-3 py-1.5 rounded-full border transition-colors ${
            activeObjek?.id === o.id ? 'bg-ink text-white border-ink' : 'border-gray-300 text-gray-600 hover:border-gray-400'
          }`}
        >
          {o.jenis} · {labelUnit(o)}
        </button>
      ))}
    </div>
  )
}
