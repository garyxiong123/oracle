package com.ailk.eaap.access.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.http.HttpRequest;
import org.springframework.jms.connection.UserCredentialsConnectionFactoryAdapter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;


@Controller
@RequestMapping("/msg")
public class SampleController extends BaseController{
	private Logger logger = Logger.getLogger(this.getClass());
// http://localhost:8080/eaap_rechargeAccess/msg/add?gary=dd
//	private ISampleSMO iSampleSMO;
	
	@RequestMapping(value="add",method=RequestMethod.GET)
	public String add(Model model,@RequestParam("gary") String gary,@RequestHeader("Accept-Encoding") String encoding){
		System.out.println("excute the baisc");
		System.out.println(encoding);
		System.out.println("thre requestParam is "+gary);
		logger.debug("start to excute the add mehtod");
		User user=new User();
		user.setAge("23");
		user.setName("xiong");
		model.addAttribute(user);
		return "index";
	}
	
	//restfull传值
	@RequestMapping("addValue/{id}")
	public String addValue(@PathVariable String id){
		System.out.println(id);
		return "index";
	}
	
	
	//xml以string形式传入，然后 以String的形式传出
	@RequestMapping(value="dd",method=RequestMethod.POST)
	@ResponseBody
	public String getInfo(HttpServletRequest request,@RequestBody String rep) throws IOException{
	String repXml=getInputParameter(request);
	System.out.println(rep);
		System.out.println("excute the post method and ");
//		System.out.println(params.size());
		return repXml;
	}
	
	
	//xml以string形式传入，然后 以String的形式传出
	@RequestMapping(value="mm",method=RequestMethod.POST)
	@ResponseBody
	public String getRequestInfo(@RequestBody String rep) throws IOException{
	
	System.out.println(rep);
		System.out.println("excute the post method and ");
//		System.out.println(params.size());
		return rep;
	}
	
	

	@RequestMapping(value="json",method=RequestMethod.POST)
	@ResponseBody
	public User getJson(@RequestBody User ss){
	System.out.println(ss.getAge());
		User user=new User();
		user.setName("gary");
		user.setAge("23");
		return user;
	}
	
	
	//以json传入 然后以json输出   这个 地方 POST的时候 必须指定 application/json否则会以text传递
	@RequestMapping(value="jsonText",method=RequestMethod.POST)
	@ResponseBody
	public User getJsonText(@RequestBody String ss){
	System.out.println(ss);
		User user=new User();
		user.setName("gary");
		user.setAge("23");
		return user;
	}
	
	
	
	private String getInputParameter(HttpServletRequest request) throws IOException{
		InputStream in=request.getInputStream();
		BufferedReader br=new BufferedReader(new InputStreamReader(in,"UTF-8"));
		String line=null;
		StringBuffer sb=new StringBuffer();
				while((line=br.readLine())!=null){
					
					sb.append(line);
				}
		return sb.toString();
	}
}
