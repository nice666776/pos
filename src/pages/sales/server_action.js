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