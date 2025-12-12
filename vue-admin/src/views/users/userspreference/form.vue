<script lang="ts" setup>
import { useUsersPreferenceApi } from '@/api'
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
  ResetFormData(formData)
  Object.assign(formData, PARTIAL_INIT)

  if (row?.id) {
    setEditMode()
    withLoading(useUsersPreferenceApi().GetUsersPreference(row?.id)).then(({ data, success }) => {
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

  const validateResult = await formRef.value.validate()
  if (validateResult === true) {
    const api = isEdit.value
      ? useUsersPreferenceApi().EditUsersPreference
      : useUsersPreferenceApi().AddUsersPreference

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
        <t-form-item label="账户ID" name="accountId">
          <t-input v-model="formData.accountId" placeholder="请输入账户ID" />
        </t-form-item>
        <t-form-item label="主题" name="theme">
          <t-input v-model="formData.theme" placeholder="请输入主题" />
        </t-form-item>
        <t-form-item label="系统语言" name="language">
          <t-input v-model="formData.language" placeholder="请输入系统语言" />
        </t-form-item>
        <t-form-item label="邮件通知" name="emailNotifications">
          <t-input v-model="formData.emailNotifications" placeholder="请输入邮件通知" />
        </t-form-item>
        <t-form-item label="推送通知" name="pushNotifications">
          <t-input v-model="formData.pushNotifications" placeholder="请输入推送通知" />
        </t-form-item>
        <t-form-item label="允许私信" name="allowDirectMessage">
          <t-input v-model="formData.allowDirectMessage" placeholder="请输入允许私信" />
        </t-form-item>
      </t-form>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
