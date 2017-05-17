package com.daoshun.shiqu.controller.shop;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.pojo.AreaInfo;
import com.daoshun.shiqu.service.CommonService;

@Controller
@RequestMapping("/shop")
public class ShopCommon {

	@Resource(name="commonService")
	CommonService commonService;
	
	@RequestMapping("/changeArea")
	public void changeArea(int id,HttpServletResponse response){
		Map<String, Object> result = new HashMap<String,Object>();
		List<AreaInfo> arealist = commonService.getAreaByParentid(id);
		result.put("arealist", arealist);
		CommonUtils.setMaptoJson(response, result);
	}
	
	
}
