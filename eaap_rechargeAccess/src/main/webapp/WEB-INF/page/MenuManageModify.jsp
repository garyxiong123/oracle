<%@page import="com.asiainfo.been.PageResultBean"%>
<%@page import="com.asiainfo.been.MenuBean"%>
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
    <title>菜单修改页面</title>
    <link href="<%=webpath%>/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="<%=webpath%>/lib/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
    <link href="<%=webpath%>/lib/ligerUI/skins/Tab/css/form.css" rel="stylesheet" type="text/css" /> 
    
    <script src="<%=webpath%>/lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="<%=webpath%>/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script><script type="text/javascript">
	    var form = null;
	    var grid = null;
	    <%MenuBean menuBean = (MenuBean)request.getAttribute("menuBean");
	    PageResultBean resultBean=(PageResultBean)request.getAttribute("resultBean");
	    %>
	    function getGridOptions(checkbox) {
	        var options = {
	                rownumbers:false,
	                columns: [
	                    { display: 'ID', name: 'rownum', width: 60 ,isSort:false},
	                    { display: '名称', name: 'dbname', width: 90 ,isSort:false,render:function(item){
	                        return "<font title='"+item.dbname+"'>"+item.dbname+"</font>";
	                     }},
	                    { display: '用户名', name: 'user', width: 90 ,isSort:false,render:function(item){
	                        return "<font title='"+item.user+"'>"+item.user+"</font>";
	                     }},
	                    { display: 'URL', name: 'url', width: 355 ,isSort:false,render:function(item){
	                        return "<font title='"+item.url+"'>"+item.url+"</font>";
	                     }},
	                    { display: 'name', name: 'name', width: 0.1 ,hide:true,isAllowHide:true}
	                    ],
	            switchPageSizeApplyComboBox : false,
	            url : '<%=webpath %>/getDataBaseList.action',
	            pageSize : 20,
	            checkbox : checkbox
	        };
	        return options;
	    }
	    $(function() {
	    	 var condition = { fields: [{ name: '', label: '数据库',width:120,type:'text'}] };
	    	 
	        //创建表单结构 
	        //创建表单结构 
            form = $("#form2").ligerForm({
                inputWidth : 170,
                labelWidth : 90,
                space : 40,
                fields : [ {
                    display : "菜单名称",
                    name : "menuName",
                    labelAlign: 'right',
                    validate:{required:true},
                    newline : true,
                    width:200,
                    type : "text"
                }, {
                    display : "URL",
                    name : "url",
                    labelAlign: 'right',
                    width:200,
                    newline : false,
                    type : "text",
                    validate:{required:false}
                } , {display : "父菜单",
                    name : "parentId",
                    labelAlign: 'right',
                    width:200,
                    newline : true,
                    type : "select",
                    validate:{required:false},
                    editor : {
                        type: 'select', 
                        url: '<%=webpath %>/listMenu.action', 
                        valueField:'menuId', textField:'menuName',
                        selectBoxHeight:120,selectBoxWidth:200,
                        onSuccess:function(data){
                        	liger.get("parentId").setValue('<%=request.getAttribute("parentId")%>');
                        }
                    }
                },{
                    display : "结果GRID名",
                    name : "gridName",
                    labelAlign: 'right',
                    width:200,
                    validate:{required:false},
                    newline : false,
                    type : "text"
                }, {
                    display : "是否分页",
                    name : "usepager",
                    labelAlign: 'right',
                    width:200,
                    newline : true,
                    type : "select",
                    validate:{required:false},
                    editor : {
                        type: 'select', 
                        data:[{menuId:'Y',menuName:'是'},{menuId:'N',menuName:'否'}],
                        cancelable:false,
                        valueField:'menuId', textField:'menuName',selectBoxHeight:100
                    }
                } , {display : "每页显示数",
                    name : "pageSize",
                    labelAlign: 'right',
                    width:200,
                    newline : false,
                    type : "select",
                    validate:{required:false},
                    editor : {
                        type: 'select', 
                        data:[{menuId:'10',menuName:'10'},{menuId:'20',menuName:'20'},{menuId:'30',menuName:'30'},{menuId:'40',menuName:'40'},{menuId:'50',menuName:'50'}],
                        cancelable:false,
                        valueField:'menuId', textField:'menuName',selectBoxHeight:100
                    }
                },{
                    display : "关联数据库",
                    name : "databaseList",
                    newline : true,
                    labelAlign: 'right',
                    type : "select",
                    validate:{required:false},
                    width:200,
                    editor : {
                        type: 'select', 
                        url : '<%=webpath %>/getDataBaseSelectList.action',
                        valueField:'code', textField:'name',selectBoxHeight:180,
                        autocomplete:true,
                        condition:condition,
                        isShowCheckBox: true, isMultiSelect: true,
                        selectBoxHeight:120,selectBoxWidth:200,
                        onSuccess:function(data){
                            liger.get("databaseList").setValue('<%=request.getAttribute("databaseList")%>');
                        }
                    }
                } , {display : "查询SQL",
                    name : "sqlList",
                    labelAlign: 'right',
                    newline : true,
                    width:530,
                    value:"1111",
                    type : "textarea",
                    validate:{required:false}
                }]
            });
	       
	        liger.get("usepager").setValue('<%=request.getAttribute("usepager")%>');
	        
	        liger.get("url").setValue('<%=request.getAttribute("url")%>');
	        liger.get("menuName").setValue('<%=request.getAttribute("menuName")%>');
	        
	        liger.get("gridName").setValue('<%=request.getAttribute("gridName")%>');
	        liger.get("pageSize").setValue('<%=request.getAttribute("pagesize1")%>');
	        
	        $("#sqlList").val($("#sqlList111").val());
	        
	        
	      //提交
            $("#submit_button").bind('click', function () {
            	 if(liger.get('menuName').getValue()=="") {
                     $.ligerDialog.alert('菜单名称不能为空', '提示', 'warn');
                     return;
                 }
            	 
            	 if(liger.get('gridName').getValue()=="Y"){
            		 
            		 if(liger.get('url').getValue()=="") {
                         $.ligerDialog.alert('URL不能为空', '提示', 'warn');
                         return;
                     }
            		 
            		 if(liger.get('gridName').getValue()=="") {
                         $.ligerDialog.alert('结果GRID名不能为空', '提示', 'warn');
                         return;
                     }
                     
                     if(liger.get('usepager').getValue()=="") {
                         $.ligerDialog.alert('是否分页不能为空', '提示', 'warn');
                         return;
                     }
                     
                     if(liger.get('databaseList').getValue()=="") {
                         $.ligerDialog.alert('数据库关联不能为空', '提示', 'warn');
                         return;
                     }
                     
                     if($("#sqlList").val()=="") {
                         $.ligerDialog.alert('查询SQL不能为空', '提示', 'warn');
                         return;
                     }
                     
                 }
            	 var params = {menuName : liger.get('menuName').getValue(),
            			       url: liger.get('url').getValue(),
            			       parentId: liger.get('parentId').getValue(),
            			       gridName: liger.get('gridName').getValue(),
            			       usepager: liger.get('usepager').getValue(),
            			       pagesize1: liger.get('pageSize').getValue(),
            			       sqlList: $("#sqlList").val(),
            			       databaseList:$("#databaseList").val(),
            			       menuId:$("#menuId").val()};

            	 $.ajax({
                     type : "POST",
                     url : "<%=webpath %>/addMenuSubmit.action",
                     data : params,
                     dataType : "json",
                     success:function (result){
                         if(result.resp_code == "1"){
                             var url = "<%=webpath %>/page/showDetail.jsp";
                            url = url + "?time="+new Date();
                             document.getElementById("detailMsg").value=result.resp_msg;
                             $.ligerDialog.open({ url: url, height:200,width: 500, buttons:   [ { text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
                         }else{
                             $.ligerDialog.success('修改菜单成功！',function(type){
                            	  dialog.close();
                            	  });
                             
                         }
                     }
                 });
            	 
            });
          //关闭
            $("#close_button").bind('click', function () {
                
            });
	    });
	    
var dialog = frameElement.dialog; //调用页面的dialog对象(ligerui对象)
        
	    
	</script> 
        <style type="text/css">
            .liger-button {
                float:left;margin-left:10px;
            }
    </style>
</head>
<form enctype="multipart/form-data" method="post" id="myform"> 
<input type="hidden" name="database" id="database"/>
<input type="hidden" name="sql" id="sql"/>
<input type="hidden" name="menuId" id="menuId" value="${menuId}"/>
<input type="hidden" name="detailMsg" id="detailMsg"/>
<input type="hidden" name="sqlList111" id="sqlList111" value="${sqlList}"/>
<body style="padding:6px; overflow:hidden;">
    <table align="left" border="0" width="100%">
        <tr>
            <td colspan="2" align="center" >
                <div id="form2"></div>
            </td>
        </tr>
        
        <tr >
            <td align="center" colspan="2">
             <div id="submit_button" class="liger-button" data-width="100" style="float: none;">提交</div>
            </td>
        </tr>
        
    </table>
</div>
 
</body>
</form>
</html>
