import { request } from '@/utils'

/**
 * 用户基本信息 API请求
 */
export function useUsersInfoApi() {
  const pathPrefix = '/api/v1'

  return {
    PageUsersInfo(data: any) {
      return request.Get<IResult<any>>(`${pathPrefix}/users/info/page`, {
        params: {
          ...data,
        },
      })
    },

    AddUsersInfo(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/users/info/add`, data)
    },

    EditUsersInfo(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/users/info/edit`, data)
    },

    DeleteUsersInfo(ids: string[]) {
      return request.Post<IResult<any>>(`${pathPrefix}/users/info/delete`, ids)
    },

    GetUsersInfo(id: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/users/info/detail/${id}`)
    },

    LatestUsersInfo(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/users/info/latest`, {
        params: {
          n,
        },
      })
    },

    TopUsersInfo(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/users/info/top`, {
        params: {
          n,
        },
      })
    },

    ListsUsersInfo() {
      return request.Get<IResult<any>>(`${pathPrefix}/users/info/lists`)
    },
  }
}
