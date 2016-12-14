<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Group Footer Chart</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-report.min.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain;
        var dsMain;
        var printOptions = {
            previewUrl : "previewer.html"
        };
        var report = {
            reportHeader : {
                items : [ {
                    text : "UNESCO UIS Database",
                    styles : {
                        paddingTop : 10,
                        paddingBottom : 20,
                        fontName : "Arial",
                        fontSize : 30,
                        fontUnderline : true
                    }
                } ]
            },
            pageHeader : {
                styles : {
                    margin : 4,
                    background : "#f8f8f8"
                },
                items : [ {
                    left : 0,
                    text : 'Dataludi Inc.',
                    styles : {
                        fontBold : true,
                        fontItalic : true
                    }
                }, {
                    right : 0,
                    data : '$report.date'
                } ]
            },
            pageFooter : {
                styles : {
                    margin : 4,
                    background : "#f8f8f8"
                },
                items : [ {
                    type : "hbox",
                    right : 0,
                    items : [ {
                        data : '$report.pageno'
                    }, {
                        text : "/"
                    }, {
                        data : '$report.pagetotal'
                    } ]
                } ]
            },
            grid : {
                display : {
                    fitStyle : "even",
                    checkDataInited : true
                },
                styles : {
                    header : {
                        background : "#f0f0f0",
                        borderTop : "#ddd"
                    }
                }
            }
        };

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
            width : 150
        }, {
            fieldName : "subgroup",
            width : 60,
            header : "Gender",
            styles : {
                textAlignment : "center"
            }
        }, {
            fieldName : "year",
            width : 50,
            styles : {
                textAlignment : "center"
            }
        }, {
            fieldName : "source",
            width : 205
        }, {
            fieldName : "unit",
            width : 60,
            styles : {
                textAlignment : "center"
            }
        }, {
            fieldName : "value",
            width : 100,
            styles : {
                textAlignment : "far",
                numberFormat : "#,##0"
            },
            footer : {
                expression : "sum",
                styles : {
                    numberFormat : "#,##0",
                    fontBold : true,
                    suffix : "$"
                }
            },
            groupFooter : {
                expression : "sum",
                styles : {
                    numberFormat : "#,##0",
                    fontBold : true,
                    suffix : "$"
                }
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
            },
            rowGroup : {
                footerItems : [ {
                    type : "chart",
                    displayCallback : function(group) {
                        return group.level() == grdMain.rowGroupLevels();
                    },
                    minHeight : 150,
                    styles : {
                        /*background: "#0800ffff",*/
                        padding : 4
                    },
                    chart : {
                        type : "column",
                        legend : {
                            visible : true,
                            position : "right",
                            direction : "vertical",
                            marginLeft : 10,
                            styles : {
                            /*border: "#800"*/
                            }
                        },
                        plotArea : {
                            styles : {
                                background : "#0800ffff"
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
                                    line : "#80ff0000,1px,dashed",
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
                            clusterWidth : 2,
                            caption : "Female",
                            dataDirection : "vertical",
                            filter : "values['subgroup'] == 'Female'",
                            labelField : "year",
                            valueField : "value",
                            summaryMode : "aggregate",
                            labelLocation : "none",
                            styles : {
                                background : "#AFD8F8"
                            },
                            label : {
                                position : "none"
                            }
                        }, {
                            name : "serMale",
                            caption : "Male",
                            dataDirection : "vertical",
                            filter : "values['subgroup'] == 'Male'",
                            labelField : "year",
                            valueField : "value",
                            summaryMode : "aggregate",
                            styles : {
                                background : "#F6BD0F"
                            },
                            label : {
                                position : "none"
                            }
                        } ]
                    }
                } ]
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

        grdMain.header().head().setPopupMenu([ {
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        }, {
            label : 'DataLudi Report Version',
            callback : function() {
                alert(DLReport.getVersion());
            }
        } ]);

        // connect dataset
        function loadData(ds) {
            $.ajax({
                url : "data/enrollment_tertiary_edu.csv",
                dataType : 'text',
                success : function(data) {
                    new DataLudi.DataLoader(ds).load("csv", data, {
                        delimiter : ';',
                        start : 1,
                        count : 110
                    });
                },
                error : function(xhr, status, error) {
                    alert("jQuery getJSON() Failed: " + err);
                }
            });
        }
        ;

        grdMain.setDataSource(dsMain);
        loadData(dsMain);
        grdMain.groupBy([ 'area' ]);

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // button
        $('#btnPrint').click(function() {
            DLReport.preview(grdMain, report, null, printOptions, $('#chkPrint').is(':checked'));
        });
    });
</script>
</head>
<body>
    <div>
        <button id="btnPrint">Print</button>
        <input type="checkbox" id="chkPrint" checked="checked">바로 출력 (Check하면 현재 크롬에서 출력 미리보기 창이 바로 열립니다.)
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px;"></div>
</body>
</html>