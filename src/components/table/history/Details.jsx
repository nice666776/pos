import React from 'react';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';

const total = (list, history_type)=>{
  let total = 0
  list.forEach(val=>{
    const price = history_type==='Sales'?val.mrp_price:val.unit_price
    total += price * val.quantity
  })
  return total
}

export default function DetailsTable({purchase_list, discount, payment, history_type}) {
  const total_price = total(purchase_list, history_type)
  return (
    <div className="mx-4 mb-3 py-3 shadow border border-secondary">
      <h6 className="text-center font-weight-bold">{history_type==='Sales'?'Sales':'Purchase'} Details</h6>
      <Table size="small">
        <TableHead>
          <TableRow>
            <TableCell>Product Name</TableCell>
            <TableCell align="right">Unit price</TableCell>
            <TableCell align="right">Quantity</TableCell>
            <TableCell align="right">Total</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {purchase_list.map((product, i) => {
            const price = history_type==='Sales'?product.mrp_price:product.unit_price
            return(
              <TableRow key={i} hover>
                <TableCell>{product.product_name}</TableCell>
                <TableCell align="right">{price.toLocaleString()}</TableCell>
                <TableCell align="right">{product.quantity}</TableCell>
                <TableCell align="right">{(price * product.quantity).toLocaleString()}</TableCell>
              </TableRow>
            )
          })}

          <TableRow>
            <TableCell className="border-0" colSpan={2}/>
            <TableCell className="font-weight-bold">Subtotal</TableCell>
            <TableCell className="font-weight-bold" align="right">{total_price.toLocaleString()}</TableCell>
          </TableRow>
          <TableRow>
            <TableCell className="border-0" colSpan={2}/>
            <TableCell className="font-weight-bold">Discount</TableCell>
            <TableCell className="font-weight-bold" align="right">{discount.toLocaleString()}</TableCell>
          </TableRow>
          <TableRow>
            <TableCell className="border-0" colSpan={2}/>
            <TableCell className="border-0 font-weight-bold">Total</TableCell>
            <TableCell className="border-0 font-weight-bold" align="right">{(total_price-discount).toLocaleString()}</TableCell>
          </TableRow>
          {/* <TableRow>
            <TableCell className="border-0" colSpan={2}/>
            <TableCell className="border-0 font-weight-bold">Payment</TableCell>
            <TableCell className="border-0 font-weight-bold" align="right">{payment.toLocaleString()}</TableCell>
          </TableRow> */}
        </TableBody>
      </Table>
    </div>
  );
}
