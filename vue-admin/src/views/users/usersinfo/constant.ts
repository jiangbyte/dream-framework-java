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
    title: '昵称',
    colKey: 'nickname',
    width: 120,
    ellipsis: true,
  },
  {
    title: '头像',
    colKey: 'avatar',
    width: 120,
    ellipsis: true,
  },
  {
    title: '性别：0-未知 1-男 2-女',
    colKey: 'gender',
    width: 120,
    ellipsis: true,
  },
  {
    title: '生日',
    colKey: 'birthday',
    width: 120,
    ellipsis: true,
  },
  {
    title: '个性签名',
    colKey: 'signature',
    width: 120,
    ellipsis: true,
  },
  {
    title: '个人背景图片',
    colKey: 'background',
    width: 120,
    ellipsis: true,
  },
  {
    title: '兴趣标签',
    colKey: 'interests',
    width: 120,
    ellipsis: true,
  },
  {
    title: '个人网站',
    colKey: 'website',
    width: 120,
    ellipsis: true,
  },
  {
    title: 'GitHub',
    colKey: 'github',
    width: 120,
    ellipsis: true,
  },
  {
    title: 'GitTee',
    colKey: 'gitee',
    width: 120,
    ellipsis: true,
  },
  {
    title: '博客',
    colKey: 'blog',
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
  nickname: '',
  avatar: '',
  gender: 0,
  birthday: '',
  signature: '',
  background: '',
  interests: '',
  website: '',
  github: '',
  gitee: '',
  blog: '',
  createdAt: '',
  updatedAt: '',
}

export const FORM_RULES = {
  accountId: [{ required: true, message: '请输入账户ID' }],
  nickname: [{ required: true, message: '请输入昵称' }],
  avatar: [{ required: true, message: '请输入头像' }],
  gender: [{ required: true, message: '请输入性别：0-未知 1-男 2-女' }],
  birthday: [{ required: true, message: '请输入生日' }],
  signature: [{ required: true, message: '请输入个性签名' }],
  background: [{ required: true, message: '请输入个人背景图片' }],
  interests: [{ required: true, message: '请输入兴趣标签' }],
  website: [{ required: true, message: '请输入个人网站' }],
  github: [{ required: true, message: '请输入GitHub' }],
  gitee: [{ required: true, message: '请输入GitTee' }],
  blog: [{ required: true, message: '请输入博客' }],
  createdAt: [{ required: true, message: '请输入创建时间' }],
  updatedAt: [{ required: true, message: '请输入最后更新时间' }],
}
