<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Search Row</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script> -->
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain, grdMain2;
        var dsMain;
        var prevField = -1;

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName : "product_id"
        }, {
            fieldName : "product_name"
        }, {
            fieldName : "customer_id"
        }, {
            fieldName : "customer_name"
        }, {
            fieldName : "country"
        }, {
            fieldName : "phone"
        }, {
            fieldName : "unit"
        }, {
            fieldName : "currency"
        }, {
            fieldName : "unit_price",
            dataType : "number"
        }, {
            fieldName : "quantity",
            dataType : "number"
        }, {
            fieldName : "order_date",
            dataType : "datetime",
            datetimeFormat : "yyyy-MM-dd"
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
            "styles" : {
                "background" : "#080000ff"
            },
            "header" : {
                "text" : "ProductName"
            }
        }, {
            "name" : "CustomerId",
            "fieldName" : "customer_id",
            "width" : "80",
            "styles" : {},
            "header" : {
                "text" : "CustomerId"
            }
        }, {
            "name" : "CustomerName",
            "fieldName" : "customer_name",
            "width" : "80",
            "styles" : {
                "background" : "#0800ff00"
            },
            "header" : {
                "text" : "CustomerName"
            }
        }, {
            "name" : "Phone",
            "fieldName" : "phone",
            "width" : 110,
            "styles" : {},
            "header" : {
                "text" : "Phone"
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
            "name" : "Unit",
            "fieldName" : "unit",
            "width" : "90",
            "styles" : {},
            "header" : {
                "text" : "Unit"
            }
        }, {
            "name" : "OrderDate",
            "fieldName" : "order_date",
            "width" : "90",
            "styles" : {
                datetimeFormat : "yyyy-MM-dd",
                textAlignment : "center"
            },
            "header" : {
                "text" : "OrderDate"
            }
        }, {
            "name" : "ShipDate",
            "fieldName" : "ship_date",
            "width" : "120",
            "styles" : {
                datetimeFormat : "yyyy-MM-dd hh:mm",
                textAlignment : "center"
            },
            "header" : {
                "text" : "ShipDate"
            }
        }, {
            "name" : "UnitPrice",
            "fieldName" : "unit_price",
            "width" : "100",
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "UnitPrice"
            },
            "footer" : {
                "styles" : {
                    "textAlignment" : "far",
                    "numberFormat" : "0,000",
                    "postfix" : " $",
                    "font" : "Arial,12"
                },
                "text" : "SUM",
                "expression" : "sum",
                /*"expression": "sum[4]",*/
                "dynamicStyles" : [ {
                    "criteria" : "value > 10000",
                    "styles" : "color=#ff0000"
                } ]
            }
        }, {
            "name" : "Quantity",
            "fieldName" : "quantity",
            "width" : "100",
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "Quantity"
            },
            "footer" : {
                "styles" : {
                    "textAlignment" : "far",
                    "numberFormat" : "0,000",
                    "postfix" : " $",
                    "font" : "Arial,12"
                },
                "text" : "SUM",
                "expression" : "sum",
                /*"expression": "sum[4]",*/
                "dynamicStyles" : [ {
                    "criteria" : "value > 10000",
                    "styles" : "color=#ff0000"
                } ]
            }
        } ]);

        grdMain2 = DataLudi.createGridView("container2");
        grdMain2.setColumns([ {
            "name" : "ProductName",
            "fieldName" : "product_name",
            "width" : "90",
            "styles" : {
                "background" : "#080000ff"
            },
            "dynamicStyles" : [ {
                "expression" : "rowtag == '#found_0'",
                "styles" : {
                    "fontBold" : true,
                    "background" : "#008",
                    "color" : "#fff"
                }
            } ],
            "header" : {
                "text" : "ProductName"
            }
        }, {
            "name" : "CustomerId",
            "fieldName" : "customer_id",
            "width" : "80",
            "styles" : {},
            "header" : {
                "text" : "CustomerId"
            }
        }, {
            "name" : "CustomerName",
            "fieldName" : "customer_name",
            "width" : "80",
            "styles" : {
                "background" : "#0800ff00"
            },
            "header" : {
                "text" : "CustomerName"
            }
        }, {
            "name" : "Phone",
            "fieldName" : "phone",
            "width" : 110,
            "styles" : {},
            "header" : {
                "text" : "Phone"
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
            "name" : "Unit",
            "fieldName" : "unit",
            "width" : "90",
            "styles" : {},
            "dynamicStyles" : [ {
                "expression" : "rowtag == '#found_1'",
                "styles" : {
                    "fontBold" : true,
                    "background" : "#008",
                    "color" : "#fff"
                }
            } ],
            "header" : {
                "text" : "Unit"
            }
        }, {
            "name" : "OrderDate",
            "fieldName" : "order_date",
            "width" : "90",
            "styles" : {
                datetimeFormat : "yyyy-MM-dd",
                textAlignment : "center"
            },
            "header" : {
                "text" : "OrderDate"
            }
        }, {
            "name" : "ShipDate",
            "fieldName" : "ship_date",
            "width" : "120",
            "styles" : {
                datetimeFormat : "yyyy-MM-dd hh:mm",
                textAlignment : "center"
            },
            "header" : {
                "text" : "ShipDate"
            }
        }, {
            "name" : "UnitPrice",
            "fieldName" : "unit_price",
            "width" : "100",
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "UnitPrice"
            },
            "footer" : {
                "styles" : {
                    "textAlignment" : "far",
                    "numberFormat" : "0,000",
                    "postfix" : " $",
                    "font" : "Arial,12"
                },
                "text" : "SUM",
                "expression" : "sum",
                /*"expression": "sum[4]",*/
                "dynamicStyles" : [ {
                    "criteria" : "value > 10000",
                    "styles" : "color=#ff0000"
                } ]
            }
        }, {
            "name" : "Quantity",
            "fieldName" : "quantity",
            "width" : "100",
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "Quantity"
            },
            "footer" : {
                "styles" : {
                    "textAlignment" : "far",
                    "numberFormat" : "0,000",
                    "postfix" : " $",
                    "font" : "Arial,12"
                },
                "text" : "SUM",
                "expression" : "sum",
                /*"expression": "sum[4]",*/
                "dynamicStyles" : [ {
                    "criteria" : "value > 10000",
                    "styles" : "color=#ff0000"
                } ]
            }
        } ]);

        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });
        grdMain.loadStyles({
            grid : {
                border : "#008"
            },
            body : {
                rowDynamic : [ {
                    expression : "tag == '#found'",
                    styles : {
                        background : '#10ff00ff',
                        fontBold : true
                    }
                } ]
            }
        });

        grdMain2.checkBar().setVisible(false);
        grdMain2.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        grdMain2.setDataSource(dsMain);
        $.ajax({
            url : "data/orders_s.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1
                });
                var f1 = dsMain.getFieldIndex('product_name');
                var f2 = dsMain.getFieldIndex('customer_name');
                var names1 = [ 'Apple', 'Orange', 'Google', 'Amazon', 'Microsoft', 'Samsung', 'Shaomi', 'Oracle', 'Sun' ];
                var names2 = [ 'daum', 'naver', 'sse', 'lge', 'dataludi' ];
                dsMain.beginUpdate();
                for (var r = 0; r < dsMain.rowCount(); r++) {
                    var i = Math.floor(Math.random() * names1.length);
                    var j = Math.floor(Math.random() * names2.length);
                    dsMain.updateRow(r, {
                        product_name : names1[i],
                        customer_name : names2[j],
                        unit : (r % 2) ? (names1[i] + '_2') : names1[i]
                    });
                }
                dsMain.endUpdate();
                grdMain.setFocusedCell();
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
        grdMain.onClickableCellClicked = function(grid, index, source, data) {
            window.open(data, '_newtab');
        };

        // buttons
        $('#btnSearchRow').click(function() {
            var options = {
                caseSensitive : document.getElementById('chkSensitive_1').checked,
                partialMatch : document.getElementById('chkParital_1').checked
            };
            var wrap = document.getElementById('chkWrap_1').checked;
            var r = grdMain.focusedRowIndex() + 1;
            var v = $('#edtValue_1').val();
            r = grdMain.searchRow([ 'product_name' ], [ v ], options, r, wrap, true);
            if (r >= 0) {
                dsMain.clearRowTags();
                dsMain.setRowTag(grdMain.getRow(r).dataIndex(), '#found');
            }
        });
        $('#btnSearchRow2').click(function() {
            var options = {
                allFields : document.getElementById('chkAllFields').checked,
                caseSensitive : document.getElementById('chkSensitive_2').checked,
                partialMatch : document.getElementById('chkParital_2').checked
            };
            var wrap = document.getElementById('chkWrap_2').checked;
            var r = grdMain.focusedRowIndex() + 1;
            var product = $('#edtValue_2').val();
            var customer = $('#edtCustomer').val();
            r = grdMain.searchRow([ 'product_name', 'customer_name' ], [ product, customer ], options, r, wrap, true);
            if (r >= 0) {
                dsMain.clearRowTags();
                dsMain.setRowTag(grdMain.getRow(r).dataIndex(), '#found');
            }
        });
        $('#btnSearchCell').click(function() {
            var options = {
                caseSensitive : document.getElementById('chkSensitive_3').checked,
                partialMatch : document.getElementById('chkParital_3').checked
            };
            var wrap = document.getElementById('chkWrap_3').checked;
            var r = grdMain2.focusedRowIndex() + 1;
            var v = $('#edtValue_3').val();
            var result = grdMain2.searchCell([ 'product_name' ], v, options, r, 0, wrap, true);
            if (result) {
                dsMain.clearRowTags();
                dsMain.setRowTag(grdMain.getRow(result.rowIndex).dataIndex(), '#found_0');
            }
        });

        $('#btnSearchCell2').click(function() {
            var options = {
                caseSensitive : document.getElementById('chkSensitive_4').checked,
                partialMatch : document.getElementById('chkParital_4').checked
            };
            var wrap = document.getElementById('chkWrap_4').checked;
            var r = grdMain2.focusedRowIndex() + (prevField > 0 ? 1 : 0);
            var c = grdMain2.focusedColumn();
            var v = $('#edtValue_4').val()
            var result = grdMain2.searchCell([ 'product_name', 'unit' ], v, options, r, prevField + 1, wrap, true);
            if (result) {
                dsMain.clearRowTags();
                dsMain.setRowTag(grdMain.getRow(result.rowIndex).dataIndex(), result.searchFieldIndex == 1 ? '#found_1' : '#found_0');
                prevField = result.searchFieldIndex;
            }
        });
    });
