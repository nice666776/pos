import React from 'react';
import {TextField, Button} from '@material-ui/core';
import { DataSaving } from 'components/loading/DataSaving';

export default React.memo(({form_inputs, handleInputs, handleSave, saving})=>{
  return(
    <div className="card py-2 px-3">
      <div className="form-row d-flex justify-content-center mb-3">
        <div className="col-md-3 col-sm-4">
          <TextField                                     // Discount
            label="Discount"
            name="discount"
            type="number"
            fullWidth
            variant="outlined"
            size='small'
            margin="dense"
            defaultValue={form_inputs.discount}
            onChange={handleInputs}
          />
        </div>
        <div className="col-md-3 col-sm-4">
          <TextField                                     // Payment
            label="Payment"
            name="payment"
            type="number"
            fullWidth
            variant="outlined"
            size='small'
            margin="dense"
            value={form_inputs.payment}
            onChange={handleInputs}
            InputLabelProps={{shrink: true}}
          />
        </div>
      </div>
      <div className="text-center">
        <Button className="w-25" variant="contained" size="small" color="primary" onClick={handleSave} disabled={saving}>
          Save {saving && <DataSaving/>}
        </Button>
      </div>
    </div>
  )
})