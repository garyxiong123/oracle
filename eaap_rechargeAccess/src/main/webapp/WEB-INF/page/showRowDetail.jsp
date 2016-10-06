<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String webpath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
	<title>显示列明细</title>

	<link href="<%=webpath%>/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="<%=webpath%>/lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<script src="<%=webpath%>/lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
	<script src="<%=webpath%>/lib/ligerUI/js/core/base.js" type="text/javascript"></script>
	<script src="<%=webpath%>/lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
	<script src="<%=webpath%>/lib/ligerUI/js/plugins/ligerButton.js" type="text/javascript"></script>
	<script src="<%=webpath%>/lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>

	<script type="text/javascript" src="<%=webpath%>/lib/ligerUI/js/plugins/ligerButton.js"></script>
	<style type="text/css">
	body {
		font-size: 12px;
	}
	
	.l-table-edit {
		
	}
	
	.l-table-edit-td {
		padding: 4px;
	}
	
	.l-button-submit,.l-button-test {
		width: 80px;
		float: left;
		margin-left: 10px;
		padding-bottom: 2px;
	}
	
	.l-verify-tip {
		left: 230px;
		top: 120px;
	}
</style>
	<script type="text/javascript">
		$(function() {
			var table = document.getElementById("detailTable");
			for(var i=0; i<parent.dtGridHeader.length;i++){
				var tr=table.insertRow(); 
				var cell0=tr.insertCell(); 
				cell0.align="right";
				cell0.width="20%";
				cell0.className="l-table-edit-td";
				cell0.innerHTML="<b>"+parent.dtGridHeader[i]+"：</b>";
				
				var cell1=tr.insertCell(); 
				cell1.align="left";
				cell1.width="80%";
				cell1.className="l-table-edit-td";
				if(parent.dtGridDataRow[parent.dtGridHeaderName[i]].valueType=="CLOB"){
					cell1.innerHTML = "<a href='javascript:void(0)' onclick=\"javascript:showMsg('"+i+"');\">CLOB</a>";
                }else{
                	cell1.innerHTML = parent.dtGridDataRow[parent.dtGridHeaderName[i]].value;
                }
			}
			
		});

		function showMsg(indext){
			parent.showMsg1(parent.dtGridDataRow[parent.dtGridHeaderName[indext]].value);
        }
	</script>
</head>
<body style="padding:6px; overflow:hidden;">
<input type="hidden" id="detailMsg" name="detailMsg"/>
    <form name="form" method="post" id="form1">
        <div style="width:770px; height:420px; overflow:auto;">
	        <table cellpadding="0" width="100%" cellspacing="0"
	            class="l-table-edit" id="detailTable">
	            
	        </table>
        </div>
    </form>
</body>
</html>
