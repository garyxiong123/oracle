package com.ailk.eaap.access.IService;

import java.util.List;

import com.ailk.eaap.access.model.AudiConfigBean;
import com.ailk.eaap.access.model.MenuBean;

public interface IAudiConfigService {

	public AudiConfigBean query() ;

	public List<MenuBean> queryMenuList();

}
