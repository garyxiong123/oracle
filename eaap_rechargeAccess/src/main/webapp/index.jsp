<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>   
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
  <%  String webpath = request.getContextPath();%>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <script src="<%=webpath%>/lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
  <script src="<%=webpath%>/lib/jquery.cookie.js" type="text/javascript"></script>
    <link href="<%=webpath%>/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="<%=webpath%>/lib/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
        <link href="<%=webpath%>/css/style.css" rel="stylesheet" type="text/css" />
    
    <link href="<%=webpath%>/lib/ligerUI/skins/Tab/css/form.css" rel="stylesheet" type="text/css" />     
    <script src="<%=webpath%>/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
    <script src="<%=webpath%>/lib/ligerUI/js/plugins/ligerTab.js" type="text/javascript"></script>
    
     <script src="<%=webpath%>/js/menu.js" type="text/javascript"></script>
    <script src="<%=webpath%>/js/function.js" type="text/javascript"></script>
        <script src="<%=webpath%>/js/json2.js" type="text/javascript"></script>
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>熊成威个人的系统管理</title>
</head>

<body style="padding:0px;background:#EAEEF5;">  
<div id="pageloading"></div>  
<div id="topmenu" class="l-topmenu">
    <div class="l-topmenu-logo" style="font-size: 18px;">gary熊管理平台</div>
    <div class="l-topmenu-welcome">
        <label style="font-size: 13px;" id="time"> 当前时间：</label>
    </div> 
</div>
  <div id="layout1" style="width:99.2%; margin:0 auto; margin-top:4px; "> 
        <div position="left"  title="主要菜单" id="accordion1"> 
                     <div title="功能列表" class="l-scroll">
                         <ul id="tree1" style="width: 300px;">
                    </div>
        </div>
        <div position="center" id="framecenter"> 
            <div tabid="home" title="我的主页" style="height:300px" >
                <iframe frameborder="0" name="home" id="home" src="html/welcome.htm"></iframe>
            </div> 
        </div> 
        
    </div>
    
    <div style="display:none"></script></div>
</body>











</html>