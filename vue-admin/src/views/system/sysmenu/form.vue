<script lang="ts" setup>
import { useSysDictApi, useSysMenuApi } from '@/api'
import { useBoolean, useLoading } from '@/hooks'
import { ResetFormData } from '@/utils'
import { manifest } from 'tdesign-icons-vue-next'

const props = defineProps<{
  formName?: string
}>()

const emit = defineEmits(['close', 'submit'])

const { isLoading, withLoading } = useLoading()
const { value: visible, setFalse: closeDrawer, setTrue: openDrawer } = useBoolean(false)
const { value: isEdit, setFalse: setAddMode, setTrue: setEditMode } = useBoolean(false)
const { isLoading: parentMenuOptionsLoading, withLoading: withParentMenuOptionsLoading } = useLoading()
const formData = reactive<DataFormType>({})
const booleanTypeOptions = ref<TypeOption[]>([])
const menuTypeOptions = ref<TypeOption[]>([])
const menuOpenMethodOptions = ref<TypeOption[]>([])
const menuListTreeOptions = ref<any[]>([{
  id: '0',
  title: '无',
}])
async function doOpen(row: any) {
  openDrawer()
  ResetFormData(formData)

  if (row?.id) {
    setEditMode()
    const { data, success } = await withLoading(useSysMenuApi().GetSysMenu(row?.id))
    if (success) {
      Object.assign(formData, data)
    }
    else {
      closeDrawer()
    }
  }
  else {
    setAddMode()
  }

  useSysDictApi().ListOptionsByType('SYS_BOOLEAN').then(
    ({ data }) => {
      booleanTypeOptions.value = data.map((item: TypeOption) => ({
        ...item,
        value: item.value === 'true', // 直接比较转换为 boolean
      }))
    },
  )
  useSysDictApi().ListOptionsByType('SYS_MENU').then(
    ({ data }) => {
      menuTypeOptions.value = data.map((item: TypeOption) => ({
        ...item,
        value: Number(item.value),
      }))
    },
  )
  useSysDictApi().ListOptionsByType('SYS_OPEN_METHOD').then(
    ({ data }) => {
      menuOpenMethodOptions.value = data.map((item: TypeOption) => ({
        ...item,
        value: Number(item.value),
      }))
    },
  )

  withParentMenuOptionsLoading(useSysMenuApi().GetSysMenuListTreeWithAccountID('')).then(
    ({ data }) => {
      menuListTreeOptions.value.push(...data)
    },
  )
}

function doClose() {
  ResetFormData(formData)
  closeDrawer()
  emit('close')
}

async function doSubmit() {
  const api = isEdit.value ? useSysMenuApi().EditSysMenu : useSysMenuApi().AddSysMenu

  const { success } = await withLoading(api(formData))
  if (success) {
    closeDrawer()
    emit('submit')
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
      <t-form :data="formData" label-align="left">
        <t-form-item label="父级ID" name="pid">
          <t-tree-select
            v-model="formData.pid"
            :keys="{ value: 'id', label: 'title' }"
            :data="menuListTreeOptions"
            placeholder="请输入父级"
          />
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
        <t-form-item
          label="菜单类型"
          name="menuType"
        >
          <t-radio-group v-model="formData.menuType" :default-value="formData.menuType">
            <t-radio v-for="item in menuTypeOptions" :key="item.value" :value="item.value">
              {{ item.text }}
            </t-radio>
          </t-radio-group>
        </t-form-item>
        <t-form-item label="打开方式" name="openTarget">
          <t-radio-group v-model="formData.openTarget" :default-value="formData.openTarget">
            <t-radio v-for="item in menuOpenMethodOptions" :key="item.value" :value="item.value">
              {{ item.text }}
            </t-radio>
          </t-radio-group>
        </t-form-item>
        <t-form-item label="iframe属性" name="iframeAttrs">
          <t-input v-model="formData.iframeAttrs" placeholder="请输入iframe属性" />
        </t-form-item>
        <t-form-item label="菜单标题" name="title">
          <t-input v-model="formData.title" placeholder="请输入菜单标题" />
        </t-form-item>
        <t-form-item label="菜单图标" name="icon">
          <!-- <t-select
            v-model="formData.icon"
            placeholder="请输入菜单图标"
            :style="{ width: '400px' }"
            :popup-props="{ overlayInnerStyle: { width: '400px' } }"
          >
            <t-option
              v-for="item in manifest"
              :key="item.stem"
              :value="item.stem"
              class="overlay-options"
            >
              <div>
                <t-icon :name="item.stem" />
              </div>
            </t-option>
            <template #valueDisplay>
              <t-icon :name="formData.icon" :style="{ marginRight: '8px' }" />
              {{ formData.icon }}
            </template>
          </t-select> -->
          <t-select
            v-model="formData.icon"
            placeholder="请选择菜单图标"
            :style="{ width: '400px' }"
            :popup-props="{ overlayInnerStyle: { width: '400px' } }"
          >
            <t-option
              v-for="item in manifest"
              :key="item.stem"
              :value="item.stem"
            >
              <div class="icon-option-content">
                <t-icon :name="item.stem" size="18" />
                <span class="icon-name">{{ item.stem }}</span>
              </div>
            </t-option>

            <template #valueDisplay="{ value }">
              <div class="selected-value">
                <t-icon :name="value" size="18" />
                <span>{{ value }}</span>
              </div>
            </template>
          </t-select>
        </t-form-item>
        <t-form-item label="排序" name="sort">
          <t-input-number v-model="formData.sort" />
        </t-form-item>
        <t-form-item label="缓存" name="keepAlive">
          <t-radio-group v-model="formData.keepAlive" :default-value="formData.keepAlive">
            <t-radio v-for="item in booleanTypeOptions" :key="item.value" :value="item.value">
              {{ item.text }}
            </t-radio>
          </t-radio-group>
        </t-form-item>
        <t-form-item label="可见" name="visible">
          <t-radio-group v-model="formData.visible" :default-value="formData.visible">
            <t-radio v-for="item in booleanTypeOptions" :key="item.value" :value="item.value">
              {{ item.text }}
            </t-radio>
          </t-radio-group>
        </t-form-item>
        <t-form-item label="钉钉" name="pined">
          <t-radio-group v-model="formData.pined" :default-value="formData.pined">
            <t-radio v-for="item in booleanTypeOptions" :key="item.value" :value="item.value">
              {{ item.text }}
            </t-radio>
          </t-radio-group>
        </t-form-item>
        <t-form-item label="无标签页" name="withoutTab">
          <t-radio-group v-model="formData.withoutTab" :default-value="formData.withoutTab">
            <t-radio v-for="item in booleanTypeOptions" :key="item.value" :value="item.value">
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
.icon-option {
  padding: 6px 12px;
}

.icon-option-content {
  display: flex;
  align-items: center;
  gap: 10px;
}

.icon-name {
  font-size: 14px;
  color: var(--td-text-color-primary);
}

.selected-value {
  display: flex;
  align-items: center;
  gap: 8px;
}
</style>
