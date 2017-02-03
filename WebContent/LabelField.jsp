<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Label Field</title>
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
            datetimeFormat : "yyyy-MM-dd"
        }, {
            fieldName : "ship_date",
            dataType : "datetime",
            datetimeFormat : "iso"
        }, {
            fieldName : "country_currency"
        } ]);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name" : "ProductName",
            "fieldName" : "product_name",
            "width" : 120,
            "styles" : {},
            "header" : {
                "text" : "ProductName"
            }
        }, {
            "name" : "Country",
            "fieldName" : "country",
            "width" : 90,
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "Currency",
            "fieldName" : "currency",
            "width" : 60,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Currency"
            }
        }, {
            "name" : "CountryCurrency",
            "fieldName" : "currency",
            "lookupDisplay" : true,
            "labelField" : "country_currency",
            "width" : 130,
            "styles" : {
                "background" : "#100088ff"
            },
            "header" : {
                "text" : "CountryCurrency"
            }
        }, {
            "name" : "UnitPrice",
            "fieldName" : "unit_price",
            "width" : 70,
            "styles" : {
                "numberFormat" : "#,##0.00",
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "UnitPrice"
            }
        }, {
            "name" : "Quantity",
            "fieldName" : "quantity",
            "width" : 70,
            "styles" : {
                "numberFormat" : "#,##0.00",
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "Quantity"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "CountryCurrencyOrg",
            "fieldName" : "country_currency",
            "lookupDisplay" : true,
            "width" : 130,
            "styles" : {
                "background" : "#f8f8f8"
            },
            "header" : {
                "text" : "country_currency"
            }
        } ]);

        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.rowIndicator().setStateVisible(true);
        grdMain.footer().setVisible(true);
        grdMain.autoFill().setEnabled(true);

        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
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
                var rowCount = dsMain.rowCount();

                /* set country_currency field values */
                var f1 = dsMain.getFieldIndex('country');
                var f2 = dsMain.getFieldIndex('currency');
                var f3 = dsMain.getFieldIndex('country_currency');

                dsMain.beginUpdate();
                dsMain.setCheckStates(false);
                for (var r = 0; r < rowCount; r++) {
                    dsMain.setValue(r, f3, dsMain.getValue(r, f1) + "_" + dsMain.getValue(r, f2));
                }
                dsMain.setCheckStates(true);
                dsMain.endUpdate();
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
        dsMain.onRowUpdated = function(ds, row) {
            ds.setValue(row, 'country_currency', ds.getValue(row, 'country') + '_' + ds.getValue(row, 'currency'));
        };
        dsMain.onRowInserted = function(ds, row) {
            ds.setValue(row, 'country_currency', ds.getValue(row, 'country') + '_' + ds.getValue(row, 'currency'));
        };
        grdMain.onEditCellUpdated = function(grid, row, fieldIndex, newValue, oldValue) {
            var f1 = dsMain.getFieldIndex('country');
            var f2 = dsMain.getFieldIndex('currency');
            if (fieldIndex == f1 || fieldIndex == f2) {
                row.setValue(dsMain.getFieldIndex('country_currency'), row.getValue(f1) + '_' + row.getValue(f2));
            }
        };
    });
</script>
</head>
<body>
    <h3>Label Field</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>