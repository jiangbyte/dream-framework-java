import { request } from '@/utils'

/**
 * 用户档案详情 API请求
 */
export function useUsersProfileApi() {
  const pathPrefix = '/api/v1'

  return {
    PageUsersProfile(data: any) {
      return request.Get<IResult<any>>(`${pathPrefix}/users/profile/page`, {
        params: {
          ...data,
        },
      })
    },

    AddUsersProfile(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/users/profile/add`, data)
    },

    EditUsersProfile(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/users/profile/edit`, data)
    },

    DeleteUsersProfile(ids: string[]) {
      return request.Post<IResult<any>>(`${pathPrefix}/users/profile/delete`, ids)
    },

    GetUsersProfile(id: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/users/profile/detail/${id}`)
    },

    LatestUsersProfile(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/users/profile/latest`, {
        params: {
          n,
        },
      })
    },

    TopUsersProfile(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/users/profile/top`, {
        params: {
          n,
        },
      })
    },

    ListsUsersProfile() {
      return request.Get<IResult<any>>(`${pathPrefix}/users/profile/lists`)
    },
  }
}
