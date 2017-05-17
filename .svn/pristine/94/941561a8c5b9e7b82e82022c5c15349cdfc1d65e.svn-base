package com.daoshun.shiqu.controller.shop;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.common.Constants;
import com.daoshun.shiqu.common.QueryResult;
import com.daoshun.shiqu.controller.ApiBaseController;
import com.daoshun.shiqu.pojo.AreaInfo;
import com.daoshun.shiqu.pojo.DailyStatistics;
import com.daoshun.shiqu.pojo.Order;
import com.daoshun.shiqu.pojo.PrintInfo;
import com.daoshun.shiqu.pojo.Store;
import com.daoshun.shiqu.pojo.StoreCategory;
import com.daoshun.shiqu.pojo.StorePic;
import com.daoshun.shiqu.pojo.StoreSigner;
import com.daoshun.shiqu.pojo.StoreUser;
import com.daoshun.shiqu.service.CommonService;
import com.daoshun.shiqu.service.OrderService;
import com.daoshun.shiqu.service.PrintService;
import com.daoshun.shiqu.service.StoreService;
import com.daoshun.shiqu.service.StoreUserService;

@Controller
@RequestMapping("/shop")
public class ShopManage extends ApiBaseController {

	@Resource(name = "storeService")
	StoreService storeService;
	@Resource(name = "commonService")
	CommonService commonService;
	@Resource(name = "printService")
	PrintService printService;
	@Resource(name = "storeUserService")
	StoreUserService storeUserService;

	@Resource(name="orderService")
	OrderService orderService;

	@RequestMapping("/detail")
	public ModelAndView detail(HttpSession session) {
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		Store store = storeService.getStoreById(shopid);
		DailyStatistics daily = storeService.getDailyStatisticsByStoreId(shopid);
		ModelAndView mov = new ModelAndView();
		mov.addObject("daily", daily);
		mov.addObject("store", store);
		mov.setViewName("/shop/shopDetail");
		return mov;
	}

	@RequestMapping("/lookdetail")
	public ModelAndView lookdetail(String phone, String password, HttpSession session) {
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		Store store = storeService.getStoreById(shopid);
		List<StoreCategory> categorylist = storeService.getCategory();
		ModelAndView mov = new ModelAndView();
		List<AreaInfo> proviencelist = commonService.getAreaByParentid(0);
		mov.addObject("categorylist", categorylist);
		mov.addObject("proviencelist", proviencelist);
		if (store.getProvienceid() > 0) {
			List<AreaInfo> citylist = commonService.getAreaByParentid(store.getProvienceid());
			mov.addObject("citylist", citylist);
		}
		if (store.getCityid() > 0) {
			List<AreaInfo> arealist = commonService.getAreaByParentid(store.getCityid());
			mov.addObject("arealist", arealist);
		}
		mov.addObject("store", store);
		mov.setViewName("/shop/shopEdit");
		return mov;
	}

	@RequestMapping("/savestore")
	public ModelAndView savestore(Store store, Long[] picid) {
		ModelAndView mov = new ModelAndView();
		Store updatestore = storeService.getStoreById(store.getStore_id());
		updatestore.setStore_name(store.getStore_name());
		updatestore.setIntro(store.getIntro());
		updatestore.setPic(store.getPic());
		updatestore.setCategory_id(store.getCategory_id());
		if(store.getCategory_id()>0){
			StoreCategory storecategory = storeService.getStoreCategoryById(store.getCategory_id());
			if(storecategory!=null){
				updatestore.setCategory_name(storecategory.getName());
			}
		}
		updatestore.setLatitude(store.getLatitude());
		updatestore.setLongitude(store.getLongitude());
		updatestore.setPhone(store.getPhone());
		updatestore.setProvienceid(store.getProvienceid());
		updatestore.setCityid(store.getCityid());
		updatestore.setAreaid(store.getAreaid());
		String area = "";
		if (store.getProvienceid() > 0) {
			AreaInfo areainfo = commonService.getAreaInfoById(store.getProvienceid());
			area += areainfo.getName();
		}
		if (store.getCityid() > 0) {
			AreaInfo areainfo = commonService.getAreaInfoById(store.getCityid());
			area += areainfo.getName();
		}
		if (store.getAreaid() > 0) {
			AreaInfo areainfo = commonService.getAreaInfoById(store.getAreaid());
			area += areainfo.getName();
		}
		updatestore.setArea(area);
		updatestore.setAddress(store.getAddress());
		updatestore.setOpen_time(store.getOpen_time());
		updatestore.setClose_time(store.getClose_time());
		updatestore.setIs_out(store.getIs_out());
		updatestore.setSend_time(store.getSend_time());
		updatestore.setMin_send(store.getMin_send());
		updatestore.setSend_money(store.getSend_money());
		updatestore.setUpdate_time(new Date());
		storeService.updateStore(updatestore);
		List<StorePic> oldstorepic = updatestore.getStorepic_list();
		List<Long> oldpicid = new ArrayList<Long>();
		for (StorePic storepic : oldstorepic) {
			oldpicid.add(storepic.getPic_id());
		}
		List<Long> clist = new ArrayList<Long>();
		if(oldpicid!=null&&oldpicid.size()>0){
			clist.addAll(oldpicid);
		}
		List<Long> newpicid = null;
		if(picid!=null){
			newpicid = new ArrayList(Arrays.asList(picid));
			if(oldpicid!=null&&oldpicid.size()>0){
				oldpicid.removeAll(newpicid);
			}
		}
		if(clist!=null&&clist.size()>0){
			if(newpicid!=null&&newpicid.size()>0){
				newpicid.removeAll(clist);
			}
		}
		storeService.updateStorePic(oldpicid, newpicid, store.getStore_id());
		mov.setViewName("redirect:/shop/detail");
		return mov;
	}

