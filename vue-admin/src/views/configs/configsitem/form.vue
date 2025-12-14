<script lang="ts" setup>
import { useConfigsGroupApi, useConfigsItemApi } from '@/api'
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
const { isLoading: configGroupsIsLoading, withLoading: configGroupsWithLoading } = useLoading()

// ============================================== Boolean ==============================================
const { value: visible, setFalse: closeDrawer, setTrue: openDrawer } = useBoolean(false)
const { value: isEdit, setFalse: setAddMode, setTrue: setEditMode } = useBoolean(false)

// ============================================== Dict ==============================================

// ============================================== Data ==============================================
const formRef = ref()
const formData = reactive<DataFormType>({})
const groupOptions = ref([])

// ============================================== Function ==============================================
async function doOpen(row: any) {
  openDrawer()

  // Iint Data
  ResetFormData(formData)
  Object.assign(formData, PARTIAL_INIT)

  // Dict Load

  // Data Load
  configGroupsWithLoading(useConfigsGroupApi().ListsConfigsGroup()).then(({ data }) => {
    groupOptions.value = data
  })

  // Mode Set
  if (row?.id) {
    setEditMode()
    withLoading(useConfigsItemApi().GetConfigsItem(row?.id)).then(({ data, success }) => {
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
      ? useConfigsItemApi().EditConfigsItem
      : useConfigsItemApi().AddConfigsItem

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
        <t-form-item label="分组编码" name="groupCode">
          <t-select
            v-model="formData.groupCode"
            :options="groupOptions"
            :keys="{
              value: 'code',
              label: 'name',
            }"
            placeholder="请选择分组编码"
          />
        </t-form-item>
        <t-form-item label="配置项名称" name="name">
          <t-input v-model="formData.name" placeholder="请输入配置项名称" />
        </t-form-item>
        <t-form-item label="配置项代码" name="code">
          <t-input v-model="formData.code" placeholder="请输入配置项代码" />
        </t-form-item>
        <t-form-item label="配置值" name="value">
          <t-input v-model="formData.value" placeholder="请输入配置值" />
        </t-form-item>
        <!-- <t-form-item label="组件类型" name="componentType">
          <t-input v-model="formData.componentType" placeholder="请输入组件类型" />
        </t-form-item> -->
        <t-form-item label="配置描述" name="description">
          <t-input v-model="formData.description" placeholder="请输入配置描述" />
        </t-form-item>
        <t-form-item label="排序" name="sort">
          <t-input-number v-model="formData.sort" placeholder="请输入排序" />
        </t-form-item>
      </t-form>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
