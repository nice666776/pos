import React from 'react';
import {DataSaving} from 'components/loading/DataSaving';
import axios from 'util/Api';
import {Tooltip, Fab} from '@material-ui/core';
import PrintRoundedIcon from '@material-ui/icons/PrintRounded';
import cogoToast from 'cogo-toast';
import showError from 'util/showError';
import printJS from 'print-js'


export const generatePDF = ({url, type, data, setCreating})=>{
  setCreating && setCreating(true)
  axios({
    url: url,
    method: type ? type : 'GET',
    responseType: 'blob',
    data: data ? data : null
  }).then(resp => {
      if(resp.data.type === 'application/pdf'){
        const obj = URL.createObjectURL(new Blob([resp.data], {type: 'application/pdf'}));
        // window.open(obj)
        printJS(obj)
      } else {
        const blob = new Blob([resp.data], {type: "text/plain"});
        const reader = new FileReader();
        reader.readAsText(blob);
        reader.addEventListener('loadend', (e) => {
          const text = JSON.parse(e.srcElement.result);
          cogoToast.error(text.message)
        });
      }
    })
    .catch(err => showError(err))
    .finally(() => setCreating && setCreating(false))
}


export const PrintButton = React.memo(({url, type, data})=>{
  const [creating, setCreating] = React.useState(false)
  return(
    <Tooltip title={creating?'Processing...':'Print'} placement="top">
      <Fab size="small" color="secondary" onClick={()=>generatePDF({url, type, data, setCreating})} disabled={creating}>
        {creating ? <DataSaving/> : <PrintRoundedIcon fontSize="small"/>}
      </Fab>
    </Tooltip>
  )
})