</script>
</head>
<body>
    <h3>Search Row</h3>
    <div>
        <button id="btnSearchRow">Search Row</button>
        <span>제품명 : </span>
        <input type="text" id="edtValue_1" value="Apple">
        <input type="checkbox" id="chkSensitive_1">Case Sensitive 
        <input type="checkbox" id="chkParital_1">Partial Match 
        <input type="checkbox" id="chkWrap_1" checked="checked">Wrap
    </div>
    <div>
        <button id="btnSearchRow2">Search Row</button>
        <span>제품명 : </span> 
        <input type="text" id="edtValue_2" value="Apple">
        <span>고객명 : </span>
        <input type="text" id="edtCustomer" value="dataludi">
        <input type="checkbox" id="chkAllFields" checked="checked">All Fields
        <input type="checkbox" id="chkSensitive_2">Sensitive
        <input type="checkbox" id="chkParital_2">Partial
        <input type="checkbox" id="chkWrap_2" checked="checked">Wrap
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <h3>Search Cell</h3>
    <div>
        <button id="btnSearchCell">Search Cell</button>
        <span>검색어 : </span>
        <input type="text" id="edtValue_3" value="Apple">
        <input type="checkbox" id="chkSensitive_3">Case Sensitive
        <input type="checkbox" id="chkParital_3">Partial Match
        <input type="checkbox" id="chkWrap_3" checked="checked">Wrap
    </div>
    <div>
        <button id="btnSearchCell2">Search Cell</button>
        <span>검색어 : </span>
        <input type="text" id="edtValue_4" value="Apple">
        <input type="checkbox" id="chkSensitive_4">Sensitive
        <input type="checkbox" id="chkParital_4">Partial
        <input type="checkbox" id="chkWrap_4" checked="checked">Wrap
    </div>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
</body>
</html>