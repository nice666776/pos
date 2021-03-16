import React from 'react';
import {
  Dialog,
  DialogTitle,
  DialogContent,
  Chip
} from '@material-ui/core';
import { kaReducer, Table } from 'ka-table';
import { FilteringMode } from 'ka-table/enums';
import { updateData, hideLoading, showLoading } from 'ka-table/actionCreators';
import { ActionButton, AddButton } from 'components/table-component';
import AccountHeadForm from 'components/forms/configuration/account-head';
import Empty from 'components/empty';
import {accountHeadList} from '../server_action';


const row = {paddingTop: 2, paddingBottom: 2}
const columns = [
  { key: 'ac_head_name', title: 'Head Name', isResizable: true, style:{...row}},
  { key: 'ac_group_id', title: 'Group', style:{...row, width: 150, textAlign: 'center'}},
  { key: 'ac_type', title: 'Account Type', style:{...row, width: 150, textAlign: 'center'}},
  { key: 'ac_status', title: 'Status', isResizable: true, style:{...row, width: 150, textAlign: 'center'}},
  { key: 'description', title: 'Description', style:{...row}},
  { key: 'action', style:{...row, width: 80}},
]

const tablePropsInit = {
  columns: columns,
  data: [],
  rowKeyField: 'id',
  filteringMode: FilteringMode.FilterRow,
  paging: {
    enabled: true,
    pageIndex: 0,
    pageSize: 20,
  }
}

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
  const [tableProps, changeTableProps] = React.useState(tablePropsInit);
  const [head_info, setHeadInfo] = React.useState({})
  const [is_empty, setIsEmpty] = React.useState(false)

  
  const handleClose = React.useCallback(()=> setOpen(false), [setOpen])

  const dispatch = React.useCallback((action) => {
    if(action.type === 'EDIT'){
      setOpen(true)
      setHeadInfo(action.rowData)
      setUpdate(true)
    } else if(action.type === 'ADD') {
      setOpen(true)
      setHeadInfo({})
      setUpdate(false)
    }
    changeTableProps((prevState) => kaReducer(prevState, action));
  }, [changeTableProps, setOpen])

  const updateList = React.useCallback((data, type="ADD")=>{
    const new_list = [...tableProps.data]
    if(type === "ADD"){
      new_list.push(data)
    } else if(type === "UPDATE") {
      const index = new_list.findIndex(val => val.id === data.id)
      new_list[index] = data
    }
    dispatch(updateData(new_list))
    handleClose()
  }, [tableProps, dispatch, handleClose])

  React.useEffect(()=>{
    dispatch(showLoading('Getting Accounts Head list...'))
    accountHeadList()
      .then(resp => {
        if(resp.success){
          dispatch(updateData(resp.message)) 
          setIsEmpty(resp.message.length===0)
        }})
      .finally(()=>dispatch(hideLoading()))
  }, [dispatch])

  return (
    <React.Fragment>
      <h5 className="text-center font-weight-bold mb-3">Accounts Head</h5>
      {!is_empty
        ? <div className="card overflow-hidden">
            <Table
              {...tableProps}
              dispatch={dispatch}
              childComponents={{
                filterRowCell: {
                  content: (props) => {
                    switch(props.column.key){
                      case 'ac_status': return <React.Fragment/>
                      case 'description': return <React.Fragment/>
                      case 'action': return <React.Fragment/>
                      default: return
                    }
                  }
                },
                cellText: {
                  content: props => {
                    switch(props.column.key){
                      case 'ac_status': return <Chip label={props.value?'Active':'Inactive'} color={props.value?'primary':'secondary'} size="small" />
                      case 'action': return <ActionButton {...props} />
                      default: return <p className="text-truncate m-0">{props.value}</p>
                    }
                  }
                },
                headCell: {
                  content: props => {
                    switch(props.column.key){
                      case 'action': return <AddButton {...props} />
                      default: return <div className="pt-2 text-primary">{props.column.title}</div>
                    }
                  },
                },
                pagingIndex: {
                  elementAttributes: ({ isActive }) => ({
                    className: `page-item ${(isActive ? 'active' : '')}`
                  }),
                  content: ({ text }) => <div className='page-link p-2'>{text}</div>
                },
              }}
            />
          </div>
        : <Empty text="No Account Head Found!" btn btn_text="Add Account Head" btn_action={() => dispatch({type: 'ADD'})}/>
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