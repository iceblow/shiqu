package com.daoshun.shiqu.controller.wap;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.daoshun.shiqu.netdata.UserOpenId;
import com.daoshun.shiqu.common.HttpRequest;
import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.common.Constants;
import com.daoshun.shiqu.netdata.OrderMenu;
import com.daoshun.shiqu.pojo.AreaInfo;
import com.daoshun.shiqu.pojo.Coupon;
import com.daoshun.shiqu.pojo.DeliveryAddress;
import com.daoshun.shiqu.pojo.Menu;
import com.daoshun.shiqu.pojo.MenuCategory;
import com.daoshun.shiqu.pojo.Store;
import com.daoshun.shiqu.pojo.StoreCategory;
import com.daoshun.shiqu.pojo.UserInfo;
import com.daoshun.shiqu.service.wap.WapMineService;
import com.daoshun.shiqu.service.wap.WapStoreService;
import com.google.gson.Gson;


@Controller
@RequestMapping("/wap")
public class WapStore {

	@Resource(name="wapStoreService")
	WapStoreService wapStoreService;
	
	@Resource(name="wapMineService")
	WapMineService wapMineService;
	
	@RequestMapping("/index")
	public ModelAndView index(HttpServletRequest request,HttpSession session){
		ModelAndView mov = new ModelAndView();
		String code = request.getParameter("code");
		String openid = "";
		if(!CommonUtils.isEmptyString(code)){
			String openidurl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="+Constants.WX_APPID+"&secret="+Constants.WX_APPSECRET+"&code="+code+"&grant_type=authorization_code";
			String openiddata = HttpRequest.sendGet(openidurl, null);
			if(!CommonUtils.isEmptyString(openiddata)){
				Gson gson = new Gson();//new一个Gson对象
				UserOpenId useropenid = gson.fromJson(openiddata, UserOpenId.class);
				openid = useropenid.getOpenid();
				}
			}
			if(!CommonUtils.isEmptyString(openid)){
				UserInfo user = wapStoreService.getUserInfoByWxOpenId(openid);
				if(user==null){
					user = new UserInfo();
					user.setWeixin_openid(openid);
					user.setNick_name("公众号用户:"+CommonUtils.makeRandomNo());
					user.setCreate_time(new Date());
					wapStoreService.addUserInfo(user);
				}
				session.setAttribute("wapuserid", user.getUser_id());
			}
		mov.setViewName("redirect:/wap/storeindex");
		return mov;
	}
	
	@RequestMapping("/storeindex")
	public ModelAndView storeindex(String city,Long category_id,String address,Double lon,Double lat){
		ModelAndView mov = new ModelAndView();
		List<StoreCategory> categorylist = wapStoreService.getStoreCategory();
		mov.addObject("categorylist", categorylist);
		mov.addObject("category_id",category_id);
		mov.addObject("address",address);
		mov.addObject("city",city);
		mov.addObject("lon",lon);
		mov.addObject("lat",lat);
		mov.setViewName("/wap/storelist");
		return mov;
	};
	
	@RequestMapping("/storelist")
	@ResponseBody
	public HashMap<String,Object> storelist(Double lon,Double lat,String keywords, Long category_id, Integer sort, Integer pageIndex, String area){
		if(pageIndex==null){
			pageIndex = 1;
		}
		return wapStoreService.getStoreList(lon+","+lat, keywords, category_id, sort, Constants.WAPSTORELISTSIZE, pageIndex, area);
	}
	
	@RequestMapping("/storelistsearch")
	public ModelAndView storelistsearch(String city,Long category_id,String address,Double lon,Double lat){
		ModelAndView mov = new ModelAndView();
		mov.addObject("category_id",category_id);
		mov.addObject("address",address);
		mov.addObject("city",city);
		mov.addObject("lon",lon);
		mov.addObject("lat",lat);
		mov.setViewName("/wap/searchstore");
		return mov;
	}
	
