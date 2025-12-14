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
    title: '分组名称',
    colKey: 'name',
    width: 120,
    ellipsis: true,
  },
  {
    title: '分组代码',
    colKey: 'code',
    width: 120,
    ellipsis: true,
  },
  {
    title: '分组描述',
    colKey: 'description',
    width: 120,
    ellipsis: true,
  },
  {
    title: '排序',
    colKey: 'sort',
    width: 120,
    ellipsis: true,
  },
  {
    title: '是否系统分组',
    colKey: 'isSystemName',
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
  name: '',
  code: '',
  description: '',
  sort: 0,
  isSystem: true,
}

export const FORM_RULES = {
  name: [{ required: true, message: '请输入分组名称' }],
  code: [{ required: true, message: '请输入分组代码' }],
  description: [{ required: true, message: '请输入分组描述' }],
  sort: [{ required: true, message: '请输入排序' }],
  isSystem: [{ required: true, message: '请输入是否系统分组' }],
}
