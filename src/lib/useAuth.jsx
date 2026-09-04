import { createContext, useContext, useEffect, useState } from 'react'
import { supabase } from './supabaseClient'

// Context: siapa yang login, profilnya (role), dan daftar objek_pengawasan
// (unit) yang bisa diakses akun ini lewat tabel akses_objek — bisa lebih
// dari satu (misal Diskarpus: Unit Pengolah + Unit Kearsipan dalam 1 akun).
// activeObjek = unit yang lagi dipilih untuk diisi/dilihat saat ini.
const AuthContext = createContext(null)
const LS_KEY_ACTIVE_OBJEK = 'evidence-aski:objek-aktif'

export function AuthProvider({ children }) {
  const [session, setSession] = useState(null)
  const [profile, setProfile] = useState(null)
  const [objekList, setObjekList] = useState([])
  const [activeObjekId, setActiveObjekId] = useState(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    supabase.auth.getSession().then(({ data }) => {
      setSession(data.session)
      if (data.session) loadProfile(data.session.user.id)
      else setLoading(false)
    })

    const { data: listener } = supabase.auth.onAuthStateChange((_event, newSession) => {
      setSession(newSession)
      if (newSession) loadProfile(newSession.user.id)
      else {
        setProfile(null)
        setObjekList([])
        setActiveObjekId(null)
        setLoading(false)
      }
    })

    return () => listener.subscription.unsubscribe()
  }, [])

  async function loadProfile(userId) {
    const { data: profileData } = await supabase.from('profiles').select('*').eq('id', userId).single()
    setProfile(profileData)

    // Akses unit (akses_objek) dicek untuk SEMUA role, bukan cuma operator —
    // supaya 1 akun admin juga bisa sekaligus isi checklist untuk instansinya
    // sendiri (misal Diskarpus: admin lihat dashboard agregat 39 OPD, DAN
    // isi checklist Unit Pengolah/Unit Kearsipan miliknya sendiri).
    if (profileData) {
      const { data: aksesData } = await supabase
        .from('akses_objek')
        .select('objek_pengawasan(*)')
        .eq('profile_id', userId)
      const list = (aksesData || []).map((a) => a.objek_pengawasan).filter(Boolean)
      setObjekList(list)

      let savedId = null
      try {
        savedId = localStorage.getItem(LS_KEY_ACTIVE_OBJEK)
      } catch {
        // localStorage bisa gagal (mode private dsb) — abaikan, pakai default
      }
      const masihValid = list.some((o) => o.id === savedId)
      setActiveObjekId(masihValid ? savedId : list[0]?.id || null)
    } else {
      setObjekList([])
      setActiveObjekId(null)
    }

    setLoading(false)
  }

  function pilihUnit(objekId) {
    setActiveObjekId(objekId)
    try {
      localStorage.setItem(LS_KEY_ACTIVE_OBJEK, objekId)
    } catch {
      // abaikan kalau localStorage tidak tersedia
    }
  }

  const activeObjek = objekList.find((o) => o.id === activeObjekId) || null

  const value = {
    session,
    profile,
    objekList,
    activeObjek,
    pilihUnit,
    loading,
    isAdmin: profile?.role === 'admin',
    signOut: () => supabase.auth.signOut(),
  }

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>
}

export function useAuth() {
  const ctx = useContext(AuthContext)
  if (!ctx) throw new Error('useAuth harus dipakai di dalam <AuthProvider>')
  return ctx
}
