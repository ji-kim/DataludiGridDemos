<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Series Columns</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain;
        var dsMain;
        var loadData = function() {
            grdMain.showToast("Load data...", true);
            $.ajax({
                url : "data/eco_growth_rate.csv",
                dataType : 'text',
                success : function(data) {
                    grdMain.hideToast();
                    new DataLudi.DataLoader(dsMain).load("csv", data, {
                        start : 3
                    });
                    var count = dsMain.rowCount();
                    $("#txtRowCount").css("color", "green").text(parseInt(count).toLocaleString() + " rows loaded.").show();
                },
                error : function(xhr, status, error) {
                    grdMain.hideToast();
                    var err = xhr + ', ' + status + ', ' + error;
                    console.log("jQuery getJSON() Failed: " + err);
                    $("#txtRowCount").css("color", "red").text("jQuery getJSON() Failed: " + err).show();
                    alert("jQuery getJSON() Failed: " + err);
                },
                complete : function(data) {
                }
            });
        };

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName : "continent",
            dataType : "text"
        }, {
            fieldName : "country",
            dataType : "text"
        }, {
            fieldName : "2000",
            dataType : "number"
        }, {
            fieldName : "2001",
            dataType : "number"
        }, {
            fieldName : "2002",
            dataType : "number"
        }, {
            fieldName : "2003",
            dataType : "number"
        }, {
            fieldName : "2004",
            dataType : "number"
        }, {
            fieldName : "2005",
            dataType : "number"
        }, {
            fieldName : "2006",
            dataType : "number"
        }, {
            fieldName : "2007",
            dataType : "number"
        }, {
            fieldName : "2008",
            dataType : "number"
        }, {
            fieldName : "2009",
            dataType : "number"
        }, {
            fieldName : "2010",
            dataType : "number"
        } ]);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            fieldName : "continent",
            width : 70,
            styles : {
                textAlignment : "near"
            },
            header : {
                text : "continent"
            }
        }, {
            fieldName : "country",
            width : 80,
            styles : {
                textAlignment : "near"
            },
            header : {
                text : "Country"
            }
        }, {
            name : "colSeries",
            type : "series",
            fieldNames : "2000..2010",
            width : 100,
            renderer : {
                type : "sparkColumn",
                highColor : "#ff008800",
                lowColor : "#ffff0000",
                lastColor : "#ff888888"
            },
            header : {
                text : "Spark Column"
            },
            styles : {
                background : "#080000ff",
                shapeColor : "#ff000088",
                paddingLeft : 4,
                paddingRight : 4,
                paddingTop : 4,
                paddingBottom : 4
            }
        }, {
            fieldName : "2000",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2000"
            }
        }, {
            fieldName : "2001",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2001"
            }
        }, {
            fieldName : "2002",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2002"
            }
        }, {
            fieldName : "2003",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2003"
            }
        }, {
            fieldName : "2004",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2004"
            }
        }, {
            fieldName : "2005",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2005"
            }
        }, {
            fieldName : "2006",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2006"
            }
        }, {
            fieldName : "2007",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2007"
            }
        }, {
            fieldName : "2008",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2008"
            }
        }, {
            fieldName : "2009",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2009"
            }
        }, {
            fieldName : "2010",
            width : 50,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2010"
            }
        } ]);

        //grid options
        grdMain.displayOptions().setFixedColumnCount(3);
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
        loadData();

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };
    });
</script>
</head>
<body>
    <h3>Series Columns</h3>
    <div id="container"
        style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>