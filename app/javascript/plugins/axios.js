import axios from 'axios'

const axiosInstance = axios.create({
  baseUrl: 'api/v1'
})

export default axiosInstance
