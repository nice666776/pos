import React from 'react';
import Collapse from '@material-ui/core/Collapse';
import IconButton from '@material-ui/core/IconButton';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableContainer from '@material-ui/core/TableContainer';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import KeyboardArrowDownIcon from '@material-ui/icons/KeyboardArrowDown';
import KeyboardArrowUpIcon from '@material-ui/icons/KeyboardArrowUp';
import Details from './Details';


function Product({history, history_type}) {
  const [open, setOpen] = React.useState(false);
  return (
    <React.Fragment>
      <TableRow hover onClick={() => setOpen(!open)}>
        <TableCell className="border-bottom-0">
          <IconButton size="small" onClick={() => setOpen(!open)}>
            {open ? <KeyboardArrowUpIcon /> : <KeyboardArrowDownIcon />}
          </IconButton>
        </TableCell>
        <TableCell className="border-bottom-0" component="th" scope="row">
          {history_type==="Sales"?history.customer_name:history.supplier_name}
        </TableCell>
        <TableCell className="border-bottom-0">{history.invoice}</TableCell>
        <TableCell className="border-bottom-0">
          {history_type==="Sales"
            ? history.sales_list.map(val=>val.product_name).join(', ')
            : history.purchase_list.map(val=>val.product_name).join(', ')
          }
        </TableCell>
        <TableCell className="border-bottom-0" align="center">{history.payment.toLocaleString()}</TableCell>
        <TableCell className="border-bottom-0" align="center">{history.discount.toLocaleString()}</TableCell>
      </TableRow>
      <TableRow style={{height: 0}}>
        <TableCell className="p-0" colSpan={6}>
          <Collapse in={open} timeout="auto" unmountOnExit>
            <Details
              purchase_list={history_type==="Sales"?history.sales_list:history.purchase_list}
              discount={history.discount}
              payment={history.payment}
              history_type={history_type}
            />
          </Collapse>
        </TableCell>
      </TableRow>
    </React.Fragment>
  );
}


export default function HistoryTable({history_list, history_type}) {
  return (
    <div className="card overflow-hidden">
      <TableContainer>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell className="border-primary"/>
              <TableCell className="font-weight-bold border-primary">{history_type==='Sales'?'Customer':'Supplier'}</TableCell>
              <TableCell className="font-weight-bold border-primary">Invoice</TableCell>
              <TableCell className="font-weight-bold border-primary">Product List</TableCell>
              <TableCell className="font-weight-bold border-primary" align="center">payment</TableCell>
              <TableCell className="font-weight-bold border-primary" align="center">Discount</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {history_list.map((history) => (
              <Product key={history.name} history={history} history_type={history_type} />
            ))}
          </TableBody>
        </Table>
      </TableContainer>
    </div>
  );
}
