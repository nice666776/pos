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
  Typography,
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
  const receipt_date = new Date(row.receipt_date.split('T')[0]).toDateString().split(' ').slice(1)

  return (
    <React.Fragment>
      <TableRow hover onClick={() => setOpen(!open)}>
        <TableCell className="py-2">
          <IconButton aria-label="expand row" size="small" onClick={() => setOpen(!open)}>
            {open ? <KeyboardArrowUp /> : <KeyboardArrowDown />}
          </IconButton>
        </TableCell>
        <TableCell className="py-2">{`${receipt_date[0]} ${receipt_date[1]}, ${receipt_date[2]}`}</TableCell>
        <TableCell className="py-2 font-weight-bold" component="th" scope="row">
          {row.pay_for.map(val => val.receipt_head).join(', ')}
        </TableCell>
        <TableCell className="py-2">{row.receipt_by}</TableCell>
        <TableCell className="py-2" align="center">{row.total_payment.toLocaleString()}</TableCell>
      </TableRow>
      <TableRow>
        <TableCell style={{ paddingBottom: 0, paddingTop: 0 }} colSpan={6}>
          <Collapse in={open} timeout="auto" unmountOnExit>
            <Box className="mx-5 my-3">
              <div className="d-flex justify-content-between">
                <Typography variant="h6" gutterBottom component="div">Receipt Details</Typography>
                <PrintButton url={`${url}/print/receiptVoucher?voucher_id=${row.voucher_id}`} />
              </div>
              <Table size="small" aria-label="purchases">
                <TableHead>
                  <TableRow>
                    <TableCell className="text-primary border-primary">Date</TableCell>
                    <TableCell className="text-primary border-primary">Receipt for</TableCell>
                    <TableCell className="text-primary border-primary" align="right">Amount</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {row.pay_for.map((pay) => (
                    <TableRow hover key={pay.receipt_head}>
                      <TableCell className="border-primary" component="th" scope="row">
                        {`${receipt_date[0]} ${receipt_date[1]}, ${receipt_date[2]}`}
                      </TableCell>
                      <TableCell className="border-primary">{pay.receipt_head}</TableCell>
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
  const [receipt_list, setReceiptList] = React.useState([])
  const [loading, setLoading] = React.useState(true)
  const [page, setPage] = React.useState(0);
  const [rowsPerPage, setRowsPerPage] = React.useState(10);

  React.useEffect(()=>{
    transactionHistory('I')
      .then(resp => resp.success && setReceiptList(resp.list))
      .finally(()=> setLoading(false))
  },[])

  const emptyRows = rowsPerPage - Math.min(rowsPerPage, receipt_list.length - page * rowsPerPage);

  const handleChangePage = (_, newPage) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(parseInt(event.target.value, 10));
    setPage(0);
  };

  return (
    <div className="app-wrapper">
      <h3 className="text-center font-weight-bold">Receipt History</h3>
      <div className="card p-0 overflow-hidden">
        <TableContainer>
          <Table aria-label="collapsible table">
            <TableHead style={{background: 'var(--light)'}}>
              <TableRow>
                <TableCell width={70} className="py-0">
                  <IconButton className="p-2" onClick={()=>history.goBack()}>
                    <ArrowBackRounded color="primary" fontSize="small"/>
                  </IconButton>
                </TableCell>
                <TableCell className="text-primary font-weight-bold" style={{minWidth: 120}}>Receipt Date</TableCell>
                <TableCell className="text-primary font-weight-bold">Receipt For</TableCell>
                <TableCell className="text-primary font-weight-bold">Receipt By</TableCell>
                <TableCell className="text-primary font-weight-bold" align="center">Total</TableCell>
              </TableRow>
            </TableHead>
              {!loading &&
                <TableBody>
                  {(rowsPerPage > 0
                    ? receipt_list.slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
                    : receipt_list).map((row, i) => (
                      <Row key={i} row={row} />
                    ))}

                  {emptyRows > 0 && (
                    <TableRow><TableCell colSpan={6} /></TableRow>
                  )}
                </TableBody>
              }
            <TableFooter>
              <TableRow>
                <TablePagination
                  rowsPerPageOptions={[10, 20, 30, 40, 50, 60, 70, 80, 90, 100]}
                  colSpan={3}
                  count={receipt_list.length}
                  rowsPerPage={rowsPerPage}
                  page={page}
                  onChangePage={handleChangePage}
                  onChangeRowsPerPage={handleChangeRowsPerPage}
                  ActionsComponent={TablePaginationActions}
                />
              </TableRow>
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

