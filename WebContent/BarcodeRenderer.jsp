<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Barcode Cell Renderers</title>
<script type="text/javascript" src="js/dataludi/jquery-1.8.3.min.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/jszip.min.js"></script> -->
<script type="text/javascript" src="js/dataludi/jszip.min-3.1.3.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi-eval-lic.js"></script>
<script type="text/javascript" src="js/dataludi/dataludi.js"></script>
<!-- <script type="text/javascript" src="js/dataludi/dataludi-eval.min.js"></script> -->

<script>
    $(document).ready(function() {
        DataLudi.setDebug(true);
        DataLudi.setTrace(true);

        var grdMain;
        var dsMain;

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName : "name",
        }, {
            fieldName : "id"
        }, {
            fieldName : "abbreviation"
        }, {
            fieldName : "league"
        }, {
            fieldName : "division"
        }, {
            fieldName : "url"
        }, {
            fieldName : "firstYear",
            dataType : "datetime",
            datetimeFormat : "yyyy"
        }, {
            fieldName : "wsTitles",
            dataType : "number"
        }, {
            fieldName : "stadium"
        }, {
            fieldName : "seatingCapacity",
            dataType : "number"
        }, {
            fieldName : "centerDistance",
            dataType : "number"
        } ]);

        // grid        
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            name : "Team",
            fieldName : "name",
            width : 80,
            styles : {
                textWrap : "normal"
            },
            header : {
                text : "Team"
            }
        }, {
            name : "Team128",
            fieldName : "name",
            width : 250,
            renderer : "code128",
            styles : {
                "shapeColor" : "#ff111111"
            },
            header : {
                text : "Code128"
            }
        }, {
            name : "Abbr",
            fieldName : "abbreviation",
            width : 50,
            styles : {
                textAlignment : "center"
            },
            header : {
                text : "Abbr"
            }
        }, {
            name : "Abbr39",
            fieldName : "abbreviation",
            width : 100,
            renderer : "code39",
            styles : {
                "shapeColor" : "#ff000088"
            },
            header : {
                text : "Code39"
            }
        }, {
            name : "Abbr128",
            fieldName : "abbreviation",
            width : 100,
            renderer : "code128",
            styles : {
                "shapeColor" : "#ff008800"
            },
            header : {
                text : "Code128"
            }
        }, {
            name : "League",
            fieldName : "league",
            lookupDisplay : true,
            lookupValues : [ "al", "nl" ],
            lookupLabels : [ "American", "National" ],
            width : 70,
            styles : {},
            header : {
                text : "League"
            }
        }, {
            name : "Division",
            fieldName : "division",
            width : 60,
            styles : {},
            header : {
                text : "Division"
            }
        }, {
            name : "Url",
            fieldName : "url",
            width : 100,
            displayCallback : function(index, value) {
                return value.substr(7);
            },
            styles : {
                color : "#00f",
                hoveredColor : "#008"
            },
            header : {
                text : "Url"
            },
            renderer : {
                type : "link",
                showTooltip : true
            }
        }, {
            name : "FirstYear",
            fieldName : "firstYear",
            width : 60,
            styles : {
                datetimeFormat : "yyyy",
                textAlignment : "center"
            },
            header : {
                text : "FirstYear"
            }
        }, {
            name : "WsTitles",
            fieldName : "wsTitles",
            width : 60,
            styles : {
                textAlignment : "center"
            },
            header : {
                text : "WsTitles"
            }
        }, {
            name : "Stadium",
            fieldName : "stadium",
            width : 110,
            styles : {},
            header : {
                text : "Stadium"
            }
        }, {
            name : "SeatCap",
            fieldName : "seatingCapacity",
            width : 60,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "SeatingCap"
            }
        }, {
            name : "CenterDistance",
            fieldName : "centerDistance",
            width : 60,
            styles : {
                textAlignment : "far"
            },
            header : {
                text : "CenterDist"
            }
        } ]);

        //grid options
        grdMain.setOptions({
            vscrollBar : {
                barWidth : 12
            },
            hscrollBar : {
                barWidth : 12
            },
            checkBar : {
                visible : false
            },
            header : {
                height : 35,
                head : {
                    popupMenu : {
                        label : 'DataLudi Grid Version',
                        callback : function() {
                            alert(DataLudi.getVersion());
                        }
                    }
                }
            },
            select : {
                style : DataLudi.SelectionStyle.ROWS
            },
            display : {
                rowHeight : 40,
                rowResizable : true
            },
            autoFill : {
                enabled : true
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url : "data/mlbteams.json",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("json", data, {});
            },
            error : function(xhr, status, error) {
                var err = status + ', ' + error;
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
    <h3>Barcode Cell Renderers</h3>
    <div id="container"
        style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>