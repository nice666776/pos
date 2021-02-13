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
import ManufacturerForm from '../../../components/forms/product-configuration/manufacturer-form';
import { manufacturerList } from '../server_action';


const row = {paddingTop: 2, paddingBottom: 2}
const columns = [
  { key: 'name', title: 'Name', isResizable: true, style:{...row, minWidth: 200}},
  { key: 'brand', title: 'Brand', isResizable: true, style:{...row}},
  { key: 'contact_person', title: 'Contact Person', isResizable: true, style:{...row}},
  { key: 'phone', title: 'Phone No.', isResizable: true, style:{...row}},
  { key: 'email', title: 'Email', isResizable: true, style:{...row}},
  { key: 'address', title: 'Address', style:{...row}},
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

const AddOrUpdate = React.memo(({open, handleClose, updateList, update, manufacturer_info})=>{
  return(
    <Dialog
      open={open}
      onClose={handleClose}
      aria-labelledby="dialog-title"
      aria-describedby="dialog-description"
      scroll="body"
    >
      <DialogTitle className="text-center" id="dialog-title">{update?'Update Manufacturer':'Add Manufacturer'}</DialogTitle>
      <DialogContent>
        <ManufacturerForm updateList={updateList} update={update} manufacturer_info={manufacturer_info} handleClose={handleClose}/>
      </DialogContent>
    </Dialog>
  )
})



const ManufacturersList = ()=>{
  const [open, setOpen] = React.useState(false)
  const [tableProps, changeTableProps] = React.useState(tablePropsInit);
  const [manufacturer_info, setManufacturerInfo] = React.useState({})
  const [update, setUpdate] = React.useState(false)

  const dispatch = React.useCallback((action) => {
    if(action.type === 'EDIT'){
      setOpen(true)
      setManufacturerInfo(action.rowData)
      setUpdate(true)
    } else if(action.type === 'ADD') {
      setOpen(true)
      setManufacturerInfo({})
      setUpdate(false)
    }
    changeTableProps((prevState) => kaReducer(prevState, action));
  }, [changeTableProps, setOpen])

  React.useEffect(()=>{
    dispatch(showLoading('Getting Data ...'))
    manufacturerList()
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
      <h5 className="text-center font-weight-bold">Manufacturers</h5>
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
                  case 'action': return <ActionButton {...props} />
                  case 'name': return <p className="font-weight-bold text-truncate m-0">{props.value}</p>
                  default: return <p className="text-truncate m-0">{props.value}</p>
                }
              }
            },
            headCell: {
              content: props => {
                switch(props.column.key){
                  case 'action': return <AddButton {...props} />
                  default: return <div className="text-primary">{props.column.title}</div>
                }
              },
            },
            pagingIndex: {
              elementAttributes: ({ isActive }) => ({className: `page-item ${(isActive ? 'active' : '')}`}),
              content: ({ text }) => <div className='page-link'>{text}</div>
            },
          }}
        />
      </div>

      <AddOrUpdate
        open={open}
        handleClose={handleClose}
        updateList={updateList}
        update={update}
        manufacturer_info={manufacturer_info}
      />

    </React.Fragment>
  )
}

export default ManufacturersList;