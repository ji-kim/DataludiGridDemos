<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Hello Chart</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script>
<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain;
        var dsMain;

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName: "term"
        }, {
            fieldName: "ie",
            dataType: "number",
            header: "IE",
        }, {
            fieldName: "firefox",
            dataType: "number",
            header: "Firefox"
        }, {
            fieldName: "chrome",
            dataType: "number",
            header: "Chrome"
        }, {
            fieldName: "safari",
            dataType: "number",
            header: "Safari"
        }, {
            fieldName: "opera",
            dataType: "number",
            header: "Opera"
        }, {
            fieldName: "gecko",
            dataType: "number",
            header: "Gecko"
        }, {
            fieldName: "netscape",
            dataType: "number",
            header: "Netscape"
        } ]);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            layout: "vertical",
            width: 60,
            childHeadersVisible: false,
            childFootersVisible: false,
            header: "Browser",
            columns: [{
                type: "label",
                styles: { textAlignment: "center", background: "#f8f8f8"} ,
                text: "IE"
            }, {
                type: "label",
                blankWhenCopy:true,
                styles: { textAlignment: "center", background: "#f8f8f8"} ,
                text: "Firefox"
            }, {
                type: "label",
                blankWhenCopy:true,
                styles: { textAlignment: "center", background: "#f8f8f8"} ,
                text: "Chrome"
            }, {
                type: "label",
                styles: { textAlignment: "center", background: "#f8f8f8"} ,
                text: "Safari"
            }, {
                type: "label",
                styles: { textAlignment: "center", background: "#f8f8f8"} ,
                text: "Opera"
            }, {
                type: "label",
                styles: { textAlignment: "center", background: "#f8f8f8"} ,
                text: "Gecko"
            }, {
                type: "label",
                styles: { textAlignment: "center", background: "#f8f8f8"} ,
                text: "Netscape"
            }]
        }, {
            layout: "vertical",
            width: 60,
            childHeadersVisible: false,
            childFootersVisible: false,
            header: "Share",
            columns: [{
                fieldName: "ie",
                width: 50,
                styles: { textAlignment: "far", suffix: "%" },
                header: { text: "2000" }
            }, {
                fieldName: "firefox",
                width: 50,
                blankWhenCopy:true,
                styles: { textAlignment: "far", suffix: "%" },
                header: { text: "2001" }
            }, {
                fieldName: "chrome",
                width: 50,
                styles: { textAlignment: "far", suffix: "%" },
                header: { text: "2002" }
            }, {
                fieldName: "safari",
                width: 50,
                styles: { textAlignment: "far", suffix: "%" },
                header: { text: "2003" }
            }, {
                fieldName: "opera",
                width: 50,
                styles: { textAlignment: "far", suffix: "%" },
                header: { text: "2004" }
            }, {
                fieldName: "gecko",
                width: 50,
                styles: { textAlignment: "far", suffix: "%" },
                header: { text: "2005" }
            }, {
                fieldName: "netscape",
                width: 50,
                styles: { textAlignment: "far", suffix: "%" },
                header: { text: "2006" }
            }]
        }, {
            width: 300,
            layout: "vertical",
            header: "Pie Chart",
            childHeadersVisible: false,
            childFootersVisible: false,
            columns: [{
                fieldName: "term",
                styles: {
                    background: "#555",
                    color: "#fff",
                    textAlignment: "center",
                    prefix: "Desktop Browser Market Share - ",
                    textWrap: "normal"
                }
            }, {
                type: "chart",
                fieldNames: "ie..netscape",
                fillHeight: 1,
                /*fillWdith: 1,*/
                width: 300,
                chart: {
                    type: "pie",
                    series: {
                        styles: {
                            background: "p(pal01:index)"
                        }
                    }
                },
                styles: {
                    paddingTop: 5,
                    borderBottom: null
                }
            }, {
                fieldNames: "ie..netscape",
                renderer: {
                    type: "seriesLegend",
                    displayCount: 4
                },
                styles: {
                    shapeColors: "pal01",
                    shapeSize: "80%",
                    paddingBottom: 4
                }
            }]
        }, {
            width: 300,
            layout: "vertical",
            header: "Bar Chart",
            childHeadersVisible: false,
            childFootersVisible: false,
            columns: [{
                fieldName: "term",
                styles: {
                    background: "#333",
                    color: "#fff",
                    textAlignment: "center",
                    prefix: "Desktop Browser Market Share - ",
                    textWrap: "normal"
                }
            }, {
                type: "chart",
                fieldNames: "ie..netscape",
                fillHeight: 1,
                /*fillWdith: 1,*/
                width: 300,
                chart: {
                    type: "bar",
                    plotArea: {
                        styles: {
                            background: "#080088ff"
                        }
                    },
                    yAxes: {
                        reversed: true
                    },
                    xAxes: {
                        lineVisible: false
                    },
                    series: {
                        styles: {
                            background: "p(pal02:index)"
                        }
                    },
                    styles: {
                        paddingRight: 5,
                        paddingTop: 5,
                        borderBottom: null
                    }
                }
            }, {
                fieldNames: "ie..netscape",
                renderer: {
                    type: "seriesLegend",
                    displayCount: 4
                },
                styles: {
                    shapeColors: "pal02",
                    shapeSize: "80%",
                    paddingBottom: 4
                }
            }]
        } ]);

        //grid options
        grdMain.setOptions({
            footer: {
                visible: true
            },
            stateBar: {
                visible: true
            },
            checkBar: {
                /*width: 50*/
            },
            header: {
            },
            display: {
                rowHeight: 220,
                rowResizable: true,
                heightMeasurer: "fixed"
            },
            operate: {
                sortHandleVisibility: "hidden"
            },
            edit: {
                deletable: true
            },
            autoFill: {
                enabled: true
            }
        });
                
        grdMain.loadStyles({
            selection: {
                background: "#11000000",
                border: "#88000000,1"
            }
        });
        
        grdMain.loadPalettes([{
            name: "pal01",
            fills: ["#ffe17F", "#97CBE7", "#074868", "#B0D67A", "#2C560A", "#DD9D82", "#578Ba7"]
        }, {
            name: "pal02",
            fills: ["#ffcccccc", "#ffaaaaaa", "#ff999999", "#ff777777", "#ff555555", "#ff333333", "#ff111111"]
        }, {
            name: "pal03",
            fills: ["#100000ff", "#200000ff", "#300000ff"]
        }]);

        grdMain.header().head().setPopupMenu({
            label: 'DataLudi Grid Version',
            callback: function () { alert(DataLudi.getVersion()); }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url: "data/browser_marketshare_in_us_statowl.tsv",
            dataType: 'text',
            success: function (data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    delimiter: '\t',
                    start: 1
                });
            },
            error: function(xhr, status, error) {
                console.log("jQuery getJSON() Failed: " + err);
                alert("jQuery getJSON() Failed: " + err);
            }
        });
        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };
    });
</script>
</head>
<body>
    <h3>Hello Chart</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>