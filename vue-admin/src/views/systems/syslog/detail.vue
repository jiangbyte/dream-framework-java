<script lang="ts" setup>
import { useSysLogApi } from '@/api'
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
  ResetFormData(formData)

  if (row?.id) {
    withLoading(useSysLogApi().GetSysLog(row?.id)).then(({ data, success }) => {
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
        <t-descriptions-item label="用户ID">
          {{ withFallback(formData.userId) }}
        </t-descriptions-item>
        <t-descriptions-item label="操作类型">
          {{ withFallback(formData.operation) }}
        </t-descriptions-item>
        <t-descriptions-item label="请求方法">
          {{ withFallback(formData.method) }}
        </t-descriptions-item>
        <t-descriptions-item label="请求参数">
          {{ withFallback(formData.params) }}
        </t-descriptions-item>
        <t-descriptions-item label="IP地址">
          {{ withFallback(formData.ip) }}
        </t-descriptions-item>
        <t-descriptions-item label="操作时间">
          {{ withFallback(formData.operationTime) }}
        </t-descriptions-item>
        <t-descriptions-item label="日志分类">
          {{ withFallback(formData.category) }}
        </t-descriptions-item>
        <t-descriptions-item label="操作模块">
          {{ withFallback(formData.module) }}
        </t-descriptions-item>
        <t-descriptions-item label="操作描述">
          {{ withFallback(formData.description) }}
        </t-descriptions-item>
        <t-descriptions-item label="操作状态">
          {{ withFallback(formData.status) }}
        </t-descriptions-item>
        <t-descriptions-item label="日志消息">
          {{ withFallback(formData.message) }}
        </t-descriptions-item>
      </t-descriptions>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
