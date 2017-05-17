package com.daoshun.shiqu.controller.shop;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.common.Constants;
import com.daoshun.shiqu.common.QueryResult;
import com.daoshun.shiqu.pojo.Menu;
import com.daoshun.shiqu.pojo.MenuCategory;
import com.daoshun.shiqu.pojo.MyCoupon;
import com.daoshun.shiqu.pojo.Order;
import com.daoshun.shiqu.pojo.OrderDetail;
import com.daoshun.shiqu.pojo.PrintInfo;
import com.daoshun.shiqu.pojo.RechargeCard;
import com.daoshun.shiqu.pojo.RechargeRecord;
import com.daoshun.shiqu.pojo.Store;
import com.daoshun.shiqu.pojo.StoreArea;
import com.daoshun.shiqu.pojo.StoreSigner;
import com.daoshun.shiqu.pojo.StoreTable;
import com.daoshun.shiqu.pojo.StoreUser;
import com.daoshun.shiqu.service.CouponService;
import com.daoshun.shiqu.service.DishesService;
import com.daoshun.shiqu.service.OrderService;
import com.daoshun.shiqu.service.PrintService;
import com.daoshun.shiqu.service.ShopService;
import com.daoshun.shiqu.service.StoreOrderService;
import com.daoshun.shiqu.service.StoreService;
import com.daoshun.shiqu.service.StoreTableService;
import com.daoshun.shiqu.service.StoreUserService;

@Controller
@RequestMapping("/shop")
public class TableManage {

	@Resource(name="storeTableService")
	StoreTableService storeTableService;
	
	@Resource(name="printService")
	PrintService printService;
	
	@Resource(name="orderService")
	OrderService orderService;
	
	@Resource(name="storeOrderService")
	StoreOrderService storeOrderService;
	
	@Resource(name="storeUserService")
	StoreUserService storeUserService;
	
	@Resource(name="storeService")
	StoreService storeService;
	
	@Resource(name = "couponService")
	CouponService couponService;
	
	@Resource(name = "shopService")
	ShopService shopService;
	
	@Resource(name = "dishesService")
	DishesService dishesService;
	
	@RequestMapping("/tablearea")
	public ModelAndView tablearea(Integer pageIndex,HttpSession session){
		ModelAndView mov = new ModelAndView();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(pageIndex==null){
			pageIndex = 1;
		}
		QueryResult<StoreArea> result = storeTableService.getStoreAreaList(shopid, pageIndex, Constants.SHOPLISTNUM);
		List<StoreArea> arealist = result.getDataList();
		if(pageIndex>1){
			if(arealist==null||arealist.size()==0){
				pageIndex--;
				mov.setViewName("redirect:/shop/tablearea?pageIndex="+pageIndex);
			}
		}
		long pageCount = ( result.getTotal() + Constants.SHOPLISTNUM - 1 ) / Constants.SHOPLISTNUM ;
		mov.addObject("arealist",arealist);
		mov.addObject("pageCount",pageCount);
		mov.addObject("pageIndex",pageIndex);
		
		return mov;
	}
	
	@RequestMapping("/edittablearea")
	public ModelAndView edittablearea(Long id,HttpSession session ){
		ModelAndView mov = new ModelAndView();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(id!=null&&id>0){
			StoreArea storearea = storeTableService.getStoreAreaById(id);
			mov.addObject("area",storearea);
		}
		List<PrintInfo> printlist = printService.getPrintListByStoreId(shopid,1);
		mov.addObject("printlist",printlist);
		mov.setViewName("/shop/edittablearea");
		return mov;
	}
	
	@RequestMapping("/savetablearea")
	public ModelAndView savetablearea(StoreArea storearea,HttpSession session ){
		ModelAndView mov = new ModelAndView();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(storearea.getId()>0){
			StoreArea updatestorearea = storeTableService.getStoreAreaById(storearea.getId());
			updatestorearea.setArea_name(storearea.getArea_name());
			updatestorearea.setPrint_id1(storearea.getPrint_id1());
			updatestorearea.setPrint_id2(storearea.getPrint_id2());
			updatestorearea.setPrint_id3(storearea.getPrint_id3());
			storeTableService.saveStoreArea(updatestorearea);
		}else{
			storearea.setStore_id(shopid);
			storeTableService.saveStoreArea(storearea);
		}
		mov.setViewName("redirect:/shop/tablearea");
		return mov;
	}
	
