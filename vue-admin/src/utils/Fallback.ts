/**
 * 判断一个值是否“无意义”（即应被替换为 fallback）
 */
function isEmpty(value: unknown): boolean {
  // null 或 undefined
  if (value == null)
    return true

  // 字符串：空或仅含空白字符
  if (typeof value === 'string') {
    return value.trim() === ''
  }

  // 空数组
  if (Array.isArray(value)) {
    return value.length === 0
  }

  // 空对象（且不是 null，因为上面已排除）
  if (typeof value === 'object') {
    return Object.keys(value).length === 0
  }

  // 其他类型（number, boolean, function, symbol 等）一律视为有值
  return false
}

/**
 * 如果 value 有实际内容，则返回 value；否则返回 fallback。
 *
 * @param value - 待检查的值
 * @param fallback - 可选，当 value 为空时的替代值，默认为 '-'
 * @returns value 或 fallback
 */
export function withFallback<T, F = string>(
  value: T,
  fallback?: F,
): T | F {
  const finalFallback: F = fallback !== undefined ? fallback : ('-' as unknown as F)
  return isEmpty(value) ? finalFallback : value
}
