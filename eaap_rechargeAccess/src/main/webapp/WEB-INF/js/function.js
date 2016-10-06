function showtime()
    {
    var today,hour,second,minute,year,month,date;
    var strDate ;
       today=new Date();
     var n_day = today.getDay();
     switch (n_day)
     {
     case 0:{
     strDate = "星期日";
     }break;
     case 1:{
     strDate = "星期一";
     }break;
     case 2:{
     strDate ="星期二";
     }break;
     case 3:{
     strDate =  "星期三";
     }break;
     case 4:{
     strDate =  "星期四";
     }break;
     case 5:{
     strDate =  "星期五";
     }break;
     case 6:{
     strDate =  "星期六";
     }break;
     case 7:{
     strDate =  "星期日";
     }break;
     }
     //alert(today.getYear());
    year = today.getYear();
    if(parseInt(year)<1900){
    	year = today.getYear()+1900;
    }
    month = today.getMonth()+1;
    if(month <10){
    	month = "0"+month;
    }
    date = today.getDate();
    if(date <10){
    	date = "0"+date;
    }
    hour = today.getHours();
    if(hour <10){
    	hour = "0"+hour;
    }
    minute =today.getMinutes();
    if(minute <10){
    	minute = "0"+minute;
    }
    second = today.getSeconds();
    if(second <10){
    	second = "0"+second;
    }
    document.getElementById('time').innerHTML = "当前时间："+year + "年" + month + "月" + date + "日 " +  strDate +" " + hour + ":" + minute + ":" + second; //显示时间
    setTimeout("showtime();", 1000); //设定函数自动执行时间为 1000 ms(1 s)
    }
    function f_heightChanged(options)
    {  
        if (tab)
            tab.addHeight(options.diff);
        if (accordion && options.middleHeight - 24 > 0)
            accordion.setHeight(options.middleHeight - 24);
    }
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
    function addShowCodeBtn(tabid)
    {
        var viewSourceBtn = $('<a class="viewsourcelink" href="javascript:void(0)">查看源码</a>');
        var jiframe = $("#" + tabid);
        viewSourceBtn.insertBefore(jiframe);
        viewSourceBtn.click(function ()
        {
            showCodeView(jiframe.attr("src"));
        }).hover(function ()
        {
            viewSourceBtn.addClass("viewsourcelink-over");
        }, function ()
        {
            viewSourceBtn.removeClass("viewsourcelink-over");
        });
    }
    function showCodeView(src)
    {
        $.ligerDialog.open({
            title : '源码预览',
            url: 'dotnetdemos/codeView.aspx?src=' + src,
            width: $(window).width() *0.9,
            height: $(window).height() * 0.9
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
    var skin_links = {
        "aqua": "lib/ligerUI/skins/Aqua/css/ligerui-all.css",
        "gray": "lib/ligerUI/skins/Gray/css/all.css",
        "silvery": "lib/ligerUI/skins/Silvery/css/style.css",
        "gray2014": "lib/ligerUI/skins/gray2014/css/all.css"
    };
    function pages_init()
    {
        var tabJson = $.cookie('liger-home-tab'); 
        if (tabJson)
        { 
            var tabitems = JSON2.parse(tabJson);
            for (var i = 0; tabitems && tabitems[i];i++)
            { 
                f_addTab(tabitems[i].tabid, tabitems[i].text, tabitems[i].url);
            } 
        }
    }
    function saveTabStatus()
    { 
        $.cookie('liger-home-tab', JSON2.stringify(tabItems));
    }
    function css_init()
    {
        var css = $("#mylink").get(0), skin = getQueryString("skin");
        $("#skinSelect").val(skin);
        $("#skinSelect").change(function ()
        { 
            if (this.value)
            {
                location.href = "index.htm?skin=" + this.value;
            } else
            {
                location.href = "index.htm";
            }
        });

       
        if (!css || !skin) return;
        skin = skin.toLowerCase();
        $('body').addClass("body-" + skin); 
        $(css).attr("href", skin_links[skin]); 
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
    function getLinkPrevHref(iframeId)
    {
        if (!window.frames[iframeId]) return;
        var head = window.frames[iframeId].document.getElementsByTagName('head').item(0);
        var links = $("link:first", head);
        for (var i = 0; links[i]; i++)
        {
            var href = $(links[i]).attr("href");
            if (href && href.toLowerCase().indexOf("ligerui") > 0)
            {
                return href.substring(0, href.toLowerCase().indexOf("lib") );
            }
        }
    }
    