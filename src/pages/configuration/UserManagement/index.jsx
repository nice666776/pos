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
  TableRow,
  Chip
} from '@material-ui/core';
import { ActionButton, AddButton } from 'components/table-component';
import UserForm from 'components/forms/configuration/user-management';
import Empty from 'components/empty';
import Loading from 'components/loading/DataLoading';
import {userList} from '../server_action';



const AddOrUpdate = React.memo(({open, handleClose, updateList, update, user_info})=>{
  return(
    <Dialog
      open={open}
      onClose={handleClose}
      aria-labelledby="dialog-title"
      scroll="body"
      disableBackdropClick={true}
    >
      <DialogTitle className="text-center text-secondary" id="dialog-title">
        {update?'Update User Information':'Add User'}
      </DialogTitle>
      <DialogContent>
        <UserForm updateList={updateList} update={update} user_info={user_info} handleClose={handleClose}/>
      </DialogContent>
    </Dialog>
  )
})

const SystemUser = ()=>{
  const [open, setOpen] = React.useState(false)
  const [update, setUpdate] = React.useState(false)
  const [user_list, setUserList] = React.useState([])
  const [user_info, setUserInfo] = React.useState({})
  const [loading, setLoading] = React.useState(true)


  React.useEffect(()=>{
    userList()
      .then(resp => resp.success && setUserList(resp.message))
      .finally(()=>setLoading(false))
  },[])

  const handleClose = React.useCallback(()=> setOpen(false), [setOpen])


  const updateList = React.useCallback((trade, type)=> {
    let list = []
    if(type === 'ADD'){
      list = [trade, ...user_list]
    } else {
      const index = user_list.findIndex(val=>val.id===trade.id)
      user_list[index] = trade
      list = [...user_list]
    }
    setUserList(list)
    setOpen(false)
  }, [user_list])

  
  const dispatch = React.useCallback((action) => {
    if(action.type === 'EDIT'){
      setUpdate(true)
      setUserInfo(action.rowData)
      setOpen(true)
    } else if(action.type === 'ADD') {
      setUpdate(false)
      setUserInfo({})
      setOpen(true)
    }
  }, [setUpdate])


  return (
    <React.Fragment>
      <h5 className="text-center font-weight-bold mb-3">System User Management</h5>
      {!loading
        ? user_list.length>0
          ? <div className="card overflow-hidden">
              <TableContainer>
                <Table>
                  <TableHead>
                    <TableRow>
                      <TableCell className="font-weight-bold" width={250}>Name</TableCell>
                      <TableCell className="font-weight-bold" align="center">Trade</TableCell>
                      <TableCell className="font-weight-bold" width={120} align="center">Role</TableCell>
                      <TableCell className="font-weight-bold" width={180}>Phone Number</TableCell>
                      <TableCell className="font-weight-bold" width={200}>Email</TableCell>
                      <TableCell className="font-weight-bold" width={100} align="center">Status</TableCell>
                      <TableCell className="p-0" align="right" width={100}><AddButton dispatch={dispatch}/></TableCell>
                    </TableRow>
                  </TableHead>
                  <TableBody>
                    {user_list.map((user, i) => (
                      <TableRow key={user.id}>
                        <TableCell component="th" scope="row">
                          {user.first_name} {user.last_name}
                        </TableCell>
                        <TableCell align="center">
                          {user.trade_list && user.trade_list.map(val=>(
                            <Chip label={val.name} style={{margin: 1}} size="small" color="primary"/>
                          ))}
                        </TableCell>
                        <TableCell align="center">{user.user_type}</TableCell>
                        <TableCell>{user.phone}</TableCell>
                        <TableCell>{user.email}</TableCell>
                        <TableCell align="center">
                          {user.status 
                            ? <Chip label="Active" style={{background: 'var(--success)', color: "white"}} size="small"/>
                            : <Chip label="Inactive" style={{background: 'var(--danger)', color: "white"}} size="small"/>}
                        </TableCell>
                        <TableCell align="right">
                          <ActionButton dispatch={dispatch} rowData={user} rowKeyValue={i} disabled={user.user_type === 'ADMIN'}/>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </TableContainer>
            </div>
          : <Empty text="No User Found!" btn btn_text="Add New User" btn_action={() => dispatch({type: 'ADD'})}/>
        : <Loading text="Getting user list..."/>
      }
      <AddOrUpdate
        open={open}
        handleClose={handleClose}
        updateList={updateList}
        update={update}
        user_info={user_info}
      />
    </React.Fragment>
  );
}

export default React.memo(SystemUser);