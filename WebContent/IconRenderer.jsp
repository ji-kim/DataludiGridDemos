<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Icon Cell Renderers</title>
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
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "100",
            "imageList" : "images1",
            "renderer" : {
                "type" : "icon"
            },
            "styles" : {},
            "styleCallback" : function(index, styles) {
                styles.setIconIndex(iconMap[index.getValue()]);
            },
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "LoanNumber",
            "fieldName" : "loan_number",
            "width" : "100",
            "imageList" : "images1",
            "renderer" : {
                "type" : "icon"
            },
            "styles" : {
                "textAlignment" : "center",
                "iconIndex" : "fr.png",
                "iconLocation" : "leftSide"
            },
            "header" : {
                "text" : "LEFT_SIDE"
            }
        }, {
            "name" : "LoanNumber2",
            "fieldName" : "loan_number",
            "width" : "100",
            "imageList" : "images1",
            "renderer" : {
                "type" : "icon"
            },
            "styles" : {
                "textAlignment" : "center",
                "iconIndex" : 1,
                "iconLocation" : "rightSide"
            },
            "header" : {
                "text" : "RIGHT_SIDE"
            }
        }, {
            "name" : "LoanNumber3",
            "fieldName" : "loan_number",
            "width" : "100",
            "imageList" : "images1",
            "renderer" : {
                "type" : "icon"
            },
            "styles" : {
                "textAlignment" : "center",
                "iconIndex" : 2,
                "iconLocation" : "topSide"
            },
            "header" : {
                "text" : "TOP_SIDE"
            }
        }, {
            "name" : "LoanNumber4",
            "fieldName" : "loan_number",
            "width" : "100",
            "imageList" : "images1",
            "renderer" : {
                "type" : "icon"
            },
            "styles" : {
                "textAlignment" : "center",
                "iconIndex" : 3,
                "iconLocation" : "bottomSide"
            },
            "header" : {
                "text" : "BOTTOM_SIDE"
            }
        }, {
            "name" : "LoanNumber5",
            "fieldName" : "loan_number",
            "width" : "100",
            "imageList" : "images1",
            "renderer" : {
                "type" : "icon"
            },
            "styles" : {
                "textAlignment" : "center",
                "iconIndex" : 4,
                "iconLocation" : "left"
            },
            "header" : {
                "text" : "LEFT"
            }
        }, {
            "name" : "LoanNumber6",
            "fieldName" : "loan_number",
            "width" : "100",
            "imageList" : "images1",
            "renderer" : {
                "type" : "icon"
            },
            "styles" : {
                "textAlignment" : "center",
                "iconIndex" : 5,
                "iconLocation" : "right"
            },
            "header" : {
                "text" : "RIGHT"
            }
        }, {
            "name" : "LoanNumber7",
            "fieldName" : "loan_number",
            "width" : "100",
            "imageList" : "images1",
            "renderer" : {
                "type" : "icon"
            },
            "styles" : {
                "textAlignment" : "center",
                "iconIndex" : 6,
                "iconLocation" : "top"
            },
            "header" : {
                "text" : "TOP"
            }
        }, {
            "name" : "LoanNumber8",
            "fieldName" : "loan_number",
            "width" : "100",
            "imageList" : "images1",
            "renderer" : {
                "type" : "icon"
            },
            "styles" : {
                "textAlignment" : "center",
                "iconIndex" : 7,
                "iconLocation" : "bottom"
            },
            "header" : {
                "text" : "BOTTOM"
            }
        }, {
            "name" : "LoanNumber9",
            "fieldName" : "loan_number",
            "width" : "100",
            "imageList" : "images1",
            "renderer" : {
                "type" : "icon"
            },
            "styles" : {
                "textAlignment" : "center",
                "iconIndex" : 8,
                "iconLocation" : "center"
            },
            "header" : {
                "text" : "CENTER"
            }
        }, {
            "name" : "LoanNumber10",
            "fieldName" : "loan_number",
            "width" : "100",
            "imageList" : "images1",
            "renderer" : {
                "type" : "icon"
            },
            "styles" : {
                "textAlignment" : "center",
                "iconIndex" : 9,
                "iconLocation" : "centerBack",
                "iconAlpha" : 0.4
            },
            "header" : {
                "text" : "CENTER_BACK"
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
        grdMain.checkBar().setVisible(false);
        grdMain.header().setHeight(40);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });
        grdMain.setDisplayOptions({
            rowHeight : 45,
            rowResizable : true
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

        // images
        var iconMap = {
            'Algeria' : 'dz.png',
            'Brazil' : 'br.png',
            'Chile' : 'cl.png',
            'Denmark' : 'dk.png',
            'France' : 'fr.png',
            'Luxembourg' : 'lu.png',
            'Mexico' : 'mx.png',
            'Netherlands' : 'al.png',
            'Netherlands2' : 'nl.png'
        };
        grdMain.registerImageList({
            name : "images1",
            root : "assets/flags_iso/",
            items : [ "al.png", "ar.png", "at.png", "be.png", "br.png", "ca.png", "cl.png", "dk.png", "fi.png", "fr.png", "de.png", "ie.png", "it.png", "mx.png", "no.png", "pl.png", "pt.png",
                    "es.png", "se.png", "ch.png", "gb.png", "us.png", "ve.png", "lu.png" ]
        });

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // buttons
        $('#btnIconAlpha').click(function() {
            var col = grdMain.columnByName('Country');
            var delta = -0.05;
            setInterval(function() {
                var a = col.styles().iconAlpha();
                if (a <= 0) {
                    a = 0;
                    delta = 0.05;
                } else if (a >= 1) {
                    a = 1;
                    delta = -0.05;
                }
                col.styles().setIconAlpha(Math.max(0, Math.min(1, a + delta)));
            }, 50);
        });
    });
</script>
</head>
<body>
    <h3>Icon Cell Renderers</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <button id="btnIconAlpha">iconAlpha 테스트</button>
</body>
</html>