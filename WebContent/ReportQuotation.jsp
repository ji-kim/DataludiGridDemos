<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Quotation Sample</title>
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
        var dsMain;
        var loadData = function (ds) {
            ds.setRows([
                ['데이타루디그리드', '라이선스', 'EA', 2, 4900000, ''],
                ['그리드 리포트', '라이선스', 'EA', 1, 900000, ''],
                ['안드로이드 그리드', '라이선스', 'EA', 1, 1100000, '']
            ]);
        };
        var reportData = [{
            id: "customer",
            value: {
                name: '(주)매크로소프트',
                date: new Date(2016, 3, 13),
                project: '롯데타워개발공사'
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
        var printOptions = {
            previewUrl: "previewer.html"
        };            
        var report = {
            reportHeader: {
                styles: {
                    /*background: "#ff0000"*/
                },
                items: [{
                    type: "vbox",
                    left: 0,
                    right: 0,
                    styles: {
                        marginTop: 10,
                        marginBottom: 20
                    },
                    items: [{
                        text: "견  적  서",
                        styles: {
                            fontName: "굴림",
                            fontSize: 30,
                            borderBottom: "#333",
                            margin: 10
                        }
                    }, {
                        type: "tile",
                        cols: 6,
                        rows: 5,
                        left: 0,
                        right: 0,
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
                                text: "아래와 같이 견적합니다.",
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
                            text: "공\n급\n자",
                            styles: {
                                background: "#f4f4f4"
                            }
        
                        }, {
                            col: 2,
                            text: "사업자번호",
                            styles: {
                                background: "#f4f4f4"
                            }
        
                        }, {
                            col: 3,
                            colSpan: 3,
                            data: "company.no",
                            styles: {
                            }
        
                        }, {
                            col: 2,
                            row: 1,
                            text: "상    호",
                            styles: {
                                background: "#f4f4f4"
                            }
        
                        }, {
                            col: 3,
                            row: 1,
                            data: "company.name",
                            styles: {
                                textAlignment: "near"
                            }
        
                        }, {
                            col: 4,
                            row: 1,
                            text: "대 표 자",
                            styles: {
                                background: "#f4f4f4"
                            }
        
                        }, {
                            col: 5,
                            row: 1,
                            data: "company.ceo",
                            styles: {
                            }
        
                        }, {
                            col: 2,
                            row: 2,
                            text: "소 재 지",
                            styles: {
                                background: "#f4f4f4"
                            }
        
                        }, {
                            col: 3,
                            row: 2,
                            colSpan: 3,
                            data: "company.address",
                            styles: {
                                textAlignment: "near"
                            }
        
                        }, {
                            col: 2,
                            row: 3,
                            text: "업   태",
                            styles: {
                                background: "#f4f4f4"
                            }
        
                        }, {
                            col: 3,
                            row: 3,
                            data: "company.category",
                            styles: {
                            }
        
                        }, {
                            col: 4,
                            row: 3,
                            text: "업   종",
                            styles: {
                                background: "#f4f4f4"
                            }
        
                        }, {
                            col: 5,
                            row: 3,
                            data: "company.type",
                            styles: {
                            }
        
                        }, {
                            col: 2,
                            row: 4,
                            text: "담 당 자",
                            styles: {
                                background: "#f4f4f4"
                            }
        
                        }, {
                            col: 3,
                            row: 4,
                            data: "company.charge",
                            styles: {
                            }
        
                        }, {
                            col: 4,
                            row: 4,
                            text: "전화번호",
                            styles: {
                                background: "#f4f4f4"
                            }
        
                        }, {
                            col: 5,
                            row: 4,
                            data: "company.phone",
                            styles: {
                            }
        
                        }]
                    }, {
                        type: "hbox",
                        left: 0,
                        right: 0,
                        styles: {
                            marginTop: 4,
                            border: "#aaa"
                        },
                        itemStyles: {
                            padding: 8
                        },
                        items: [{
                            text: "합  계  금  액",
                            left: 0,
                            right: 0,
                            styles: {
                                background: "#f4f4f4",
                                borderRight: "#888"
                            }
                        }, {
                            text: "(공급가액 + 부가세)",
                            left: 0
                        }, {
                            type: "hbox",
                            right: "0",
                            itemStyles: {
                                fontSize: 14,
                                fontName: "Arial",
                                paddingRight: 8
                            },
                            items: [{
                                text: "일금"
                            }, {
                                type: "summary",
                                expression: "sum['amount'] + sum['tax']",
                                right: 0,
                                styles: {
                                    numberFormat: "#,##0",
                                    fontBold: true
                                }
                             }, {
                                text: "원"
                            }]
                        }]
                    }]
                }]
            },
            reportFooter: {
                styles: {
                    marginTop: 20
                },
                items: [{
                    type: "vbox",
                    left: 0,
                    right: 0,
                    itemLeft: 0,
                    itemRight: 0,
                    styles: {
                        border: "#888",
                        line: "#888"
                    },
                    items: [{
                        text: "특 기 사 항",
                        styles: {
                            padding: 8,
                            background: "#f4f4f4"
                        }
                    }, {
                        type: "list",
                        styles: {
                            padding: 8
                        },
                        itemStyles: {
                            paddingBottom: 2
                        },
                        items: [{
                            text: "결제조건: 발주일로부터 1주일 내 현금."
                        }, {
                            text: "무상유지보수: 1년."
                        }, {
                            text: "유상유지보수: 구매 비용의 15%."
                        }, {
                            text: "영업문의: 임권섭, 010-3671-4065, gslim@dataludi.com"
                        }]
                    }]
                }]
            },
            pageHeader: {
                styles: {
                    margin: 4,
                    background: "#f8f8f8"
                },
                items: [{
                    left: 0,
                    text: 'Dataludi Inc.',
                    styles: {
                        fontBold: true,
                        fontItalic: true
                    }
        
                }, {
                    right: 0,
                    data: '$report.date'
                }]
            },
            pageFooter: {
                styles: {
                    margin: 4,
                    background: "#f8f8f8"
                },
                items: [{
                    type: "hbox",
                    right: 0,
                    items: [{
                        data: '$report.pageno'
                    }, {
                        text: "/"
                    }, {
                        data: '$report.pages',
                    }]
                }]
            },
            grid: {
                print: {
                    pageFill: true
                },
                footer: {
                    visible: true
                },
                display: {
                    fitStyle: "even"
                },
                styles: {
                    grid: {
                        borderLeft: "#888",
                        borderRight: "#888",
                        border: null
                    },
                    header: {
                        borderTop: "#888",
                        borderBottom: "#888",
                        borderLeft: null,
                        borderRight: null,
                        background: "#f4f4f4"
                    },
                    footer: {
                        borderTop: "#888",
                        borderBottom: "#888",
                        borderLeft: null,
                        borderRight: null,
                        background: "#f4f4f4"
                    },
                    body: {
                        cell: {
                            borderLeft: null,
                            borderRight: null,
                            borderBottom: null
                        },
                        row: {
                            borderBottom: "#aaa,1px,dashed"
                        },
                        rowRange: {
                            "row == rowcount - 1": {
                                /*borderBottom: null*/
                            }
                        }
                    }
                }
            }
        };
            
        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName: "product"
        }, {
            fieldName: "standard"
        }, {
            fieldName: "unit"
        }, {
            fieldName: "quantity",
            dataType: "number"
        }, {
            fieldName: "unit_price",
            dataType: "number"
        }, {
            fieldName: "note",
            dataType: "text"
        }], [{
            fieldName: "amount",
            expression: "quantity * unit_price"
        }, {
            fieldName: "tax",
            expression: "quantity * unit_price / 10"
        } ]);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            name: "colNo",
            type: "calced",
            width: 36,
            valueExpression: "row + 1",
            styles: {
                textAlignment: "center"
            },
            header: "번호",
            footer: {
                spanNext: 3,
                text: "합    계",
                styles: {
                    textAlignment: "center"
                }
            }
        },{
            name: "colProduct",
            fieldName: "product",
            width: "120",
            styles: {
            },
            header: {
                text: "품명"
            }
        }, {
            name: "colStandard",
            fieldName: "standard",
            width: "66",
            styles: {
                textAlignment: "center"
            },
            header: {
                text: "규격"
            }
        }, {
            name: "colUnit",
            fieldName: "unit",
            width: "45",
            styles: {
                textAlignment: "center"
            },
            header: {
                text: "단위"
            }
        }, {
            name: "colQuantity",
            fieldName: "quantity",
            width: "45",
            styles: {
                textAlignment: "far",
                numberFormat: "#,##0"
            },
            header: {
                text: "수량"
            },
            footer: {
                styles: {
                    textAlignment: "far",
                    numberFormat: "#,##0",
                },
                expression: "sum"
            }
        }, {
            name: "colUnitPrice",
            fieldName: "unit_price",
            width: "70",
            excelFormat: "#,##0",
            styles: {
                numberFormat: "#,##0",
                textAlignment: "far"
            },
            header: {
                text: "단가"
            }
        }, {
            name: "colAmount",
            fieldName: "amount",
            width: "80",
            styles: {
                textAlignment: "far",
                numberFormat: "#,##0"
            },
            header: {
                text: "금액"
            },
            footer: {
                styles: {
                    textAlignment: "far",
                    numberFormat: "#,##0",
                    suffix: "원"
                },
                expression: "sum"
            }
        }, {
            name: "colTax",
            fieldName: "tax",
            width: "70",
            styles: {
                textAlignment: "far",
                numberFormat: "#,##0"
            },
            header: {
                text: "세액"
            },
            footer: {
                styles: {
                    textAlignment: "far",
                    numberFormat: "#,##0",
                    suffix: "원"
                },
                expression: "sum"
            }
        }, {
            name: "colNote",
            fieldName: "note",
            width: "115",
            styles: {
                textAlignment: "near"
            },
            header: {
                text: "비고"
            }
        } ]);

        //grid options
        grdMain.setOptions({
            display: {
                selectStyle: DataLudi.SelectionStyle.ROWS
            }
        });
        grdMain.loadStyles({
            selection: {
                background: "#11000000",
                border: "#88000000,1"
            }
        });
        
        grdMain.header().head().setPopupMenu([{
            label: 'DataLudi Grid Version',
            callback: function () { alert(DataLudi.getVersion()); }
        },{
            label: 'DataLudi Report Version',
            callback: function () { alert(DLReport.getVersion()); }
        }]);
        
        // connect dataset
        grdMain.setDataSource(dsMain);
        loadData(dsMain);
        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };
        
        // button
        $('#btnPrint').click(function () {
            DLReport.preview(grdMain, report, null, printOptions, $('#chkPrint').is(':checked'));
        });
    });
</script>
</head>
<body>
    <h3>Quotation Sample</h3>
    <div><button id="btnPrint">Print</button></div>
    <input type="checkbox" id="chkPrint" checked="checked">바로 출력    (Check하면 현재 크롬에서 출력 미리보기 창이 바로 열립니다.)
    <div id="container" style="height:550px;width:95%;min-width:500px;position:absolute;padding-top:7px;"></div>
</body>
</html>