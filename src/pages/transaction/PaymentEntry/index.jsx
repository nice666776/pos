import React from 'react';
import { Route, Switch, withRouter } from 'react-router-dom';
import asyncComponent from 'util/asyncComponent';
import PaymentEntryForm from 'components/forms/transaction/payment-entry';


const PaymentEntry = ()=>{
  return(
    <div className="app-wrapper">
      <h5 className="text-center font-weight-bold mb-3">Payment Entry</h5>
      <PaymentEntryForm/>
    </div>
  )
}

const PaymentEntryRoutes = ({match}) =>
	<Switch>
		<Route path={`${match.url}/p-history`} component={asyncComponent(() => import("./History"))}/>
		<Route path={`${match.url}`} exact component={()=><PaymentEntry/>}/>
		<Route component={asyncComponent(() => import("pages/error/Error"))}/>
	</Switch>


export default withRouter(PaymentEntryRoutes);