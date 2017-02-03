<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Row Heights</title>
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
            fieldName : "year",
            dataType : "number"
        }, {
            fieldName : "name"
        }, {
            fieldName : "gender"
        }, {
            fieldName : "country"
        }, {
            fieldName : "country2"
        }, {
            fieldName : "language"
        }, {
            fieldName : "language2"
        }, {
            fieldName : "born",
            dataType : "number"
        }, {
            fieldName : "picture"
        }, {
            fieldName : "works"
        }, {
            fieldName : "citation"
        }, {
            fieldName : "genre"
        }, {
            fieldName : "remarks"
        } ]);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            name : "Year",
            fieldName : "year",
            width : 50,
            styles : {
                textAlignment : "center"
            },
            header : {
                text : "Year",
            }
        }, {
            name : "Name",
            fieldName : "name",
            width : 120,
            styles : {
                textWrap : "normal"
            },
            header : {
                text : "Name",
            },
            renderer : {
                type : "link",
                requiredFields : "name",
                url : "http://wikipedia.org/wiki/${name}"
            }
        }, {
            name : "Picture",
            fieldName : "picture",
            width : 90,
            styles : {},
            header : {
                text : "Picture",
            },
            renderer : {
                type : "image",
                imageDisplay : "auto"
            }
        }, {
            name : "Gender",
            fieldName : "gender",
            width : 65,
            styles : {
                textAlignment : "center"
            },
            header : {
                text : "Gender",
            }
        }, {
            name : "Country",
            fieldName : "country",
            width : 90,
            imageList : "flags",
            renderer : {
                type : "icon"
            },
            styleCallback : function(index, styles) {
                styles.setIconIndex(iconMap[index.getValue()]);
            },
            styles : {
                iconIndex : -1,
                iconLocation : "left",
            },
            header : {
                text : "Country",
            }
        }, {
            name : "Country2",
            fieldName : "country2",
            width : 90,
            imageList : "flags",
            renderer : {
                type : "icon"
            },
            styleCallback : function(index, styles) {
                styles.setIconIndex(iconMap[index.getValue()]);
            },
            styles : {
                iconIndex : -1,
                iconLocation : "left",
            },
            header : {
                text : "Country2",
            }
        }, {
            name : "Language",
            fieldName : "language",
            width : 60,
            styles : {},
            header : {
                text : "Lang",
            },
            editor : {
                type : "list",
                values : [ "English", "French", "German", "Spanish", "Italian", "Swedish", "Chinese", "Japanese" ]
            }
        }, {
            name : "Language2",
            fieldName : "language2",
            width : 60,
            styles : {},
            header : {
                text : "Lang2",
            }
        }, {
            name : "Born",
            fieldName : "born",
            width : 50,
            styles : {
                textAlignment : "center"
            },
            header : {
                text : "Born",
            }
        }, {
            name : "Citation",
            fieldName : "citation",
            width : 250,
            styles : {
                textWrap : "normal"
            },
            header : {
                text : "Citation",
            }
        }, {
            name : "Works",
            fieldName : "works",
            width : 130,
            styles : {
                textWrap : "normal"
            },
            header : {
                text : "Works",
            }
        }, {
            name : "Genre",
            fieldName : "genre",
            width : 60,
            styles : {
                textWrap : "normal"
            },
            header : {
                text : "Genre",
            }
        }, {
            name : "Remarks",
            fieldName : "remarks",
            width : 95,
            styles : {},
            header : {
                text : "Remarks",
            }
        } ]);

        // images
        var iconMap = {
            'Australia' : 'au.png',
            'Austria' : 'at.png',
            'Belarus' : 'by.png',
            'Canada' : 'ca.png',
            'Chile' : 'cl.png',
            'China' : 'cn.png',
            'Colombia' : 'co.png',
            'Czechoslovakia' : 'cz.png',
            'Denmark' : 'dk.png',
            'Egypt' : 'eg.png',
            'Finland' : 'fi.png',
            'France' : 'fr.png',
            'Germany' : 'de.png',
            'Greece' : 'gr.png',
            'Guatemala' : 'gt.png',
            'Hungary' : 'hu.png',
            'India' : 'in.png',
            'Italy' : 'it.png',
            'Iran' : 'ir.png',
            'Israel' : 'il.png',
            'Japan' : 'jp.png',
            'Ireland' : 'ie.png',
            'Mauritius' : 'mu.png',
            'Mexico' : 'mx.png',
            'Nigeria' : 'ng.png',
            'Norway' : 'no.png',
            'Peru' : 'pe.png',
            'Poland' : 'pl.png',
            'Portugal' : 'pt.png',
            'Romaina' : 'ro.png',
            'Saint Lucia' : 'lc.png',
            'South Africa' : 'za.png',
            'Soviet Union' : 'ru.png',
            'Spain' : 'es.png',
            'Sweden' : 'se.png',
            'Switzerland' : 'sz.png',
            'Turkey' : 'tr.png',
            'Ukraine' : 'ua.png',
            'United Kingdom' : 'gb.png',
            'United States' : 'us.png',
            'Yugoslavia' : 'mk.png'
        };

        grdMain.registerImageList({
            name : "flags",
            root : "assets/flag_iso/",
            items : [ 'au.png', 'at.png', 'by.png', 'ca.png', 'cl.png', 'cn.png', 'co.png', 'cz.png', 'dk.png', 'eg.png', 'fi.png', 'fr.png', 'de.png', 'gr.png', 'gt.png', 'hu.png', 'in.png',
                    'it.png', 'il.png', 'jp.png', 'ie.png', 'mx.png', 'ng.png', 'no.png', 'pe.png', 'pl.png', 'pt.png', 'lc.png', 'za.png', 'ru.png', 'es.png', 'se.png', 'sz.png', 'tr.png',
                    'ua.png', 'gb.png', 'us.png', 'mk.png', 'ro.png', 'mu.png', 'ir.png' ]
        });

        //grid options
        grdMain.setOptions({
            groupPanel : true,
            display : {
                rowResizable : true/*,
                                minRowHeight: 10
                 */,
                variableRowHeight : true,
                wheelDelta : 1,
                rowHoverMask : true
            },
            edit : {
                insertable : true,
                appendable : true,
                updatable : true,
                deletable : true
            },
            autoFill : {
                enabled : false
            },
            rowIndicator : {
                stateVisible : true
            },
            vscrollBar : {
                barWidth : 12
            },
            hscrollBar : {
                barWidth : 12
            },
            footer : false,
            header : {
                head : {
                    popupMenu : {
                        label : 'DataLudi Version',
                        callback : function() {
                            alert(DataLudi.getVersion());
                        }
                    }
                }
            }
        });

        // grid styles
        grdMain.loadStyles({
            body : {
                rowDynamic : [ {
                    expression : 'row % 2',
                    styles : {
                        background : '#10cccccc'
                    }
                } ],
                rowHover : {
                    background : "#1088ff00"
                }
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        $.ajax({
            url : "http://helpme.dataludi.com/download/nobel_literature.json",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("json", data, {});

                grdMain.setRowHeight(0, 90);
                grdMain.setRowHeight(1, 60);
                grdMain.setRowHeight(2, 60);
                grdMain.setRowHeight(7, 70);
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
        $('#btnSetHeight').click(function() {
            var row = grdMain.focusedRow();
            if (row) {
                var h = $('#edtRowHeight').val();
                grdMain.setRowHeight(row, Math.max(4, Math.min(500, h)));
            }
        });
        $('#btnFitRowHeight').click(function() {
            var row = grdMain.focusedRow();
            if (row) {
                grdMain.fitRowHeight(row);
            }
        });
        $('#btnResetRowHeight').click(function() {
            var row = grdMain.focusedRow();
            if (row) {
                grdMain.setRowHeight(row, undefined);
            }
        });

        $('#btnClearRowHeights').click(function() {
            grdMain.clearRowHeights();
        });
    });
</script>
</head>
<body>
    <h3>Row Heights</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="text" id="edtRowHeight" value="30">
        <button id="btnSetHeight">Set Current Row Height</button>
    </div>
    <div>
        <button id="btnFitRowHeight">Fit Current Row Height</button>
    </div>
    <div>
        <button id="btnResetRowHeight">Reset Row Height</button>
    </div>
    <div>
        <button id="btnClearRowHeights">Clear Row Heights</button>
    </div>
</body>
</html>