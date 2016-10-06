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
	<title></title>

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
			$("#detailMsg1").val(parent.window.document.getElementById("detailMsg").value);
			$("textarea").each(function() {
				$(this).css("height", $(document).height() * 0.96);
			});
		});
	</script>
</head>
<body style="padding:6px; overflow:hidden;">

    <form name="form" method="post" id="form1">
        <input type="hidden" name="detail" id="detail" value="1111"/> 
        <input type="hidden" name="type" id="type" value="${type}" />
        <table cellpadding="0" width="100%" cellspacing="0"
            class="l-table-edit">
            <tr>
                <td align="left" class="l-table-edit-td" colspan="2"><textarea rows="8"
                        cols="8" style="width: 100%;overflow-y:visible;" readonly="readonly"
                        id="detailMsg1" name="detailMsg1"></textarea></td>
                <td align="left"></td>
            </tr>
        </table>
    </form>
</body>
</html>
