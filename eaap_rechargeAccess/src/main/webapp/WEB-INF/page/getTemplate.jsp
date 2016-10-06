<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix ="s" uri="/struts-tags"%>  
<%
    String webpath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>模板选择页面</title>
    <link href="<%=webpath%>/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="<%=webpath%>/lib/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
    <link href="<%=webpath%>/lib/ligerUI/skins/Tab/css/form.css" rel="stylesheet" type="text/css" /> 
    
    <script src="<%=webpath%>/lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="<%=webpath%>/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
    <script src="<%=webpath%>/lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
    <script src="<%=webpath%>/lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="<%=webpath%>/lib/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script>
    <script src="<%=webpath%>/lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
   
    
    <script src="<%=webpath%>/demos/grid/CustomersData.js" type="text/javascript"></script>
    <script type="text/javascript">
    
        var grid = null;
        $(function () {
            grid = $("#maingrid4").ligerGrid({
                height:'360',width: '100%',
                switchPageSizeApplyComboBox : false,usePager:true,
                rownumbers:true,
                pageSizeOptions : [ 10, 20, 30, 50 ],
                columns: [
				{ display: '模板ID', name: 'templateId', width: $(document).width() * 0.05 ,isSort:false,render:function(item){
				    return "<font title='"+item.templateId+"'>"+item.templateId+"</font>";
				}},
                { display: '模板名称', name: 'templateName', width: $(document).width() * 0.3 ,isSort:false,render:function(item){
                    return "<font title='"+item.templateName+"'>"+item.templateName+"</font>";
                }},
                { display: '执行SQL', name: 'templateSql', width: $(document).width() * 0.65 ,isSort:false,render:function(item){
                    return "<font title=\""+item.templateSql+"\">"+item.templateSql+"</font>";
                }}
                ],  pageSize:20,enabledEdit: true,clickToEdit:false,
                url : '<%=webpath %>/getTemplate.action',
                parms : {database:parent.window.document.getElementById("database").value},
                onDblClickRow:function (data, rowindex, rowobj){
                	parent.window.document.getElementById("sqls").value=data.templateSql;
                	parent.window.document.getElementById("templateId").value=data.templateId;
                	//$.ligerDialog.close();
                	//parent.$.ligerDialog.close();
                	//parent.$(".l-dialog,.l-window-mask").remove(); 
                	//window.parent.$('.l-dialog,.l-window-mask').remove(); 
                	//window.parent.$.ligerDialog.close();
                }
            });
        });
    </script>
</head>
<form enctype="multipart/form-data"> 
<body style="padding:6px; overflow:hidden;">
    <!-- 这里目前调整了Firefox、IE7、8、9的样式 -->
    <div id="maingrid4"  style="*+margin-top:1.5%;margin-top:1.5%\0;bottom:0px;"></div><!-- *+margin-top:0.2%;margin-top:0.2%\0; -->
   

  <div style="display:none;">
  <!-- g data total ttt -->
</div>
 
</body>
</form>
</html>
