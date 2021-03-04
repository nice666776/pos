import React, { useCallback } from 'react';
import {useHistory} from 'react-router-dom';
import {TextField, Button, FormControl, InputLabel, Select, MenuItem, OutlinedInput, InputAdornment, IconButton} from '@material-ui/core';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faPercent, faDollarSign } from '@fortawesome/free-solid-svg-icons'
import SyncRoundedIcon from '@material-ui/icons/SyncRounded';
import { DataSaving } from 'components/loading/DataSaving';
import {PrintButton} from 'components/PDF';


let RESET = 1

export default React.memo(({form_inputs, handleInputs, handleSave, saving, saved, invoice})=>{
  const history = useHistory()
  
  const handleReset = useCallback(()=>{
    history.replace(`${history.location.pathname}?reset=${RESET++}`)
  }, [history])

  const handleDiscountType = useCallback(()=>{
    let event = {target: {name: 'percent', value: !form_inputs.percent}}
    handleInputs(event)
  }, [form_inputs.percent, handleInputs])

  return(
    <div className="card py-2 px-3">
      <div className="form-row d-flex justify-content-center mb-3">
        <div className="col-md-2 col-sm-3">
          <FormControl variant="outlined" size="small" margin="dense">
            <InputLabel htmlFor="discount">Discount</InputLabel>
            <OutlinedInput
              id="discount"
              name="discount"
              type="number"
              onChange={handleInputs}
              endAdornment={
                <InputAdornment position="end">
                  <IconButton
                    onClick={handleDiscountType}
                    edge="end"
                    color="secondary"
                  >
                    {form_inputs.percent ? <FontAwesomeIcon icon={faPercent}/> : <FontAwesomeIcon icon={faDollarSign}/>}
                  </IconButton>
                </InputAdornment>
              }
              labelWidth={70}
            />
          </FormControl>
        </div>
        <div className="col-md-2 col-sm-3">
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
        <div className="col-md-2 col-sm-3">
          <FormControl fullWidth size="small" margin="dense" variant="outlined" required>
            <InputLabel id="payment_type-label">Payment Type</InputLabel>
            <Select
              labelId="payment_type-label"
              name="payment_type"
              label="Payment Type"
              defaultValue={form_inputs.payment_type}
              onChange={handleInputs}
            >
              <MenuItem value="Cash">Cash</MenuItem>
              <MenuItem value="Bank">Bank</MenuItem>
            </Select>
          </FormControl>
        </div>
      </div>
      <div className="text-center">
        {!saved
          ? <Button className="w-25" variant="contained" size="small" color="primary" onClick={handleSave} disabled={saving}>
              Submit {saving && <DataSaving/>}
            </Button>
          : <div>
              <PrintButton url={`/print/PurchaseOrder?invoice=${invoice}`}/>
              <Button className="ml-2" variant="contained" size="small" color="primary" onClick={handleReset} disabled={saving}>
                Reset <SyncRoundedIcon fontSize="small"/>
              </Button>
            </div>
        }
      </div>
    </div>
  )
})