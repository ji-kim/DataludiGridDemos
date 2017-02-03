<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Row Deleting</title>
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

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName : "country"
        }, {
            fieldName : "year",
            dataType : "number"
        }, {
            fieldName : "comm_code"
        }, {
            fieldName : "commodity"
        }, {
            fieldName : "flow"
        }, {
            fieldName : "trade",
            dataType : "number"
        }, {
            fieldName : "weight",
            dataType : "number"
        }, {
            fieldName : "unit"
        } ]);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "70",
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "CommCode",
            "fieldName" : "comm_code",
            "width" : "90",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "CommCode"
            }
        }, {
            "name" : "Commodity",
            "fieldName" : "commodity",
            "width" : "200",
            "styles" : {},
            "header" : {
                "text" : "Commodity"
            }
        }, {
            "name" : "Year",
            "fieldName" : "year",
            "width" : "60",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Year"
            }
        }, {
            "name" : "Flow",
            "fieldName" : "flow",
            "width" : 60,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Flow"
            }
        }, {
            "name" : "Trade",
            "fieldName" : "trade",
            "width" : 60,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0"
            },
            "header" : {
                "text" : "Trade"
            },
            "groupFooter" : {
                "expression" : "sum",
                "styles" : {
                    "textAlignment" : "far",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "Weight",
            "fieldName" : "weight",
            "width" : 70,
            "styles" : {
                "textAlignment" : "far",
                "numberFormat" : "#,##0"
            },
            "header" : {
                "text" : "Weight"
            },
            "groupFooter" : {
                "expression" : "sum",
                "styles" : {
                    "textAlignment" : "far",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "Unit",
            "fieldName" : "unit",
            "width" : 120,
            "styles" : {},
            "header" : {
                "text" : "Unit"
            }
        } ]);

        //grid options
        grdMain.setEditOptions({
            deletable : true,
            insertable : true,
            appendable : true
        })
        grdMain.rowIndicator().setStateVisible(true);

        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        // grid styles
        grdMain.loadStyles({
            body : {
                cellDynamic : {
                    expression : "state == 'd' || state == 'x'",
                    styles : {
                        textDecoration : "lineThrough"
                    }
                }
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url : "data/un_comtrade_of_goods_ss.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1,
                    quoted : true,
                    currency : true
                });
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
        grdMain.onDeleting = function(grid, rowIndices) {
            if ($('#chkEventDeletable').is(':checked')) {
                return false;
            }
        };

        // buttons
        $('#chkDeletable').click(function() {
            var checked = $('#chkDeletable').is(':checked');
            grdMain.editOptions().setDeletable(checked);
        });
        $('#chkConfirm').click(function() {
            var checked = $('#chkConfirm').is(':checked');
            grdMain.editOptions().setConfirmWhenDelete(checked);
        });
        $('#btnMessage').click(function() {
            grdMain.editOptions().setDeleteMessage(document.getElementById('edtMessage').value);
        });
        $('#chkSoftDelete').click(function() {
            var checked = $('#chkSoftDelete').is(':checked');
            dsMain.setSoftDelete(checked);
        });
        $('#chkDeleteCreated').click(function() {
            var checked = $('#chkDeleteCreated').is(':checked');
            dsMain.setDeleteCreated(checked);
        });
        $('#chkHideDeletedRows').click(function() {
            var checked = $('#chkHideDeletedRows').is(':checked');
            grdMain.displayOptions().setHideDeletedRows(checked);
        });
    });
</script>
</head>
<body>
    <h3>Row Deleting</h3>
    <div>
        <input type="checkbox" id="chkDeletable" checked="checked">Rows Deletable
        <input type="checkbox" id="chkConfirm" checked="checked">Confirm When Delete
    </div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkEventDeletable">Not Deletable in Event
    </div>
    <div>
        <button id="btnMessage">Set</button>
        <input type="text" id="edtMessage" style="width: 500px;">
    </div>
    <div>
        <input type="checkbox" id="chkSoftDelete">softDelete
        <input type="checkbox" id="chkDeleteCreated">deleteCreated
        <input type="checkbox" id="chkHideDeletedRows">hideDeletedRows
    </div>
</body>
</html>