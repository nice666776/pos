import React from 'react';
import { Link, useHistory } from 'react-router-dom';
import {
  TextField,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  Button,
  IconButton
} from '@material-ui/core';
import AddRoundedIcon from '@material-ui/icons/AddRounded';
import HistoryRoundedIcon from '@material-ui/icons/HistoryRounded';
import ClearRoundedIcon from '@material-ui/icons/ClearRounded';
import { AnimateOnChange } from 'react-animation';
import {PrintButton} from 'components/PDF';
import {DataSaving} from 'components/loading/DataSaving';
import {accountsHeadList, postTransaction} from 'pages/transaction/server_action';
import {url} from 'util/Api';
import cogoToast from 'cogo-toast';



const PaymentFor = ({index, payment_number, handleChange, handleAddOne, handleRemoveOne, require_fields, form_inputs, payment_for})=>{
  return(
    <div className="form-row">
      <div className="col-md-6 col-sm-6">
        <FormControl variant="outlined" margin="dense" size="small" fullWidth required error={require_fields[index].payment_head}>
          <InputLabel id="payment_for_label">Payment For</InputLabel>
          <Select                                   // Payment For
            labelId="payment_for_label"
            name="payment_head"
            label="Payment For"
            value={form_inputs[index]['payment_head']}
            onChange={(e)=>handleChange(e, index)}
          >
            {payment_for && payment_for.map(val=>(
              <MenuItem key={val.ac_head_id} value={val.ac_head_id} disabled={form_inputs.map(inpt => inpt.payment_head).indexOf(val.ac_head_id) !== -1 ? true : false}>
                {val.ac_head_name}
              </MenuItem>
            ))}
          </Select>
        </FormControl>
      </div>
      <div className="col-md-4 col-sm-4">
        <TextField                                    // amount
          name="amount"
          label="Amount"
          type="number"
          variant="outlined"
          size="small"
          margin="dense"
          fullWidth
          required
          error={require_fields[index].amount}
          value={form_inputs[index]['amount']}
          onChange={e=>handleChange(e, index)}
        />
      </div>
      {payment_number === index+1 &&
        <div className="col-2 d-flex justify-content-center align-items-center">
          <IconButton className="p-1" onClick={handleAddOne}>
            <AddRoundedIcon color="primary"/>
          </IconButton>
          {index !==0 &&
            <IconButton className="p-1" onClick={()=>handleRemoveOne(index)}>
              <ClearRoundedIcon color="error"/>
            </IconButton>
          }
        </div>
      }
    </div>
  )
}


const checkValidation = (form_inputs, require_fields)=>{
  let is_valid = false
  require_fields['payment_by'] =  form_inputs.payment_by ? false : true
  // eslint-disable-next-line
  form_inputs['pay_for'].map((pay, i) => {
    require_fields['pay_for'][i]['payment_head'] = pay.payment_head ? false: true
    require_fields['pay_for'][i]['amount'] = pay.amount ? false: true
  })
  is_valid = !require_fields['payment_by']
  if(!is_valid) return {is_valid, requires: require_fields}
  // eslint-disable-next-line
  require_fields['pay_for'].map((_, i) => {
    is_valid = !require_fields['pay_for'][i]['payment_head'] && !require_fields['pay_for'][i]['amount']
    if(!is_valid) return {is_valid, requires: require_fields}
  })
  return {is_valid, requires: require_fields}
}


