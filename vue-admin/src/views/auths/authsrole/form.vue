<script lang="ts" setup>
import { useAuthsRoleApi } from '@/api'
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
const { value: isAssignCustom, setFalse: setNotAssignCustom, setTrue: setIsAssignCustom } = useBoolean(false)

// ============================================== Dict ==============================================
const dataScopeDictOptions = ref<TransformedOption<string>[]>([])

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
  await loadStringDict(DictConstants.SYS_DATA_SCOPE, dataScopeDictOptions)

  // Data Load

  // Mode Set
  if (row?.id) {
    setEditMode()
    withLoading(useAuthsRoleApi().GetAuthsRole(row?.id)).then(({ data, success }) => {
      if (success) {
        Object.assign(formData, data)
        if (formData.dataScope === 'CUSTOM') {
          setIsAssignCustom()
        }
        else {
          setNotAssignCustom()
        }
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
            ? useAuthsRoleApi().EditAuthsRole
            : useAuthsRoleApi().AddAuthsRole

      if (formData.dataScope !== 'CUSTOM') {
        formData.assignGroupIds = []
      }
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

function dataScopeChange(value: any) {
  if (value === 'CUSTOM') {
    setIsAssignCustom()
  }
  else {
    setNotAssignCustom()
  }
}
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
        <t-form-item label="角色名称" name="name">
          <t-input v-model="formData.name" placeholder="请输入角色名称" />
        </t-form-item>
        <t-form-item label="角色编码" name="code">
          <t-input v-model="formData.code" placeholder="请输入角色编码" />
        </t-form-item>
        <t-form-item label="数据权限范围" name="dataScope">
          <t-select
            v-model="formData.dataScope"
            :options="dataScopeDictOptions"
            :keys="{
              label: 'text',
            }"
            placeholder="请选择数据权限范围"
            @change="dataScopeChange"
          />
        </t-form-item>
        <t-form-item label="角色描述" name="description">
          <t-input v-model="formData.description" placeholder="请输入角色描述" />
        </t-form-item>
        <t-form-item v-if="isAssignCustom" label="分配的用户组列表" name="assignGroupIds">
          <t-input v-model="formData.assignGroupIds" placeholder="请输入分配的用户组ID列表" />
        </t-form-item>
      </t-form>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
