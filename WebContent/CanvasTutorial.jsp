<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Canvas Tutorial</title>
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
                    items: [{
                        type: "hbox",
                        left: "5mm",
                        top: "2mm",
                        styles: {
                            line: "#800000ff,1px,dashed"  
                        },
                        itemStyles: {
                            paddingLeft: 10,
                            paddingRight: 10,
                            background: "#1000ff88"
                        },
                        items: [{
                            text: "hbox"
                        }, {
                            text: "(left: 5mm, "
                        }, {
                            text: "top: 5mm)"
                        }]
                    }, {
                        left: "5mm",
                        bottom: "2mm",
                        text: "label (left: 5mm, bottom: 5mm)",
                        styles: {
                            fontSize: 16
                        }
                    }, {
                        text: "label (no layout)",
                        styles: {
                        }
                    }, {
                        text: "label (left: 2mm, right: 2mm, top: 10mm)",
                        left: "2mm",
                        right: "2mm",
                        top: "9mm",
                        styles: {
                            fontSize: 8,
                            padding: 1,
                            border: "#888,1px,dotted"
                        }
                    }, {
                        type: "vbox",
                        right: "5mm",
                        top: "2mm",
                        bottom: "2mm",
                        styles: {
                            background: "#50ffff00",
                            line: "#80ff0000,1px,dashaed"
                        },
                        items: [{
                            text: "vbox"
                        }, {
                            text: "right: 5mm"
                        }, {
                            text: "top: 2mm"
                        }, {
                            text: "bottom: 2mm"
                        }]
                    }]
                }]
            },
            page: {
                styles: {
                }
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
    
       // _isIE && grdMain.updateNow();
        
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