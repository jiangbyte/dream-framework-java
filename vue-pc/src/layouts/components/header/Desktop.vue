<script lang="ts" setup>
import Dropdown from '../Dropdown.vue'
import { useAuthStore, useRouterStore } from '@/stores'

const authStore = useAuthStore()
const routerStore = useRouterStore()

const router = useRouter()

// 定义菜单数据结构
interface MenuItem {
  value: string
  label: string
  disabled?: boolean
  children?: MenuItem[]
}

// 菜单数据
const menuItems: MenuItem[] = [
  { value: '/', label: '首页' },
  // {
  //   value: '1',
  //   label: '资源列表',
  //   children: [
  //     { value: '1-1', label: '菜单二', disabled: true }
  //   ]
  // },
  // {
  //   value: '2',
  //   label: '调度平台',
  //   children: [
  //     {
  //       value: '2-1',
  //       label: '二级菜单-1',
  //       children: [
  //         { value: '3-1', label: '三级菜单-1' },
  //         { value: '3-2', label: '三级菜单-2' },
  //         { value: '3-3', label: '三级菜单-3' }
  //       ]
  //     },
  //     { value: '2-2', label: '二级菜单-2' }
  //   ]
  // }
]

// 处理菜单点击
function handleMenuClick(item: MenuItem) {
  console.log('Menu clicked:', item)
  router.push(item.value)
}
</script>

<template>
  <div style="position: fixed; top: 0; z-index: 50; background-color: white;" class="h-56px w-full p-x-4 xl:p-x-12 flex justify-between items-center border-b border-b-solid border-b-gray-200">
    <t-space align="center">
      <div class="flex items-center justify-center">
        <img src="/logo3.png" height="40px" style="object-fit: cover">
      </div>

      <t-head-menu
        expand-type="popup"
        class="compact-menu"
        :value="routerStore.activeMenu"
        :default-value="routerStore.menus[0]?.path"
      >
        <template v-for="item in menuItems" :key="item.value">
          <!-- 有子菜单的情况 -->
          <t-submenu
            v-if="item.children && item.children.length"
            :value="item.value"
            :title="item.label"
          >
            <template v-for="child in item.children" :key="child.value">
              <!-- 二级有子菜单 -->
              <t-submenu
                v-if="child.children && child.children.length"
                :value="child.value"
                :title="child.label"
              >
                <t-menu-item
                  v-for="grandChild in child.children"
                  :key="grandChild.value"
                  :value="grandChild.value"
                  :disabled="grandChild.disabled"
                  @click="handleMenuClick(grandChild)"
                >
                  {{ grandChild.label }}
                </t-menu-item>
              </t-submenu>

              <!-- 二级普通菜单项 -->
              <t-menu-item
                v-else
                :value="child.value"
                :disabled="child.disabled"
                @click="handleMenuClick(child)"
              >
                {{ child.label }}
              </t-menu-item>
            </template>
          </t-submenu>

          <!-- 普通菜单项 -->
          <t-menu-item
            v-else
            :value="item.value"
            :disabled="item.disabled"
            @click="handleMenuClick(item)"
          >
            {{ item.label }}
          </t-menu-item>
        </template>
      </t-head-menu>

      <t-input placeholder="请输入搜索内容" style="width: 250px" clearable>
        <template #suffixIcon>
          <t-icon name="search" />
        </template>
      </t-input>
    </t-space>
    <t-space v-if="authStore.isLogined" align="center" :size="2" class="mr-4">
      <t-button variant="text" shape="square">
        <t-badge count="2" dot>
          <t-icon name="notification" />
        </t-badge>
      </t-button>
      <t-button variant="text" shape="square">
        <template #icon>
          <t-icon name="logo-github" />
        </template>
      </t-button>
      <t-button theme="primary">
        投稿
      </t-button>
      <Dropdown />
    </t-space>
    <t-space v-else align="center" :size="2" class="mr-4">
      <t-button variant="base" theme="default" @click="$router.push('/login')">
        登录
      </t-button>
      <t-button variant="base" theme="primary" @click="$router.push('/register')">
        注册
      </t-button>
    </t-space>
  </div>
</template>

<style scoped>
.compact-menu :deep(.t-menu__item) {
  margin: 0;
  padding: 0 8px;
}
.compact-menu :deep(.t-submenu) {
  margin: 0;
}
</style>
