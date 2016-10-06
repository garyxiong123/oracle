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
    <script type="text/javascript">
    
        var grid = null;
        var menuId;
        var resultId;
        $(function () {
            
        	menu = $.ligerMenu({ width: 120, items:
                [
                { text: '编辑查询条件', click: itemclick_condition, icon: 'modify' },
                { line: true },
                { text: '编辑查询结果', click: itemclick_result,icon: 'database'  },
                { line: true },
                { text: '查看', click: itemclick_view,icon:'settings' }
                ]
                });
        	menu1 = $.ligerMenu({ width: 120, items:
                [
                { text: '编辑查询条件', click: itemclick_condition, icon: 'modify' },
                { line: true },
                { text: '查看', click: itemclick_view,icon:'settings' }
                ]
                });
        	
            // 创建搜索
        form = $("#searchbar").ligerForm({
            inputWidth : 150,
            labelWidth : 60,
            space : 30,
        
                fields : [ {
                    display : "菜单名",
                    name : "org",
                    labelAlign: 'right',
                    newline : true,
                    type : "text"
                }]
            });

            grid = $("#maingrid4").ligerGrid({
                height:'100%',width: '100%',
                columns: [
                        { display: '序号', name: 'rownum', width: 80 ,isSort:false},
                        { display: '菜单ID', name: 'menuId', isSort:false,hide:true,width:0.00001,isAllowHide:false},
                        { display: '结果ID', name: 'resultId', isSort:false,hide:true,width:0.00001,isAllowHide:false},
                        //{ display: 'ID', name: 'menuId', minWidth: 100 ,isSort:false},
                          { display: '名称', name: 'menuName', width: 200 ,isSort:false},
                          { display: '父菜单', name: 'parentName', width: 200 ,isSort:false},
                          { display: 'URL', name: 'url', minWidth: 280 ,isSort:false,render:function(item){
                              return "<font title='"+item.url+"'>"+item.url+"</font>";
                          }}
                          ],  pageSize:10,
                //data: $.extend(true,{},CustomersData),
                url : '<%=webpath %>/queryMenuGrid.action',
                allowAdjustColWidth:true,
                parms : {key:liger.get('org').getValue()},
                checkbox:true,
                toolbar: { items: [
                                   { text: '增加', click: itemclick_add, icon: 'add' },
                                   { line: true },
                                   { text: '修改', click: itemclick_modify, icon: 'modify' },
                                   { line: true },
                                   { text: '删除', click: itemclick_delete, icon:'delete'}
                                   ]
                                   },
                 onCheckRow: function(checked, rowdata, rowindex) {
                     for (var rowid in this.records)
                         this.unselect(rowid); 
                     this.select(rowindex);
                 },
                 onCheckAllRow: function(checked,element) {
                     return false;
                 },
                 onContextmenu : function (parm,e)
                 {
                	 menuId = parm.data.menuId;
                	 resultId =parm.data.resultId;
                	 if(resultId == null || resultId ==""){
                		 menu1.show({ top: e.pageY, left: e.pageX });
                		 menu.hide();
                	 }else{
                		 menu.show({ top: e.pageY, left: e.pageX });
                		 menu1.hide();
                	 }
                    
                     return false;
                 } 
            });
            
            //查询
            $("#select_button").bind('click', function () {
                query();
            });
            
            function query(){
            	if (!grid) return;                                               
                grid.setOptions({ 
                    parms : {key:liger.get('org').getValue()},
                     newPage:1 
                   }); //这里是一堆查询条件
                grid.loadData(true); //重新查询，返回json记录集 
            }
            
            //重置
            $("#reset_button").bind('click', function () {
            	liger.get('org').setValue('');
            });
            
        });
       
        //增加
        function itemclick_add(item, i)
        { 
            var url = "<%=webpath %>/MenuManageAdd.action";
            url = url + "?time="+new Date();
            url = url + "&menuId=";
            $.ligerDialog.open({ url: url, height:350,width: 700, title:'新增菜单',buttons:   [ { text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
        }
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
            
            var url = "<%=webpath %>/MenuManageModify.action";
            url = url + "?time="+new Date();
            url = url + "&menuId="+selectRows[0].menuId;
            $.ligerDialog.open({ url: url, height:350,width: 700, title:'修改菜单',buttons:   [ { text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
        }
        //删除
        function itemclick_delete(item, i)
        { 
            var selectRows = grid.getSelectedRows();
            if(selectRows == null || selectRows.length==0){
                $.ligerDialog.alert('请选择需要删除的菜单！', '提示', 'warn');
                return;
            }
            if(selectRows.length >1){
                $.ligerDialog.alert('只能修删除一条数据！', '提示', 'warn');
                return;
            }
            $.ligerDialog.confirm('确定要删除选中的菜单吗？', function (yes) {
                  if(!yes){
                      return;
                  }
                  $.ajax({
                      type : "POST",
                      url : "<%=webpath %>/deleteMenu.action",
                      data : {menuId:selectRows[0].menuId,resultId:selectRows[0].resultId},
                      dataType : "json",
                      success:function (result){
                          if(result.resp_code == "1"){
                              var url = "<%=webpath %>/page/showDetail.jsp";
                             url = url + "?time="+new Date();
                              document.getElementById("detailMsg").value=result.resp_msg;
                              $.ligerDialog.open({ url: url, height:200,width: 500, buttons:   [ { text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
                          }else if(result.resp_code == "2"){
                              $.ligerDialog.warn(result.resp_msg,function(type){grid.loadData(true); });
                          }else{
                        	  $.ligerDialog.success('删除菜单成功！',function(type){grid.loadData(true); });
                          }
                      }
                  });
                });
        }
        
        //编辑查询条件
        function itemclick_condition(item, i)
        {
        	var url = "<%=webpath %>/modifyPageCondition.action";
        	url = url +"?menuId="+menuId;
            url = url + "&time="+new Date();
            $.ligerDialog.open({ url: url, height:500,width: 800, title:'查询条件',buttons:   [ { text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
        }
        //编辑查询结果
        function itemclick_result(item, i){
        	var url = "<%=webpath %>/modifyPageResult.action";
            url = url +"?resultId="+resultId;
            url = url + "&time="+new Date();
            $.ligerDialog.open({ url: url, height:500,width: 800, title:'查询结果',buttons:   [ { text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
        }
        //查看详细
        function itemclick_view(item, i){
        	alert(menuId + " | " + item.text);
        }
        
    </script>
</head>
<form enctype="multipart/form-data"> 
<input type="hidden" name="detailMsg" id="detailMsg"/>
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
