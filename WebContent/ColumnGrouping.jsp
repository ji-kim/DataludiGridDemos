<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Column Grouping</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script>
$(document).ready(function () {
    DataLudi.setDebug(true);
    DataLudi.setTrace(true);
    
    var grdMain;
    var dsMain;
    
    // dataset
    dsMain = DataLudi.createGridDataSet();
    dsMain.setFields([{
        fieldName: "product_id",
        dataType: "text",
    }, {
        fieldName: "product_name"
    }, {
        fieldName: "customer_id"
    },
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
    }]);
    
    // grid
    grdMain = DataLudi.createGridView("container");
    grdMain.setColumns([{
        "name": "ProductName",
        "fieldName": "product_name",
        "width": "90",
        "styles": {
        },
        "header": {
            "text": "ProductName"
        }
    }, {
        "name": "CustomerGroup",
        "width": 320,
        "layout": "vertical",
        "footer": "CustomerGroup Footer",
        "columns": [
            {
                "name": "Country",
                "fieldName": "country",
                "width": "70",
                "styles": {
                },
                "header": {
                    "text": "Country"
                }
            }, {
                "name": "ChildGroup",
                "layout": "horizontal",
                "columns": [
                    {
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
                    }
                ]
            }
        ]
    }, {
        "name": "Currency",
        "fieldName": "currency",
        "width": "60",
        "styles": {
            "textAlignment": "center"
        },
        "header": {
            "text": "Currency"
        }
    }, {
        "name": "DateGroup",
        "type": "group",
        "width": "200",
        "columns": [
            {
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
            }
        ]
    }, {
        "name": "HiddenGroup",
        "type": "group",
        "width": "200",
        "visible": false,
        "columns": [
            {
                "name": "OrderDate2",
                "fieldName": "order_date",
                "width": "90"
            },  {
                "name": "ShipDate2",
                "fieldName": "ship_date",
                "width": "120"
            }
        ]
    }]);
    
    //grid options
    grdMain.checkBar().setVisible(false);
    grdMain.header().head().setPopupMenu({
        label: 'DataLudi Grid Version',
        callback: function () { alert(DataLudi.getVersion()); }
    });
    
    // connect dataset
    grdMain.setDataSource(dsMain);

    $.ajax({
        url: "data/orders_s.csv",
        dataType: 'text',
        success: function (data) {
            new DataLudi.DataLoader(dsMain).load("csv", data, {
                start:1
            });
        },
        error: function (xhr, status, error) {
            var err = textStatus + ', ' + error;
            alert("jQuery getJSON() Failed: " + err);
        }
    });
    
    // dataset events
    dsMain.onRowCountChanged = function (ds, count) {
        $("#rowCount").css("color", "blue").text(count.toLocaleString());
    };

    // buttons
    $('#btnLayout').click(function () {
        var column = grdMain.columnByName('DateGroup');
        if (column) {
            column.setLayout(column.layout() == 'vertical' ? 'horizontal' : 'vertical');
        }
    });
    $('#btnGroupHeader').click(function () {
        var column = grdMain.columnByName('DateGroup');
        if (column) {
            column.header().setVisible(!column.header().visible());
        }
    });
    $('#btnChildHeaders').click(function () {
        var column = grdMain.columnByName('DateGroup');
        if (column) {
            column.setChildHeadersVisible(!column.childHeadersVisible());
        }
    });
    $('#btnChildFooters').click(function () {
        var column = grdMain.columnByName('CustomerGroup');
        if (column) {
            column.setChildFootersVisible(!column.childFootersVisible());
        }
    });
    $('#btnAllColumns').click(function () {
        var columns = [];
        grdMain.visitAllColumns(function (col) {
            columns.push(col.name()); 
        });
        document.getElementById('conMain').value = JSON.stringify(columns);
    });
    $('#btnVisibleColumns').click(function () {
        var columns = [];
        grdMain.visitColumns(function (col) {
            columns.push(col.name()); 
        });
        document.getElementById('conMain').value = JSON.stringify(columns);
    });    
});
</script>
</head>
<body>
<h3>Column Grouping</h3>
<div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
<div>
    <span id="rowCount" style="">0</span> rows.
</div>
<p>
<div>
    <button id="btnLayout">Change Layout</button>
    <button id="btnGroupHeader">Group Header</button>
    <button id="btnChildHeaders">Child Headers - DateGroup</button>
    <button id="btnChildFooters">Child Footers - Customer Group</button>
    <button id="btnAllColumns">Get All Columns</button>
    <button id="btnVisibleColumns">Get Visible Columns</button>      
</div>
<p>
<textarea id="conMain" class="helpMemo" style="width:730px;min-height:200px;"></textarea>
</body>
</html>