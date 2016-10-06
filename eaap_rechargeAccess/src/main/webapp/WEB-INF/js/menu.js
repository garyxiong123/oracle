var tab;
var tabItems = [];

$(function(){
	alert("ss");
 	var url = "query/queryMenuList";
 	var treeData=[];
 	$.ajax({
 		type:"POST",
 		url:url,
 	dataType:"json",
 	success:function(data){
 		alert(data);
 		  //拼接树字符串

 //childCnt>0的那就是主菜单
        for(var i=0; i<data.length;i++){
        	if(parseInt(data[i].childCnt)>0){
        		 var ss = { id: data[i].menuId, pid: data[i].parentId, text: data[i].menuName};
                 treeData.push(ss);
        	}else{
        		 var ss = { id: data[i].menuId, pid: data[i].parentId, text: data[i].menuName,url:'<%=webpath%>'+data[i].url+"?condition="+data[i].menuId};
                 treeData.push(ss);
                 
        	}
        }
 		
 		 //增加系统管理
 	    treeData.push({ id: 9000000,  pid: '0',text: '系统管理'});
 	    
 	    treeData.push({ id: 9000001,pid: 9000000,text: '菜单管理',url:'page/MenuManage.jsp'});
 	    treeData.push({ id: 9000002,pid: 9000000,text: '数据库管理',url:'page/dbManage.jsp'});
 	    treeData.push({ id: 9000003,pid: 9000000,text: '刷新缓存',url:'refresh.action'});
 	    treeData.push({ id: 9000003,pid: 9000000,text: '刷新测试 ',url:'refresh.action'});
 	 	
 	      $("#tree1").ligerTree({
 	          data : treeData,
 	          checkbox: false,
 	          slide: false,
 	          nodeWidth: 300,
 	          idFieldName :'id',
 	          parentIDFieldName :'pid',
 	          attribute: ['nodename', 'url'],
 	          onSelect: function (node)
 	          {
 	        	   if (!node.data.url) return;
    	                var tabid = $(node.target).attr("tabid");
    	                if (!tabid)
    	                {
    	                    tabid = new Date().getTime();
    	                    $(node.target).attr("tabid", tabid)
    	                } 
    	                f_addTab(tabid, node.data.text, node.data.url);
 	        	  
 	        	  
 	             alert("被选了以后");
 	          }
 	      });
 		
 		
 	        //布局
 	        $("#layout1").ligerLayout({ leftWidth: 220, height: '100%',heightDiff:-34,space:4, onHeightChanged: f_heightChanged });

 	        var height = $(".l-layout-center").height();

 	        //Tab
 	        $("#framecenter").ligerTab({
 	            height: height,
 	            showSwitchInTab : true,
 	            showSwitch: true,
 	            onAfterAddTabItem: function (tabdata)
 	            {
 	                tabItems.push(tabdata);
 	                saveTabStatus();
 	            },
 	            onAfterRemoveTabItem: function (tabid)
 	            { 
 	                for (var i = 0; i < tabItems.length; i++)
 	                {
 	                    var o = tabItems[i];
 	                    if (o.tabid == tabid)
 	                    {
 	                        tabItems.splice(i, 1);
 	                        saveTabStatus();
 	                        break;
 	                    }
 	                }
 	            },
 	            onReload: function (tabdata)
 	            {
 	                var tabid = tabdata.tabid;
 	                addFrameSkinLink(tabid);
 	            }
 	        });

 	        //面板
 	        $("#accordion1").ligerAccordion({ height: height - 24, speed: null });

 	        $(".l-link").hover(function ()
 	        {
 	            $(this).addClass("l-link-over");
 	        }, function ()
 	        {
 	            $(this).removeClass("l-link-over");
 	        });
 	        	      
 	        tab = liger.get("framecenter");
 	        accordion = liger.get("accordion1");
 	        tree = liger.get("tree1");
 	        $("#pageloading").hide();

 	        css_init();
 	        //初始化加载
 	        //pages_init();
 	        
 	        showtime();
 	  
 		
 	
   
 	
 	
 	
 	
 	}
	


  
	
})



})











    // 增加tab页签 
    function f_addTab(tabid, text, url)
    {
        tab.addTabItem({
            tabid: tabid,
            text: text,
            url: url,
            callback: function ()
            {
                //addShowCodeBtn(tabid); 
                addFrameSkinLink(tabid); 
            }
        });
    }

function addFrameSkinLink(tabid)
{
    var prevHref = getLinkPrevHref(tabid) || "";
    var skin = getQueryString("skin");
    if (!skin) return;
    skin = skin.toLowerCase();
    attachLinkToFrame(tabid, prevHref + skin_links[skin]);
}



function getQueryString(name)
{
    var now_url = document.location.search.slice(1), q_array = now_url.split('&');
    for (var i = 0; i < q_array.length; i++)
    {
        var v_array = q_array[i].split('=');
        if (v_array[0] == name)
        {
            return v_array[1];
        }
    }
    return false;
}
function attachLinkToFrame(iframeId, filename)
{ 
    if(!window.frames[iframeId]) return;
    var head = window.frames[iframeId].document.getElementsByTagName('head').item(0);
    var fileref = window.frames[iframeId].document.createElement("link");
    if (!fileref) return;
    fileref.setAttribute("rel", "stylesheet");
    fileref.setAttribute("type", "text/css");
    fileref.setAttribute("href", filename);
    head.appendChild(fileref);
}
