package com.daoshun.shiqu.controller.wap;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.daoshun.exception.CustomException;
import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.common.Constants;
import com.daoshun.shiqu.common.QueryResult;
import com.daoshun.shiqu.pojo.Coupon;
import com.daoshun.shiqu.pojo.MyCoupon;
import com.daoshun.shiqu.pojo.Order;
import com.daoshun.shiqu.pojo.OrderDetail;
import com.daoshun.shiqu.pojo.RechargeCard;
import com.daoshun.shiqu.pojo.RechargeRecord;
import com.daoshun.shiqu.service.wap.WapOrderService;
import com.utils.GetWxOrderno;
import com.utils.RequestHandler;
import com.utils.Sha1Util;
import com.utils.TenpayUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/wap")
public class WapOrder {

	@Resource(name="wapOrderService")
	WapOrderService wapOrderService;
	
	/**
	 * 当前订单(未完成订单 state=1or2)
	 * @return
	 */
	@RequestMapping("/presentorderlist")
	public HashMap<String,Object> presentorderlist( Integer pageIndex, HttpSession session){
		HashMap<String, Object> result = new HashMap<String, Object>();
		long wapuserid = CommonUtils.parseLong(String.valueOf(session.getAttribute("wapuserid")), 0) ;  
		if(pageIndex == null){
			pageIndex = 1;
		}
		QueryResult<Order> qresult =  wapOrderService.getPresentOrderListBypage(wapuserid, pageIndex, Constants.WAPSTORELISTSIZE);
		result.put("orderlist",  qresult.getDataList());
		result.put("pageSize",  Constants.WAPSTORELISTSIZE);
		result.put("total", qresult.getTotal());
		return result;
	}
	
	@RequestMapping("/pullpresentorderlist")
	@ResponseBody
	public HashMap<String, Object> pullpresentorderlist(Integer pageIndex, HttpSession session){
		HashMap<String, Object> result = new HashMap<String, Object>();
		long wapuserid = CommonUtils.parseLong(String.valueOf(session.getAttribute("wapuserid")), 0) ; 
		if(pageIndex == null){
			pageIndex = 1;
		}
		QueryResult<Order> qresult =  wapOrderService.getPresentOrderListBypage(wapuserid, pageIndex, Constants.WAPSTORELISTSIZE);
		result.put("orderlist",  qresult.getDataList());
		result.put("total", qresult.getTotal());
		return result;
	}
	
	/**
	 * 堂食
	 * @param pageIndex
	 * @param session
	 * @return
	 */
	@RequestMapping("/hereorderlist")
	public HashMap<String, Object> hereorderlist(Integer pageIndex, HttpSession session, int is_out){
		HashMap<String, Object> result = new HashMap<String, Object>();
		long wapuserid = CommonUtils.parseLong(String.valueOf(session.getAttribute("wapuserid")), 0) ; 
		if(pageIndex == null){
			pageIndex = 1;
		}
		QueryResult<Order> qresult =  wapOrderService.getIsOutOrderListBypage(wapuserid, pageIndex, is_out, Constants.WAPSTORELISTSIZE);
		result.put("orderlist",  qresult.getDataList());
		result.put("pageSize",  Constants.WAPSTORELISTSIZE);
		result.put("total", qresult.getTotal());
		return result;
	}
	
	/**
	 * 堂食
	 * @param pageIndex
	 * @param session
	 * @return
	 */
	@RequestMapping("/pullhereorderlist")
	@ResponseBody
	public HashMap<String, Object> pullhereorderlist(Integer pageIndex, HttpSession session, int is_out){
		HashMap<String, Object> result = new HashMap<String, Object>();
		long wapuserid = CommonUtils.parseLong(String.valueOf(session.getAttribute("wapuserid")), 0) ; 
		if(pageIndex == null){
			pageIndex = 1;
		}
		QueryResult<Order> qresult =  wapOrderService.getIsOutOrderListBypage(wapuserid, pageIndex, is_out, Constants.WAPSTORELISTSIZE);
		result.put("orderlist",  qresult.getDataList());
		result.put("total", qresult.getTotal());
		return result;
	}
	
	/**
	 * 外卖
	 * @param pageIndex
	 * @param session
	 * @param is_out
	 * @return
	 */
	@RequestMapping("/outorderlist")
	public HashMap<String, Object> outorderlist(Integer pageIndex, HttpSession session, int is_out){
		HashMap<String, Object> result = new HashMap<String, Object>();
		long wapuserid = CommonUtils.parseLong(String.valueOf(session.getAttribute("wapuserid")), 0) ; 
		if(pageIndex == null){
			pageIndex = 1;
		}
		QueryResult<Order> qresult =  wapOrderService.getIsOutOrderListBypage(wapuserid, pageIndex, is_out, Constants.WAPSTORELISTSIZE);
		result.put("orderlist",  qresult.getDataList());
		result.put("pageSize",  Constants.WAPSTORELISTSIZE);
		result.put("total", qresult.getTotal());
		return result;
	}
	
