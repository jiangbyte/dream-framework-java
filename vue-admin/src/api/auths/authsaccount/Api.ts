import { request } from '@/utils'

/**
 * 核心账户 API请求
 */
export function useAuthsAccountApi() {
  const pathPrefix = '/api/v1'

  return {
    PageAuthsAccount(data: any) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/account/page`, {
        params: {
          ...data,
        },
      })
    },

    AddAuthsAccount(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/auths/account/add`, data)
    },

    EditAuthsAccount(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/auths/account/edit`, data)
    },

    DeleteAuthsAccount(ids: string[]) {
      return request.Post<IResult<any>>(`${pathPrefix}/auths/account/delete`, ids)
    },

    GetAuthsAccount(id: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/account/detail/${id}`)
    },

    LatestAuthsAccount(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/account/latest`, {
        params: {
          n,
        },
      })
    },

    TopAuthsAccount(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/account/top`, {
        params: {
          n,
        },
      })
    },

    ListsAuthsAccount() {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/account/lists`)
    },
  }
}
