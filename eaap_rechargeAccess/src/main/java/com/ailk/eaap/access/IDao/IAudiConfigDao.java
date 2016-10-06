package com.ailk.eaap.access.IDao;

import java.util.List;

import com.ailk.eaap.access.model.AudiConfigBean;
import com.ailk.eaap.access.model.MenuBean;

public interface IAudiConfigDao {

	public AudiConfigBean query();

	public List<MenuBean> queryMenuList();
	
	
	
}
