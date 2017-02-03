<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Image Button Cell Renderers</title>
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
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "InterestRate",
            "fieldName" : "interest_rate",
            "width" : "90",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "InterestRate"
            }
        }, {
            "name" : "ImageButton1",
            "fieldName" : "interest_rate",
            "width" : "90",
            "header" : {
                "text" : "ImageBtn1"
            },
            "renderer" : {
                "type" : "button",
                "imageUrl" : "assets/btn_normal.png",
                "hoveredImageUrl" : "assets/btn_hover.png",
                "hoveredText" : "hovered",
                "activeImageUrl" : "assets/btn_active.png",
                "disabledImageUrl" : "assets/btn_disabled.png",
                "disableHoveredImageUrl" : "assets/btn_disabled.png",
                "disableHoveredText" : "Disable_H",
                "disabledText" : "Disabled",
                "text" : "Button",
                "textVisible" : true,
                "enabledExpression" : "value > 4",
                "downOffset" : 1
            },
            "styles" : {
                "textAlignment" : "center",
                "color" : "#555555"
            }
        }, {
            "name" : "ImageButton2",
            "fieldName" : "interest_rate",
            "width" : "90",
            "header" : {
                "text" : "ImageBtn2"
            },
            "renderer" : {
                "type" : "button",
                "imageUrl" : "assets/btn_normal.png",
                "activeImageUrl" : "assets/btn_active.png",
                "disabledImageUrl" : "assets/btn_disabled.png",
                "textVisible" : true,
                "enabledExpression" : "value > 4",
                "downOffset" : 1
            },
            "styles" : {
                "textAlignment" : "center",
                "color" : "#555555"
            }
        }, {
            "name" : "ImageButton3",
            "fieldName" : "interest_rate",
            "width" : "90",
            "header" : {
                "text" : "ImageBtn3"
            },
            "renderer" : {
                "type" : "button",
                "imageUrl" : "assets/btn_normal.png",
                "activeImageUrl" : "assets/btn_active.png",
                "disabledImageUrl" : "assets/btn_disabled.png",
                "textVisible" : true,
                "enabledExpression" : "value > 4",
                "downOffset" : 1,
                "textPadding" : 10
            },
            "styles" : {
                "textAlignment" : "near"
            }
        }, {
            "name" : "ImageButton4",
            "fieldName" : "interest_rate",
            "width" : "90",
            "header" : {
                "text" : "ImageBtn4"
            },
            "renderer" : {
                "type" : "button",
                "imageUrl" : "assets/btn_normal.png",
                "activeImageUrl" : "assets/btn_active.png",
                "disabledImageUrl" : "assets/btn_disabled.png",
                "textVisible" : true,
                "enabledExpression" : "value < 5",
                "downOffset" : 1,
                "textPadding" : 10
            },
            "styles" : {
                "textAlignment" : "far"
            }
        } ]);

        //grid options
        grdMain.setOptions({
            checkBar : false,
            header : {
                height : 40,
                head : {
                    popupMenu : {
                        label : 'DataLudi Version',
                        callback : function() {
                            alert(DataLudi.getVersion());
                        }
                    }
                }
            },
            display : {
                rowHeight : 38,
                rowResizable : true
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

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };

        // grid events        
        grdMain.onDataButtonClicked = function(grid, index) {
            setTimeout(function() {
                alert(index.rowIndex + " 번째 줄 " + index.column.name() + " 컬럼 버튼 클릭");
            }, 0);
        };

        // buttons
        $('#btnSetText').click(function() {
            var col = grdMain.columnByName("ImageButton1");
            col.setRenderer({
                "hoveredText" : edtHoveredText.value,
                "disableHoveredText" : edtDisableHoverText.value,
                "disabledText" : edtDisableText.value,
                "text" : edtText.value,
            })
        });
        $('#btnSetExpression').click(function() {
            var col = grdMain.columnByName("ImageButton1");
            var exp = "value < " + edtExpression.value;
            col.setRenderer({
                "enabledExpression" : exp
            });
        });
        $('input:radio[name=rgpTextAlign]').click(function() {
            var value = $("input[name=rgpTextAlign]:checked").val();
            var col = grdMain.columnByName("ImageButton1");
            col.styles().setTextAlignment(value);
        });
        $('#chkTextVisible').click(function() {
            var checked = document.getElementById('chkTextVisible').checked;
            var col = grdMain.columnByName("ImageButton1");
            col.setRenderer({
                "textVisible" : checked
            });
        });
        $('#chktextOnImage').click(function() {
            var checked = document.getElementById('chktextOnImage').checked;
            var col = grdMain.columnByName("ImageButton3");
            col.setRenderer({
                "textOnImage" : checked
            });
        });
    });
</script>
</head>
<body>
    <h3>Image Button Cell Renderers</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <span>Text: </span>
        <input type="text" id="edtText" value="Button">
        <span>Hovered Text: </span>
        <input type="text" id="edtHoveredText" value="hovered">
        <span>Disabled Text: </span>
        <input type="text" id="edtDisableText" value="Disabled">
        <span>Disabled Hover Text: </span>
        <input type="text" id="edtDisableHoverText" value="Disable_H">
        <button id="btnSetText">Set Text</button>
    </div>
    <div>
        <span>Enabled Expression : value &lt;</span>
        <input type="text" id="edtExpression" value="6">
        <button id="btnSetExpression">Set Expression</button>
    </div>
    <div>
        <span>Button Text Alignment : </span>
        <input type="radio" name="rgpTextAlign" value="center" checked="checked">center
        <input type="radio" name="rgpTextAlign" value="near">near
        <input type="radio" name="rgpTextAlign" value="far">far
    </div>
    <div>
        <input type="checkbox" id="chkTextVisible" checked="checked">textVisible
    </div>
    <div>
        <input type="checkbox" id="chktextOnImage" checked="checked">textOnImage
    </div>
</body>
</html>