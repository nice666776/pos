import React from 'react';
import {
  Dialog,
  DialogTitle,
  DialogContent,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow
} from '@material-ui/core';
import { ActionButton, AddButton } from 'components/table-component';
import TradeForm from 'components/forms/configuration/trade-management';
import Empty from 'components/empty';
import Loading from 'components/loading/DataLoading';
import {tardeList} from '../server_action';



const AddOrUpdate = React.memo(({open, handleClose, updateList, update, trade_info})=>{
  return(
    <Dialog
      open={open}
      onClose={handleClose}
      aria-labelledby="dialog-title"
      scroll="body"
      disableBackdropClick={true}
    >
      <DialogTitle className="text-center text-secondary" id="dialog-title">
        {update?'Update Trade':'Add Trade'}
      </DialogTitle>
      <DialogContent>
        <TradeForm updateList={updateList} update={update} trade_info={trade_info} handleClose={handleClose}/>
      </DialogContent>
    </Dialog>
  )
})

const Trade = ()=>{
  const [open, setOpen] = React.useState(false)
  const [update, setUpdate] = React.useState(false)
  const [trade_list, setTradeList] = React.useState([])
  const [trade_info, setTradeInfo] = React.useState({})
  const [loading, setLoading] = React.useState(true)

  React.useEffect(()=>{
    tardeList()
      .then(resp => resp.success && setTradeList(resp.message))
      .finally(()=>setLoading(false))
  },[])

  const handleClose = React.useCallback(()=> setOpen(false), [setOpen])


  const updateList = React.useCallback((trade, type)=> {
    let list = []
    console.log(type, trade)
    if(type === 'ADD'){
      list = [trade, ...trade_list]
    } else {
      const index = trade_list.findIndex(val=>val.id===trade.id)
      trade_list[index] = trade
      list = [...trade_list]
    }
    setTradeList(list)
    setOpen(false)
  }, [trade_list])

  
  const dispatch = React.useCallback((action) => {
    if(action.type === 'EDIT'){
      setUpdate(true)
      setTradeInfo(action.rowData)
      setOpen(true)
    } else if(action.type === 'ADD') {
      setUpdate(false)
      setTradeInfo({})
      setOpen(true)
    }
  }, [setUpdate])

  return (
    <React.Fragment>
      <h5 className="text-center font-weight-bold mb-3">Trade Management</h5>
      {!loading
        ? trade_list.length>0
          ? <div className="card overflow-hidden">
              <TableContainer>
                <Table>
                  <TableHead>
                    <TableRow>
                      <TableCell className="font-weight-bold">Name</TableCell>
                      <TableCell className="font-weight-bold" width={150}>Phone Number</TableCell>
                      <TableCell className="font-weight-bold">In Charge</TableCell>
                      <TableCell className="font-weight-bold" width={100}>Floor</TableCell>
                      <TableCell className="font-weight-bold" width={100}>Block</TableCell>
                      <TableCell className="font-weight-bold">Description</TableCell>
                      <TableCell className="p-0" align="right" width={100}><AddButton dispatch={dispatch}/></TableCell>
                    </TableRow>
                  </TableHead>
                  <TableBody>
                    {trade_list.map((trade, i) => (
                      <TableRow key={trade.name}>
                        <TableCell component="th" scope="row">
                          {trade.name}
                        </TableCell>
                        <TableCell>{trade.phone?trade.phone:'-'}</TableCell>
                        <TableCell>{trade.in_charge?trade.in_charge:'-'}</TableCell>
                        <TableCell>{trade.floor?trade.floor:'-'}</TableCell>
                        <TableCell>{trade.block?trade.block:'-'}</TableCell>
                        <TableCell>{trade.description?trade.description:'-'}</TableCell>
                        <TableCell align="right">
                          <ActionButton dispatch={dispatch} rowData={trade} rowKeyValue={i}/>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </TableContainer>
            </div>
          : <Empty text="No Trade Found!" btn btn_text="Add new trade" btn_action={() => dispatch({type: 'ADD'})}/>
        : <Loading text="Getting trade list..."/>
      }
      <AddOrUpdate
        open={open}
        handleClose={handleClose}
        updateList={updateList}
        update={update}
        trade_info={trade_info}
      />
    </React.Fragment>
  );
}

export default React.memo(Trade);