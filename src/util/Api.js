import axios from 'axios';

const url = 'http://192.168.0.102:44317'

export default axios.create({
  baseURL: url,
  headers: {
    accept: 'application/json'
  }
});

export { url }
