import axios from 'axios'

const baseUrl = (process.env.NODE_ENV === 'production') ? process.env.API_URL : 'api/v1'
const axiosInstance = axios.create({
  baseURL: baseUrl
})
if (localStorage.getItem('access-token')) {
  axiosInstance.defaults.headers.common['client'] = localStorage.getItem('client')
  axiosInstance.defaults.headers.common['uid'] = localStorage.getItem('uid')
  axiosInstance.defaults.headers.common['access-token'] = localStorage.getItem('access-token')
}

export default axiosInstance
