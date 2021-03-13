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
import AccountGroupForm from 'components/forms/configuration/account-group';
import Empty from 'components/empty';
import Loading from 'components/loading/DataLoading';
import {tradeList} from '../server_action';



const AddOrUpdate = React.memo(({open, handleClose, updateList, update, group_info})=>{
  return(
    <Dialog
      open={open}
      onClose={handleClose}
      aria-labelledby="dialog-title"
      scroll="body"
      disableBackdropClick={true}
    >
      <DialogTitle className="text-center text-secondary" id="dialog-title">
        {update?'Update Account Group':'New Account Group'}
      </DialogTitle>
      <DialogContent>
        <AccountGroupForm updateList={updateList} update={update} group_info={group_info} handleClose={handleClose}/>
      </DialogContent>
    </Dialog>
  )
})

const AccountGroup = ()=>{
  const [open, setOpen] = React.useState(false)
  const [update, setUpdate] = React.useState(false)
  const [group_list, setGroupList] = React.useState([])
  const [group_info, setGroupInfo] = React.useState({})
  const [loading, setLoading] = React.useState(true)

  React.useEffect(()=>{
    tradeList()
      .then(resp => resp.success && setGroupList(resp.message))
      .finally(()=>setLoading(false))
  },[])

  const handleClose = React.useCallback(()=> setOpen(false), [setOpen])


  const updateList = React.useCallback((group, type)=> {
    let list = []
    if(type === 'ADD'){
      list = [group, ...group_list]
    } else {
      const index = group_list.findIndex(val=>val.id===group.id)
      group_list[index] = group
      list = [...group_list]
    }
    setGroupList(list)
    setOpen(false)
  }, [group_list])

  
  const dispatch = React.useCallback((action) => {
    if(action.type === 'EDIT'){
      setUpdate(true)
      setGroupInfo(action.rowData)
      setOpen(true)
    } else if(action.type === 'ADD') {
      setUpdate(false)
      setGroupInfo({})
      setOpen(true)
    }
  }, [setUpdate])

  return (
    <React.Fragment>
      <h5 className="text-center font-weight-bold mb-3">Account Group</h5>
      {!loading
        ? group_list.length>0
          ? <div className="card overflow-hidden">
              <TableContainer>
                <Table>
                  <TableHead>
                    <TableRow>
                      <TableCell className="font-weight-bold">Name</TableCell>
                      <TableCell className="font-weight-bold">Control Type</TableCell>
                      <TableCell className="font-weight-bold">Comments</TableCell>
                      <TableCell className="font-weight-bold">Description</TableCell>
                      <TableCell className="p-0" align="right" width={100}><AddButton dispatch={dispatch}/></TableCell>
                    </TableRow>
                  </TableHead>
                  <TableBody>
                    {group_list.map((group, i) => (
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
          : <Empty text="No Account Group Found!" btn btn_text="Add Account Group" btn_action={() => dispatch({type: 'ADD'})}/>
        : <Loading text="Getting Account Group list..."/>
      }
      <AddOrUpdate
        open={open}
        handleClose={handleClose}
        updateList={updateList}
        update={update}
        group_info={group_info}
      />
    </React.Fragment>
  );
}

export default React.memo(AccountGroup);