import cogoToast from "cogo-toast";
import React from "react";
import {useHistory} from 'react-router-dom';
import DataLoading from 'components/loading/DataLoading';
import {posLogin, getUserInfo} from '../pages/login/server_action';
import axios from 'util/Api';

var UserStateContext = React.createContext();
var UserDispatchContext = React.createContext();

function userReducer(state, action) {
  switch (action.type) {
    case "LOGIN_SUCCESS":
      return { ...state, isAuthenticated: true, userInfo: action.user_info?action.user_info:{} };
    case "SIGN_OUT_SUCCESS":
      return { ...state, isAuthenticated: false, userInfo: {} };
    case "USER_INFO":
      return { ...state, userInfo: action.user_info };
    default: {
      throw new Error(`Unhandled action type: ${action.type}`);
    }
  }
}

function UserProvider({ children }) {                       // startup user check
  const history = useHistory()
  const [loading, setLoading] = React.useState(true)
  var [state, dispatch] = React.useReducer(userReducer, {
    isAuthenticated: false,
  });

  React.useEffect(()=>{
    const token = sessionStorage.getItem('user-token')
    if(token){
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
      getUserInfo()
        .then((resp)=>{
          if(resp.success){
            dispatch({ type: 'LOGIN_SUCCESS', user_info: resp })
          } else signOut(dispatch, history)
        })
        .finally(()=>setLoading(false))
    } else setLoading(false)
  }, [history])

  return (
    !loading
      ? <UserStateContext.Provider value={state}>
          <UserDispatchContext.Provider value={dispatch}>
            {children}
          </UserDispatchContext.Provider>
        </UserStateContext.Provider>
      : <DataLoading text="Checking user information..."/>
  );
}

function useUserState() {
  var context = React.useContext(UserStateContext);
  if (context === undefined) {
    throw new Error("useUserState must be used within a UserProvider");
  }
  return context;
}

function useUserDispatch() {
  var context = React.useContext(UserDispatchContext);
  if (context === undefined) {
    throw new Error("useUserDispatch must be used within a UserProvider");
  }
  return context;
}

export { UserProvider, useUserState, useUserDispatch, loginUser, signOut };

// ###########################################################

function loginUser(dispatch, username, password, history, setIsLoading, setError) {
  setError(false);
  setIsLoading(true);

  if (!!username && !!password) {
    posLogin({username, password})
      .then(resp => {
        if(resp.success){
          cogoToast.success("Login successful")
          sessionStorage.setItem('user-token', resp.token)
          axios.defaults.headers.common['Authorization'] = `Bearer ${resp.token}`;
          getUserInfo()
            .then(user_resp => {
              if(user_resp.success){
                dispatch({ type: 'LOGIN_SUCCESS', user_info: user_resp })
                setError(false)
                history.push('/')
              } else {
                cogoToast.error('Error occurred while getting user information')
                signOut(dispatch, history)
              }
            })
        } else cogoToast.error('Sorry! Something went wrong')
      })
      .catch(err => err.message === "Request failed with status code 401" && setError(true))
      .finally(()=>setIsLoading(false))
  } else {
    dispatch({ type: "LOGIN_FAILURE" });
    setError(true);
    setIsLoading(false);
  }
}

function signOut(dispatch, history) {
  sessionStorage.removeItem("user-token");
  dispatch({ type: "SIGN_OUT_SUCCESS" });
  history.push("/login");
}
