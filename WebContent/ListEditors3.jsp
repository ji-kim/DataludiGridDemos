<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>List Editor Two Values</title>
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

        var grdMain, grdMain2;
        var dsMain;
        var countries = [ "Algeria", "Albania", "Chile", "Colombia", "Denmark", "Finland", "France", "India" ];
        var countryLabels = [ "알제리", "알바니아", "칠레", "콜롬비아", "덴마크", "핀란드", "프랑스", "인도" ];

        // dataset
        dsMain = DataLudi.createGridDataSet();
        dsMain.setFields([ {
            fieldName : "country"
        }, {
            fieldName : "year",
            dataType : "number"
        }, {
            fieldName : "comm_code"
        }, {
            fieldName : "commodity"
        }, {
            fieldName : "flow"
        }, {
            fieldName : "trade",
            dataType : "number"
        }, {
            fieldName : "weight",
            dataType : "number"
        }, {
            fieldName : "unit"
        } ]);

        // grid
        grdMain = DataLudi.createGridView("container");
        grdMain2 = DataLudi.createGridView("container2");
        grdMain.setColumns([ {
            "name" : "Country",
            "fieldName" : "country",
            "width" : 150,
            "header" : {
                "text" : "Value"
            },
            "editor" : {
                "type" : "list",
                "listItemDisplay" : "default",
                "displayLabels" : false,
                "values" : [ "Algeria", "Albania", "Chile", "Colombia", "Denmark", "Finland", "France", "India" ],
                "labels" : [ "알제리", "알바니아", "칠레", "콜롬비아", "덴마크", "핀란드", "프랑스", "인도" ]
            }
        }, {
            "name" : "Country2",
            "fieldName" : "country",
            "width" : 150,
            "header" : {
                "text" : "Label"
            },
            "lookupValues" : [ "Algeria", "Albania", "Chile", "Colombia", "Denmark", "Finland", "France", "India" ],
            "lookupLabels" : [ "알제리", "알바니아", "칠레", "콜롬비아", "덴마크", "핀란드", "프랑스", "인도" ],
            "editor" : {
                "type" : "list",
                "listItemDisplay" : "default",
                "displayLabel" : true
            }
        }, {
            "name" : "Country3",
            "fieldName" : "country",
            "width" : 150,
            "header" : {
                "text" : "Value-Label"
            },
            "lookupValues" : [ "Algeria", "Albania", "Chile", "Colombia", "Denmark", "Finland", "France", "India" ],
            "lookupLabels" : [ "알제리", "알바니아", "칠레", "콜롬비아", "덴마크", "핀란드", "프랑스", "인도" ],
            "editor" : {
                "type" : "list",
                "listItemDisplay" : "valueLabel"
            }
        }, {
            "name" : "Country4",
            "fieldName" : "country",
            "width" : 150,
            "header" : {
                "text" : "Label-Value"
            },
            "editor" : {
                "type" : "list",
                "listItemDisplay" : "labelValue",
                "values" : [ "Algeria", "Albania", "Chile", "Colombia", "Denmark", "Finland", "France", "India" ],
                "labels" : [ "알제리", "알바니아", "칠레", "콜롬비아", "덴마크", "핀란드", "프랑스", "인도" ]
            }
        } ]);

        grdMain2.setColumns([ {
            "name" : "Country3",
            "fieldName" : "country",
            "width" : 150,
            "header" : {
                "text" : "Value-Label"
            },
            "editor" : {
                "type" : "list",
                "listItemDisplay" : "valueLabel",
                "listItemSeparator" : " - ",
                "values" : [ "Algeria", "Albania", "Chile", "Colombia", "Denmark", "Finland", "France", "India" ],
                "labels" : [ "알제리", "알바니아", "칠레", "콜롬비아", "덴마크", "핀란드", "프랑스", "인도" ]
            }
        }, {
            "name" : "Country4",
            "fieldName" : "country",
            "width" : 150,
            "header" : {
                "text" : "Label-Value"
            },
            "lookupValues" : [ "Algeria", "Albania", "Chile", "Colombia", "Denmark", "Finland", "France", "India" ],
            "lookupLabels" : [ "알제리", "알바니아", "칠레", "콜롬비아", "덴마크", "핀란드", "프랑스", "인도" ],
            "lookupDisplay" : true,
            "editor" : {
                "type" : "list",
                "domainOnly" : true,
                "listItemDisplay" : "labelValue",
                "listItemColumned" : true
            }
        } ]);

        //grid options
        grdMain.editOptions().setInsertable(true).setAppendable(true);
        grdMain.header().setHeight(0);
        grdMain.rowIndicator().setStateVisible(true);
        grdMain.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        grdMain2.editOptions().setInsertable(true).setAppendable(true);
        grdMain2.header().setHeight(0);
        grdMain2.header().head().setPopupMenu({
            label : 'DataLudi Version',
            callback : function() {
                alert(DataLudi.getVersion());
            }
        });

        // connect dataset
        grdMain.setDataSource(dsMain);
        grdMain2.setDataSource(dsMain);
        $.ajax({
            url : "data/un_comtrade_of_goods_ss.csv",
            dataType : 'text',
            success : function(data) {
                new DataLudi.DataLoader(dsMain).load("csv", data, {
                    start : 1,
                    count : 7,
                    quoted : true,
                    currency : true
                });
            },
            error : function(xhr, status, error) {
                var err = status + ', ' + error;
                alert("jQuery ajax() Failed: " + err);
            }
        });

        // dataset events
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
            $("#rowCount2").css("color", "blue").text(count.toLocaleString());
        };

        // buttons
        $('#chkColumned').click(function() {
            var v = $('#chkColumned').is(':checked');
            grdMain.columnByName('Country3').setEditor({
                listItemColumned : v
            });
            grdMain.columnByName('Country4').setEditor({
                listItemColumned : v
            });
        });
        $('#chkSeparator').click(function() {
            var v = $('#chkSeparator').is(':checked');
            var s = v ? document.getElementById('edtSeparator').value : null;
            grdMain.columnByName('Country3').setEditor({
                listItemSeparator : s
            });
            grdMain.columnByName('Country4').setEditor({
                listItemSeparator : s
            });
        });
        $('#btnStyles1').click(function() {
            var styles = {
                listItemStyles : {
                    fontSize : 18
                },
                subItemStyles : {
                    fontSize : 12,
                    color : '#f00'
                }
            };
            grdMain2.columnByName('Country3').setEditor(styles);
            grdMain2.columnByName('Country4').setEditor(styles);
        });
        $('#btnStyles2').click(function() {
            var styles = {
                listItemStyles : {
                    fontSize : 20,
                    selectedBackground : "#008"
                },
                subItemStyles : {
                    fontSize : 10,
                    color : '#f00',
                    selectedBackground : '#fff',
                    selectedColor : '#f00'
                }
            };
            grdMain2.columnByName('Country3').setEditor(styles);
            grdMain2.columnByName('Country4').setEditor(styles);
        });
        $('#btnStyles3').click(function() {
            var styles = {
                listItemStyles : {
                    fontSize : 12
                },
                subItemStyles : {
                    fontSize : 16,
                    color : '#f00'
                }
            };
            grdMain2.columnByName('Country3').setEditor(styles);
            grdMain2.columnByName('Country4').setEditor(styles);
        });
    });
</script>
</head>
<body>
    <h3>List Editor Two Values</h3>
    <h4>1.List Item Display</h4>
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <div>
        <input type="checkbox" id="chkColumned">listItemColumned 
        <br>
        <input type="checkbox" id="chkSeparator">listItemSeparator
        <input type="text" id="edtSeparator" value="-">
    </div>
    <p>
    <h4>2.Item & SubItem Styles</h4>
    <div id="container2" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount2" style="">0</span> rows.
    </div>
    <div>
        <button id="btnStyles1">스타일 1</button>
        <button id="btnStyles2">스타일 2</button>
        <button id="btnStyles3">스타일 3</button>
    </div>
</body>
</html>