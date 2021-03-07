import React from 'react';
import { HoopSpinner } from "react-spinners-kit";


// eslint-disable-next-line
export default ({text})=>{
  return(
    <div className="d-flex flex-column justify-content-center align-items-center" style={{height: 'calc(100vh - 200px)'}}>
      <HoopSpinner size={100} color="#ff0f60"/>
      <h6 className="text-muted mt-4">{text?text:'Loading...'}</h6>
    </div>
  )
}