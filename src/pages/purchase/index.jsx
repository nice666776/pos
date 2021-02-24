import React from 'react';
import SupplierForm from 'components/forms/purchase/Supplier';
import AmountForm from 'components/forms/purchase/Amount';
import ProductTable from './ProductTable';
import checkValidation from 'util/checkValidation';
import cogoToast from 'cogo-toast';
import {purchaseConfirm} from './server_action';


const Total = React.memo(({total})=>{
  return(
    <div className="text-center">
      <h5 className="text-primary font-italic">Total Price</h5>
      <h2 className="text-monospace text-secondary">{total?total.toLocaleString():0}</h2>
    </div>
  )
})


class Purchase extends React.Component{
  constructor(props){
    super(props)
    const date = new Date()
    const today = `${date.getFullYear()}-${('0'+(date.getMonth()+1)).slice(-2)}-${('0'+(date.getDate())).slice(-2)}`
    this.state={
      form_inputs: {entry_date: today},
      require_field: {supplier_code: false},
      purchase_list: [],
      total: 0,
      saving: false,
      saved: false,
      invoice: ''
    }
  }

  handleFormInputs = (e)=>{
    const prev_state = this.state.form_inputs
    prev_state[e.target.name] = e.target.value
    if(e.target.name === 'discount'){
      let discount = parseFloat(e.target.value||0)
      let t = this.state.total - discount
      prev_state['discount'] = discount
      prev_state['payment'] = t<0?0:t
    }
    this.setState({form_inputs: {...prev_state}})
  }

  handlePurchaseList = (list)=>{
    let total = 0
    list.forEach(val=>{
      total += val.unit_price * val.quantity
    })
    let payment = this.state.form_inputs.discount?total-this.state.form_inputs.discount:total
    this.setState({purchase_list: list, total, form_inputs: {...this.state.form_inputs, payment: payment<0?0:payment}})
  }

  handleSave = ()=>{
    const {isFormValid, require_fields} = checkValidation(this.state.form_inputs, this.state.require_field)
    if(isFormValid){
      if(this.state.purchase_list.length > 0){
        this.setState({saving: true})
        const {hide} = cogoToast.loading('Saving information...')
        const output = this.state.form_inputs
        output['purchase_list'] = this.state.purchase_list
        purchaseConfirm(output)
          .then(resp => {
            if(resp.success){
              cogoToast.success('Product added successfully!')
              this.setState({saved: true, invoice: resp.invoice})
            } else cogoToast.error(resp.message)
          })
          .finally(()=>{this.setState({saving: false}); hide()})
      } else cogoToast.error('Please, Add some product')
    } else cogoToast.error('Please, fill up all required fields!')
    this.setState({require_field: {...require_fields}})
  }

  render(){
    return(
      <div className="app-wrapper">
        <h5 className="text-center font-weight-bold">Purchase Product</h5>
        <SupplierForm
          form_inputs={this.state.form_inputs}
          handleInputs={this.handleFormInputs.bind(this)}
          require_fields={this.state.require_field}
        />
        <ProductTable handlePurchaseList={this.handlePurchaseList.bind(this)}/>
        <Total total={this.state.total}/>
        <AmountForm
          form_inputs={this.state.form_inputs}
          handleInputs={this.handleFormInputs.bind(this)}
          handleSave={this.handleSave.bind(this)}
          saving={this.state.saving}
          saved={this.state.saved}
          invoice={this.state.invoice}
        />
      </div>
    )
  }
}

export default Purchase;