<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Load Styles</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script> -->
<script type="text/javascript" src="js/theme/flatbluestyle.js"></script>
<script type="text/javascript" src="js/theme/graystyle.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain, grdMain2, grdMain3, grdMain4, grdMain5;
        var dsMain;

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName : "loan_number"
        }, {
            fieldName : "country"
        }, {
            fieldName : "interest_rate",
            dataType : "number"
        }, {
            fieldName : "currency"
        }, {
            fieldName : "project_id"
        }, {
            fieldName : "original_amount",
            dataType : "number"
        }, {
            fieldName : "cancelled_amount",
            dataType : "number"
        }, {
            fieldName : "disbursed_amount",
            dataType : "number"
        }, {
            fieldName : "repaid_amount",
            dataType : "number"
        }, {
            fieldName : "sold_amount",
            dataType : "number"
        }, {
            fieldName : "first_date",
            dataType : "datetime",
            datetimeFormat : "MM/dd/yyyy"
        }, {
            fieldName : "last_date",
            dataType : "datetime",
            datetimeFormat : "MM/dd/yyyy"
        } ]);

        // grid
        var columns = [ {
            "name" : "LoanNumber",
            "fieldName" : "loan_number",
            "width" : "70",
            "styles" : {
                textAlignment : "center"
            },
            "header" : {
                "text" : "LoanNumber"
            }
        }, {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "70",
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "InterestRate",
            "fieldName" : "interest_rate",
            "width" : "65",
            "renderer" : {
                "type" : "shape"
            },
            "styles" : {
                "textAlignment" : "far"
            },
            "dynamicStyles" : {
                "expression" : "value >= 4.5",
                "styles" : {
                    "shapeName" : "downarrow",
                    "shapeSize" : "70%",
                    "shapeLocation" : "right",
                    "shapeColor" : "#f00",
                    "background" : "#100088ff"
                }
            },
            "header" : {
                "text" : "InterestRate",
                "summary" : {
                    "expression" : "avg",
                    "styles" : {
                        "prefix" : "Avg: ",
                        "numberFormat" : "#,##0.00"
                    }
                }
            },
            "footer" : {
                "spanPrev" : 2,
                "expression" : "avg",
                "styles" : {
                    "background" : "#60cccc99",
                    "prefix" : "Average" + ": ",
                    "numberFormat" : "#,##0.00"
                }
            }
        }, {
            "name" : "Currency",
            "fieldName" : "currency",
            "width" : "90",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Currency"
            }
        }, {
            "name" : "ProjectID",
            "fieldName" : "project_id",
            "width" : "70",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "ProjectID",
                "summary" : {
                    "text" : "SUM "
                }
            },
            "footer" : {
                "spanPrev" : 1,
                "text" : "Sum",
                "styles" : {
                    "textAlignment" : "far"
                }
            }
        }, {
            "name" : "OriginalAmount",
            "fieldName" : "original_amount",
            "width" : 110,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "OriginalAmount",
                "summary" : {
                    "expression" : "sum",
                    "styles" : {
                        "prefix" : "$",
                        "numberFormat" : "#,##0",
                        "color" : "#400",
                        "fontName" : "Arial",
                        "fontBold" : true
                    }
                }
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "prefix" : "$",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "CancelledAmount",
            "fieldName" : "cancelled_amount",
            "width" : 105,
            "styles" : {
                "textAlignment" : "far"
            },
            "dynamicStyles" : {
                "expression" : "value > 1000000",
                "styles" : {
                    "background" : "#333",
                    "color" : "#fff"
                }
            },
            "header" : {
                "text" : "CancelledAmount",
                "summary" : {
                    "expression" : "sum",
                    "styles" : {
                        "prefix" : "$",
                        "numberFormat" : "#,##0",
                        "color" : "#400",
                        "fontName" : "Arial",
                        "fontBold" : true
                    }
                }
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "prefix" : "$",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "DisbursedAmount",
            "fieldName" : "disbursed_amount",
            "width" : 110,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "DisbursedAmount"
            },
            "footer" : {
                "expression" : "varp",
                "text" : "분산",
                "styles" : {
                    "prefix" : "분산=>$",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "RepaidAmount",
            "fieldName" : "repaid_amount",
            "width" : 110,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "RepaidAmount"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "prefix" : "$",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "SoldAmount",
            "fieldName" : "sold_amount",
            "width" : 110,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "SoldAmount"
            },
            "footer" : {
                "styles" : {
                    "prefix" : "$",
                    "textAlignment" : "far",
                    "numberFormat" : "0,000",
                    "postfix" : " $",
                    "font" : "Arial,12"
                },
                "text" : "SUM",
                "expression" : "sum",
                /*"expression": "sum[4]",*/
                "dynamicStyles" : [ {
                    "criteria" : "value > 10000",
                    "styles" : "color=#ff0000"
                } ]
            }
        }, {
            "name" : "SoldAmount2",
            "fieldName" : "sold_amount",
            "width" : 80,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "SoldAmount" + '2'
            },
            "footer" : {
                "expression" : "'TOTAL'"
            }
        }, {
            "name" : "FirstDate",
            "fieldName" : "first_date",
            "width" : "90",
            "styles" : {
                datetimeFormat : "yyyy-MM-dd",
                textAlignment : "center"
            },
            "header" : {
                "text" : "FirstDate"
            }
        }, {
            "name" : "LastDate",
            "fieldName" : "last_date",
            "width" : "90",
            "styles" : {
                datetimeFormat : "yyyy-MM-dd",
                textAlignment : "center"
            },
            "header" : {
                "text" : "LastDate"
            }
        } ];
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns(columns);

        //grid options
        grdMain.rowIndicator().setStateVisible(true);
        grdMain.header().setSummary({
            visible : true
        });
        grdMain.autoFill().setEnabled(true);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url : "data/loan_statement_small.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1,
                    quoted : true,
                    currency : true
                });
            },
            error : function(xhr, status, error) {
                var err = status + ', ' + error;
                alert("jQuery ajax() Failed: " + err);
            }
        });

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // buttons
        $('#btnClear').click(function() {
            grdMain.clearStyles(true);
        });
        $('#btnFlatblue').click(function() {
            grdMain.clearStyles(true);
            grdMain.loadStyles(flatbluestyles);
        });
        $('#btnGray').click(function() {
            grdMain.clearStyles(true);
            grdMain.loadStyles(graystyles);
        });
        $('#btnLoadTheme').click(function() {
            $.ajax({
                url : "data/flatbluestyle2.json",
                dataType : 'json',
                success : function(data) {
                    grdMain.loadStyles(data);
                },
                error : function(xhr, status, error) {
                    var err = status + ', ' + error;
                    alert(err);
                }
            });
        });
        $('#btnSetDefaultFont').click(function() {
            grdMain.clearStyles(true);
            grdMain.loadStyles({
                "default" : {
                    fontName : "Courier New"
                }
            })
        });
    });
</script>
</head>
<body>
    <h3>Load Styles</h3>
    <div>
        <button id="btnClear">Clear Styles</button>
        <button id="btnFlatblue">Flatblue 테마</button>
        <button id="btnGray">Gray 테마</button>
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <button id="btnLoadTheme">Load Theme</button>
    </div>
    <div>
        <button id="btnSetDefaultFont">Set Default Font</button>
    </div>
</body>
</html>