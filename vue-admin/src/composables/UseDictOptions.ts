import { useSysDictApi } from '@/api'

export interface TransformedOption<T> {
  value: T
  text: string
}

export interface UseDictOptionsReturn<T> {
  options: Ref<TransformedOption<T>[]>
  loading: Ref<boolean>
  reload: () => Promise<void>
}

/**
 * 获取并转换指定类型的字典选项
 * @param dictType 字典类型，如 'SYS_BOOLEAN'
 * @param valueType 要转换的 value 类型，默认 'string'
 * @returns { options, loading, reload }
 */
export function useDictOptions<T extends 'boolean' | 'number' | 'string' = 'string'>(
  dictType: string,
  valueType: T = 'string' as T,
): UseDictOptionsReturn<
  T extends 'boolean' ? boolean : T extends 'number' ? number : string
> {
  const options = ref([]) as Ref<TransformedOption<any>[]>
  const loading = ref(false)

  const transformValue = (rawValue: string): any => {
    if (valueType === 'boolean')
      return rawValue === 'true'
    if (valueType === 'number')
      return Number(rawValue)
    return rawValue // string
  }

  const reload = async () => {
    loading.value = true
    try {
      const { data } = await useSysDictApi().ListOptionsByType(dictType)
      options.value = data.map((item: TypeOption) => ({
        text: item.text,
        value: transformValue(item.value),
      }))
    }
    finally {
      loading.value = false
    }
  }

  // 初次加载
  reload()

  return {
    options: options as Ref<TransformedOption<any>[]>,
    loading,
    reload,
  }
}

// === 专用方法 ===

/**
 * 获取布尔型字典选项（value 为 true/false）
 */
export function useBooleanDict(dictType: string) {
  return useDictOptions(dictType, 'boolean')
}

/**
 * 获取数值型字典选项（value 为 number）
 */
export function useNumberDict(dictType: string) {
  return useDictOptions(dictType, 'number')
}

/**
 * 获取字符串型字典选项（value 保持 string，默认行为）
 */
export function useStringDict(dictType: string) {
  return useDictOptions(dictType, 'string')
}


// =====================

/**
 * 加载布尔型字典并填充到目标 ref
 */
export async function loadBooleanDict(
  dictType: string,
  targetRef: Ref<TransformedOption<boolean>[]>
): Promise<void> {
  const { data } = await useSysDictApi().ListOptionsByType(dictType)
  targetRef.value = data.map((item: TypeOption) => ({
    text: item.text,
    value: item.value === 'true',
  }))
}

/**
 * 加载数值型字典
 */
export async function loadNumberDict(
  dictType: string,
  targetRef: Ref<TransformedOption<number>[]>
): Promise<void> {
  const { data } = await useSysDictApi().ListOptionsByType(dictType)
  targetRef.value = data.map((item: TypeOption) => ({
    text: item.text,
    value: Number(item.value),
  }))
}

/**
 * 加载字符串型字典
 */
export async function loadStringDict(
  dictType: string,
  targetRef: Ref<TransformedOption<string>[]>
): Promise<void> {
  const { data } = await useSysDictApi().ListOptionsByType(dictType)
  targetRef.value = data.map((item: TypeOption) => ({
    text: item.text,
    value: item.value,
  }))
}