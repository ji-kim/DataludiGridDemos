<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Image Cell Renderers</title>
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

        // images
        var logoCallback = function(column, row) {
            return 'assets/mlb/' + row.getValue('id') + '.jpg';
        };

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
            name : "Logo",
            type : "calced",
            width : 100,
            valueCallback : logoCallback,
            styles : {},
            header : {
                text : "ImageDisplay.DEFAULT"
            },
            renderer : {
                type : "image",
                "imageDisplay" : DataLudi.ImageDisplay.DEFAULT
            }
        }, {
            name : "LogoCenter",
            type : "calced",
            width : 100,
            valueCallback : logoCallback,
            styles : {},
            header : {
                text : "CENTER"
            },
            renderer : {
                type : "image",
                "imageDisplay" : DataLudi.ImageDisplay.CENTER
            }
        }, {
            name : "LogoBoth",
            type : "calced",
            width : 100,
            valueCallback : logoCallback,
            styles : {},
            header : {
                text : "BOTH"
            },
            renderer : {
                type : "image",
                "imageDisplay" : DataLudi.ImageDisplay.BOTH
            }
        }, {
            name : "LogoWidth",
            type : "calced",
            width : 110,
            valueCallback : logoCallback,
            styles : {},
            header : {
                text : "WIDTH"
            },
            renderer : {
                type : "image",
                "imageDisplay" : DataLudi.ImageDisplay.WIDTH
            }
        }, {
            name : "LogoHeight",
            type : "calced",
            width : 110,
            valueCallback : logoCallback,
            styles : {},
            header : {
                text : "HEIGHT"
            },
            renderer : {
                type : "image",
                "imageDisplay" : DataLudi.ImageDisplay.HEIGHT
            }
        }, {
            name : "LogoAuto",
            type : "calced",
            width : 110,
            valueCallback : logoCallback,
            styles : {},
            header : {
                text : "AUTO"
            },
            renderer : {
                type : "image",
                "imageDisplay" : DataLudi.ImageDisplay.AUTO
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
        grdMain.checkBar().setVisible(false);
        grdMain.footer().setVisible(false);
        grdMain.header().setHeight(35);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });
        grdMain.setDisplayOptions({
            rowHeight : 110,
            rowResizable : true
        });
        grdMain.vscrollBar().setBarWidth(12);
        grdMain.hscrollBar().setBarWidth(12);

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

        // grid events
        grdMain.onClickableCellClicked = function(grid, index, source, data) {
            window.open(data, '_newtab');
        };

        // buttons
        $('#btnIconAlpha').click(function() {
            var t = 0;
            [ 'Logo', 'LogoBoth', 'LogoHeight', 'LogoWidth', 'LogoCenter', 'LogoAuto' ].forEach(function(item) {
                setTimeout(function() {
                    var col = grdMain.columnByName(item);
                    var delta = -0.05;
                    setInterval(function() {
                        var a = col.styles().iconAlpha();
                        if (a <= 0) {
                            a = 0;
                            delta = 0.05;
                        } else if (a >= 1) {
                            a = 1;
                            delta = -0.05;
                        }
                        col.styles().setIconAlpha(Math.max(0, Math.min(1, a + delta)));
                    }, 50);
                }, t);
                t += 200;
            });
        });
    });
</script>
</head>
<body>
    <h3>Image Cell Renderers</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <button id="btnIconAlpha">iconAlpha 테스트</button>
</body>
</html>