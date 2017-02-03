<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Column Visibility</title>
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

        var grdMain;
        var dsMain;
        var loadColumns = function() {
            var groups = [];
            var cols = [];
            var values = [];
            var labels = [];
            var c, i;

            grdMain.visitAllColumns(function(col) {
                if (col instanceof DataLudi.ColumnGroup) {
                    groups.push(col);
                } else {
                    cols.push(col);
                }
            });

            for (i = 0; i < groups.length; i++) {
                c = groups[i];
                values.push(c.name());
                labels.push(c.header().displayText());
            }
            $_fillSelect('selGroups', values, labels);

            values = [];
            labels = [];
            for (i = 0; i < cols.length; i++) {
                c = cols[i];
                values.push(c.name());
                labels.push(c.header().displayText());
            }
            $_fillSelect('selColumns', values, labels);
            checkColumn();
        };
        var loadData = function(ds) {
            $.ajax({
                url : "data/orders_s.csv",
                dataType : 'text',
                success : function(data) {
                    new DataLudi.DataLoader(ds).load("csv", data, {
                        start : 1
                    });
                },
                error : function(xhr, status, error) {
                    var err = textStatus + ', ' + error;
                    alert("jQuery getJSON() Failed: " + err);
                }
            });
        };
        var checkColumn = function() {
            var col = grdMain.columnByName($('#selColumns')[0].value);
            if (col) {
                $('#chkColumns')[0].checked = col.visible();
                $('#txtColumnIndex').text(col.index());
                $('#edtColumnDisplayIndex')[0].value = col.displayIndex();
                grdMain.clearColumnTags();
                col.setTag('sel');
            }
        };
        var checkGroup = function() {
            var col = grdMain.columnByName($('#selGroups')[0].value);
            if (col) {
                $('#chkGroups')[0].checked = col.visible();
                $('#txtGroupIndex').text(col.index());
                $('#edtGroupDisplayIndex')[0].value = col.displayIndex();
            }
        };
        var $_fillSelect = function(id, values, labels) {
            if (values && values.length > 0) {
                var elt = document.getElementById(id);
                if (elt) {
                    for (var i = 0; i < values.length; i++) {
                        var opt = document.createElement("option");
                        opt.value = values[i];
                        opt.text = labels && labels.length > i ? (labels[i] || values[i]) : values[i];
                        elt.appendChild(opt);
                    }
                }
            }
        }

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
            "name" : "Country",
            "fieldName" : "country",
            "width" : "70",
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "CustomerId",
            "fieldName" : "customer_id",
            "width" : "90",
            "styles" : {},
            "header" : {
                "text" : "CustomerId"
            }
        }, {
            "name" : "CustomerGroup",
            "width" : 320,
            "layout" : "vertical",
            "header" : "CountryCustomer",
            "footer" : "CustomerGroup Footer",
            "columns" : [ {
                "name" : "Country2",
                "fieldName" : "country",
                "width" : "70",
                "styles" : {},
                "header" : {
                    "text" : "Country" + '_2'
                }
            }, {
                "name" : "ChildGroup",
                "layout" : "horizontal",
                "header" : "Customer",
                "columns" : [ {
                    "name" : "CustomerId2",
                    "fieldName" : "customer_id",
                    "width" : "90",
                    "styles" : {},
                    "header" : {
                        "text" : "CustomerId" + '_2'
                    }
                }, {
                    "name" : "CustomerName",
                    "fieldName" : "customer_name",
                    "width" : "90",
                    "styles" : {},
                    "header" : {
                        "text" : "CustomerName" + '_2'
                    }
                }, {
                    "name" : "Phone",
                    "fieldName" : "phone",
                    "width" : "100",
                    "styles" : {},
                    "header" : {
                        "text" : "Phone" + '_2'
                    }
                } ]
            } ]
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
            "name" : "DateGroup",
            "type" : "group",
            "width" : "200",
            "header" : "Dates",
            "columns" : [ {
                "name" : "OrderDate",
                "fieldName" : "order_date",
                "width" : "90",
                "styles" : {
                    datetimeFormat : "yyyy-MM-dd",
                    textAlignment : "center"
                },
                "header" : {
                    "text" : "OrderDate" + '_2'
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
                    "text" : "ShipDate" + '_2'
                }
            } ]
        }, {
            "name" : "HiddenGroup",
            "type" : "group",
            "width" : "200",
            "visible" : false,
            "columns" : [ {
                "name" : "OrderDate2",
                "fieldName" : "order_date",
                "width" : "90"
            }, {
                "name" : "ShipDate2",
                "fieldName" : "ship_date",
                "width" : "120"
            } ]
        } ]);

        grdMain.checkBar().setVisible(false);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        grdMain.loadStyles({
            header : {
                group : {
                    background : '#1066aaff'
                }
            },
            body : {
                cellDynamic : [ {
                    expression : "tag == 'sel'",
                    styles : {
                        background : '#1000ff88'
                    }
                } ]
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        loadColumns();
        loadData(dsMain);

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // grid events
        grdMain.onColumnMoved = function() {
            checkColumn();
            checkGroup();
        };

        // buttons
        $('#selColumns').change(function() {
            checkColumn();
        });
        $('#chkColumns').click(function() {
            var checked = document.getElementById('chkColumns').checked;
            var col = grdMain.columnByName($('#selColumns')[0].value);
            if (col) {
                col.setVisible(checked);
            }
        });
        $('#btnColumnDisplayIndex').click(function() {
            var col = grdMain.columnByName($('#selColumns')[0].value);
            if (col) {
                var i = $('#edtColumnDisplayIndex')[0].value;
                col.setDisplayIndex(i);
            }
        });
        $('#selGroups').change(function() {
            checkGroup();
        });
        $('#chkGroups').click(function() {
            var checked = document.getElementById('chkGroups').checked;
            var col = grdMain.columnByName($('#selGroups')[0].value);
            if (col) {
                col.setVisible(checked);
            }
        });
        $('#btnGroupDisplayIndex').click(function() {
            var col = grdMain.columnByName($('#selGroups')[0].value);
            if (col) {
                var i = $('#edtGroupDisplayIndex')[0].value;
                col.setDisplayIndex(i);
            }
        });
    });
</script>
</head>
<body>
    <h3>Column Visibility</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <select id="selColumns"></select>
        <input type="checkbox" id="chkColumns" checked="checked">visible,
        <span>index : </span>
        <span id="txtColumnIndex">0</span>
        <button id="btnColumnDisplayIndex">displayIndex</button>
        <input type="text" id="edtColumnDisplayIndex" value="0">
    </div>
    <div>
        <select id="selGroups"></select>
        <input type="checkbox" id="chkGroups" checked="checked">visible,
        <span>index : </span>
        <span id="txtGroupIndex">0</span>
        <button id="btnGroupDisplayIndex">displayIndex</button>
        <input type="text" id="edtGroupDisplayIndex" value="0">
    </div>
</body>
</html>