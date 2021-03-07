import axios from 'util/Api';
import showError from 'util/showError';


export const posLogin = (form_inputs)=>{                        // Login
  return new Promise((resolve, reject)=>{
    axios.post('/pos/login', form_inputs)
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
			reject(err)
    })
  })
}

export const getUserInfo = ()=>{                          // get user information
  return new Promise((resolve, reject)=>{
    axios.get('/pos/token')
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
			reject(err)
    })
  })
}