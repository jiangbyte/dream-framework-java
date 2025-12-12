import { request } from '@/utils'

/**
 * 用户统计信息 API请求
 */
export function useUsersStatsApi() {
  const pathPrefix = '/api/v1'

  return {
    PageUsersStats(data: any) {
      return request.Get<IResult<any>>(`${pathPrefix}/users/stats/page`, {
        params: {
          ...data,
        },
      })
    },

    AddUsersStats(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/users/stats/add`, data)
    },

    EditUsersStats(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/users/stats/edit`, data)
    },

    DeleteUsersStats(ids: string[]) {
      return request.Post<IResult<any>>(`${pathPrefix}/users/stats/delete`, ids)
    },

    GetUsersStats(id: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/users/stats/detail/${id}`)
    },

    LatestUsersStats(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/users/stats/latest`, {
        params: {
          n,
        },
      })
    },

    TopUsersStats(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/users/stats/top`, {
        params: {
          n,
        },
      })
    },

    ListsUsersStats() {
      return request.Get<IResult<any>>(`${pathPrefix}/users/stats/lists`)
    },
  }
}
