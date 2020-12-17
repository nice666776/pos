import React from 'react';
import {Route, withRouter, Switch, Redirect} from 'react-router-dom';
import asyncComponent from '../../util/asyncComponent';

const ConfigurationRoutes = (props)=>{
  const path = props.match.path
  return(
    <div className="app-wrapper">
      <Switch>
        <Redirect exact from={path} to={`${path}/supplier-entry`} />
        <Route to={`${path}/supplier-entry`} component={asyncComponent(() => import('./SupplierEntry'))}/>
        <Route to={`${path}/manufacture`} component={asyncComponent(() => import('./Manufacture'))}/>
        <Route to={`${path}/util-info`} component={asyncComponent(() => import('./UtilInfo'))}/>
      </Switch>
    </div>
  )
}

export default withRouter(ConfigurationRoutes);