	@RequestMapping("/deltablearea")
	public void deltablearea(Long[] id,HttpSession session,HttpServletResponse response){
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		HashMap<String,Object> result = new HashMap<String,Object>();
		int delable = 0;
		for(Long area_id:id){
			if(area_id!=null&&area_id>0){
				List<StoreTable> tablelist = storeTableService.getStoreTableList(shopid, area_id);
				if(tablelist!=null&&tablelist.size()>0){
					delable =1;
					result.put("code", 100);
					result.put("message", tablelist.get(0).getArea_name()+"存在桌台信息，删除失败!");	
					CommonUtils.setMaptoJson(response, result);
					break;
				}
			}
		}
		if(delable==0){
			storeTableService.delStoreArea(id, shopid);
			result.put("code", 1);
			CommonUtils.setMaptoJson(response, result);
		}
	}
	
	@RequestMapping("/table")
	public ModelAndView table(Integer area_id,String keyword,Integer pageIndex,HttpSession session){
		ModelAndView mov = new ModelAndView();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(pageIndex==null){
			pageIndex = 1;
		}
		QueryResult<StoreTable> result = storeTableService.getTableListByStoreid(area_id,keyword, shopid,pageIndex,Constants.SHOPLISTNUM);
		List<StoreTable> tablelist = result.getDataList();
		if(pageIndex>1){
			if(tablelist==null||tablelist.size()==0){
				pageIndex--;
				mov.setViewName("redirect:/shop/table?pageIndex="+pageIndex+"&area_id="+area_id+"&keyword="+keyword);
				return mov;
			}
		}
		long pageCount = ( result.getTotal() + Constants.SHOPLISTNUM - 1 )/Constants.SHOPLISTNUM;
		List<StoreArea> arealist = storeTableService.getAreaListByStoreId(shopid);
		mov.addObject("arealist", arealist);
		mov.addObject("tablelist", tablelist);
		mov.addObject("pageIndex", pageIndex);
		mov.addObject("pageCount", pageCount);
		mov.addObject("area_id", area_id);
		mov.addObject("keyword", keyword);
		return mov;
	}
	
	@RequestMapping("/edittable")
	public ModelAndView edittable(Long id,HttpSession session){
		ModelAndView mov = new ModelAndView();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(id!=null&&id>0){
			StoreTable storetable = storeTableService.getStoreTableById(id);
			mov.addObject("storetable", storetable);
		}
		List<StoreArea> arealist = storeTableService.getAreaListByStoreId(shopid);
		mov.addObject("arealist", arealist);
		mov.setViewName("/shop/edittable");
		return mov;
	}
	
	@RequestMapping("/savetable")
	public ModelAndView savetable(Long table_id,String table_no,Long area_id ,Integer num,HttpSession session){
		ModelAndView mov = new ModelAndView();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(area_id==null){
			area_id = 0l ;
		}
		if(num==null){
			num = 0;
		}
		if(table_id!=null&&table_id>0){
			StoreTable updatetable = storeTableService.getStoreTableById(table_id);
			if(updatetable!=null){
				updatetable.setArea_id(area_id);
				updatetable.setNum(num);
				updatetable.setTable_no(table_no);
				storeTableService.updateStoreTable(updatetable);
			}
		}else{
			StoreTable storetable= new StoreTable();
			storetable.setArea_id(area_id);
			storetable.setNum(num);
			storetable.setTable_no(table_no);
			storetable.setState(1);
			storetable.setStore_id(shopid);
			storeTableService.addStoreTable(storetable);
		}
		mov.setViewName("redirect:/shop/table");
		return mov;
	}
	
	
	@RequestMapping("/deltable")
	public void deltable(Long[] id,HttpSession session,HttpServletResponse response){
//		ModelAndView mov = new ModelAndView();
		HashMap<String,Object> result = new HashMap<String,Object>();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		List<StoreTable> tablelist = storeTableService.getStoreTableListByIDS(id, shopid);
		int delable = 0;
		for(StoreTable table:tablelist){
			if(table.getState()==2){
				delable = 1;
				result.put("code", 100);
				result.put("message",table.getArea_name() +table.getTable_no()+"有客，无法删除桌台!");
				CommonUtils.setMaptoJson(response, result);
				break;
			}
			if(table.getState()==3){
				delable = 1;
				result.put("code", 100);
				result.put("message",table.getArea_name() +table.getTable_no()+"已经被预约，无法删除桌台!");
				CommonUtils.setMaptoJson(response, result);
				break;
			}
			
		}
		if(delable==0){
			storeTableService.delStoreTable(id, shopid);	
			result.put("code", 1);
			CommonUtils.setMaptoJson(response, result);
		}
		
//		mov.setViewName("redirect:/shop/table");
//		return mov;
	}
	
