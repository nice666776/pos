import { makeStyles } from "@material-ui/styles";

export default makeStyles(theme => ({
  textRow: {
    marginBottom: theme.spacing(10),
    textAlign: "center",
  },
  safetyText: {
    fontWeight: 300,
    color: theme.palette.text.hint,
  },
}));
