import { request } from '@/utils'

/**
 * 用户组 API请求
 */
export function useAuthsGroupApi() {
  const pathPrefix = '/api/v1'

  return {
    PageAuthsGroup(data: any) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/group/page`, {
        params: {
          ...data,
        },
      })
    },

    AddAuthsGroup(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/auths/group/add`, data)
    },

    EditAuthsGroup(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/auths/group/edit`, data)
    },

    DeleteAuthsGroup(ids: string[]) {
      return request.Post<IResult<any>>(`${pathPrefix}/auths/group/delete`, ids)
    },

    GetAuthsGroup(id: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/group/detail/${id}`)
    },

    LatestAuthsGroup(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/group/latest`, {
        params: {
          n,
        },
      })
    },

    TopAuthsGroup(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/group/top`, {
        params: {
          n,
        },
      })
    },

    ListsAuthsGroup() {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/group/lists`)
    },
    ListTreeOptions(keyword: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/auths/group/lists/tree`, {
        params: {
          keyword,
        },
      })
    },
  }
}
