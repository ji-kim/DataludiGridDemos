<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Tree Row Filtering</title>
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
            fieldName: "icon"
        }, {
        	fieldName: "loan_number"
        }, {
        	fieldName: "country"
        }, {
        	fieldName: "interest_rate",
        	dataType: "number"
        }, {
        	fieldName: "currency"
        }, {
        	fieldName: "project_id"
        }, {
        	fieldName: "original_amount",
        	dataType: "number"
        }, {
        	fieldName: "cancelled_amount",
        	dataType: "number"
        }, {
        	fieldName: "disbursed_amount",
        	dataType: "number"
        }, {
        	fieldName: "repaid_amount",
        	dataType: "number"
        }, {
        	fieldName: "sold_amount",
        	dataType: "number"
        }, {
        	fieldName: "first_date",
        	dataType: "datetime",
        	datetimeFormat: "MM/dd/yyyy"
        }, {
        	fieldName: "last_date",
        	dataType: "datetime",
        	datetimeFormat: "MM/dd/yyyy"
        } ]);

        //tree 
        treeMain = DataLudi.createTreeView('container');
        treeMain.setColumns([ {
    		"name": "LoanNumber",
    		"fieldName": "loan_number",
    		"width": "160",
    		"styles": {
    		    textAlignment: "near"
    		},
    		"header": {
    			"text": "LoanNumber"
    		}
    	}, {
    		"name": "Country",
    		"fieldName": "country",
    		"width": "120",
    		"styles": {
    		},
    		"header": {
    			"text": "Country"
    		}
        }, {
    		"name": "InterestRate",
    		"fieldName": "interest_rate",
    		"width": "65",
    		"styles": {
    		    "textAlignment": "far"
    		},
    		"header": {
    			"text": "InterestRate"
    		},
    		"footer": {
    		    "expression": "avg",
    		    "styles": {
    		        "prefix": "Average" + ": ",
    		        "numberFormat": "#,##0.00"
    		    }
    		}
    	}, {
    		"name": "Currency",
    		"fieldName": "currency",
    		"width": "90",
    		"styles": {
    		    "textAlignment": "center"
    		},
    		"header": {
    			"text": "Currency"
    		}
        }, {
    		"name": "ProjectID",
    		"fieldName": "project_id",
    		"width": "70",
    		"styles": {
    		    "textAlignment": "center"
    		},
    		"header": {
    			"text": "ProjectID"
    		},
    		"footer": {
    		    "text": "Sum",
    		    "styles": {
    		        "textAlignment": "far"
    		    }
    		}
    	}, {
    		"name": "OriginalAmount",
    		"fieldName": "original_amount",
    		"width": 110,
    		"styles": {
    		    "textAlignment": "far",
    		    "numberFormat": "#,##0.00"
    		},
    		"header": {
    			"text": "OriginalAmount"
    		},
    		"footer": {
    		    "expression": "sum",
    		    "styles": {
    		        "prefix": "$",
        		    "numberFormat": "#,##0",
        		    "background": "#777",
        		    "color": "#fff",
        		    "borderTop": "#ddd"
    		    }
    		}
    	}, {
    		"name": "CancelledAmount",
    		"fieldName": "cancelled_amount",
    		"width": 110,
    		"styles": {
    		    "textAlignment": "far",
    		    "numberFormat": "#,##0.00"
    		},
    		"header": {
    			"text": "CancelledAmount"
    		},
    		"footer": {
    		    "expression": "sum",
    		    "styles": {
    		        "prefix": "$",
        		    "numberFormat": "#,##0"
    		    }
    		}
    	}, {
    		"name": "DisbursedAmount",
    		"fieldName": "disbursed_amount",
    		"width": 110,
    		"styles": {
    		    "textAlignment": "far",
    		    "numberFormat": "#,##0.00"
    		},
    		"header": {
    			"text": "DisbursedAmount"
    		},
    		"footer": {
    		    "expression": "varp",
    		    "text": "분산",
    		    "styles": {
    		        "prefix": "분산=>$",
        		    "numberFormat": "#,##0"
    		    }
    		}
    	},  {
    		"name": "FirstDate",
    		"fieldName": "first_date",
    		"width": "90",
    		"styles": {
    		    datetimeFormat: "yyyy-MM-dd",
    		    textAlignment: "center"
    		},
    		"header": {
    			"text": "FirstDate"
    		}
    	},  {
    		"name": "LastDate",
    		"fieldName": "last_date",
    		"width": "90",
    		"styles": {
    		    datetimeFormat: "yyyy-MM-dd",
    		    textAlignment: "center"
    		},
    		"header": {
    			"text": "LastDate"
    		}
        } ]);

        // tree options
        treeMain.header().head().setPopupMenu([{
            label: 'DataLudi Version',
            callback: function () { alert(DataLudi.getVersion()); }
        }, {
            label: '-'  
        },{
            label: 'Expand All',
            callback: function () { treeMain.expandAll(); }
        },{
            label: 'Collapse All',
            callback: function () { treeMain.collapseAll(); }
        }]);

        treeMain.setOptions({
            "header.height": 30,
            "checkBar.visible": false,
            "rowIndicator.stateVisible": true,
            tree: {
                expanderWithCellStyles: true,
                iconField: 'icon',
                iconList: "images01",
                checkBoxVisible: true
            },
            body: {
                rowDynamicStyles: [{
                    expression: 'checked',
                    styles: {
                        background: '#100000ff'
                    }
                }]
            },
            edit: {
                insertable: true,
                appendable: true,
                deletable: true
            }
        });

        // connet Dataset
        treeMain.setDataSource(dsMain);
        $.ajax({
			url: "data/loan_statement_tree.csv",
			dataType: 'text',
			success: function (data) {
				DataLudi.loadCsvData(dsMain, data, {
					start: 1,
					quoted: true,
					currency: true,
					treeField: 1,
					useTreeField: false
				});
			},
			error: function (xhr, status, error) {
				var err = status + ', ' + error;
				alert("jQuery ajax() Failed: " + err);
			}
    	});

        treeMain.registerImageList({
            name: "images01",
            rootUrl: "assets/flags_iso/",
            items: [
                "ar.png", "at.png", "be.png", "br.png", "ca.png",
                "de.png", "dk.png", "et.png", "fi.png", "fr.png",
                "it.png", "jp.png", "kg.png"
            ]
        });

        // dsMain events
        dsMain.onRowAdded = function(ds, index, dataRow) {
            var row = treeMain.getRowOfDataRow(dataRow);
            row.setIconIndex(2);
        };
        dsMain.onRowCountChanged = function(ds, count) {
            $("#rowCount").css("color", "blue").text(count.toLocaleString());
        };
        dsMain.onRowAdded = function (ds, index, dataRow) {
            var row = treeMain.getRowOfDataRow(dataRow);
            row.setIconIndex(2);
        };
        dsMain.onRowDeleting = function (ds, row) {
            if (treeMain.rowCount() <= 1) {
                setTimeout(function () {
                    alert('I need at least one row!');
                }, 0);
                return false;
            }  
        };
        
        // grid
        treeMain.onInserting = function (grid, rowIndex) {
            console.log('Inserting at ' + rowIndex);  
            if (!$('#chkInsertable').is(':checked')) return false;
        };

        // buttons
        $('#chkOptionsInsertable').click(function () {
        	var checked = $('#chkOptionsInsertable').is(':checked');
            treeMain.setProperty("editOptions.insertable", checked).setFocus();
        });
        $('#chkOptionsAppendable').click(function () {
        	var checked = $('#chkOptionsAppendable').is(':checked');
        	treeMain.setProperty("editOptions.appendable", checked).setFocus();
        });
        $('#chkOptionsDeletable').click(function () {
        	var checked = $('#chkOptionsDeletable').is(':checked');
            treeMain.setProperty("editOptions.deletable", checked).setFocus();
        });
    });
</script>
</head>
<body>
    <h3>Tree Row Filtering</h3>
    <input type="checkbox" id="chkOptionsInsertable" checked="checked">editOptions.insertable 행 삽입 추가. 기본값은 false. 
    <input type="checkbox" id="chkInsertable" checked="checked">insertable in event
    <div id="container" style="height: 550px; width: 740px; min-width: 500px"></div>
    <div>
        <span id="rowCount" style="">0</span> rows.
    </div>
    <input type="checkbox" id="chkOptionsAppendable" checked="checked">appendable 마지막 행 다음에 행 추가. 기본값은 false.
    <input type="checkbox" id="chkOptionsDeletable" checked="checked">deletable 선택 행들 삭제. 기본값은 false.
</body>
</html>