<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Column Exclusion</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script type="text/javascript" src="js/theme/flatbluestyle.js"></script>
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
        "name": "Country",
        "fieldName": "country",
        "width": 70,
        "styles": {
        },
        "header": {
            "text": "Country"
        }
    }, {
        "name": "Currency",
        "fieldName": "currency",
        "width": 70,
        "styles": {
            "textAlignment": "center"
        },
        "header": {
            "text": "Currency"
        }
    }, {
        "name": "ProductName",
        "fieldName": "product_name",
        "width": 70,
        "styles": {
        },
        "header": {
            "text": "ProductName"
        }
    }, {
        "name": "CustomerGroup",
        "width": 240,
        "layout": "vertical",
        "footer": "CustomerGroup Footer",
        "columns": [
            {
                "name": "Country2",
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
        "name": "Currency2",
        "fieldName": "currency",
        "width": 60,
        "styles": {
            "textAlignment": "center"
        },
        "header": {
            "text": "Currency"
        }
    }, {
        "name": "DateGroup",
        "type": "group",
        "width": 160,
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

    function excludeHandler(grid, column) {
        if (confirm(column.displayText() + ' 컬럼을 감추겠스니까?')) {
            column.setVisible(false);
        }
    }
    
    grdMain.onExcludeColumn = excludeHandler;

    // buttons
    $('#chkExcludable').click(function() {
    	var checked = document.getElementById('chkExcludable').checked;
        grdMain.setDisplayOptions({
        	columnExcludable: checked
        });
    });
    $('#chkHide').click(function() {
        var checked = document.getElementById('chkHide').checked;
        grdMain.setDisplayOptions({
            hideColumnWhenExcluded: checked
        });
    });
    $('#chkEvent').click(function() {
        var checked = document.getElementById('chkEvent').checked;        
        grdMain.onExcludeColumn = checked ? excludeHandler : null;
    });
});
</script>
</head>
<body>
<h3>Column Exclusion</h3>
<div>
    <input type="checkbox" id="chkExcludable">컬럼 제거 가능
    <input type="checkbox" id="chkHide" checked="checked">컬럼 감추기
</div>
<div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
<div>
    <span id="rowCount" style="">0</span> rows.
</div>
<div>
    <input type="checkbox" id="chkEvent" checked="checked">제거 이벤트 설정
</div>
</body>
</html>