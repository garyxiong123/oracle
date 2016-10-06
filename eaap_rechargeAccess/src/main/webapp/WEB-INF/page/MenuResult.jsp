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
    <title>查询结果配置页面</title>
    <link href="<%=webpath%>/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="<%=webpath%>/lib/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
    <link href="<%=webpath%>/lib/ligerUI/skins/Tab/css/form.css" rel="stylesheet" type="text/css" /> 
    
    <script src="<%=webpath%>/lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="<%=webpath%>/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script><script type="text/javascript">
	    var form = null;
	    var grid = null;
	    var colId="";
	    $(function() {
	    	 
	        //创建表单结构 
	        form = $("#form2").ligerForm({
	            inputWidth : 170,
	            labelWidth : 90,
	            space : 40,
	            fields : [ {
	                display : "名称(中文)",
	                name : "display",
	                labelAlign: 'right',
	                width:200,
	                validate:{required:true},
	                newline : true,
	                type : "text"
	            }, {
	                display : "名称(英文)",
	                name : "name",
	                labelAlign: 'right',
	                width:200,
	                newline : false,
	                type : "text",
	                validate:{required:true}
	            }, {
                    display : "最小宽度",
                    name : "widht",
                    labelAlign: 'right',
                    width:200,
                    newline : true,
                    type : "text",
                    validate:{required:true}
                }]
	        });
	        liger.get("widht").setValue('150');
	        
	      //提交
            $("#submit_button").bind('click', function () {
            	 if(liger.get('display').getValue()=="") {
                     $.ligerDialog.alert('名称(中文)不能为空', '提示', 'warn');
                     return;
                 }
            	 if(liger.get('name').getValue()=="") {
                     $.ligerDialog.alert('名称(英文)不能为空', '提示', 'warn');
                     return;
                 }
            	 
            		 
            		 if(liger.get('widht').getValue()=="") {
                         $.ligerDialog.alert('最小宽度不能为空', '提示', 'warn');
                         return;
                     }
                     
            	 var params = {display : liger.get('display').getValue(),
            			 name: liger.get('name').getValue(),
            			 widht: liger.get('widht').getValue(),
            			 resultId:'<%=request.getAttribute("resultId")%>',
            			 colId:colId};

            	 $.ajax({
                     type : "POST",
                     url : "<%=webpath %>/addMenuResultSubmit.action",
                     data : params,
                     dataType : "json",
                     success:function (result){
                         if(result.resp_code == "1"){
                             var url = "<%=webpath %>/page/showDetail.jsp";
                            url = url + "?time="+new Date();
                             document.getElementById("detailMsg").value=result.resp_msg;
                             $.ligerDialog.open({ url: url, height:200,width: 500, buttons:   [ { text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
                         }else{
                             $.ligerDialog.success('新增查询结果字段成功！',function(type){
                            	 liger.get('display').setValue('');
                            	 liger.get('name').setValue('');
                            	 liger.get("widht").setValue('150');
                                 //初始化变量colId
                                 colId="";
                            	 grid.loadData(true); });
                         }
                     }
                 });
            	 
            });
	      
            grid = $("#maingrid4").ligerGrid({
                width: '780',height:290,
                columns: [
                        { display: '序列', name: 'sortNo', width: 50 ,isSort:false},
                        { display: '名称(中文)', name: 'display', minWidth: 200 ,isSort:false,render:function(item){
                            return "<font title='"+item.display+"'>"+item.display+"</font>";
                        }},
                        { display: 'ID', name: 'colId', isSort:false,hide:true,width:0.00001,isAllowHide:false},
                          { display: '名称(英文)', name: 'name', minWidth: 100 ,isSort:false,render:function(item){
                              return "<font title='"+item.name+"'>"+item.name+"</font>";
                          }}
                          ],  pageSize:10,
                url : '<%=webpath %>/queryPageResultGrid.action',
                allowAdjustColWidth:true,
                parms : {resultId:'<%=request.getAttribute("resultId")%>'},
                checkbox:true,
                usePager:true,
                toolbar: { items: [
                                   { text: '修改', click: itemclick_modify, icon: 'modify' },
                                   { line: true },
                                   { text: '删除', click: itemclick_delete, icon:'delete'}
                                   ]
                                   }
            });
          //修改
            function itemclick_modify(item, i)
            { 
            	var selectRows = grid.getSelectedRows();
                if(selectRows == null || selectRows.length==0){
                    $.ligerDialog.alert('请选择需要修改的条件！', '提示', 'warn');
                    return;
                }
                
                if(selectRows.length >1){
                    $.ligerDialog.alert('只能修改一条数据！', '提示', 'warn');
                    return;
                }
                
                liger.get('display').setValue(selectRows[0].display);
                liger.get('name').setValue(selectRows[0].name);
                liger.get("widht").setValue(selectRows[0].widht);
                
                //初始化变量editPcid
                colId=selectRows[0].colId;
            }
            //删除
            function itemclick_delete(item, i)
            { 
            	var selectRows = grid.getSelectedRows();
            	if(selectRows == null || selectRows.length==0){
            		$.ligerDialog.alert('请选择需要删除的条件！', '提示', 'warn');
                    return;
            	}
            	$.ligerDialog.confirm('确定要删除选中的条件吗？', function (yes) {
            		if(!yes){
                        return;
                    }
            		  var str ="";
            		  for(var i=0; i<selectRows.length;i++){
            			  if(str !=""){
            				  str = str +",";
            			  }
            			  str = str + selectRows[i].colId;
            		  }
            		  $.ajax({
                          type : "POST",
                          url : "<%=webpath %>/deleteMenuResult.action",
                          data : {colId:str},
                          dataType : "json",
                          success:function (result){
                              if(result.resp_code == "1"){
                                  var url = "<%=webpath %>/page/showDetail.jsp";
                                 url = url + "?time="+new Date();
                                  document.getElementById("detailMsg").value=result.resp_msg;
                                  $.ligerDialog.open({ url: url, height:200,width: 500, buttons:   [ { text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
                              }else{
                                  $.ligerDialog.success('删除查询结果成功！',function(type){grid.loadData(true); });
                              }
                          }
                      });
            	    });
            }
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
<input type="hidden" name="resultId" id="resultId"/>
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
        <tr>
            <td colspan="2" align="center">
                <!-- 这里目前调整了Firefox、IE7、8、9的样式 -->
                <div id="maingrid4"
                    style="*+margin-top:1.5%;margin-top:1.5%\0;bottom:0px;"></div>
                <!-- *+margin-top:0.2%;margin-top:0.2%\0; -->

                <div style="display:none;">
            </td>
        </tr>
        
    </table>
</div>
 
</body>
</form>
</html>
