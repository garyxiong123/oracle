<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <script type="text/javascript">
    var dtGridHeader;
    var dtGridHeaderName;
    var changeColumns;
    var dtGridDataRow;
    var detailRowindex;
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
        var grid = null;
        var condition = { fields: [{ name: 'databaseCondition', label: '数据库',width:120,type:'text'}] };
        
        $(function () {
            $("#database1").ligerComboBox({
                width : 200,
                slide : false,
                selectBoxWidth : 620,
                selectBoxHeight : 240,
                valueField : 'code',
                textField : 'name',
                autocomplete:false,
                grid : getGridOptions(false),
                condition:condition
            });
        /*grid = $("#maingrid").ligerGrid({
            columns : [],
            width : '100%',
            pkName : 'id',
            pageSizeOptions : [ 10, 50, 100, 200 ],
            height : 350,
            isScroll:true
        });
        */
        function f_onDblClickRow(rowdata, rowindex, rowDomElement){
           var url = "<%=webpath %>/page/showRowDetail.jsp";
           url = url + "?time="+new Date();
           dtGridDataRow=rowdata;
          $.ligerDialog.open({ url: url, height:500,width: 800, title:'行明细信息',buttons:   [ { text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
        }

        //$("#maingrid").hide();
        $('.l-dialog,.l-window-mask').add();
            //查询
            $("#select_button").bind('click', function () {
               $("#maingrid").hide();
               
               
               //判断是否为查询语句
             if($("#sqls").val().replace(/(^\s*)/g,'')==""){
                 alert("执行SQL不能为空！");
                 return;
               }
             var manager = $.ligerDialog.waitting('处理中,请稍候...');
               //判断是否以SELECT为开始
             if($("#sqls").val().replace(/(^\s*)/g,'').substr(0,6).toUpperCase()=="SELECT"){
                 $("#maingrid").show();
                 
                 var url1 = "<%=webpath%>/queryHeader.action";
                 
                 $.ajax({
                     type : "POST",
                     url : url1,
                     data : {
                         database: liger.get('database1').getValue(),
                         sql : $("#sqls").val()
                     },
                     dataType : "json",
                     success:function (result){
                         manager.close();
                         if(result.resp_code == "1"){
                             var url = "<%=webpath %>/page/showDetail.jsp";
                            url = url + "?time="+new Date();
                             document.getElementById("detailMsg").value=result.resp_msg;
                             $.ligerDialog.open({ url: url, height:200,width: 500, buttons:   [ { text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
                         }else if(result.data != null && result.data !=""){
                             $("#maingrid").show();
                             var columns = new Array();
                             var columnsHeader = new Array();
                             var hiddenCol = new Array();
                             var hidIndex = 0;
                             //设置表头
                          for(var i=0; i<result.data[0].length;i++){
                                 var column = {};
                                 column["display"] = result.data[0][i].key;
                                 column["name"] = result.data[0][i].key;
                                 column["minWidth"] = 200;
                                 column["type"] = "text";
                                 columns[i] =column;
                                 column["render"] = f_render;
                                 if(result.data[0][i].valueType=="CLOB"){
                                     hiddenCol[hidIndex] = result.data[0][i].key+"_HIDDEN";
                                     hidIndex = hidIndex +1;
                                 }
                                 columnsHeader[i] = result.data[0][i].key;
                             }
                             
                             //隐藏域
                          for(var i=0; i<hidIndex;i++){
                                var column = {};
                                column["display"] = hiddenCol[i];
                                column["name"] = hiddenCol[i];
                                column["minWidth"] = "0.00001";
                                column["width"] = "0.00001";
                                column["isAllowHide"] = false;
                                column["hide"]=true;
                                columns[columns.length+i] =column;
                             } 
                             //设置表头
                          dtGridHeader = columnsHeader;
                          dtGridHeaderName=columnsHeader;
                          changeColumns = columns;
                         }else{
                             dtGridHeader = new Array();
                             dtGridHeaderName = new Array();
                             $("#maingrid").show();
                         }
                         
                         if(grid == null){
                             grid = $("#maingrid").ligerGrid({
                                 columns : changeColumns,
                                 width : '100%',
                                 pkName : 'id',
                                 pageSizeOptions : [ 10,20,50,100,200],
                                 height : 353,
                                 isScroll:true,
                                 url:"<%=webpath%>/queryData.action",
                                 newPage:1,
                                 onDblClickRow:f_onDblClickRow,
                                 param : {
                                     database: liger.get('database1').getValue(),
                                     sql : $("#sqls").val()
                                 }
                             });
                         }else{
                             grid.set({ columns: changeColumns,newPage:1}); 
                             grid.loadData(true); //重新查询，返回json记录集 
                         }
                     }
                 });
                 return;
                }
                var url = "<%=webpath%>/executeSql.action";
                $.ajax({
                    type : "POST",
                    url : url,
                    data : {
                        database: liger.get('database1').getValue(),
                        sql : $("#sqls").val()
                    },
                    dataType : "json",
                    success:function (result){
                        manager.close();
                        if(result.resp_code == "1"){
                            var url = "<%=webpath %>/page/showDetail.jsp";
                           url = url + "?time="+new Date();
                            document.getElementById("detailMsg").value=result.resp_msg;
                            $.ligerDialog.open({ url: url, height:200,width: 500, buttons:   [ { text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
                        }else if(result.execute_type=="insert"){
                             $.ligerDialog.success('成功插入'+result.cnt+"条记录！");
                        }else if(result.execute_type=="update"){
                             $.ligerDialog.success('成功更新'+result.cnt+"条记录！");
                        }else if(result.execute_type=="delete"){
                            $.ligerDialog.success('成功删除'+result.cnt+"条记录！");
                        }
                    }
                });
            });
            
            
            function f_render(rowdata, rowindex, value){
                if(value.valueType=="CLOB"){
                    return "<a href='javascript:void(0)' onclick=\"javascript:showMsg("+rowindex+",'"+value.key+"');\">CLOB</a>";
                }else{
                    return "<font title='"+value.value+"'>"+value.value+"</font>";
                }
            }
            
          //导出
            $("#export_button").bind('click', function () {
                if($("#sqls").val()=="") {
                    $.ligerDialog.alert('执行SQL不能为空', '提示', 'warn');
                    return;
                }
                if($("#database1").val()=="") {
                    $.ligerDialog.alert('请选择数据库', '提示', 'warn');
                    return;
                }
                $("#database").val(liger.get('database1').getValue());
                $("#sql").val($("#sqls").val());
                var url = "<%=webpath %>/exportResult.action";
                document.forms[0].action=url;
                document.forms[0].submit();
            });
          
          //选择模板
            $("#select_template_button").bind('click', function () {
                if(liger.get('database1').getValue()=="") {
                    $.ligerDialog.alert('请选择数据库', '提示', 'warn');
                    return;
                }
                $("#database").val(liger.get('database1').getValue());
                var url = "<%=webpath %>/page/getTemplate.jsp";
                url = url + "?time="+new Date();
                $.ligerDialog.open({ url: url, height:450,width: 800, title:'选择模板',buttons:   [{ text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
            });
            
            //另存为模板
            $("#save_template_button").bind('click', function () {
                if(liger.get('database1').getValue()=="") {
                    $.ligerDialog.alert('请选择数据库', '提示', 'warn');
                    return;
                }
                if($("#sqls").val()=="") {
                    $.ligerDialog.alert('执行SQL不能为空', '提示', 'warn');
                    return;
                }
                $.ligerDialog.prompt('输入模板名称', true, function(yes, value) {
                    if (yes){
                        if(value.trim() == ""){
                            $.ligerDialog.alert('模板名称不能为空', '提示', 'warn');
                            return;
                        }
                        $.ajax({
                            type : "POST",
                            url : "<%=webpath%>/saveTemplate.action",
                            data : {
                                database: liger.get('database1').getValue(),
                                sql : $("#sqls").val(),
                                templateName:value
                            },
                            dataType : "json",
                            success:function (result){
                                if(result.resp_code == "1"){
                                    var url = "<%=webpath %>/page/showDetail.jsp";
                                   url = url + "?time="+new Date();
                                    document.getElementById("detailMsg").value=result.resp_msg;
                                    $.ligerDialog.open({ url: url, height:200,width: 500, buttons:   [ { text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
                                }else{
                                    $.ligerDialog.success('模板存储成功 ！模板ID：'+result.templateId);
                                    $("#templateId").val(result.templateId);
                                }
                            }
                        });
                    }
                });
            });
            
          //删除模板
            $("#delete_template_button").bind('click', function () {
                if($("#templateId").val()=="") {
                    $.ligerDialog.alert('不是模板，不能删除!', '提示', 'warn');
                    return;
                }
                 $.ajax({
                     type : "POST",
                     url : "<%=webpath%>/deleteTemplate.action",
                     data : {
                         templateId : $("#templateId").val()
                     },
                     dataType : "json",
                     success:function (result){
                         if(result.resp_code == "1"){
                             var url = "<%=webpath %>/page/showDetail.jsp";
                            url = url + "?time="+new Date();
                             document.getElementById("detailMsg").value=result.resp_msg;
                             $.ligerDialog.open({ url: url, height:200,width: 500, buttons:   [ { text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
                         }else{
                             $.ligerDialog.success('模板删除成功 ！模板ID:'+$("#templateId").val());
                             $("#templateId").val("");
                         }
                     }
                 });
            });
        });
        
        function showMsg(indext,colmn){
           var row = grid.getRow(indext);
           var url = "<%=webpath %>/page/showDetail.jsp";
          url = url + "?time="+new Date();
          document.getElementById("detailMsg").value=row[colmn].value;
         $.ligerDialog.open({ url: url, height:450,width: 700, title:'CLOB明细信息',buttons:   [ { text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
        }
        
        function showMsg1(val){
            var url = "<%=webpath %>/page/showDetail.jsp";
           url = url + "?time="+new Date();
           document.getElementById("detailMsg").value=val;
          $.ligerDialog.open({ url: url, height:450,width: 700, title:'CLOB明细信息',buttons:   [ { text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
         }
        
    </script>
</head>
<form enctype="multipart/form-data" method="post"> 
<input type="hidden" name="database" id="database"/>
<input type="hidden" name="sql" id="sql"/>
<input type="hidden" name="templateId" id="templateId"/>
<input type="hidden" name="detailMsg" id="detailMsg"/>
<body style="padding:6px; overflow:hidden;">
    <table width="80%">
        <tr align="left">
            <td align="right" width="10%">数据库：</td>
            <td>
                <table>
                    <tr>
                        <td><input id="database1" type="text"></td>
                        <td>&nbsp;</td>
                        <td><div id="select_template_button" class="liger-button" data-width="100">模板</div></td>
                    </tr>
                </table>
            </td>
            
        </tr>
        
        <tr>
            <td align="right" width="10%">执行SQL：</td>
            <td colspan="1"><br />
                <table width="100%">
                    <tr>
                        <td width="80%"><textarea rows="8"
                        cols="8" style="width: 100%;overflow-y:visible;"
                        id="sqls" name="sqls"></textarea></td>
                        <td>&nbsp;</td>
                        <td><div id="save_template_button" class="liger-button" data-width="150">存为模板</div></td>
                        <td><div id="delete_template_button" class="liger-button" data-width="150">删除模板</div></td>
                    </tr>
                </table>
                
            </td>
        </tr>
        <tr align="center">
           <td align="center" colspan="2"><br />
                <table>
                    <tr align="center">
                        <td>
                            <div id="select_button" class="liger-button" data-width="100">查询</div>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <div id="export_button" class="liger-button" data-width="100">导出</div>
                        </td>
                    </tr>
                </table>
           </td>
        </tr>
    </table>
    <!-- 这里目前调整了Firefox、IE7、8、9的样式 -->
    <div id="maingrid"  style="*+margin-top:1.5%;margin-top:1.5%\0;bottom:0px;"></div><!-- *+margin-top:0.2%;margin-top:0.2%\0; -->
  <div style="display:none;">
  <!-- g data total ttt -->
</div>
 
</body>
</form>
</html>
