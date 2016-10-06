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


</style>
<head>
    <title>查询管理页面</title>
    <link href="<%=webpath%>/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="<%=webpath%>/lib/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
    <link href="<%=webpath%>/lib/ligerUI/skins/Tab/css/form.css" rel="stylesheet" type="text/css" /> 
    
    <script src="<%=webpath%>/lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="<%=webpath%>/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
    <script src="<%=webpath%>/lib/ligerUI/js/jquery.json-2.2.js" type="text/javascript"></script>
    <script type="text/javascript">
    
        var grid = null;
        var fields=[];
        var params=[];
        var conditionName=[];
        var dtGridHeader = new Array();
        var dtGridHeaderName = new Array();
        var dtGridDataRow;
        var mustInput=[];
        var gridData=[];
        var columns=[];
        $(function () {
        	var url = "<%=webpath%>/queryPageItemList.action";
            $.ajax({
                type : "POST",
                url : url,
                dataType : "json",
                data:{condition:'<%=request.getAttribute("condition")%>'},
                success:function (data){
                    if(data.resp_code == '1'){
                        $.ligerDialog.success("查询页面元素失败，MSG="+data.resp_msg);
                        return;
                    }
                    //拼接查询条件
                 for(var i=0; i<data.condition.length;i++){
                    	var isnewline = false;
                    	if("Y"==data.condition[i].newline){
                    		isnewline = true;
                    	}
                    	var ss;
                    	if(data.condition[i].type=="date"){
                    		ss = {display:data.condition[i].label,
                                    name:data.condition[i].plname,
                                    newline:isnewline,
                                    labelAlign: 'right',
                                    type:"date",
                                    width:200,
                                    readonly:true,
                                    validate:{required:data.condition[i].required},
                                    editor : {
                                        format : data.condition[i].typeDateFormat,
                                        showTime:true
                                    }
                                    };
                    	}else {
                    		ss = {display:data.condition[i].label,
                                    name:data.condition[i].plname,
                                    width:200,
                                    labelAlign: 'right',
                                    newline:isnewline,
                                    type:data.condition[i].type,
                                    validate:{required:data.condition[i].required}};
                    	}
                        
                        mustInput.push({display:data.condition[i].label,name:data.condition[i].plname,required:data.condition[i].required,type:data.condition[i].type});
                    	fields.push(ss);
                    }
                    var isNewline=true;
                    if(data.condition.length%3 >0){
                    	isNewline = false;
                    }
                    var ss1 = {display : "数据库",name : "database",width:200,newline : isNewline,labelAlign: 'right',type : "select",validate:{required:true},
                        editor : {
                            type: 'select', 
                            url: '<%=webpath %>/listDataBase.action', 
                            valueField:'code', textField:'name',selectBoxHeight:270,
                            parms:{condition:'<%=request.getAttribute("condition")%>'},
                            onSuccess:function(data){
                            },
                            onBeforeOpen:function(){
                            	
                            }
                        }
                    };
                    mustInput.push({display:"数据库",name:"database",required:true})
                    fields.push(ss1);
                    
                    
                 // 创建搜索
                    form = $("#searchbar").ligerForm({
                        inputWidth : 150,
                        labelWidth : 120,
                        space : 15,
                        fields : fields
                        });
                 $("#search_button").show();
                 //创建查询结果
                 if(data.result ==null || data.result.length ==0){
                	 $.ligerDialog.success("未配置查询结果！");
                	 return;
                	}
                    var result=data.result[0];
                    var gridHtml = "<div id=' "+result.gridName+"' style='*+margin-top:1.5%;margin-top:1.5%\0;bottom:0px;'></div>";
                    $("#resultArea").html(gridHtml);
                    //拼接COLUMNS
                  
                    for(var i=0; i<result.columnList.length;i++){
                    	var cls = { display: result.columnList[i].display,
                    			     name: result.columnList[i].name, 
                    			     minWidth: parseInt(result.columnList[i].widht),
                    			     isSort:'N',
                    			     render:f_render};
                    	columns.push(cls);
                    	dtGridHeader[i]=result.columnList[i].display;
                    	dtGridHeaderName[i]=result.columnList[i].name;
                    }
                    
                    //参数
                  for(var i=0; i<data.condition.length;i++){
                    	var clname=data.condition[i].plname;
                    	if(mustInput[i].type =="date"){
                            params[clname]=$("input[name="+clname+"]").val();
                        }else{
                            params[clname]=liger.get(clname).getValue();
                        }
                    	
                    	conditionName[i]=clname;
                    }
                  params["database"]=liger.get("database").getValue();
                  params["condition"]='<%=request.getAttribute("condition")%>';
                    
                  grid = $("#"+result.gridName).ligerGrid({
                        height:"100%",width: "100%",
                        columns: columns,  pageSize:result.pageSize,
                        url : '<%=webpath %>/queryCommonList.action',
                        allowAdjustColWidth:true,
                        usePager:result.usepager,
                        onDblClickRow:f_onDblClickRow,
                        newPage:1,
                        toolbar: {items: [{ text: '导出EXCEL', click: itemclick, icon: 'down' }]},
                        delayLoad:true //初始化不加载
                    });
                  
                  gridData =result;
                }
            });
            
            function itemclick(item){
            	if (!grid) return;   
                var params1 ={};
                for(var i=0; i<mustInput.length;i++){
                    if(mustInput[i].required){
                         if(liger.get(mustInput[i].name).getValue() == null || liger.get(mustInput[i].name).getValue() ==''){
                             $.ligerDialog.warn(mustInput[i].display+"必须输入！");
                             return;
                         }
                    }
                    
                    if(mustInput[i].type =="date"){
                        params1[mustInput[i].name]=$("input[name="+mustInput[i].name+"]").val();
                    }else{
                        params1[mustInput[i].name]=liger.get(mustInput[i].name).getValue();
                    }
                    //alert(params1[mustInput[i].name]+","+mustInput[i].name);
                }

                params1["database"]=liger.get("database").getValue();
                params1["condition"]='<%=request.getAttribute("condition")%>';
              $("#exportCondition").val(jQuery.toJSON(params1));
              var url = "<%=webpath %>/export.action";
               document.forms[0].action=url;
               document.forms[0].submit();
            }
            
            //查询
            $("#select_button").bind('click', function () {
                if (!grid) return;   
                var params1 ={};
                for(var i=0; i<mustInput.length;i++){
                	if(mustInput[i].required){
                		 if(liger.get(mustInput[i].name).getValue() == null || liger.get(mustInput[i].name).getValue() ==''){
                             $.ligerDialog.warn(mustInput[i].display+"必须输入！");
                             return;
                         }
                	}
                	
                	if(mustInput[i].type =="date"){
                        params1[mustInput[i].name]=$("input[name="+mustInput[i].name+"]").val();
                    }else{
                        params1[mustInput[i].name]=liger.get(mustInput[i].name).getValue();
                    }
                	//alert(params1[mustInput[i].name]+","+mustInput[i].name);
                }

                params1["database"]=liger.get("database").getValue();
                params1["condition"]='<%=request.getAttribute("condition")%>';
                
                //var parm111 ={database:liger.get("database").getValue(),condition:'<%=request.getAttribute("condition")%>'};
                grid.setOptions({ 
                    parms : {reqParams:jQuery.toJSON(params1)},
                     newPage:1 
                   }); //这里是一堆查询条件
                //grid.loadData(true); //重新查询，返回json记录集 
               grid.reload();
                
            });
            
            //重置
            $("#reset_button").bind('click', function () {
            	for(var i=0; i<mustInput.length;i++){
            		liger.get(mustInput[i].name).setValue('');
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
         
         function f_onDblClickRow(rowdata, rowindex, rowDomElement){
             var url = "<%=webpath %>/page/showRowDetail.jsp";
             url = url + "?time="+new Date();
             dtGridDataRow=rowdata;
            $.ligerDialog.open({ url: url, height:500,width: 800, title:'行明细信息',buttons:   [ { text:  '关闭', onclick: function (item, dialog) { dialog.close(); } } ] });
          }
    </script>
</head>

<form enctype="multipart/form-data"> 
<input type="hidden" name="detailMsg" id="detailMsg"/>
<input type="hidden" name="exportCondition" id="exportCondition"/>
<body style="padding:6px; overflow:hidden;">

    <table width="90%"><tr>
    <td id="searchbar">
    </td>
    </tr>
    <tr>
        <td align="center">
            <table>
                <tr>
                <td>&nbsp;</td>
                </tr>
                <tr id="search_button" style="display: none;">
                    <td>
                        <div id="select_button" class="liger-button" data-width="100">查询</div>
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <div id="reset_button" class="liger-button" data-width="100">重置</div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    </table>
    <!-- 这里目前调整了Firefox、IE7、8、9的样式 -->
    <font id="resultArea">
        <!-- *+margin-top:0.2%;margin-top:0.2%\0; -->
    </font>
   <div id="${gridName}"  style="*+margin-top:1.5%;margin-top:1.5%\0;bottom:0px;"></div><!-- *+margin-top:0.2%;margin-top:0.2%\0; -->

  <div style="display:none;">
  <!-- g data total ttt -->
</div>
 
</body>
</form>
</html>
