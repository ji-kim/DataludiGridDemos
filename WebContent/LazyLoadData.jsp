<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Lazy Data Loading</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script> -->
<script>
$(document).ready(function () {
    DataLudi.setDebug(true);
    DataLudi.setTrace(true);
    
    var grdMain, grdMain2;
    var dsMain, dsMain;
    var loading2 = false;
    var loadCount2 = 0;
    
    // dataset
    var fields = [
        "product_id",
        "product_name",
        "customer_id",
        "customer_name",
        "country",
        "phone",
        "unit",
        "currency",
        {
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
        }
    ];
    dsMain = DataLudi.createGridDataSet();
    dsMain.setFields(fields);
    dsMain2 = DataLudi.createGridDataSet();
    dsMain2.setFields(fields);
    
    // grid
    var columns = [{
        "name": "ProductName",
        "fieldName": "product_name",
        "width": "90",
        "styles": {
        },
        "header": {
            "text": "ProductName"
        }
    }, {
        "name": "CustomerId",
        "fieldName": "customer_id",
        "width": "90",
        "styles": {
        },
        "header": {
            "text": "CustomerId"
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
    }, {
        "name": "Phone",
        "fieldName": "phone",
        "width": "100",
        "styles": {
        },
        "header": {
            "text": "Phone"
        }
    }, {
        "name": "Currency",
        "fieldName": "currency",
        "width": "60",
        "ignoreRowDynamicStyles": true,
        "styles": {
            "textAlignment": "center",
            "background": "#3000ff00"
        },
        "header": {
            "text": "Currency"
        }
    }, {
        "name": "Unit",
        "fieldName": "unit",
        "width": "70",
        "styles": {
        },
        "header": {
            "text": "Unit"
        }
    }, {
        "name": "OrderDate",
        "fieldName": "order_date",
        "width": "90",
        "styles": {
            datetimeFormat: "yyyy-MM-dd",
            textAlignment: "center"
        },
        "header": {
            "text": "OrderDate"
        }
    },  {
        "name": "ShipDate",
        "fieldName": "ship_date",
        "width": "120",
        "styles": {
            datetimeFormat: "yyyy-MM-dd hh:mm",
            textAlignment: "center"
        },
        "header": {
            "text": "ShipDate"
        }
    }, {
        "name": "UnitPrice",
        "fieldName": "unit_price",
        "width": "100",
        "styles": {
            "textAlignment": "far"
        },
        "header": {
            "text": "UnitPrice"
        },
        "footer": {
            "styles": {
                "textAlignment": "far",
                "numberFormat": "0,000",
                "postfix": " $",
                "font": "Arial,12"
            },
            "text": "SUM",
            "expression": "sum",
            /*"expression": "sum[4]",*/
            "dynamicStyles": [{
                "criteria": "value > 10000",
                "styles": "color=#ff0000"
            }]
        }
    }, {
        "name": "Quantity",
        "fieldName": "quantity",
        "width": "100",
        "styles": {
            "textAlignment": "far"
        },
        "header": {
            "text": "Quantity"
        },
        "footer": {
            "styles": {
                "textAlignment": "far",
                "numberFormat": "0,000",
                "postfix": " $",
                "font": "Arial,12"
            },
            "text": "SUM",
            "expression": "sum",
            /*"expression": "sum[4]",*/
            "dynamicStyles": [{
                "criteria": "value > 10000",
                "styles": "color=#ff0000"
            }]
        }
    }];

    grdMain = DataLudi.createGridView("container");
    grdMain.setColumns(columns);
    grdMain2 = DataLudi.createGridView("container2");
    grdMain2.setColumns(columns);
    
    //grid options
    grdMain.setOptions({
        checkBar: false,
        header: {
            head: {
                popupMenu: {
                    label: 'DataLudi Grid Version',
                    callback: function () { alert(DataLudi.getVersion()); }
                }
            }
        }
    });
    grdMain2.setOptions({
        checkBar: false,
        header: {
            head: {
                popupMenu: {
                    label: 'DataLudi Grid Version',
                    callback: function () { alert(DataLudi.getVersion()); }
                }
            }
        }
    });
    
    // connect dataset
    grdMain.setDataSource(dsMain);
    grdMain2.setDataSource(dsMain2);
    var loading = false;
    var loadData = function (ds, grid) {
        if (loading) return ;
        loading = true;
        grid.showToast('Load Data ...');
        $.ajax({
            url: "data/orders.json",
            dataType: 'text',
            success: function (data) {
                grid.hideToast();
                DataLudi.loadJsonData(ds, data, {
                    fillMode: "append"
                });
            },
            error: function (xhr, status, error) {
                var err = status + ', ' + error;
                alert("jQuery ajax() Failed: " + err);
            },
            complete: function () {
                loading = false;
                grid.hideToast();
            }
        }); 
    };
    loadData(dsMain, grdMain);
    var loadData2 = function (ds, grid) {
        if (loading2) return;
        
        loading2 = true;
        grid.showToast('Load Data ...');
        $.ajax({
            url: "data/orders.json",
            dataType: 'text',
            success: function (data) {
                if (!ds.hasData(loadCount2)) {
                    new DataLudi.DataLoader(ds).load("json", data, {
                        fillMode: "update",
                        fillPos: loadCount2,
                        count: 1000
                    });
                }
                loadCount2 += 1000;
            },
            error: function (xhr, status, error) {
                var err = status + ', ' + error;
                alert("jQuery ajax() Failed: " + err);
            },
            complete: function () {
                loading2 = false;
                grid.hideToast();
                
                if (loadCount2 < 10000) {
                    setTimeout(function () {
                        loadData2(ds, grid);
                    }, 1000)
                }
            }
        });
    };

    // dataset events
    dsMain.onRowCountChanged = function (ds, count) {
        $("#rowCount").css("color", "blue").text(count.toLocaleString());
    };
    dsMain2.onRowCountChanged = function (ds, count) {
         $("#rowCount2").css("color", "blue").text(count.toLocaleString());
    };

     // grid events
    grdMain.onScrollToBottom = function (grid) {
        loadData(dsMain, grdMain);       
    };
     
    // buttons
    $('#btnLoadData').click(function () {
        dsMain2.setRowCount(10000);
        loadData2(dsMain2, grdMain2);
    });
});
</script>
</head>
<body>
<h3>Lazy Data Loading</h3>
<div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
<div>
    <span id="rowCount" style="">0</span> rows.
</div>
<p>
<div>
    <button id="btnLoadData">1초 간격으로 두고 1000건씩 로드하기</button>
</div>
<div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
<div>
    <span id="rowCount2" style="">0</span> rows.
</div>
</body>
</html>