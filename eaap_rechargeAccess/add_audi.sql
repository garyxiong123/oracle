select * from AUDI_CACHE

select * from AUDICONFIG
##菜单表格


   treeData.push({ id: 9000001,pid: 9000000,text: '菜单管理',url:'<%=webpath%>/page/MenuManage.jsp'});
//菜单表字段   id  pid   name  url

create table menu (menu_id number(5),parent_id number(5),menu_name varchar2(50),url varchar2(50) )