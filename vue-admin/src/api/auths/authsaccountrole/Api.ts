import { request } from '@/utils'

/**
 * 账户角色关联 API请求
 */
export function useAuthsAccountRoleApi() {
  const pathPrefix = '/api/v1'

  return {
    PageAuthsAccountRole(data: any) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/account/role/page`, {
        params: {
          ...data,
        },
      })
    },

    AddAuthsAccountRole(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/auths/account/role/add`, data)
    },

    EditAuthsAccountRole(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/auths/account/role/edit`, data)
    },

    DeleteAuthsAccountRole(ids: string[]) {
      return request.Post<IResult<any>>(`${pathPrefix}/auths/account/role/delete`, ids)
    },

    GetAuthsAccountRole(id: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/account/role/detail/${id}`)
    },

    LatestAuthsAccountRole(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/account/role/latest`, {
        params: {
          n,
        },
      })
    },

    TopAuthsAccountRole(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/account/role/top`, {
        params: {
          n,
        },
      })
    },

    ListsAuthsAccountRole() {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/account/role/lists`)
    },
  }
}
