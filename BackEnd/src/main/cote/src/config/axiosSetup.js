import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:8080', // 기본 API URL
  timeout: 5000, // 요청 타임아웃 (ms)
  headers: {
    'Content-Type': 'application/json',
  },
});

export default api;