	@RequestMapping("/otherstore")
	public ModelAndView otherstore(String city,Double lon,Double lat){
		ModelAndView mov = new ModelAndView();
		if(lon!=null&&lat!=null){
			mov.addObject("city",city);
			mov.addObject("lon",lon);
			mov.addObject("lat",lat);
			List<StoreCategory> categorylist = wapStoreService.getStoreCategory();
			mov.addObject("categorylist",categorylist);
			List<AreaInfo> arealist = wapStoreService.getAreaInfoByParentname(city);
			mov.addObject("arealist",arealist);
			mov.setViewName("/wap/otherstore");
		}else{
			mov.setViewName("redirect:/wap/storeindex");
		}
		return mov;
	}
	
	@RequestMapping("/storedetail")
	public ModelAndView storedetail(Long store_id){
		ModelAndView mov = new ModelAndView();
		if(store_id!=null&&store_id>0){
			 List<MenuCategory> categorylist = wapStoreService.getStoreMenu(store_id);
			 mov.addObject("categorylist", categorylist);
			 mov.addObject("store_id", store_id);
		}else{
			mov.setViewName("redirect:/wap/storeindex");
		}
		return mov;
	}
	
	@RequestMapping("/outorder")
	public ModelAndView outorder(Long addressid,long store_id,Long[] menuids,Integer[] quantitys,HttpSession session){
		long wapuserid = CommonUtils.parseLong(String.valueOf(session.getAttribute("wapuserid")), 0) ;  
		ModelAndView mov = new ModelAndView();
		List<OrderMenu> menulist = new ArrayList<OrderMenu>();
		float allprice = 0f ;for(int i=0;i<quantitys.length;i++){
			Integer num = quantitys[i];
			if(num>0){
				Long menu_id = menuids[i];
				Menu menu = wapStoreService.getMenuById(menu_id);
				float price = menu.getPrice()*num;
				allprice += price;
				OrderMenu ordermenu = new OrderMenu();
				ordermenu.setName(menu.getMenu_name());
				ordermenu.setMenu_id(menu_id);
				ordermenu.setQuantity(num);
				ordermenu.setPrice(price);
				menulist.add(ordermenu);
			}
		}
		if(addressid==null){
			DeliveryAddress deliveryaddress = wapStoreService.getUserDefultAddress(wapuserid);
			mov.addObject("deliveryaddress", deliveryaddress);
		}else{
			DeliveryAddress deliveryaddress = wapStoreService.getAddressById(addressid);
			mov.addObject("deliveryaddress", deliveryaddress); 
		}
		mov.addObject("menulist", menulist);
		Store store = wapStoreService.getStoreById(store_id,0);
		mov.addObject("store", store);
		if(store.getSend_money()>0){
			allprice += store.getSend_money();
		}
		mov.addObject("allprice", allprice);
		mov.setViewName("/wap/outorder");
		List<String> timechoose = new ArrayList<String>();
		Calendar c = Calendar.getInstance();
		c.setTime(new Date());
		String[] storestart = store.getOpen_time().split(":");
		String[] storeend = store.getClose_time().split(":");
		long nowtime = c.getTimeInMillis();
		c.set(Calendar.HOUR_OF_DAY, CommonUtils.parseInt(storestart[0], 0));
		c.set(Calendar.MINUTE, CommonUtils.parseInt(storestart[1], 0));
		long starttime = c.getTimeInMillis();
		c.set(Calendar.HOUR_OF_DAY,CommonUtils.parseInt(storeend[0], 0));
		c.set(Calendar.MINUTE,CommonUtils.parseInt(storeend[1], 0));
		long endtime = c.getTimeInMillis();
		if(nowtime>=starttime&&nowtime<=endtime){
			int times = (int) ((endtime-nowtime)/(1000*60*15));
			c.setTimeInMillis(nowtime);
			c.add(Calendar.MINUTE,15);
			for(int i=0;i<times;i++){
				String begin = CommonUtils.getTimeFormat(c.getTime(), "HH:mm");
				c.add(Calendar.MINUTE,15);
				String end = CommonUtils.getTimeFormat(c.getTime(), "HH:mm");
				timechoose.add(begin+"--"+end);
			}
		}
		mov.addObject("timechoose",timechoose);
		return mov;
	}
	
