import React from 'react';
import {TextField, IconButton, InputAdornment} from '@material-ui/core';
import SearchRoundedIcon from '@material-ui/icons/SearchRounded';


export default ()=>{
  return(
    <div className="row">
      <div className="col">
        <div className="card p-3">
          <div className="d-flex align-items-center">
            <TextField
              label="Search by Date"
              fullWidth
              variant="outlined"
              size="small"
              type="date"
              InputLabelProps={{shrink: true}}
            />
            <IconButton className="ml-3 bg-primary text-white">
              <SearchRoundedIcon fontSize="small"/>
            </IconButton>
          </div>
        </div>
      </div>
      <div className="col">
        <div className="card p-3">
          <div className="d-flex align-items-center">
            <TextField
              label="Search by Invoice"
              placeholder="Invoice"
              fullWidth
              variant="outlined"
              size="small"
              InputProps={{
                startAdornment: <InputAdornment position="start">#</InputAdornment>,
              }}
            />
            <IconButton className="ml-3 bg-primary text-white">
              <SearchRoundedIcon fontSize="small"/>
            </IconButton>
          </div>
        </div>
      </div>
    </div>
  )
}