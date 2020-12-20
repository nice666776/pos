import axios from '../../util/Api';
import showError from '../../util/showError';

export const manufacturerList = ()=>{                              // Manufacturer list
  return new Promise((resolve, reject)=>{
    axios.get('/manufacturer')
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
      reject()
    })
  })
}

export const postManufacturerInfo = (form_data)=>{                  // manufacturer add
  return new Promise((resolve, reject)=>{
    axios.post('/manufacturer/add', form_data)
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
			reject()
    })
  })
}

export const categoryList = ()=>{                              // Category list
  return new Promise((resolve, reject)=>{
    axios.get('/category')
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
      reject()
    })
  })
}

export const postCategoryInfo = (form_data)=>{                  // Category add
  return new Promise((resolve, reject)=>{
    axios.post('/category/add', form_data)
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
			reject()
    })
  })
}