	@RequestMapping("/tablemanage")
	public ModelAndView tablemanage(Long area_id,HttpSession session){
		ModelAndView mov = new ModelAndView();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		List<StoreArea> arealist = storeTableService.getAreaListByStoreId(shopid);
		mov.addObject("arealist", arealist);
		if(area_id==null){
			if(arealist!=null&&arealist.size()>0){
				area_id = arealist.get(0).getId();
			}
		}
		mov.addObject("area_id", area_id);
		if(area_id!=null&&area_id>0){
			List<StoreTable> storetable = storeTableService.getStoreTableList(shopid, area_id);
			mov.addObject("storetable", storetable);
		}
		List<StoreSigner> signerlist =  storeUserService.getStoreSignerByStoreId(shopid );
		mov.addObject("signerlist", signerlist);
		List<MenuCategory> menucategorys = shopService.getStoreMenu(shopid);
		mov.addObject("menucategorys", menucategorys);
		List<Menu> menulist = storeTableService.getMenuListById(shopid, 0l);
		mov.addObject("menulist", menulist);
		long freecount = storeTableService.getTableCount(shopid, 1);
		mov.addObject("freecount", freecount);
		long usecount = storeTableService.getTableCount(shopid, 2);
		mov.addObject("usecount", usecount);
		long nocleancount = storeTableService.getTableCount(shopid, 5);
		mov.addObject("nocleancount", nocleancount);
		long ordercount = storeTableService.getTableCount(shopid, 3);
		mov.addObject("ordercount", ordercount);
		long unusecount = storeTableService.getTableCount(shopid, 4);
		mov.addObject("unusecount", unusecount);
		long allcount = freecount+usecount+ordercount+unusecount;
		mov.addObject("allcount", allcount);
		return mov;
	}
	
	@RequestMapping("/precheckout")
	public void precheckout(Long order_id,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		if(order_id!=null){
			storeTableService.sendOrderPrint(order_id,1);
		}
		result.put("code", 1);
		CommonUtils.setMaptoJson(response, result);
	}
	
	@RequestMapping("/cleantable")
	public void cleantable(Long table_id,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		if(table_id!=null){
			int code = storeTableService.cleanTable(table_id);
			result.put("code", code);
			if(code!=1){
				if(code==99){
					result.put("message", "空闲桌台无需清台!");
				}else{
					result.put("message", "桌台有订单未完成，清台失败!");
				}
			}
		}
		CommonUtils.setMaptoJson(response, result);
	}
	
	@RequestMapping("/ordertable")
	public void ordertable(Long table_id,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		if(table_id!=null){
			StoreTable storetable = storeTableService.getStoreTableById(table_id);
			if(storetable==null){
				result.put("code", 100);
				result.put("message", "桌台信息错误，预定失败!");
			}else{
				if(storetable.getState()!=1){
					result.put("code", 100);
					result.put("message", "非空闲桌台无法接受预定，预定失败!");
				}else{
					storetable.setState(3);
					storeTableService.updateStoreTable(storetable);
					result.put("code", 1);
				}
			}
		}
		CommonUtils.setMaptoJson(response, result);
	}
	
