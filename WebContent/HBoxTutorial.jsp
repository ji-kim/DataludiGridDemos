<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>HBox Tutorial</title>
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
                    type: "hbox",
                    left: "4mm",
                    top: "2mm",
                    styles: {
                        border: "#777",
                        line: "#80000000,1px,dashed"
                    },
                    itemStyles: {
                        border: "#aaa",
                        margin: 4,
                        padding: 4,
                        background: "#fff"
                    },
                    items: [{
                        text: "hbox (left: 4mm, top: 2mm)"
                    }, {
                        text: "label item 1"
                    }, {
                        text: "label item 2"
                    }, {
                        text: "label item 2"
                    }]
                }, {
                    type: "hbox",
                    left: "4mm",
                    top: "13mm",
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
                        text: "hbox (left: 4mm, top: 13mm)"
                    }, {
                        type: "image",
                        text: "image",
                        url: "/repo/grid/resource/images/dataludi64.png",
                        imageWidth: 64,
                        imageHeight: 64,
                        styles: {
                        }
                    }, {
                        text: "label item",
                        styles: {
                            shapeName: "start"
                        }
                    }]
                }, {
                    type: "hbox",
                    left: "2mm",
                    right: "2mm",
                    bottom: "0.15in",
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
                        text: "hbox (left: 2mm, right: 2mm,\r bottom: 0.15in)"
                    }, {
                        text: "label item 1",
                        styles: {
                            shapeName: "star",
                            shapeColor: '#f00',
                            fontSize: 14
                        }
                    }, {
                        text: "label item 2",
                        styles: {
                            shapeName: "downarrow",
                            shapeColor: '#00f',
                            shapeLocation: "right"
                        }
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