<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>List Cell Editors2</title>
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

        var grdMain, grdMain2;
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
        grdMain2 = DataLudi.createGridView("container2");
        grdMain.setColumns([ {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "100",
            "defaultValue" : "Japan",
            "styles" : {},
            "header" : {
                "text" : "Partial True"
            },
            "editor" : {
                "type" : "list",
                "values" : [ "Algeria", "Albania", "Chile", "Colombia", "Denmark", "Finland", "France", "India" ],
                "labels" : [ "알제리", "알바니아", "칠레", "콜롬비아", "덴마크", "핀란드", "프랑스", "인도" ],
                "partialMatch" : true
            }
        }, {
            "name" : "Country2",
            "fieldName" : "country",
            "width" : "100",
            "defaultValue" : "Japan",
            "styles" : {},
            "header" : {
                "text" : "Partial False"
            },
            "lookupValues" : [ "Algeria", "Albania", "Chile", "Colombia", "Denmark", "Finland", "France", "India" ],
            "lookupLabels" : [ "알제리", "알바니아", "칠레", "콜롬비아", "덴마크", "핀란드", "프랑스", "인도" ],
            "editor" : {
                "type" : "list",
                "partialMatch" : false
            }
        }, {
            "name" : "Flow",
            "fieldName" : "flow",
            "width" : 100,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Lookup Labels"
            },
            "lookupDisplay" : true,
            "lookupLabels" : [ "in", "out" ],
            "lookupValues" : [ "Import", "Export" ],
            "editor" : {
                "type" : "list",
                "domainOnly" : true
            }
        }, {
            "name" : "Flow2",
            "fieldName" : "flow",
            "width" : 60,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Flow"
            }
        }, {
            "name" : "CommCode",
            "fieldName" : "comm_code",
            "width" : "90",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "CommCode"
            }
        }, {
            "name" : "Commodity",
            "fieldName" : "commodity",
            "width" : "200",
            "styles" : {},
            "header" : {
                "text" : "Commodity"
            }
        }, {
            "name" : "Year",
            "fieldName" : "year",
            "width" : "60",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Year"
            }
        }, {
            "name" : "Trade",
            "fieldName" : "trade",
            "width" : 60,
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
            "width" : 120,
            "styles" : {},
            "header" : {
                "text" : "Unit"
            }
        } ]);

        grdMain2.setColumns([ {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "100",
            "defaultValue" : "Japan",
            "styles" : {},
            "header" : {
                "text" : "Narrow true"
            },
            "editor" : {
                "type" : "search",
                "keyLength" : 1,
                "searchDelay" : 500,
                "values" : [ "Algeria", "Albania", "Chile", "Colombia", "Denmark", "Finland", "France", "India" ],
                "labels" : [ "알제리", "알바니아", "칠레", "콜롬비아", "덴마크", "핀란드", "프랑스", "인도" ],
                "narrowSearch" : true
            }
        }, {
            "name" : "Country2",
            "fieldName" : "country",
            "width" : "100",
            "defaultValue" : "Japan",
            "styles" : {},
            "header" : {
                "text" : "Narrow False"
            },
            "editor" : {
                "type" : "search",
                "keyLength" : 1,
                "searchDelay" : 500,
                "values" : [ "Algeria", "Albania", "Chile", "Colombia", "Denmark", "Finland", "France", "India" ],
                "labels" : [ "알제리", "알바니아", "칠레", "콜롬비아", "덴마크", "핀란드", "프랑스", "인도" ],
                "narrowSearch" : false
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
            "name" : "CommCode",
            "fieldName" : "comm_code",
            "width" : "90",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "CommCode"
            }
        }, {
            "name" : "Commodity",
            "fieldName" : "commodity",
            "width" : "200",
            "styles" : {},
            "header" : {
                "text" : "Commodity"
            }
        }, {
            "name" : "Year",
            "fieldName" : "year",
            "width" : "60",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Year"
            }
        }, {
            "name" : "Trade",
            "fieldName" : "trade",
            "width" : 60,
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
            "width" : 120,
            "styles" : {},
            "header" : {
                "text" : "Unit"
            }
        } ]);

        //grid options
        grdMain.editOptions().setInsertable(true).setAppendable(true);
        grdMain.header().setHeight(0);
        grdMain.rowIndicator().setStateVisible(true);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        grdMain2.editOptions().setInsertable(true).setAppendable(true);
        grdMain2.header().setHeight(0);
        grdMain2.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        var countries = [ "Algeria", "Argentina", "Australia", "Austria", "Bahamas, The", "Bangladesh", "Barbados", "Belgium", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil",
                "Cameroon", "Caribbean", "Chile", "China", "Colombia", "Congo", "Costa Rica", "Cote d'Ivoire", "Croatia", "Cyprus", "Denmark", "Dominican Republic", "Eastern Africa",
                "Ecuador", "Egypt", "El Salvador", "Ethiopia", "Fiji", "Finland", "France", "Gabon", "Ghana", "Greece", "Guatemala", "Guyana", "Haiti", "Honduras", "Iceland", "India",
                "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kenya", "Korea", "Lebanon", "Liberia", "Luxembourg", "Macedonia", "Madagascar",
                "Malawi", "Malaysia", "Malta", "Mauritania", "Mauritius", "Mexico", "Morocco", "Myanmar", "Netherlands", "New Zealand", "Nicaragua", "Nigeria", "Norway", "Oman", "Pakistan",
                "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Portugal", "Romania", "Senegal", "Serbia", "Sierra Leone", "Singapore", "Slovenia", "South Africa",
                "Southern Africa", "Spain", "Sri Lanka", "Sudan", "Swaziland", "Syrian Arab Republic", "Taiwan, China", "Tanzania", "Thailand", "Togo", "Trinidad and Tobago", "Tunisia",
                "Turkey", "Uganda", "Uruguay", "Venezuelae", "Western Africa", "Zambia", "Zimbabwe" ];

        // connect dataset
        grdMain.setDataSource(dsMain);
        grdMain2.setDataSource(dsMain);
        $.ajax({
            url : "data/un_comtrade_of_goods_ss.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1,
                    count : 7,
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
            $("#rowCount2").css("color", "blue").text(count.toLocaleString());
        };
    });
</script>
</head>
<body>
    <h3>List Cell Editors2</h3>
    <h4>1.Partial match</h4>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <p>
    <h4>2.Narrow search</h4>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
</body>
</html>