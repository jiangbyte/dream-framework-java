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
    title: '账户ID',
    colKey: 'accountId',
    width: 120,
    ellipsis: true,
  },
  {
    title: '真实姓名',
    colKey: 'realName',
    width: 120,
    ellipsis: true,
  },
  {
    title: '学校',
    colKey: 'school',
    width: 120,
    ellipsis: true,
  },
  {
    title: '专业',
    colKey: 'major',
    width: 120,
    ellipsis: true,
  },
  {
    title: '学号',
    colKey: 'studentId',
    width: 120,
    ellipsis: true,
  },
  {
    title: '公司',
    colKey: 'company',
    width: 120,
    ellipsis: true,
  },
  {
    title: '职位',
    colKey: 'jobTitle',
    width: 120,
    ellipsis: true,
  },
  {
    title: '行业',
    colKey: 'industry',
    width: 120,
    ellipsis: true,
  },
  {
    title: '国家',
    colKey: 'country',
    width: 120,
    ellipsis: true,
  },
  {
    title: '省份',
    colKey: 'province',
    width: 120,
    ellipsis: true,
  },
  {
    title: '城市',
    colKey: 'city',
    width: 120,
    ellipsis: true,
  },
  {
    title: '详细地址',
    colKey: 'location',
    width: 120,
    ellipsis: true,
  },
  {
    title: 'QQ',
    colKey: 'qq',
    width: 120,
    ellipsis: true,
  },
  {
    title: '微信',
    colKey: 'wechat',
    width: 120,
    ellipsis: true,
  },
  {
    title: '是否显示生日',
    colKey: 'showBirthday',
    width: 120,
    ellipsis: true,
  },
  {
    title: '是否显示地理位置',
    colKey: 'showLocation',
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
  accountId: '',
  realName: '',
  school: '',
  major: '',
  studentId: '',
  company: '',
  jobTitle: '',
  industry: '',
  country: '',
  province: '',
  city: '',
  location: '',
  qq: '',
  wechat: '',
  showBirthday: true,
  showLocation: true,
}

export const FORM_RULES = {
  accountId: [{ required: true, message: '请输入账户ID' }],
  realName: [{ required: true, message: '请输入真实姓名' }],
  school: [{ required: true, message: '请输入学校' }],
  major: [{ required: true, message: '请输入专业' }],
  studentId: [{ required: true, message: '请输入学号' }],
  company: [{ required: true, message: '请输入公司' }],
  jobTitle: [{ required: true, message: '请输入职位' }],
  industry: [{ required: true, message: '请输入行业' }],
  country: [{ required: true, message: '请输入国家' }],
  province: [{ required: true, message: '请输入省份' }],
  city: [{ required: true, message: '请输入城市' }],
  location: [{ required: true, message: '请输入详细地址' }],
  qq: [{ required: true, message: '请输入QQ' }],
  wechat: [{ required: true, message: '请输入微信' }],
  showBirthday: [{ required: true, message: '请输入是否显示生日' }],
  showLocation: [{ required: true, message: '请输入是否显示地理位置' }],
}
