import React from 'react';
import {TextField, FormControl, InputLabel, Select, MenuItem, OutlinedInput, InputAdornment, IconButton, Button} from '@material-ui/core';
import Visibility from '@material-ui/icons/Visibility';
import VisibilityOff from '@material-ui/icons/VisibilityOff';
import SendRoundedIcon from '@material-ui/icons/SendRounded';
import ImageInput from 'components/input/ImageInput';
import { DataSaving } from 'components/loading/DataSaving';
var address = require('util/area.json');


// eslint-disable-next-line
export default React.memo(({form_inputs, handleChange, handleSubmit, requires, loading, update})=>{
  const division_list = address.message
  const [district_list, setDistrictList] = React.useState([])
  const [thana_list, setThanaList] = React.useState([])
  const [showPassword, setShowPassword] = React.useState(false)

  React.useEffect(()=>{
    if(form_inputs.district){
      const division = division_list.find(val=>val.name===form_inputs.division)
      setDistrictList(division.districts)
      if(division && form_inputs.thana){
        const district = division.districts.find(val=>val.name===form_inputs.district)
        setThanaList(district.thanas)
      }
    }
  // eslint-disable-next-line
  }, [form_inputs.district])

  const handleAddress = React.useCallback((e)=>{
    if(e.target.name === 'division'){
      const division = division_list.find(val=>val.name===e.target.value)
      setDistrictList(division.districts)
      setThanaList([])
    } else if(e.target.name === 'district'){
      const district = district_list.find(val=>val.name===e.target.value)
      setThanaList(district.thanas)
    }
    handleChange(e)
  }, [division_list, district_list, handleChange])


  return(
    <div className="mx-md-5">
      <div className="row">
        <div className="col-xl-10 col-md-8 col-sm-6">
          <div className="form-row">
            <div className="col">
              <TextField
                label="Business Name"
                name="name"
                fullWidth
                size="small"
                variant="outlined"
                margin="normal"
                required
                error={requires.name}
                value={form_inputs.name?form_inputs.name:''}
                onChange={handleChange}
              />
            </div>
          </div>
          <div className="form-row">
            <div className="col-md-3">
              <TextField
                label="Email"
                name="email"
                type="email"
                fullWidth
                required
                size="small"
                variant="outlined"
                margin="normal"
                error={requires.email}
                value={form_inputs.email?form_inputs.email:''}
                onChange={handleChange}
              />
            </div>
            <div className="col-md-3">
              <TextField
                label="Phone Number"
                name="phone"
                type="number"
                fullWidth
                required
                size="small"
                variant="outlined"
                margin="normal"
                error={requires.phone}
                value={form_inputs.phone?form_inputs.phone:''}
                onChange={handleChange}
              />
            </div>
          </div>
          <div className="form-row">
            <div className="col">
              <FormControl variant="outlined" size="small" margin="normal" fullWidth>
                <InputLabel id="division-label">Division</InputLabel>
                <Select
                  labelId="division-label"
                  label="Division"
                  name="division"
                  value={form_inputs.division?form_inputs.division:''}
                  onChange={handleAddress}
                >
                  {division_list.map(division=>(
                    <MenuItem key={division.id} value={division.name}>{division.name}</MenuItem>
                  ))}
                </Select>
              </FormControl>
            </div>
            <div className="col">
              <FormControl variant="outlined" size="small" margin="normal" fullWidth>
                <InputLabel id="district-label">District</InputLabel>
                <Select
                  labelId="district-label"
                  label="District"
                  name="district"
                  value={form_inputs.district?form_inputs.district:''}
                  onChange={handleAddress}
                >
                  {district_list.map(district=>(
                    <MenuItem key={district.id} value={district.name}>{district.name}</MenuItem>
                  ))}
                </Select>
              </FormControl>
            </div>
            <div className="col">
              <FormControl variant="outlined" size="small" margin="normal" fullWidth>
                <InputLabel id="thana-label">Thana</InputLabel>
                <Select
                  labelId="thana-label"
                  label="Thana"
                  name="thana"
                  value={form_inputs.thana?form_inputs.thana:''}
                  onChange={handleChange}
                >
                  {thana_list.map(thana=>(
                    <MenuItem key={thana} value={thana}>{thana}</MenuItem>
                  ))}
                </Select>
              </FormControl>
            </div>
            <div className="col-md-2">
              <TextField
                label="ZIP code"
                name="zipcode"
                type="number"
                fullWidth
                size="small"
                variant="outlined"
                margin="normal"
                value={form_inputs.zipcode?form_inputs.zipcode:''}
                onChange={handleChange}
              />
            </div>
          </div>
          <div className="form-row">
            <div className="col">
              <TextField
                label="Address"
                name="address"
                fullWidth
                size="small"
                variant="outlined"
                margin="normal"
                multiline
                value={form_inputs.address?form_inputs.address:''}
                onChange={handleChange}
              />
            </div>
            <div className="col">
              <TextField
                label="Description"
                name="description"
                fullWidth
                size="small"
                variant="outlined"
                margin="normal"
                multiline
                value={form_inputs.description?form_inputs.description:''}
                onChange={handleChange}
              />
            </div>
          </div>
        </div>
        <div className="col-xl-2 col-md-4 col-xm-6">
          <div className="d-flex justify-content-center mt-3">
            <ImageInput
              id="logo_file"
              name="logo_file"
              buttonLabel="Choose logo"
              dummyText="LOGO"
              defaultValue={form_inputs.logo}
              onChange={handleChange}
            />
          </div>
        </div>
      </div>

      <h6 className="text-center font-weight-bold my-3">Admin Information</h6>
      <hr className="w-50 bg-secondary"/>

      <div className="row">
        <div className="col-xl-3">
          <TextField
            label="Admin Firstname"
            name="admin_firstname"
            fullWidth
            size="small"
            variant="outlined"
            margin="normal"
            required
            error={requires.admin_firstname}
            value={form_inputs.admin_firstname?form_inputs.admin_firstname:''}
            onChange={handleChange}
          />
        </div>
        <div className="col-xl-3">
          <TextField
            label="Admin Lastname"
            name="admin_lastname"
            fullWidth
            size="small"
            variant="outlined"
            margin="normal"
            required
            error={requires.admin_lastname}
            value={form_inputs.admin_lastname?form_inputs.admin_lastname:''}
            onChange={handleChange}
          />
        </div>
        <div className="col-xl-3">
          <TextField
            label="Mobile No."
            name="admin_mobile"
            type="number"
            fullWidth
            size="small"
            variant="outlined"
            margin="normal"
            required
            disabled={update}
            error={requires.admin_mobile}
            value={form_inputs.admin_mobile?form_inputs.admin_mobile:''}
            onChange={handleChange}
          />
        </div>
        <div className="col-xl-3">
          <TextField
            label="Email"
            name="admin_email"
            fullWidth
            size="small"
            variant="outlined"
            margin="normal"
            required
            error={requires.admin_email}
            value={form_inputs.admin_email?form_inputs.admin_email:''}
            onChange={handleChange}
          />
        </div>
      </div>
      <div className="row">
        <div className="col-xl-3">
          <FormControl variant="outlined" size="small" margin="normal" required error={requires.password}>
            <InputLabel htmlFor="password">Password</InputLabel>
            <OutlinedInput
              id="password"
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
                    {showPassword ? <Visibility color="secondary" /> : <VisibilityOff />}
                  </IconButton>
                </InputAdornment>
              }
              labelWidth={70}
            />
          </FormControl>
        </div>
      </div>

      <div className="text-center">
        <Button className="w-25" size="small" variant="contained" color="primary" onClick={handleSubmit} disabled={loading}>
          Submit &nbsp; {loading?<DataSaving/>:<SendRoundedIcon fontSize="small"/>}
        </Button>
      </div>
    </div>
  )
})