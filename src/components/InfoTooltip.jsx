import { useState } from 'react'

// Ikon "info" kecil yang bisa di-hover (atau di-tap di HP) untuk menampilkan
// contoh bukti dukung resmi per item — supaya operator tahu jenis evidence
// apa yang sebaiknya diunggah, tanpa perlu buka dokumen standar terpisah.
export default function InfoTooltip({ text }) {
  const [show, setShow] = useState(false)
  if (!text) return null

  return (
    <span className="relative inline-block align-middle ml-1.5">
      <button
        type="button"
        onMouseEnter={() => setShow(true)}
        onMouseLeave={() => setShow(false)}
        onClick={() => setShow((s) => !s)}
        aria-label="Lihat contoh bukti dukung"
        className="w-4 h-4 inline-flex items-center justify-center rounded-full border border-gray-300 text-gray-500 text-[10px] leading-none hover:border-accent hover:text-accent focus:outline-none focus:ring-2 focus:ring-accent/40"
      >
        !
      </button>

      {show && (
        <div
          onMouseEnter={() => setShow(true)}
          onMouseLeave={() => setShow(false)}
          className="absolute z-20 top-5 left-0 w-72 sm:w-80 max-h-64 overflow-y-auto bg-ink text-white text-xs rounded-lg shadow-lg p-3 whitespace-pre-wrap leading-relaxed"
        >
          <p className="text-[10px] uppercase tracking-wide text-white/50 mb-1.5">Contoh bukti dukung</p>
          {text}
        </div>
      )}
    </span>
  )
}
