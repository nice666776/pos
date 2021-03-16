import React from 'react';
import SalesTable from 'components/table/SalesTable';
import Amount from 'components/forms/sales/Amount';
import { AnimateOnChange } from 'react-animation';
import {saleSubmit} from './server_action';
import cogoToast from 'cogo-toast';


const Total = React.memo(({total})=>
  <div className="text-center">
    <h5 className="text-primary font-italic">Total Price</h5>
    <h2 className="text-monospace text-secondary">
      <AnimateOnChange animationIn="bounceIn" animationOut="bounceOut" durationOut={300}>
        {total?total.toLocaleString():0}
      </AnimateOnChange>
    </h2>
  </div>
)


class Sales extends React.Component{
  state={
    form_inputs: {receive_type: 'Cash', percent: true},
    sale_list: [],
    total: 0,
    saving: false,
    saved: false,
    invoice: ''
  }

  updateSaleList = (list)=>{
    var total = 0
    list.forEach(val=>{
      total += val.total_price
    })
    let payment = this.state.form_inputs.discount?total-this.state.form_inputs.discount:total
    this.setState({sale_list: list, total, form_inputs: {...this.state.form_inputs, payment: payment<0?0:payment}})
  }

  handleInputs = (e)=>{
    const prev_state = this.state.form_inputs
    prev_state[e.target.name] = e.target.value
    if(e.target.name === 'discount' || e.target.name === "percent"){
      let discount = e.target.name === 'discount' ? parseFloat(e.target.value||0) : this.state.form_inputs.discount || 0
      let t = this.state.form_inputs.percent ? this.state.total-(this.state.total*discount/100) : this.state.total - discount
      prev_state['discount'] = discount
      prev_state['payment'] = t<0?0:t
    } else if(e.target.name === 'payment')
      prev_state['payment'] = parseFloat(e.target.value)
    this.setState({form_inputs: {...prev_state}})
  }

  handleSave = ()=>{
    let output = this.state.form_inputs
    output['sales_list'] = this.state.sale_list
    if(this.state.sale_list.length > 0){
      this.setState({saving: true})
      const {hide} = cogoToast.loading('Saving information...')
      saleSubmit(output)
        .then(resp => {
          if(resp.success){
            cogoToast.success('Submited!')
            this.setState({saved: true, invoice: resp.invoice})
          } else cogoToast.error(resp.message)
        })
        .finally(()=>{this.setState({saving: false}); hide()})
    } else cogoToast.warn('Select some product to sale')
  }

  render(){
    return(
      <div className="app-wrapper">
        <h5 className="text-center font-weight-bold">Sales</h5>
        <SalesTable updateSaleList={this.updateSaleList.bind(this)}/>
        <Total total={this.state.total}/>
        <Amount
          form_inputs={this.state.form_inputs}
          handleInputs={this.handleInputs.bind(this)}
          handleSave={this.handleSave.bind(this)}
          saving={this.state.saving}
          saved={this.state.saved}
          invoice={this.state.invoice}
        />
      </div>
    )
  }
}

export default Sales;