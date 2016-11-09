<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ScrollBar</title>
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
            "width" : "70",
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
            "width" : "70",
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
        } ]);

        //grid options
        grdMain.setOptions({
            rowIndicator: {
                stateVisible: false
            },
            header: {
                head: {
                    popupMenu: {
                        label: 'DataLudi Grid Version',
                        callback: function () { alert(DataLudi.getVersion()); }
                    }
                }
            },
            footer: {
                visible: false
            },
            autoFill: true,
            display: {
                rowHoverMask: true,
                fixedColumnCount: 1,
                fixedRowCount: 1
            },
            vscrollBar: {
                visible: true,
                barWidth: 12,
                barIndent: "header",
                styles: {
                    background: "#10000000"
                }
            },
            hscrollBar: {
                visible: true,
                barWidth: 12
            }
        });

        // grid style
        grdMain.loadStyles({
            grid: {
                border: "#ccc"
            },
            header: {
                background: "#fff",
                selectedBackground: "#fff",
                selectedColor: "#f00",
                borderRight: null,
                borderBottom: "#ddd"
            },
            rowIndicator: {
                background: "#10aaaaaa",
                selectedBackground: "#10555555",
                borderTop: null,
                borderLeft: null,
                borderRight: "#ddd",
                borderBottom: "#ddd"
            },
            checkBar: {
                borderRight: null,
                borderBottom: "#ddd",
                shapeName: "rectangle",
                shapeColor: "#f00",
                head: {
                    shapeName: "rectangle",
                    shapeColor: "#f00",
                }
            },
            body: {
                cell: {
                    paddingTop: 9,
                    paddingBottom: 9,
                    paddingLeft: 8,
                    paddingRight: 8,
                    borderRight: null,
                    borderBottom: null
                },
                row: {
                    borderBottom: "#ddd"  
                },
                rowDynamic: [{
                    expression: "row % 2",
                    styles: {
                        background: "#10cccccc"
                    }
                }],
                rowHover: {
                    background: "#1000cc00"
                },
                focus: {
                    border: "#f00"
                }
            },
            scrollBar: {
                background: "#1a000000",
                thumb: {
                    background: "#77000000",
                    hoveredBackground: "#cc000000"
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
                $("#rowCount").css("color", "blue").text(ds.rowCount().toLocaleString());
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
        $('input:radio[name=rgpVertBarWidth]').click(function() {
            var value = $("input[name=rgpVertBarWidth]:checked").val();
            grdMain.vscrollBar().setBarWidth(parseInt(value));
        });
        $('input:radio[name=rgpHorzBarWidth]').click(function() {
            var value = $("input[name=rgpHorzBarWidth]:checked").val();
            grdMain.hscrollBar().setBarWidth(parseInt(value));
        });
        $('input:radio[name=rgpVertBarIndent]').click(function() {
            var value = $("input[name=rgpVertBarIndent]:checked").val();
            grdMain.vscrollBar().setBarIndent(value);
        });
        $('input:radio[name=rgpHorzBarIndent]').click(function() {
            var value = $("input[name=rgpHorzBarIndent]:checked").val();
            grdMain.hscrollBar().setBarIndent(value);
        });
        $('input:radio[name=rgpVertButtonLocation]').click(function() {
            var value = $("input[name=rgpVertButtonLocation]:checked").val();
            grdMain.vscrollBar().setButtonLocation(value);
        });
        $('input:radio[name=rgpHorzButtonLocation]').click(function() {
            var value = $("input[name=rgpHorzButtonLocation]:checked").val();
            grdMain.hscrollBar().setButtonLocation(value);
        });
        $('#btnSetStyles1').click(function() {
            grdMain.loadStyles({
                scrollBar : {
                    background : "#100000ff",
                    button : {
                        shapeColor : "#0000ff",
                        shapeSelectedColor : "#000088"
                    },
                    thumb : {
                        background : "#300000ff",
                        hoveredBackground : "#800000ff",
                        selectedBackground : "#600000ff"
                    }
                },
                scrollEdge : {
                    background : "#300000ff"
                }
            });
        });
        $('#btnSetStyles2').click(function() {
            grdMain.loadStyles({
                scrollBar : {
                    background : "#10ff0000",
                    button : {
                        shapeColor : "#ff0000",
                        shapeSelectedColor : "#880000"
                    },
                    thumb : {
                        background : "#30ff0000",
                        hoveredBackground : "#80ff0000",
                        selectedBackground : "#60ff0000"
                    }
                },
                scrollEdge : {
                    background : "#30ff0000"
                }
            });
        });
    });
</script>
</head>
<body>
    <h3>ScrollBar</h3>
    <div id="container"
        style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="radio" name="rgpVertBarWidth" value="16">16
        <input type="radio" name="rgpVertBarWidth" value="14">14
        <input type="radio" name="rgpVertBarWidth" value="12" checked="checked">12
        <input type="radio" name="rgpVertBarWidth" value="10">10
        <input type="radio" name="rgpVertBarWidth" value="8">8
    </div>
    <div>
        <input type="radio" name="rgpHorzBarWidth" value="16">16
        <input type="radio" name="rgpHorzBarWidth" value="14">14
        <input type="radio" name="rgpHorzBarWidth" value="12" checked="checked">12
        <input type="radio" name="rgpHorzBarWidth" value="10">10
        <input type="radio" name="rgpHorzBarWidth" value="8">8
    </div>
    <div>
        <input type="radio" name="rgpVertBarIndent" value="none">ScrollBarIndent.NONE
        <input type="radio" name="rgpVertBarIndent" value="header" checked="checked">HEADER
        <input type="radio" name="rgpVertBarIndent" value="fixed">FIXED
    </div>
    <div>
        <input type="radio" name="rgpHorzBarIndent" value="none" checked="checked">ScrollBarIndent.NONE
        <input type="radio" name="rgpHorzBarIndent" value="header">HEADER
        <input type="radio" name="rgpHorzBarIndent" value="fixed">FIXED
    </div>
    <div>
        <input type="radio" name="rgpVertButtonLocation" value="normal" checked="checked">ScrollButtonLocation.NORMAL
        <input type="radio" name="rgpVertButtonLocation" value="near">NEAR
        <input type="radio" name="rgpVertButtonLocation" value="far">FAR
        <input type="radio" name="rgpVertButtonLocation" value="hidden">HIDDEN
    </div>
    <div>
        <input type="radio" name="rgpHorzButtonLocation" value="normal">ScrollButtonLocation.NORMAL
        <input type="radio" name="rgpHorzButtonLocation" value="near">NEAR
        <input type="radio" name="rgpHorzButtonLocation" value="far">FAR
        <input type="radio" name="rgpHorzButtonLocation" value="hidden">HIDDEN
    </div>
    <div>
        <button id="btnSetStyles1">스타일1</button>
        <button id="btnSetStyles2">스타일2</button>
    </div>
</body>
</html>