const PaymentEntryForm = ()=>{
  const date = new Date()
  const today = `${date.getFullYear()}-${('0'+(date.getMonth()+1)).slice(-2)}-${('0'+(date.getDate())).slice(-2)}`
  const [form_inputs, setFormInputs] = React.useState({payment_date: today, pay_for: [{}]})
  const [payment_number, setPaymentNumber] = React.useState(1)
  const [payment_for_list, setPaymentForList] = React.useState([])
  const [require_fields, setRequireFields] = React.useState({payment_by: false, pay_for: [{}]})
  const [total_amount, setTotalAmount] = React.useState(0)
  const [saving, setSaving] = React.useState(false)
  const [saved, setSaved] = React.useState(false)
  const [voucher, setVoucher] = React.useState('')

  const history = useHistory()

  React.useEffect(()=>{
    accountsHeadList('E')
      .then(resp => setPaymentForList(resp.query))
  }, [])

  const handleChange = (e, index)=>{
    if(e.target.name === 'payment_head' || e.target.name === 'amount'){
      let old = [...form_inputs.pay_for]
      old[index][e.target.name] = e.target.name === 'amount' ? parseFloat(e.target.value) : e.target.value
      setFormInputs({...form_inputs, pay_for: old})
      if(e.target.name === 'amount'){
        setTotalAmount(calculate_total(old))
      }
    } else setFormInputs({...form_inputs, [e.target.name]: e.target.value})
  }

  const handleAddOne = React.useCallback(()=>{
    setPaymentNumber(payment_number+1)
    let new_field = [...form_inputs.pay_for]
    let new_require = [...require_fields.pay_for]
    new_field.push({})
    new_require.push({})
    setRequireFields({...require_fields, pay_for: new_require})
    setFormInputs({...form_inputs, pay_for: new_field})
  }, [payment_number, form_inputs, require_fields])

  const handleRemoveOne = React.useCallback((index)=>{
    setPaymentNumber(payment_number-1)
    let remove_field = [...form_inputs.pay_for]
    let remove_require = [...require_fields.pay_for]
    remove_field.splice(index, 1)
    remove_require.splice(index, 1)
    setFormInputs({...form_inputs, pay_for: remove_field})
    setRequireFields({...require_fields, pay_for: remove_require})
    setTotalAmount(calculate_total(remove_field))
  }, [form_inputs, require_fields, payment_number])

  const handleSave = ()=>{
    const {is_valid, requires} = checkValidation(form_inputs, require_fields)
    setRequireFields({...requires})
    if(is_valid){
      setSaving(true)
      postTransaction('E', form_inputs)
        .then(resp => {
          if(resp.success){
            cogoToast.success('Payment Entry Successful')
            setVoucher(resp.voucher_id)
            setSaved(true)
          } else cogoToast.warn(resp.message)
        })
        .finally(()=>setSaving(false))
    } else cogoToast.error('Please fillup required fields')
  }

  const handleReset = ()=> history.replace(history.location.pathname)
  
  return(
    <div className="card p-4">
      <div className="form-row">
        <div className="col-md-4 col-sm-6 col-12">
          <TextField                                    // Payment Date
            name="payment_date"
            required
            label="Payment Date"
            type="date"
            variant="outlined"
            size="small"
            margin="dense"
            fullWidth
            value={form_inputs.payment_date}
            onChange={handleChange}
            InputLabelProps={{shrink: true}}
          />
        </div>
        <div className="col-md-3 col-sm-6 col-12">
          <FormControl variant="outlined" margin="dense" size="small" fullWidth required error={require_fields.payment_by}>
            <InputLabel id="payment_by_label">Payment By</InputLabel>
            <Select                                   // Payment By
              labelId="payment_by_label"
              name="payment_by"
              label="Payment By"
              value={form_inputs.payment_by}
              onChange={handleChange}
            >
              <MenuItem value="CASH">Cash and cash equivalents</MenuItem>
              <MenuItem value="BANK">Bank Account</MenuItem>
            </Select>
          </FormControl>
        </div>

        <div className="col text-right d-none d-md-block">
          <Link to="/transaction/payment-entry/p-history">
            <IconButton className="p-2">
              <HistoryRoundedIcon color="primary" />
            </IconButton>
          </Link>
        </div>

      </div>

      <div className="row">
        <div className="col-lg-7 com-md-7">
          {[...Array(payment_number).keys()].map(number => (
            <PaymentFor
              key={number}
              index={number}
              payment_number={payment_number}
              handleChange={handleChange}
              handleAddOne={handleAddOne}
              handleRemoveOne={handleRemoveOne}
              require_fields={require_fields['pay_for']}
              form_inputs={form_inputs.pay_for}
              payment_for={payment_for_list}
            />
          ))}
        </div>
        <div className="col-lg-5 com-md-5">
          <Total amount={total_amount}/>
        </div>
      </div>

      <div className="text-right">
        <Link to="/transaction/receipts-entry/history" className="d-sm-block d-md-none mx-2">
          <IconButton className="p-2">
            <HistoryRoundedIcon color="primary" />
          </IconButton>
        </Link>
        {saved &&
          <PrintButton url={`${url}/print/paymentVoucher?voucher_id=${voucher}`} />
        }
        <Button className="ml-3" variant="contained" color="primary" size="small" onClick={saved?handleReset:handleSave} disabled={saving}>
          <AnimateOnChange animationIn="bounceIn" animationOut="bounceOut" durationOut={300}>{saved?'Reset':'Save'}</AnimateOnChange> {saving && <DataSaving/>}
        </Button>
      </div>
    </div>
  )
}


const calculate_total = (amount_list)=>{
  let total = 0
  amount_list.map(val => (total += val.amount? val.amount : 0))
  return total
}

const Total = React.memo(({amount})=>{
  return(
    <div className="text-center mt-3">
      <h4 className="font-weight-bold">Total Amount</h4>
      <span className="text-secondary text-monospace lead" style={{fontSize: 35}}>
        <AnimateOnChange animationIn="bounceIn" animationOut="bounceOut" durationOut={300}>
          {amount ? amount.toLocaleString() : 0}
        </AnimateOnChange>
      </span>
    </div>
  )
})


export default React.memo(PaymentEntryForm);