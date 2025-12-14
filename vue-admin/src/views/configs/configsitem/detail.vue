<script lang="ts" setup>
import { useConfigsItemApi } from '@/api'
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
    withLoading(useConfigsItemApi().GetConfigsItem(row?.id)).then(({ data, success }) => {
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
        <t-descriptions-item label="分组编码">
          {{ withFallback(formData.groupCode) }}
        </t-descriptions-item>
        <t-descriptions-item label="配置项名称">
          {{ withFallback(formData.name) }}
        </t-descriptions-item>
        <t-descriptions-item label="配置项代码">
          {{ withFallback(formData.code) }}
        </t-descriptions-item>
        <t-descriptions-item label="配置值">
          {{ withFallback(formData.value) }}
        </t-descriptions-item>
        <t-descriptions-item label="组件类型">
          {{ withFallback(formData.componentType) }}
        </t-descriptions-item>
        <t-descriptions-item label="配置描述">
          {{ withFallback(formData.description) }}
        </t-descriptions-item>
        <t-descriptions-item label="排序">
          {{ withFallback(formData.sort) }}
        </t-descriptions-item>
      </t-descriptions>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
