<#-- ==================== 字段类型分类 ==================== -->

<#-- 布尔类型 -->
<#assign BOOLEAN_TYPES = ["Boolean"]>

<#-- 数值类型（用于 InputNumber） -->
<#assign NUMBER_TYPES = ["Long", "Integer", "Short", "Byte", "Double", "Float", "BigDecimal"]>

<#-- 字符串类型（普通文本输入） -->
<#assign STRING_TYPES = ["String", "Character", "char"]>

<#-- 日期时间类型（可扩展） -->
<#assign DATE_TYPES = ["Date", "LocalDateTime", "LocalDate", "LocalTime"]>

<#-- 忽略的系统字段 -->
<#assign IGNORED_FIELDS = [
"id", "isDeleted", "deletedAt", "deletedBy",
"createdBy", "updatedBy"
]>
<#assign IGNORED_FIELDS1 = [
"id", "isDeleted", "deletedAt", "deletedBy",
"createdBy", "updatedBy", "createdAt", "updatedAt"
]>

<#-- ==================== 工具函数 ==================== -->

<#function isIgnoredField field>
    <#return IGNORED_FIELDS?seq_contains(field.propertyName)>
</#function>

<#function isIgnoredField1 field>
    <#return IGNORED_FIELDS1?seq_contains(field.propertyName)>
</#function>

<#function shouldRenderField field>
    <#return !isIgnoredField(field)>
</#function>

<#function shouldRenderField1 field>
    <#return !isIgnoredField1(field)>
</#function>

<#function isBooleanField field>
    <#return BOOLEAN_TYPES?seq_contains(field.propertyType)>
</#function>

<#function isNumberField field>
    <#return NUMBER_TYPES?seq_contains(field.propertyType)>
</#function>

<#function isStringField field>
    <#return STRING_TYPES?seq_contains(field.propertyType)>
</#function>

<#function isDateField field>
    <#return DATE_TYPES?seq_contains(field.propertyType)>
</#function>