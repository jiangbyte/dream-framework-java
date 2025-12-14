<script lang="ts" setup>
import { useAuthsGroupApi } from '@/api'
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
      withLoading(useAuthsGroupApi().GetAuthsGroup(row?.id)).then(({ data, success }) => {
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
          <t-descriptions-item label="父级组ID">
              {{ withFallback(formData.pid) }}
          </t-descriptions-item>
          <t-descriptions-item label="父级组路径">
              {{ withFallback(formData.pidPath) }}
          </t-descriptions-item>
          <t-descriptions-item label="用户组名称">
              {{ withFallback(formData.name) }}
          </t-descriptions-item>
          <t-descriptions-item label="用户组编码">
              {{ withFallback(formData.code) }}
          </t-descriptions-item>
          <t-descriptions-item label="用户组描述">
              {{ withFallback(formData.description) }}
          </t-descriptions-item>
          <t-descriptions-item label="排序号，数字越小越靠前">
              {{ withFallback(formData.sort) }}
          </t-descriptions-item>
          <t-descriptions-item label="管理员ID">
              {{ withFallback(formData.adminId) }}
          </t-descriptions-item>
          <t-descriptions-item label="最大用户数量限制">
              {{ withFallback(formData.maxUserCount) }}
          </t-descriptions-item>
        </t-descriptions>
      </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>