	@RequestMapping("/getTableList")
	public void getTableList(Long area_id,HttpSession session,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(area_id!=null){
			List<StoreTable> storetable = storeTableService.getStoreTableList(shopid, area_id);
			result.put("storetable", storetable);
			result.put("code", 1);
		}else{
			result.put("code", 100);
		}
		CommonUtils.setMaptoJson(response, result);
	}
	
	@RequestMapping("/getTableListNoUse")
	public void getTableListNoUse(Long area_id,HttpSession session,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(area_id!=null){
			List<StoreTable> storetable = storeTableService.getStoreTableListNoUse(shopid, area_id);
			result.put("storetable", storetable);
			result.put("code", 1);
		}else{
			result.put("code", 100);
		}
		CommonUtils.setMaptoJson(response, result);
	}
	
	//换桌（占用）
	@RequestMapping("/changeTable")
	public void changeTable(Long from_id,Long to_id,HttpSession session,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		long storeuserid = CommonUtils.parseInt(String.valueOf(session.getAttribute("storeuserid")), 0) ;  
		StoreTable fromtable = storeTableService.getStoreTableById(from_id);
		StoreTable totable = storeTableService.getStoreTableById(to_id);
		if(fromtable!=null&&fromtable.getStore_id()==shopid&&totable!=null&&totable.getStore_id()==shopid){
			if(totable.getState()==1){
				Order order = orderService.getOrderDetail(fromtable.getCorrent_order());
				if(order==null){
					result.put("code", 100);
					result.put("message", "旧桌台没有菜单，占用失败!");	
				}else{
					totable.setState(2);
					totable.setCorrent_order(order.getOrder_id());
					storeTableService.updateStoreTable(totable);
					order.setTable_id(totable.getTable_id());
					storeOrderService.updateOrder(order);
					fromtable.setCorrent_order(0);
					storeTableService.updateStoreTable(fromtable);
					storeTableService.changeTablePrint(from_id, to_id, storeuserid);
					result.put("code", 1);
				}
			}else{
				result.put("code", 100);
				result.put("message", "新桌台非空闲状态，占用失败!");	
			}
		}else{
			result.put("code", 100);
			result.put("message", "桌台数据错误，占用失败!");
		}
		CommonUtils.setMaptoJson(response, result);
	}
	
	@RequestMapping("/cancelfree")
	@ResponseBody
	public HashMap<String,Object> cancelfree(Long detail_id,HttpSession session,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		if(detail_id!=null&&detail_id>0){
			OrderDetail orderdetail = orderService.getDetail(detail_id);
			Order order = orderService.getOrderDetail(orderdetail.getOrder_id());
			Menu menu = dishesService.getMenuById(orderdetail.getMenu_id());
			if(menu!=null&&order!=null){
				orderdetail.setPrice(menu.getPrice());
				orderdetail.setIs_free(0);
				storeOrderService.updateOrderDetail(orderdetail);
				float orderprice = orderdetail.getPrice()*orderdetail.getQuantity();
				if(orderdetail.getIs_weigh()==1){
					orderprice = orderprice * orderdetail.getWeight();
				}
				order.setTotal_price(order.getTotal_price()+orderprice);
				order.setPrice(order.getPrice()+orderprice);
				storeOrderService.updateOrder(order);
				result.put("code", 1);
				result.put("price", menu.getPrice());
				result.put("allprice", orderprice);
			}else{
				result.put("code", 100);
				result.put("message", "菜品数据有误，赠送失败!");
			}
		}else{
			result.put("code", 100);
			result.put("message", "菜品数据有误，取消赠送失败!");
		}
		return result;
	}
	
