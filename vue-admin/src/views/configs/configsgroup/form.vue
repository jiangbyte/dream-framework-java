<script lang="ts" setup>
import { useConfigsGroupApi } from '@/api'
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
    withLoading(useConfigsGroupApi().GetConfigsGroup(row?.id)).then(({ data, success }) => {
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
      ? useConfigsGroupApi().EditConfigsGroup
      : useConfigsGroupApi().AddConfigsGroup

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
        <t-form-item label="分组名称" name="name">
          <t-input v-model="formData.name" placeholder="请输入分组名称" />
        </t-form-item>
        <t-form-item label="分组代码" name="code">
          <t-input v-model="formData.code" placeholder="请输入分组代码" />
        </t-form-item>
        <t-form-item label="分组描述" name="description">
          <t-input v-model="formData.description" placeholder="请输入分组描述" />
        </t-form-item>
        <t-form-item label="排序" name="sort">
          <t-input v-model="formData.sort" placeholder="请输入排序" />
        </t-form-item>
        <t-form-item label="是否系统分组" name="isSystem">
          <t-input v-model="formData.isSystem" placeholder="请输入是否系统分组" />
        </t-form-item>
      </t-form>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
