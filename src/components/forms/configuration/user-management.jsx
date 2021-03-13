import React from 'react';
import {TextField, Button, FormControl, InputLabel, Select, MenuItem, OutlinedInput, InputAdornment, IconButton} from '@material-ui/core';
import {VisibilityOutlined, VisibilityOffOutlined} from '@material-ui/icons';
import Autocomplete from '@material-ui/lab/Autocomplete';
import cogoToast from 'cogo-toast';
import {user_require} from './require';
import checkValidation from 'util/checkValidation';
import { DataSaving } from '../../loading/DataSaving';
import { tradeList, postUserData } from 'pages/configuration/server_action';


// eslint-disable-next-line
export default React.memo(({updateList, update, user_info, handleClose})=>{
  const [form_inputs, setFormInputs] = React.useState(update?{...user_info}:{status: true})
  const [trade_list, setTradeList] = React.useState([])
  const [showPassword, setShowPassword] = React.useState(false)
  const [requires, setRequireFields] = React.useState({})
  const [saving, setSaving] = React.useState(false)


  React.useEffect(()=>{
    let req_obj = {...user_require}
    if(update){ delete req_obj.password }
    setRequireFields(req_obj)
    tradeList()
      .then(resp => resp.success && setTradeList(resp.message))
  // eslint-disable-next-line
  }, [])
  
  const handleChange = React.useCallback((e, val)=>{
    if(e.target.name === undefined){
      e = {target: {name: 'trade_list', value: val}}
    }
    setFormInputs({...form_inputs, [e.target.name]: e.target.value})
  }, [form_inputs])

  const handleSave = React.useCallback(()=>{
    const {isFormValid, require_fields} = checkValidation(form_inputs, requires)
    if(isFormValid){
      setSaving(true)
      postUserData(form_inputs, update)
        .then(resp => {
          if(resp.success){
            cogoToast.success(`User ${update?'Updated':'Added'} Successfully`)
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
            label="First Name"
            variant="outlined"
            margin="dense"
            fullWidth
            placeholder="First Name"
            name="first_name"
            required
            error={requires.first_name}
            value={form_inputs.first_name}
            onChange={handleChange}
          />
        </div>
        <div className="col-md-6 col-12">
          <TextField
            label="Last Name"
            variant="outlined"
            margin="dense"
            fullWidth
            placeholder="Last Name"
            name="last_name"
            required
            error={requires.last_name}
            value={form_inputs.last_name}
            onChange={handleChange}
          />
        </div>
      </div>

      <div className="form-row">
        <div className="col-md-5 col-sm-6 col-12">
          <TextField
            label="Mobile"
            variant="outlined"
            margin="dense"
            fullWidth
            placeholder="Mobile"
            name="phone"
            required
            disabled={update}
            error={requires.phone}
            value={form_inputs.phone}
            onChange={handleChange}
          />
        </div>
        <div className="col-md-7 col-sm-6 col-12">
          <TextField
            label="Email"
            placeholder="Email"
            variant="outlined"
            margin="dense"
            fullWidth
            name="email"
            required
            error={requires.email}
            value={form_inputs.email}
            onChange={handleChange}
          />
        </div>
      </div>

      <div className="form-row">
        <div className="col-md-8">
          <Autocomplete
            multiple
            options={trade_list}
            getOptionLabel={(option) => option.name}
            defaultValue={form_inputs.trade_list}
            filterOptions={op=>op.filter(val=>form_inputs.trade_list?form_inputs.trade_list.map(tr=>tr.id).indexOf(val.id)===-1:val)}
            filterSelectedOptions
            size="small"
            onChange={handleChange}
            renderInput={(params) => (
              <TextField
                {...params}
                size="small"
                margin="dense"
                variant="outlined"
                label="Trade"
                placeholder="Select Trade"
                required
                error={requires.trade_list}
              />
            )}
          />
        </div>
        <div className="col-md-4">
          <FormControl variant="outlined" margin="dense" size="small" fullWidth required error={requires.user_type} disabled={update}>
            <InputLabel>Role</InputLabel>
            <Select name="user_type" value={form_inputs.user_type} onChange={handleChange} label="Role">
              <MenuItem value="ADMIN">ADMIN</MenuItem>
              <MenuItem value="ACCOUNTS">ACCOUNTS</MenuItem>
              <MenuItem value="SALES">SALES</MenuItem>
              <MenuItem value="INVENTORY">INVENTORY</MenuItem>
            </Select>
          </FormControl>
        </div>
      </div>

      <div className="form-row">
        <div className="col-md-8">
          <FormControl variant="outlined" size="small" margin="dense" required error={requires.password}>
            <InputLabel htmlFor="password">{update?'Change Password':'Password'}</InputLabel>
            <OutlinedInput
              name="password"
              type={showPassword ? 'text' : 'password'}
              value={form_inputs.password?form_inputs.password:''}
              onChange={handleChange}
              endAdornment={
                <InputAdornment position="end">
                  <IconButton
                    onClick={()=>setShowPassword(!showPassword)}
                    onMouseDown={()=>setShowPassword(!showPassword)}
                    edge="end"
                  >
                    {showPassword ? <VisibilityOutlined fontSize="small" color="secondary" /> : <VisibilityOffOutlined fontSize="small" />}
                  </IconButton>
                </InputAdornment>
              }
              labelWidth={update?140:80}
            />
          </FormControl>
        </div>
        <div className="col-md-4">
          <FormControl variant="outlined" margin="dense" size="small" fullWidth>
            <InputLabel>Status</InputLabel>
            <Select name="status" value={form_inputs.status} onChange={handleChange} label="Status">
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