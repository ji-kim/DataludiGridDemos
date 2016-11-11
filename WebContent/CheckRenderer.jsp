<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Check Cell Renderers</title>
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
            fieldName : "field1"
        }, {
            fieldName : "field2"
        }, {
            fieldName : "field3"
        }, {
            fieldName : "field4",
            dataType : "boolean"
        } ]);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain.setColumns([ {
            "name" : "col1",
            "fieldName" : "field1",
            "width" : "150",
            "editable" : false,
            "styles" : {
                "textAlignment" : "center",
                "iconOffset" : 4,
                "shapeColor" : "#008888"
            },
            "header" : {
                "text" : "Field1"
            },
            "renderer" : {
                "type" : "check",
                "editable" : true,
                "threeStates" : true,
                "editOnClick" : true,
                "spaceKey" : true,
                "trueValues" : "female",
                "falseValues" : "male"
            }
        }, {
            "name" : "col2",
            "fieldName" : "field2",
            "width" : "150",
            "styles" : {
                "iconOffset" : 4,
                "shapeSize" : "130%",
                "textAlignment" : "center"
            },
            "header" : {
                "text" : "Field2"
            },
            "renderer" : {
                "type" : "check",
                "editable" : true,
                "threeStates" : false,
                "editOnClick" : false,
                "spaceKey" : true,
                "trueValues" : "A01,A02",
                "falseValues" : "A03,A04"
            }
        }, {
            "name" : "col3",
            "fieldName" : "field3",
            "width" : "150",
            "styles" : {
                "textAlignment" : "center",
                "iconLocation" : "center"
            },
            "header" : {
                "text" : "Field3"
            },
            "renderer" : {
                "type" : "check",
                "editable" : false,
                "threeStates" : false,
                "editOnClick" : false,
                "spaceKey" : false,
                "falseValues" : "USD"
            }
        }, {
            "name" : "col4",
            "fieldName" : "field4",
            "width" : "150",
            "editable" : false,
            "styles" : {
                "textAlignment" : "center",
                "iconLocation" : "right",
                "iconOffset" : 4
            },
            "header" : {
                "text" : "Field4"
            },
            "renderer" : {
                "type" : "check",
                "editable" : true,
                "threeStates" : true,
                "editOnClick" : false,
                "spaceKey" : true
            }
        } ]);

        //grid options
        grdMain.checkBar().setVisible(false);
        grdMain.header().setHeight(30);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Grid Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        dsMain.setRows([
            [ 'male', 'A01', 'EUR', false ],
            [ 'female', 'A02', 'USD', true ],
            [ 'female', 'A04', 'USD', false ],
            [ 'male', 'A01', 'CNY', false ],
            [ undefined, 'A03', 'JPY', true ]
        ]);

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };
    });
</script>
</head>
<body>
    <h3>Check Cell Renderers</h3>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
</body>
</html>