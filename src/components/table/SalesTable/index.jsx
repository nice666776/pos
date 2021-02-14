import React from 'react';
import { kaReducer, Table } from 'ka-table';
import { EditingMode, DataType } from 'ka-table/enums';
import { updateData } from 'ka-table/actionCreators';
import cogoToast from 'cogo-toast';
import { DeleteButton, AddButton } from '../../../components/table-component';
import BarcodeReader from 'react-barcode-reader';
import {productSaleinformation} from 'pages/sales/server_action';


const tableProps = {
  columns: [
    { key: 'product_code', title: 'Code', isEditable: false, visible: false },
    { key: 'product_name', title: 'Product Name', isEditable: false },
    { key: 'category_name', title: 'Category', isEditable: false },
    { key: 'sell_quantity', title: 'Quantity', dataType: DataType.Number, style: {width: 120, textAlign: 'center'} },
    { key: 'mrp_price', title: 'MRP', isEditable: false, style: {width: 150, textAlign: 'center'} },
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
      tableProps,
      total: 0
    };
  }

  // componentDidUpdate(){
  //   var total = 0
  //   const product_list = this.state.tableProps.data
  //   product_list.forEach(val=>{
  //     total += val.total_price
  //   })
  //   this.setState({total})
  // }

  dispatch = (action)=>{
    const new_data = kaReducer(this.state.tableProps, action)
    if(action.type === 'UpdateCellValue'){
      action.value = parseInt(action.value) > 0 ? parseInt(action.value) : 1
      const index = new_data.data.findIndex(val => val.product_code === action.rowKeyValue)
      new_data.data[index]['total_price'] = new_data.data[index]['mrp_price'] * action.value
      new_data.data[index]['sell_quantity'] = action.value
    }
    this.setState({tableProps: {...new_data}});
  }

  handleScan = (data)=>{
    const table_data = this.state.tableProps.data
    const index = table_data.findIndex(val => val.product_code === data)
    if(index === -1){
      productSaleinformation(data)
        .then(resp=>{
          if(resp.success){
            let pro_info = resp.message
            pro_info['sell_quantity'] = 1
            pro_info['total_price'] = pro_info.mrp_price
            table_data.push(pro_info)
            this.dispatch(updateData(table_data));
          }
        })
    } else {
      table_data[index]['sell_quantity'] += 1
      table_data[index]['total_price'] = table_data[index].mrp_price * table_data[index]['sell_quantity']
      this.dispatch(updateData(table_data));
    }
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
                  case 'action': return <DeleteButton {...props} />
                  default: return
                }
              }
            },
          }}
        />
      </div>
    );
  }
}

export default SalesTable;