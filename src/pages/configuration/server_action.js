import axios from '../../util/Api';
import showError from '../../util/showError';


export const postSupplierInfo = (form_data)=>{                  // Supplier add
  return new Promise((resolve, reject)=>{
    axios.post('/supplier/add', form_data)
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
			reject()
    })
  })
}

export const supplierList = ()=>{                                    // Supplier list
  return new Promise((resolve, reject)=>{
    axios.get('/supplier')
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
      reject()
    })
  })
}

export const postTrade = (form_inputs)=>{                          // Trade add or update
  return new Promise((resolve, reject)=>{
    axios.post('/trade/add', form_inputs)
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
      reject()
    })
  })
}

export const tardeList = ()=>{                                      // trade list
  return new Promise((resolve, reject)=>{
    axios.get('/trade')
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
      reject()
    })
  })
}