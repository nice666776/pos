import React from 'react';
import {Route, withRouter, Switch, Redirect} from 'react-router-dom';
import asyncComponent from '../../util/asyncComponent';

const ProductConfigurationRoutes = (props)=>{
  const match = props.match.path

  return(
    <div className="app-wrapper">
      <Switch>
        <Redirect exact from={match} to={`${match}/supplier-entry`} />
        <Route path={`${match}/manufacturers`} component={asyncComponent(() => import('./Manufacturers'))}/>
        <Route path={`${match}/categories`} component={asyncComponent(() => import('./Categories'))}/>
        <Route component={asyncComponent(() => import('../error/Error'))}/>
      </Switch>
    </div>
  )
}

export default withRouter(ProductConfigurationRoutes);