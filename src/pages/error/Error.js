import React from "react";
import { Typography, Button } from "@material-ui/core";
import classnames from "classnames";
import useStyles from "./styles";
import logo from "./404.svg";

export default function Error({history}) {
  var classes = useStyles();

  return (
    <div className="">
      <div className="d-flex justify-content-center mb-3">
        <img width="40%" src={logo} alt="logo" />
      </div>
      <Typography variant="h5" color="primary" className={classes.textRow}>
        Oops. Looks like the page you're looking for no longer exists
      </Typography>
      <Typography
        variant="h6"
        color="text"
        colorBrightness="secondary"
        className={classnames(classes.textRow, classes.safetyText)}
      >
        But we're here to bring you back to safety
      </Typography>
      <div className="d-flex justify-content-center">
        <Button
          color="primary"
          variant="contained"
          onClick={()=>history.goBack()}
        >
          Go Back
        </Button>
      </div>
    </div>
  );
}
