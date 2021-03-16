import React from 'react';
import {
  Box,
  Collapse,
  IconButton,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  TableFooter,
  TablePagination,
} from '@material-ui/core';
import {
  KeyboardArrowDown,
  KeyboardArrowUp,
  FirstPage,
  KeyboardArrowLeft,
  KeyboardArrowRight,
  LastPage,
  ArrowBackRounded
} from '@material-ui/icons';
import { useTheme } from '@material-ui/core/styles';
import DataLoading from 'components/loading/DataLoading';
import {PrintButton} from 'components/PDF';
import { transactionHistory } from '../server_action';
import {url} from 'util/Api';


const Row = React.memo((props)=>{
  const { row } = props;
  const [open, setOpen] = React.useState(false);

  const payment_date = new Date(row.payment_date.split('T')[0]).toDateString().split(' ').slice(1)

  return (
    <React.Fragment>
      <TableRow hover onClick={() => setOpen(!open)}>
        <TableCell className="py-2">
          <IconButton aria-label="expand row" size="small" onClick={() => setOpen(!open)}>
            {open ? <KeyboardArrowUp /> : <KeyboardArrowDown />}
          </IconButton>
        </TableCell>
        <TableCell className="py-2">{`${payment_date[0]} ${payment_date[1]}, ${payment_date[2]}`}</TableCell>
        <TableCell className="py-2 font-weight-bold">
          {row.pay_for.map(val => val.payment_head).join(', ')}
        </TableCell>
        <TableCell className="py-2">{row.payment_by}</TableCell>
        <TableCell className="py-2" align="right">{row.total_payment.toLocaleString()}</TableCell>
      </TableRow>
      <TableRow>
        <TableCell style={{ paddingBottom: 0, paddingTop: 0 }} colSpan={6}>
          <Collapse in={open} timeout="auto" unmountOnExit>
            <Box className="mx-5 my-3">
              <div className="d-flex justify-content-between align-items-center py-2">
                <h6 className="m-0 font-weight-bold text-secondary">Payment Details</h6>
                <PrintButton url={`${url}/print/paymentVoucher?voucher_id=${row.voucher_id}`} />
              </div>
              <Table size="small" aria-label="purchases">
                <TableHead>
                  <TableRow>
                    <TableCell className="text-primary border-primary font-weight-bold">Date</TableCell>
                    <TableCell className="text-primary border-primary font-weight-bold">Payment for</TableCell>
                    <TableCell className="text-primary border-primary font-weight-bold" align="right">Amount</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {row.pay_for.map((pay) => (
                    <TableRow hover key={pay.payment_head}>
                      <TableCell className="border-primary" component="th" scope="row">
                        {`${payment_date[0]} ${payment_date[1]}, ${payment_date[2]}`}
                      </TableCell>
                      <TableCell className="border-primary">{pay.payment_head}</TableCell>
                      <TableCell className="border-primary" align="right">{pay.amount.toLocaleString()}</TableCell>
                    </TableRow>
                  ))}
                  
                  <TableRow>
                    <TableCell className="border-bottom-0" rowSpan={3}/>
                    <TableCell className="border-bottom-0">Total</TableCell>
                    <TableCell className="border-bottom-0" align="right">{row.total_payment.toLocaleString()}</TableCell>
                  </TableRow>

                </TableBody>
              </Table>
            </Box>
          </Collapse>
        </TableCell>
      </TableRow>
    </React.Fragment>
  );
})

// eslint-disable-next-line
export default ({history})=>{
  const [payment_list, setPaymentList] = React.useState([])
  const [loading, setLoading] = React.useState(true)
  const [page, setPage] = React.useState(0);
  const [rowsPerPage, setRowsPerPage] = React.useState(10);

  React.useEffect(()=>{
    transactionHistory('E')
      .then(resp => resp.success && setPaymentList(resp.list))
      .finally(()=> setLoading(false))
  },[])

  const emptyRows = rowsPerPage - Math.min(rowsPerPage, payment_list.length - page * rowsPerPage);

  const handleChangePage = (_, newPage) => setPage(newPage);

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(parseInt(event.target.value, 10));
    setPage(0);
  };

  return (
    <div className="app-wrapper">
      <h5 className="text-center font-weight-bold mb-3">Payment History</h5>
      <div className="card overflow-hidden">
        <TableContainer>
          <Table aria-label="collapsible table">
            <TableHead style={{background: 'var(--light)'}}>
              <TableRow>
                <TableCell className="py-0">
                  <IconButton className="p-2" onClick={()=>history.goBack()}>
                    <ArrowBackRounded fontSize="small" color="primary"/>
                  </IconButton>
                </TableCell>
                <TableCell className="text-primary font-weight-bold" style={{minWidth: 120}}>Payment Date</TableCell>
                <TableCell className="text-primary font-weight-bold">Paid For</TableCell>
                <TableCell className="text-primary font-weight-bold">Paid By</TableCell>
                <TableCell className="text-primary font-weight-bold" align="right">Total</TableCell>
              </TableRow>
            </TableHead>
              {!loading &&
                <TableBody>
                  {(rowsPerPage > 0
                    ? payment_list.slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
                    : payment_list).map((row, i) => (
                      <Row key={i} row={row} />
                    ))}

                  {emptyRows > 0 && (
                    <TableRow><TableCell colSpan={6} /></TableRow>
                  )}
                </TableBody>
              }
            <TableFooter>
              <TablePagination
                rowsPerPageOptions={[10, 20, 30, 40, 50]}
                colSpan={3}
                count={payment_list.length}
                rowsPerPage={rowsPerPage}
                page={page}
                onChangePage={handleChangePage}
                onChangeRowsPerPage={handleChangeRowsPerPage}
                ActionsComponent={TablePaginationActions}
              />
            </TableFooter>
          </Table>
          {loading && <DataLoading/>}
        </TableContainer>
      </div>
    </div>
  );
}



function TablePaginationActions(props) {
  const theme = useTheme();
  const { count, page, rowsPerPage, onChangePage } = props;

  const handleFirstPageButtonClick = (event) => {
    onChangePage(event, 0);
  };

  const handleBackButtonClick = (event) => {
    onChangePage(event, page - 1);
  };

  const handleNextButtonClick = (event) => {
    onChangePage(event, page + 1);
  };

  const handleLastPageButtonClick = (event) => {
    onChangePage(event, Math.max(0, Math.ceil(count / rowsPerPage) - 1));
  };

  return (
    <div style={{flexShrink: 0}}>
      <IconButton
        onClick={handleFirstPageButtonClick}
        disabled={page === 0}
        aria-label="first page"
      >
        {theme.direction === 'rtl' ? <LastPage /> : <FirstPage />}
      </IconButton>
      <IconButton onClick={handleBackButtonClick} disabled={page === 0} aria-label="previous page">
        {theme.direction === 'rtl' ? <KeyboardArrowRight /> : <KeyboardArrowLeft />}
      </IconButton>
      <IconButton
        onClick={handleNextButtonClick}
        disabled={page >= Math.ceil(count / rowsPerPage) - 1}
        aria-label="next page"
      >
        {theme.direction === 'rtl' ? <KeyboardArrowLeft /> : <KeyboardArrowRight />}
      </IconButton>
      <IconButton
        onClick={handleLastPageButtonClick}
        disabled={page >= Math.ceil(count / rowsPerPage) - 1}
        aria-label="last page"
      >
        {theme.direction === 'rtl' ? <FirstPage /> : <LastPage />}
      </IconButton>
    </div>
  );
}
