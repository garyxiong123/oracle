select * from AUDI_CACHE

select * from AUDICONFIG
##菜单表格


   treeData.push({ id: 9000001,pid: 9000000,text: '菜单管理',url:'<%=webpath%>/page/MenuManage.jsp'});
//菜单表字段   id  pid   name  url



create table menu (menu_id number(5),parent_id number(5),menu_name varchar2(50),url varchar2(50) )


insert into menu values (6,2,'csb稽核管理','dd' )
insert into menu values (5,1,'csb稽核管理','dd' )


select t.*,rowid from menu t



"SELECT rownum as rn,t3.result_id,t1.MENU_ID,t1.MENU_NAME,t2.menu_name as parentName,t1.PARENT_ID,t1.URL,t1.STATE,");
		sql.append(" (select count(1) from web_db_menu t4 where t1.menu_id=t4.parent_id) childCnt ");
		sql.append(" FROM web_db_menu t1 left join web_db_menu t2 on t2.menu_id=t1.PARENT_ID left join page_result t3 on t1.menu_id=t3.menu_id WHERE t1.STATE='A'");
		if(menuName != null && !"".equals(menuName)){
    
    select   rownum as rn, t1.menu_id,t1.menu_name,t1.url ,t2.menu_name as parentName,t1.parent_id ,
    
   ( select count(1) from menu t5 where t1.menu_id=t5.parent_id) childCnt 
    
    from  menu t1 left join menu t2 on t1.parent_id=t2.menu_id
