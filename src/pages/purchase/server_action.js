import axios from '../../util/Api';
import showError from '../../util/showError';

export const supplierDropDown = ()=>{                            // supplier DropDown
  return new Promise((resolve, reject)=>{
    axios.get('/DropDown/suppliers')
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
      reject()
    })
  })
}

export const productList = (c_code)=>{                               // product list
  return new Promise((resolve, reject)=>{
    axios.get(`/Product/Categorywise?category_code=${c_code}`)
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
      reject()
    })
  })
}

export const productInfo = (p_code)=>{                               // product Information
  return new Promise((resolve, reject)=>{
    axios.get(`/Product/info?product_code=${p_code}`)
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
      reject()
    })
  })
}

export const purchaseConfirm = (form_inputs)=>{                         // purchase Confirm
  return new Promise((resolve, reject)=>{
    axios.post("/Purchase/confirm", form_inputs)
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
      reject()
    })
  })
}