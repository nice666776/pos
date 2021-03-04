import React from 'react';
import {TextField, Button, CircularProgress} from '@material-ui/core';
import Autocomplete from '@material-ui/lab/Autocomplete';
import {product_info_require} from './require';
import cogoToast from 'cogo-toast';
import checkValidation from '../../../util/checkValidation';
import {searchProduct} from 'pages/sales/server_action';


export default React.memo(({update, product_info, handleClose, updateList})=>{
  const [form_inputs, setInputs] = React.useState(update?product_info:{})
  const [requires, setRequireFields] = React.useState(product_info_require)
  const [product_list, setProductList] = React.useState([])
  const [loading, setLoading] = React.useState(false);

  const handleChange = React.useCallback((e)=>{
    let inputs = form_inputs
    setInputs({...inputs, [e.target.name]: (['quantity', 'unit_price', 'mrp_price']).indexOf(e.target.name) > -1 ? parseFloat(e.target.value):e.target.value})
  }, [form_inputs])

  const handleSearch = React.useCallback((e)=>{
    setLoading(true)
    searchProduct(e.target.value)
      .then(resp => {
        if(resp.success)
          setProductList(resp.message)
        else setProductList([])
      })
      .finally(()=>setLoading(false))
  }, [])

  const handleSelected = React.useCallback((e, val)=>{
    setInputs(prev=>({
      ...prev,
      available_quantity: val ? val.quantity : null,
      product_code: val ? val.product_code : null,
      product_name: val ? val.product_name : null,
      category: val ? val.category : null,
      subcategory: val ? val.subcategory : null
    }))
  }, [])


  const handleSave = React.useCallback(()=>{
    const {isFormValid, require_fields} = checkValidation(form_inputs, requires)
    if(isFormValid){
      updateList(form_inputs, update?'EDIT':'ADD')
    } else cogoToast.error('Please, fill up all required fields!')
    setRequireFields({...require_fields})
  }, [form_inputs, requires, updateList, update])


  return(
    <React.Fragment>
      <div className="form-row">
        <div className="col-md-8">
          <Autocomplete
            style={{ minWidth: 350 }}
            loadingText="Searching..."
            noOptionsText="No product found!"
            getOptionLabel={(option) => option.product_name}
            onChange={handleSelected}
            options={product_list}
            loading={loading}
            renderInput={(params) => (
              <TextField
                {...params}
                label="Search Product"
                variant="outlined"
                autoFocus
                size="small"
                margin="normal"
                required
                error={requires.product_code}
                onChange={handleSearch}
                InputProps={{
                  ...params.InputProps,
                  endAdornment: (
                    <React.Fragment>
                      {loading ? <CircularProgress color="secondary" size={20} /> : null}
                      {params.InputProps.endAdornment}
                    </React.Fragment>
                  )
                }}
              />
            )}
          />
        </div>
        <div className="col-md-4">
          <TextField                                     // Available Quantity
            label="Available Quantity"
            name="available_quantity"
            type="number"
            fullWidth
            variant="outlined"
            size='small'
            margin="normal"
            disabled
            value={form_inputs.available_quantity?form_inputs.available_quantity:''}
            InputLabelProps={{shrink: true}}
          />
        </div>
      </div>

      <div className="form-row">
        <div className="col-md-6">
          <TextField                                     // Category
            label="Category"
            name="category"
            fullWidth
            variant="outlined"
            size='small'
            margin="normal"
            disabled
            value={form_inputs.category?form_inputs.category:''}
            InputLabelProps={{shrink: true}}
          />
        </div>
        <div className="col-md-6">
          <TextField                                     // subcategory
            label="Subcategory"
            name="subcategory"
            fullWidth
            variant="outlined"
            size='small'
            margin="normal"
            disabled
            value={form_inputs.subcategory?form_inputs.subcategory:''}
            InputLabelProps={{shrink: true}}
          />
        </div>
      </div>

      <div className="form-row">
        <div className="col-md-4">
          <TextField                                     // Quantity
            label="Quantity"
            name="quantity"
            type="number"
            fullWidth
            variant="outlined"
            size='small'
            margin="normal"
            required
            error={requires.quantity}
            defaultValue={form_inputs.quantity}
            onChange={handleChange}
          />
        </div>
        <div className="col-md-4">
          <TextField                                     // Unit Price
            label="Unit Price"
            name="unit_price"
            type="number"
            fullWidth
            required
            variant="outlined"
            size='small'
            margin="normal"
            error={requires.unit_price}
            value={form_inputs.unit_price}
            onChange={handleChange}
            InputLabelProps={{shrink: true}}
          />
        </div>
        <div className="col-md-4">
          <TextField                                     // MRP Price
            label="MRP Price"
            name="mrp_price"
            type="number"
            fullWidth
            required
            variant="outlined"
            size='small'
            margin="normal"
            error={requires.mrp_price}
            value={form_inputs.mrp_price}
            onChange={handleChange}
            InputLabelProps={{shrink: true}}
          />
        </div>
      </div>

      <div className="form-row">
        <div className="col-md-6">
          <TextField                                     // expire date
            label="Expire Date"
            name="expire_date"
            type="date"
            fullWidth
            variant="outlined"
            size='small'
            margin="normal"
            defaultValue={form_inputs.expire_date}
            onChange={handleChange}
            InputLabelProps={{shrink: true}}
          />
        </div>
      </div>
      <div className="text-center mt-2">
        <Button size="small" variant="outlined" onClick={handleClose}>
          Close
        </Button>
        <Button className="ml-2" size="small" variant="contained" color="primary" onClick={handleSave}>
          Save
        </Button>
      </div>
    </React.Fragment>
  )
})