	@RequestMapping("/makeorder")
	public ModelAndView makeorder(long store_id,Long[] menuids,Integer[] quantitys){
		ModelAndView mov = new ModelAndView();
		List<OrderMenu> menulist = new ArrayList<OrderMenu>();
		float allprice = 0f ;
		for(int i=0;i<quantitys.length;i++){
			Integer num = quantitys[i];
			if(num>0){
				Long menu_id = menuids[i];
				Menu menu = wapStoreService.getMenuById(menu_id);
				float price = menu.getPrice()*num;
				allprice += price;
				OrderMenu ordermenu = new OrderMenu();
				ordermenu.setName(menu.getMenu_name());
				ordermenu.setMenu_id(menu_id);
				ordermenu.setQuantity(num);
				ordermenu.setPrice(price);
				menulist.add(ordermenu);
			}
		}
		mov.addObject("menulist", menulist);
		mov.addObject("allprice", allprice);
		Store store = wapStoreService.getStoreById(store_id,0);
		mov.addObject("store", store);
		mov.setViewName("/wap/outlessorder");
		return mov;
	}
	
	@RequestMapping("/addorder")
	public ModelAndView addorder(Integer peoplenum,String phone,String ordername,String send_time,String address,String comment,int is_out,long store_id,Long[] menuids,Integer[] quantitys,float allprice, HttpSession session){
		ModelAndView mov = new ModelAndView();
		long wapuserid = CommonUtils.parseLong(String.valueOf(session.getAttribute("wapuserid")), 0) ;  
		try{
			wapStoreService.addOrder(peoplenum,ordername,phone,send_time,address,comment,is_out,store_id,menuids,quantitys,allprice,wapuserid);
		}catch(Exception e){
			
		}
		mov.setViewName("redirect:/wap/ordersuccess");
		return mov;
	}
	
	@RequestMapping("/ordersuccess")
	public ModelAndView ordersuccess(){
		ModelAndView mov = new ModelAndView();
		return mov;
	}
	
	@RequestMapping("/store")
	public ModelAndView store(long store_id,HttpSession session){
		ModelAndView mov = new ModelAndView();
		long wapuserid = CommonUtils.parseLong(String.valueOf(session.getAttribute("wapuserid")), 0) ;  
		Store store = wapStoreService.getStoreById(store_id,wapuserid);
		List<Coupon> couponlist = wapStoreService.getStoreCoupon(store_id, wapuserid);
		int piclistsize = store.getStorepic_list().size();
		mov.addObject("store", store);
		mov.addObject("couponlist", couponlist);
		mov.addObject("piclistsize", piclistsize);
		return mov;
	}
	
	@RequestMapping("/collectStore")
	@ResponseBody
	public HashMap<String,Object> collectStore(long store_id,HttpSession session){
		HashMap<String,Object> result = new HashMap<String,Object>();
		long wapuserid = CommonUtils.parseLong(String.valueOf(session.getAttribute("wapuserid")), 0) ;  
		int code = wapStoreService.collectStore(store_id, wapuserid);
		result.put("code", code);
		return result;
	}
	
	@RequestMapping("/getcoupon")
	@ResponseBody
	public HashMap<String,Object> getcoupon(long coupon_id,HttpSession session){
		HashMap<String,Object> result = new HashMap<String,Object>();
		long wapuserid = CommonUtils.parseLong(String.valueOf(session.getAttribute("wapuserid")), 0) ; 
		wapStoreService.getCoupon(coupon_id,wapuserid);
		return result;
	}
	
	@RequestMapping("/outaddress")
	public ModelAndView outaddress(Long addressid,long store_id,Long[] menuids,Integer[] quantitys,HttpSession session){
		ModelAndView mov = new ModelAndView();
		List<OrderMenu> menulist = new ArrayList<OrderMenu>();
		for(int i=0;i<quantitys.length;i++){
			Integer num = quantitys[i];
			if(num>0){
				Long menu_id = menuids[i];
				Menu menu = wapStoreService.getMenuById(menu_id);
				float price = menu.getPrice()*num;
				OrderMenu ordermenu = new OrderMenu();
				ordermenu.setName(menu.getMenu_name());
				ordermenu.setMenu_id(menu_id);
				ordermenu.setQuantity(num);
				ordermenu.setPrice(price);
				menulist.add(ordermenu);
			}
		}
		mov.addObject("addressid", addressid);
		mov.addObject("menulist", menulist);
		Store store = wapStoreService.getStoreById(store_id,0);
		mov.addObject("store", store);
		long wapuserid = CommonUtils.parseLong(String.valueOf(session.getAttribute("wapuserid")), 0) ;
		List<DeliveryAddress> addresslist = wapMineService.getDeliverAddressList(wapuserid);
		mov.addObject("addresslist", addresslist);
		mov.setViewName("wap/orderaddress");
		return mov;
	}
	
