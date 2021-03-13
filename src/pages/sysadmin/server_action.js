import axios from '../../util/Api';
import showError from '../../util/showError';


const makeFormData = std_data => {
	let data = new FormData()
	Object.keys(std_data).map(field=>{
		data.append(field, std_data[field])
		return 0
	})
	return data
}


export const createClient = (form_inputs)=>{                     // create client and new admin
  return new Promise((resolve, reject)=>{
    const form_data = makeFormData(form_inputs)
    axios.post("/client/add", form_data)
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
      reject()
    })
  })
}

export const getClientInfo = ()=>{                     // get client information
  return new Promise((resolve, reject)=>{
    axios.get("/client/exists")
    .then(resp => resolve(resp.data))
    .catch(err=>{
			showError(err)
      reject()
    })
  })
}