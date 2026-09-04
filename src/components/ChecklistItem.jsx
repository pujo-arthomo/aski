import { useRef, useState } from 'react'
import InfoTooltip from './InfoTooltip'

// Satu blok pertanyaan ASKI: pilihan a-e + slot upload evidence.
// Catatan penting sesuai keputusan awal: tidak ada validasi "evidence ini
// sudah sesuai standar atau belum" — operator cukup unggah file yang relate,
// sistem tidak menilai isinya.
export default function ChecklistItem({ item, pilihanId, evidenceFiles, onPilih, onUpload, saving }) {
  const [dragOver, setDragOver] = useState(false)
  const fileInputRef = useRef(null)

  const sudahDijawab = Boolean(pilihanId)
  const adaEvidence = (evidenceFiles || []).length > 0

  function handleFiles(fileList) {
    if (fileList && fileList.length > 0) onUpload(item.id, fileList)
  }

  return (
    <div className="border border-gray-200 rounded-lg bg-white p-4 md:p-5">
      <div className="flex items-start justify-between gap-3 mb-3">
        <div>
          <span className="text-xs font-mono text-accent">{item.nomor}</span>
          <InfoTooltip text={item.contoh_bukti_dukung} />
          <p className="text-sm text-ink mt-0.5">{item.pernyataan}</p>
        </div>
        <div className="flex-shrink-0 flex flex-col items-end gap-1">
          {sudahDijawab && (
            <span className="text-xs px-2 py-0.5 rounded-full bg-emerald-100 text-emerald-700">terjawab</span>
          )}
          {adaEvidence && (
            <span className="text-xs px-2 py-0.5 rounded-full bg-blue-100 text-blue-700">
              {evidenceFiles.length} file
            </span>
          )}
        </div>
      </div>

      <div className="space-y-1.5 mb-4">
        {item.pilihan.map((p) => (
          <label
            key={p.id}
            className={`flex items-start gap-2 text-sm px-2.5 py-1.5 rounded cursor-pointer border ${
              pilihanId === p.id ? 'border-operator bg-operator/5' : 'border-transparent hover:bg-gray-50'
            }`}
          >
            <input
              type="radio"
              name={`item-${item.id}`}
              checked={pilihanId === p.id}
              onChange={() => onPilih(item.id, p.id)}
              className="mt-0.5"
            />
            <span>
              <span className="font-mono text-xs text-gray-400 mr-1">{p.kode}.</span>
              {p.label}
            </span>
          </label>
        ))}
      </div>

      <div
        onDragOver={(e) => {
          e.preventDefault()
          setDragOver(true)
        }}
        onDragLeave={() => setDragOver(false)}
        onDrop={(e) => {
          e.preventDefault()
          setDragOver(false)
          handleFiles(e.dataTransfer.files)
        }}
        onClick={() => fileInputRef.current?.click()}
        className={`border border-dashed rounded px-3 py-3 text-center text-xs cursor-pointer transition-colors ${
          dragOver ? 'border-accent bg-accent/5' : 'border-gray-300 text-gray-500 hover:border-gray-400'
        }`}
      >
        {saving ? 'Mengunggah...' : 'Klik atau seret file evidence ke sini (screenshot, foto, PDF, dll)'}
        <input
          ref={fileInputRef}
          type="file"
          multiple
          className="hidden"
          onChange={(e) => handleFiles(e.target.files)}
        />
      </div>

      {adaEvidence && (
        <ul className="mt-2 space-y-1">
          {evidenceFiles.map((f) => (
            <li key={f.id} className="text-xs text-gray-500 flex items-center gap-1.5">
              <span className="w-1 h-1 rounded-full bg-gray-400" />
              {f.nama_file}
            </li>
          ))}
        </ul>
      )}
    </div>
  )
}
