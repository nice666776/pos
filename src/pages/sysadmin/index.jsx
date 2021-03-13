import React from 'react';
import Header from "components/Header";
import ClientInformation from 'components/forms/sysadmin';
import {admin_require} from 'components/forms/sysadmin/require';
import checkValidation from 'util/checkValidation';
import {createClient, getClientInfo} from './server_action';
import cogoToast from 'cogo-toast';


class SystemAdmin extends React.Component{
  state={
    form_inputs: {},
    requires: admin_require,
    update: false,
    loading: false
  }

  componentDidMount(){
    getClientInfo()
      .then(resp=>{
        if(resp.success){
          this.setState({form_inputs: resp.client, update: true})
        }
      })
  }

  handleChange = (e)=>{
    let input = this.state.form_inputs
    if(e.target.name==="logo_file"){
      input = {...input, [e.target.name]: e.target.files[0]}
    } else {
      input = {...input, [e.target.name]: e.target.value}
    }
    if(e.target.name === 'division'){
      input['district'] = null
      input['thana'] = null
    } else if(e.target.name === 'district'){
      input['thana'] = null
    }
    this.setState({form_inputs: {...input}})
  }

  handleSubmit = ()=>{
    const {isFormValid, require_fields} = checkValidation(this.state.form_inputs, this.state.requires)
    this.setState({requires: require_fields})
    if(isFormValid){
      this.setState({loading: true})
      createClient(this.state.form_inputs)
        .then(resp => {
          if(resp.success){
            cogoToast.success('Client has been created')
          } else cogoToast.error(resp.message)
        })
        .finally(()=>this.setState({loading: false}))
    } else cogoToast.error('Following fields are required')
  }

  render(){
    return(
      <React.Fragment>
        <Header history={this.props.history} />
        <div className="app-wrapper p-3">
          <h5 className="text-center font-weight-bold">Client Information</h5>
          <ClientInformation
            form_inputs={this.state.form_inputs}
            handleChange={this.handleChange.bind(this)}
            handleSubmit={this.handleSubmit.bind(this)}
            requires={this.state.requires}
            update={this.state.update}
            loading={this.state.loading}
          />
        </div>
      </React.Fragment>
    )
  }
}

export default SystemAdmin;