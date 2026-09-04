// Badge kategori nilai — warna mengikuti tingkat (bukan cuma teks), supaya
// kelihatan sekilas tanpa harus baca angkanya dulu.
const WARNA = {
  'AA (Sangat Memuaskan)': 'bg-emerald-100 text-emerald-800',
  'A (Memuaskan)': 'bg-emerald-100 text-emerald-800',
  'BB (Sangat Baik)': 'bg-teal-100 text-teal-800',
  'B (Baik)': 'bg-teal-100 text-teal-800',
  'CC (Cukup)': 'bg-amber-100 text-amber-800',
  'C (Kurang)': 'bg-orange-100 text-orange-800',
  'D (Sangat Kurang)': 'bg-red-100 text-red-800',
}

export default function ScoreBadge({ kategori, className = '' }) {
  const warna = WARNA[kategori] || 'bg-gray-100 text-gray-700'
  return (
    <span className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium ${warna} ${className}`}>
      {kategori}
    </span>
  )
}
