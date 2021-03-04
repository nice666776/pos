import React from 'react';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import {PrintButton} from 'components/PDF';


export default function DetailsTable({purchase_list, discount, discount_p, payment, history_type, invoice}) {
  return (
    <div className="mx-4 mb-3 pb-3 shadow border border-secondary">
      <div className="row py-1 px-3">
        <div className="col"/>
        <div className="col d-flex align-items-center justify-content-center">
          <h6 className="text-center font-weight-bold">{history_type==='Sales'?'Sales':'Purchase'} Details</h6>
        </div>
        <div className="col d-flex justify-content-end align-items-center">
          <PrintButton url={`/print/${history_type==='Sales'?'receipt':'PurchaseOrder'}?invoice=${invoice}`}/>
        </div>
      </div>
      
      <Table size="small">
        <TableHead>
          <TableRow>
            <TableCell>Product Name</TableCell>
            <TableCell align="right">Unit price</TableCell>
            <TableCell align="center" width={100}>Quantity</TableCell>
            <TableCell align="center" width={110}>Discount(%)</TableCell>
            <TableCell align="right">Total</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {purchase_list.map((product, i) => {
            const price = history_type==='Sales'?product.mrp_price:product.unit_price
            const total = (price * product.quantity).toLocaleString()
            return(
              <TableRow key={i} hover>
                <TableCell>{product.product_name}</TableCell>
                <TableCell align="right">{price.toLocaleString()}</TableCell>
                <TableCell align="center">{product.quantity}</TableCell>
                <TableCell align="center">{product.discount}</TableCell>
                <TableCell align="right">
                  {product.discount&&product.discount>0 
                    ? <div>(<small><del>{total}</del></small>) {product.total_price}</div>
                    : product.total_price.toLocaleString()
                  }
                </TableCell>
              </TableRow>
            )
          })}

          <TableRow>
            <TableCell className="border-0" colSpan={3}/>
            <TableCell className="font-weight-bold">Subtotal</TableCell>
            <TableCell className="font-weight-bold" align="right">{payment.toLocaleString()}</TableCell>
          </TableRow>
          <TableRow>
            <TableCell className="border-0" colSpan={3}/>
            <TableCell className="font-weight-bold">Discount({discount_p}%)</TableCell>
            <TableCell className="font-weight-bold" align="right">{discount.toLocaleString()}</TableCell>
          </TableRow>
          <TableRow>
            <TableCell className="border-0" colSpan={3}/>
            <TableCell className="border-0 font-weight-bold">Total</TableCell>
            <TableCell className="border-0 font-weight-bold" align="right">{(payment-discount).toLocaleString()}</TableCell>
          </TableRow>
        </TableBody>
      </Table>
    </div>
  );
}
