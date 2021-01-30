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
import {manufacturer_require} from './require';
import checkValidation from '../../../util/checkValidation';
import { DataSaving } from '../../loading/DataSaving';
import { postManufacturerInfo } from '../../../pages/product-configuration/server_action';


// eslint-disable-next-line
export default React.memo(({updateList, update, manufacturer_info, handleClose})=>{
  const [form_inputs, setFormInputs] = React.useState(update?{...manufacturer_info}:{status: true})
  const [requires, setRequireFields] = React.useState(manufacturer_require)
  const [saving, setSaving] = React.useState(false)


  const handleChange = React.useCallback((e)=>{
    setFormInputs({...form_inputs, [e.target.name]: e.target.value})
  }, [form_inputs])

  const handleSave = React.useCallback(()=>{
    const {isFormValid, require_fields} = checkValidation(form_inputs, requires)
    if(isFormValid){
      setSaving(true)
      postManufacturerInfo(form_inputs)
        .then(resp => {
          cogoToast.success(`Manufacturer ${update?'Updated':'Added'} Successfully`)
          updateList(resp, `${update?'UPDATE':'ADD_NEW'}`)
        })
        .finally(() => setSaving(false))
    } else cogoToast.error('Please fill all required fields')
    setRequireFields({...require_fields})
  }, [form_inputs, requires, update, updateList])


  return(
    <form>
      <div className="form-row">
        <div className="col-md-8 col-12">
          <TextField
            label="Manufacturer Name"
            variant="outlined"
            margin="dense"
            fullWidth
            placeholder="Manufacturer Name"
            name="name"
            required
            error={requires.name}
            value={form_inputs.name}
            onChange={handleChange}
          />
        </div>
        <div className="col-md-4 col-12">
          <TextField
            label="Brand"
            variant="outlined"
            margin="dense"
            fullWidth
            placeholder="Brand"
            name="brand"
            required
            error={requires.brand}
            value={form_inputs.brand}
            onChange={handleChange}
          />
        </div>
      </div>

      <div className="form-row">
        <div className="col">
          <TextField
            label="Contact Person"
            variant="outlined"
            margin="dense"
            fullWidth
            placeholder="Contact Person"
            name="contact_person"
            required
            error={requires.contact_person}
            value={form_inputs.contact_person}
            onChange={handleChange}
          />
        </div>
      </div>

      <div className="form-row">
        <div className="col-md-6 col-12">
          <TextField
            label="Phone"
            variant="outlined"
            margin="dense"
            fullWidth
            type="number"
            placeholder="Phone"
            name="phone"
            required
            error={requires.phone}
            value={form_inputs.phone}
            onChange={handleChange}
          />
        </div>
        <div className="col-md-6 col-12">
          <TextField
            label="Email"
            variant="outlined"
            margin="dense"
            fullWidth
            type="email"
            placeholder="Email"
            name="email"
            required
            error={requires.email}
            value={form_inputs.email}
            onChange={handleChange}
          />
        </div>
      </div>

      <div className="form-row">
        <div className="col">
          <TextField
            label="Address"
            variant="outlined"
            margin="dense"
            fullWidth
            multiline
            placeholder="Address"
            name="address"
            required
            error={requires.address}
            value={form_inputs.address}
            onChange={handleChange}
          />
        </div>
      </div>

      <div className="form-row">
        <div className="col-md-9">
          <TextField
            label="Comments"
            variant="outlined"
            margin="dense"
            fullWidth
            placeholder="Comments"
            name="comments"
            value={form_inputs.comments}
            onChange={handleChange}
          />
        </div>
        <div className="col-lg-3 col-md-3 col-sm-4 col-12">
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