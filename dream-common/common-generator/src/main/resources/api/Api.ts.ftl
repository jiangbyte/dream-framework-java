import { request } from '@/utils'

/**
* ${table.comment?replace('表', '')} API请求
*/
export function use${entity}Api() {
    const pathPrefix = '/api/v1'

 return {
    Page${entity}(data: any) {
      return request.Get<IResult<any>>(`<#noparse>${pathPrefix}</#noparse>/${table.name?replace('_', '/')}/page`, {
        params: {
        ...data,
        },
      })
    },

    Add${entity}(data: any) {
      return request.Post<IResult<any>>(`<#noparse>${pathPrefix}</#noparse>/${table.name?replace('_', '/')}/add`, data)
    },

    Edit${entity}(data: any) {
      return request.Post<IResult<any>>(`<#noparse>${pathPrefix}</#noparse>/${table.name?replace('_', '/')}/edit`, data)
    },

    Delete${entity}(ids: string[]) {
      return request.Post<IResult<any>>(`<#noparse>${pathPrefix}</#noparse>/${table.name?replace('_', '/')}/delete`, ids)
    },

    Get${entity}(id: string) {
      return request.Get<IResult<any>>(`<#noparse>${pathPrefix}</#noparse>/${table.name?replace('_', '/')}/detail/<#noparse>${id}</#noparse>`)
    },

    Latest${entity}(n: number) {
      return request.Get<IResult<any>>(`<#noparse>${pathPrefix}</#noparse>/${table.name?replace('_', '/')}/latest`, {
        params: {
            n,
        },
      })
    },

    Top${entity}(n: number) {
      return request.Get<IResult<any>>(`<#noparse>${pathPrefix}</#noparse>/${table.name?replace('_', '/')}/top`, {
        params: {
            n,
        },
      })
    },

    Lists${entity}() {
        return request.Get<IResult<any>>(`<#noparse>${pathPrefix}</#noparse>/${table.name?replace('_', '/')}/lists`)
    },
  }
}
