import React from 'react';
import {
  Dialog,
  DialogTitle,
  DialogContent,
} from '@material-ui/core';
import { kaReducer, Table } from 'ka-table';
import { EditingMode, DataType } from 'ka-table/enums';
import { updateData } from 'ka-table/actionCreators';
import cogoToast from 'cogo-toast';
import SearchProduct from 'components/forms/sales/SearchProduct'; 
import { DeleteButton, AddButton } from '../../../components/table-component';
import BarcodeReader from 'react-barcode-reader';
import {productSaleinformation} from 'pages/sales/server_action';


const tableProps = {
  columns: [
    { key: 'product_code', title: 'Code', isEditable: false, visible: false },
    { key: 'product_name', title: 'Product Name', isEditable: false },
    { key: 'category_name', title: 'Category', isEditable: false },
    { key: 'mrp_price', title: 'MRP', isEditable: false, style: {width: 140, textAlign: 'center'} },
    { key: 'quantity', title: 'Quantity', dataType: DataType.Number, style: {width: 110, textAlign: 'center'} },
    { key: 'discount', title: 'Discount (%)', dataType: DataType.Number, style: {width: 110, textAlign: 'center'} },
    { key: 'total_price', title: 'Total', isEditable: false, style: {width: 150, textAlign: 'center'} },
    { key: 'action', isEditable: false, style: {width: 90} },
  ],
  data: [],
  editingMode: EditingMode.Cell,
  rowKeyField: 'product_code',
};

class SalesTable extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      tableProps: {...tableProps},
      modal_open: false
    };
  }

  dispatch = (action)=>{
    if(action.type === 'OpenEditor' && action.columnKey === "action")
      return
    else if(action.type === 'ADD'){
      this.setState({modal_open: true})
      return
    }
    const new_data = this.state.tableProps
    if(action.type === 'UpdateCellValue'){
      const index = new_data.data.findIndex(val => val.product_code === action.rowKeyValue)
      if(action.columnKey === "quantity"){
        action.value = parseInt(action.value) > 0 ? parseInt(action.value) : 1
        let total = new_data.data[index]['mrp_price'] * action.value
        new_data.data[index]['total_price'] = total - (total*new_data.data[index]['discount']/100)
        new_data.data[index]['quantity'] = action.value
      } else if(action.columnKey === "discount") {
        action.value = parseInt(action.value) > -1 ? parseInt(action.value) : 0
        let total = new_data.data[index]['mrp_price'] * new_data.data[index]['quantity']
        new_data.data[index]['total_price'] = total - (total*action.value/100)
        new_data.data[index]['discount'] = action.value
      }
      this.props.updateSaleList(new_data.data)
    }
    const update_table = kaReducer(new_data, action)
    this.setState({tableProps: update_table});
    if(action.type === 'UpdateData' || action.type === 'DeleteRow'){
      this.props.updateSaleList(update_table.data)
    }
  }

  componentDidMount(){
    this.dispatch(updateData([]))
  }

  handleClose = ()=> this.setState({modal_open: false})

  handleScan = (data)=>{
    const table_data = this.state.tableProps.data
    const index = table_data.findIndex(val => val.product_code === data)
    if(index === -1){
      productSaleinformation(data)
        .then(resp=>{
          if(resp.success){
            let pro_info = resp.message
            pro_info['quantity'] = 1
            pro_info['total_price'] = pro_info.mrp_price
            table_data.push(pro_info)
            this.dispatch(updateData(table_data));
          } else cogoToast.error(resp.message)
        })
    } else {
      table_data[index]['quantity'] += 1
      let total = table_data[index]['mrp_price'] * table_data[index]['quantity']
      table_data[index]['total_price'] = total - (total*table_data[index]['discount']/100)
      this.dispatch(updateData(table_data));
    }
  }

  handleSearchinput = (product)=>{
    this.handleScan(product.product_code)
    this.setState({modal_open: false})
  }

  handleError = (err)=> cogoToast.error(err)

  render() {
    return (
      <div className="card p-0 overflow-hidden">
        <BarcodeReader onError={this.handleError} onScan={this.handleScan}/>
        <Table
          {...this.state.tableProps}
          dispatch={this.dispatch}
          childComponents={{
            headCell: {
              content: props => {
                switch(props.column.key){
                  case 'action': return <AddButton {...props} />
                  default: return <div className="text-primary py-2">{props.column.title}</div>
                }
              },
            },
            cellText: {
              content: props => {
                switch(props.column.key){
                  case 'total_price': return props.rowData.discount>0
                                              ? <div>(<del>{props.rowData.mrp_price*props.rowData.quantity}</del>) {props.value}</div>
                                              : <div>{props.value}</div>
                  case 'action': return <DeleteButton {...props} />
                  default: return
                }
              }
            },
          }}
        />
        <AddProduct open={this.state.modal_open} handleClose={this.handleClose} handleSearchinput={this.handleSearchinput}/>
      </div>
    );
  }
}

const AddProduct = React.memo(({open, handleClose, handleSearchinput})=>{
  return(
    <Dialog
      open={open}
      onClose={handleClose}
      scroll="body"
      disableBackdropClick={true}
    >
      <DialogTitle className="text-center">Search Product</DialogTitle>
      <DialogContent>
        <SearchProduct handleSearchinput={handleSearchinput} handleClose={handleClose}/>
      </DialogContent>
    </Dialog>
  )
})

export default SalesTable;