	/**
	 * 外卖
	 * @param pageIndex
	 * @param session
	 * @param is_out
	 * @return
	 */
	@RequestMapping("/pulloutorderlist")
	@ResponseBody
	public HashMap<String, Object> pulloutorderlist(Integer pageIndex, HttpSession session, int is_out){
		HashMap<String, Object> result = new HashMap<String, Object>();
		long wapuserid = CommonUtils.parseLong(String.valueOf(session.getAttribute("wapuserid")), 0); 
		if(pageIndex == null){
			pageIndex = 1;
		}
		QueryResult<Order> qresult =  wapOrderService.getIsOutOrderListBypage(wapuserid, pageIndex, is_out, Constants.WAPSTORELISTSIZE);
		result.put("orderlist",  qresult.getDataList());
		result.put("total", qresult.getTotal());
		return result;
	}
	
	
	/**
	 * 订单详情
	 * @param order_id
	 * @param session
	 * @return
	 */
	@RequestMapping("/orderdetail")
	public ModelAndView orderdetail(Long order_id, Long mycoupon_id, HttpSession session){
		ModelAndView mov = new ModelAndView();
		long wapuserid = CommonUtils.parseLong(String.valueOf(session.getAttribute("wapuserid")), 0);
		Order order = wapOrderService.getOrderDetail(order_id);
		List<OrderDetail> neworderdetail = new ArrayList<OrderDetail>();
		List<OrderDetail> orderdetails = order.getMenu_list();
		for(OrderDetail detail:orderdetails){
			if(detail.getDetail_flg()>=0){
				neworderdetail.add(detail);
			}
		}
		order.setMenu_list(neworderdetail);
		mov.addObject("order", order);
		if(mycoupon_id != null){
			MyCoupon mycoupon = wapOrderService.getMyCouponById(mycoupon_id);
			if(mycoupon != null){
				mov.addObject("coupon", mycoupon.getCoupon());
				mov.addObject("mycoupon", mycoupon.getId());
			}
		}
		long conponcount = wapOrderService.getMyCouponUsedCount(wapuserid, order.getTotal_price(), order.getStore_id());
		mov.addObject("conponcount", conponcount);
		if(order.getState() == 1){
			//店家未确认
			mov.setViewName("wap/instateon");
		}else if(order.getState() == 2){
			RechargeCard card = wapOrderService.getRechargeCard(order.getUser_id(), order.getStore_id());
			int hascard = 0;
			if(card != null && card.getMoney() > order.getPrice()){
				hascard = 1;
			}
			//店家已确认
			mov.setViewName("redirect:/wap/wxpayprepare?order_id="+order_id+"&coupon_id="+mycoupon_id+"&hascard="+hascard);
		}else if(order.getState() == 3){
			//店家拒单
			mov.setViewName("wap/instateth");
		}else if(order.getState() == 4){
			//已付款
			mov.setViewName("wap/instatefo");
		}else{
			//取消
			mov.setViewName("wap/instatefi");
		}
		return mov;
	}
	
	/**
	 * 取消订单
	 * @param order_id
	 * @param response
	 */
	@RequestMapping("/cancelorder")
	public void cancelorder(Long order_id, HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		result.put("code", 1);
		try {
			wapOrderService.cancelOrder(order_id);
			result.put("message", "取消成功");
		} catch (CustomException e) {
			result.put("message", e.getMessage());
			result.put("code", 101);
			CommonUtils.setMaptoJson(response, result);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("message", Constants.EXCEPTION);
			result.put("code", 101);
			CommonUtils.setMaptoJson(response, result);
		}
		CommonUtils.setMaptoJson(response, result);
	}
	
	/**
	 * 选择优惠券
	 * @param order_id
	 * @param coupon_id
	 * @return
	 */
	@RequestMapping("/selectcoupon")
	public ModelAndView selectconpon(Long order_id, Long coupon_id){
		ModelAndView mov = new ModelAndView();
		Order order = wapOrderService.getOrderDetail(order_id);
		List<MyCoupon> list = wapOrderService.getMyCouponList(order.getUser_id(), order.getTotal_price(), order.getStore_id());
		mov.addObject("mycouponlist", list);
		mov.addObject("order_id", order_id);
		mov.addObject("coupon_id", coupon_id);
		mov.setViewName("wap/mycouponlist");
		return mov;
	}
	
