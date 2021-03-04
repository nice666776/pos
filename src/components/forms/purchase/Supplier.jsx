import React from 'react';
import {TextField, CircularProgress} from '@material-ui/core';
import Autocomplete from '@material-ui/lab/Autocomplete';
import {supplierSearch} from 'pages/purchase/server_action';

export default React.memo(({form_inputs, handleInputs, require_fields})=>{
  const [supplier_list, setSupplierList] = React.useState([])
  const [supplier_info, setSupplierInfo] = React.useState(null)
  const [loading, setLoading] = React.useState(false)

  React.useEffect(()=>{
    setSupplierInfo(null)
  }, [])

  const handleSearch = React.useCallback((e)=>{
    setLoading(true)
    supplierSearch(e.target.value)
      .then(resp => {
        if(resp.success)
          setSupplierList(resp.message)
        else setSupplierList([])
      })
      .finally(()=>setLoading(false))
  }, [])

  const handleSelected = React.useCallback((e, val)=>{
    setSupplierInfo(val)
    let event = {target: {name: 'supplier_code', value: val?val.code:null}}
    handleInputs(event)
  }, [handleInputs])

  
  return(
    <div className="card py-2 px-3">
      <div className="form-row d-flex justify-content-center">
        <div className="col-md-4 col-sm-7">
          <Autocomplete
            style={{ minWidth: 350 }}
            loadingText="Searching..."
            noOptionsText="No supplier found!"
            getOptionLabel={(option) => option.name}
            onChange={handleSelected}
            options={supplier_list}
            loading={loading}
            renderInput={(params) => (
              <TextField
                {...params}
                label="Supplier Name"
                placeholder="Search by Name/Mobile"
                variant="outlined"
                size="small"
                onChange={handleSearch}
                fullWidth
                required
                margin="dense"
                error={require_fields.supplier_code}
                InputProps={{
                  ...params.InputProps,
                  endAdornment: (
                    <React.Fragment>
                      {loading ? <CircularProgress color="secondary" size={20}/> : null}
                      {params.InputProps.endAdornment}
                    </React.Fragment>
                  )
                }}
              />
            )}
          />
        </div>
        {supplier_info &&
          <div className="col-xl-3 col-md-4 col sm-5">
            <div className="d-flex flex-column align-items-center justify-content-center">
              <span><strong>Company : </strong>&nbsp;{supplier_info.company}</span>
              <hr className="w-50 p-0 m-0"/>
              <span><strong>Mobile : </strong>&nbsp;{supplier_info.mobile}</span>
            </div>
          </div>
        }  
        <div className="col-md-2 col-sm-3">
          <TextField                                     // entry date
            label="Entry Date"
            name="entry_date"
            type="date"
            fullWidth
            required
            variant="outlined"
            size='small'
            margin="dense"
            defaultValue={form_inputs.entry_date}
            onChange={handleInputs}
            InputLabelProps={{shrink: true}}
          />
        </div>
      </div>
    </div>
  )
})