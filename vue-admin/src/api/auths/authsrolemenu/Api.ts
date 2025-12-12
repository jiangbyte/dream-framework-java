import { request } from '@/utils'

/**
 * 角色菜单关联 API请求
 */
export function useAuthsRoleMenuApi() {
  const pathPrefix = '/api/v1'

  return {
    PageAuthsRoleMenu(data: any) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/role/menu/page`, {
        params: {
          ...data,
        },
      })
    },

    AddAuthsRoleMenu(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/auths/role/menu/add`, data)
    },

    EditAuthsRoleMenu(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/auths/role/menu/edit`, data)
    },

    DeleteAuthsRoleMenu(ids: string[]) {
      return request.Post<IResult<any>>(`${pathPrefix}/auths/role/menu/delete`, ids)
    },

    GetAuthsRoleMenu(id: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/role/menu/detail/${id}`)
    },

    LatestAuthsRoleMenu(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/role/menu/latest`, {
        params: {
          n,
        },
      })
    },

    TopAuthsRoleMenu(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/role/menu/top`, {
        params: {
          n,
        },
      })
    },

    ListsAuthsRoleMenu() {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/role/menu/lists`)
    },
  }
}
