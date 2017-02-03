<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Cell Validation</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script> -->
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
        var columns = [ {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "70",
            "defaultValue" : "Japan",
            "styles" : {},
            "header" : {
                "text" : "Country"
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
            },
            "validations" : [ {
                "expression" : "value is not empty",
                "level" : DataLudi.ValidationLevel.WARNING,
                "message" : "CommCodeMsg"
            } ]
        }, {
            "name" : "Year",
            "fieldName" : "year",
            "width" : "60",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Year"
            },
            "validations" : [ {
                "expression" : "value >= 2000",
                "level" : DataLudi.ValidationLevel.INFO,
                "message" : "YearMsg",
                "mode" : DataLudi.ValidationMode.INSERT
            }, {
                "expression" : "value < 2020",
                "level" : DataLudi.ValidationLevel.INFO,
                "message" : "YearMsg2",
                "mode" : DataLudi.ValidationMode.UPDATE
            } ]
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
            },
            "validations" : {
                "callback" : function(scope) {
                    if (scope.value < 1000) {
                        return false;
                    }
                },
                "level" : DataLudi.ValidationLevel.ERROR,
                "message" : "TradeMsg"
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
        }, {
            "name" : "Commodity",
            "fieldName" : "commodity",
            "width" : "200",
            "styles" : {},
            "header" : {
                "text" : "Commodity"
            }
        } ];

        grdMain = DataLudi.createGridView("container");
        grdMain2 = DataLudi.createGridView("container2");
        grdMain.setColumns(columns);
        grdMain2.setColumns(columns);

        //grid options
        grdMain.editOptions().setInsertable(true).setAppendable(true);
        grdMain.header().setHeight(0);
        grdMain2.editOptions().setInsertable(true).setAppendable(true);
        grdMain2.header().setHeight(0);

        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });
        grdMain2.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        grdMain2.setDataSource(dsMain);
        $.ajax({
            url : "data/un_comtrade_of_goods_ss.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1,
                    count : 5,
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

        // grid events        
        grdMain2.onValidateCell = function(grid, index, inserting, value) {
            if (index.dataField() == dsMain.getFieldIndex('weight')) {
                if (value <= 100) {
                    DataLudi.throwValidationError(DataLudi.ValidationLevel.ERROR, strings['WeightMsg']);
                }
            }
        };

        // buttons
        $('input:radio[name=rgpCommitLevel]').click(function() {
            var value = $("input[name=rgpCommitLevel]:checked").val();
            grdMain.editOptions().setCommitLevel(value);
        });
    });
</script>
</head>
<body>
    <h3>Cell Validation</h3>
    <div>
        <span>Commit Level : </span>
        <input type="radio" name="rgpCommitLevel" value="ignore" checked="checked">DataLudi.ValidationLevel.IGNORE
        <input type="radio" name="rgpCommitLevel" value="info">INFO
        <input type="radio" name="rgpCommitLevel" value="warning">WARNING
        <input type="radio" name="rgpCommitLevel" value="error">ERROR
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
</body>
</html>