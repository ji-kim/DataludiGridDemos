<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Dynamic Renderer</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script> --><script type="text/javascript" src="js/theme/flatbluestyle.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain;
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
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
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
            "dynamicStyles" : {
                "expression" : "values['country'] == 'Chile' || values['country'] == 'Brazil'",
                "styles" : {
                    "background" : "#1000eeff"
                }
            },
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "InterestRate",
            "fieldName" : "interest_rate",
            "width" : "100",
            "styles" : {
                "textAlignment" : "far"
            },
            "dynamicStyles" : [ {
                "expression" : "values['country'] == 'Chile' || values['country'] == 'Brazil'",
                "styles" : {
                    "renderer" : "signal01",
                    "shapeColor" : "#ff008800",
                    "shapeState" : "value"
                }
            }, {
                "expression" : "values['country'] != 'Chile' && values['country'] != 'Brazil' && value <= 4",
                "styles" : {
                    "renderer" : "shape01",
                    "shapeColor" : "#800000ff",
                    "shapeName" : "itriangle",
                    "shapeSize" : "60%"
                }
            } ],
            "header" : {
                "text" : "InterestRate"
            }
        }, {
            "name" : "InterestRate2",
            "fieldName" : "interest_rate",
            "width" : "65",
            "styles" : {
                "textAlignment" : "far"
            },
            "dynamicStyles" : {
                "expression" : "values['country'] != 'Chile' && values['country'] != 'Brazil' && value <= 4",
                "styles" : {
                    "background" : "#1000eeff"
                }
            },
            "header" : {
                "text" : "InterestRate" + "_2"
            }
        }, {
            "name" : "OriginalAmount",
            "fieldName" : "original_amount",
            "width" : 120,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0.00"
            },
            "header" : {
                "text" : "OriginalAmount"
            },
            "dynamicStyles" : [ {
                "expression" : "value < 50000000",
                "styles" : {
                    "renderer" : "bar01",
                    "shapeColor" : "linear,#ff000044,#ffeeeeee"
                }
            }, {
                "expression" : "value < 13000000",
                "styles" : {
                    "renderer" : "shape01",
                    "shapeColor" : "#80ff0000",
                    "shapeName" : "triangle",
                    "shapeSize" : "60%"
                }
            } ]
        }, {
            "name" : "OriginalAmount2",
            "fieldName" : "original_amount",
            "width" : 105,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0.00"
            },
            "dynamicStyles" : {
                "expression" : "value < 50000000",
                "styles" : {
                    "background" : "#1000eeff"
                }
            },
            "header" : {
                "text" : "OriginalAmount" + "_2"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "prefix" : "$",
                    "numberFormat" : "#,##0",
                    "background" : "#777",
                    "color" : "#fff",
                    "borderTop" : "#ddd"
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
                "text" : "ProjectID"
            }
        }, {
            "name" : "CancelledAmount",
            "fieldName" : "cancelled_amount",
            "width" : 100,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "CancelledAmount"
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
        } ]);

        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.header().setHeight(30);

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
                alert("jQuery getJSON() Failed: " + err);
            }
        });

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        grdMain.registerCellRenderers([ {
            "id" : "bar01",
            "type" : "bar",
            "minimum" : 0,
            "maximum" : 50000000
        }, {
            "id" : "shape01",
            "type" : "shape"
        }, {
            "id" : "signal01",
            "type" : "signal",
            "barCount" : 10,
            "minimum" : 0,
            "maximum" : 10
        } ]);
    });
</script>
</head>
<body>
    <h3>Dynamic Renderer</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>