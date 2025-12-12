import { request } from '@/utils'

/**
 * 账户用户组关联 API请求
 */
export function useAuthsAccountGroupApi() {
  const pathPrefix = '/api/v1'

  return {
    PageAuthsAccountGroup(data: any) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/account/group/page`, {
        params: {
          ...data,
        },
      })
    },

    AddAuthsAccountGroup(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/auths/account/group/add`, data)
    },

    EditAuthsAccountGroup(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/auths/account/group/edit`, data)
    },

    DeleteAuthsAccountGroup(ids: string[]) {
      return request.Post<IResult<any>>(`${pathPrefix}/auths/account/group/delete`, ids)
    },

    GetAuthsAccountGroup(id: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/account/group/detail/${id}`)
    },

    LatestAuthsAccountGroup(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/account/group/latest`, {
        params: {
          n,
        },
      })
    },

    TopAuthsAccountGroup(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/account/group/top`, {
        params: {
          n,
        },
      })
    },

    ListsAuthsAccountGroup() {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/account/group/lists`)
    },
  }
}
