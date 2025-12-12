import { request } from '@/utils'

/**
 * 系统活动日志记录 API请求
 */
export function useSysLogApi() {
  const pathPrefix = '/api/v1'

  return {
    PageSysLog(data: any) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/log/page`, {
        params: {
          ...data,
        },
      })
    },

    AddSysLog(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/sys/log/add`, data)
    },

    EditSysLog(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/sys/log/edit`, data)
    },

    DeleteSysLog(ids: string[]) {
      return request.Post<IResult<any>>(`${pathPrefix}/sys/log/delete`, ids)
    },

    GetSysLog(id: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/log/detail/${id}`)
    },

    LatestSysLog(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/log/latest`, {
        params: {
          n,
        },
      })
    },

    TopSysLog(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/log/top`, {
        params: {
          n,
        },
      })
    },

    ListsSysLog() {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/log/lists`)
    },
  }
}
