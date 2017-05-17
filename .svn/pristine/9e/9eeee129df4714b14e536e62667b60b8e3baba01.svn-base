package com.daoshun.shiqu.controller.shop;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.pojo.Store;
import com.daoshun.shiqu.pojo.StoreUser;
import com.daoshun.shiqu.service.StoreUserService;

@Controller
@RequestMapping("/shop")
public class ShopIndex {
	
	@Resource(name="storeUserService")
	StoreUserService storeUserService;

	@RequestMapping("/{shopid}")
	public ModelAndView shop(@PathVariable(value="shopid") String shopid ,HttpSession session){
		ModelAndView mov = new ModelAndView();
		int sessionshopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0) ;  
        if(sessionshopid == 0) {  
        	mov.addObject("err", 2);
        	mov.setViewName("/shop/login");
        }else{
        	if(sessionshopid!=CommonUtils.parseInt(shopid, 0)){
        		mov.addObject("err", 2);
            	mov.setViewName("/shop/login");
        	}else{
        		mov.setViewName("/shop/index");
        	}
        }
		return mov;
	}
	
	
	@RequestMapping("/index")
	public ModelAndView index(HttpSession session){
		ModelAndView mov = new ModelAndView();
		int sessionstoreuserid = CommonUtils.parseInt(String.valueOf(session.getAttribute("storeuserid")), 0) ;  
        if(sessionstoreuserid == 0) {  
//        	mov.addObject("err", 2);
        	mov.setViewName("/shop/login");
        }else{
        	mov.setViewName("redirect:/shop/"+sessionstoreuserid);
        }
		return mov;
	}
	
	@RequestMapping("/logout")
	public ModelAndView logout(HttpSession session){
		ModelAndView mov = new ModelAndView();
		session.invalidate();
		mov.setViewName("/shop/login");
		return mov;
	}
	
	@RequestMapping("/loginStorelist")
	public void loginStorelist(String phone,String password,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		List<Store> storelist = storeUserService.getStoreUserList(phone, password);
		if(storelist!=null&&storelist.size()>0){
			result.put("code", 1);
			result.put("storelist", storelist);
		}else{
			result.put("code", 500);
		}
		CommonUtils.setMaptoJson(response, result);
	}
	
	@RequestMapping("/login")
	public ModelAndView login(String phone,String password,Long store_id,HttpSession session){
		ModelAndView mov = new ModelAndView();
		if(store_id==null)
			store_id = 0l;
		StoreUser storeuser = storeUserService.getStoreUserByStorePhone(phone,store_id);
		if(storeuser==null){
			mov.addObject("err", 1);
			mov.setViewName("/shop/login");
		}else{
			if(!CommonUtils.MD5(password).equals(storeuser.getPassword())){
				mov.addObject("err", 1);
				mov.setViewName("/shop/login");
			}else{
				if(storeuser.getPrivilege()==20){
					mov.addObject("err", 3);
					mov.setViewName("/shop/login");
				}else{
					session.setAttribute("privilege", storeuser.getPrivilege());
					session.setAttribute("shopid", storeuser.getStore_id());
					Store store = storeUserService.getStoreById(storeuser.getStore_id());
					session.setAttribute("storename", store.getStore_name());
					session.setAttribute("username", storeuser.getName());
					session.setAttribute("storeuserid", storeuser.getId());
					mov.setViewName("redirect:/shop/"+storeuser.getStore_id());
				}
			}
		}
		return mov;
	}
}
