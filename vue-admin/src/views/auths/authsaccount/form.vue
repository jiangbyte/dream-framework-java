<script lang="ts" setup>
import { useAuthsAccountApi } from '@/api'
import { useBoolean, useLoading } from '@/hooks'
import { ResetFormData } from '@/utils'
import { FORM_RULES, PARTIAL_INIT } from './constant'
import { DictConstants } from '@/constants'
import { loadBooleanDict, loadNumberDict, loadStringDict } from '@/composables'
import type { TransformedOption } from '@/composables'

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
    withLoading(useAuthsAccountApi().GetAuthsAccount(row?.id)).then(({ data, success }) => {
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
            ? useAuthsAccountApi().EditAuthsAccount
            : useAuthsAccountApi().AddAuthsAccount

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
    <t-loading size="small" :loading="isLoading" show-overlay class="w-full">
      <t-form ref="formRef" :data="formData" scroll-to-first-error="smooth" label-align="left" :rules="FORM_RULES">
        <t-form-item label="用户名，登录标识" name="username">
          <t-input v-model="formData.username" placeholder="请输入用户名，登录标识" />
        </t-form-item>
        <t-form-item label="加密后的密码" name="password">
          <t-input v-model="formData.password" placeholder="请输入加密后的密码" />
        </t-form-item>
        <t-form-item label="邮箱地址" name="email">
          <t-input v-model="formData.email" placeholder="请输入邮箱地址" />
        </t-form-item>
        <t-form-item label="手机号码" name="telephone">
          <t-input v-model="formData.telephone" placeholder="请输入手机号码" />
        </t-form-item>
        <t-form-item label="账户状态：0-正常, 1-锁定, 2-禁用" name="status">
          <t-input-number v-model="formData.status" placeholder="请输入账户状态：0-正常, 1-锁定, 2-禁用" />
        </t-form-item>
        <t-form-item label="密码强度等级：0-3" name="passwordStrength">
          <t-input-number v-model="formData.passwordStrength" placeholder="请输入密码强度等级：0-3" />
        </t-form-item>
        <t-form-item label="最后修改密码的时间" name="lastPasswordChange">
          <t-input v-model="formData.lastPasswordChange" placeholder="请输入最后修改密码的时间" />
        </t-form-item>
        <t-form-item label="最后登录时间" name="lastLoginTime">
          <t-input v-model="formData.lastLoginTime" placeholder="请输入最后登录时间" />
        </t-form-item>
        <t-form-item label="最后登录IP地址" name="lastLoginIp">
          <t-input v-model="formData.lastLoginIp" placeholder="请输入最后登录IP地址" />
        </t-form-item>
        <t-form-item label="登录次数统计" name="loginCount">
          <t-input-number v-model="formData.loginCount" placeholder="请输入登录次数统计" />
        </t-form-item>
      </t-form>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
