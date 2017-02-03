<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Merged Selection</title>
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
            fieldName: "country"
        }, {
            fieldName: "year",
            dataType: "number"
        }, {
            fieldName: "comm_code"
        }, {
            fieldName: "commodity"
        }, {
            fieldName: "flow"
        }, {
            fieldName: "trade",
            dataType: "number"
        }, {
            fieldName: "weight",
            dataType: "number"
        }, {
            fieldName: "unit"
        } ]);
        dsMain.setSoftDelete(true);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name": "Country",
            "fieldName": "country",
            "width": "160",
            "mergeExpression": "value",
            "styles": {
                "background": "#1000ff00"
            },
            "header": {
                "text": "Country"
            }
        }, {
            "name": "CommCode",
            "fieldName": "comm_code",
            "width": "90",
            "mergeCallback": function (item, column) {
                return column.grid().getValueAt(item, column) + grdMain.getValueAt(item, 'flow');  
            },
            "styles": {
                "background": "#10ffff00",
                "textAlignment": "center",
                "lineAlignment": "near"
            },
            "header": {
                "text": "CommCode"
            }
        }, {
            "name": "CommCode2",
            "fieldName": "comm_code",
            "width": "90",
            "styles": {
                "textAlignment": "center"
            },
            "header": {
                "sortHandleVisibility": "hidden",
                "text": "CommCode" + "_2"
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
            "width": "65",
            "styles": {
                "textAlignment": "center"
            },
            "header": {
                "text": "Year"
            }
        }, {
            "name": "Trade",
            "fieldName": "trade",
            "width": 100,
            "styles": {
                "textAlignment": "far",
                "numberFormat": "#,##0"
            },
            "header": {
                "text": "Trade"
            },
            "groupFooter": {
                "expression": "sum",
                "styles": {
                    "textAlignment": "far",
                    "numberFormat": "#,##0"
                }
            }
        }, {
            "name": "Weight",
            "fieldName": "weight",
            "width": 110,
            "styles": {
                "textAlignment": "far",
                "numberFormat": "#,##0"
            },
            "header": {
                "text": "Weight"
            },
            "groupFooter": {
                "expression": "sum",
                "styles": {
                    "textAlignment": "far",
                    "numberFormat": "#,##0"
                }
            }
        }, {
            "name": "Unit",
            "fieldName": "unit",
            "width": 110,
            "styles": {
            },
            "header": {
                "text": "Unit"
            }
        } ]);
        
        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.header().setHeight(30);
        grdMain.footer().setVisible(false);
        grdMain.header().head().setPopupMenu({
            label: 'DataLudi Grid Version',
            callback: function () { alert(DataLudi.getVersion()); }
        });
        grdMain.displayOptions().setCheckDataInited(true);

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url: "data/un_comtrade_of_goods_s.csv",
            dataType: 'text',
            success: function (data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start: 1,
                    quoted: true,
                    currency: true
                });
            },
            error: function (xhr, status, error) {
                var err = status + ', ' + error;
                alert("jQuery getJSON() Failed: " + err);
            }
        });

        grdMain.orderByFields(['comm_code']);

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // grid events
        
        // buttons
        $('#chkMergedSelection').click(function () {
            var checked = document.getElementById('chkMergedSelection').checked;
            grdMain.setDisplayOptions({
                mergedSelection: checked
            });
        });
        $('#btnSetSelection').click(function () {
            var row = grdMain.focusedRow();
            if (row) {
                var col = grdMain.columnByName('CommCode');
                var col2 = grdMain.columnByName('CommCode2');
                grdMain.setSelection(DataLudi.createIndex(row.index(), col), DataLudi.createIndex(row.index() + 1, col2));
            }            
        });
        $('input:radio[name=rgpSelectDisplay]').click(function () {
            var val = $("input[name=rgpSelectDisplay]:checked").val();
            grdMain.displayOptions().setSelectDisplay(val);
        });
    });
</script>
</head>
<body>
    <h3>Merged Selection</h3>
    <div>
        <input type="checkbox" id="chkMergedSelection">Merged Selection
    </div>
    <button id="btnSetSelection">Set Selection</button>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="radio" name="rgpSelectDisplay" value="mask" checked="checked">SelectionDisplay.MASK
        <input type="radio" name="rgpSelectDisplay" value="cell">CELL
    </div>
</body>
</html>