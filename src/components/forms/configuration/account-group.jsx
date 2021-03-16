import React from 'react';
import {TextField, Button, FormControl, InputLabel, Select, MenuItem} from '@material-ui/core';
import cogoToast from 'cogo-toast';
import {group_require} from './require';
import checkValidation from 'util/checkValidation';
import { DataSaving } from '../../loading/DataSaving';
import { controlTypes, postAccountGroup } from 'pages/configuration/server_action';


// eslint-disable-next-line
export default React.memo(({updateList, update, group_info, handleClose})=>{
  const [form_inputs, setFormInputs] = React.useState(update?{...group_info}:{})
  const [control_types, setControlTypes] = React.useState([])
  const [requires, setRequireFields] = React.useState(group_require)
  const [saving, setSaving] = React.useState(false)

  React.useEffect(()=>{
    controlTypes()
      .then(resp => resp.success && setControlTypes(resp.message))
  }, [])
  
  const handleChange = React.useCallback((e)=>{
    let inputs = form_inputs
    if(e.target.name === 'control_type')
      inputs['ac_type'] = control_types.find(val=>val.key===e.target.value)['ac_type']
    inputs[e.target.name] = e.target.value
    setFormInputs({...inputs})
  }, [form_inputs, control_types])

  const handleSave = React.useCallback(()=>{
    const {isFormValid, require_fields} = checkValidation(form_inputs, requires)
    if(isFormValid){
      setSaving(true)
      postAccountGroup(form_inputs)
        .then(resp => {
          if(resp.success){
            cogoToast.success(`Account Group ${update?'Updated':'Added'} Successfully`)
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
        <div className="col-md-8 col-12">
          <TextField
            label="Group Name"
            placeholder="Group Name"
            variant="outlined"
            margin="dense"
            fullWidth
            name="ac_group_name"
            required
            error={requires.ac_group_name}
            value={form_inputs.ac_group_name}
            onChange={handleChange}
          />
        </div>
        <div className="col-md-4 col-12">
          <FormControl fullWidth size="small" margin="dense" variant="outlined" required error={requires.control_type}>
            <InputLabel id="control-label">Control Type</InputLabel>
            <Select
              labelId="control-label"
              name="control_type"
              label="Control Type"
              value={form_inputs.control_type}
              onChange={handleChange}
            >
              {control_types.map(val=>(
                <MenuItem key={val.id} value={val.key}>{val.name}</MenuItem>
              ))}
            </Select>
          </FormControl>
        </div>
      </div>

      <div className="form-row">
        <div className="col-lg-6 col-md-4 col-12">
          <TextField
            label="Comments"
            placeholder="Comments"
            variant="outlined"
            margin="dense"
            fullWidth
            multiline
            name="comments"
            value={form_inputs.comments}
            onChange={handleChange}
          />
        </div>
        <div className="col-lg-6">
          <TextField
            label="Description"
            variant="outlined"
            margin="dense"
            fullWidth
            multiline
            placeholder="Description"
            name="description"
            value={form_inputs.description}
            onChange={handleChange}
            onKeyPress={(e)=>e.key==="Enter"&&handleSave()}
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

    </React.Fragment>
  )
})