	//赠菜
	@RequestMapping("/freeorder")
	public void freeorder(Long detail_id,HttpSession session,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		if(detail_id!=null&&detail_id>0){
			OrderDetail orderdetail = orderService.getDetail(detail_id);
			if(orderdetail!=null){
				Order order = orderService.getOrderDetail(orderdetail.getOrder_id());
				if(order!=null){
					float orderprice = orderdetail.getPrice()*orderdetail.getQuantity();
					if(orderdetail.getIs_weigh()==1){
						orderprice = orderprice * orderdetail.getWeight();
					}
					order.setTotal_price(order.getTotal_price()-orderprice);
					order.setPrice(order.getPrice()-orderprice);
					storeOrderService.updateOrder(order);
					orderdetail.setPrice(0);
					orderdetail.setIs_free(1);
					storeOrderService.updateOrderDetail(orderdetail);
					result.put("code", 1);
				}else{
					result.put("code", 100);
					result.put("message", "菜品数据有误，赠送失败!");
				}
			}else{
				result.put("code", 100);
				result.put("message", "菜品数据有误，赠送失败!");
			}
		}else{
			result.put("code", 100);
			result.put("message", "菜品数据有误，赠送失败!");
		}
		CommonUtils.setMaptoJson(response, result);
	}
	
	//退菜
	@RequestMapping("/delorderDetail")
	public void delorderDetail(Long detail_id,HttpSession session,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		if(detail_id!=null&&detail_id>0){
			OrderDetail orderdetail = orderService.getDetail(detail_id);
			if(orderdetail!=null){
				Order order = orderService.getOrderDetail(orderdetail.getOrder_id());
				if(order!=null){
					float orderprice = orderdetail.getPrice()*orderdetail.getQuantity();
					if(orderdetail.getIs_weigh()==1){
						orderprice = orderprice * orderdetail.getWeight();
					}
					order.setTotal_price(order.getTotal_price()-orderprice);
					order.setPrice(order.getPrice()-orderprice);
					storeOrderService.updateOrder(order);
					storeOrderService.delOrderDetailPrint(detail_id);
					orderdetail.setDetail_flg(-1);
					storeOrderService.updateOrderDetail(orderdetail);
					result.put("code", 1);
				}else{
					result.put("code", 100);
					result.put("message", "菜品数据有误，退菜失败!");
				}
			}else{
				result.put("code", 100);
				result.put("message", "菜品数据有误，退菜失败!");
			}
		}else{
			result.put("code", 100);
			result.put("message", "菜品数据有误，退菜失败!");
		}
		CommonUtils.setMaptoJson(response, result);
	}
	
	//称重
	@RequestMapping("/makeweight")
	public void makeweight(Long detail_id,Float weight,HttpSession session,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		if(detail_id!=null&&detail_id>0&&weight!=null&&weight>0){
			OrderDetail orderdetail = orderService.getDetail(detail_id);
			if(orderdetail!=null){
				Order order = orderService.getOrderDetail(orderdetail.getOrder_id());
				if(order!=null){
					if(orderdetail.getIs_weigh()==1){
						float orderprice = orderdetail.getPrice()*orderdetail.getQuantity() * orderdetail.getWeight();
						float oldtotalprice = order.getTotal_price()-orderprice;
						float oldprice = order.getPrice()-orderprice;
						orderdetail.setWeight(weight);
						storeOrderService.updateOrderDetail(orderdetail);
						float newtotalprice = oldtotalprice + orderdetail.getPrice()*orderdetail.getQuantity()*weight;
						float newprice = oldprice +  orderdetail.getPrice()*orderdetail.getQuantity()*weight;
						order.setTotal_price(newtotalprice);
						order.setPrice(newprice);
						storeOrderService.updateOrder(order);
						result.put("order_id", order.getOrder_id());
						result.put("newprice", newprice);
						result.put("weightprice", orderdetail.getPrice()*orderdetail.getQuantity()*weight);
						result.put("code", 1);
					}else{
						result.put("code", 100);
						result.put("message", "该菜品无法称重!");
					}
				
				}else{
					result.put("code", 100);
					result.put("message", "称重数据有误，称重失败!");
				}
			}else{
				result.put("code", 100);
				result.put("message", "称重数据有误，称重失败!");
			}
		}else{
			result.put("code", 100);
			result.put("message", "称重数据有误，称重失败!");
		}
		CommonUtils.setMaptoJson(response, result);
	}
	
