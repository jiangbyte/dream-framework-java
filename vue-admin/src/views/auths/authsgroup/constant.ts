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
      title: '父级组ID',
      colKey: 'pid',
      width: 120,
      ellipsis: true,
  },
  {
      title: '父级组路径',
      colKey: 'pidPath',
      width: 120,
      ellipsis: true,
  },
  {
      title: '用户组名称',
      colKey: 'name',
      width: 120,
      ellipsis: true,
  },
  {
      title: '用户组编码',
      colKey: 'code',
      width: 120,
      ellipsis: true,
  },
  {
      title: '用户组描述',
      colKey: 'description',
      width: 120,
      ellipsis: true,
  },
  {
      title: '排序号，数字越小越靠前',
      colKey: 'sort',
      width: 120,
      ellipsis: true,
  },
  {
      title: '管理员ID',
      colKey: 'adminId',
      width: 120,
      ellipsis: true,
  },
  {
      title: '最大用户数量限制',
      colKey: 'maxUserCount',
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
        pid: '',
        pidPath: '',
        name: '',
        code: '',
        description: '',
        sort: 0,
        adminId: '',
        maxUserCount: 0,
}

export const FORM_RULES = {
    pid: [{ required: true, message: '请输入父级组ID' }],
    // pidPath: [{ required: true, message: '请输入父级组路径' }],
    name: [{ required: true, message: '请输入用户组名称' }],
    code: [{ required: true, message: '请输入用户组编码' }],
    description: [{ required: true, message: '请输入用户组描述' }],
    sort: [{ required: true, message: '请输入排序号，数字越小越靠前' }],
    // adminId: [{ required: true, message: '请输入管理员ID' }],
    maxUserCount: [{ required: true, message: '请输入最大用户数量限制' }],
}