	@RequestMapping("/turnaddoutaddress")
	public ModelAndView turnaddoutaddress(Long addressid,long store_id,Long[] menuids,Integer[] quantitys,HttpSession session){
		ModelAndView mov = new ModelAndView();
		List<OrderMenu> menulist = new ArrayList<OrderMenu>();
		for(int i=0;i<quantitys.length;i++){
			Integer num = quantitys[i];
			if(num>0){
				Long menu_id = menuids[i];
				Menu menu = wapStoreService.getMenuById(menu_id);
				float price = menu.getPrice()*num;
				OrderMenu ordermenu = new OrderMenu();
				ordermenu.setName(menu.getMenu_name());
				ordermenu.setMenu_id(menu_id);
				ordermenu.setQuantity(num);
				ordermenu.setPrice(price);
				menulist.add(ordermenu);
			}
		}
		mov.addObject("addressid", addressid);
		mov.addObject("menulist", menulist);
		Store store = wapStoreService.getStoreById(store_id,0);
		mov.addObject("store", store);
		List<AreaInfo> prolist = wapMineService.getProList(0);
		mov.addObject("prolist", prolist);
		mov.setViewName("wap/addoutaddress");
		return mov;
	}
	
	@RequestMapping("/addoutaddress")
	public ModelAndView addoutaddress(DeliveryAddress address, Long province_id, Long city_id, Long area_id,Long addressid,long store_id,Long[] menuids,Integer[] quantitys,HttpSession session){
		ModelAndView mov = new ModelAndView();
		long wapuserid = CommonUtils.parseLong(String.valueOf(session.getAttribute("wapuserid")), 0) ;
		List<DeliveryAddress> list = wapMineService.getDeliverAddressList(wapuserid);
		DeliveryAddress deliverAddress = new DeliveryAddress();
		deliverAddress.setUser_id(wapuserid);
		if(list != null && list.size() > 0){
			deliverAddress.setIs_default(1);
		}else{
			deliverAddress.setIs_default(0);
		}
		if(province_id != null){
			AreaInfo pareainfo = wapMineService.getAreaInfoById(province_id);
			deliverAddress.setProvince(pareainfo.getName());
		}
		if(city_id != null){
			AreaInfo careainfo = wapMineService.getAreaInfoById(city_id);
			deliverAddress.setCity(careainfo.getName());
		}
		if(area_id != null){
			AreaInfo areainfo = wapMineService.getAreaInfoById(area_id);
			deliverAddress.setArea(areainfo.getName());
		}
		deliverAddress.setAddress(address.getAddress());
		deliverAddress.setPhone(address.getPhone());
		deliverAddress.setReceiver(address.getReceiver());
		deliverAddress.setUpdate_time(new Date());
		wapMineService.addDeliveryAddress(deliverAddress);
		List<OrderMenu> menulist = new ArrayList<OrderMenu>();
		for(int i=0;i<quantitys.length;i++){
			Integer num = quantitys[i];
			if(num>0){
				Long menu_id = menuids[i];
				Menu menu = wapStoreService.getMenuById(menu_id);
				float price = menu.getPrice()*num;
				OrderMenu ordermenu = new OrderMenu();
				ordermenu.setName(menu.getMenu_name());
				ordermenu.setMenu_id(menu_id);
				ordermenu.setQuantity(num);
				ordermenu.setPrice(price);
				menulist.add(ordermenu);
			}
		}
		mov.addObject("addressid", addressid);
		mov.addObject("menulist", menulist);
		Store store = wapStoreService.getStoreById(store_id,0);
		mov.addObject("store", store);
		List<DeliveryAddress> addresslist = wapMineService.getDeliverAddressList(wapuserid);
		mov.addObject("addresslist", addresslist);
		mov.setViewName("/wap/orderaddress");
		return mov;
	}
}
