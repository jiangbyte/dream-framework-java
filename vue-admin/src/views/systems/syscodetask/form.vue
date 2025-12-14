<script lang="ts" setup>
import { useSysCodeTaskApi } from '@/api'
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
    withLoading(useSysCodeTaskApi().GetSysCodeTask(row?.id)).then(({ data, success }) => {
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
      ? useSysCodeTaskApi().EditSysCodeTask
      : useSysCodeTaskApi().AddSysCodeTask

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
        <t-form-item label="任务名称，如：系统模块代码生成" name="taskName">
          <t-input v-model="formData.taskName" placeholder="请输入任务名称，如：系统模块代码生成" />
        </t-form-item>
        <t-form-item label="作者" name="author">
          <t-input v-model="formData.author" placeholder="请输入作者" />
        </t-form-item>
        <t-form-item label="代码输出目录" name="outputDir">
          <t-input v-model="formData.outputDir" placeholder="请输入代码输出目录" />
        </t-form-item>
        <t-form-item label="数据库JDBC URL" name="dbUrl">
          <t-input v-model="formData.dbUrl" placeholder="请输入数据库JDBC URL" />
        </t-form-item>
        <t-form-item label="数据库用户名" name="dbUsername">
          <t-input v-model="formData.dbUsername" placeholder="请输入数据库用户名" />
        </t-form-item>
        <t-form-item label="数据库密码（建议加密或留空）" name="dbPassword">
          <t-input v-model="formData.dbPassword" placeholder="请输入数据库密码（建议加密或留空）" />
        </t-form-item>
        <t-form-item label="数据库名" name="databaseName">
          <t-input v-model="formData.databaseName" placeholder="请输入数据库名" />
        </t-form-item>
        <t-form-item label="生成后端：1-是，0-否" name="addBackend">
          <t-input-number v-model="formData.addBackend" placeholder="请输入生成后端：1-是，0-否" />
        </t-form-item>
        <t-form-item label="生成后端：1-是，0-否" name="addFrontend">
          <t-input-number v-model="formData.addFrontend" placeholder="请输入生成后端：1-是，0-否" />
        </t-form-item>
        <t-form-item label="实际执行时间" name="executedAt">
          <t-input v-model="formData.executedAt" placeholder="请输入实际执行时间" />
        </t-form-item>
        <t-form-item label="状态：0-待执行，1-成功，2-失败" name="status">
          <t-input-number v-model="formData.status" placeholder="请输入状态：0-待执行，1-成功，2-失败" />
        </t-form-item>
        <t-form-item label="备注" name="remark">
          <t-input v-model="formData.remark" placeholder="请输入备注" />
        </t-form-item>
      </t-form>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
