import type { DropdownOption, PrimaryTableCol } from 'tdesign-vue-next'

export const COLUMNS: PrimaryTableCol[] = [
  {
      colKey: 'row-select',
      title: '选择',
      type: 'multiple',
      width: 40,
      fixed: 'left',
  },
<#list table.fields as field>
<#if !["id", "isDeleted", "deletedAt", "deletedBy", "createdBy", "updatedBy"]?seq_contains(field.propertyName)>
  {
      title: '${field.comment}',
      colKey: '${field.propertyName}',
      width: 120,
      ellipsis: true,
  },
</#if>
</#list>
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
<#list table.fields as field>
<#if !["id", "isDeleted", "deletedAt", "deletedBy", "createdBy", "updatedBy"]?seq_contains(field.propertyName)>
    <#if field.propertyType == 'String'>
        ${field.propertyName}: '',
    <#elseif ['Long','Integer','Short','Byte','Double','Float','BigDecimal']?seq_contains(field.propertyType)>
        ${field.propertyName}: 0,
    <#elseif ['Boolean']?seq_contains(field.propertyType)>
        ${field.propertyName}: true,
    <#else>
        ${field.propertyName}: '',
    </#if>
</#if>
</#list>
}

export const FORM_RULES = {
<#list table.fields as field>
    <#if !["id", "isDeleted", "deletedAt", "deletedBy", "createdBy", "updatedBy"]?seq_contains(field.propertyName)>
    ${field.propertyName}: [{ required: true, message: '请输入'${field.comment}'' }],
    </#if>
</#list>
}