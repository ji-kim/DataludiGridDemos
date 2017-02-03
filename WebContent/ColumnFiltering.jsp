<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Column Filtering</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script> --><script type="text/javascript" src="js/theme/flatbluestyle.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain;
        var dsMain;

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName : "product_id",
        }, {
            fieldName : "product_name",
        }, {
            fieldName : "customer_id",
        }, {
            fieldName : "customer_name",
        }, {
            fieldName : "country",
        }, {
            fieldName : "phone",
        }, {
            fieldName : "unit",
        }, {
            fieldName : "currency",
        }, {
            fieldName : "unit_price",
            dataType : "number"
        }, {
            fieldName : "quantity",
            dataType : "number"
        }, {
            fieldName : "order_date",
            dataType : "datetime",
            datetimeFormat : "yyyy-MM-dd",
            zoneDelta: 540
        }, {
            fieldName : "ship_date",
            dataType : "datetime",
            datetimeFormat : "iso"
        } ]);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name" : "ProductName",
            "fieldName" : "product_name",
            "width" : "90",
            "styles" : {},
            "header" : {
                "text" : "ProductName"
            }
        }, {
            "name" : "UnitPrice",
            "fieldName" : "unit_price",
            "width" : 60,
            "styles" : {
                "numberFormat" : "#,##0.00",
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "UnitPrice"
            },
            "filters" : [ {
                "name" : "High Price",
                "expression" : "value > 800"
            }, {
                "name" : "Mid Price",
                "expression" : "(value > 500) && (value <= 800)"
            }, {
                "name" : "Low Price",
                "expression" : "value <= 500"
            } ]
        }, {
            "name" : "Quantity",
            "fieldName" : "quantity",
            "width" : 60,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "Quantity"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "fontName" : "Arial",
                    "fontBold" : true,
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "OrderDate",
            "fieldName" : "order_date",
            "width" : "90",
            "styles" : {
                "datetimeFormat" : "yyyy-MM-dd",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "OrderDate"
            }
        }, {
            "name" : "ShipDate",
            "fieldName" : "ship_date",
            "width" : "120",
            "styles" : {
                "datetimeFormat" : "yyyy-MM-dd",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "ShipDate"
            }
        }, {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "70",
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "Unit",
            "fieldName" : "unit",
            "width" : "90",
            "styles" : {},
            "header" : {
                "text" : "Unit"
            }
        }, {
            "name" : "Currency",
            "fieldName" : "currency",
            "width" : "60",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Currency"
            }
        }, {
            "name" : "CustomerName",
            "fieldName" : "customer_name",
            "width" : "90",
            "styles" : {},
            "header" : {
                "text" : "CustomerName"
            }
        } ]);

        //grid options
        grdMain.setOptions({
            checkBar : false,
            header : {
                head : {
                    popupMenu : {
                        label : 'DataLudi Version',
                        callback : function() {
                            alert(DataLudi.getVersion());
                        }
                    }
                }
            }
        })

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url : "data/orders_s.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1
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

        // buttons
        $('#chkHighPrice').click(function() {
            var col = grdMain.columnByName('UnitPrice');
            col.activateFilters('High Price', document.getElementById('chkHighPrice').checked);
        });
        $('#chkUnitAll').click(function() {
            var col = grdMain.columnByName('UnitPrice');
            col.activateAllFilters(document.getElementById('chkUnitAll').checked);
        });
        $('#btnSetFilters').click(function() {
            var col = grdMain.columnByName('Country');
            col.setFilters([ {
                name : 'Asia Countries',
                expression : 'value in ("China", "Japan", "Indonesia")',
                active : true
            }, {
                name : 'Europe Countries',
                expression : 'value in ("Italy", "Poland", "Finland", "Greece")'
            } ]);
        });

        $('#btnClearFilters').click(function() {
            var col = grdMain.columnByName('Country');
            col.clearFilters();
        });
        $('#btnAddFilter').click(function() {
            var col = grdMain.columnByName('OrderDate');
            col.addFilters({
                name : "2014 Year",
                expression : "value >= date('2014-01-01T00:00:00+09:00') && value < date('2015-01-01T00:00:00+09:00')",
                active : true
            });
        });
        $('#btnRemoveFilter').click(function() {
            var col = grdMain.columnByName('OrderDate');
            col.removeFilters('2014 Year');
        });
    });
</script>
</head>
<body>
    <h3>Column Filtering</h3>
    <div id="container"
        style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkHighPrice">'단가' 컬럼의 'High Price' 필터 active 
        <input type="checkbox" id="chkUnitAll">'단가' 컬럼의 전체필터 active
    </div>
    <div>
        <button id="btnSetFilters">Set Filters</button>
        <span>'국가' 컬럼에 필터들을 설정한다.</span>
    </div>
    <div>
        <button id="btnClearFilters">Clear Filters Filters</button>
        <span>'국가' 컬럼의 필터들을 모두 제거한다.</span>
    </div>
    <div>
        <button id="btnAddFilter">Add Filter</button>
        <span>'발주일' 컬럼에 '2014년만 표시하는' 필터를 추가한다.</span>
    </div>
    <div>
        <button id="btnRemoveFilter">Remove Filter</button>
        <span>발주일' 컬럼의 필터를 제거한다.</span>
    </div>
</body>
</html>