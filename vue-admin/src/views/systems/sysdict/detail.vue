<script lang="ts" setup>
import { useSysDictApi } from '@/api'
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
      withLoading(useSysDictApi().GetSysDict(row?.id)).then(({ data, success }) => {
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
          <t-descriptions-item label="字典类型">
              {{ withFallback(formData.dictType) }}
          </t-descriptions-item>
          <t-descriptions-item label="类型标签">
              {{ withFallback(formData.typeLabel) }}
          </t-descriptions-item>
          <t-descriptions-item label="字典值">
              {{ withFallback(formData.dictValue) }}
          </t-descriptions-item>
          <t-descriptions-item label="字典标签">
              {{ withFallback(formData.dictLabel) }}
          </t-descriptions-item>
          <t-descriptions-item label="排序号">
              {{ withFallback(formData.sort) }}
          </t-descriptions-item>
        </t-descriptions>
      </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>