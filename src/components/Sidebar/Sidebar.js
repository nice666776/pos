import React, { useState, useEffect } from "react";
import { Drawer, IconButton, List } from "@material-ui/core";
import {
  Home as HomeIcon,
  ArrowBack as ArrowBackIcon,
  Settings,
  Build,
  AddShoppingCart
} from "@material-ui/icons";
import { useTheme } from "@material-ui/styles";
import { withRouter } from "react-router-dom";
import classNames from "classnames";

// styles
import useStyles from "./styles";

// components
import SidebarLink from "./components/SidebarLink/SidebarLink";

// context
import {useLayoutState, useLayoutDispatch, toggleSidebar} from "../../context/LayoutContext";


const structure = [
  { label: "Dashboard", link: "/dashboard", icon: <HomeIcon />},
  { label: "Purchase", link: "/purchase", icon: <AddShoppingCart />},
  {
    label: "Product Configuration",
    link: "/product-configuration",
    icon: <Build />,
    children: [
      { label: "Manufacturers", link: "/product-configuration/manufacturers" },
      { label: "Categories", link: "/product-configuration/categories" },
      { label: "Products", link: "/product-configuration/products" },
    ],
  },
  {
    label: "Configuration",
    link: "/configuration",
    icon: <Settings />,
    children: [
      { label: "Suppliers", link: "/configuration/supplier-entry"},
      { label: "Util Info", link: "/configuration/util-info" },
    ],
  },
];




const Sidebar = ({ location })=>{
  var classes = useStyles();
  var theme = useTheme();

  // global
  var { isSidebarOpened } = useLayoutState();
  var layoutDispatch = useLayoutDispatch();

  // local
  var [isPermanent, setPermanent] = useState(true);


  const handleWindowWidthChange = ()=>{
    var windowWidth = window.innerWidth;
    var breakpointWidth = theme.breakpoints.values.md;
    var isSmallScreen = windowWidth < breakpointWidth;

    if (isSmallScreen && isPermanent) {
      setPermanent(false);
    } else if (!isSmallScreen && !isPermanent) {
      setPermanent(true);
    }
  }

  useEffect(function() {
    window.addEventListener("resize", handleWindowWidthChange);
    handleWindowWidthChange();
    return function cleanup() {
      window.removeEventListener("resize", handleWindowWidthChange);
    };
  });

  return (
    <Drawer
      variant={isPermanent ? "permanent" : "temporary"}
      className={classNames(classes.drawer, {
        [classes.drawerOpen]: isSidebarOpened,
        [classes.drawerClose]: !isSidebarOpened,
      })}
      classes={{
        paper: classNames({
          [classes.drawerOpen]: isSidebarOpened,
          [classes.drawerClose]: !isSidebarOpened,
        }),
      }}
      open={isSidebarOpened}
    >
      <div className={classes.toolbar} />
      <div className={classes.mobileBackButton}>
        <IconButton onClick={() => toggleSidebar(layoutDispatch)}>
          <ArrowBackIcon
            classes={{
              root: classNames(classes.headerIcon, classes.headerIconCollapse),
            }}
          />
        </IconButton>
      </div>
      <List className={classes.sidebarList}>
        {structure.map((link, i) => (
          <SidebarLink
            key={i}
            location={location}
            isSidebarOpened={isSidebarOpened}
            {...link}
          />
        ))}
      </List>
    </Drawer>
  );
  
}

export default withRouter(Sidebar);
