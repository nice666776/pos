import React from 'react';
import {
  IconButton,
  Button
} from '@material-ui/core';
import {
  deleteRow,
} from 'ka-table/actionCreators';
import DataRowContent from "ka-table/Components/DataRowContent/DataRowContent";
import {
  EditTwoTone,
  DeleteTwoTone,
  AddRounded
} from '@material-ui/icons';


export const DataRow = React.memo(
  props => <DataRowContent {...props} />,
  () => true
);

export const ActionButton = React.memo((props) => {
  const { dispatch, rowKeyValue, rowData, del } = props
  return (
    <div className="d-flex justify-content-center animated zoomIn animation-duration-3">
      <IconButton className="p-1" onClick={() => dispatch({type: 'EDIT', rowData})}>
        <EditTwoTone color="primary"/>
      </IconButton>
      {del &&
        <IconButton className="p-1" onClick={() => dispatch(deleteRow(rowKeyValue))}>
          <DeleteTwoTone color="error"/>
        </IconButton>
      }
    </div>
  );
})


export const AddButton = React.memo((props) => {
  const { dispatch } = props
  return (
    <div className="d-flex justify-content-center animated zoomIn animation-duration-3">
      <Button className="p-0 m-0" variant="contained" color="secondary" onClick={() => dispatch({type: 'ADD'})}>
        <AddRounded fontSize="small"/> Add
      </Button>
    </div>
  );
})