package com.daoshun.shiqu.controller.shop;

import java.text.NumberFormat;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.pojo.ChargeStatistics;
import com.daoshun.shiqu.pojo.MenuStatistics;
import com.daoshun.shiqu.pojo.SaleStatistics;
import com.daoshun.shiqu.service.AccountService;

@Controller
@RequestMapping("/shop")
public class CountManage {

	@Resource(name="accountService")
	AccountService accountService;
	
	@RequestMapping("/salecount")
	public ModelAndView salecount(Integer type, HttpSession session,HttpServletRequest request){
		ModelAndView mov = new ModelAndView();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(type==null){
			type = 1;
		}
		List<SaleStatistics> salelist =  accountService.getSaleList(type, shopid);
		mov.addObject("type", type);
		request.setAttribute("salelist", salelist);
		return mov;
	}
	
	
	@RequestMapping("/chargecount")
	public ModelAndView chargecount(Integer type, HttpSession session,HttpServletRequest request){
		ModelAndView mov = new ModelAndView();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(type==null){
			type = 1;
		}
		List<ChargeStatistics> chargelist =  accountService.getChargeList(type, shopid);
		mov.addObject("type", type);
		request.setAttribute("chargelist", chargelist);
		return mov;
	}
	
	@RequestMapping("/menucount")
	public ModelAndView menucount(Integer type,HttpSession session,HttpServletRequest request){
		ModelAndView mov = new ModelAndView();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(type==null){
			type = 1;
		}
		List<MenuStatistics> menulist =  accountService.getMenuList(type, shopid);
		long menucount = accountService.getMenuCount(type, shopid);
		mov.addObject("type", type);
		request.setAttribute("menucount", menucount);
		request.setAttribute("menulist", menulist);
		return mov;
	}
}
