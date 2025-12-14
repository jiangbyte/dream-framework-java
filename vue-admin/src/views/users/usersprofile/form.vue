<script lang="ts" setup>
import { useUsersProfileApi } from '@/api'
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
const showBirthdayDictOptions = ref<TransformedOption<boolean>[]>([])
const showLocationDictOptions = ref<TransformedOption<boolean>[]>([])

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
  await loadBooleanDict(DictConstants.SYS_BOOLEAN, showBirthdayDictOptions)
  await loadBooleanDict(DictConstants.SYS_BOOLEAN, showLocationDictOptions)

  // Data Load

  // Mode Set
  if (row?.id) {
    setEditMode()
    withLoading(useUsersProfileApi().GetUsersProfile(row?.id)).then(({ data, success }) => {
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
            ? useUsersProfileApi().EditUsersProfile
            : useUsersProfileApi().AddUsersProfile

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
        <t-form-item label="账户ID" name="accountId">
          <t-input v-model="formData.accountId" placeholder="请输入账户ID" />
        </t-form-item>
        <t-form-item label="真实姓名" name="realName">
          <t-input v-model="formData.realName" placeholder="请输入真实姓名" />
        </t-form-item>
        <t-form-item label="学校" name="school">
          <t-input v-model="formData.school" placeholder="请输入学校" />
        </t-form-item>
        <t-form-item label="专业" name="major">
          <t-input v-model="formData.major" placeholder="请输入专业" />
        </t-form-item>
        <t-form-item label="学号" name="studentId">
          <t-input v-model="formData.studentId" placeholder="请输入学号" />
        </t-form-item>
        <t-form-item label="公司" name="company">
          <t-input v-model="formData.company" placeholder="请输入公司" />
        </t-form-item>
        <t-form-item label="职位" name="jobTitle">
          <t-input v-model="formData.jobTitle" placeholder="请输入职位" />
        </t-form-item>
        <t-form-item label="行业" name="industry">
          <t-input v-model="formData.industry" placeholder="请输入行业" />
        </t-form-item>
        <t-form-item label="国家" name="country">
          <t-input v-model="formData.country" placeholder="请输入国家" />
        </t-form-item>
        <t-form-item label="省份" name="province">
          <t-input v-model="formData.province" placeholder="请输入省份" />
        </t-form-item>
        <t-form-item label="城市" name="city">
          <t-input v-model="formData.city" placeholder="请输入城市" />
        </t-form-item>
        <t-form-item label="详细地址" name="location">
          <t-input v-model="formData.location" placeholder="请输入详细地址" />
        </t-form-item>
        <t-form-item label="QQ" name="qq">
          <t-input v-model="formData.qq" placeholder="请输入QQ" />
        </t-form-item>
        <t-form-item label="微信" name="wechat">
          <t-input v-model="formData.wechat" placeholder="请输入微信" />
        </t-form-item>
        <t-form-item label="是否显示生日" name="showBirthday">
          <t-radio-group v-model="formData.showBirthday" :default-value="formData.showBirthday">
            <t-radio v-for="(item, index) in showBirthdayDictOptions" :key="index" :value="item.value">
              {{ item.text }}
            </t-radio>
          </t-radio-group>
        </t-form-item>
        <t-form-item label="是否显示地理位置" name="showLocation">
          <t-radio-group v-model="formData.showLocation" :default-value="formData.showLocation">
            <t-radio v-for="(item, index) in showLocationDictOptions" :key="index" :value="item.value">
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