	//称重
	@RequestMapping("/getPayOrder")
	public void getPayOrder(Long order_id,HttpSession session,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		Order order = orderService.getOrderDetail(order_id);
		if(order!=null){
			long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
			if(order.getStore_id()==shopid){
				if(order.getState()==2){
					int no_weight=0;
					for(OrderDetail orderdetail:order.getMenu_list()){
						if(orderdetail.getIs_weigh()==1){
							if(orderdetail.getWeight()==0f){
								no_weight =1;
							}
						}
					}
					if(no_weight==0){
						long storeusrid = CommonUtils.parseInt(String.valueOf(session.getAttribute("storeuserid")), 0);
						StoreUser storeuser = storeUserService.getStoreUserById(storeusrid);
						result.put("code", 1);
						result.put("discount",storeuser.getDiscount() );
						result.put("limitreset",storeuser.getLimitreset() );
						result.put("totalprice",order.getTotal_price() );
						float discountprice = orderService.canDiscountOrderPrice(order_id);
						result.put("discountprice",discountprice );
						result.put("nodiscountprice",order.getTotal_price()-discountprice );
					}else{
						result.put("code", 100);
						result.put("message", "存在未称重的菜品，请在称重后收银!");
					}
				}else{
					result.put("code", 100);
					result.put("message", "收银订单状态 错误，无法收银！");
				}
			}else{
				result.put("code", 100);
				result.put("message", "收银订单数据有误！");
			}
		}else{
			result.put("code", 100);
			result.put("message", "收银订单数据有误！");
		}
		CommonUtils.setMaptoJson(response, result);
	}
	
	@RequestMapping("/checkCoupon")
	public void getPayOrder(String coupon_no,HttpSession session,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		if(!CommonUtils.isEmptyString(coupon_no)){
			MyCoupon mycoupon = couponService.getMyCouponByCouponno(coupon_no);
			if(mycoupon!=null){
				if(mycoupon.getIs_used()==0){
					if(mycoupon.getCoupon().getFrom_time().getTime()<=System.currentTimeMillis()&&System.currentTimeMillis()<=mycoupon.getCoupon().getEnd_time().getTime()){
						result.put("code", 1);
						result.put("mycoupon", mycoupon);
					}else{
						result.put("code", 100);
						result.put("message", "优惠券已过期!");
					}
				}else{
					result.put("code", 100);
					result.put("message", "无效优惠券！");
				}
			}else{
				result.put("code", 100);
				result.put("message", "无效优惠券！");
			}
		}else{
			result.put("code", 100);
			result.put("message", "无效优惠券！");
		}
		CommonUtils.setMaptoJson(response, result);
	}
	
	@RequestMapping("/checkRechangeCard")
	public void checkRechangeCard(String cardno,HttpSession session,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		if(!CommonUtils.isEmptyString(cardno)){
			RechargeCard rechargecard = couponService.getRechargeCradByCardno(shopid,cardno);
			if(rechargecard!=null){
				result.put("code", 1);
				result.put("rechargecard", rechargecard);
			}else{
				result.put("code", 100);
				result.put("message", "无效充值卡！"); 
			}
		}else{
			result.put("code", 100);
			result.put("message", "无效充值卡！");
		}
		CommonUtils.setMaptoJson(response, result);
	}
	
