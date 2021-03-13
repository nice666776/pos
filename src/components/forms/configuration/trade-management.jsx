import React from 'react';
import {TextField, Button} from '@material-ui/core';
import cogoToast from 'cogo-toast';
import {trade_require} from './require';
import checkValidation from '../../../util/checkValidation';
import { DataSaving } from '../../loading/DataSaving';
import { postTrade } from '../../../pages/configuration/server_action';


// eslint-disable-next-line
export default React.memo(({updateList, update, trade_info, handleClose})=>{
  const [form_inputs, setFormInputs] = React.useState(update?{...trade_info}:{})
  const [requires, setRequireFields] = React.useState(trade_require)
  const [saving, setSaving] = React.useState(false)

  
  const handleChange = React.useCallback((e)=>{
    setFormInputs({...form_inputs, [e.target.name]: e.target.value})
  }, [form_inputs])

  const handleSave = React.useCallback(()=>{
    const {isFormValid, require_fields} = checkValidation(form_inputs, requires)
    if(isFormValid){
      setSaving(true)
      postTrade(form_inputs)
        .then(resp => {
          if(resp.success){
            cogoToast.success(`Trade ${update?'Updated':'Added'} Successfully`)
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
        <div className="col-md-6 col-12">
          <TextField
            label="Trade Name"
            variant="outlined"
            margin="dense"
            fullWidth
            placeholder="Trade Name"
            name="name"
            required
            error={requires.name}
            value={form_inputs.name}
            onChange={handleChange}
          />
        </div>
        <div className="col-md-6 col-12">
          <TextField
            label="In Charge"
            variant="outlined"
            margin="dense"
            fullWidth
            placeholder="In Charge"
            name="in_charge"
            value={form_inputs.in_charge}
            onChange={handleChange}
          />
        </div>
      </div>

      <div className="form-row">
        <div className="col-sm-4 col-12">
          <TextField
            label="Phone"
            variant="outlined"
            margin="dense"
            fullWidth
            placeholder="Phone"
            name="phone"
            value={form_inputs.phone}
            onChange={handleChange}
          />
        </div>
        <div className="col-lg-4 col-md-4 col-12">
          <TextField
            label="Block"
            placeholder="Block"
            variant="outlined"
            margin="dense"
            fullWidth
            name="block"
            value={form_inputs.block}
            onChange={handleChange}
          />
        </div>
        <div className="col-lg-4 col-md-4 col-12">
          <TextField
            label="Floor"
            variant="outlined"
            margin="dense"
            fullWidth
            placeholder="Floor"
            name="floor"
            value={form_inputs.floor}
            onChange={handleChange}
          />
        </div>
        <div className="col-md-8">
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