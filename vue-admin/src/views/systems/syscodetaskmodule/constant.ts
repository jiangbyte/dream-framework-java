import type { DropdownOption, PrimaryTableCol } from 'tdesign-vue-next'

export const COLUMNS: PrimaryTableCol[] = [
  {
      colKey: 'row-select',
      title: '选择',
      type: 'multiple',
      width: 40,
      fixed: 'left',
  },
  {
      title: '关联 gen_code_task.id',
      colKey: 'taskId',
      width: 120,
      ellipsis: true,
  },
  {
      title: '模块类型，如：biz, sys, auth',
      colKey: 'moduleType',
      width: 120,
      ellipsis: true,
  },
  {
      title: 'Java 包路径',
      colKey: 'packagePath',
      width: 120,
      ellipsis: true,
  },
  {
      title: '表名称，如：biz_normal_category',
      colKey: 'tableName',
      width: 120,
      ellipsis: true,
  },
  {
      title: '创建时间',
      colKey: 'createdAt',
      width: 120,
      ellipsis: true,
  },
  {
      title: '最后更新时间',
      colKey: 'updatedAt',
      width: 120,
      ellipsis: true,
  },
  {
      title: '操作',
      colKey: 'operation',
      width: 180,
      align: 'center',
      fixed: 'right',
  },
]

export const SortOptions: DropdownOption[] = [
  {
      value: 'id',
      label: 'ID',
  },
  ...COLUMNS
      .filter(column =>
        column.colKey !== 'row-select'
        && column.colKey !== 'operation'
        && column.title,
      )
      .map(column => ({
        value: column.colKey,
        label: column.title as string,
      })),
]

export const PARTIAL_INIT = {
        taskId: 0,
        moduleType: '',
        packagePath: '',
        tableName: '',
}

export const FORM_RULES = {
    taskId: [{ required: true, message: '请输入关联 gen_code_task.id' }],
    moduleType: [{ required: true, message: '请输入模块类型，如：biz, sys, auth' }],
    packagePath: [{ required: true, message: '请输入Java 包路径' }],
    tableName: [{ required: true, message: '请输入表名称，如：biz_normal_category' }],
}