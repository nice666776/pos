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

export const tradeList = ()=>{                                      // trade list
  return new Promise((resolve, reject)=>{
    axios.get('/trade')
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
      reject()
    })
  })
}

export const postUserData = (form_inputs, update)=>{                // user add or update
  const url = update?'/pos/updatebyadmin':'/pos/registration'
  return new Promise((resolve, reject)=>{
    axios.post(url, form_inputs)
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
      reject()
    })
  })
}

export const userList = ()=>{                                        // user list
  return new Promise((resolve, reject)=>{
    axios.get('/Pos/userlist')
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
      reject()
    })
  })
}