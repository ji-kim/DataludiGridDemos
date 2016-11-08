<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Row Grouping Levels</title>
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
            "width" : "70",
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "CommCode",
            "fieldName" : "comm_code",
            "width" : "110",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "CommCode"
            }
        }, {
            "name" : "Commodity",
            "fieldName" : "commodity",
            "width" : "90",
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
            "width" : 80,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0"
            },
            "header" : {
                "text" : "Trade",
                "subText" : "(USD)",
                "subStyles" : {
                    "color" : "#f00",
                    "fontSize" : 10,
                    "fontBold" : false
                }
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
            "width" : 90,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0"
            },
            "header" : {
                "text" : "Weight"
            },
            "groupFooter" : {
                "expression" : "sum",
                "styles" : {
                    "textAlignment" : "far",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "Unit",
            "fieldName" : "unit",
            "width" : 110,
            "styles" : {},
            "header" : {
                "text" : "Unit"
            }
        } ]);

        //grid options
        grdMain.setOptions({
            vscrollBar : {
                barWidth : 14
            },
            checkBar : false,
            footer : false,
            groupPanel : true,
            header : {
                height : 30,
                head : {
                    popupMenu : {
                        label : 'DataLudi Grid Version',
                        callback : function() {
                            alert(DataLudi.getVersion());
                        }
                    }
                }
            },
            rowGroup : {
                displayMode : "banded",
                levels : [ {
                    headerStyles : {
                        borderTop : null,
                        borderBottom : '#55',
                        background : "#777",
                        color : "#fff"
                    },
                    footerStyles : {
                        background : "#500088ff"
                    },
                    expanderStyles : {
                        borderTop : null,
                        borderBottom : '#55',
                        background : "#777",
                        shapeColor : "#fff"
                    }
                }, {
                    headerStyles : {
                        borderTop : null,
                        borderBottom : '#777',
                        background : "#999",
                        color : "#fff"
                    },
                    footerStyles : {
                        background : "#300088ff"
                    },
                    expanderStyles : {
                        borderTop : null,
                        borderBottom : '#777',
                        background : "#999",
                        shapeColor : "#fff"
                    }
                }, {
                    expanderVisible : false,
                    headerHeight : 15,
                    headerStatement : '${groupValue} - ${rowCount} items',
                    headerStyles : {
                        borderTop : null,
                        borderBottom : '#999',
                        background : "#6000ccff",
                        color : "#008"
                    },
                    footerStyles : {
                        background : "#100088ff"
                    },
                    expanderStyles : {
                        borderTop : null,
                        borderBottom : '#999',
                        background : "#6000ccff",
                        shapeColor : "#008"
                    }
                } ]
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url : "data/un_comtrade_of_goods_s.csv",
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

        //grid groupby
        grdMain.groupBy([ 'country', 'comm_code', 'commodity' ]);
    });
</script>
</head>
<body>
    <h3>Row Grouping Levels</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>