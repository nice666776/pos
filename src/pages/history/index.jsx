import React from 'react';
import {Route, Switch, Redirect, useRouteMatch} from 'react-router-dom';
import asyncComponent from '../../util/asyncComponent';


const PurchaseHistory = asyncComponent(() => import('./Purchase'));
const SalesHistory = asyncComponent(() => import('./Sales'));

const ConfigurationRoutes = React.memo(()=>{
  const path = useRouteMatch().path

  return(
    <div className="app-wrapper">
      <Switch>
        <Redirect exact from={path} to={`${path}/purchase`} />
        <Route path={`${path}/purchase`} component={PurchaseHistory}/>
        <Route path={`${path}/sales`} component={SalesHistory}/>
        <Route component={asyncComponent(() => import('../error/Error'))}/>
      </Switch>
    </div>
  )
})

export default ConfigurationRoutes;