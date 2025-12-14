<script lang="ts" setup>
import { useAuthsAccountApi, useAuthsGroupApi } from '@/api'
import { COLUMNS, SortOptions } from './constant'
import { SortTypeOptions } from '@/constants'
import { toIDArray } from '@/utils'
import { useLoading } from '@/hooks'
import Form from './form.vue'
import Detail from './detail.vue'

// ============================================== Data ==============================================
const pageData = ref({
  current: 1,
  pages: 1,
  records: [],
  size: 20,
  total: 0,
})

const pageParams = reactive({
  current: 1,
  pageSize: 20,
  sortField: '',
  sortOrder: '',
  keyword: '',
  groupId: '',
})

const formRef = ref()
const formName = '核心账户'
const detailRef = ref()
const selectedRowKeys = ref([])
const columnControllerVisible = ref(false)
const groupOptions = ref([])

// ============================================== Loading ==============================================
const { isLoading, withLoading } = useLoading()
const { isLoading: groupsIsLoading, withLoading: groupsWithLoading } = useLoading()

// ============================================== Function ==============================================
async function loadPageData() {
  withLoading(useAuthsAccountApi().PageAuthsAccount(pageParams)).then(({ data }) => {
    pageData.value = data
  })
}
loadPageData()
function loadGroupData() {
  groupsWithLoading(useAuthsGroupApi().ListTreeOptions('')).then(({ data }) => {
    groupOptions.value = data
  })
}
loadGroupData()

function handleSelectChange(selectedKeys: any) {
  selectedRowKeys.value = selectedKeys
}

async function handleDelete(id: string | string[]) {
  const idArray = toIDArray(id)
  if (idArray.length === 0) {
    MessagePlugin.warning('请选择要删除的记录')
    return
  }
  useAuthsAccountApi().DeleteAuthsAccount(idArray).then(({ success }) => {
    if (success) {
      loadPageData()
    }
  })
}

function handleReset() {
  pageParams.keyword = ''
  pageParams.groupId = ''
  loadPageData()
}

function handlePageChange(pageInfo: any) {
  pageParams.current = pageInfo.current
  pageParams.pageSize = pageInfo.pageSize
  loadPageData()
}
async function treeNodeClickHandler(value: Array<any>, context: any) {
  const { node } = context
  pageParams.groupId = value[0] ? node.data.id : ''
  loadPageData()
}
</script>

<template>
  <div class="flex">
    <div class="w-60 flex-shrink-0 p-2">
      <div class="flex flex-col gap-2">
        <div class="flex items-center gap-2">
          <t-input clearable class="w-40"  
            placeholder="请输入关键字"/>
        </div>
        <div class="flex items-center justify-between gap-2 w-full">
          <div class="flex items-center gap-2">
            <t-button theme="primary" @click="loadGroupData">
              搜索
            </t-button>
            <t-button
              theme="default"
              @click="
                () => {
                  loadGroupData()
                  loadPageData()
                }
              "
            >
              重置
            </t-button>
          </div>
        </div>
      </div>
      <t-loading
        size="small"
        :loading="groupsIsLoading"
        show-overlay
        class="w-full"
      >
        <t-tree
          :data="groupOptions"
          :keys="{ value: 'code', label: 'name' }"
          activable
          hover
          transition
          line
          @active="treeNodeClickHandler"
        />
      </t-loading>
    </div>
    <div class="flex-1">
      <div class="h-24 flex flex-col gap-2 p-4 justify-center">
        <div class="flex items-center gap-4 flex-1">
          <div class="flex items-center gap-2">
            <span class="w-14">关键字</span>
            <t-input
              v-model="pageParams.keyword"
              clearable
              class="w-40"
              placeholder="请输入关键字"
            />
          </div>

          <div class="flex items-center gap-2">
            <t-button theme="primary" @click="loadPageData">
              搜索
            </t-button>
            <t-button theme="default" @click="handleReset">
              重置
            </t-button>
          </div>
        </div>

        <div class="flex items-center justify-between gap-2">
          <div class="flex items-center gap-2">
            <t-button theme="primary" @click="formRef.doOpen()">
              新增
            </t-button>
            <t-button variant="base" theme="danger" @click="handleDelete(selectedRowKeys)">
              删除
            </t-button>
          </div>
          <div class="flex items-center gap-2">
            <t-select
              v-model="pageParams.sortField"
              :borderless="true"
              placeholder="排序字段"
              clearable
              :options="SortOptions"
              style="width: 100px;"
              @change="loadPageData"
            />
            <t-select
              v-model="pageParams.sortOrder"
              :borderless="true"
              placeholder="排序方式"
              clearable
              :options="SortTypeOptions"
              style="width: 100px;"
              @change="loadPageData"
            />
            <t-button variant="text" theme="default" @click="columnControllerVisible = true">
              显示
            </t-button>
            <t-button variant="text" theme="default" @click="loadPageData">
              刷新
            </t-button>
          </div>
        </div>
      </div>

      <t-enhanced-table
        v-model:column-controller-visible="columnControllerVisible"
        :columns="COLUMNS"
        :column-controller="{
          hideTriggerButton: true,
        }"
        :data="pageData.records"
        row-key="id"
        :hover="true"
        :loading="isLoading"
        :pagination="{
          current: pageData.current,
          pageSize: pageData.size,
          total: pageData.total,
          theme: 'simple',
        }"
        :selected-row-keys="selectedRowKeys"
        :tree="{
          treeNodeColumnIndex: 1,
          checkStrictly: false,
          indent: 25,
        }"
        max-height="calc(100vh - 56px - 96px - 64px)"
        height="calc(100vh - 56px - 96px - 64px)"
        @select-change="handleSelectChange"
        @page-change="handlePageChange"
      >
        <template #operation="{ row }">
          <t-space :size="12" align="center">
            <t-link variant="text" theme="primary" @click="formRef.doOpen(row)">
              编辑
            </t-link>
            <t-link variant="text" theme="primary" @click="detailRef.doOpen(row)">
              详情
            </t-link>
            <t-popconfirm content="确认删除吗" @confirm="handleDelete(row.id)">
              <t-link variant="text" theme="danger">
                删除
              </t-link>
            </t-popconfirm>
          </t-space>
        </template>
      </t-enhanced-table>

      <Form ref="formRef" :form-name="formName" @submit="loadPageData" />
      <Detail ref="detailRef" :form-name="formName" />
    </div>
  </div>
</template>

<style scoped>

</style>
