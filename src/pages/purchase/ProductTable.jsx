import React from 'react';
import {Dialog, DialogTitle, DialogContent} from '@material-ui/core';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableContainer from '@material-ui/core/TableContainer';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import { ActionButton, AddButton } from 'components/table-component';
import ProductInfoForm from 'components/forms/purchase/ProductInfo';




const AddOrUpdate = React.memo(({open, handleClose, updateList, update, product_info})=>{
  return(
    <Dialog
      open={open}
      onClose={handleClose}
      aria-labelledby="dialog-title"
      scroll="body"
      disableBackdropClick={true}
    >
      <DialogTitle className="text-center" id="dialog-title">{update?'Update Product':'Add Product'}</DialogTitle>
      <DialogContent>
        <ProductInfoForm updateList={updateList} update={update} product_info={product_info} handleClose={handleClose}/>
      </DialogContent>
    </Dialog>
  )
})


export default React.memo(({handlePurchaseList})=>{
  const [open, setOpen] = React.useState(false)
  const [update, setUpdate] = React.useState(false)
  const [purchase_list, setPurchaseList] = React.useState([])
  const [product_info, setProductInfo] = React.useState({})

  const handleClose = React.useCallback(()=> setOpen(false), [setOpen])


  const updateList = React.useCallback((product, type)=> {
    let list = []
    if(type === 'ADD'){
      list = [product, ...purchase_list]
    } else {
      const index = purchase_list.findIndex(val=>val.product_code===product.product_code)
      purchase_list[index] = product
      list = [...purchase_list]
    }
    setPurchaseList(list)
    handlePurchaseList(list)
    setOpen(false)
  }, [setOpen, purchase_list, handlePurchaseList])

  
  const dispatch = React.useCallback((action) => {
    if(action.type === 'EDIT'){
      setUpdate(true)
      setProductInfo(action.rowData)
      setOpen(true)
    } else if(action.type === 'ADD') {
      setUpdate(false)
      setProductInfo({})
      setOpen(true)
    } else if(action.type === 'DeleteRow'){
      purchase_list.splice(action.rowKeyValue, 1)
      setPurchaseList([...purchase_list])
      handlePurchaseList([...purchase_list])
    }
  }, [purchase_list, handlePurchaseList])



  return (
    <div className="card overflow-hidden">
      <TableContainer>
        <Table size="small">
          <TableHead style={{background: '#F1F5F7'}}>
            <TableRow>
              <TableCell className="font-weight-bold">Name</TableCell>
              <TableCell className="font-weight-bold">Category</TableCell>
              <TableCell className="font-weight-bold">Subcategory</TableCell>
              <TableCell className="font-weight-bold" align="center">Quantity</TableCell>
              <TableCell className="font-weight-bold" align="center">Unit Price</TableCell>
              <TableCell className="font-weight-bold" align="center">Total</TableCell>
              <TableCell className="p-0"><AddButton dispatch={dispatch}/></TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {purchase_list.map((product, i) => (
              <TableRow key={i} hover>
                <TableCell component="th" scope="row">{product.product_name}</TableCell>
                <TableCell>{product.category_name}</TableCell>
                <TableCell>{product.subcategory_name}</TableCell>
                <TableCell align="center">{product.quantity}</TableCell>
                <TableCell align="center">{product.unit_price}</TableCell>
                <TableCell align="center">{(product.unit_price * product.quantity).toLocaleString()}</TableCell>
                <TableCell className="p-0">
                  <ActionButton dispatch={dispatch} rowData={product} del rowKeyValue={i}/>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>

      <AddOrUpdate
        open={open}
        handleClose={handleClose}
        updateList={updateList}
        update={update}
        product_info={product_info}
      />

    </div>
  );
})
