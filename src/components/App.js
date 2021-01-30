import React from "react";
import { BrowserRouter, Route, Switch, Redirect } from "react-router-dom";
import Layout from "./Layout";
import Login from "../pages/login";
import { useUserState } from "../context/UserContext";


const App = React.memo(()=>{
  var { isAuthenticated } = useUserState();

  const PrivateRoute = ({ component, ...rest })=>{
    return (
      <Route
        {...rest}
        render={props =>
          isAuthenticated ? (
            React.createElement(component, props)
          ) : (
            <Redirect to={{pathname: "/login", state: {from: props.location}}}/>
          )
        }
      />
    );
  }

  const PublicRoute = ({ component, ...rest })=>{
    return (
      <Route
        {...rest}
        render={props =>
          isAuthenticated ? (
            <Redirect to={{pathname: "/"}}/>
          ) : (
            React.createElement(component, props)
          )
        }
      />
    );
  }


  // #######################################################################


  return (
    <BrowserRouter>
      <Switch>
        <PublicRoute path="/login" component={Login} />
        <PrivateRoute path="/" component={Layout} />
      </Switch>
    </BrowserRouter>
  );
})


export default App;