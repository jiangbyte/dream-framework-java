<script lang="ts" setup>
import { useAuthsAccountApi } from '@/api'
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
    withLoading(useAuthsAccountApi().GetAuthsAccount(row?.id)).then(({ data, success }) => {
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
        <t-descriptions-item label="用户名，登录标识">
          {{ withFallback(formData.username) }}
        </t-descriptions-item>
        <t-descriptions-item label="加密后的密码">
          {{ withFallback(formData.password) }}
        </t-descriptions-item>
        <t-descriptions-item label="邮箱地址">
          {{ withFallback(formData.email) }}
        </t-descriptions-item>
        <t-descriptions-item label="手机号码">
          {{ withFallback(formData.telephone) }}
        </t-descriptions-item>
        <t-descriptions-item label="账户状态">
          {{ withFallback(formData.status) }}
        </t-descriptions-item>
        <t-descriptions-item label="密码强度等级">
          {{ withFallback(formData.passwordStrength) }}
        </t-descriptions-item>
        <t-descriptions-item label="最后修改密码的时间">
          {{ withFallback(formData.lastPasswordChange) }}
        </t-descriptions-item>
        <t-descriptions-item label="最后登录时间">
          {{ withFallback(formData.lastLoginTime) }}
        </t-descriptions-item>
        <t-descriptions-item label="最后登录IP地址">
          {{ withFallback(formData.lastLoginIp) }}
        </t-descriptions-item>
        <t-descriptions-item label="登录次数统计">
          {{ withFallback(formData.loginCount) }}
        </t-descriptions-item>
      </t-descriptions>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
