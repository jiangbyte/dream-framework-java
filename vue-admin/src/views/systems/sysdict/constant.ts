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
      title: '字典类型',
      colKey: 'dictType',
      width: 120,
      ellipsis: true,
  },
  {
      title: '类型标签',
      colKey: 'typeLabel',
      width: 120,
      ellipsis: true,
  },
  {
      title: '字典值',
      colKey: 'dictValue',
      width: 120,
      ellipsis: true,
  },
  {
      title: '字典标签',
      colKey: 'dictLabel',
      width: 120,
      ellipsis: true,
  },
  {
      title: '排序号',
      colKey: 'sort',
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
        dictType: '',
        typeLabel: '',
        dictValue: '',
        dictLabel: '',
        sort: 0,
}

export const FORM_RULES = {
    dictType: [{ required: true, message: '请输入字典类型' }],
    typeLabel: [{ required: true, message: '请输入类型标签' }],
    dictValue: [{ required: true, message: '请输入字典值' }],
    dictLabel: [{ required: true, message: '请输入字典标签' }],
    sort: [{ required: true, message: '请输入排序号' }],
}