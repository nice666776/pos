import React from 'react';
import { Switch, Route, withRouter } from 'react-router-dom';
import asyncComponent from 'util/asyncComponent';
import ReceiptsEntryForm from 'components/forms/transaction/receipt-entry';


const ReceiptsEntry = ()=>{
  return(
    <div className="app-wrapper">
      <h5 className="text-center font-weight-bold mb-3">Receipt Entry</h5>
      <ReceiptsEntryForm/>
    </div>
  )
}

const ReceiptEntryRoutes = ({match}) =>{
  return(
    <Switch>
      <Route path={`${match.url}/p-history`} component={asyncComponent(() => import("./History"))}/>
      <Route path={`${match.url}`} exact component={()=><ReceiptsEntry/>}/>
      <Route component={asyncComponent(() => import("pages/error/Error"))}/>
    </Switch>
  )
}


export default withRouter(ReceiptEntryRoutes);