import type { RouteRecordRaw } from 'vue-router'
import Layout from '@/layouts/index.vue'

export const layoutRoutes: RouteRecordRaw[] = [
  // 默认布局路由
  {
    path: '/',
    name: 'default',
    // redirect: '/root',
    component: Layout,
    meta: {
      title: '系统',
      icon: 'application',
    },
    children: [
      // 公开路由
      {
        path: '/',
        name: 'home',
        component: () => import('@/views/home/index.vue'),
        meta: { title: '首页' },
      },
    ],
  },
  // 其他布局路由
]
