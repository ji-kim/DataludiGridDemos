<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>List Tutorial</title>
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
                    type: "list",
                    left: "2mm",
                    top: "4mm",
                    styles: {
                        border: "#777,1px,dashed"
                    },
                    itemStyles: {
                        border: "#aaa",
                        margin: 2,
                        padding: 2,
                        background: "#fff",
                        shapeName: "circle",
                        shapeSize: 6,
                        shapePadding: 7,
                        shapeColor: "#333"
                    },
                    title: {
                        text: "list (left: 2mm, top: 4mm)",
                        styles: {
                        }
                    },
                    items: [{
                        text: "label item 1"
                    }, {
                        text: "label item 2",
                        styles: {
                            shapeColor: "#f00",
                            color: "#f00"
                        }
                    }, 
                        "label item 3",
                        "label item 4",
                        "label item 5",
                    {
                        text: "label item 6",
                        styles: {
                            shapeSize: 10,
                            shapeColor: "#00f",
                            color: "#080",
                            fontSize: 14,
                            fontBold: true
                        }
                    }, {
                        text: "label item 7"
                    }]
                }, {
                    type: "list",
                    left: "48mm",
                    top: "2mm",
                    styles: {
                        border: "#ccc",
                        padding: 8
                    },
                    itemStyles: {
                        border: "#aaa",
                        margin: 2,
                        padding: 2
                    },
                    title: {
                        text: "list (left: 49mm, top: 2mm)",
                        styles: {
                            fontBold: false,
                            borderBottom: "#777"
                        }
                    },
                    items: [{
                        text: "label item 1",
                        header: "header1"
                    }, {
                        text: "label item 2",
                        header: "header2"
                    }, {
                        text: "label item 3",
                        header: "header3"
                    }, {
                        text: "label item 4"
                    }, {
                        text: "label item 5"
                    }, {
                        text: "label item 6",
                        styles: {
                            shapeSize: 10,
                            shapeColor: "#00f",
                            color: "#080",
                            fontSize: 14,
                            fontBold: true
                        },
                        header: {
                            text: "header 6"
                        }
                    }, {
                        text: "label item 7",
                        headerCollapsible: true,
                        left: 0,
                        right: 0
                    }]
                }, , {
                    type: "list",
                    left: "95mm",
                    top: "2mm",
                    styles: {
                        border: "#ccc",
                        padding: 8
                    },
                    headerStyles: {
                        paddingRight: 10
                    },
                    itemStyles: {
                        border: "#aaa",
                        margin: 2,
                        padding: 2
                    },
                    title: {
                        text: "list (left: 45mm, top: 2mm)",
                        left: 0,
                        right: 0,
                        styles: {
                            fontBold: false,
                            borderBottom: "#777"
                        }
                    },
                    items: [{
                        text: "label item 1",
                        header: "header1",
                        footer: "footer1"
                    }, {
                        text: "label item 2",
                        header: "header22",
                        footer: "footer2"
                    }, {
                        text: "label item 3",
                        header: "header333",
                        footer: "footer3"
                    }, {
                        text: "label item 4",
                        headerCollapsible: true,
                        left: 0,
                        right: 0,
                        styles: {
                            shapeName: "star"
                        }
                    }, {
                        text: "label item 5",
                        footer: {
                            text: "footer5",
                            styles: {
                                fontSize: 16,
                                fontBold: true,
                                shapeName: "downarrow",
                                shapeColor: "#f00",
                                shapeLocation: "right"
                            }
                        }
                    }, {
                        text: "label item 6",
                        footerCallapsible: true,
                        styles: {
                            shapeSize: 10,
                            shapeColor: "#00f",
                            color: "#080",
                            fontSize: 14,
                            fontBold: true
                        },
                        header: {
                            text: "header 6"
                        }
                    }, {
                        text: "label item 7",
                        headerCollapsible: true,
                        footerCallapsible: true,
                        left: 0,
                        right: 0
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