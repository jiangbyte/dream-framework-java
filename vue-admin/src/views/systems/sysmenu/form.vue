<script lang="ts" setup>
import { useSysMenuApi } from '@/api'
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
const keepAliveDictOptions = ref<TransformedOption<boolean>[]>([])
const visibleDictOptions = ref<TransformedOption<boolean>[]>([])
const pinedDictOptions = ref<TransformedOption<boolean>[]>([])
const withoutTabDictOptions = ref<TransformedOption<boolean>[]>([])

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
  await loadBooleanDict(DictConstants.SYS_BOOLEAN, keepAliveDictOptions)
  await loadBooleanDict(DictConstants.SYS_BOOLEAN, visibleDictOptions)
  await loadBooleanDict(DictConstants.SYS_BOOLEAN, pinedDictOptions)
  await loadBooleanDict(DictConstants.SYS_BOOLEAN, withoutTabDictOptions)

  // Data Load

  // Mode Set
  if (row?.id) {
    setEditMode()
    withLoading(useSysMenuApi().GetSysMenu(row?.id)).then(({ data, success }) => {
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
            ? useSysMenuApi().EditSysMenu
            : useSysMenuApi().AddSysMenu

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
        <t-form-item label="父级ID" name="pid">
          <t-input v-model="formData.pid" placeholder="请输入父级ID" />
        </t-form-item>
        <t-form-item label="菜单名称" name="name">
          <t-input v-model="formData.name" placeholder="请输入菜单名称" />
        </t-form-item>
        <t-form-item label="菜单路径" name="path">
          <t-input v-model="formData.path" placeholder="请输入菜单路径" />
        </t-form-item>
        <t-form-item label="组件路径" name="componentPath">
          <t-input v-model="formData.componentPath" placeholder="请输入组件路径" />
        </t-form-item>
        <t-form-item label="重定向路径" name="redirect">
          <t-input v-model="formData.redirect" placeholder="请输入重定向路径" />
        </t-form-item>
        <t-form-item label="外部链接地址" name="externalUrl">
          <t-input v-model="formData.externalUrl" placeholder="请输入外部链接地址" />
        </t-form-item>
        <t-form-item label="菜单类型：0-内部菜单 1-外链菜单 2-重定向菜单 3-iframe嵌入" name="menuType">
          <t-input-number v-model="formData.menuType" placeholder="请输入菜单类型：0-内部菜单 1-外链菜单 2-重定向菜单 3-iframe嵌入" />
        </t-form-item>
        <t-form-item label="打开方式：0-当前窗口 1-新窗口打开" name="openTarget">
          <t-input-number v-model="formData.openTarget" placeholder="请输入打开方式：0-当前窗口 1-新窗口打开" />
        </t-form-item>
        <t-form-item label="iframe属性" name="iframeAttrs">
          <t-input v-model="formData.iframeAttrs" placeholder="请输入iframe属性" />
        </t-form-item>
        <t-form-item label="菜单标题" name="title">
          <t-input v-model="formData.title" placeholder="请输入菜单标题" />
        </t-form-item>
        <t-form-item label="菜单图标" name="icon">
          <t-input v-model="formData.icon" placeholder="请输入菜单图标" />
        </t-form-item>
        <t-form-item label="排序" name="sort">
          <t-input-number v-model="formData.sort" placeholder="请输入排序" />
        </t-form-item>
        <t-form-item label="缓存" name="keepAlive">
          <t-radio-group v-model="formData.keepAlive" :default-value="formData.keepAlive">
            <t-radio v-for="(item, index) in keepAliveDictOptions" :key="index" :value="item.value">
              {{ item.text }}
            </t-radio>
          </t-radio-group>
        </t-form-item>
        <t-form-item label="可见" name="visible">
          <t-radio-group v-model="formData.visible" :default-value="formData.visible">
            <t-radio v-for="(item, index) in visibleDictOptions" :key="index" :value="item.value">
              {{ item.text }}
            </t-radio>
          </t-radio-group>
        </t-form-item>
        <t-form-item label="钉钉" name="pined">
          <t-radio-group v-model="formData.pined" :default-value="formData.pined">
            <t-radio v-for="(item, index) in pinedDictOptions" :key="index" :value="item.value">
              {{ item.text }}
            </t-radio>
          </t-radio-group>
        </t-form-item>
        <t-form-item label="无标签页" name="withoutTab">
          <t-radio-group v-model="formData.withoutTab" :default-value="formData.withoutTab">
            <t-radio v-for="(item, index) in withoutTabDictOptions" :key="index" :value="item.value">
              {{ item.text }}
            </t-radio>
          </t-radio-group>
        </t-form-item>
        <t-form-item label="头部参数" name="parameters">
          <t-input v-model="formData.parameters" placeholder="请输入头部参数" />
        </t-form-item>
        <t-form-item label="路由参数" name="extraParams">
          <t-input v-model="formData.extraParams" placeholder="请输入路由参数" />
        </t-form-item>
      </t-form>
    </t-loading>
  </t-drawer>
</template>

<style scoped>

</style>
