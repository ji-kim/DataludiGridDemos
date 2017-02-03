<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Grid Header</title>
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
            fieldName : "loan_number"
        }, {
            fieldName : "country"
        }, {
            fieldName : "interest_rate",
            dataType : "number"
        }, {
            fieldName : "currency"
        }, {
            fieldName : "project_id"
        }, {
            fieldName : "original_amount",
            dataType : "number"
        }, {
            fieldName : "cancelled_amount",
            dataType : "number"
        }, {
            fieldName : "disbursed_amount",
            dataType : "number"
        }, {
            fieldName : "repaid_amount",
            dataType : "number"
        }, {
            fieldName : "sold_amount",
            dataType : "number"
        }, {
            fieldName : "first_date",
            dataType : "datetime",
            datetimeFormat : "MM/dd/yyyy"
        }, {
            fieldName : "last_date",
            dataType : "datetime",
            datetimeFormat : "MM/dd/yyyy"
        } ]);

        // grid
        var columns = [ {
            "name" : "LoanNumber",
            "fieldName" : "loan_number",
            "width" : "120",
            "styles" : {
                textAlignment : "center"
            },
            "header" : {
                "text" : "LoanNumber"
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
            "name" : "InterestRate",
            "fieldName" : "interest_rate",
            "width" : "65",
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "InterestRate"
            }
        }, {
            "name" : "Currency",
            "fieldName" : "currency",
            "width" : "90",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Currency"
            }
        }, {
            "name" : "ProjectID",
            "fieldName" : "project_id",
            "width" : "90",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "ProjectID"
            }
        }, {
            "name" : "OriginalAmount",
            "fieldName" : "original_amount",
            "width" : 105,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "OriginalAmount"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "CancelledAmount",
            "fieldName" : "cancelled_amount",
            "width" : 100,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "CancelledAmount"
            }
        }, {
            "name" : "DisbursedAmount",
            "fieldName" : "disbursed_amount",
            "width" : 110,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "DisbursedAmount"
            }
        }, {
            "name" : "RepaidAmount",
            "fieldName" : "repaid_amount",
            "width" : 110,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "RepaidAmount"
            }
        }, {
            "name" : "SoldAmount",
            "fieldName" : "sold_amount",
            "width" : 110,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "SoldAmount"
            }
        }, {
            "name" : "FirstDate",
            "fieldName" : "first_date",
            "width" : "90",
            "styles" : {
                datetimeFormat : "yyyy-MM-dd",
                textAlignment : "center"
            },
            "header" : {
                "text" : "FirstDate"
            }
        }, {
            "name" : "LastDate",
            "fieldName" : "last_date",
            "width" : "90",
            "styles" : {
                datetimeFormat : "yyyy-MM-dd",
                textAlignment : "center"
            },
            "header" : {
                "text" : "LastDate"
            }
        } ];
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns(columns);

        //grid options
        grdMain.setOptions({
            checkBar : false,
            header : {
                resizable : true,
                imageList : 'images01',
                head : {
                    popupMenu : {
                        label : 'DataLudi Version',
                        callback : function() {
                            alert(DataLudi.getVersion());
                        }
                    }
                }
            },
            footer : false,
            vscrollBar : {
                barWidth : 12,
            },
            hscrollBar : {
                barWidth : 12
            }
        });

        // grid styles
        grdMain.loadStyles({
            grid : {
                border : "#0088ff"
            }
        });
        grdMain.registerImageList({
            name : "images01",
            rootUrl : "assets/flags_iso/",
            items : [ "ar.png", "at.png", "be.png", "br.png", "ca.png", "de.png", "dk.png", "et.png", "fi.png", "fr.png", "it.png", "jp.png", "kg.png" ]
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url : "data/loan_statement_small.csv",
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
                alert("jQuery getJSON() Failed: " + err);
            }
        });

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // grid events
        grdMain.onColumnChecked = function(grid, column, checked) {
            console.log('Column "' + column.name() + '" is ' + (checked ? 'checked' : 'unchecked'));
            column.styles().setBackground(checked ? '#200000ff' : '#ffffff');
        };

        // buttons
        $('#edtMinHeight')[0].value = grdMain.header().minHeight();
        $('#chkVisible').click(function() {
            var checked = document.getElementById('chkVisible').checked;
            grdMain.header().setVisible(checked);
        });
        $('#chkHeight').click(function() {
            var checked = document.getElementById('chkHeight').checked;
            if (checked) {
                view.btnHeight_click();
            } else {
                grdMain.header().setHeight(0);
            }
        });
        $('#btnHeight').click(function() {
            if (document.getElementById('chkHeight').checked) {
                grdMain.header().setHeight(document.getElementById('edtHeight').value);
            }
        });
        $('#btnMinHeight').click(function() {
            grdMain.header().setMinHeight(document.getElementById('edtMinHeight').value);
        });
        $('#chkMenuVisible').click(function() {
            var checked = document.getElementById('chkMenuVisible').checked;
            grdMain.header().head().setMenuVisible(checked);
        });
        $('#btnStyles1').click(function() {
            grdMain.loadStyles({
                header : {
                    background : '#100000ff',
                    selectedBackground : '#300000ff',
                    color : '#000088',
                    selectedColor : undefined,
                    fontBold : true,
                    head : {
                        shapeColor : '#800000ff',
                        shapeHoveredColor : '#ff000000ff'
                    }
                }
            });
        });
        $('#btnStyles2').click(function() {
            grdMain.loadStyles({
                header : {
                    background : '#fff',
                    selectedBackground : '#100000ff',
                    selectedColor : undefined,
                    color : '#000088',
                    fontBold : false,
                    head : {
                        shapeColor : '#800000ff',
                        shapeHoveredColor : '#ff000000ff'
                    }
                }
            });
        });
        $('#btnStyles3').click(function() {
            grdMain.loadStyles({
                header : {
                    background : '#c00088ff',
                    selectedBackground : '#c00000cc',
                    color : '#fff',
                    selectedColor : '#fff',
                    fontBold : false,
                    head : {
                        shapeColor : '#eee',
                        shapeHoveredColor : '#ff000000ff'
                    }
                }
            });
        });
    });
</script>
</head>
<body>
    <h3>Grid Header</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkVisible" checked="checked">Header Visible
    </div>
    <div>
        <input type="checkbox" id="chkHeight" checked="checked">Header Height
        <input type="text" id="edtHeight" value="30">
        <button id="btnHeight">높이 변경</button>
        <input type="text" id="edtMinHeight" value="0">
        <button id="btnMinHeight">최소 높이 변경</button>
    </div>
    <div>
        <input type="checkbox" id="chkMenuVisible" checked="checked">Head Menu Visible
    </div>
    <div>
        <button id="btnStyles1">Styles 1</button>
        <button id="btnStyles2">Styles 2</button>
        <button id="btnStyles3">Styles 3</button>
    </div>
</body>
</html>