<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Column Resizing</title>
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
            fieldName : "product_id",
            dataType : "text",
        }, {
            fieldName : "product_name"
        }, {
            fieldName : "customer_id"
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
            datetimeFormat : "yyyy-MM-dd"
        }, {
            fieldName : "ship_date",
            dataType : "datetime",
            datetimeFormat : "iso"
        } ]);
        dsMain.setSoftDelete(true);

        // grid
        var columns = [ {
            "name" : "Country",
            "fieldName" : "country",
            "width" : 70,
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "Currency",
            "fieldName" : "currency",
            "width" : 70,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Currency"
            }
        }, {
            "name" : "ProductName",
            "fieldName" : "product_name",
            "width" : 70,
            "styles" : {},
            "header" : {
                "text" : "ProductName"
            }
        }, {
            "name" : "CustomerGroup",
            "width" : 240,
            "layout" : "vertical",
            "footer" : "CustomerGroup Footer",
            "columns" : [ {
                "name" : "Country2",
                "fieldName" : "country",
                "width" : "70",
                "styles" : {},
                "header" : {
                    "text" : "Country"
                }
            }, {
                "name" : "ChildGroup",
                "layout" : "horizontal",
                "columns" : [ {
                    "name" : "CustomerId",
                    "fieldName" : "customer_id",
                    "width" : "90",
                    "styles" : {},
                    "header" : {
                        "text" : "CustomerId"
                    }
                }, {
                    "name" : "CustomerName",
                    "fieldName" : "customer_name",
                    "width" : "90",
                    "styles" : {},
                    "header" : {
                        "text" : "CustomerName"
                    }
                }, {
                    "name" : "Phone",
                    "fieldName" : "phone",
                    "width" : "100",
                    "styles" : {},
                    "header" : {
                        "text" : "Phone"
                    }
                } ]
            } ]
        }, {
            "name" : "Currency2",
            "fieldName" : "currency",
            "width" : 60,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Currency"
            }
        }, {
            "name" : "DateGroup",
            "type" : "group",
            "width" : 160,
            "columns" : [ {
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
            } ]
        } ];
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns(columns);

        //grid options
        grdMain.displayOptions().setFixedColumnCount(2);
        grdMain.checkBar().setVisible(false);
        grdMain.body().setFixedColumnBarWidth(2);
        grdMain.footer().setVisible(false);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });
        grdMain.loadStyles({
            header : {
                group : {
                    background : '#10ffcc88'
                }
            }
        });

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
                var err = textStatus + ', ' + error;
                alert("jQuery getJSON() Failed: " + err);
            }
        });

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // grid events
        grdMain.onCurrentChanged = function(grid, index) {
            var col = index.column;
            if (col) {
                $('#chkFocusedResizable')[0].checked = col.resizable();
                $('#chkParentResizable')[0].disabled = !col.group();
                $('#chkParentResizable')[0].checked = col.parent().resizable();
            }
        };

        // buttons
        $('#chkColumnResizable').click(function() {
            var checked = document.getElementById('chkColumnResizable').checked;
            grdMain.displayOptions().setColumnResizable(checked);
        });
        $('#chkFixedColumnResizable').click(function() {
            var checked = document.getElementById('chkFixedColumnResizable').checked;
            grdMain.displayOptions().setFixedColumnResizable(checked);
        });
        $('#chkCheckChildColumnResizable').click(function() {
            var checked = document.getElementById('chkCheckChildColumnResizable').checked;
            grdMain.displayOptions().setCheckChildColumnResizable(checked);
        });
        $('#chkFocusedResizable').click(function() {
            var checked = document.getElementById('chkFocusedResizable').checked;
            var col = grdMain.focusedColumn();
            col && col.setResizable(checked);
        });
        $('#chkParentResizable').click(function() {
            var col = grdMain.focusedColumn();
            var checked = document.getElementById('chkParentResizable').checked;
            col && col.group() && col.parent().setResizable(checked);
        });
    });
</script>
</head>
<body>
    <h3>Column Resizing</h3>
    <div>
        <input type="checkbox" id="chkColumnResizable" checked="checked">컬럼 크기 변경 : false이면 모든 컬럼의 너비를 변경할 수 없다.
        <br>
        <input type="checkbox" id="chkFixedColumnResizable">고정 컬럼 크기 변경 : true이면 고정 컬럼들의 너비를 변경할 수 있다.
        <br>
        <input type="checkbox" id="chkCheckChildColumnResizable" checked="checked">부모 컬럼 크기 변경 확인 : 자식 컬럼 너비를 변경할 때 부모 컬럼이 크기 변경 가능한 지 먼저 확인.
        <br>
        <input type="checkbox" id="chkFocusedResizable" checked="checked">선택 컬럼 크기 변경 : resizable 속성으로 선택 컬럼 너비 변경 여부를 지정할 수 있다.
        <br>
        <input type="checkbox" id="chkParentResizable">선택 컬럼의 부모 컬럼 크기 변경 : 선택 컬럼의 부모 컬럼 너비 변경 여부를 지정한다.
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>