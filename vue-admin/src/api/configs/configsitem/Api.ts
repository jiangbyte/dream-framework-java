import { request } from '@/utils'

/**
 * 系统配置 API请求
 */
export function useConfigsItemApi() {
  const pathPrefix = '/api/v1'

  return {
    PageConfigsItem(data: any) {
      return request.Get<IResult<any>>(`${pathPrefix}/configs/item/page`, {
        params: {
          ...data,
        },
      })
    },

    AddConfigsItem(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/configs/item/add`, data)
    },

    EditConfigsItem(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/configs/item/edit`, data)
    },

    DeleteConfigsItem(ids: string[]) {
      return request.Post<IResult<any>>(`${pathPrefix}/configs/item/delete`, ids)
    },

    GetConfigsItem(id: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/configs/item/detail/${id}`)
    },

    LatestConfigsItem(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/configs/item/latest`, {
        params: {
          n,
        },
      })
    },

    TopConfigsItem(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/configs/item/top`, {
        params: {
          n,
        },
      })
    },

    ListsConfigsItem() {
      return request.Get<IResult<any>>(`${pathPrefix}/configs/item/lists`)
    },
    GetWebsiteConfig() {
      return request.Get<IResult<any>>(`${pathPrefix}/configs/item/website`)
    },
  }
}
