import type { DropdownOption, PrimaryTableCol } from 'tdesign-vue-next'

export const COLUMNS: PrimaryTableCol[] = [
  {
    colKey: 'row-select',
    title: '选择',
    type: 'multiple',
    width: 40,
    fixed: 'left',
  },
  // {
  //   title: '分组编码',
  //   colKey: 'groupCode',
  //   width: 120,
  //   ellipsis: true,
  // },
  {
    title: '配置项名称',
    colKey: 'name',
    width: 120,
    ellipsis: true,
  },
  {
    title: '配置项代码',
    colKey: 'code',
    width: 120,
    ellipsis: true,
  },
  {
    title: '配置值',
    colKey: 'value',
    width: 120,
    ellipsis: true,
  },
  // {
  //   title: '组件类型',
  //   colKey: 'componentType',
  //   width: 120,
  //   ellipsis: true,
  // },
  // {
  //   title: '配置描述',
  //   colKey: 'description',
  //   width: 120,
  //   ellipsis: true,
  // },
  {
    title: '排序',
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
  groupCode: '',
  name: '',
  code: '',
  value: '',
  componentType: '',
  description: '',
  sort: 0,
}

export const FORM_RULES = {
  groupCode: [{ required: true, message: '请输入分组编码' }],
  name: [{ required: true, message: '请输入配置项名称' }],
  code: [{ required: true, message: '请输入配置项代码' }],
  // value: [{ required: true, message: '请输入配置值' }],
  // componentType: [{ required: true, message: '请输入组件类型' }],
  description: [{ required: true, message: '请输入配置描述' }],
  sort: [{ required: true, message: '请输入排序' }],
}
