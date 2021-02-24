import React from 'react';
import {TextField, Fab, InputAdornment} from '@material-ui/core';
import SearchRoundedIcon from '@material-ui/icons/SearchRounded';


export default React.memo(({handleSearch, searching})=>{
  const [history_date, setDate] = React.useState('')
  const [date_error, setDateError] = React.useState(false)
  const [invoice, setInvoice] = React.useState('')
  const [invoice_error, setInvoiceError] = React.useState(false)

  const byDate = React.useCallback(()=>{
    if(history_date){
      setDateError(false)
      setInvoiceError(false)
      setInvoice('')
      handleSearch('date', history_date)
    } else setDateError(true)
  }, [handleSearch, history_date])

  const byInvoice = React.useCallback(()=>{
    if(invoice){
      setDateError(false)
      setInvoiceError(false)
      setDate('')
      handleSearch('invoice', invoice)
    } else setInvoiceError(true)
  }, [handleSearch, invoice])

  return(
    <div className="form-row">
      <div className="col-sm-6">
        <div className="card p-3">
          <div className="d-flex align-items-center">
            <TextField
              label="Search by Date"
              fullWidth
              variant="outlined"
              size="small"
              type="date"
              value={history_date}
              required
              error={date_error}
              helperText={date_error && "Date is required"}
              onChange={(e)=>setDate(e.target.value)}
              onKeyPress={(e)=>e.key==='Enter' && byDate()}
              InputLabelProps={{shrink: true}}
            />
            <Fab className="ml-3" color="primary" size="small" onClick={byDate} disabled={searching}>
              <SearchRoundedIcon/>
            </Fab>
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
              required
              autoFocus
              error={invoice_error}
              helperText={invoice_error && "Invoice is required"}
              value={invoice}
              onChange={(e)=>setInvoice(e.target.value)}
              onKeyPress={(e)=>e.key==='Enter' && byInvoice()}
              InputProps={{
                startAdornment: <InputAdornment position="start">#</InputAdornment>,
              }}
            />
            <Fab className="ml-3" color="primary" size="small" onClick={byInvoice} disabled={searching}>
              <SearchRoundedIcon/>
            </Fab>
          </div>
        </div>
      </div>
    </div>
  )
})