import { request } from '@/utils'

/**
 * 角色 API请求
 */
export function useAuthsRoleApi() {
  const pathPrefix = '/api/v1'

  return {
    PageAuthsRole(data: any) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/role/page`, {
        params: {
          ...data,
        },
      })
    },

    AddAuthsRole(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/auths/role/add`, data)
    },

    EditAuthsRole(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/auths/role/edit`, data)
    },

    DeleteAuthsRole(ids: string[]) {
      return request.Post<IResult<any>>(`${pathPrefix}/auths/role/delete`, ids)
    },

    GetAuthsRole(id: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/role/detail/${id}`)
    },

    LatestAuthsRole(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/role/latest`, {
        params: {
          n,
        },
      })
    },

    TopAuthsRole(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/role/top`, {
        params: {
          n,
        },
      })
    },

    ListsAuthsRole() {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/role/lists`)
    },
  }
}
