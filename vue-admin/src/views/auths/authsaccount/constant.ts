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
    title: '用户名',
    colKey: 'usersInfo[nickname]',
    width: 120,
    // ellipsis: true,
  },
  {
    title: '用户名',
    colKey: 'username',
    width: 120,
    ellipsis: true,
  },
  // {
  //   title: '加密后的密码',
  //   colKey: 'password',
  //   width: 120,
  //   ellipsis: true,
  // },
  {
    title: '邮箱地址',
    colKey: 'email',
    width: 120,
    ellipsis: true,
  },
  {
    title: '手机号码',
    colKey: 'telephone',
    width: 120,
    ellipsis: true,
  },
  {
    title: '账户状态',
    colKey: 'statusName',
    width: 120,
    ellipsis: true,
  },
  // {
  //   title: '密码强度等级',
  //   colKey: 'passwordStrengthName',
  //   width: 120,
  //   ellipsis: true,
  // },
  // {
  //   title: '最后修改密码的时间',
  //   colKey: 'lastPasswordChange',
  //   width: 120,
  //   ellipsis: true,
  // },
  // {
  //   title: '最后登录时间',
  //   colKey: 'lastLoginTime',
  //   width: 120,
  //   ellipsis: true,
  // },
  // {
  //   title: '最后登录IP地址',
  //   colKey: 'lastLoginIp',
  //   width: 120,
  //   ellipsis: true,
  // },
  // {
  //   title: '登录次数统计',
  //   colKey: 'loginCount',
  //   width: 120,
  //   ellipsis: true,
  // },
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
  username: '',
  password: '',
  email: '',
  telephone: '',
  status: 0,
  passwordStrength: 0,
  lastPasswordChange: '',
  lastLoginTime: '',
  lastLoginIp: '',
  loginCount: 0,
}

export const FORM_RULES = {
  username: [{ required: true, message: '请输入用户名，登录标识' }],
  password: [{ required: true, message: '请输入加密后的密码' }],
  email: [{ required: true, message: '请输入邮箱地址' }],
  telephone: [{ required: true, message: '请输入手机号码' }],
  status: [{ required: true, message: '请输入账户状态：0-正常, 1-锁定, 2-禁用' }],
  passwordStrength: [{ required: true, message: '请输入密码强度等级：0-3' }],
  lastPasswordChange: [{ required: true, message: '请输入最后修改密码的时间' }],
  lastLoginTime: [{ required: true, message: '请输入最后登录时间' }],
  lastLoginIp: [{ required: true, message: '请输入最后登录IP地址' }],
  loginCount: [{ required: true, message: '请输入登录次数统计' }],
}
