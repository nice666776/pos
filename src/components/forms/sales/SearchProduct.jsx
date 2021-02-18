import React from 'react';
import {Button, TextField, CircularProgress} from '@material-ui/core';
import Autocomplete from '@material-ui/lab/Autocomplete';
import {searchProduct} from 'pages/sales/server_action';


const SearchProduct = ({handleClose, handleSearchinput})=>{
  const [options, setOptions] = React.useState([]);
  const [loading, setLoading] = React.useState(false);

  
  const handleSearch = React.useCallback((e)=>{
    setLoading(true)
    searchProduct(e.target.value)
      .then(resp => {
        if(resp.success)
          setOptions(resp.message)
        else setOptions([])
      })
      .finally(()=>setLoading(false))
  }, [])

  const handleSelected = React.useCallback((e, val)=>{
    val && val.product_code && handleSearchinput(val)
  }, [handleSearchinput])


  return (
    <React.Fragment>
      <Autocomplete
        style={{ minWidth: 350 }}
        loadingText="Searching..."
        getOptionLabel={(option) => option.product_name}
        onChange={handleSelected}
        options={options}
        loading={loading}
        freeSolo
        renderInput={(params) => (
          <TextField
            {...params}
            label="Product Name/Code"
            variant="outlined"
            autoFocus
            size="small"
            onChange={handleSearch}
            InputProps={{
              ...params.InputProps,
              endAdornment: (
                <React.Fragment>
                  {loading ? <CircularProgress color="secondary" size={20} /> : null}
                  {params.InputProps.endAdornment}
                </React.Fragment>
              )
            }}
          />
        )}
      />
      <div className="text-center mt-3">
        <Button variant="contained" size="small" onClick={handleClose}>Close</Button>
      </div>
    </React.Fragment>
  );
}


export default React.memo(SearchProduct);