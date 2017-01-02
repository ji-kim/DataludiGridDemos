<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>VBox Tutorial</title>
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
            paperHeight: 340
        };            
        var report = {
            reportHeader: {
                height: 225,
                styles: {
                    border: "#aaa",
                    background: "#10aaaaaa"
                },
                items: [{
                    type: "vbox",
                    left: "4mm",
                    top: "4mm",
                    styles: {
                        border: "#777",
                        line: "#80000000"
                    },
                    itemStyles: {
                        border: "#aaa",
                        margin: 4,
                        padding: 4,
                        background: "#fff"
                    },
                    items: [{
                        text: "vbox (left: 4mm, top: 4mm)"
                    }, {
                        text: "label item 1\n(left:0, right:0)",
                        left: 0,
                        right: 0
                    }, {
                        text: "label item 2"
                    }, {
                        text: "label 3 (width: 90%)",
                        width: "90%"
                    }]
                }, {
                    type: "vbox",
                    left: "56mm",
                    top: "5mm",
                    bottom: "5mm",
                    width: "50mm",
                    styles: {
                        border: "#800000ff,1px,dashed",
                        line: "#800000ff,1px,dashed"
                    }, 
                    itemStyles: {
                        border: "#60000000",
                        margin: 4,
                        padding: 4,
                        background: "#fff"  
                    },
                    items: [{
                        text: "vbox"
                    }, {
                        type: "image",
                        text: "image",
                        url: "/repo/grid/resource/images/dataludi64.png",
                        imageWidth: 64,
                        imageHeight: 64,
                        styles: {
                            padding: 4
                        }
                    }, {
                        text: "label",
                        styles: {
                            shapeName: "start"
                        }
                    }]
                }, {
                    type: "vbox",
                    left: "113mm",
                    top: "2mm",
                    bottom: "2mm",
                    styles: {
                        border: "#777",
                        line: "#80000000"
                    },
                    itemStyles: {
                        border: "#aaa",
                        margin: 4,
                        padding: 4,
                        background: "#fff"
                    },
                    items: [{
                        text: "vbox (left: 110mm, top: 2mm,\r bottom: 2mm)"
                    }, {
                        text: "label item 1"
                    }, {
                        text: "label item 2"
                    }, {
                        text: "label item 2"
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