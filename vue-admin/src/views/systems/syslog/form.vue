<script lang="ts" setup>
import { useSysLogApi } from '@/api'
import { useBoolean, useLoading } from '@/hooks'
import { ResetFormData } from '@/utils'
import { FORM_RULES, PARTIAL_INIT } from './constant'

// ============================================== Props ==============================================
const props = defineProps<{
  formName?: string
}>()

// ============================================== emit ==============================================
const emit = defineEmits(['close', 'submit'])

// ============================================== Loading ==============================================
const { isLoading, withLoading } = useLoading()

// ============================================== Boolean ==============================================
const { value: visible, setFalse: closeDrawer, setTrue: openDrawer } = useBoolean(false)
const { value: isEdit, setFalse: setAddMode, setTrue: setEditMode } = useBoolean(false)

// ============================================== Dict ==============================================

// ============================================== Data ==============================================
const formRef = ref()
const formData = reactive<DataFormType>({})

// ============================================== Function ==============================================
async function doOpen(row: any) {
  openDrawer()

  // Iint Data
  ResetFormData(formData)
  Object.assign(formData, PARTIAL_INIT)

  // Dict Load

  // Data Load

  // Mode Set
  if (row?.id) {
    setEditMode()
    withLoading(useSysLogApi().GetSysLog(row?.id)).then(({ data, success }) => {
      if (success) {
        Object.assign(formData, data)
      }
      else {
        closeDrawer()
      }
    })
  }
  else {
    setAddMode()
  }
}

function doClose() {
  ResetFormData(formData)
  closeDrawer()
  emit('close')
}

async function doSubmit() {
  if (!formRef.value)
    return

  const validate = await formRef.value.validate()
  if (validate === true) {
    const api = isEdit.value
      ? useSysLogApi().EditSysLog
      : useSysLogApi().AddSysLog

    withLoading(api(formData)).then(({ success }) => {
      if (success) {
        closeDrawer()
        emit('submit')
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
    :close-on-overlay-click="false"
    :confirm-btn="{ disabled: isLoading }"
    size="large"
    destroy-on-close
    @close="doClose"
    @confirm="doSubmit"
  >
    <template #header>
      {{ isEdit ? `编辑${props.formName}` : `新增${props.formName}` }}
    </template>
    <t-loading
      size="small"
      :loading="isLoading"
      show-overlay
      class="w-full"
    >
      <t-form
        ref="formRef"
        :data="formData"
        scroll-to-first-error="smooth"
        label-align="left"
        :rules="FORM_RULES"
      >
        <t-form-item label="用户ID" name="userId">
          <t-input v-model="formData.userId" placeholder="请输入用户ID" />
        </t-form-item>
        <t-form-item label="操作类型" name="operation">
          <t-input v-model="formData.operation" placeholder="请输入操作类型" />
        </t-form-item>
        <t-form-item label="请求方法" name="method">
          <t-input v-model="formData.method" placeholder="请输入请求方法" />
        </t-form-item>
        <t-form-item label="请求参数" name="params">
          <t-input v-model="formData.params" placeholder="请输入请求参数" />
        </t-form-item>
        <t-form-item label="IP地址" name="ip">
          <t-input v-model="formData.ip" placeholder="请输入IP地址" />
        </t-form-item>
        <t-form-item label="操作时间" name="operationTime">
          <t-input v-model="formData.operationTime" placeholder="请输入操作时间" />
        </t-form-item>
        <t-form-item label="日志分类" name="category">
          <t-input v-model="formData.category" placeholder="请输入日志分类" />
        </t-form-item>
        <t-form-item label="操作模块" name="module">
          <t-input v-model="formData.module" placeholder="请输入操作模块" />
        </t-form-item>
        <t-form-item label="操作描述" name="description">
          <t-input v-model="formData.description" placeholder="请输入操作描述" />
        </t-form-item>
        <t-form-item label="操作状态" name="status">
          <t-input v-model="formData.status" placeholder="请输入操作状态" />
        </t-form-item>
        <t-form-item label="日志消息" name="message">
          <t-input v-model="formData.message" placeholder="请输入日志消息" />
        </t-form-item>
      </t-form>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
