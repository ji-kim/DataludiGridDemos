<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>RowGroup Chart</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script type="text/javascript" src="js/theme/flatbluestyle.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain;
        var dsMain;

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName : "area",
            header : "Area"
        }, {
            fieldName : "subgroup",
            header : "Subgroup"
        }, {
            fieldName : "year",
            dataType : "number",
            header : "Year"
        }, {
            fieldName : "source",
            header : "Source"
        }, {
            fieldName : "unit",
            header : "Unit"
        }, {
            fieldName : "value",
            dataType : "number",
            header : "Value"
        } ]);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            fieldName : "area",
            width : 40
        }, {
            fieldName : "subgroup",
            width : 50,
            header : "Gender",
            styles : {
                textAlignment : "center"
            }
        }, {
            fieldName : "year",
            width : 40,
            styles : {
                textAlignment : "center"
            }
        }, {
            fieldName : "source",
            width : 55
        }, {
            fieldName : "unit",
            width : 35,
            styles : {
                textAlignment : "center"
            }
        }, {
            fieldName : "value",
            width : 50,
            styles : {
                textAlignment : "far",
                numberFormat : "#,##0"
            }
        }, {
            type : "chart",
            fieldNames : "subgroup,year,value",
            width : 370,
            header : "Chart",
            mergeExpression : "values['area']",
            chart : {
                type : "column",
                legend : {
                    visible : true,
                    styles : {
                    /*border: "#800"*/
                    }
                },
                xAxes : {
                    padding : 0.1,
                    styles : {
                        line : "#333"
                    },
                    tickStyles : {
                        line : "#333"
                    }
                },
                yAxes : {
                    indicators : [ {
                        type : "line",
                        front : true,
                        series : "serFemale",
                        value : "avg",
                        label : "Average:${value}",
                        styles : {
                            line : "#600000ff,1px,dotted",
                            color : "#e00000ff",
                            fontSize : 10,
                            fontBold : true,
                            textAlignment : "far",
                            numberFormat : "#,##0"
                        }
                    }, {
                        type : "line",
                        front : true,
                        series : "serMale",
                        value : "avg",
                        label : "Average:${value}",
                        styles : {
                            line : "#60ff0000,1px,dashed",
                            color : "#e0800000",
                            fontSize : 10,
                            fontBold : true,
                            textAlignment : "near",
                            numberFormat : "#,##0"
                        }
                    } ]
                },
                series : [ {
                    name : "serFemale",
                    caption : "Female",
                    filter : "values['subgroup'] == 'Female'",
                    labelField : "year",
                    valueField : "value",
                    summaryMode : "aggregate",
                    labelLocation : "none",
                    styles : {
                        background : "#AFD8F8"
                    }
                }, {
                    name : "serMale",
                    caption : "Male",
                    filter : "values['subgroup'] == 'Male'",
                    labelField : "year",
                    valueField : "value",
                    summaryMode : "aggregate",
                    styles : {
                        background : "#F6BD0F"
                    }
                } ]
            }
        } ]);

        //grid options
        grdMain.setOptions({
            footer : {
                visible : true
            },
            stateBar : {
                visible : true
            },
            checkBar : {
            /*width: 50*/
            },
            header : {},
            display : {},
            operate : {
                sortHandleVisibility : "hidden"
            },
            edit : {
                deletable : true
            },
            autoFill : {
                enabled : true
            }
        });
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        grdMain.loadStyles({
            selection : {
                background : "#11000000",
                border : "#88000000,1"
            }
        });

        grdMain.loadPalettes([ {
            name : "pal01",
            fills : [ "#ffe17F", "#97CBE7", "#074868", "#B0D67A", "#2C560A", "#DD9D82", "#578Ba7" ]
        }, {
            name : "pal02",
            fills : [ "#ffcccccc", "#ffaaaaaa", "#ff999999", "#ff777777", "#ff555555", "#ff333333", "#ff111111" ]
        }, {
            name : "pal03",
            fills : [ "#100000ff", "#200000ff", "#300000ff" ]
        } ]);

        // connect dataset
        function loadData(ds) {
            $.ajax({
                url : "data/enrollment_tertiary_edu.csv",
                dataType : 'text',
                success : function(data) {
                    new DataLudi.DataLoader(ds).load("csv", data, {
                        delimiter : ';',
                        start : 1
                    });
                },
                error : function(xhr, status, error) {
                    alert("jQuery getJSON() Failed: " + err);
                }
            });
        }
        grdMain.setDataSource(dsMain);
        loadData(dsMain);
        grdMain.groupBy([ 'area' ]);

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };
    });
</script>
</head>
<body>
    <h3>RowGroup Chart</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>