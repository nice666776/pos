import axios from '../../util/Api';
import showError from '../../util/showError';

export const productSaleinformation = (p_code)=>{                     // product sale information
  return new Promise((resolve, reject)=>{
    axios.get(`/Product/Sale/info?product_code=${p_code}`)
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
      reject()
    })
  })
}

export const searchProduct = (q)=>{                                 // Search for product
  return new Promise((resolve, reject)=>{
    axios.get(`/Product/Sale/search?search_string=${q}`)
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
      reject()
    })
  })
}

export const saleSubmit = (form_input)=>{                            // Sale submit
  return new Promise((resolve, reject)=>{
    axios.post('/Sale/confirm', form_input)
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
      reject()
    })
  })
}