	@RequestMapping("/cashier")
	public void cashier(Long order_id,Long coupon_id,Float discount,Float moling,int type,
			Long card_id,Long qiandan_id,Long miandan_id,String comment,Float price,Float ordercash,
			Float orderzhifubao,Float ordercard,HttpSession session,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		Store store = storeService.getStoreById(shopid);
		if(type==4){
			if(card_id==null){
				result.put("code", 100);
				result.put("message", "请输入充值卡!");
				CommonUtils.setMaptoJson(response, result);
				return; 
			}
		}else if(type==5){
			if(qiandan_id==null){
				result.put("code", 100);
				result.put("message", "请选择签单人!");
				CommonUtils.setMaptoJson(response, result);
				return; 
			}
		}else if(type==6){
			if(miandan_id==null){
				result.put("code", 100);
				result.put("message", "请选择免单人!");
				CommonUtils.setMaptoJson(response, result);
				return; 
			}
		}
		Order order = orderService.getOrderDetail(order_id);
		if(order==null||order.getStore_id()!=shopid){
			result.put("code", 100);
			result.put("message", "订单数据错误!");
			CommonUtils.setMaptoJson(response, result);
			return; 
		}
		if(type==4){
			RechargeCard rechargeCard = couponService.getRechargeCard(card_id);
			if (rechargeCard == null) {
				result.put("code", 100);
				result.put("message", "充值卡信息错误!");
				CommonUtils.setMaptoJson(response, result);
				return; 
			}
			if (rechargeCard.getMoney() < price) {
				result.put("code", 100);
				result.put("message", "充值卡余额不足 !");
				CommonUtils.setMaptoJson(response, result);
				return; 
			}
			rechargeCard.setMoney(rechargeCard.getMoney() - price);
			couponService.updateRechargeCard(rechargeCard);
			RechargeRecord record = new RechargeRecord();
			record.setCard_id(0);
			record.setCharge_time(new Date());
			record.setCharge_money(price);
			record.setMoney(price);
			record.setType(2);
			record.setUser_id(order.getUser_id());
			couponService.addRechargeRecord(record);
			order.setCard_no(rechargeCard.getCard_no());
		}
		order.setCoupon_id(coupon_id);
		if(coupon_id!=null&&coupon_id>0){
			MyCoupon mycoupon = couponService.getMyCouponById(coupon_id);
			mycoupon.setIs_used(1);
			couponService.updateMyCoupon(mycoupon);
		}
		order.setDiscount(discount==null?0:discount);
		order.setMoling(moling==null?0f:moling);
		order.setPay_type(type);
		if(type==5){
			order.setSigner_id(qiandan_id);
		}
		if(type==6){
			order.setSigner_id(miandan_id);
		}
		order.setSerial_num(CommonUtils.makeSerialNum());
		order.setComment(comment);
		order.setState(4);
		order.setPrice(price);
		order.setCheck_time(new Date());
		if(type==1||type==2||type==3){
			float actually_pay = (ordercash==null?0:ordercash) + (orderzhifubao==null?0:orderzhifubao) + (ordercard==null?0:ordercard); ;
			order.setActually_pay(actually_pay); 
		}
		storeOrderService.updateOrder(order);
		storeOrderService.accountDaily(order_id);
		store.setSales_num(store.getSales_num()+1);
		storeService.updateStore(store);
		storeService.sendOrderPrint(order_id,2);
		result.put("code", 1);
		CommonUtils.setMaptoJson(response, result);
	}
	
	@RequestMapping("/menulist")
	public void menulist(Long menu_type,HttpSession session,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		List<Menu> menulist = storeTableService.getMenuListById(shopid, menu_type);
		result.put("menulist", menulist);
		CommonUtils.setMaptoJson(response, result);
	}
	
