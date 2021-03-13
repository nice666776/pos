import React from "react";
import { BrowserRouter, Route, Switch, Redirect } from "react-router-dom";
import Layout from "./Layout";
import Login from "../pages/login";
import { useUserState } from "../context/UserContext";
import asyncComponent from 'util/asyncComponent';
import user_type from 'util/user_type';


const App = React.memo(()=>{
  var { isAuthenticated, userInfo } = useUserState();

  const PrivateRoute = ({ component, ...rest })=>{
    return (
      <Route
        {...rest}
        render={props =>
          isAuthenticated
            ? userInfo.role===user_type.SYSADMIN
              ? <Redirect to={{pathname: "/sysadmin", state: {from: props.location}}}/>
              : ( React.createElement(component, props) )
            : ( <Redirect to={{pathname: "/login", state: {from: props.location}}}/> )
        }
      />
    );
  }

  const SysAdmin = ({ component, ...rest })=>{
    return (
      <Route
        {...rest}
        render={props =>
          isAuthenticated && userInfo.role===user_type.SYSADMIN
            ? ( React.createElement(component, props) )
            : ( <Redirect to={{pathname: "/", state: {from: props.location}}}/> )
        }
      />
    );
  }

  const PublicRoute = ({ component, ...rest })=>{
    return (
      <Route
        {...rest}
        render={props =>
          isAuthenticated 
            ? ( <Redirect to={{pathname: "/"}}/> )
            : ( React.createElement(component, props) )
        }
      />
    );
  }


  // #######################################################################


  return (
    <BrowserRouter>
      <Switch>
        <PublicRoute path="/login" component={Login} />
        <SysAdmin path="/sysadmin" component={asyncComponent(() => import("../pages/sysadmin"))} />
        <PrivateRoute path="/" component={Layout} />
      </Switch>
    </BrowserRouter>
  );
})


export default App;