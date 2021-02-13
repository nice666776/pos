import React from 'react';
import {TextField, FormControl, InputLabel, Select, MenuItem} from '@material-ui/core';
import {supplierDropDown} from 'pages/purchase/server_action';

export default React.memo(({form_inputs, handleInputs, require_fields})=>{
  const [supplier_list, setSupplierList] = React.useState([])

  React.useEffect(()=>{
    supplierDropDown()
      .then(resp => resp.success && setSupplierList(resp.suppliers))
  }, [])

  return(
    <div className="card py-2 px-3">
      <div className="form-row d-flex justify-content-center">
        <div className="col-md-4 col-sm-5">
          <FormControl fullWidth size="small" margin="dense" variant="outlined" required error={require_fields.supplier_code}>
            <InputLabel id="suppiler-label">Supplier</InputLabel>
            <Select
              labelId="suppiler-label"
              name="supplier_code"
              label="Supplier"
              defaultValue={form_inputs.supplier_code}
              onChange={handleInputs}
            >
              {supplier_list.map(val => (
                <MenuItem key={val.code} value={val.code}>{val.name}</MenuItem>
              ))}
            </Select>
          </FormControl>
        </div>
        <div className="col-md-2 col-sm-4">
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
        <div className="col-md-3 col-sm-4">
          <TextField                                     // Invoice
            label="Invoice Number"
            name="invoice"
            fullWidth
            variant="outlined"
            size='small'
            margin="dense"
            defaultValue={form_inputs.invoice}
            onChange={handleInputs}
          />
        </div>
      </div>
    </div>
  )
})