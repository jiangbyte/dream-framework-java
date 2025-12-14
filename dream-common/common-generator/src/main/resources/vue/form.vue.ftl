<#include "../common/field-helpers.ftl">
<script lang="ts" setup>
import { use${entity}Api } from '@/api'
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
<#list table.fields as field>
<#if shouldRenderField(field) && isBooleanField(field)>
const ${field.propertyName}DictOptions = ref<TransformedOption<boolean>[]>([])
</#if>
</#list>

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
  <#list table.fields as field>
  <#if shouldRenderField(field) && isBooleanField(field)>
  await loadBooleanDict(DictConstants.SYS_BOOLEAN, ${field.propertyName}DictOptions)
  </#if>
  </#list>

  // Data Load

  // Mode Set
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

  const validate = await formRef.value.validate()
  if (validate === true) {
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
        <#if shouldRenderField1(field)>
<#if isNumberField(field)>
        <t-form-item label="${field.comment}" name="${field.propertyName}">
          <t-input-number v-model="formData.${field.propertyName}" placeholder="请输入${field.comment}" />
        </t-form-item>
<#elseif isBooleanField(field)>
        <t-form-item label="${field.comment}" name="${field.propertyName}">
          <t-radio-group v-model="formData.${field.propertyName}" :default-value="formData.${field.propertyName}">
            <t-radio v-for="(item, index) in ${field.propertyName}DictOptions" :key="index" :value="item.value">
              {{ item.text }}
            </t-radio>
          </t-radio-group>
        </t-form-item>
<#else>
        <t-form-item label="${field.comment}" name="${field.propertyName}">
          <t-input v-model="formData.${field.propertyName}" placeholder="请输入${field.comment}" />
        </t-form-item>
</#if>
        </#if>
        </#list>
      </t-form>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
