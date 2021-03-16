import axios from 'util/Api';
import showError from 'util/showError';


export const accountsHeadList = (type)=>{                  // get account head list
  return new Promise((resolve, reject)=>{
    axios.get(`/accountshead/entry_point?type=${type}`)
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
			reject()
    })
  })
}

export const postTransaction = (type, form_inputs)=>{                  // post transaction form
  const url = type==='E' ? '/accounts/payment/submit' : '/accounts/receipt/submit'
  return new Promise((resolve, reject)=>{
    axios.post(url, form_inputs)
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
			reject()
    })
  })
}

export const transactionHistory = (type)=>{                       // payment and receipt transaction history
  const url = type==='E' ? '/accounts/payment/list' : '/accounts/receipt/list'
  return new Promise((resolve, reject)=>{
    axios.get(url)
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
			reject()
    })
  })
}