<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Style Region - Body</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script> -->
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain;
        var dsMain;

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName : "country"
        }, {
            fieldName : "year",
            dataType : "number"
        }, {
            fieldName : "comm_code"
        }, {
            fieldName : "commodity"
        }, {
            fieldName : "flow"
        }, {
            fieldName : "trade",
            dataType : "number"
        }, {
            fieldName : "weight",
            dataType : "number"
        }, {
            fieldName : "unit"
        } ]);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name" : "Country",
            "fieldName" : "country",
            "width" : 60,
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "CommCode",
            "fieldName" : "comm_code",
            "width" : 70,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "CommCode"
            }
        }, {
            "name" : "Commodity",
            "fieldName" : "commodity",
            "width" : "70",
            "styles" : {},
            "header" : {
                "text" : "Commodity"
            }
        }, {
            "name" : "Year",
            "fieldName" : "year",
            "width" : "65",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Year"
            }
        }, {
            "name" : "Flow",
            "fieldName" : "flow",
            "width" : 60,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Flow"
            }
        }, {
            "name" : "Trade",
            "fieldName" : "trade",
            "width" : 70,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0"
            },
            "header" : {
                "text" : "Trade"
            },
            "groupFooter" : {
                "expression" : "sum",
                "styles" : {
                    "textAlignment" : "far",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "Weight",
            "fieldName" : "weight",
            "width" : 70,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0"
            },
            "header" : {
                "text" : "Weight"
            },
            "footer" : {
                "expression" : "sum / 1000",
                "styles" : {
                    "textAlignment" : "far",
                    "numberFormat" : "#,##0",
                    "suffix" : "K"
                }
            }
        }, {
            "name" : "Unit",
            "fieldName" : "unit",
            "width" : 110,
            "fillWidth" : 1,
            "styles" : {},
            "header" : {
                "text" : "Unit"
            }
        } ]);
        grdMain2 = DataLudi.createGridView("container2");

        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.footer().setVisible(true);
        grdMain.groupPanel().setVisible(true);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        grdMain2.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        $('#edtEmptyMessage').val(grdMain2.displayOptions().emptyGridMessage());

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url : "data/un_comtrade_of_goods_s.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1,
                    count : 5,
                    quoted : true,
                    currency : true
                });
            },
            error : function(xhr, status, error) {
                var err = status + ', ' + error;
                alert("jQuery getJSON() Failed: " + err);
            }
        });

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // buttons
        $('#btnSetBodyColor').click(function() {
            grdMain.loadStyles({
                body : {
                    background : "#25ffff00"
                }
            });
        });
        $('#btnClearBodyColor').click(function() {
            grdMain.loadStyles({
                body : {
                    background : null
                }
            });
        });
        $('#btnSetRowStyles').click(function() {
            grdMain.loadStyles({
                body : {
                    row : {
                        background : "#1500ff88",
                        borderBottom : "#00f"
                    }
                }
            });
        });
        $('#btnClearRowStyles').click(function() {
            grdMain.loadStyles({
                body : {
                    row : {
                        background : null,
                        borderBottom : undefined
                    }
                }
            });
        });
        $('#btnSetCellStyles').click(function() {
            grdMain.loadStyles({
                body : {
                    cell : {
                        background : "#15ff0088"
                    }
                }
            });
        });
        $('#btnClearCellStyles').click(function() {
            grdMain.loadStyles({
                body : {
                    cell : {
                        background : undefined
                    }
                }
            });
        });
        $('#btnSetEmptyStyles').click(function() {
            grdMain2.loadStyles({
                body : {
                    empty : {
                        background : "#10ff0000",
                        color : "#00f",
                        fontName : "Courier New",
                        fontSize : 14
                    }
                }
            });
        });
        $('#btnSetEmptyMessage').click(function() {
            grdMain2.displayOptions().setEmptyGridMessage($('#edtEmptyMessage').val());
            grdMain2.refreshView();
        });
    });
</script>
</head>
<body>
    <h3>Style Region - Body</h3>
    <div>
        <button id="btnSetBodyColor">Set Body Background</button>
        <button id="btnClearBodyColor">Clear Body Background</button>
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <button id="btnSetRowStyles">Set Row Styles</button>
        <button id="btnClearRowStyles">Clear Row Styles</button>
    </div>
    <div>
        <button id="btnSetCellStyles">Set Cell Styles</button>
        <button id="btnClearCellStyles">Clear Cell Styles</button>
    </div>
    <div>
        <button id="btnSetEmptyStyles">Set Empty Styles</button>
        <input type="text" id="edtEmptyMessage" value="">
        <button id="btnSetEmptyMessage">Set Empty Message</button>
    </div>
    <div id="container2" style="height: 200px; width: 550px"></div>
</body>
</html>