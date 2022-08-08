import axios from 'axios'

const axiosInstance = axios.create({
  baseURL: 'http://localhost:3000/api/v1'
})
if (localStorage.getItem('access-token')) {
  axiosInstance.defaults.headers.common['client'] = localStorage.getItem('client')
  axiosInstance.defaults.headers.common['uid'] = localStorage.getItem('uid')
  axiosInstance.defaults.headers.common['access-token'] = localStorage.getItem('access-token')
}

export default axiosInstance
