<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Signal Cell Renderers</title>
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
        var footer = {
            expression : "sum",
            styles : {
                numberFormat : ".0"
            }
        };
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            fieldName : "country",
            width : 60,
            styles : {
                textAlignment : "near"
            },
            header : {
                text : "Country"
            }
        }, {
            "name" : "2000",
            "fieldName" : "2000",
            "width" : 120,
            "renderer" : {
                "type" : "signal",
                "maximum" : 10,
                "detailed" : true
            },
            "styles" : {
                "textAlignment" : "far",
                "shapeColor" : "#b0008800"
            }
        }, {
            fieldName : "2000",
            width : 45,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2000"
            },
            footer : footer
        }, {
            "name" : "2001",
            "fieldName" : "2001",
            "width" : 100,
            "renderer" : {
                "type" : "signal",
                "maximum" : 10
            },
            "styles" : {
                "textAlignment" : "far",
                "shapeColor" : "#b0000088"
            }
        }, {
            fieldName : "2001",
            width : 45,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2001"
            },
            footer : footer
        }, {
            "name" : "2002",
            "fieldName" : "2002",
            "width" : 80,
            "renderer" : {
                "type" : "signal",
                "maximum" : 10,
                "barCount" : 5,
                "startRate" : 1,
                "barRate" : 0.6,
                "barGap" : 5
            },
            "styles" : {
                "textAlignment" : "far",
                "shapeColor" : "#b00088ff",
                "shapeInactiveColor" : "#300088ff",
                "paddingLeft" : 8,
                "paddingRight" : 8
            }
        }, {
            fieldName : "2002",
            width : 45,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2002"
            },
            footer : footer
        }, {
            "name" : "2003",
            "fieldName" : "2003",
            "width" : 100,
            "renderer" : {
                "type" : "signal",
                "barCount" : 7,
                "maximum" : 10,
                "startRate" : 1,
                "endRate" : 0.4,
                "barGap" : 3
            },
            "styles" : {
                "textAlignment" : "far",
                "shapeColor" : "#b0cc8800",
                "shapeInactiveColor" : "#20cc8800",
            }
        }, {
            fieldName : "2003",
            width : 45,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2003"
            },
            footer : footer
        }, {
            fieldName : "2004",
            width : 45,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "2004"
            },
            footer : footer
        } ]);

        //grid options
        grdMain.setOptions({
            checkBar : {
                visible : false
            },
            hscrollBar : {
                barWidth : 12
            },
            vscrollBar : {
                barWidth : 12
            },
            display : {
                rowHoverMask : {
                    visible : true,
                    styles : {
                        //background: "#20aaaaaa"
                        background : "#1000ff00"
                    }
                }
            }
        });
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
    <h3>Shape Cell Renderers</h3>
    <div id="container"
        style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>