	@RequestMapping("/addorderdetail")
	public void addorderdetail(Long[] menuid,Integer[] menunum,Long order_id,HttpSession session,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0);
		Order order = orderService.getOrderDetail(order_id);
		if(order!=null){
			if(order.getStore_id()==shopid){
			if(order.getState()==2){
				int price = 0;
				for(int i=0;i<menunum.length;i++){
					Integer num = menunum[i];
					if(num>0){
						Long menu_id = menuid[i];
						Menu menu = storeTableService.getMenuById(menu_id);
						if(menu!=null){
							OrderDetail orderdetail = new OrderDetail();
							orderdetail.setOrder_id(order_id);
							orderdetail.setMenu_id(menu_id);
							orderdetail.setMenu_name(menu.getMenu_name());
							orderdetail.setQuantity(num);
							orderdetail.setPrice(menu.getPrice());
							orderdetail.setUnit(menu.getUnit());
							orderdetail.setKitunit(menu.getKitunit());
							orderdetail.setCan_discount(menu.getCan_discount());
							orderdetail.setIs_weigh(menu.getIs_weigh());
							if(menu.getIs_weigh()==0){
								price += menu.getPrice() * num;
							}
							storeTableService.addOrderDetail(orderdetail);
						}
					}
				}
				if(price>0){
					order.setTotal_price(order.getTotal_price() + price);
					order.setPrice(order.getPrice() + price);
					storeOrderService.updateOrder(order);
				}
				result.put("code", 1);
			}else{
				result.put("code", 100);
				result.put("message", "订单状态错误!加菜失败");	
			}
			}else{
				result.put("code", 100);
				result.put("message", "订单数据错误!加菜失败");
			}
		}else{
			result.put("code", 100);
			result.put("message", "订单数据错误!加菜失败");
		}
		CommonUtils.setMaptoJson(response, result);
	}
	
	@RequestMapping("/sendkitchen")
	public void sendkitchen(Long order_id,HttpSession session,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		if(order_id!=null){
			storeTableService.sendOrderDetailPrint(order_id);
			storeTableService.sendOrderDetailSingelPrint(order_id);
		}
		result.put("code", 1);
		CommonUtils.setMaptoJson(response, result);
	}
	
	@RequestMapping("/disabletable")
	public void disabletable(Long table_id,HttpSession session,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		if(table_id!=null){
			StoreTable storetable = storeTableService.getStoreTableById(table_id);
			if(storetable==null){
				result.put("code", 100);
				result.put("message", "桌台信息错误，预定失败!");
			}else{
				if(storetable.getState()!=1){
					result.put("code", 100);
					result.put("message", "非空闲桌台无法设置不可用!");
				}else{
					storetable.setState(4);
					storeTableService.updateStoreTable(storetable);
					result.put("code", 1);
				}
			}
		}
		CommonUtils.setMaptoJson(response, result);
	}
	
	@RequestMapping("/changeDetail")
	public void changeDetail(Long detail_id,Long to_id,HttpSession session,HttpServletResponse response){
		HashMap<String,Object> result = new HashMap<String,Object>();
		if(detail_id!=null&&detail_id>0&&to_id!=null&&to_id>0){
			OrderDetail orderdetail = orderService.getDetail(detail_id);
			if(orderdetail!=null){
				Order order = orderService.getOrderDetail(orderdetail.getOrder_id());
				if(order.getState()==2){
					StoreTable totable = storeTableService.getStoreTableById(to_id);
					if(totable!=null){
						Order toorder = orderService.getOrderDetail(totable.getCorrent_order());
						if(toorder!=null){
							if(toorder.getState()==2){
								orderdetail.setOrder_id(toorder.getOrder_id());
								storeOrderService.updateOrderDetail(orderdetail);
								float price  = orderdetail.getPrice()*orderdetail.getQuantity();
								if(orderdetail.getIs_weigh()==1){
									price = price * orderdetail.getWeight();
								}
								order.setTotal_price(order.getTotal_price()-price);
								order.setPrice(order.getPrice()-price);
								storeOrderService.updateOrder(order);
								toorder.setTotal_price(toorder.getTotal_price()+price);
								toorder.setPrice(toorder.getPrice()+price);
								storeOrderService.updateOrder(toorder);
								result.put("code", 1);
							}else{
								result.put("code", 100);
								result.put("message", "转菜桌台订单状态错误!转菜失败");
							}
						}else{
							result.put("code", 100);
							result.put("message", "转菜桌台没有订单!转菜失败");
						}
					}else{
						result.put("code", 100);
						result.put("message", "转菜桌台错误!转菜失败");
					}
				}else{
					result.put("code", 100);
					result.put("message", "订单状态错误!转菜失败");
				}
			}else{
				result.put("code", 100);
				result.put("message", "菜品数据错误!转菜失败");
			}
		}else{
			result.put("code", 100);
			result.put("message", "菜品数据错误!转菜失败");
		}
		CommonUtils.setMaptoJson(response, result);
	}
}
