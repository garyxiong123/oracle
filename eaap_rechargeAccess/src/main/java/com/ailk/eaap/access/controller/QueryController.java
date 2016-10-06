package com.ailk.eaap.access.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ailk.eaap.access.IService.IAudiConfigService;
import com.ailk.eaap.access.common.Cache;
import com.ailk.eaap.access.model.AudiConfigBean;
import com.ailk.eaap.access.model.MenuBean;
@Controller
@RequestMapping("/query")
public class QueryController {
	@Autowired
	IAudiConfigService audiConfigService;
	
	@RequestMapping(value="audiConfig",method=RequestMethod.POST)
	@ResponseBody
	public AudiConfigBean quryAudiConfig(){
		
		AudiConfigBean audiConfigBean=audiConfigService.query();
		return audiConfigBean;
	}
	
	
	
	@RequestMapping(value="queryMenuList",method=RequestMethod.POST)
	@ResponseBody
	public List<MenuBean> queryMenuList(){
		List<MenuBean> menuBeanList=new ArrayList<MenuBean>();
		menuBeanList=audiConfigService.queryMenuList();
		return menuBeanList;
	}
	
	
	
	
	
	
}
