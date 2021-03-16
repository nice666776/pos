import React from "react";
import {
  Route,
  Switch,
  Redirect,
  withRouter,
} from "react-router-dom";
import classnames from "classnames";
import useStyles from "./styles";
import Header from "../Header";
import Sidebar from "../Sidebar";
import Configuration from "../../pages/configuration";
import ProductConfiguration from "../../pages/product-configuration";
import History from "../../pages/history";
import Transaction from "../../pages/transaction";
import { useLayoutState } from "../../context/LayoutContext";
import asyncComponent from '../../util/asyncComponent';


const Routes = React.memo(({path})=>{
  return(
    <Switch>
      <Redirect exact from={path} to="/dashboard" />
      <Route path="/dashboard" component={asyncComponent(() => import('pages/dashboard'))} />
      <Route path="/sales" component={asyncComponent(() => import('pages/sales'))} />
      <Route path="/purchase" component={asyncComponent(() => import('pages/purchase'))} />
      <Route path="/history" component={History}/>
      <Route path="/transaction" component={Transaction}/>
      <Route path="/product-configuration" component={ProductConfiguration}/>
      <Route path="/configuration" component={Configuration}/>
      <Route path="/reset-password" component={asyncComponent(() => import('pages/ChangePassword'))}/>
      <Route component={asyncComponent(() => import('../../pages/error/Error'))} />
    </Switch>
  )
})

function Layout(props) {
  var classes = useStyles();
  var layoutState = useLayoutState();
  const match = props.match
  
  return (
    <div className={classes.root}>
      <React.Fragment>
        <Header history={props.history} />
        <Sidebar />
        <div
          className={classnames(classes.content, {
            [classes.contentShift]: layoutState.isSidebarOpened,
          })}
        >
          <Routes path={match.path} reset={props.location.search.split('=')[1]}/>
        </div>
      </React.Fragment>
    </div>
  );
}

export default withRouter(Layout);
