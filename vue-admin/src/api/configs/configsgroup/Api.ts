import { request } from '@/utils'

/**
 * 配置分组 API请求
 */
export function useConfigsGroupApi() {
  const pathPrefix = '/api/v1'

  return {
    PageConfigsGroup(data: any) {
      return request.Get<IResult<any>>(`${pathPrefix}/configs/group/page`, {
        params: {
          ...data,
        },
      })
    },

    AddConfigsGroup(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/configs/group/add`, data)
    },

    EditConfigsGroup(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/configs/group/edit`, data)
    },

    DeleteConfigsGroup(ids: string[]) {
      return request.Post<IResult<any>>(`${pathPrefix}/configs/group/delete`, ids)
    },

    GetConfigsGroup(id: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/configs/group/detail/${id}`)
    },

    LatestConfigsGroup(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/configs/group/latest`, {
        params: {
          n,
        },
      })
    },

    TopConfigsGroup(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/configs/group/top`, {
        params: {
          n,
        },
      })
    },

    ListsConfigsGroup() {
      return request.Get<IResult<any>>(`${pathPrefix}/configs/group/lists`)
    },
  }
}
