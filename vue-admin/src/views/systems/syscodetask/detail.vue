<script lang="ts" setup>
import { useSysCodeTaskApi } from '@/api'
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
      withLoading(useSysCodeTaskApi().GetSysCodeTask(row?.id)).then(({ data, success }) => {
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
          <t-descriptions-item label="任务名称，如：系统模块代码生成">
              {{ withFallback(formData.taskName) }}
          </t-descriptions-item>
          <t-descriptions-item label="作者">
              {{ withFallback(formData.author) }}
          </t-descriptions-item>
          <t-descriptions-item label="代码输出目录">
              {{ withFallback(formData.outputDir) }}
          </t-descriptions-item>
          <t-descriptions-item label="数据库JDBC URL">
              {{ withFallback(formData.dbUrl) }}
          </t-descriptions-item>
          <t-descriptions-item label="数据库用户名">
              {{ withFallback(formData.dbUsername) }}
          </t-descriptions-item>
          <t-descriptions-item label="数据库密码（建议加密或留空）">
              {{ withFallback(formData.dbPassword) }}
          </t-descriptions-item>
          <t-descriptions-item label="数据库名">
              {{ withFallback(formData.databaseName) }}
          </t-descriptions-item>
          <t-descriptions-item label="生成后端：1-是，0-否">
              {{ withFallback(formData.addBackend) }}
          </t-descriptions-item>
          <t-descriptions-item label="生成后端：1-是，0-否">
              {{ withFallback(formData.addFrontend) }}
          </t-descriptions-item>
          <t-descriptions-item label="实际执行时间">
              {{ withFallback(formData.executedAt) }}
          </t-descriptions-item>
          <t-descriptions-item label="状态：0-待执行，1-成功，2-失败">
              {{ withFallback(formData.status) }}
          </t-descriptions-item>
          <t-descriptions-item label="备注">
              {{ withFallback(formData.remark) }}
          </t-descriptions-item>
        </t-descriptions>
      </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>