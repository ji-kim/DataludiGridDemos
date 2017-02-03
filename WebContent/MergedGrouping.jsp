<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Merged Row Grouping</title>
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
            "width" : "70",
            "styles" : {},
            "header" : {
                "text" : "Commodity"
            }
        }, {
            "name" : "Year",
            "fieldName" : "year",
            "width" : "65",
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
            "width" : 100,
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
            "width" : 110,
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
            "width" : 110,
            "styles" : {},
            "header" : {
                "text" : "Unit"
            }
        } ]);

        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.header().setHeight(30);
        grdMain.footer().setVisible(false);
        grdMain.groupPanel().setVisible(true);
        grdMain.rowGroup().setDisplayMode(DataLudi.RowGroupDisplayMode.MERGED);
        grdMain.groupBy([ 'country', 'comm_code' ])
        grdMain.operateOptions().setGroupingToast(true);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url : "data/un_comtrade_of_goods_s.csv",
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

        // buttons
        $('#chkMerged').click(function() {
            grdMain.showToast('Grouping', false, function() {
                grdMain.rowGroup().setDisplayMode($('#chkMerged').is(":checked") ? DataLudi.RowGroupDisplayMode.MERGED : DataLudi.RowGroupDisplayMode.BANDED);
            });
        });
        $('input:radio[name=rgpExpandedAdornments]').click(function() {
            var value = $("input[name=rgpExpandedAdornments]:checked").val();
            grdMain.rowGroup().setExpandedAdornments(value);
        });
        $('input:radio[name=rgpCollapsedAdornments]').click(function() {
            var value = $("input[name=rgpCollapsedAdornments]:checked").val();
            grdMain.rowGroup().setCollapsedAdornments(value);
        });
        $('#btnExport').click(function() {
            new DataLudi.GridExcelExporter().export(grdMain, {
                target : "local",
                fileName : "dlgrid.xlsx",
                numberFormat : "#,##0.00",
                datetimeFormat : "yyyy.mm.dd"
            });
        });
    });
</script>
</head>
<body>
    <h3>Merged Row Grouping</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <input type="checkbox" id="chkMerged" checked="checked">병합 모드
    <div>
        <span>RowGroup.expandedAdornments : </span>
        <input type="radio" name="rgpExpandedAdornments" value="both" checked="checked">RowGroupAdornments.BOTH
        <input type="radio" name="rgpExpandedAdornments" value="header">HEADER
        <input type="radio" name="rgpExpandedAdornments" value="footer">FOOTER
        <input type="radio" name="rgpExpandedAdornments" value="none">NONE
    </div>
    <div>
        <span>RowGroup.collapsedAdornments : </span>
        <input type="radio" name="rgpCollapsedAdornments" value="both">RowGroupAdornments.BOTH
        <input type="radio" name="rgpCollapsedAdornments" value="header" checked="checked">HEADER
        <input type="radio" name="rgpCollapsedAdornments" value="footer">FOOTER
    </div>
    <button id="btnExport">Export</button>
</body>
</html>