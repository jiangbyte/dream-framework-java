import { request } from '@/utils'

/**
 * 代码生成任务模块明细 API请求
 */
export function useSysCodeTaskModuleApi() {
  const pathPrefix = '/api/v1'

  return {
    PageSysCodeTaskModule(data: any) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/code/task/module/page`, {
        params: {
          ...data,
        },
      })
    },

    AddSysCodeTaskModule(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/sys/code/task/module/add`, data)
    },

    EditSysCodeTaskModule(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/sys/code/task/module/edit`, data)
    },

    DeleteSysCodeTaskModule(ids: string[]) {
      return request.Post<IResult<any>>(`${pathPrefix}/sys/code/task/module/delete`, ids)
    },

    GetSysCodeTaskModule(id: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/code/task/module/detail/${id}`)
    },

    LatestSysCodeTaskModule(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/code/task/module/latest`, {
        params: {
          n,
        },
      })
    },

    TopSysCodeTaskModule(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/code/task/module/top`, {
        params: {
          n,
        },
      })
    },

    ListsSysCodeTaskModule() {
      return request.Get<IResult<any>>(`${pathPrefix}/sys/code/task/module/lists`)
    },
  }
}
