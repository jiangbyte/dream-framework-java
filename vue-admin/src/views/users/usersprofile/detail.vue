<script lang="ts" setup>
import { useUsersProfileApi } from '@/api'
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
    withLoading(useUsersProfileApi().GetUsersProfile(row?.id)).then(({ data, success }) => {
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
        <t-descriptions-item label="真实姓名">
          {{ withFallback(formData.realName) }}
        </t-descriptions-item>
        <t-descriptions-item label="学校">
          {{ withFallback(formData.school) }}
        </t-descriptions-item>
        <t-descriptions-item label="专业">
          {{ withFallback(formData.major) }}
        </t-descriptions-item>
        <t-descriptions-item label="学号">
          {{ withFallback(formData.studentId) }}
        </t-descriptions-item>
        <t-descriptions-item label="公司">
          {{ withFallback(formData.company) }}
        </t-descriptions-item>
        <t-descriptions-item label="职位">
          {{ withFallback(formData.jobTitle) }}
        </t-descriptions-item>
        <t-descriptions-item label="行业">
          {{ withFallback(formData.industry) }}
        </t-descriptions-item>
        <t-descriptions-item label="国家">
          {{ withFallback(formData.country) }}
        </t-descriptions-item>
        <t-descriptions-item label="省份">
          {{ withFallback(formData.province) }}
        </t-descriptions-item>
        <t-descriptions-item label="城市">
          {{ withFallback(formData.city) }}
        </t-descriptions-item>
        <t-descriptions-item label="详细地址">
          {{ withFallback(formData.location) }}
        </t-descriptions-item>
        <t-descriptions-item label="QQ">
          {{ withFallback(formData.qq) }}
        </t-descriptions-item>
        <t-descriptions-item label="微信">
          {{ withFallback(formData.wechat) }}
        </t-descriptions-item>
        <t-descriptions-item label="是否显示生日">
          {{ withFallback(formData.showBirthday) }}
        </t-descriptions-item>
        <t-descriptions-item label="是否显示地理位置">
          {{ withFallback(formData.showLocation) }}
        </t-descriptions-item>
      </t-descriptions>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
