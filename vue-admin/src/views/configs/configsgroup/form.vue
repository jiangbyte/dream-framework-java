<script lang="ts" setup>
import { useConfigsGroupApi } from '@/api'
import { useBoolean, useLoading } from '@/hooks'
import { ResetFormData } from '@/utils'
import { FORM_RULES, PARTIAL_INIT } from './constant'
import { DictConstants } from '@/constants'
import { loadBooleanDict } from '@/composables'
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
const isSystemDictOptions = ref<TransformedOption<boolean>[]>([])

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
  await loadBooleanDict(DictConstants.SYS_BOOLEAN, isSystemDictOptions)

  // Data Load

  // Mode Set
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

  const validate = await formRef.value.validate()
  if (validate === true) {
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
          <t-input-number v-model="formData.sort" placeholder="请输入排序" />
        </t-form-item>
        <t-form-item label="是否系统分组" name="isSystem">
          <t-radio-group v-model="formData.isSystem" :default-value="formData.isSystem">
            <t-radio v-for="(item, index) in isSystemDictOptions" :key="index" :value="item.value">
              {{ item.text }}
            </t-radio>
          </t-radio-group>
        </t-form-item>
      </t-form>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
