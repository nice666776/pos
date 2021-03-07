import React from 'react';
import Header from "components/Header";


class SystemAdmin extends React.Component{
  render(){
    return(
      <React.Fragment>
        <Header history={this.props.history} />
        <div className="app-wrapper">
          <h1>System Admin page</h1>
        </div>
      </React.Fragment>
    )
  }
}

export default SystemAdmin;