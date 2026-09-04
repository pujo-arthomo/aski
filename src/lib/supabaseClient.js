import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseAnonKey) {
  // eslint-disable-next-line no-console
  console.warn(
    'VITE_SUPABASE_URL / VITE_SUPABASE_ANON_KEY belum diisi. Salin .env.example ke .env dan isi dari Supabase Dashboard.'
  )
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

// Nama bucket Supabase Storage tempat file evidence disimpan.
// Dibuat otomatis oleh supabase/schema.sql.
export const EVIDENCE_BUCKET = 'evidence-files'
