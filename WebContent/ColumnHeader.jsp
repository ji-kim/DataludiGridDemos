<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Column Header</title>
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
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name" : "LoanNumber",
            "fieldName" : "loan_number",
            "width" : 120,
            "styles" : {
                textAlignment : "center"
            },
            "header" : {
                "text" : "LoanNumber",
                "checkLocation" : DataLudi.HeaderItemLocation.LEFT,
                "itemGap" : 4
            }
        }, {
            "name" : "Country",
            "fieldName" : "country",
            "width" : 100,
            "styles" : {},
            "header" : {
                "text" : "Country",
                "imageUrl" : "assets/flags_iso/de.png",
                "imageLocation" : "right",
                "imageOffset" : 2
            }
        }, {
            "name" : "InterestRate",
            "fieldName" : "interest_rate",
            "width" : 100,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "InterestRate",
                "subText" : "(%)",
                "subTextLocation" : "right",
                "subTextGap" : 0,
                "subStyles" : {
                    "color" : "#f00",
                    "fontSize" : 9
                }
            }
        }, {
            "name" : "Currency",
            "fieldName" : "currency",
            "width" : 90,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Currency",
                "imageIndex" : 1,
                "imageLocation" : "left",
                "imageOffset" : 1
            }
        }, {
            "name" : "ProjectID",
            "fieldName" : "project_id",
            "width" : 90,
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "ProjectID",
                "sortHandleVisibility" : "hidden",
                "popupMenu" : [ {
                    "label" : "Sort Ascending",
                    "callback" : function() {
                        grdMain.orderByFields([ 'project_id' ]);
                    }
                }, {
                    "label" : "Sort Descending",
                    "callback" : function() {
                        grdMain.orderByFields([ 'project_id' ], [ DataLudi.SortDirection.DESCENDING ]);
                    }
                } ]
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
            "width" : 90,
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
            "width" : 90,
            "styles" : {
                datetimeFormat : "yyyy-MM-dd",
                textAlignment : "center"
            },
            "header" : {
                "text" : "LastDate"
            }
        } ]);

        //grid options
        grdMain.setOptions({
            checkBar : false,
            header : {
                height : 40,
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
            }
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

        // grid image
        grdMain.registerImageList({
            name : "images01",
            rootUrl : "assets/flags_iso/",
            items : [ "ar.png", "at.png", "be.png", "br.png", "ca.png", "de.png", "dk.png", "et.png", "fi.png", "fr.png", "it.png", "jp.png", "kg.png" ]
        });

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        grdMain.onColumnChecked = function(grid, column, checked) {
            console.log('Column "' + column.name() + '" is ' + (checked ? 'checked' : 'unchecked'));
            column.styles().setBackground(checked ? '#200000ff' : '#ffffff');
        };

        // buttons
        $('#selCheckLocation').change(function() {
            var col = grdMain.columnByName('LoanNumber');
            col.header().setCheckLocation($('#selCheckLocation option:selected').val());
        });
        $('#chkChecked').click(function() {
            var col = grdMain.columnByName('LoanNumber');
            col.setChecked(document.getElementById('chkChecked').checked);
        });
        $('#selImageLocation').change(function() {
            var col = grdMain.columnByName('Country');
            col.header().setImageLocation($('#selImageLocation option:selected').val());
        });
        $('#selSubTextLocation').click(function() {
            var col = grdMain.columnByName('InterestRate');
            col.header().setSubTextLocation($('#selSubTextLocation option:selected').val());
        });

        $('#selImageIndex').change(function(ev) {
            var col = grdMain.columnByName('Currency');
            col.header().setImageIndex($('#selImageIndex option:selected').val());
        });
        $('#btnIncGap').click(function() {
            var col = grdMain.columnByName('InterestRate');
            col.header().setSubTextGap(col.header().subTextGap() + 2);
        });
        $('#btnDecGap').click(function() {
            var col = grdMain.columnByName('InterestRate');
            col.header().setSubTextGap(col.header().subTextGap() - 2);
        });
        $('#chkPopupMenu').click(function() {
            var col = grdMain.columnByName('ProjectID');
            col.header().setPopupMenu(document.getElementById('chkPopupMenu').checked ? [ {
                "label" : "Sort Ascending",
                "callback" : function() {
                    grdMain.orderByFields([ 'project_id' ]);
                }
            }, {
                "label" : "Sort Descending",
                "callback" : function() {
                    grdMain.orderByFields([ 'project_id' ], [ DataLudi.SortDirection.DESCENDING ]);
                }
            } ] : null)
        });
    });
</script>
</head>
<body>
    <h3>Column Header</h3>
    <div id="container"
        style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <p>
    <div>
        <span>Check Location : </span> <select id="selCheckLocation">
            <option value="none">HeaderItemLocation.NONE</option>
            <option value="left" selected='selected'>HeaderItemLocation.LEFT</option>
            <option value="right">HeaderItemLocation.RIGHT</option>
            <option value="top">HeaderItemLocation.TOP</option>
            <option value="bottom">HeaderItemLocation.BOTTOM</option>
            <option value="leftSide">HeaderItemLocation.LEFT_SIDE</option>
            <option value="rightSide">HeaderItemLocation.RIGHT_SIDE</option>
            <option value="topSide">HeaderItemLocation.TOP_SIDE</option>
            <option value="bottomSide">HeaderItemLocation.BOTTOM_SIDE</option>
            <option value="center">HeaderItemLocation.CENTER</option>
        </select> <input type="checkbox" id="chkChecked">checked
    </div>
    <div>
        <span>Image Location:</span> <select id="selImageLocation">
            <option value="none">HeaderItemLocation.NONE</option>
            <option value="left">HeaderItemLocation.LEFT</option>
            <option value="right" selected="selected">HeaderItemLocation.RIGHT</option>
            <option value="top">HeaderItemLocation.TOP</option>
            <option value="bottom">HeaderItemLocation.BOTTOM</option>
            <option value="leftSide">HeaderItemLocation.LEFT_SIDE</option>
            <option value="rightSide">HeaderItemLocation.RIGHT_SIDE</option>
            <option value="topSide">HeaderItemLocation.TOP_SIDE</option>
            <option value="bottomSide">HeaderItemLocation.BOTTOM_SIDE</option>
            <option value="center">HeaderItemLocation.CENTER</option>
        </select>
    </div>
    <div>
        <span>SubText Location: </span> <select id="selSubTextLocation">
            <option value="none">HeaderItemLocation.NONE</option>
            <option value="left">HeaderItemLocation.LEFT</option>
            <option value="right" selected="selected">HeaderItemLocation.RIGHT</option>
            <option value="top">HeaderItemLocation.TOP</option>
            <option value="bottom">HeaderItemLocation.BOTTOM</option>
        </select>
        <button id="btnIncGap">Inc Gap</button>
        <button id="btnDecGap">Dec Gap</button>
    </div>
    <div>
        <span>Image Index:</span> <select id="selImageIndex">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
            <option value="9">9</option>
            <option value="10">10</option>
        </select>
    </div>
    <div>
        <input type="checkbox" id="chkPopupMenu" checked="checked">Popup Menu
    </div>
</body>
</html>