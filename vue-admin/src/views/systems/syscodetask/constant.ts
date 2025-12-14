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
      title: '任务名称，如：系统模块代码生成',
      colKey: 'taskName',
      width: 120,
      ellipsis: true,
  },
  {
      title: '作者',
      colKey: 'author',
      width: 120,
      ellipsis: true,
  },
  {
      title: '代码输出目录',
      colKey: 'outputDir',
      width: 120,
      ellipsis: true,
  },
  {
      title: '数据库JDBC URL',
      colKey: 'dbUrl',
      width: 120,
      ellipsis: true,
  },
  {
      title: '数据库用户名',
      colKey: 'dbUsername',
      width: 120,
      ellipsis: true,
  },
  {
      title: '数据库密码（建议加密或留空）',
      colKey: 'dbPassword',
      width: 120,
      ellipsis: true,
  },
  {
      title: '数据库名',
      colKey: 'databaseName',
      width: 120,
      ellipsis: true,
  },
  {
      title: '生成后端：1-是，0-否',
      colKey: 'addBackend',
      width: 120,
      ellipsis: true,
  },
  {
      title: '生成后端：1-是，0-否',
      colKey: 'addFrontend',
      width: 120,
      ellipsis: true,
  },
  {
      title: '实际执行时间',
      colKey: 'executedAt',
      width: 120,
      ellipsis: true,
  },
  {
      title: '状态：0-待执行，1-成功，2-失败',
      colKey: 'status',
      width: 120,
      ellipsis: true,
  },
  {
      title: '备注',
      colKey: 'remark',
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
        taskName: '',
        author: '',
        outputDir: '',
        dbUrl: '',
        dbUsername: '',
        dbPassword: '',
        databaseName: '',
        addBackend: 0,
        addFrontend: 0,
        executedAt: '',
        status: 0,
        remark: '',
}

export const FORM_RULES = {
    taskName: [{ required: true, message: '请输入任务名称，如：系统模块代码生成' }],
    author: [{ required: true, message: '请输入作者' }],
    outputDir: [{ required: true, message: '请输入代码输出目录' }],
    dbUrl: [{ required: true, message: '请输入数据库JDBC URL' }],
    dbUsername: [{ required: true, message: '请输入数据库用户名' }],
    dbPassword: [{ required: true, message: '请输入数据库密码（建议加密或留空）' }],
    databaseName: [{ required: true, message: '请输入数据库名' }],
    addBackend: [{ required: true, message: '请输入生成后端：1-是，0-否' }],
    addFrontend: [{ required: true, message: '请输入生成后端：1-是，0-否' }],
    executedAt: [{ required: true, message: '请输入实际执行时间' }],
    status: [{ required: true, message: '请输入状态：0-待执行，1-成功，2-失败' }],
    remark: [{ required: true, message: '请输入备注' }],
}