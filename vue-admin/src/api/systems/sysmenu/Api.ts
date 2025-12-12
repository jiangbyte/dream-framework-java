import { request } from '@/utils'

/**
 * 菜单 API请求
 */
export function useSysMenuApi() {
  const pathPrefix = '/api/v1'

  return {
    PageSysMenu(data: any) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/menu/page`, {
        params: {
          ...data,
        },
      })
    },

    AddSysMenu(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/sys/menu/add`, data)
    },

    EditSysMenu(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/sys/menu/edit`, data)
    },

    DeleteSysMenu(ids: string[]) {
      return request.Post<IResult<any>>(`${pathPrefix}/sys/menu/delete`, ids)
    },

    GetSysMenu(id: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/menu/detail/${id}`)
    },

    LatestSysMenu(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/menu/latest`, {
        params: {
          n,
        },
      })
    },

    TopSysMenu(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/menu/top`, {
        params: {
          n,
        },
      })
    },

    ListsSysMenu() {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/menu/lists`)
    },
    GetSysMenuListTreeWithAccountID(keyword: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/menu/list/tree`, {
        params: {
          keyword,
        },
      })
    },
    GetSysMenuListWithAccountID(keyword: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/menu/list`, {
        params: {
          keyword,
        },
      })
    },
  }
}
