import axios from 'axios';

// const url = 'http://localhost:44317'
const url = 'http://192.168.0.102:44317'
// const url = 'https://d06269ab5496.ngrok.io'

export default axios.create({
  // baseURL: `https://api-test--ikbal_nayem.repl.co/`,
  baseURL: url,
  headers: {
    accept: 'application/json',
    // 'Content-Type': 'multipart/form-data',
    // 'Content-Type': 'application/x-www-form-urlencoded',
    // 'Content-Type': 'application/json',
  }
});

export { url }
