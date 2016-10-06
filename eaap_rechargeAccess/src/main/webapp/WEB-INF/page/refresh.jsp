<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix ="s" uri="/struts-tags"%>  
<%
    String webpath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<style type="text/css">
body {
    margin-left: 0px;
    margin-top: 0px;
    margin-right: 0px;
    margin-bottom: 0px;
}

.tabfont01 {
    font-family: "宋体";
    font-size: 9px;
    color: #555555;
    text-decoration: none;
    text-align: center;
}

.font051 {
    font-family: "宋体";
    font-size: 12px;
    color: #333333;
    text-decoration: none;
    line-height: 20px;
}

.font201 {
    font-family: "宋体";
    font-size: 12px;
    color: #FF0000;
    text-decoration: none;
}

.button {
    font-family: "宋体";
    font-size: 14px;
    height: 37px;
}

html {
    overflow-x: auto;
    overflow-y: auto;
    border: 0;
}
</style>
<head>
    <title>数据库WEB方式访问</title>
    <link href="<%=webpath%>/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="<%=webpath%>/lib/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
    <link href="<%=webpath%>/lib/ligerUI/skins/Tab/css/form.css" rel="stylesheet" type="text/css" /> 
    
    <script src="<%=webpath%>/lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="<%=webpath%>/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
</head>
<form enctype="multipart/form-data" method="post"> 
<body style="padding:6px; overflow:hidden;">
    <table width="100%">
        <tr>
            <td><h2>刷新成功！</h2></td>
        </tr>
    </table>
</body>
</form>
</html>
