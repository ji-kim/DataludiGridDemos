<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Tree Footer Chart</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script type="text/javascript" src="js/theme/flatbluestyle.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var treeMain;
        var dsMain;

        // dataset
        dsMain = DataLudi.createTreeDataSet();
        dsMain.setFields([ {
            fieldName : "icon"
        }, {
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

        // tree
        treeMain = DataLudi.createTreeView("container");
        treeMain.setColumns([ {
            "name" : "LoanNumber",
            "fieldName" : "loan_number",
            "width" : "110",
            "styles" : {
                textAlignment : "near"
            },
            "header" : {
                "text" : "LoanNumber"
            }
        }, {
            "name" : "Country",
            "fieldName" : "country",
            "width" : "70",
            "styles" : {},
            "header" : {
                "text" : "Country"
            }
        }, {
            "name" : "InterestRate",
            "fieldName" : "interest_rate",
            "width" : "55",
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "InterestRate"
            },
            "footer" : {
                "expression" : "avg",
                "styles" : {
                    "prefix" : "Average" + ": ",
                    "numberFormat" : "#,##0.00"
                }
            }
        }, {
            "name" : "Currency",
            "fieldName" : "currency",
            "width" : "40",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Currency"
            }
        }, {
            "name" : "ProjectID",
            "fieldName" : "project_id",
            "width" : "70",
            "styles" : {
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "ProjectID"
            },
            "footer" : {
                "text" : "Sum",
                "styles" : {
                    "textAlignment" : "far"
                }
            }
        }, {
            "name" : "OriginalAmount",
            "fieldName" : "original_amount",
            "width" : 80,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "OriginalAmount"
            },
            "footer" : {
                "expression" : "sum",
                "styles" : {
                    "prefix" : "$",
                    "numberFormat" : "#,##0",
                    "background" : "#777",
                    "color" : "#fff",
                    "borderTop" : "#ddd"
                }
            }
        }, {
            "name" : "DisbursedAmount",
            "fieldName" : "disbursed_amount",
            "width" : 80,
            "styles" : {
                "textAlignment" : "far"
            },
            "header" : {
                "text" : "DisbursedAmount"
            },
            "footer" : {
                "expression" : "varp",
                "text" : "분산",
                "styles" : {
                    "prefix" : "분산=>$",
                    "numberFormat" : "#,##0"
                }
            }
        }, {
            "name" : "FirstDate",
            "fieldName" : "first_date",
            "width" : "90",
            "styles" : {
                datetimeFormat : "yyyy-MM-dd",
                textAlignment : "center"
            },
            "header" : {
                "text" : "FirstDate"
            }
        }, {
            "name" : "LastDate",
            "fieldName" : "last_date",
            "width" : "90",
            "styles" : {
                datetimeFormat : "yyyy-MM-dd",
                textAlignment : "center"
            },
            "header" : {
                "text" : "LastDate"
            }
        } ]);

        //tree options
        treeMain.checkBar().setVisible(false);
        treeMain.header().setHeight(30);
        treeMain.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        treeMain.registerImageList({
            name : "images01",
            rootUrl : "assets/flags_iso/",
            items : [ "ar.png", "at.png", "be.png", "br.png", "ca.png", "de.png", "dk.png", "et.png", "fi.png", "fr.png", "it.png", "jp.png", "kg.png" ]
        });
        treeMain.setOptions({
            display : {},
            header : {
                height : 30
            },
            tree : {
                expanderWithCellStyles : true,
                iconField : 'icon',
                /*
                // iconCallback을 사용할 수도 있다.
                iconCallback: function (row) {
                    var idx = row.iconIndex();
                    if (idx === undefined) {
                        switch (row.getData('country')) {
                            case 'France': 
                                idx = 'fr.png';
                                break;
                            case 'Brazil':
                                idx = 'br.png';
                                break;
                            default:
                                idx = 0;
                                break;
                        }
                        row.setIconIndex(idx);
                    }
                    return idx;
                },
                 */
                iconList : "images01",
                /*iconWidth: 20,*/
                checkBoxVisible : true,
                footerItems : [ {
                    type : "chart",
                    displayCallback : function(row) {
                        return row.level() == 1;
                    },
                    minHeight : 150,
                    styles : {
                        /*background: "#0800ffff",*/
                        padding : 4
                    },
                    chart : {
                        type : "column",
                        legend : {
                            visible : true,
                            position : "right",
                            marginLeft : 10,
                            styles : {
                            /*border: "#800"*/
                            }
                        },
                        plotArea : {
                            styles : {
                                background : "#0800ffff"
                            }
                        },
                        xAxes : {
                            padding : 0.1,
                            styles : {
                                line : "#333"
                            },
                            tickStyles : {
                                line : "#333"
                            }
                        },
                        yAxes : {
                            indicators : [ {
                                type : "line",
                                front : true,
                                series : "serFemale",
                                value : "avg",
                                label : "Average:${value}",
                                styles : {
                                    line : "#600000ff,1px,dotted",
                                    color : "#e00000ff",
                                    fontSize : 10,
                                    fontBold : true,
                                    textAlignment : "far",
                                    numberFormat : "#,##0"
                                }
                            }, {
                                type : "line",
                                front : true,
                                series : "serMale",
                                value : "avg",
                                label : "Average:${value}",
                                styles : {
                                    line : "#80ff0000,1px,dashed",
                                    color : "#e0800000",
                                    fontSize : 10,
                                    fontBold : true,
                                    textAlignment : "near",
                                    numberFormat : "#,##0"
                                }
                            } ]
                        },
                        series : [ {
                            name : "serCountry",
                            caption : "Country",
                            /*filter: "values['subgroup'] == 'Female'",*/
                            labelField : "country",
                            valueField : "interest_rate",
                            summaryMode : "aggregate",
                            labelLocation : "none",
                            styles : {
                                background : "#AFD8F8"
                            }
                        } /*, {
	                        name: "serMale",
	                        caption: "Male",
	                        filter: "values['subgroup'] == 'Male'",
	                        labelField: "year",
	                        valueField: "value",
	                        summaryMode: "aggregate",
	                        styles: {
	                            background: "#F6BD0F"
	                        }
	                    }*/]
                    }
                } ]
            }
        });

        // connect dataset
        treeMain.setDataSource(dsMain);
        $.ajax({
            url : "data/loan_statement_tree.json",
            dataType : 'text',
            success : function(data) {
                DataLudi.loadJsonData(dsMain, data, {
                    currency : true,
                    rows : "",
                    childRows : "rows"
                });
                treeMain.expand(treeMain.getRow(0), true);
            },
            error : function(xhr, status, error) {
                var err = status + ', ' + error;
                alert("jQuery ajax() Failed: " + err);
            }
        });

        dsMain.setProperties({
            datetimeFormat : "MM/dd/yyyy"
        });
        dsMain.setRows(rows, 1);

        // dsMain events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };
    });
</script>
</head>
<body>
    <h3>Tree Footer Chart</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>