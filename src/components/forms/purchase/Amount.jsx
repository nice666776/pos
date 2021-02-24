import React, { useCallback } from 'react';
import {useHistory} from 'react-router-dom';
import {TextField, Button} from '@material-ui/core';
import SyncRoundedIcon from '@material-ui/icons/SyncRounded';
import { DataSaving } from 'components/loading/DataSaving';
import {PrintButton} from 'components/PDF';


let RESET = 1

export default React.memo(({form_inputs, handleInputs, handleSave, saving, saved, invoice})=>{
  const history = useHistory()
  const handleReset = useCallback(()=>{
    history.replace(`${history.location.pathname}?reset=${RESET++}`)
  }, [history])

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