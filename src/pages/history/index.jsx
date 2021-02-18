import React from 'react';
import {Route, withRouter, Switch, Redirect} from 'react-router-dom';
import asyncComponent from '../../util/asyncComponent';

const ConfigurationRoutes = (props)=>{
  const match = props.match.path

  return(
    <div className="app-wrapper">
      <Switch>
        <Redirect exact from={match} to={`${match}/purchase`} />
        <Route path={`${match}/purchase`} component={asyncComponent(() => import('./Purchase'))}/>
        <Route path={`${match}/sales`} component={asyncComponent(() => import('./Sales'))}/>
        <Route component={asyncComponent(() => import('../error/Error'))}/>
      </Switch>
    </div>
  )
}

export default withRouter(ConfigurationRoutes);