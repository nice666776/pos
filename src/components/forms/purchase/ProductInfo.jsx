import React from 'react';
import {TextField, FormControl, InputLabel, Select, MenuItem, Button} from '@material-ui/core';
import {product_info_require} from './require';
import cogoToast from 'cogo-toast';
import checkValidation from '../../../util/checkValidation';
import { productData } from '../../../pages/product-configuration/server_action';
import { productList, productInfo } from 'pages/purchase/server_action';


export default React.memo(({update, product_info, handleClose, updateList})=>{
  const [form_inputs, setInputs] = React.useState(update?product_info:{})
  const [requires, setRequireFields] = React.useState(product_info_require)
  const [dropdown, setDropdown] = React.useState({})

  React.useEffect(()=>{
    let drop = {}
    productData()
      .then(resp => {
        if(resp.success){
          const cat_list = resp.message
          drop = {...cat_list}
          if(update){
            const cate = cat_list.categories.find(val=>val.category.code === form_inputs.category_code)
            drop['subcategory_list'] = cate.subcategories
            productList(form_inputs.category_code)
              .then(pro => {drop['product_list'] = pro.message})
              .finally(()=>setDropdown(drop))
          } else setDropdown(drop)
        }
      })
  // eslint-disable-next-line
  }, [])

  const handleChange = React.useCallback((e)=>{
    let inputs = form_inputs
    const cate = dropdown.categories.find(val=>val.category.code === e.target.value)
    if(e.target.name === 'category_code'){
      productList(e.target.value)
        .then(resp => resp.success &&
          setDropdown({...dropdown, subcategory_list: cate.subcategories, product_list: resp.message})
        )
      inputs['category_name'] = cate.category.name
      inputs['subcategory_code'] = null
      inputs['subcategory_name'] = null
      inputs['product_code'] = null
      inputs['product_name'] = null
    } else if((['subcategory_code', 'product_code']).indexOf(e.target.name)>-1){
      if(e.target.name === 'subcategory_code') {
        inputs['subcategory_name'] = e.target.value ? dropdown.subcategory_list.find(val=>val.code === e.target.value).name : null
      } else if(e.target.name === 'product_code') {
        inputs['product_name'] = dropdown.product_list.find(val=>val.product_code===e.target.value).product_name
        productInfo(e.target.value)
          .then(resp => {
            resp.success &&
              setInputs(prev=>({...prev, mrp_price: resp.message.mrp_price, unit_price: resp.message.unit_price, available_quantity: resp.message.quantity}))
          })
      }
    }
    setInputs({...inputs, [e.target.name]: (['quantity', 'unit_price', 'mrp_price']).indexOf(e.target.name) > -1 ? parseFloat(e.target.value):e.target.value})
  }, [form_inputs, dropdown])


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
        <div className="col-md-6">
          <FormControl fullWidth size="small" margin="dense" variant="outlined" required error={requires.category_code}>
            <InputLabel id="suppiler-label">Category</InputLabel>
            <Select
              labelId="category-label"
              name="category_code"
              label="Category"
              value={form_inputs.category_code}
              onChange={handleChange}
            >
              {dropdown.categories && dropdown.categories.map(val => 
                <MenuItem key={val.category.code} value={val.category.code}>{val.category.name}</MenuItem>
              )}
            </Select>
          </FormControl>
        </div>
        <div className="col-md-6">
          <FormControl fullWidth size="small" margin="dense" variant="outlined">
            <InputLabel id="subcategory-label">Subcategory</InputLabel>
            <Select
              labelId="subcategory-label"
              name="subcategory_code"
              label="Subcategory"
              value={form_inputs.subcategory_code || ''}
              onChange={handleChange}
            >
              {dropdown.subcategory_list && dropdown.subcategory_list.map(val=>
                <MenuItem key={val.code} value={val.code}>{val.name}</MenuItem>
              )}
              <MenuItem value={null}>None</MenuItem>
            </Select>
          </FormControl>
        </div>
      </div>

      <div className="form-row">
        <div className="col-md-8">
          <FormControl fullWidth size="small" margin="dense" variant="outlined" required error={requires.product_code}>
            <InputLabel id="product-label">Product</InputLabel>
            <Select
              labelId="product-label"
              name="product_code"
              label="Product"
              value={form_inputs.product_code || ''}
              onChange={handleChange}
            >
              {dropdown.product_list && !form_inputs.subcategory_code
                ? dropdown.product_list.map(val=>(
                    <MenuItem key={val.product_code} value={val.product_code}>{val.product_name}</MenuItem>
                  ))
                : dropdown.product_list && form_inputs.subcategory_code
                  ? dropdown.product_list.map(val=>(
                      form_inputs.subcategory_code === val.subcategory_code &&
                        <MenuItem key={val.product_code} value={val.product_code}>{val.product_name}</MenuItem>
                    ))
                  : <MenuItem className="text-secondary" disabled>No Product Found!</MenuItem>
              }
            </Select>
          </FormControl>
        </div>
        <div className="col-md-4">
          <TextField                                     // Available Quantity
            label="Available Quantity"
            name="available_quantity"
            type="number"
            fullWidth
            variant="outlined"
            size='small'
            margin="dense"
            disabled
            value={form_inputs.available_quantity}
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
            margin="dense"
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
            margin="dense"
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
            margin="dense"
            error={requires.mrp_price}
            value={form_inputs.mrp_price}
            onChange={handleChange}
            InputLabelProps={{shrink: true}}
          />
        </div>
      </div>

      <div className="form-row">
        <div className="col-md-8">
          <TextField                                     // expire date
            label="Expire Date"
            name="expire_date"
            type="date"
            fullWidth
            variant="outlined"
            size='small'
            margin="dense"
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