<script lang="ts" setup>
import { use${entity}Api } from '@/api'
import { useBoolean, useLoading } from '@/hooks'
import { useBooleanDict, useNumberDict, useStringDict } from '@/composables'
import { DictConstants } from '@/constants'
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
    withLoading(use${entity}Api().Get${entity}(row?.id)).then(({ data, success }) => {
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
            ? use${entity}Api().Edit${entity}
            : use${entity}Api().Add${entity}

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
    <#noparse>
    <template #header>
      {{ isEdit ? `编辑${props.formName}` : `新增${props.formName}` }}
    </template>
    </#noparse>
    <t-loading size="small" :loading="isLoading" show-overlay class="w-full">
      <t-form ref="formRef" :data="formData" scroll-to-first-error="smooth" label-align="left" :rules="FORM_RULES">
        <#list table.fields as field>
        <#if !["id", "isDeleted", "deletedAt", "deletedBy", "createdAt", "createdBy", "updatedAt", "updatedBy"]?seq_contains(field.propertyName)>
        <t-form-item label="${field.comment}" name="${field.propertyName}">
          <t-input v-model="formData.${field.propertyName}" placeholder="请输入${field.comment}" />
        </t-form-item>
        </#if>
        </#list>
      </t-form>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
