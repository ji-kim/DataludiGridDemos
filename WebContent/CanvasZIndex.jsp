<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Canvas Z Index</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-report.min.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var dsMain;
        var grdMain;
        var printOptions = {
            previewUrl: "previewer.html",
            paperWidth: 720,
            paperHeight: 290
        };            
        var items = [{
            text: "label (left:5mm, top:5mm, zindex:0)",
            left: "5mm",
            top: "5mm",
            zindex: 0,
            styles: {
                background: "#fff"
            }
        }, {
            text: "label (left:10mm, top:10mm, zindex:1)",
            left: "10mm",
            top: "10mm",
            zindex: 1,
            styles: {
                background: "#eee"
            }
        }, {
            text: "label (left:15mm, top:15mm, zindex:2)",
            left: "15mm",
            top: "15mm",
            zindex: 2,
            styles: {
                background: "#ddd"
            }
        }, {
            text: "label (left:20mm, top:20mm, zindex:3)",
            left: "20mm",
            top: "20mm",
            zindex: 3,
            styles: {
                background: "#ccc"
            }
        }, {
            text: "label (left:25mm, top:25mm, zindex:4)",
            left: "25mm",
            top: "25mm",
            zindex: 4,
            styles: {
                background: "#aaa",
                color: "#fff"
            }
        }];
        var items2 = [{
            text: "label (left:5mm, top:5mm, zindex:4)",
            left: "5mm",
            top: "5mm",
            zindex: 4,
            styles: {
                background: "#fff"
            }
        }, {
            text: "label (left:10mm, top:10mm, zindex:3)",
            left: "10mm",
            top: "10mm",
            zindex: 3,
            styles: {
                background: "#eee"
            }
        }, {
            text: "label (left:15mm, top:15mm, zindex:2)",
            left: "15mm",
            top: "15mm",
            zindex: 2,
            styles: {
                background: "#ddd"
            }
        }, {
            text: "label (left:20mm, top:20mm, zindex:1)",
            left: "20mm",
            top: "20mm",
            zindex: 1,
            styles: {
                background: "#ccc"
            }
        }, {
            text: "label (left:25mm, top:25mm, zindex:0)",
            left: "25mm",
            top: "25mm",
            zindex: 0,
            styles: {
                background: "#aaa",
                color: "#fff"
            }
        }];
        var report = {
            reportHeader: {
                height: 176,
                styles: {
                    border: "#aaa",
                    background: "#10aaaaaa"
                },
                items: [{
                    type: "canvas",
                    left: 10,
                    right: 10,
                    top: 10,
                    bottom: 10,
                    styles: {
                        border: "#aaa",
                        background: "#10aaaaaa"
                    },
                    itemStyles: {
                        background: "#fff",
                        padding: 4,
                        border: "#333"
                    },
                    items: items
                }]
            },
            grid: {
                print: {
                    visible: false
                }
            }
        };
        
        // dataset
        grdMain = DataLudi.createGridView('container', [{ width: 100 }], false);
        grdMain.footer().setVisible(false);
        grdMain.checkBar().setVisible(false);
        grdMain.header().head().setPopupMenu([{
            label: 'DataLudi Grid Version',
            callback: function () { alert(DataLudi.getVersion()); }
        },{
            label: 'DataLudi Report Version',
            callback: function () { alert(DLReport.getVersion()); }
        }]);
        
        // button
        $('#btnPrint').click(function () {
            DLReport.preview(grdMain, report, null, printOptions, $('#chkPrint').is(':checked'));
        });
    });
</script>
</head>
<body>
	<div>
	   <button id="btnPrint">Print</button>
	   <input type="checkbox" id="chkPrint" checked="checked">바로 출력 (Check하면 현재 크롬에서 출력 미리보기 창이 바로 열립니다.)
	</div>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px;"></div>
</body>
</html>