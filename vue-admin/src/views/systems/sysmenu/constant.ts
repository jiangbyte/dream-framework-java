import type { DropdownOption, PrimaryTableCol } from 'tdesign-vue-next'

export const COLUMNS: PrimaryTableCol[] = [
  {
    colKey: 'row-select',
    title: '选择',
    type: 'multiple',
    width: 40,
    fixed: 'left',
  },
  //   {
  //       title: '父级ID',
  //       colKey: 'pid',
  //       width: 120,
  //       ellipsis: true,
  //   },
  {
    title: '菜单标题',
    colKey: 'title',
    width: 120,
    ellipsis: true,
  },
  {
    title: '菜单名称',
    colKey: 'name',
    width: 120,
    ellipsis: true,
  },
  {
    title: '菜单路径',
    colKey: 'path',
    width: 120,
    ellipsis: true,
  },
  {
    title: '组件路径',
    colKey: 'componentPath',
    width: 120,
    ellipsis: true,
  },
  {
    title: '重定向路径',
    colKey: 'redirect',
    width: 120,
    ellipsis: true,
  },
  {
    title: '外部链接地址',
    colKey: 'externalUrl',
    width: 120,
    ellipsis: true,
  },
  {
    title: '菜单类型：0-内部菜单 1-外链菜单 2-重定向菜单 3-iframe嵌入',
    colKey: 'menuType',
    width: 120,
    ellipsis: true,
  },
  {
    title: '打开方式：0-当前窗口 1-新窗口打开',
    colKey: 'openTarget',
    width: 120,
    ellipsis: true,
  },
  {
    title: 'iframe属性',
    colKey: 'iframeAttrs',
    width: 120,
    ellipsis: true,
  },
  {
    title: '菜单图标',
    colKey: 'icon',
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
    title: '缓存',
    colKey: 'keepAlive',
    width: 120,
    ellipsis: true,
  },
  {
    title: '可见',
    colKey: 'visible',
    width: 120,
    ellipsis: true,
  },
  {
    title: '钉钉',
    colKey: 'pined',
    width: 120,
    ellipsis: true,
  },
  {
    title: '无标签页',
    colKey: 'withoutTab',
    width: 120,
    ellipsis: true,
  },
  {
    title: '头部参数',
    colKey: 'parameters',
    width: 120,
    ellipsis: true,
  },
  {
    title: '路由参数',
    colKey: 'extraParams',
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
  name: '',
  path: '',
  componentPath: '',
  redirect: '',
  externalUrl: '',
  menuType: 0,
  openTarget: 0,
  iframeAttrs: '',
  title: '',
  icon: '',
  sort: 0,
  keepAlive: true,
  visible: true,
  pined: true,
  withoutTab: true,
  parameters: '',
  extraParams: '',
}

export const FORM_RULES = {
  pid: [{ required: true, message: '请输入父级ID' }],
  name: [{ required: true, message: '请输入菜单名称' }],
  path: [{ required: true, message: '请输入菜单路径' }],
  componentPath: [{ required: true, message: '请输入组件路径' }],
  redirect: [{ required: true, message: '请输入重定向路径' }],
  externalUrl: [{ required: true, message: '请输入外部链接地址' }],
  menuType: [{ required: true, message: '请输入菜单类型：0-内部菜单 1-外链菜单 2-重定向菜单 3-iframe嵌入' }],
  openTarget: [{ required: true, message: '请输入打开方式：0-当前窗口 1-新窗口打开' }],
  iframeAttrs: [{ required: true, message: '请输入iframe属性' }],
  title: [{ required: true, message: '请输入菜单标题' }],
  icon: [{ required: true, message: '请输入菜单图标' }],
  sort: [{ required: true, message: '请输入排序' }],
  keepAlive: [{ required: true, message: '请输入缓存' }],
  visible: [{ required: true, message: '请输入可见' }],
  pined: [{ required: true, message: '请输入钉钉' }],
  withoutTab: [{ required: true, message: '请输入无标签页' }],
  parameters: [{ required: true, message: '请输入头部参数' }],
  extraParams: [{ required: true, message: '请输入路由参数' }],
}
