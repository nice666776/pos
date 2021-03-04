import React from 'react';
import {
  TextField,
  Button,
  FormControl,
  InputLabel,
  MenuItem,
  Select
} from '@material-ui/core';
import cogoToast from 'cogo-toast';
import {product_require} from './require';
import checkValidation from '../../../util/checkValidation';
import { DataSaving } from '../../loading/DataSaving';
import { addProduct, productData } from '../../../pages/product-configuration/server_action';


// eslint-disable-next-line
export default React.memo(({updateList, update, manufacturer_info, handleClose})=>{
  const [form_inputs, setFormInputs] = React.useState(update?{...manufacturer_info}:{status: true})
  const [form_data, setFormData] = React.useState({})
  const [requires, setRequireFields] = React.useState(product_require)
  const [saving, setSaving] = React.useState(false)

  React.useEffect(()=>{
    productData()
      .then(resp => resp.success && setFormData(resp.message))
  }, [setFormData])

  const handleChange = React.useCallback((e)=>{
    let value = e.target.value
    if((['mrp_price', 'reorder_level', 'unit_price']).indexOf(e.target.name) !== -1)
      value = parseFloat(e.target.value)
    else if(e.target.name === 'category_code')
      form_inputs['subcategory_code'] = null
    setFormInputs({...form_inputs, [e.target.name]: value})
  }, [form_inputs])

  const handleSave = React.useCallback(()=>{
    const {isFormValid, require_fields} = checkValidation(form_inputs, requires)
    if(isFormValid){
      setSaving(true)
      addProduct(form_inputs)
        .then(resp => {
          if(resp.success){
            cogoToast.success(`Product ${update?'Updated':'Added'} Successfully`)
            updateList(resp.message, `${update?'UPDATE':'ADD_NEW'}`)
          } else cogoToast.error(resp.message)
        })
        .finally(() => setSaving(false))
    } else cogoToast.error('Please fill all required fields')
    setRequireFields({...require_fields})
  }, [form_inputs, requires, update, updateList])


  return(
    <form>
      <div className="form-row">
        <div className="col">
          <TextField
            label="Product Name"
            placeholder="Product Name"
            name="product_name"
            variant="outlined"
            margin="dense"
            fullWidth
            required
            error={requires.product_name}
            value={form_inputs.product_name}
            onChange={handleChange}
          />
        </div>
      </div>

      <div className="form-row">
        <div className="col-md-6 col-12">
          <FormControl fullWidth size="small" margin="dense" variant="outlined" required error={requires.category_code}>
            <InputLabel id="category-label">Category</InputLabel>
            <Select
              labelId="category-label"
              name="category_code"
              label="Category"
              value={form_inputs.category_code}
              onChange={handleChange}
            >
              {form_data.categories && form_data.categories.map(val => 
                <MenuItem key={val.category.code} value={val.category.code}>{val.category.name}</MenuItem>
              )}
            </Select>
          </FormControl>
        </div>
        <div className="col-md-6 col-12">
          <FormControl fullWidth size="small" margin="dense" variant="outlined">
            <InputLabel id="category-label">Subcategory</InputLabel>
            <Select
              labelId="category-label"
              name="subcategory_code"
              label="Subcategory"
              value={form_inputs.subcategory_code || ''}
              onChange={handleChange}
            >
              {form_inputs.category_code && form_data.categories && form_data.categories.find(val => val.category.code===form_inputs.category_code).subcategories.map(val=>
                <MenuItem key={val.code} value={val.code}>{val.name}</MenuItem>
              )}
            </Select>
          </FormControl>
        </div>
      </div>

      <div className="form-row">
        <div className="col-md-8 col-12">
          <FormControl fullWidth size="small" margin="dense" variant="outlined">
            <InputLabel id="manufacturer-label">Manufacturer</InputLabel>
            <Select
              labelId="manufacturer-label"
              name="manufacturer_code"
              label="Manufacturer"
              value={form_inputs.manufacturer_code}
              onChange={handleChange}
            >
              {form_data.manufacturers && form_data.manufacturers.map(val => 
                <MenuItem key={val.code} value={val.code}>{val.name}</MenuItem>
              )}
            </Select>
          </FormControl>
        </div>
      </div>

      <div className="form-row">
        <div className="col">
          <FormControl fullWidth size="small" margin="dense" variant="outlined" required error={requires.product_unit}>
            <InputLabel id="unit-label">Product unit</InputLabel>
            <Select
              labelId="unit-label"
              name="product_unit"
              label="Product unit"
              value={form_inputs.product_unit}
              onChange={handleChange}
            >
              {form_data.units && form_data.units.map(val => 
                <MenuItem key={val.code} value={val.name}>{val.name}</MenuItem>
              )}
            </Select>
          </FormControl>
        </div>
        <div className="col">
          <TextField
            label="Unit Price"
            placeholder="Unit Price"
            name="unit_price"
            variant="outlined"
            margin="dense"
            type="number"
            fullWidth
            disabled={update}
            value={form_inputs.unit_price}
            onChange={handleChange}
          />
        </div>
        <div className="col">
          <TextField
            label="MRP Price"
            placeholder="MRP Price"
            name="mrp_price"
            variant="outlined"
            margin="dense"
            type="number"
            fullWidth
            value={form_inputs.mrp_price}
            onChange={handleChange}
          />
        </div>
      </div>

      <div className="form-row">
        <div className="col-md-7">
          <TextField
            label="Reorder level"
            placeholder="Reorder level"
            name="reorder_level"
            variant="outlined"
            margin="dense"
            fullWidth
            value={form_inputs.reorder_level}
            onChange={handleChange}
          />
        </div>
        <div className="col-md-5 col-12">
          <FormControl fullWidth size="small" margin="dense" variant="outlined" required>
            <InputLabel id="status-label">Status</InputLabel>
            <Select
              labelId="status-label"
              name="status"
              label="Status"
              value={form_inputs.status}
              onChange={handleChange}
            >
              <MenuItem value={true}>Active</MenuItem>
              <MenuItem value={false}>Inactive</MenuItem>
            </Select>
          </FormControl>
        </div>
      </div>

      <div className="form-row">
        <div className="col">
          <TextField
            label="Description"
            placeholder="Description"
            name="description"
            variant="outlined"
            margin="dense"
            fullWidth
            multiline
            value={form_inputs.description}
            onChange={handleChange}
          />
        </div>
      </div>

      <div className="text-center mt-3">
        <Button className="mr-2" variant="outlined" color="primary" size="small" onClick={handleClose} disabled={saving}>
          Cancel
        </Button>
        <Button variant="contained" color="primary" size="small" onClick={handleSave} disabled={saving}>
          Save {saving && <DataSaving/>}
        </Button>
      </div>

    </form>
  )
})