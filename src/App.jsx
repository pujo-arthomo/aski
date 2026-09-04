import { Navigate, Route, Routes } from 'react-router-dom'
import { AuthProvider, useAuth } from './lib/useAuth'
import Login from './pages/Login'
import Checklist from './pages/Checklist'
import DashboardSkor from './pages/DashboardSkor'
import ExportEvidence from './pages/ExportEvidence'
import DashboardAdmin from './pages/DashboardAdmin'

function Protected({ children, adminOnly = false }) {
  const { session, profile, loading, isAdmin } = useAuth()
  if (loading) return <div className="p-8 text-sm text-gray-500">Memuat...</div>
  if (!session) return <Navigate to="/login" replace />
  if (adminOnly && !isAdmin) return <Navigate to="/checklist" replace />
  if (!profile) return <div className="p-8 text-sm text-gray-500">Profil belum diset. Hubungi Admin Diskarpus.</div>
  return children
}

function AppRoutes() {
  return (
    <Routes>
      <Route path="/login" element={<Login />} />
      <Route
        path="/checklist"
        element={
          <Protected>
            <Checklist />
          </Protected>
        }
      />
      <Route
        path="/dashboard"
        element={
          <Protected>
            <DashboardSkor />
          </Protected>
        }
      />
      <Route
        path="/export"
        element={
          <Protected>
            <ExportEvidence />
          </Protected>
        }
      />
      <Route
        path="/admin"
        element={
          <Protected adminOnly>
            <DashboardAdmin />
          </Protected>
        }
      />
      <Route path="*" element={<Navigate to="/checklist" replace />} />
    </Routes>
  )
}

export default function App() {
  return (
    <AuthProvider>
      <AppRoutes />
    </AuthProvider>
  )
}
