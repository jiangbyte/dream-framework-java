<#include "../common/field-helpers.ftl">
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
<#if shouldRenderField(field)>
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
<#if shouldRenderField1(field)>
    <#if isNumberField(field)>
        ${field.propertyName}: 0,
    <#elseif isBooleanField(field)>
        ${field.propertyName}: true,
    <#else>
        ${field.propertyName}: '',
    </#if>
</#if>
</#list>
}

export const FORM_RULES = {
<#list table.fields as field>
    <#if shouldRenderField1(field)>
    ${field.propertyName}: [{ required: true, message: '请输入${field.comment}' }],
    </#if>
</#list>
}