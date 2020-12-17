// eslint-disable-next-line
export default (form_data, require_fields, setValidFields) =>{
  let valid = true
  Object.keys(require_fields).map(fields=>{
    if(!form_data[fields]){
      require_fields[fields] = true;
      valid = false
    } else {
      require_fields[fields] = false;
    }
    return 0
  })
  setValidFields && setValidFields(require_fields)
  return {isFormValid: valid, require_fields: require_fields}
}