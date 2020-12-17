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
import {require_fields as rf} from './require';
import checkValidation from '../../../util/checkValidation';
import { DataSaving } from '../../loading/DataSaving';
import { postSupplierInfo } from '../../../pages/configuration/server_action';
var address = require('../../../util/area.json');


// eslint-disable-next-line
export default React.memo(({updateList, update, supplier_info, handleClose})=>{
  const [form_inputs, setFormInputs] = React.useState(update?{...supplier_info}:{supplier_type: true})
  const [requires, setRequireFields] = React.useState(rf)
  const division_list = address.message
  const [district_list, setDistrictList] = React.useState([])
  const [thana_list, setThanaList] = React.useState([])
  const [saving, setSaving] = React.useState(false)

  React.useEffect(()=>{
    if(update){
      const dis_list = division_list.filter(val=>val.name === form_inputs.division)[0].districts
      setDistrictList(dis_list)
      setThanaList(dis_list.filter(val=>val.name === form_inputs.district)[0].thanas)
    }
    // eslint-disable-next-line
  }, [])

  const handleChange = React.useCallback((e)=>{
    if(e.target.name === 'division'){
      setDistrictList(division_list.filter(val=>val.name === e.target.value)[0].districts)
      setFormInputs({...form_inputs, [e.target.name]: e.target.value, thana: null, district: null})
      return
    } else if(e.target.name === 'district') {
      setThanaList(district_list.filter(val=>val.name === e.target.value)[0].thanas)
      setFormInputs({...form_inputs, [e.target.name]: e.target.value, thana: null})
      return
    }
    setFormInputs({...form_inputs, [e.target.name]: e.target.value})
  }, [division_list, district_list, form_inputs])

  const handleSave = React.useCallback(()=>{
    const {isFormValid, require_fields} = checkValidation(form_inputs, requires)
    if(isFormValid){
      setSaving(true)
      postSupplierInfo(form_inputs)
        .then(resp => {
          cogoToast.success(`Supplier ${update?'Updated':'Added'} Successfully`)
          updateList(resp, `${update?'UPDATE':'ADD_NEW'}`)
        })
        .finally(() => setSaving(false))
    } else cogoToast.error('Please fill all required fields')
    setRequireFields({...require_fields})
  }, [form_inputs, requires, update, updateList])


  return(
    <form>
      <div className="form-row">
        <div className="col-md-6 col-12">
          <TextField
            label="Supplier Name"
            variant="outlined"
            margin="dense"
            fullWidth
            placeholder="Supplier Name"
            name="name"
            required
            error={requires.name}
            value={form_inputs.name}
            onChange={handleChange}
          />
        </div>
        <div className="col-md-6 col-12">
          <TextField
            label="Company name"
            variant="outlined"
            margin="dense"
            fullWidth
            placeholder="Company Name"
            name="company"
            required
            error={requires.company}
            value={form_inputs.company}
            onChange={handleChange}
          />
        </div>
      </div>

      <div className="form-row">
        <div className="col-lg-4 col-md-4 col-sm-6">
          <FormControl fullWidth size="small" margin="dense" variant="outlined" required error={requires.division}>
            <InputLabel id="division-label">Division</InputLabel>
            <Select
              labelId="division-label"
              name="division"
              label="Division"
              value={form_inputs.division}
              onChange={handleChange}
            >
              {division_list.map(val=>(
                <MenuItem key={val.id} value={val.name}>{val.name}</MenuItem>
              ))}
            </Select>
          </FormControl>
        </div>
        <div className="col-lg-4 col-md-4 col-sm-6">
          <FormControl fullWidth size="small" margin="dense" variant="outlined" required error={requires.district}>
            <InputLabel id="district-label">District</InputLabel>
            <Select
              labelId="district-label"
              name="district"
              label="District"
              value={form_inputs.district?form_inputs.district:''}
              onChange={handleChange}
            >
              {district_list.map(val=>(
                <MenuItem key={val.id} value={val.name}>{val.name}</MenuItem>
              ))}
            </Select>
          </FormControl>
        </div>
        <div className="col-lg-4 col-md-4 col-sm-6">
          <FormControl fullWidth size="small" margin="dense" variant="outlined" required error={requires.thana}>
            <InputLabel id="thana-label">Thana</InputLabel>
            <Select
              labelId="thana-label"
              name="thana"
              label="Thana"
              value={form_inputs.thana?form_inputs.thana:''}
              onChange={handleChange}
            >
              {thana_list.map(val=>(
                <MenuItem key={val} value={val}>{val}</MenuItem>
              ))}
            </Select>
          </FormControl>
        </div>
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
        <div className="col-sm-4 col-12">
          <TextField
            label="Mobile"
            variant="outlined"
            margin="dense"
            fullWidth
            type="number"
            placeholder="Mobile"
            name="mobile"
            required
            error={requires.mobile}
            value={form_inputs.mobile}
            onChange={handleChange}
          />
        </div>
        <div className="col-lg-4 col-md-4 col-12">
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
        <div className="col-lg-3 col-md-3 col-sm-4 col-12">
          <FormControl fullWidth size="small" margin="dense" variant="outlined" required>
            <InputLabel id="supplier_type-label">Supplier Type</InputLabel>
            <Select
              labelId="supplier_type-label"
              name="supplier_type"
              label="Supplier Type"
              value={form_inputs.supplier_type}
              onChange={handleChange}
            >
              <MenuItem value={true}>Active</MenuItem>
              <MenuItem value={false}>Inactive</MenuItem>
            </Select>
          </FormControl>
        </div>
        <div className="col-md-8">
          <TextField
            label="Remarks"
            variant="outlined"
            margin="dense"
            fullWidth
            placeholder="Remarks"
            name="remarks"
            value={form_inputs.remarks}
            onChange={handleChange}
          />
        </div>
      </div>

      <div className="text-center mt-2">
        <Button className="text-capitalize mr-2" variant="outlined" color="primary" size="small" onClick={handleClose} disabled={saving}>
          Cancel
        </Button>
        <Button className="text-capitalize" variant="contained" color="primary" size="small" onClick={handleSave} disabled={saving}>
          Save {saving && <DataSaving/>}
        </Button>
      </div>

    </form>
  )
})