	@RequestMapping("/payorder")
	public ModelAndView  payorder(Long order_id, Long coupon_id){
		ModelAndView mov = new ModelAndView();
		Order order = wapOrderService.getOrderDetail(order_id);
		mov.addObject("order", order);
		Coupon coupon = wapOrderService.getCouponById(coupon_id);
		mov.addObject("coupon", coupon);
		mov.setViewName("wap/paysuccess");
		return mov;
	}
	
	
	@RequestMapping("/payorderdetail")
	public ModelAndView payorderdetail(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		ModelAndView mov = new ModelAndView();
		//网页授权后获取传递的参数
		long order_id = CommonUtils.parseLong(request.getParameter("order_id"), 0);
		long coupon_id = CommonUtils.parseLong(request.getParameter("coupon_id"),0);
		int hascard = CommonUtils.parseInt(request.getParameter("hascard"), 0);
		Order order = wapOrderService.getOrderDetail(order_id);
		order.setSerial_num(CommonUtils.makeSerialNum());
		wapOrderService.updateOrder(order);
		List<OrderDetail> neworderdetail = new ArrayList<OrderDetail>();
		List<OrderDetail> orderdetails = order.getMenu_list();
		for(OrderDetail detail:orderdetails){
			if(detail.getDetail_flg()>=0){
				neworderdetail.add(detail);
			}
		}
		order.setMenu_list(neworderdetail);
		mov.addObject("order", order);
		mov.addObject("hascard", hascard);
		float sessionmoney =(float)order.getTotal_price();
		if(coupon_id > 0){
			Coupon coupon = wapOrderService.getCouponById(coupon_id);
			mov.addObject("coupon", coupon);
			sessionmoney = sessionmoney - coupon.getAmount();
		}
		long wapuserid = CommonUtils.parseLong(String.valueOf(session.getAttribute("wapuserid")), 0);
		long conponcount = wapOrderService.getMyCouponUsedCount(wapuserid, order.getTotal_price(), order.getStore_id());
		mov.addObject("conponcount", conponcount);
		String code = request.getParameter("code");
		//金额转化为分为单位
		String finalmoney = String.format("%.2f", sessionmoney);
		finalmoney = finalmoney.replace(".", "");
		
		String appid = Constants.WX_APPID;
		String appsecret = Constants.WX_APPSECRET;
		String partner = Constants.WX_PARTNER;
		String partnerkey = Constants.WX_PARTNERKEY;
		String openId ="";
		String URL = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="+appid+"&secret="+appsecret+"&code="+code+"&grant_type=authorization_code";
		JSONObject jsonObject = CommonUtils.httpsRequest(URL, "GET", null);
		if (null != jsonObject) {
			openId = jsonObject.getString("openid");
		}
		//获取openId后调用统一支付接口https://api.mch.weixin.qq.com/pay/unifiedorder
			String currTime = TenpayUtil.getCurrTime();
			//8位日期
			String strTime = currTime.substring(8, currTime.length());
			//四位随机数
			String strRandom = TenpayUtil.buildRandom(4) + "";
			//10位序列号,可以自行调整。
			String strReq = strTime + strRandom;
			
			
			//商户号
			String mch_id = partner;
			//子商户号  非必输
			//String sub_mch_id="";
			//设备号   非必输
			String device_info="";
			//随机数 
			String nonce_str = strReq;
			//商品描述
			//String body = describe;
			
			//商品描述根据情况修改
			String body = "食在有趣订单支付";
			//附加数据
			String attach = order.getOrder_id()+","+coupon_id;
			//商户订单号
			String out_trade_no = order.getSerial_num()+TenpayUtil.buildRandom(4);
			
			int total_fee = Integer.parseInt(finalmoney);
			//测试用价格
//			int total_fee = 1;
			//订单生成的机器 IP
			String spbill_create_ip = request.getRemoteAddr();
			//订 单 生 成 时 间   非必输
//			String time_start ="";
			//订单失效时间      非必输
//			String time_expire = "";
			//商品标记   非必输
//			String goods_tag = "";
			
			//这里notify_url是 支付完成后微信发给该链接信息，可以判断会员是否支付成功，改变订单状态等。
			String notify_url =CommonUtils.properties.getProperty("WXNotifyUrl");
			String trade_type = "JSAPI";
			String openid = openId;
			//非必输
//			String product_id = "";
			SortedMap<String, String> packageParams = new TreeMap<String, String>();
			packageParams.put("appid", appid);  
			packageParams.put("mch_id", mch_id);  
			packageParams.put("nonce_str", nonce_str);  
			packageParams.put("body", body);  
			packageParams.put("attach", attach);  
			packageParams.put("out_trade_no", out_trade_no);  
			
			
			//这里写的金额为1 分到时修改
			packageParams.put("total_fee", ""+total_fee);  
//			packageParams.put("total_fee", "finalmoney");  
			packageParams.put("spbill_create_ip", spbill_create_ip);  
			packageParams.put("notify_url", notify_url);  
			
			packageParams.put("trade_type", trade_type);  
			packageParams.put("openid", openid);  

			RequestHandler reqHandler = new RequestHandler(request, response);
			reqHandler.init(appid, appsecret, partnerkey);
			
			String sign = reqHandler.createSign(packageParams);
			String xml="<xml>"+
					"<appid>"+appid+"</appid>"+
					"<mch_id>"+mch_id+"</mch_id>"+
					"<nonce_str>"+nonce_str+"</nonce_str>"+
					"<sign>"+sign+"</sign>"+
					"<body><![CDATA["+body+"]]></body>"+
					"<attach>"+attach+"</attach>"+
					"<out_trade_no>"+out_trade_no+"</out_trade_no>"+
					//金额，这里写的1 分到时修改
					"<total_fee>"+total_fee+"</total_fee>"+
					//"<total_fee>"+finalmoney+"</total_fee>"+
					"<spbill_create_ip>"+spbill_create_ip+"</spbill_create_ip>"+
					"<notify_url>"+notify_url+"</notify_url>"+
					"<trade_type>"+trade_type+"</trade_type>"+
					"<openid>"+openid+"</openid>"+
					"</xml>";
//			System.out.println(xml);
			String allParameters = "";
			try {
				allParameters =  reqHandler.genPackage(packageParams);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String createOrderURL = "https://api.mch.weixin.qq.com/pay/unifiedorder";
			String prepay_id="";
			try {
				HashMap map  = new GetWxOrderno().getPayNo(createOrderURL, xml );
				prepay_id = (String)map.get("prepay_id");
//				code_url = (String)map.get("code_url");
				if(prepay_id.equals("")){
					request.setAttribute("ErrorMsg", "统一支付接口获取预支付订单出错");
					response.sendRedirect("error.jsp");
				}
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			SortedMap<String, String> finalpackage = new TreeMap<String, String>();
			String appid2 = appid;
			String timestamp = Sha1Util.getTimeStamp();
			String nonceStr2 = nonce_str;
			String prepay_id2 = "prepay_id="+prepay_id;
			String packages = prepay_id2;
			finalpackage.put("appId", appid2);  
			finalpackage.put("timeStamp", timestamp);  
			finalpackage.put("nonceStr", nonceStr2);  
			finalpackage.put("package", packages);  
			finalpackage.put("signType", "MD5");
			String finalsign = reqHandler.createSign(finalpackage);
			mov.addObject("appid",appid2);
			mov.addObject("timeStamp",timestamp);
			mov.addObject("nonceStr",nonceStr2);
			mov.addObject("packagename",packages);
			mov.addObject("sign",finalsign);
			mov.setViewName("/wap/instatetw");
			return mov;
	}
	
	@RequestMapping("/paycardorder")
	public ModelAndView paycardorder(Long order_id, Long coupon_id, int pay_type){
		ModelAndView mov = new ModelAndView();
		Order order = wapOrderService.getOrderDetail(order_id);
		if(coupon_id != null){
			order.setCoupon_id(coupon_id);
			MyCoupon coupon = wapOrderService.getCouponByCouponId(coupon_id, order.getUser_id());
			coupon.setIs_used(1);
			coupon.setUse_time(new Date());
			wapOrderService.updateMyCoupon(coupon);
			mov.addObject("coupon", coupon);
			order.setPrice(order.getTotal_price()-coupon.getCoupon().getAmount());
		}
		order.setState(4);
		RechargeCard card = wapOrderService.getRechargeCard(order.getUser_id(), order.getStore_id());
		card.setMoney(card.getMoney() - order.getPrice());
		wapOrderService.updateRechargeCard(card);
		order.setCard_no(card.getCard_no());
		// 增加卡的消费记录
		RechargeRecord record = new RechargeRecord();
		record.setCard_id(card.getId());
		record.setCharge_time(new Date());
		record.setCharge_money(0);
		record.setMoney(order.getPrice());
		record.setType(2);
		record.setUser_id(order.getUser_id());
		wapOrderService.addRechargeRecord(record);
		order.setCheck_time(new Date());
		wapOrderService.updateOrder(order);
		mov.addObject("order", order);
		mov.setViewName("wap/paysuccess");
		return mov;
	}
	
}
