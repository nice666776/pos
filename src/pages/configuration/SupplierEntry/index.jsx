import React from 'react';
import {
  Dialog,
  DialogTitle,
  DialogContent,
} from '@material-ui/core';
import { kaReducer, Table } from 'ka-table';
import { FilteringMode } from 'ka-table/enums';
import { updateData, hideLoading, showLoading } from 'ka-table/actionCreators';
import { ActionButton, AddButton } from '../../../components/table-component';
import SupplierForm from '../../../components/forms/configuration/supplier-entry';
import { supplierList } from '../server_action';


const row = {paddingTop: 2, paddingBottom: 2}
const columns = [
  { key: 'name', title: 'Name', isResizable: true, style:{...row}},
  { key: 'company', title: 'Company', isResizable: true, style:{...row}},
  { key: 'mobile', title: 'Mobile No.', isResizable: true, style:{...row}},
  { key: 'email', title: 'Email', isResizable: true, style:{...row}},
  { key: 'address', title: 'Address', isResizable: true, style:{...row}},
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

const AddOrUpdate = React.memo(({open, handleClose, updateList, update, supplier_info})=>{
  return(
    <Dialog
      open={open}
      onClose={handleClose}
      aria-labelledby="dialog-title"
      aria-describedby="dialog-description"
      scroll="body"
    >
      <DialogTitle className="text-center" id="dialog-title">{update?'Update Supplier':'Add Supplier'}</DialogTitle>
      <DialogContent>
        <SupplierForm updateList={updateList} update={update} supplier_info={supplier_info} handleClose={handleClose}/>
      </DialogContent>
    </Dialog>
  )
})



const SupplierEntry = ()=>{
  const [open, setOpen] = React.useState(false)
  const [tableProps, changeTableProps] = React.useState(tablePropsInit);
  const [supplier_info, setSupplierInfo] = React.useState({})
  const [update, setUpdate] = React.useState(false)

  const dispatch = React.useCallback((action) => {
    if(action.type === 'EDIT'){
      setOpen(true)
      setSupplierInfo(action.rowData)
      setUpdate(true)
    } else if(action.type === 'ADD') {
      setOpen(true)
      setSupplierInfo({})
      setUpdate(false)
    }
    changeTableProps((prevState) => kaReducer(prevState, action));
  }, [changeTableProps, setOpen])

  React.useEffect(()=>{
    dispatch(showLoading('Getting Data ...'))
    supplierList()
      .then(resp => {
        if(resp.success){
          dispatch(updateData(resp.message))
        }
      })
      .finally(()=>dispatch(hideLoading()))
  }, [dispatch])

  const handleClose = React.useCallback(()=> setOpen(false), [setOpen])

  const updateList = React.useCallback((data, type="ADD_NEW")=>{
    const new_list = [...tableProps.data]
    if(type === "ADD_NEW"){
      new_list.push(data)
    } else if(type === "UPDATE") {
      const index = new_list.findIndex(val => val.id === data.id)
      new_list[index] = data
    }
    dispatch(updateData(new_list))
    handleClose()
  }, [tableProps, dispatch, handleClose])



  return(
    <React.Fragment>
      <h5 className="text-center font-weight-bold">Suppliers</h5>
      <div className="card overflow-hidden">
        <Table
          {...tableProps}
          dispatch={dispatch}
          childComponents={{
            filterRowCell: {
              content: (props) => {
                // eslint-disable-next-line
                switch(props.column.key){
                  case 'address': return <React.Fragment/>
                  case 'action': return <React.Fragment/>
                }
              }
            },
            cellText: {
              content: props => {
                switch(props.column.key){
                  case 'address': return <p className="text-truncate m-0">{`${props.rowData.address}, ${props.rowData.thana}, ${props.rowData.district}, ${props.rowData.division}`}</p>
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

      <AddOrUpdate
        open={open}
        handleClose={handleClose}
        updateList={updateList}
        update={update}
        supplier_info={supplier_info}
      />

    </React.Fragment>
  )
}

export default SupplierEntry;