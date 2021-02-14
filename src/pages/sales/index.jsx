import React from 'react';
import SalesTable from 'components/table/SalesTable';
import Amount from 'components/forms/sales/Amount';


const Total = React.memo(({total})=>{
  return(
    <div className="text-center">
      <h5 className="text-primary font-italic">Total Price</h5>
      <h2 className="text-monospace text-secondary">{total?total.toLocaleString():0}</h2>
    </div>
  )
})


class Sales extends React.Component{
  state={
    form_inputs: {}
  }

  render(){
    return(
      <div className="app-wrapper">
        <h5 className="text-center font-weight-bold">Sales</h5>
        <SalesTable/>
        <Total total={0}/>
        <Amount form_inputs={this.state.form_inputs}/>
      </div>
    )
  }
}

export default Sales;