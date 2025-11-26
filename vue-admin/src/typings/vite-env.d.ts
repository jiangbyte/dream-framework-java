/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_API_URL: string
  readonly VITE_HOME_PATH: string
  readonly VITE_ROUTES_MODE: string // 'static' | 'dynamic'
  readonly VITE_PATH_SECRET_KEY: string
  readonly VITE_PASSWORD_SECRET_KEY: string
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}
