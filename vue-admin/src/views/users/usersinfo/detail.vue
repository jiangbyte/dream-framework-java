<script lang="ts" setup>
import { useUsersInfoApi } from '@/api'
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
    withLoading(useUsersInfoApi().GetUsersInfo(row?.id)).then(({ data, success }) => {
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
        <t-descriptions-item label="昵称">
          {{ withFallback(formData.nickname) }}
        </t-descriptions-item>
        <t-descriptions-item label="头像">
          {{ withFallback(formData.avatar) }}
        </t-descriptions-item>
        <t-descriptions-item label="性别：0-未知 1-男 2-女">
          {{ withFallback(formData.gender) }}
        </t-descriptions-item>
        <t-descriptions-item label="生日">
          {{ withFallback(formData.birthday) }}
        </t-descriptions-item>
        <t-descriptions-item label="个性签名">
          {{ withFallback(formData.signature) }}
        </t-descriptions-item>
        <t-descriptions-item label="个人背景图片">
          {{ withFallback(formData.background) }}
        </t-descriptions-item>
        <t-descriptions-item label="兴趣标签">
          {{ withFallback(formData.interests) }}
        </t-descriptions-item>
        <t-descriptions-item label="个人网站">
          {{ withFallback(formData.website) }}
        </t-descriptions-item>
        <t-descriptions-item label="GitHub">
          {{ withFallback(formData.github) }}
        </t-descriptions-item>
        <t-descriptions-item label="GitTee">
          {{ withFallback(formData.gitee) }}
        </t-descriptions-item>
        <t-descriptions-item label="博客">
          {{ withFallback(formData.blog) }}
        </t-descriptions-item>
      </t-descriptions>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
