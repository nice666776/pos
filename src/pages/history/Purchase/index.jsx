import React from 'react';
import HistoryForm from 'components/forms/history';
import HistoryTable from 'components/table/history';
import {searchByDate, searchByInvoice} from '../server_action';
import cogoToast from 'cogo-toast';

class PurchaseHistory extends React.PureComponent{
  state = {
    history_list: [],
    searching: false
  }

  handleSearch = (by, value)=>{
    const search = by==='date' ? searchByDate : searchByInvoice
    this.setState({searching: true, history_list: []})
    const {hide} = cogoToast.loading('Looking for history...', {hideAfter: 10})
    search(value)
      .then(resp => {
        if(resp.success){
          this.setState({history_list: resp.message})
        } else cogoToast.error(resp.message)
      })
      .finally(()=>{this.setState({searching: false}); hide()})
  }

  render(){
    return(
      <div className="app-wrapper">
        <h5 className="text-center font-weight-bold mb-3">Purchase History</h5>
        <HistoryForm handleSearch={this.handleSearch.bind(this)} searching={this.state.searching}/>
        {this.state.history_list.length > 0 &&
          <HistoryTable history_list={this.state.history_list} history_type="Purchase"/>
        }
      </div>
    )
  }
}

export default PurchaseHistory;