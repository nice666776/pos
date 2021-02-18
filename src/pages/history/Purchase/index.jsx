import React from 'react';
import HistoryForm from 'components/forms/history';

class PurchaseHistory extends React.Component{
  render(){
    return(
      <div className="app-wrapper">
        <h5 className="text-center font-weight-bold">Purchase History</h5>
        <HistoryForm/>
      </div>
    )
  }
}

export default PurchaseHistory;