<script lang="ts" setup>
import { useUsersPreferenceApi } from '@/api'
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
    withLoading(useUsersPreferenceApi().GetUsersPreference(row?.id)).then(({ data, success }) => {
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
        <t-descriptions-item label="账户ID">
          {{ withFallback(formData.accountId) }}
        </t-descriptions-item>
        <t-descriptions-item label="主题">
          {{ withFallback(formData.theme) }}
        </t-descriptions-item>
        <t-descriptions-item label="系统语言">
          {{ withFallback(formData.language) }}
        </t-descriptions-item>
        <t-descriptions-item label="邮件通知">
          {{ withFallback(formData.emailNotifications) }}
        </t-descriptions-item>
        <t-descriptions-item label="推送通知">
          {{ withFallback(formData.pushNotifications) }}
        </t-descriptions-item>
        <t-descriptions-item label="允许私信">
          {{ withFallback(formData.allowDirectMessage) }}
        </t-descriptions-item>
      </t-descriptions>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
