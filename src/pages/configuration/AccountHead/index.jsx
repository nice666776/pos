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
import AccountHeadForm from 'components/forms/configuration/account-head';
import Empty from 'components/empty';
import Loading from 'components/loading/DataLoading';
import {tradeList} from '../server_action';



const AddOrUpdate = React.memo(({open, handleClose, updateList, update, head_info})=>{
  return(
    <Dialog
      open={open}
      onClose={handleClose}
      aria-labelledby="dialog-title"
      scroll="body"
      disableBackdropClick={true}
      fullWidth
    >
      <DialogTitle className="text-center text-secondary" id="dialog-title">
        {update?'Update Account Head':'New Account Head'}
      </DialogTitle>
      <DialogContent>
        <AccountHeadForm updateList={updateList} update={update} head_info={head_info} handleClose={handleClose}/>
      </DialogContent>
    </Dialog>
  )
})

const AccountHead = ()=>{
  const [open, setOpen] = React.useState(false)
  const [update, setUpdate] = React.useState(false)
  const [head_list, setHeadList] = React.useState([])
  const [head_info, setHeadInfo] = React.useState({})
  const [loading, setLoading] = React.useState(true)

  React.useEffect(()=>{
    tradeList()
      .then(resp => resp.success && setHeadList(resp.message))
      .finally(()=>setLoading(false))
  },[])

  const handleClose = React.useCallback(()=> setOpen(false), [setOpen])


  const updateList = React.useCallback((group, type)=> {
    let list = []
    if(type === 'ADD'){
      list = [group, ...head_list]
    } else {
      const index = head_list.findIndex(val=>val.id===group.id)
      head_list[index] = group
      list = [...head_list]
    }
    setHeadList(list)
    setOpen(false)
  }, [head_list])

  
  const dispatch = React.useCallback((action) => {
    if(action.type === 'EDIT'){
      setUpdate(true)
      setHeadInfo(action.rowData)
      setOpen(true)
    } else if(action.type === 'ADD') {
      setUpdate(false)
      setHeadInfo({})
      setOpen(true)
    }
  }, [setUpdate])

  return (
    <React.Fragment>
      <h5 className="text-center font-weight-bold mb-3">Account Head</h5>
      {!loading
        ? head_list.length>0
          ? <div className="card overflow-hidden">
              <TableContainer>
                <Table>
                  <TableHead>
                    <TableRow>
                      <TableCell className="font-weight-bold">Name</TableCell>
                      <TableCell className="font-weight-bold">Account Group</TableCell>
                      <TableCell className="font-weight-bold" width={120}>Status</TableCell>
                      <TableCell className="font-weight-bold">Description</TableCell>
                      <TableCell className="p-0" align="right" width={100}><AddButton dispatch={dispatch}/></TableCell>
                    </TableRow>
                  </TableHead>
                  <TableBody>
                    {head_list.map((group, i) => (
                      <TableRow key={group.name}>
                        <TableCell component="th" scope="row">
                          {group.name}
                        </TableCell>
                        <TableCell>{group.phone?group.phone:'-'}</TableCell>
                        <TableCell>{group.in_charge?group.in_charge:'-'}</TableCell>
                        <TableCell>{group.description?group.description:'-'}</TableCell>
                        <TableCell align="right">
                          <ActionButton dispatch={dispatch} rowData={group} rowKeyValue={i}/>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </TableContainer>
            </div>
          : <Empty text="No Account Head Found!" btn btn_text="Add Account Head" btn_action={() => dispatch({type: 'ADD'})}/>
        : <Loading text="Getting Account Head list..."/>
      }
      <AddOrUpdate
        open={open}
        handleClose={handleClose}
        updateList={updateList}
        update={update}
        head_info={head_info}
      />
    </React.Fragment>
  );
}

export default React.memo(AccountHead);