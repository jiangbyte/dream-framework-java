import { request } from '@/utils'

/**
 * 用户偏好设置 API请求
 */
export function useUsersPreferenceApi() {
  const pathPrefix = '/api/v1'

  return {
    PageUsersPreference(data: any) {
      return request.Get<IResult<any>>(`${pathPrefix}/users/preference/page`, {
        params: {
          ...data,
        },
      })
    },

    AddUsersPreference(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/users/preference/add`, data)
    },

    EditUsersPreference(data: any) {
      return request.Post<IResult<any>>(`${pathPrefix}/users/preference/edit`, data)
    },

    DeleteUsersPreference(ids: string[]) {
      return request.Post<IResult<any>>(`${pathPrefix}/users/preference/delete`, ids)
    },

    GetUsersPreference(id: string) {
      return request.Get<IResult<any>>(`${pathPrefix}/users/preference/detail/${id}`)
    },

    LatestUsersPreference(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/users/preference/latest`, {
        params: {
          n,
        },
      })
    },

    TopUsersPreference(n: number) {
      return request.Get<IResult<any>>(`${pathPrefix}/users/preference/top`, {
        params: {
          n,
        },
      })
    },

    ListsUsersPreference() {
      return request.Get<IResult<any>>(`${pathPrefix}/users/preference/lists`)
    },
  }
}
