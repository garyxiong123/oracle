package com.ailk.eaap.access.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ailk.eaap.access.IDao.IAudiConfigDao;
import com.ailk.eaap.access.IService.IAudiConfigService;
import com.ailk.eaap.access.model.AudiConfigBean;
import com.ailk.eaap.access.model.MenuBean;
@Service
public class AudiConfigService implements IAudiConfigService{
	@Autowired
IAudiConfigDao iAudiConfigDao;
	public AudiConfigBean query() {
		// TODO Auto-generated method stub
		;
		return iAudiConfigDao.query();
	}
	public List<MenuBean> queryMenuList() {
		// TODO Auto-generated method stub
		return iAudiConfigDao.queryMenuList();
	}

}
