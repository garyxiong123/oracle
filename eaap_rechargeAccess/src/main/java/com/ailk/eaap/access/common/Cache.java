package com.ailk.eaap.access.common;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.ailk.eaap.access.model.MenuBean;

/**
 * @author gary
 * @date   2016年10月2日
 * @tags   
 * @projec eaap_rechargeAccess
 * 从数据库读出缓存
 */
@Repository
public class Cache {

	 @Autowired
     @Qualifier("jdbcTemplate")
private static JdbcTemplate jdbcTemplate;
	/**
	 * 菜单结果缓存
	 */
	private static List<MenuBean> menuBeans;
	
	public static String url="";
	public static String driver="";
	public static String username="";
	public static String password="";
	public final Properties properties=new Properties();
	
	
	static{
 //通过jdbc从数据里读出缓存

		
	}
	
	
	
	

	public static List<MenuBean> getMenuBeans() {
		if(menuBeans==null){
			String sql="select   rownum as rn, t1.menu_id,t1.menu_name,t1.url ,t2.menu_name as parentName,t1.parent_id , ( select count(1) from menu t5 where t1.menu_id=t5.parent_id) childCnt  from  menu t1 left join menu t2 on t1.parent_id=t2.menu_id";
	
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
					menuBean.setUrl(rs.getString("url"));
					return menuBean;
				}
				
			});
		}
		return menuBeans;
	}

	public void setMenuBeans(List<MenuBean> menuBeans) {
		this.menuBeans = menuBeans;
	}
	
	
	
	
	
	
	public static void main(String[] args) {
		
//	   Properties.class.
		
		
		
		
	}
	
	
	
	
	
}
