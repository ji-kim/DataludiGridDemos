<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Tile Tutorial</title>
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
            paperHeight: 480,
            paperMarginLeft: "5mm",
            paperMarginRight: "5mm",
            paperMarginTop: "5mm",
            paperMarginBottom: "5mm"
        };            
        var report = {
            reportHeader: {
                height: 442,
                styles: {
                    border: "#aaa",
                    background: "#10aaaaaa"
                },
                items: [{
                    type: "tile",
                    cols: 5,
                    rows: 2,
                    left: "3mm",
                    top: "3mm",
                    styles: {
                        line: "#999",
                        border: "#999"
                    },
                    itemStyles: {
                        padding: 2,
                        background: "#fff"
                    },
                    items: [{
                        text: "결\n재\n\nrowSpan\n:2",
                        rowSpan: 2
                    }, {
                        text: "담 당",
                        col: 1,
                        width: "14mm"
                    }, {
                        text: "팀 장",
                        col: 2,
                        width: "14mm"
                    }, {
                        text: "이 사",
                        col: 3,
                        width: "14mm"
                    }, {
                        text: "대 표",
                        col: 4,
                        width: "14mm"
                    }, {
                        text: "row:1,\rcol:1",
                        col: 1,
                        row: 1,
                        height: "11mm"
                    }, {
                        text: "row:1,\rcol:2",
                        col: 2,
                        row: 1
                    }, {
                        text: "row:1,\rcol:3",
                        col: 3,
                        row: 1
                    }, {
                        text: "row:1,\rcol:4",
                        col: 4,
                        row: 1
                    }]
                }, {
                    type: "tile",
                    top: "25mm",
                    left: "2mm",
                    cols: 6,
                    rows: 5,
                    styles: {
                        border: "#aaa",
                        line: "#aaa"
                    },
                    itemStyles: {
                        background: "#fff",
                        padding: 4
                    },
                    items: [{
                        type: "vbox",
                        rowSpan: 5,
                        styles: {
                            background: '#fff',
                            line: null
                        },
                        itemStyles: {
                            paddingLeft: 8,
                            paddingRight: 8
                        },
                        items: [{
                            text: "vbox(rowSpan: 5)\n\n아래와 같이 견적합니다.",
                            left: 0
                        }, {
                            data: "customer.date",
                            left: 0,
                            styles: {
                                textAlignment: "near",
                                datetimeFormat: "yyyy년 MM월 dd일",
                                suffix: "\n(유효기간: 견적일로부터 15일)"
                            }
                        }, {
                            data: "customer.name",
                            right: 0,
                            styles: {
                                suffix: " 귀하"
                            }
                        }]
                    }, {
                        col: 1,
                        rowSpan: 5,
                        text: "label\n(col:1\nrowSpan:5)\n\n공\n급\n자",
                        styles: {
                            background: "#f4f4f4"
                        }
                    }, {
                        col: 2,
                        text: "label(col:2)\n사업자번호",
                        styles: {
                            background: "#f4f4f4"
                        }
                    }, {
                        col: 3,
                        colSpan: 3,
                        data: "company.no",
                        styles: {
                            prefix: "label(col:3,colSpan:3)\n"
                        }
                    }, {
                        row: 1,
                        col: 2,
                        text: "label(row:1,\ncol:2)\n상    호",
                        styles: {
                            background: "#f4f4f4"
                        }
                    }, {
                        row: 1,
                        col: 3,
                        data: "company.name",
                        styles: {
                            textAlignment: "near",
                            prefix: "label(row:1,col:3)\n"
                        }
                    }, {
                        row: 1,
                        col: 4,
                        text: "label(row:1,\ncol:4)\n대 표 자",
                        styles: {
                            background: "#f4f4f4"
                        }
                    }, {
                        row: 1,
                        col: 5,
                        data: "company.ceo",
                        styles: {
                            prefix: "label:(row:1,col:5)\n"
                        }
                    }, {
                        row: 2,
                        col: 2,
                        text: "label(row:2,\ncol:2)\n소 재 지",
                        styles: {
                            background: "#f4f4f4"
                        }
                    }, {
                        row: 2,
                        col: 3,
                        colSpan: 3,
                        data: "company.address",
                        styles: {
                            textAlignment: "near",
                            prefix: "label(row:2,col:3,colSpan:3)\n"
                        }
                    }, {
                        row: 3,
                        col: 2,
                        text: "label(row:3,\ncol:2)\n업   태",
                        styles: {
                            background: "#f4f4f4"
                        }
                    }, {
                        row: 3,
                        col: 3,
                        data: "company.category",
                        styles: {
                            prefix: "label(row:3,col:3)\n"
                        }
                    }, {
                        row: 3,
                        col: 4,
                        text: "label(row:3\ncol:4)\n업   종",
                        styles: {
                            background: "#f4f4f4"
                        }
                    }, {
                        row: 3,
                        col: 5,
                        data: "company.type",
                        styles: {
                            prefix: "label(row:3,col:5)\n"
                        }
                    }, {
                        row: 4,
                        col: 2,
                        text: "label(row:4,\ncol:2)\n담 당 자",
                        styles: {
                            background: "#f4f4f4"
                        }
                    }, {
                        row: 4,
                        col: 3,
                        data: "company.charge",
                        styles: {
                            prefix: "label(row:4,col:3)\n"
                        }
                    }, {
                        row: 4,
                        col: 4,
                        text: "label(row:4,\ncol:4)\n전화번호",
                        styles: {
                            background: "#f4f4f4"
                        }
                    }, {
                        row: 4,
                        col: 5,
                        data: "company.phone",
                        styles: {
                            prefix: "label(row:4,col:5)\n"
                        }

                    }]
                }, {
                    type: "tile",
                    bottom: "2mm",
                    cols: 6,
                    rows: 3,
                    styles: {
                        border: "#888",
                        line: "#888"
                    },
                    rangeMasks: [{
                        range: "0,3:2,3",
                        offset: 4,
                        styles: {
                            border: "#008,2px",
                            background: "#1088ff00"
                        }
                    }],
                    items: [{
                        type: "dbox",
                        styles: {
                            line: "#888"
                        },
                        itemStyles: {
                            paddingLeft: 4,
                            paddingRight: 4
                        },
                        items: [{
                            text: "품목"
                        }, {
                            text: "월별"
                        }]
                    }, {
                        text: "1월",
                        col: 1,
                        height: "6mm"
                    }, {
                        text: "2월",
                        col: 2
                    }, {
                        text: "3월",
                        col: 3
                    }, {
                        text: "4월",
                        col: 4
                    }, {
                        text: "5월",
                        col: 5
                    }, {
                        text: "비어스탑",
                        row: 1,
                        height: "7mm"
                    }, {
                        text: "아그네스",
                        row: 2,
                        height: "7mm"
                    }, {
                        text: "123,345.6",
                        row: 1,
                        col: 1
                    }, {
                        text: "123,345.6",
                        row: 1,
                        col: 2
                    }, {
                        text: "123,345.6",
                        row: 1,
                        col: 3
                    }, {
                        text: "123,345.6",
                        row: 1,
                        col: 4
                    }, {
                        text: "123,345.6",
                        row: 1,
                        col: 5
                    }, {
                        text: "123,345.6",
                        row: 2,
                        col: 1
                    }, {
                        text: "123,345.6",
                        row: 2,
                        col: 2
                    }, {
                        text: "123,345.6",
                        row: 2,
                        col: 3
                    }, {
                        text: "123,345.6",
                        row: 2,
                        col: 4
                    }, {
                        text: "123,345.6",
                        row: 2,
                        col: 5
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
        
        var reportData = [{
            id: "customer",
            value: {
                name: '(주)매크로소프트',
                date: new Date(2016, 3, 13),
                project: 'DL타워개발공사'
            }
        }, {
            id: "company",
            value: {
                no: "129-86-90262",
                name: "(주)데이타루디",
                ceo: "홍 길 동",
                address: "우주시 태양계동 311 오피스타워 777호",
                category: "서비스",
                type: "소프트웨어자문개발",
                charge: "장 길 산",
                phone: "070-0012-2345",
                fax: "070-0012-2346"
            }
        }];
        // dataset
        grdMain = DataLudi.createGridView('container', [{ width: 100 }], false);
        grdMain.setOptions({
            footer: false,
            checkBar: false,
            header: {
                head: {
                    popupMenu: [{
                        label: 'DataLudi Grid Version',
                        callback: function () { alert(DataLudi.getVersion()); }
                    },{
                        label: 'DataLudi Report Version',
                        callback: function () { alert(DLReport.getVersion()); }
                    }]
                }
            },
            display: {
                checkDataInited: true
            }
        });        
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