	@RequestMapping("/imgupload")
	public void imgupload(HttpServletResponse response, @RequestParam(value = "imgfile", required = false) MultipartFile imgfile) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		if (imgfile != null && !imgfile.isEmpty()) {
			long picid = getFileId(imgfile, 1);
			result.put("code", 1);
			result.put("picid", picid);
		}
		CommonUtils.setMaptoJson(response, result);
	}

	@RequestMapping("/print")
	public ModelAndView print(Integer pageIndex, HttpSession session) {
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if (pageIndex == null) {
			pageIndex = 1;
		}
		ModelAndView mov = new ModelAndView();
		QueryResult<PrintInfo> result = printService.getPrintListByStoreId(shopid, pageIndex, Constants.SHOPLISTNUM);
		List<PrintInfo> printlist = result.getDataList();
		if (pageIndex > 1) {
			if (printlist != null && printlist.size() == 0) {
				pageIndex--;
				mov.setViewName("redirect:/shop/print?pageIndex=" + pageIndex);
				return mov;
			}
		}
		long pageCount = (result.getTotal() + Constants.SHOPLISTNUM - 1) / Constants.SHOPLISTNUM;
		mov.addObject("pageIndex", pageIndex);
		mov.addObject("pageCount", pageCount);
		mov.addObject("printlist", printlist);
		mov.setViewName("/shop/print");
		return mov;
	}

	@RequestMapping("/editprint")
	public ModelAndView editprint(Integer id, HttpSession session) {
		ModelAndView mov = new ModelAndView();
		if (id != null && id > 0) {
			PrintInfo print = printService.getPrintInfoById(id);
			long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
			if (print.getStore_id() != shopid) {
				mov.setViewName("redirect:/shop/print");
			} else {
				mov.addObject("print", print);
			}
		}
		return mov;
	}

	@RequestMapping("/saveprint")
	public ModelAndView saveprint(PrintInfo print, HttpSession session) {
		ModelAndView mov = new ModelAndView();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		print.setStore_id(shopid);
		printService.savePrint(print);
		mov.setViewName("redirect:/shop/print");
		return mov;
	}

	@RequestMapping("/delprint")
	public ModelAndView delprint(Long[] id) {
		ModelAndView mov = new ModelAndView();
		printService.delPrint(id);
		mov.setViewName("redirect:/shop/print");
		return mov;
	}
	
	@RequestMapping("/storeuser")
	public ModelAndView storeuser(Integer pageIndex, HttpSession session){
		ModelAndView mov = new ModelAndView();
		if(pageIndex == null){
			pageIndex = 1;
		}
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		QueryResult<StoreUser> result = storeUserService.getStoreUserListByStorePage(shopid, pageIndex, Constants.SHOPLISTNUM);
		if(result.getDataList() == null || result.getDataList().size() == 0){
			if(pageIndex > 1){
				pageIndex--;
				mov.setViewName("redirect:/shop/storeuser?pageIndex="+pageIndex);
			}
		}
		List<StoreUser> storeuserlist = result.getDataList();
		if(storeuserlist != null && storeuserlist.size() > 0){
			for (StoreUser storeUser : storeuserlist) {
				storeUser.setDiscount(storeUser.getDiscount()*100);
			}
		}
		long pageCount = (result.getTotal() + Constants.SHOPLISTNUM - 1) / Constants.SHOPLISTNUM;
		mov.addObject("pageIndex", pageIndex);
		mov.addObject("pageCount", pageCount);
		mov.addObject("storeuserlist", storeuserlist);
		mov.setViewName("shop/storeuserlist");
		return mov;
	}
	
	@RequestMapping("/editorStoreUser")
	public ModelAndView editorStoreUser(Long id, HttpSession session){
		ModelAndView mov = new ModelAndView();
		if(id != 0){
			StoreUser storeuser = storeUserService.getStoreUserById(id);
			storeuser.setDiscount(storeuser.getDiscount()*100);
			mov.addObject("storeuser", storeuser);
		}
		mov.setViewName("shop/editorStoreUser");
		return mov;
	}
	
	@RequestMapping("/saveorupdateStoreUser")
	public ModelAndView saveorupdateStoreUser(StoreUser storeuser, HttpSession session){
		ModelAndView mov = new ModelAndView();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(storeuser.getId() == 0){
			StoreUser storeUser = storeUserService.getCheckStoreUserByStorePhone(storeuser.getPhone(), shopid);
			if(storeUser == null){
				StoreUser user = new StoreUser();
				user.setDiscount(storeuser.getDiscount()/100F);
				user.setName(storeuser.getName());
				user.setPassword(CommonUtils.MD5(storeuser.getPassword()));
				user.setPhone(storeuser.getPhone());
				user.setPrivilege(storeuser.getPrivilege());
				user.setLimitreset(storeuser.getLimitreset());
				user.setStore_id(shopid);
				user.setDelflag(0);
				storeUserService.addStoreUser(user);
			}else{
				storeUser.setDiscount(storeuser.getDiscount());
				storeUser.setName(storeuser.getName());
				storeUser.setPassword(CommonUtils.MD5(storeuser.getPassword()));
				storeUser.setPrivilege(storeuser.getPrivilege());
				storeUser.setLimitreset(storeuser.getLimitreset());
				storeUser.setStore_id(shopid);
				storeUser.setDelflag(0);
				storeUserService.updateStoreUser(storeUser);
			}
			
		}else{
			StoreUser user = storeUserService.getStoreUserById(storeuser.getId());
			user.setDiscount(storeuser.getDiscount()/100F);
			user.setName(storeuser.getName());
			if(!CommonUtils.isEmptyString(storeuser.getPassword())){
				user.setPassword(CommonUtils.MD5(storeuser.getPassword()));
			}
			user.setPhone(storeuser.getPhone());
			user.setPrivilege(storeuser.getPrivilege());
			user.setLimitreset(storeuser.getLimitreset());
			storeUserService.updateStoreUser(user);
		}
		mov.setViewName("redirect:/shop/storeuser");
		return mov;
	}
	
	@RequestMapping("/delstoreuser")
	public void delstoreuser(Long id,HttpServletResponse response){
		StoreUser user = storeUserService.getStoreUserById(id);
		if(user != null){
			user.setDelflag(1);
			storeUserService.updateStoreUser(user);
			CommonUtils.setResponseStr("success", response);
		}else{
			CommonUtils.setResponseStr("error", response);
			return;
		}
	}
	
	@RequestMapping("/delStoreUserList")
	public void delStoreUserList(String id,HttpServletResponse response ){
		String[] idlist = id.split(",");
		if(idlist != null && idlist.length > 0){
			for (String strid : idlist) {
				StoreUser user = storeUserService.getStoreUserById(CommonUtils.parseLong(strid, 0));
				if(user != null){
					user.setDelflag(1);
					storeUserService.updateStoreUser(user);
				}
			}
		}
		CommonUtils.setResponseStr("success", response);
	}
	
	@RequestMapping("/checkstoreuserphone")
	public void checkstoreuserphone(Long id, String phone, HttpServletResponse response, HttpSession session){
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(id == 0){
			StoreUser user = storeUserService.getCheckStoreUserByStorePhone(phone, shopid);
			if(user != null && user.getDelflag() == 0){
				CommonUtils.setResponseStr("error", response);
				return;
			}else{
				CommonUtils.setResponseStr("success", response);
				return;
			}
		}else{
			StoreUser user = storeUserService.getCheckStoreUserByStorePhone(phone, shopid);
			if(user != null && user.getId() != id){
				CommonUtils.setResponseStr("error", response);
				return;
			}else{
				CommonUtils.setResponseStr("success", response);
			}
		}
	}
	
	@RequestMapping("/storesigner")
	public ModelAndView storesigner(Integer pageIndex, HttpSession session){
		ModelAndView mov = new ModelAndView();
		if(pageIndex == null){
			pageIndex = 1;
		}
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		QueryResult<StoreSigner> result = storeUserService.getStoreSignerListByPage(shopid, pageIndex, Constants.SHOPLISTNUM);
		if(result.getDataList() == null || result.getDataList().size() == 0){
			if(pageIndex > 1){
				pageIndex--;
				mov.setViewName("redirect:/shop/storesigner?pageIndex="+pageIndex);
				return mov;
			}
		}
		List<StoreSigner> storesingerlist = result.getDataList();
		long pageCount = (result.getTotal() + Constants.SHOPLISTNUM - 1) / Constants.SHOPLISTNUM;
		mov.addObject("pageIndex", pageIndex);
		mov.addObject("pageCount", pageCount);
		mov.addObject("storesingerlist", storesingerlist);
		mov.setViewName("shop/storesignerlist");
		return mov;
	}
	
	
	@RequestMapping("/editorStoreSigner")
	public ModelAndView editorStoreSigner(Long id, HttpSession session){
		ModelAndView mov = new ModelAndView();
		if(id != 0){
			StoreSigner storesigner = storeUserService.getStoreSignerById(id);
			mov.addObject("storesigner", storesigner);
		}
		mov.setViewName("shop/editorStoreSigner");
		return mov;
	}
	
	@RequestMapping("/saveorupdateStoreSinger")
	public ModelAndView saveorupdateStoreSinger(StoreSigner storesigner, HttpSession session){
		ModelAndView mov = new ModelAndView();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(storesigner.getId() == 0){
			StoreSigner signer = storeUserService.getStoreSignerByName(shopid, storesigner.getName());
			if(signer == null){
				StoreSigner user = new StoreSigner();
				user.setCompany(storesigner.getCompany());
				user.setDelflag(0);
				user.setName(storesigner.getName());
				user.setStore_id(shopid);
				storeUserService.addStoreSigner(user);
			}else{
				signer.setCompany(storesigner.getCompany());
				signer.setDelflag(0);
				signer.setStore_id(shopid);
				storeUserService.updateStoreSigner(signer);
			}
		}else{
			StoreSigner user = storeUserService.getStoreSignerById(storesigner.getId());
			user.setCompany(storesigner.getCompany());
			user.setName(storesigner.getName());
			storeUserService.updateStoreSigner(user);
		}
		mov.setViewName("redirect:/shop/storesigner");
		return mov;
	}
	
	@RequestMapping("/checkstoresigner")
	public void checkstoresigner(Long id, String name, HttpServletResponse response, HttpSession session){
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		StoreSigner signer = storeUserService.getStoreSignerByName(shopid, name);
		if(id == 0){
			if(signer != null && signer.getDelflag() == 0){
				CommonUtils.setResponseStr("error", response);
				return;
			}else{
				CommonUtils.setResponseStr("success", response);
				return;
			}
		}else{
			if(signer != null && signer.getId() != id){
				CommonUtils.setResponseStr("error", response);
				return;
			}else{
				CommonUtils.setResponseStr("success", response);
				return;
			}
		}
	}
	
	@RequestMapping("/delStoreSignerList")
	public void delStoreSignerList(String id, HttpSession session, HttpServletResponse response){
//		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(!CommonUtils.isEmptyString(id)){
			String[] idlist = id.split(",");
			if(idlist != null && idlist.length > 0){
				for (String idstr : idlist) {
					StoreSigner signer = storeUserService.getStoreSignerById(CommonUtils.parseLong(idstr, 0));
					if(signer != null){
						signer.setDelflag(1);
						storeUserService.updateStoreSigner(signer);
					}
				}
			}
		}
		CommonUtils.setResponseStr("success", response);
		return;
	}
	
	@RequestMapping("/delstoreSigner")
	public void delstoreSigner(Long id, HttpSession session, HttpServletResponse response){
		StoreSigner signer = storeUserService.getStoreSignerById(id);
		if(signer != null){
			signer.setDelflag(1);
			storeUserService.updateStoreSigner(signer);
		}
		CommonUtils.setResponseStr("success", response);
		return;
	}
	
	@RequestMapping("/lookSignerRecord")
	public ModelAndView lookSignerRecord(Integer pageIndex, Long id, HttpSession session){
		ModelAndView mov = new ModelAndView();
		if(pageIndex == null){
			pageIndex = 1;
		}
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		QueryResult<Order> result = orderService.getSignerOrderListByPage(pageIndex, id, shopid, Constants.SHOPLISTNUM);
		if(result.getDataList() == null || result.getDataList().size() == 0){
			if(pageIndex > 1){
				pageIndex--;
				mov.setViewName("redirect:/shop/lookSignerRecord?pageIndex="+pageIndex);
				return mov;
			}
		}
		List<Order> orderlist = result.getDataList();
		long pageCount = (result.getTotal() + Constants.SHOPLISTNUM - 1) / Constants.SHOPLISTNUM;
		mov.addObject("pageIndex", pageIndex);
		mov.addObject("pageCount", pageCount);
		mov.addObject("orderlist", orderlist);
		mov.setViewName("shop/signerrecordlist");
		return mov;
	}
}
