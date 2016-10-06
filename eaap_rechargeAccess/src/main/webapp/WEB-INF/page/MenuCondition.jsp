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
    <title>查询条件配置页面</title>
    <link href="<%=webpath%>/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="<%=webpath%>/lib/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
    <link href="<%=webpath%>/lib/ligerUI/skins/Tab/css/form.css" rel="stylesheet" type="text/css" /> 
    
    <script src="<%=webpath%>/lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="<%=webpath%>/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script><script type="text/javascript">
	    var form = null;
	    var grid = null;
	    var editPcid="";
	    $(function() {
	    	 
	        //创建表单结构 
	        form = $("#form2").ligerForm({
	            inputWidth : 170,
	            labelWidth : 90,
	            space : 40,
	            fields : [ {
	                display : "名称(中文)",
	                name : "label",
	                validate:{required:true},
	                newline : true,
	                labelAlign: 'right',
	                width:200,
	                type : "text"
	            }, {
	                display : "名称(英文)",
	                name : "name",
	                newline : false,
	                labelAlign: 'right',
	                width:200,
	                type : "text",
	                validate:{required:true}
	            }, {
	                display : "类型",
	                name : "type",
	                newline : true,
	                labelAlign: 'right',
	                width:200,
	                type : "select",
	                validate:{required:true},
	                editor : {
                        type: 'select', 
                        data:[{code:'text',name:'字符型'},{code:'date',name:'日期'},{code:'select',name:'下拉列表'}],
                        cancelable:false,
                        valueField:'code', textField:'name',selectBoxHeight:100
                    }
	            } , {
                    display : "日期格式",
                    name : "typeDateFormat",
                    newline : false,
                    labelAlign: 'right',
                    width:200,
                    type : "select",
                    validate:{required:false},
                    editor : {
                        type: 'select', 
                        data:[{code:'yyyy-MM-dd',name:'yyyy-MM-dd'},
                              {code:'yyyy-MM-dd hh:mm',name:'yyyy-MM-dd hh:mm'}],
                        cancelable:false,
                        valueField:'code', textField:'name',selectBoxHeight:100
                    }
                } , {display : "操作类型",
	            	name : "oper",
	            	newline : true,
	            	labelAlign: 'right',
	            	width:200,
	            	type : "select",
	            	validate:{required:true},
	            	editor : {
                        type: 'select', 
                        data:[{code:'=',name:'等于'},
                              {code:'>',name:'大于'},
                              {code:'<',name:'小于'},
                              {code:'>=',name:'大于等于'},
                              {code:'<=',name:'小于等于'},
                              {code:'like',name:'包含'}],
                        cancelable:false,
                        valueField:'code', textField:'name',selectBoxHeight:100
                    }
                },{
                    display : "是否必须",
                    name : "required",
                    newline : false,
                    labelAlign: 'right',
                    width:200,
                    type : "select",
                    validate:{required:true},
                    editor : {
                        type: 'select', 
                        data:[{code:'Y',name:'是'},{code:'N',name:'否'}],
                        cancelable:false,
                        valueField:'code', textField:'name',selectBoxHeight:100
                    }
                },{
                    display : "是否换行",
                    name : "newline",
                    labelAlign: 'right',
                    width:200,
                    newline : true,
                    type : "select",
                    validate:{required:true},
                    editor : {
                        type: 'select', 
                        data:[{code:'Y',name:'是'},{code:'N',name:'否'}],
                        cancelable:false,
                        valueField:'code', textField:'name',selectBoxHeight:100
                    }
                }]
	        });
	        liger.get("oper").setValue('=');
	        liger.get("required").setValue('N');
	        liger.get("newline").setValue('Y');
	        liger.get("type").setValue('text');
	        
	      //提交
            $("#submit_button").bind('click', function () {
            	 if(liger.get('label').getValue()=="") {
                     $.ligerDialog.alert('名称(中文)不能为空', '提示', 'warn');
                     return;
                 }
            	 if(liger.get('name').getValue()=="") {
                     $.ligerDialog.alert('名称(英文)不能为空', '提示', 'warn');
                     return;
                 }
            	 
            		 
            		 if(liger.get('type').getValue()=="") {
                         $.ligerDialog.alert('类型不能为空', '提示', 'warn');
                         return;
                     }
            		 //如果类型是date型
            		 if(liger.get('type').getValue()=="date" && liger.get('typeDateFormat').getValue()=="") {
                         $.ligerDialog.alert('日期格式不能为空', '提示', 'warn');
                         return;
                     }
            		 
            		 if(liger.get('oper').getValue()=="") {
                         $.ligerDialog.alert('操作类型不能为空', '提示', 'warn');
                         return;
                     }
                     
                     if(liger.get('required').getValue()=="") {
                         $.ligerDialog.alert('是否必须不能为空', '提示', 'warn');
                         return;
                     }
                     
                     if(liger.get('newline').getValue()=="") {
                         $.ligerDialog.alert('是否换行不能为空', '提示', 'warn');
                         return;
                     }
                     
            	 var params = {label : liger.get('label').getValue(),
            			 name: liger.get('name').getValue(),
            			 type: liger.get('type').getValue(),
            			 oper: liger.get('oper').getValue(),
            			 required: liger.get('required').getValue(),
            			 newline: liger.get('newline').getValue(),
            			 menuId:'<%=request.getAttribute("menuId")%>',
            			 typeDateFormat:liger.get('typeDateFormat').getValue(),
            			 pciId:editPcid};

            	 $.ajax({
                     type : "POST",
                     url : "<%=webpath %>/addMenuConditionSubmit.action",
                     data : params,
                     dataType : "json",
                     success:function (result){
                         if(result.resp_code == "1"){
                             var url = "<%=webpath %>/page/showDetail.jsp";
                            url = url + "?time="+new Date();
                             document.getElementById("detailMsg").value=result.resp_msg;
                             $.ligerDialog.open({ url: url, height:200,width: 500, buttons:   [ { text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
                         }else{
                             $.ligerDialog.success('新增查询条件成功！',function(type){
                            	 liger.get('label').setValue('');
                            	 liger.get('name').setValue('');
                            	 liger.get('typeDateFormat').setValue('');
                            	 liger.get("oper").setValue('=');
                                 liger.get("required").setValue('N');
                                 liger.get("newline").setValue('Y');
                                 liger.get("type").setValue('text');
                                 //初始化变量editPcid
                                 editPcid="";
                            	 grid.loadData(true); });
                         }
                     }
                 });
            	 
            });
	      
            grid = $("#maingrid4").ligerGrid({
                width: '780',height:220,
                columns: [
                        { display: '排序', name: 'sortno', width: 50 ,isSort:false},
                        { display: '显示名称', name: 'label', width: 100 ,isSort:false,render:function(item){
                            return "<font title='"+item.label+"'>"+item.label+"</font>";
                        }},
                        { display: 'ID', name: 'pciId', isSort:false,hide:true,width:0.00001,isAllowHide:false},
                          { display: '名称', name: 'name', minWidth: 100 ,isSort:false,render:function(item){
                              return "<font title='"+item.name+"'>"+item.name+"</font>";
                          }},
                          { display: '类型', name: 'type', minWidth: 80 ,isSort:false,render:function(item){
                              if(item.type == "text"){
                                  return '字符型';
                              }else if(item.type == "date"){
                                  return '日期';
                              }else if(item.type == "select"){
                            	  return '下拉列表';
                              }else{
                            	  return item.type;
                              }
                          }},
                          { display: '日期格式', name: 'typeDateFormat', minWidth: 80 ,isSort:false,render:function(item){
                              return "<font title='"+item.typeDateFormat+"'>"+item.typeDateFormat+"</font>";
                          }},
                          { display: '是否换行', name: 'newline', width: 60 ,isSort:false},
                          { display: '操作类型', name: 'oper', width: 60 ,isSort:false,render:function(item){
                              if(item.oper=='='){
                                  return '等于';
                              }else if(item.oper=='>'){
                                  return '大于';
                              }else if(item.oper=='<'){
                                  return '小于';
                              }else if(item.oper=='>='){
                                  return '大于等于';
                              }else if(item.oper=='<='){
                                  return '小于等于';
                              }else if(item.oper=='like'){
                                  return '包含';
                              }
                          }},
                          { display: '是否必须', name: 'required', width: 60 ,isSort:false,render:function(item){
                              if(item.required){
                            	  return 'Y';
                              }else{
                            	  return 'N';
                              }
                          }}
                          ],  pageSize:10,
                url : '<%=webpath %>/queryPageConditionGrid.action',
                allowAdjustColWidth:true,
                parms : {menuId:'<%=request.getAttribute("menuId")%>'},
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
                
                liger.get('label').setValue(selectRows[0].label);
                liger.get('name').setValue(selectRows[0].name);
                liger.get("oper").setValue(selectRows[0].oper);
                liger.get('typeDateFormat').setValue(selectRows[0].typeDateFormat);
                if(selectRows[0].required){
                	liger.get("required").setValue( 'Y');
                }else{
                    liger.get("required").setValue( 'N');
                }
                
                liger.get("newline").setValue(selectRows[0].newline);
                liger.get("type").setValue(selectRows[0].type);
                //初始化变量editPcid
                editPcid=selectRows[0].pciId;
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
            			  str = str + selectRows[i].pciId;
            		  }
            		  $.ajax({
                          type : "POST",
                          url : "<%=webpath %>/deleteMenuCondition.action",
                          data : {pciId:str},
                          dataType : "json",
                          success:function (result){
                              if(result.resp_code == "1"){
                                  var url = "<%=webpath %>/page/showDetail.jsp";
                                 url = url + "?time="+new Date();
                                  document.getElementById("detailMsg").value=result.resp_msg;
                                  $.ligerDialog.open({ url: url, height:200,width: 500, buttons:   [ { text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
                              }else{
                                  $.ligerDialog.success('删除查询条件成功！',function(type){grid.loadData(true); });
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
<input type="hidden" name="menuId" id="menuId"/>
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
