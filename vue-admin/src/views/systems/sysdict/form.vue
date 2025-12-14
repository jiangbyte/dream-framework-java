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
const { isLoading: listTypeOptionsLoading, withLoading: withListTypeOptionsLoading }
  = useLoading()

// ============================================== Boolean ==============================================
const { value: visible, setFalse: closeDrawer, setTrue: openDrawer } = useBoolean(false)
const { value: isEdit, setFalse: setAddMode, setTrue: setEditMode } = useBoolean(false)

// ============================================== Dict ==============================================

// ============================================== Data ==============================================
const formRef = ref()
const formData = reactive<DataFormType>({})
const typeOptions = ref([])

// ============================================== Function ==============================================
async function doOpen(row: any, type: string) {
  openDrawer()

  // Iint Data
  ResetFormData(formData)
  Object.assign(formData, PARTIAL_INIT)
  formData.dictType = type
  if (type) {
    const name = (typeOptions.value as TypeOption[]).find(item => item.value === type)?.text
    formData.typeLabel = name
  }

  // Dict Load

  // Data Load
  withListTypeOptionsLoading(useSysDictApi().ListTypeOptions('')).then(({ data }) => {
    typeOptions.value = data
  })

  // Mode Set
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

  const validate = await formRef.value.validate()
  if (validate === true) {
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

function changeType(value: any) {
  const name = (typeOptions.value as TypeOption[]).find(item => item.value === value)?.text
  formData.typeLabel = name
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
        <t-form-item label="字典类型编码" name="dictType">
          <t-tree-select
            v-model="formData.dictType"
            :keys="{ value: 'value', label: 'text' }"
            :data="typeOptions"
            placeholder="请选择字典类型编码"
            @change="changeType"
          />
        </t-form-item>
        <t-form-item label="字典值" name="dictValue">
          <t-input v-model="formData.dictValue" placeholder="请输入字典值" />
        </t-form-item>
        <t-form-item label="字典标签" name="dictLabel">
          <t-input v-model="formData.dictLabel" placeholder="请输入字典标签" />
        </t-form-item>
        <t-form-item label="排序号" name="sort">
          <t-input-number v-model="formData.sort" placeholder="请输入排序号" />
        </t-form-item>
      </t-form>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
