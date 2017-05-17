package com.daoshun.shiqu.controller.shop;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.common.Constants;
import com.daoshun.shiqu.common.JpushClientUtil;
import com.daoshun.shiqu.common.QueryResult;
import com.daoshun.shiqu.controller.ApiBaseController;
import com.daoshun.shiqu.pojo.Coupon;
import com.daoshun.shiqu.pojo.MessageInfo;
import com.daoshun.shiqu.pojo.MyCoupon;
import com.daoshun.shiqu.pojo.PushInfo;
import com.daoshun.shiqu.pojo.UserInfo;
import com.daoshun.shiqu.service.CouponService;
import com.daoshun.shiqu.service.UserService;

@Controller
@RequestMapping("/shop")
public class UserManage extends ApiBaseController{

	@Resource(name = "userService")
	UserService userService;
	
	@Resource(name="couponService")
	CouponService couponService;
	
	@RequestMapping("/usermanage")
	public ModelAndView usermanage(Integer pageIndex, String keyword, HttpSession session){
		ModelAndView mov = new ModelAndView();
		if(pageIndex == null){
			pageIndex = 1;
		}
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		QueryResult<UserInfo> result = userService.getUserListByStorePage(1, shopid, keyword, pageIndex, Constants.SHOPLISTNUM);
		if(result.getDataList() == null || result.getDataList().size() == 0){
			if(pageIndex > 1){
				pageIndex--;
				mov.setViewName("redirect:/shop/usermanage?pageIndex="+pageIndex);
				return mov;
			}
		}
		List<UserInfo> userlist = result.getDataList();
		long pageCount = (result.getTotal() + (Constants.SHOPLISTNUM - 1)) / Constants.SHOPLISTNUM;
		List<Coupon> couponlist = couponService.getCouponList(shopid);
		mov.addObject("userlist", userlist);
		mov.addObject("couponlist", couponlist);
		mov.addObject("pageCount", pageCount);
		mov.addObject("pageIndex", pageIndex);
		mov.addObject("keyword", keyword);
		mov.addObject("total", result.getTotal());
		mov.setViewName("shop/userlist");
		return mov;
	}
	
	@RequestMapping("/sendmessagelist")
	public void sendmessagelist(String user_id, String title, String messagecontent, HttpServletResponse response, HttpSession session){
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(!CommonUtils.isEmptyString(user_id)){
			String user_ids = "";
			String[] idlist = user_id.split(",");
			if(idlist != null && idlist.length > 0){
				for (String idstr : idlist) {
					UserInfo userinfo = userService.getUserInfo(CommonUtils.parseLong(idstr, 0));
					if(userinfo != null){
						PushInfo pushinfo = userService.getPushInfoByUser(userinfo.getUser_id());
						if(pushinfo != null){
							if(pushinfo.getIs_receive() == 0){
								JpushClientUtil jPushClientUtil = new JpushClientUtil();
								jPushClientUtil.sendMsgPush(pushinfo.getClient_id());
							}
						}
						if(CommonUtils.isEmptyString(user_ids)){
							user_ids = userinfo.getUser_id()+"";
						}else{
							user_ids = user_ids + ","+userinfo.getUser_id();
						}
					}
				}
				MessageInfo messageinfo = new MessageInfo();
				messageinfo.setContent(messagecontent);
				messageinfo.setTitle(title);
				messageinfo.setStore_id(shopid);
				messageinfo.setUser_ids(user_ids);
				messageinfo.setAddtime(new Date());
				userService.addMessageInfo(messageinfo);
			}
		}
		CommonUtils.setResponseStr("success", response);
	}
	
	@RequestMapping("/distriCouponlist")
	public void distriCouponlist(String user_id, String coupon_ids, HttpServletResponse response, HttpSession session){
//		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(!CommonUtils.isEmptyString(user_id)){
			String[] idlist = user_id.split(",");
			if(idlist != null && idlist.length > 0){
				for (String idstr : idlist) {
					UserInfo userinfo = userService.getUserInfo(CommonUtils.parseLong(idstr, 0));
					if(userinfo != null){
						if(!CommonUtils.isEmptyString(coupon_ids)){
							String[] couponlist = coupon_ids.split(",");
							if(couponlist != null && couponlist.length > 0){
								for (String couponstr : couponlist) {
									Coupon coupon = couponService.getCouponById(CommonUtils.parseLong(couponstr, 0));
									if(coupon != null){
										MyCoupon mycoupon = couponService.getMyCouponByCU(userinfo.getUser_id(), coupon.getCoupon_id());
										if(mycoupon == null){
											MyCoupon myCoupon = new MyCoupon();
											myCoupon.setCoupon(coupon);
											myCoupon.setCoupon_no(CommonUtils.makeRandomNo());
											myCoupon.setIs_used(0);
											myCoupon.setUser_id(userinfo.getUser_id());
											couponService.addMyCoupon(myCoupon);
											PushInfo pushinfo = userService.getPushInfoByUser(userinfo.getUser_id());
											if(pushinfo != null){
												if(pushinfo != null){
													if(pushinfo.getIs_receive() == 0){
														JpushClientUtil jPushClientUtil = new JpushClientUtil();
														jPushClientUtil.sendCouponPush(pushinfo.getClient_id());
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
		CommonUtils.setResponseStr("success", response);
	}
}
