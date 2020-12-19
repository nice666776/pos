import React from 'react';
import {Route, withRouter, Switch, Redirect} from 'react-router-dom';
import asyncComponent from '../../util/asyncComponent';

const ConfigurationRoutes = (props)=>{
  const match = props.match.path

  return(
    <div className="app-wrapper">
      <Switch>
        <Redirect exact from={match} to={`${match}/supplier-entry`} />
        <Route path={`${match}/supplier-entry`} component={asyncComponent(() => import('./SupplierEntry'))}/>
        <Route path={`${match}/manufacture`} component={asyncComponent(() => import('./Manufacture'))}/>
        <Route path={`${match}/util-info`} component={asyncComponent(() => import('./UtilInfo'))}/>
        <Route component={asyncComponent(() => import('../error/Error'))}/>
      </Switch>
    </div>
  )
}

export default withRouter(ConfigurationRoutes);