<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix ="s" uri="/struts-tags"%>  
<%
    String webpath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>菜单配置管理页面</title>
    <link href="<%=webpath%>/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="<%=webpath%>/lib/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
    <link href="<%=webpath%>/lib/ligerUI/skins/Tab/css/form.css" rel="stylesheet" type="text/css" /> 
    
    <script src="<%=webpath%>/lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="<%=webpath%>/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
    <script src="<%=webpath%>/lib/ligerUI/js/jquery.json-2.2.js" type="text/javascript"></script>
    <script type="text/javascript">
    
        var grid = null;
        var menuId;
        var resultId;
        $(function () {
            
            
        	 // 创建搜索
            form = $("#searchbar").ligerForm({
                inputWidth : 150,
                labelWidth : 60,
                space : 30,
            
                    fields : [ {
                        display : "数据库",
                        name : "org",
                        newline : true,
                        type : "text"
                    }]
                });
            var params1={};
            params1["value"]=liger.get('org').getValue();
            var ss =new Array();
            ss.push(params1);
            grid = $("#maingrid4").ligerGrid({
                height:'100%',width: '100%',
                columns: [
                          { display: '序号', name: 'rownum', width: document.body.clientWidth*0.05 ,isSort:false},
                            { display: 'DB名称', name: 'name', width: document.body.clientWidth*0.14 ,isSort:false},
                            { display: '用户名', name: 'user', width: document.body.clientWidth*0.14 ,isSort:false},
                            { display: 'URL', name: 'url', width: document.body.clientWidth*0.4 ,isSort:false,render:function(item){
                                return "<font title='"+item.url+"'>"+item.url+"</font>";
                            }},
                            { display: '最大导出数', name: 'exportSheetMaxNum', width: document.body.clientWidth*0.12 ,isSort:false},
                            { display: 'SHEET最大记录数', name: 'sheetMaxNum', width: document.body.clientWidth*0.12 ,isSort:false}, 
                            { display: 'userId', name: 'code', width: 0.0001 ,isSort:false,hide:true,isAllowHide:false}
                            ],  pageSize:20,
                //data: $.extend(true,{},CustomersData),
                url : '<%=webpath %>/getDataBaseList.action',
                allowAdjustColWidth:true,
                parms : {condition:"["+jQuery.toJSON(params1)+"]"},
                checkbox:true
            });
            
            //查询
            $("#select_button").bind('click', function () {
                query();
            });
            
            function query(){
                if (!grid) return;     
                var params1={};
                params1["value"]=liger.get('org').getValue();
                grid.setOptions({ 
                    parms : {condition:"["+jQuery.toJSON(params1)+"]"},
                     newPage:1 
                   }); //这里是一堆查询条件
                grid.loadData(true); //重新查询，返回json记录集 
            }
            
            //重置
            $("#reset_button").bind('click', function () {
                liger.get('org').setValue('');
            });
            
        });
       
        
    </script>
</head>
<form enctype="multipart/form-data"> 
<body style="padding:6px; overflow:hidden;">
    <table><tr>
    <td id="searchbar">
    </td>
    <td><div id="select_button" class="liger-button" data-width="150">查询</div></td>
    <td>&nbsp;</td>
    <td><div id="reset_button" class="liger-button" data-width="150">重置</div></td>
    </tr></table>
    <!-- 这里目前调整了Firefox、IE7、8、9的样式 -->
    <div id="maingrid4"  style="*+margin-top:1.5%;margin-top:1.5%\0;bottom:0px;"></div><!-- *+margin-top:0.2%;margin-top:0.2%\0; -->
   

  <div style="display:none;">
  <!-- g data total ttt -->
</div>
 
</body>
</form>
</html>
