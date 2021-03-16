import React from 'react';
import {TextField, Button, FormControl, InputLabel, Select, MenuItem} from '@material-ui/core';
import cogoToast from 'cogo-toast';
import {head_require} from './require';
import checkValidation from 'util/checkValidation';
import { DataSaving } from '../../loading/DataSaving';
import { acGroupDropdown, postAccountHead } from 'pages/configuration/server_action';


// eslint-disable-next-line
export default React.memo(({updateList, update, head_info, handleClose})=>{
  const [form_inputs, setFormInputs] = React.useState(update?{...head_info}:{ac_status: true})
  const [group_list, setGroupList] = React.useState([])
  const [requires, setRequireFields] = React.useState(head_require)
  const [saving, setSaving] = React.useState(false)

  React.useEffect(()=>{
    acGroupDropdown()
      .then(resp => resp.success && setGroupList(resp.message))
  }, [])

  
  const handleChange = React.useCallback((e)=>{
    let inputs = form_inputs
    if(e.target.name === 'ac_group_id')
      inputs['ac_type'] = group_list.find(val=>val.ac_group_id===e.target.value)['ac_type']
    inputs[e.target.name] = e.target.value
    setFormInputs({...inputs})
  }, [form_inputs, group_list])

  const handleSave = React.useCallback(()=>{
    const {isFormValid, require_fields} = checkValidation(form_inputs, requires)
    if(isFormValid){
      setSaving(true)
      postAccountHead(form_inputs)
        .then(resp => {
          if(resp.success){
            cogoToast.success(`Account Head ${update?'Updated':'Added'} Successfully`)
            updateList(resp.message, `${update?'UPDATE':'ADD'}`)
          } else cogoToast.error(resp.message)
        })
        .finally(() => setSaving(false))
    } else cogoToast.error('Please, fill up all required fields!')
    setRequireFields({...require_fields})
  }, [form_inputs, requires, update, updateList])


  return(
    <React.Fragment>
      <div className="form-row">
        <div className="col">
          <TextField
            label="Head Name"
            placeholder="Head Name"
            variant="outlined"
            margin="dense"
            fullWidth
            name="ac_head_name"
            required
            error={requires.ac_head_name}
            value={form_inputs.ac_head_name}
            onChange={handleChange}
          />
        </div>
      </div>

      <div className="form-row">
        <div className="col-md-8">
          <FormControl fullWidth size="small" margin="dense" variant="outlined" required error={requires.ac_group_id}>
            <InputLabel id="account_group-label">Account Group</InputLabel>
            <Select
              labelId="account_group-label"
              name="ac_group_id"
              label="Account Group"
              value={form_inputs.ac_group_id}
              onChange={handleChange}
            >
              {group_list.map(val=>(
                <MenuItem key={val.ac_group_id} value={val.ac_group_id}>{val.ac_group_name}</MenuItem>
              ))}
            </Select>
          </FormControl>
        </div>
      </div>

      <div className="form-row">
        <div className="col-md-9">
          <TextField
            label="Description"
            variant="outlined"
            margin="dense"
            fullWidth
            placeholder="Description"
            name="description"
            value={form_inputs.description}
            onChange={handleChange}
            onKeyPress={(e)=>e.key==="Enter"&&handleSave()}
          />
        </div>
        <div className="col-md-3">
          <FormControl fullWidth size="small" margin="dense" variant="outlined">
            <InputLabel id="status-label">Status</InputLabel>
            <Select
              labelId="status-label"
              name="ac_status"
              label="Status"
              value={form_inputs.ac_status}
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

    </React.Fragment>
  )
})