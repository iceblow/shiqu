package com.daoshun.shiqu.controller.admin;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.daoshun.shiqu.pojo.SaleStatistics;
import com.daoshun.shiqu.service.AccountService;

@Controller
@RequestMapping("/manage")
public class ManageCountController {
	
	@Resource(name="accountService")
	AccountService accountService;

	@RequestMapping("/allsalecount")
	public ModelAndView allsalecount(Integer type, HttpSession session,HttpServletRequest request){
		ModelAndView mov = new ModelAndView();
//		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(type==null){
			type = 1;
		}
		List<SaleStatistics> salelist =  accountService.getSaleList(type, 0);
		mov.addObject("type", type);
		request.setAttribute("salelist", salelist);
		mov.setViewName("manage/allsalecount");
		return mov;
	}
	
	@RequestMapping("/solosalecount")
	public ModelAndView solosalecount(Integer store_id, Integer type, HttpSession session,HttpServletRequest request){
		ModelAndView mov = new ModelAndView();
		if(type==null){
			type = 1;
		}
		List<SaleStatistics> salelist =  accountService.getSaleList(type, store_id);
		mov.addObject("type", type);
		request.setAttribute("salelist", salelist);
		request.setAttribute("store_id", store_id);
		mov.setViewName("manage/solosalecount");
		return mov;
	}
}
