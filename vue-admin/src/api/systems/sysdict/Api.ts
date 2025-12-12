import { request } from '@/utils'

/**
 * 系统字典 API请求
 */
export function useSysDictApi() {
  const pathPrefix = '/api/v1'

  return {
    PageSysDict(data: any) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/dict/page`, {
        params: {
          ...data,
        },
      })
    },

    AddSysDict(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/sys/dict/add`, data)
    },

    EditSysDict(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/sys/dict/edit`, data)
    },

    DeleteSysDict(ids: string[]) {
      return request.Post<IResult<any>>(`${pathPrefix}/sys/dict/delete`, ids)
    },

    GetSysDict(id: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/dict/detail/${id}`)
    },

    LatestSysDict(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/dict/latest`, {
        params: {
          n,
        },
      })
    },

    TopSysDict(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/dict/top`, {
        params: {
          n,
        },
      })
    },

    ListsSysDict() {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/dict/lists`)
    },
    TreeOptions(keyword: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/dict/tree/options`, {
        params: {
          keyword,
        },
      })
    },
    ListOptions(keyword: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/dict/list/options`, {
        params: {
          keyword,
        },
      })
    },
    ListTypeOptions(keyword: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/dict/list/type/options`, {
        params: {
          keyword,
        },
      })
    },

    ListOptionsByType(type: string, keyword?: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/dict/list/options/by/type`, {
        params: {
          type,
          ...(keyword && { keyword }), // 只有当 keyword 有值时才传入
        },
      })
    },
  }
}
