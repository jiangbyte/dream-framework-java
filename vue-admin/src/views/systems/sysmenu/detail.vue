<script lang="ts" setup>
import { useSysMenuApi } from '@/api'
import { useBoolean, useLoading } from '@/hooks'
import { ResetFormData, withFallback } from '@/utils'

// ============================================== Props ==============================================
const props = defineProps<{
  formName?: string
}>()

// ============================================== Loading ==============================================
const { isLoading, withLoading } = useLoading()

// ============================================== Boolean ==============================================
const { value: visible, setFalse: closeDrawer, setTrue: openDrawer } = useBoolean(false)

// ============================================== Data ==============================================
const formData = reactive<DataFormType>({})

// ============================================== Function ==============================================
function doClose() {
  ResetFormData(formData)
  closeDrawer()
}

async function doOpen(row: any) {
  openDrawer()

  // Iint Data
  ResetFormData(formData)

  // Data Load
  if (row?.id) {
    withLoading(useSysMenuApi().GetSysMenu(row?.id)).then(({ data, success }) => {
      if (success) {
        Object.assign(formData, data)
      }
      else {
        closeDrawer()
      }
    })
  }
}

defineExpose({
  doOpen,
})
</script>

<template>
  <t-drawer
    v-model:visible="visible"
    :close-btn="true"
    :confirm-btn="null"
    size="large"
    destroy-on-close
    @close="doClose"
  >
    <template #header>
      {{ `${props.formName}详情` }}
    </template>
    <t-loading
      size="small"
      :loading="isLoading"
      show-overlay
      class="w-full"
    >
      <t-descriptions :column="1" colon table-layout="auto">
        <t-descriptions-item label="父级ID">
          {{ withFallback(formData.pid) }}
        </t-descriptions-item>
        <t-descriptions-item label="菜单名称">
          {{ withFallback(formData.name) }}
        </t-descriptions-item>
        <t-descriptions-item label="菜单路径">
          {{ withFallback(formData.path) }}
        </t-descriptions-item>
        <t-descriptions-item label="组件路径">
          {{ withFallback(formData.componentPath) }}
        </t-descriptions-item>
        <t-descriptions-item label="重定向路径">
          {{ withFallback(formData.redirect) }}
        </t-descriptions-item>
        <t-descriptions-item label="外部链接地址">
          {{ withFallback(formData.externalUrl) }}
        </t-descriptions-item>
        <t-descriptions-item label="菜单类型：0-内部菜单 1-外链菜单 2-重定向菜单 3-iframe嵌入">
          {{ withFallback(formData.menuType) }}
        </t-descriptions-item>
        <t-descriptions-item label="打开方式：0-当前窗口 1-新窗口打开">
          {{ withFallback(formData.openTarget) }}
        </t-descriptions-item>
        <t-descriptions-item label="iframe属性">
          {{ withFallback(formData.iframeAttrs) }}
        </t-descriptions-item>
        <t-descriptions-item label="菜单标题">
          {{ withFallback(formData.title) }}
        </t-descriptions-item>
        <t-descriptions-item label="菜单图标">
          {{ withFallback(formData.icon) }}
        </t-descriptions-item>
        <t-descriptions-item label="排序">
          {{ withFallback(formData.sort) }}
        </t-descriptions-item>
        <t-descriptions-item label="缓存">
          {{ withFallback(formData.keepAlive) }}
        </t-descriptions-item>
        <t-descriptions-item label="可见">
          {{ withFallback(formData.visible) }}
        </t-descriptions-item>
        <t-descriptions-item label="钉钉">
          {{ withFallback(formData.pined) }}
        </t-descriptions-item>
        <t-descriptions-item label="无标签页">
          {{ withFallback(formData.withoutTab) }}
        </t-descriptions-item>
        <t-descriptions-item label="头部参数">
          {{ withFallback(formData.parameters) }}
        </t-descriptions-item>
        <t-descriptions-item label="路由参数">
          {{ withFallback(formData.extraParams) }}
        </t-descriptions-item>
      </t-descriptions>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
