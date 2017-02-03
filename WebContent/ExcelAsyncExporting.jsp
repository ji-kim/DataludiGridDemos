<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Async Excel Exporting</title>
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
        function loadData(ds, count) {
            grdMain.showToast('Load Data...');
            $.ajax({
                url: "data/orders.csv",
                dataType: 'text',
                success: function (data) {
                    for (var i = 0; i < count; i++) {
                        new DataLudi.DataLoader(ds).load("csv", data, {
                            start:1,
                            fillMode: 'append'
                        });
                    }
                },
                error: function (xhr, status, error) {
                    var err = status + ', ' + error;
                    alert("jQuery getJSON() Failed: " + err);
                },
                complete: function () {
                    grdMain.hideToast();
                }
            });
        };

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName: "product_id",
            dataType: "text"
        }, {
            fieldName: "product_name"
        }, {
            fieldName: "customer_id"
        }, {
            fieldName: "customer_name",
        }, {
            fieldName: "country",
        }, {
            fieldName: "phone",
        }, {
            fieldName: "unit",
        }, {
            fieldName: "currency",
        }, {
            fieldName: "unit_price",
            dataType: "number"
        }, {
            fieldName: "quantity",
            dataType: "number"
        }, {
            fieldName: "order_date",
            dataType: "datetime",
            datetimeFormat: "yyyy-MM-dd"
        }, {
            fieldName: "ship_date",
            dataType: "datetime",
            datetimeFormat: "iso"
        } ]);
        dsMain.setSoftDelete(true);

        // grid
        var columns = [ {
            "name": "ProductName",
            "fieldName": "product_name",
            "width": "90",
            "styles": {
            },
            "header": {
                "text": "ProductName"
            }
        }, {
            "name": "UnitPrice",
            "fieldName": "unit_price",
            "width": 60,
            "styles": {
                "numberFormat": "#,##0.00",
                "textAlignment": "far"
            },
            "dynamicStyles": [{
                "expression": "value > 500",
                "styles": {
                    "background": "#10000000"
                }
            }, {
                "expression": "value > 700",
                "styles": {
                    "background": "#20000000"
                }
            }, {
                "expression": "value > 800",
                "styles": {
                    "background": "#30000000"
                }
            }],
            "header": {
                "text": "UnitPrice"
            }
        }, {
            "name": "Quantity",
            "fieldName": "quantity",
            "width": 60,
            "renderer": {
                "type": "shape"
            },
            "styles": {
                "textAlignment": "far"
            },
            "dynamicStyles": [{
                "expressions": [
                    "value > 700", 
                    "value > 500",
                    "value > 300"
                ],
                "styles": [
                    {
                        "shapeColor": "#ff0000"
                    }, {
                        "shapeColor": "#0000ff"
                    }, {
                        "shapeColor": "#008800"
                    }
                ]
            }],
            "header": {
                "text": "Quantity"
            }
        },  {
            "name": "OrderDate",
            "fieldName": "order_date",
            "width": "90",
            "styles": {
                "datetimeFormat": "yyyy-MM-dd",
                "textAlignment": "center"
            },
            "dynamicStyles": [{
                "expression": "value >= date('2015-01-01')",
                "styles": {
                    "background": "#100000ff",
                    "color": "#ff000088"
                }
            }],
            "header": {
                "text": "OrderDate"
            }
        },  {
            "name": "ShipDate",
            "fieldName": "ship_date",
            "width": "120",
            "styles": {
            "datetimeFormat": "yyyy-MM-dd",
            "textAlignment": "center"
            },
            "header": {
                "text": "ShipDate"
            }
        }, {
            "name": "Country",
            "fieldName": "country",
            "width": "70",
            "styles": {
            },
            "dynamicStyles": {
                "expressions": "value in ()",
                "styles": {
                    "fontBold": true
                }
            },
            "header": {
                "text": "Country"
            }
        }, {
            "name": "Unit",
            "fieldName": "unit",
            "width": "90",
            "styles": {
            },
            "header": {
                "text": "Unit"
            }
        }, {
            "name": "Currency",
            "fieldName": "currency",
            "width": "60",
            "styles": {
                "textAlignment": "center",
                "background": "#10ff0000"
            },
            "header": {
                "text": "Currency"
            }
        }, {
            "name": "CustomerName",
            "fieldName": "customer_name",
            "width": "90",
            "styles": {
            },
            "header": {
                "text": "CustomerName"
            }
        } ];
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns(columns);

        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.footer().setVisible(false);
        grdMain.header().head().setPopupMenu({
            label: 'DataLudi Grid Version',
            callback: function () { alert(DataLudi.getVersion()); }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        loadData(dsMain, 10);
        
        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // buttons
        $('#btnAddRows').click(function () {
            loadData(dsMain, 5);
        });
        $('#btnSave').click(function() {
            var memo = '';
            DataLudi.exportToExcel(grdMain, {
                target: "local",
                fileName: "dlgrid.xlsx",
                numberFormat: "#,##0.00",
                datetimeFormat: "yyyy.mm.dd",
                applyDynamicStyles: $("#chkApplyDynamics")[0].checked,
                async: $('#chkAsync')[0].checked,
                showProgress: $('#chkProgress')[0].checked,
                modal: $('#chkModal')[0].checked,
                cancelable: $('#chkCancelable')[0].checked,
                onStart: function (grid) {
                    if (!$('#chkProgress')[0].checked) {
                        grdMain.showProgress('Exporting Grid...', true);
                    }
                    memo = 'Exporting started.';
                    document.getElementById('conMain').value = JSON.stringify(memo);
                },
                onProgress: function (grid, current, elapsed, message) {
                    if (!$('#chkProgress')[0].checked) {
                        grdMain.setProgress(0, 100, current, message + ' in ' + elapsed.toLocaleString());
                    }
                    memo += '\r\n' + current + '%, ' + elapsed + 'ms, ' + message;
                    document.getElementById('conMain').value = JSON.stringify(memo);
                },
                onFinished: function (grid, error, elapsed) {
                    if (!$('#chkProgress')[0].checked) {
                        grdMain.closeProgress();
                    }
                    if (error) {
                        memo += '\r\n' + 'Exporting failed: ' + error;
                        document.getElementById('conMain').value = JSON.stringify(memo);
                    } else {
                        memo += '\r\n' + 'Exporting completed in ' + elapsed + 'ms.';
                        document.getElementById('conMain').value = JSON.stringify(memo);
                    }
                }
            });
        });
        $('#btnUpload').click(function() {
            DataLudi.exportToExcel(grdMain, {
                url:  "/envelope",
                fileName: "dlgrid.xlsx",
                numberFormat: "#,##0.00",
                datetimeFormat: "yyyy.mm.dd",
                applyDynamicStyles: $("#chkApplyDynamics")[0].checked,
                async: $('#chkAsync')[0].checked,
                showProgress: $('#chkProgress')[0].checked,
                modal: $('#chkModal')[0].checked,
                cancelable: $('#chkCancelable')[0].checked,
                onStart: function (grid) {
                    if (!$('#chkProgress')[0].checked) {
                        grdMain.showProgress('Exporting Grid...', false, function () {
                            return true;
                        });
                    }
                    memo = 'Exporting started.';
                    document.getElementById('conMain').value = JSON.stringify(memo);
                },
                onProgress: function (grid, current, elapsed, message) {
                    if (!$('#chkProgress')[0].checked) {
                        grdMain.setProgress(0, 100, current, message + ' in ' + elapsed.toLocaleString());
                    }
                    memo += '\r\n' + current + '%, ' + elapsed + 'ms, ' + message;
                    document.getElementById('conMain').value = JSON.stringify(memo);
                },
                onFinished: function (grid, error, elapsed) {
                    if (!$('#chkProgress')[0].checked) {
                        grdMain.closeProgress();
                    }
                    if (err) {
                        memo += '\r\n' + 'Exporting failed: ' + error;
                        document.getElementById('conMain').value = JSON.stringify(memo);
                    } else {
                        memo += '\r\n' + 'Exporting completed in ' + elapsed + 'ms.';
                        document.getElementById('conMain').value = JSON.stringify(memo);
                    }
                }
            });
        });
    });
</script>
</head>
<body>
    <h3>Async Excel Exporting</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <button id="btnAddRows">Append Rows</button>
    </div>
    <div>
        <button id="btnSave">Save to Local</button>
        <button id="btnUpload">Upload to Server</button>
        <input type="checkbox" id="chkAsync" checked="checked">Async
        <input type="checkbox" id="chkApplyDynamics" checked="checked">Apply Dynamic Styles
        <input type="checkbox" id="chkProgress" checked="checked">Show Progress
        <input type="checkbox" id="chkModal">Modal
        <input type="checkbox" id="chkCancelable" checked="checked">Cancelable
    </div>
    <p>
    <textarea id="conMain" class="helpMemo" style="width:730px;min-height:200px;"></textarea>
</body>
</html>