<script lang="ts" setup>
import { useSysDictApi } from '@/api'
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
    withLoading(useSysDictApi().GetSysDict(row?.id)).then(({ data, success }) => {
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
      ? useSysDictApi().EditSysDict
      : useSysDictApi().AddSysDict

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
        <t-form-item label="字典类型" name="dictType">
          <t-input v-model="formData.dictType" placeholder="请输入字典类型" />
        </t-form-item>
        <t-form-item label="类型标签" name="typeLabel">
          <t-input v-model="formData.typeLabel" placeholder="请输入类型标签" />
        </t-form-item>
        <t-form-item label="字典值" name="dictValue">
          <t-input v-model="formData.dictValue" placeholder="请输入字典值" />
        </t-form-item>
        <t-form-item label="字典标签" name="dictLabel">
          <t-input v-model="formData.dictLabel" placeholder="请输入字典标签" />
        </t-form-item>
        <t-form-item label="排序号" name="sort">
          <t-input v-model="formData.sort" placeholder="请输入排序号" />
        </t-form-item>
      </t-form>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
