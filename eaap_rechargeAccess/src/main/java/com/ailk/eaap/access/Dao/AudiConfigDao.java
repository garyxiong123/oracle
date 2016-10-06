package com.ailk.eaap.access.Dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.ailk.eaap.access.IDao.IAudiConfigDao;
import com.ailk.eaap.access.model.AudiConfigBean;
import com.ailk.eaap.access.model.MenuBean;
@Repository 
public class AudiConfigDao implements IAudiConfigDao{
	
	public static List<MenuBean> menuBeans;
	
	 @Autowired
     @Qualifier("jdbcTemplate")
private JdbcTemplate jdbcTemplate;
	public AudiConfigBean query() {
		// TODO Auto-generated method stub
		String sql="select count(*) from AUDICONFIG";
		int num =jdbcTemplate.queryForInt(sql);
		System.out.println(num);
		AudiConfigBean audiConfigBean=new AudiConfigBean();
		audiConfigBean.setDescription("ss");
		audiConfigBean.setName("hname");
		audiConfigBean.setValue(3);
		
		return audiConfigBean;
	}
	
	
	
	

	public List<MenuBean> queryMenuList() {
		if(menuBeans==null){
			String sql="select   rownum as rn, t1.menu_id as menuId ,t1.menu_name as menuname,t1.url ,t2.menu_name as parentName,t1.parent_id , ( select count(1) from menu t5 where t1.menu_id=t5.parent_id) childCnt  from  menu t1 left join menu t2 on t1.parent_id=t2.menu_id";
	
			menuBeans=jdbcTemplate.query(sql, new RowMapper<MenuBean>(){
//通过sql要知道  改bean的父类id，名称 ，子类的个数
				public MenuBean mapRow(ResultSet rs, int rowNum)
						throws SQLException {
					// TODO Auto-generated method stub
					MenuBean menuBean=new MenuBean();
					menuBean.setChildCnt(rs.getInt("childCnt"));
					menuBean.setMenuId(rs.getString("menuId"));
					menuBean.setMenuName(rs.getString("menuName"));
//					menuBean.setText(text);
					menuBean.setParentName(rs.getString("parentName"));
					menuBean.setRownum(rs.getString("rn"));
					menuBean.setParentId(rs.getString("parent_Id"));
					menuBean.setUrl(rs.getString("url"));
					return menuBean;
				}
				
			});
		}
	
		return menuBeans;
	}

	
	
	
	
	
	
	
	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}





}
