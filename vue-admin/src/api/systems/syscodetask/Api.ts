import { request } from '@/utils'

/**
 * 代码生成任务主 API请求
 */
export function useSysCodeTaskApi() {
  const pathPrefix = '/api/v1'

  return {
    PageSysCodeTask(data: any) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/code/task/page`, {
        params: {
          ...data,
        },
      })
    },

    AddSysCodeTask(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/sys/code/task/add`, data)
    },

    EditSysCodeTask(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/sys/code/task/edit`, data)
    },

    DeleteSysCodeTask(ids: string[]) {
      return request.Post<IResult<any>>(`${pathPrefix}/sys/code/task/delete`, ids)
    },

    GetSysCodeTask(id: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/code/task/detail/${id}`)
    },

    LatestSysCodeTask(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/code/task/latest`, {
        params: {
          n,
        },
      })
    },

    TopSysCodeTask(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/code/task/top`, {
        params: {
          n,
        },
      })
    },

    ListsSysCodeTask() {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/code/task/lists`)
    },
  }
}
