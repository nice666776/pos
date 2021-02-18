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
import { useLayoutState } from "../../context/LayoutContext";
import asyncComponent from '../../util/asyncComponent';

function Layout(props) {
  var classes = useStyles();
  var layoutState = useLayoutState();

  const path = props.match.path

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
          <Switch>
            <Redirect exact from={path} to="/dashboard" />
            <Route path="/dashboard" component={asyncComponent(() => import('../../pages/dashboard'))} />
            <Route path="/sales" component={asyncComponent(() => import('../../pages/sales'))} />
            <Route path="/purchase" component={asyncComponent(() => import('../../pages/purchase'))} />
            <Route path="/history" component={History}/>
            <Route path="/product-configuration" component={ProductConfiguration}/>
            <Route path="/configuration" component={Configuration}/>
            <Route component={asyncComponent(() => import('../../pages/error/Error'))} />
          </Switch>
        </div>
      </React.Fragment>
    </div>
  );
}

export default withRouter(Layout);
