<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Invoice Sample</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-report.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain;
        var dsMain;
        var loadData = function (ds) {
            ds.setRows([{
                item_name: "Design Services - Business System",
                item_spec: "includes iego, layout for letterhead, 2nd sheet, A10 envelope, and business card",
                price: 3500,
                unit: "project",
                quantity: 1,
                tax_rate: 8.25
            }, {
                item_name: "Design Services - Additional Concepts",
                item_spec: "includes thumbnail sketches for one additioanl concept",
                price: 125,
                unit: "each",
                quantity: 1,
                tax_rate: 8.25
            }]);
    	};
        var reportData = [{
            id: "inv",
            value: {
                id: "00035",
                date: "2016/04/24",
                dueDate: "2016/05/31",
                balance: 2311,
                shipping: 12.95,
                payments: -2000
            }
        }];
        var printOptions = {
            previewUrl: "previewer.html"
        };            
        var report = {
            styles: {
                fontSize: 14,
                fontName: "Helvetical"
            },
            reportHeader: {
                items: [{
                    type: "vbox",
                    left: 0,
                    right: 0,
                    styles: {
                        marginTop: 10,
                        marginBottom: 20
                    },
                    items: [{
                        type: "hbox",
                        left: 0,
                        right: 0,
                        items: [{
                            type: "vbox",
                            left: 0,
                            itemLeft: 0,
                            itemStyles: {
                                textAlignment: "near",
                            },
                            items: [{
                                type: "image",
                                url: "assets/logo.png",
                                imageWidth: 64,
                                imageHeight: 64,
                                styles: {
                                    marginBottom: 4
                                }
                            }, {
                                text: "DataLudi Data Inc.",
                            }, {
                                text: "777 Kji Street"
                            }, {
                                text: "Seongnam, GG 99999"
                            }, {
                                text: "555-555-4444"
                            }, {
                                text: "help@dataludidatacorp.com"
                            }]
                        }, {
                            type: "vbox",
                            right: 0,
                            top: 0,
                            items: [{
                                text: "INVOICE",
                                right: 0,
                                top: 0,
                                styles: {
                                    fontSize: 32,
                                    marginBottom: 10,
                                    color: "#888",
                                    lineAlignment: "near"
                                }
                            }, {
                                type: "list",
                                rowStyles: {
                                    borderBottom: "#ccc"
                                },
                                headerStyles: {
                                    textAlignment: "near",
                                    paddingRight: 20
                                },
                                itemStyles: {
                                    textAlignment: "near",
                                    paddingRight: 10
                                },
                                items: [{
                                    data: "inv.id",
                                    header: "Invoice No"
                                }, {
                                    data: "inv.date",
                                    header: "Date:"
                                }, {
                                    data: "inv.dueDate",
                                    header: "Due Date:"
                                }, {
                                    data: "inv.balance",
                                    header: "Balance Due $:",
                                    styles: {
                                        numberFormat: "#,##0.00"
                                    }
                                }, {
                                    text: "",
                                    header: "Customer PO#:"
                                }]
                            }]
                        }]
                    }, {
                        type: "hbox",
                        left: 0,
                        right: 0,
                        itemLeft: 0,
                        styles: {
                            paddingTop: 16
                        },
                        items: [{
                            type: "list",
                            itemStyles: {
                                textAlignment: "near"
                            },
                            title: {
                                text: "Bill To:",
                                styles: {
                                    fontBold: true
                                }
                            },
                            items: [{
                                text: "Aqua Hotel and Resort"
                            }, {
                                text: "1040 Boulevard"
                            }, {
                                text: "Anytown, CA 94558"
                            }, {
                                text: "555-555-2222 (Phone)"
                            }, {
                                text: "555-555-2225 (Fax)"
                            }]
                        }, {
                            type: "list",
                            top: 0,
                            itemStyles: {
                                textAlignment: "near"
                            },
                            title: {
                                text: "Ship To:",
                                styles: {
                                    fontBold: true
                                }
                            },
                            items: [{
                                text: "Aqua Hotel and Resort"
                            }, {
                                text: "1040 Boulevard"
                            }, {
                                text: "Anytown, CA 94558"
                            }, {
                                text: "555-555-2222 (Phone)"
                            }]
                        }, {
                            type: "list",
                            top: 0,
                            headerStyles: {
                                textAlignment: "near"
                            },
                            itemStyles: {
                                textAlignment: "near"
                            },
                            title: {
                                text: "Shipment Details:",
                                styles: {
                                    fontBold: true
                                }
                            },
                            items: [{
                                header: "Carrier:",
                                text: "USPS"
                            }, {
                                header: "Method:",
                                text: "Overnight Priority"
                            }, {
                                header: "Tracking#:",
                                text: "w126a5s31231sas"
                            }, {
                                header: "Ship Date:",
                                text: "03/02/2009"
                            }]
                        }]
                    }]
                }]
            },
            reportFooter: {
                styles: {
                },
                items: [{
                    type: "vbox",
                    left: 0,
                    right: 0,
                    styles: {
                        marginTop: 10
                    },
                    itemStyles: {
                        paddingTop: 1,
                        paddingBottom: 1,
                    },
                    items: [{
                        type: "list",
                        right: 30,
                        itemRight: 0,
                        rowStyles: {
                            paddingTop: 2,
                            paddingBottom: 2
                        },
                        headerStyles: {
                            paddingLeft: 100,
                            paddingRight: 10,
                            textAlignment: "far"
                        },
                        itemStyles: {
                            paddingRight: 20,
                            textAlignment: "far",
                            numberFormat: "#,##0.00"
                        },
                        items: [{
                            header: "Pre-tax Total:",
                            type: "summary",
                            expression: "sum['amount']"
                        }, {
                            header: "Tax:",
                            type: "summary",
                            expression: "sum['tax']"
                        }, {
                            header: "Shipping:",
                            data: "inv.shipping"
                        }, {
                            type: "hline",
                            styles: {
                                line: "#777",
                                paddingRight: 0
                            }
                        },{
                            header: {
                                text: "Total:",
                                styles: {
                                    fontBold: true
                                }
                            },
                            type: "summary",
                            expression: "sum['amount'] + sum['tax'] + inv['shipping']"
                        }, {
                            header: "Payments:",
                            data: "inv.payments"
                        }, {
                            type: "hline",
                            styles: {
                                line: "#777",
                                paddingRight: 0
                            }
                        }, {
                            header: {
                                text: "Balance($):",
                                styles: {
                                    fontBold: true
                                }
                            },
                            type: "summary",
                            expression: "sum['amount'] + sum['tax'] + inv['shipping'] + inv['payments']"
                        }]
                    },{
                        left: 0,
                        text: "Notes",
                        styles: {
                            marginTo: 10,
                            fontBold: true
                        }
                    }, {
                        left: 0,
                        text: "Thanks for the work! Art hard copies and CD mailed to printer per instructions"
                    }, {
                        left: 0,
                        text: "Terms and Conditions",
                        styles: {
                            marginTop: 10,
                            fontBold: true
                        }
                    }, {
                        left: 0,
                        text: "Balance Due Net 30 days."
                    }]
                }]
            },
            page: {
                styles: {
                    border: "#888",
                    padding: 12
                }
            },
            grid: {
                footer: {
                    visible: false
                },
                display: {
                    fitStyle: "even"
                },
                styles: {
                    grid: {
                        borderBottom: "#888",
                        borderLeft: "#888",
                        borderRight: "#888",
                        border: null
                    },
                    header: {
                        borderTop: "#888",
                        borderBottom: "#888",
                        borderLeft: null,
                        borderRight: null,
                        background: "#fff",
                        group: {
                            borderTop: "#888",
                            borderRight: null,
                            background: "#fff"
                        }
                    },
                    footer: {
                        borderTop: "#888",
                        borderBottom: "#888",
                        borderLeft: null,
                        borderRight: null,
                        background: "#fff"
                    },
                    body: {
                        cell: {
                            borderLeft: null,
                            borderRight: null,
                            borderBottom: null,
                            paddingLeft: 6,
                            paddingRight: 6,
                            fontSize: 14
                        },
                        row: {
                            borderBottom: "#aaa,1px,dashed"
                        },
                        rowRange: {
                            "row == rowcount - 1": {
                                borderBottom: null
                            }
                        }
                    }
                }
            }
        };
            
        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName: "invoice_id",
            dataType: "number"
        }, {
            fieldName: "item_name",
            dataType: "text"
        }, {
            fieldName: "item_spec",
            dataType: "text"
        }, {
            fieldName: "price",
            dataType: "number"
        }, {
            fieldName: "unit",
            dataType: "text"
        }, {
            fieldName: "quantity",
            dataType: "number"
        }, {
            fieldName: "tax_rate",
            dataType: "number"
        }], [{
            fieldName: "amount",
            expression: "price * quantity"
        }, {
            fieldName: "tax",
            expression: "price * quantity * tax_rate / 100"
        } ]);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            layout: "vertical",
            width: 260,
            childHeadersVisible: false,
            header: "Item",
            columns: [{
                fieldName: "item_name",
                height: 25,
                styles: {
                    fontSize: 16
                }
            }, {
                fieldName: "item_spec",
                fillHeight: 1,
                styles: {
                    textWrap: "normal"
                }
            }]
        },{
            fieldName: "price",
            width: "80",
            styles: {
                textAlignment: "far",
                numberFormat: "#,##0.00"
            },
            header: {
                text: "Price ($)"
            }
        }, {
            fieldName: "unit",
            width: "80",
            styles: {
                textAlignment: "center"
            },
            header: {
                text: "Unit"
            }
        }, {
            fieldName: "quantity",
            width: "50",
            styles: {
                textAlignment: "far"
            },
            header: {
                text: "Qty"
            }
        }, {
            fieldName: "amount",
            width: "80",
            styles: {
                textAlignment: "far",
                numberFormat: "#,##0.00"
            },
            header: {
                text: "Total ($)"
            }
        }, {
            fieldName: "tax_rate",
            width: "70",
            styles: {
                textAlignment: "far",
                numberFormat: "0.00",
                suffix: "%"
            },
            header: {
                text: "Tax"
            }
        } ]);

        //grid options
        grdMain.setOptions({
             footer: {
                 visible: false
             },
             display: {
                 selectStyle: DataLudi.SelectionStyle.ROWS,
                 rowHeight: 65,
                 heightMeasurer: "fixed",
                 rowResizable: true
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
            DLReport.preview(grdMain, report, null, printOptions, true);
        });
    });
</script>
</head>
<body>
	<div><button id="btnPrint">Print</button></div>
    <div id="container" style="height:550px;width:95%;min-width:500px;position:absolute;padding-top:7px;"></div>
</body>
</html>