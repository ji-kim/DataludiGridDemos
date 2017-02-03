<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Row Summary</title>
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
            fieldName : "continent",
            dataType : "text"
        }, {
            fieldName : "country",
            dataType : "text"
        }, {
            fieldName : "y2000",
            dataType : "number"
        }, {
            fieldName : "y2001",
            dataType : "number"
        }, {
            fieldName : "y2002",
            dataType : "number"
        }, {
            fieldName : "y2003",
            dataType : "number"
        }, {
            fieldName : "y2004",
            dataType : "number"
        }, {
            fieldName : "y2005",
            dataType : "number"
        }, {
            fieldName : "y2006",
            dataType : "number"
        }, {
            fieldName : "y2007",
            dataType : "number"
        }, {
            fieldName : "y2008",
            dataType : "number"
        }, {
            fieldName : "y2009",
            dataType : "number"
        }, {
            fieldName : "y2010",
            dataType : "number"
        } ], [ {
            fieldName : "fld_sum",
            dataType : "number",
            callback : function(ds, fld, row, values) {
                var sum = 0;
                for (var i = 2; i <= 12; i++) {
                    var v = values[i];
                    sum += isNaN(v) ? 0 : v;
                }
                return sum;
            }
        } ]);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            fieldName : "continent",
            width : 45,
            styles : {
                textAlignment : "near"
            },
            header : {
                text : "continent"
            }
        }, {
            fieldName : "country",
            width : 55,
            styles : {
                textAlignment : "near"
            },
            header : {
                text : "Country"
            }
        }, {
            fieldName : "y2000",
            width : 38,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2000"
            }
        }, {
            fieldName : "y2001",
            width : 38,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2001"
            }
        }, {
            fieldName : "y2002",
            width : 38,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2002"
            }
        }, {
            fieldName : "y2003",
            width : 38,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2003"
            }
        }, {
            fieldName : "y2004",
            width : 38,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2004"
            }
        }, {
            fieldName : "y2005",
            width : 38,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2005"
            }
        }, {
            fieldName : "y2006",
            width : 38,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2006"
            }
        }, {
            fieldName : "y2007",
            width : 38,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2007"
            }
        }, {
            fieldName : "y2008",
            width : 38,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2008"
            }
        }, {
            fieldName : "y2009",
            width : 38,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2009"
            }
        }, {
            fieldName : "y2010",
            width : 38,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2010"
            }
        }, {
            fieldName : "fld_sum",
            width : 75,
            styles : {
                background : "#100088ff",
                fontName : "Arial",
                fontBold : true,
                textAlignment : "far",
                numberFormat : "#,###.0"
            },
            header : {
                text : "Sum(Field)"
            },
            footer : {
                expression : "sum",
                styles : {
                    numberFormat : "#,##0",
                    fontBold : true
                }
            }
        }, {
            type : "calced",
            cached : true,
            valueCallback : function(column, row) {
                var sum = 0;
                for (var i = 2; i <= 12; i++) {
                    var v = row.getValue(i);
                    sum += isNaN(v) ? 0 : v;
                }
                return sum;
            },
            /*
            // or
            //valueExpression: "y2000 + y2001 + y2002 + y2003 + y2004 + y2005 + y2006 + y2007 + y2008 + y2009 + y2010",
             */
            width : 90,
            styles : {
                background : "#1000ff88",
                fontName : "Arial",
                fontBold : true,
                textAlignment : "far",
                numberFormat : "#,###.0"
            },
            header : {
                text : "Sum(Column)"
            },
            footer : {
                expression : "sum",
                styles : {
                    numberFormat : "#,##0",
                    fontBold : true
                }
            }
        } ]);

        //grid options
        grdMain.displayOptions().setFixedColumnCount(2);
        grdMain.checkBar().setVisible(false);
        grdMain.rowIndicator().setStateVisible(true);

        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url : "data/eco_growth_rate.csv",
            dataType : 'text',
            success : function(data) {
                grdMain.hideToast();
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 3
                });
                var count = dsMain.rowCount();
                $("rowCount").css("color", "green").text(parseInt(count).toLocaleString() + " rows loaded.").show();
            },
            error : function(xhr, status, error) {
                grdMain.hideToast();
                var err = xhr + ', ' + status + ', ' + error;
                console.log("jQuery getJSON() Failed: " + err);
                alert("jQuery getJSON() Failed: " + err);
            },
            complete : function(data) {
            }
        });

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };
    });
</script>
</head>
<body>
    <h3>Row Summary</h3>
    <div id="container"
        style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>