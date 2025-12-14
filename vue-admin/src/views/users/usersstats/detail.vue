<script lang="ts" setup>
import { useUsersStatsApi } from '@/api'
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
      withLoading(useUsersStatsApi().GetUsersStats(row?.id)).then(({ data, success }) => {
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
      <t-loading size="small" :loading="isLoading" show-overlay class="w-full">
        <t-descriptions :column="1" colon table-layout="auto">
          <t-descriptions-item label="账户ID">
              {{ withFallback(formData.accountId) }}
          </t-descriptions-item>
          <t-descriptions-item label="等级">
              {{ withFallback(formData.level) }}
          </t-descriptions-item>
          <t-descriptions-item label="经验值">
              {{ withFallback(formData.exp) }}
          </t-descriptions-item>
          <t-descriptions-item label="累计经验值">
              {{ withFallback(formData.totalExp) }}
          </t-descriptions-item>
          <t-descriptions-item label="登录天数">
              {{ withFallback(formData.loginDays) }}
          </t-descriptions-item>
          <t-descriptions-item label="连续登录天数">
              {{ withFallback(formData.continuousLoginDays) }}
          </t-descriptions-item>
          <t-descriptions-item label="发帖数">
              {{ withFallback(formData.postCount) }}
          </t-descriptions-item>
          <t-descriptions-item label="评论数">
              {{ withFallback(formData.commentCount) }}
          </t-descriptions-item>
          <t-descriptions-item label="获赞数">
              {{ withFallback(formData.likeCount) }}
          </t-descriptions-item>
          <t-descriptions-item label="关注数">
              {{ withFallback(formData.followCount) }}
          </t-descriptions-item>
          <t-descriptions-item label="粉丝数">
              {{ withFallback(formData.fansCount) }}
          </t-descriptions-item>
        </t-descriptions>
      </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>