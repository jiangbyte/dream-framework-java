/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_API_URL: string
  readonly VITE_HOME_PATH: string
  readonly VITE_ROUTES_MODE: string // 'static' | 'dynamic'
  readonly VITE_PATH_SECRET_KEY: string
  readonly VITE_PASSWORD_SECRET_KEY: string
  readonly VITE_PORT: string | number
  readonly VITE_PUBLIC_ROUTES: string // 公开路由，多个用逗号分隔
  readonly VITE_AUTH_PAGES: string // 认证页面，多个用逗号分隔
  readonly VITE_WHITELIST_ROUTES: string // 白名单路由，多个用逗号分隔
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}
