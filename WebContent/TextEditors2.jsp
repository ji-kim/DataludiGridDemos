<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Text Cell Editors</title>
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
            "name": "Country",
            "fieldName": "country",
            "width": "70",
            "defaultValue": "Japan",
            "styles": {
            },
            "header": {
                "text": "Country"
            },
            "editor": {
                "maxLength": 20
            }
        }, {
            "name": "CommCode",
            "fieldName": "comm_code",
            "width": "90",
            "editor": {
                "noHangul": true,
                "keyCallback": function (key, code, pos, text) {
                    if (key < '0' || key > '9') return false;
                }
            },
            "styles": {
                "background": "#1000ff88",
                "textAlignment": "center"
            },
            "header": {
                "text": "CommCode"
            }
        }, {
            "name": "Commodity",
            "fieldName": "commodity",
            "width": "200",
            "styles": {
            },
            "header": {
                "text": "Commodity"
            }
        }, {
            "name": "Year",
            "fieldName": "year",
            "width": "60",
            "styles": {
                "textAlignment": "center"
            },
            "header": {
                "text": "Year"
            }
        }, {
            "name": "Flow",
            "fieldName": "flow",
            "width": 60,
            "styles": {
                "textAlignment": "center"
            },
            "header": {
                "text": "Flow"
            }
        }, {
            "name": "Trade",
            "fieldName": "trade",
            "width": 60,
            "styles": {
                "textAlignment": "far",
                "numberFormat": "#,##0"
            },
            "header": {
                "text": "Trade"
            },
            "footer": {
                "expression": "sum",
                "styles": {
                    "textAlignment": "far",
                    "numberFormat": "#,##0"
                }
            }
        }, {
            "name": "Weight",
            "fieldName": "weight",
            "width": 70,
            "styles": {
                "textAlignment": "far",
                "numberFormat": "#,##0"
            },
            "header": {
                "text": "Weight"
            },
            "footer": {
                "expression": "sum",
                "styles": {
                    "textAlignment": "far",
                    "numberFormat": "#,##0"
                }
            }
        }, {
            "name": "Unit",
            "fieldName": "unit",
            "width": 120,
            "styles": {
            },
            "header": {
                "text": "Unit"
            }
        } ]);

        //grid options
        grdMain.editOptions().setInsertable(true).setAppendable(true);
        grdMain.header().setHeight(0);
        grdMain.header().head().setPopupMenu({
            label: 'DataLudi Grid Version',
            callback: function () { alert(DataLudi.getVersion()); }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
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
        };

        // grid events        
    });
</script>
</head>
<body>
    <h3>Text Cell Editors2</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>