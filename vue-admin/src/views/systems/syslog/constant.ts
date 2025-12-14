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
      title: '用户ID',
      colKey: 'userId',
      width: 120,
      ellipsis: true,
  },
  {
      title: '操作类型',
      colKey: 'operation',
      width: 120,
      ellipsis: true,
  },
  {
      title: '请求方法',
      colKey: 'method',
      width: 120,
      ellipsis: true,
  },
  {
      title: '请求参数',
      colKey: 'params',
      width: 120,
      ellipsis: true,
  },
  {
      title: 'IP地址',
      colKey: 'ip',
      width: 120,
      ellipsis: true,
  },
  {
      title: '操作时间',
      colKey: 'operationTime',
      width: 120,
      ellipsis: true,
  },
  {
      title: '日志分类',
      colKey: 'category',
      width: 120,
      ellipsis: true,
  },
  {
      title: '操作模块',
      colKey: 'module',
      width: 120,
      ellipsis: true,
  },
  {
      title: '操作描述',
      colKey: 'description',
      width: 120,
      ellipsis: true,
  },
  {
      title: '操作状态',
      colKey: 'status',
      width: 120,
      ellipsis: true,
  },
  {
      title: '日志消息',
      colKey: 'message',
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
        userId: '',
        operation: '',
        method: '',
        params: '',
        ip: '',
        operationTime: '',
        category: '',
        module: '',
        description: '',
        status: '',
        message: '',
}

export const FORM_RULES = {
    userId: [{ required: true, message: '请输入用户ID' }],
    operation: [{ required: true, message: '请输入操作类型' }],
    method: [{ required: true, message: '请输入请求方法' }],
    params: [{ required: true, message: '请输入请求参数' }],
    ip: [{ required: true, message: '请输入IP地址' }],
    operationTime: [{ required: true, message: '请输入操作时间' }],
    category: [{ required: true, message: '请输入日志分类' }],
    module: [{ required: true, message: '请输入操作模块' }],
    description: [{ required: true, message: '请输入操作描述' }],
    status: [{ required: true, message: '请输入操作状态' }],
    message: [{ required: true, message: '请输入日志消息' }],
}