package com.daoshun.shiqu.controller.shop;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.common.Constants;
import com.daoshun.shiqu.common.QueryResult;
import com.daoshun.shiqu.pojo.Order;
import com.daoshun.shiqu.pojo.OrderDetail;
import com.daoshun.shiqu.pojo.Refuse;
import com.daoshun.shiqu.pojo.StoreArea;
import com.daoshun.shiqu.pojo.StoreTable;
import com.daoshun.shiqu.service.OrderService;
import com.daoshun.shiqu.service.StoreOrderService;
import com.daoshun.shiqu.service.StoreTableService;
import com.daoshun.shiqu.service.manage.MaCommonService;

@Controller
@RequestMapping("/shop")
public class OrderManage {

	@Resource(name="storeOrderService")
	StoreOrderService storeOrderService;
	
	@Resource(name="storeTableService")
	StoreTableService storeTableService;
	
	@Resource(name="orderService")
	OrderService orderService;
	
	@Resource(name="maCommonService")
	MaCommonService maCommonService;
	
	@RequestMapping("/order")
	public ModelAndView order(Integer is_out,Integer state,String order_time,String keyword,Integer pageIndex,HttpSession session){
		ModelAndView mov = new ModelAndView();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0) ;
		if(pageIndex==null){
			pageIndex=1;
		}
		QueryResult<Order> result = storeOrderService.getOrderListByStoreId(shopid, is_out, state, order_time, keyword, pageIndex, Constants.SHOPLISTNUM);
		List<Order> orderlist = result.getDataList();
		long pageCount = (result.getTotal() + Constants.SHOPLISTNUM - 1)/Constants.SHOPLISTNUM;
		List<Refuse> refuselist = maCommonService.getRefuseList();
		List<StoreArea> arealist = storeTableService.getAreaListByStoreId(shopid);
		mov.addObject("arealist", arealist);
		mov.addObject("pageCount", pageCount);
		mov.addObject("pageIndex", pageIndex);
		mov.addObject("orderlist", orderlist);
		mov.addObject("refuselist", refuselist);
		mov.addObject("is_out", is_out);
		mov.addObject("state", state);
		mov.addObject("order_time", order_time);
		mov.addObject("keyword", keyword);
		mov.setViewName("/shop/order");
		return mov;
	}
	
	@RequestMapping("/reciveOrder")
	public void reciveOrder(int state,long order_id,String refuse_reason,Long table_id,HttpSession session,HttpServletResponse response ){
		HashMap<String,Object> result = new HashMap<String,Object>();
		long shopid = CommonUtils.parseInt(String.valueOf(session.getAttribute("shopid")), 0) ;
		Order order = orderService.getOrderDetail(order_id);
		if(order!=null){
			if(order.getStore_id()==shopid){
				if(order.getState()==1){
					if(state!=2&&state!=3){
						result.put("code", 500);
						result.put("message", "订单状态错误，操作失败!");
					}else{
						if(state==3){
						order.setState(state);
						order.setRefuse_reason(refuse_reason);
						storeOrderService.updateOrder(order);
						result.put("code", 1);
						}else{
							if(order.getIs_out()==1){
								order.setState(state);
								storeOrderService.updateOrder(order);
								storeOrderService.sendOrderDetailPrint(order_id);
								storeOrderService.sendOrderDetailSingelPrint(order_id);
								result.put("code", 1);
							}else{
								List<OrderDetail> menu_list = order.getMenu_list();
								boolean canrecive = false;
								for(OrderDetail detail:menu_list){
									if(detail.getDetail_flg()>=0){
									if(detail.getIs_weigh()==1){
										if(detail.getWeight()==0f){
											canrecive = true;
											break;
										}
									}
									}
								}
								if(canrecive){
									result.put("code", 500);
									result.put("message", "存在未称重的菜品，请在称重后确认订单!");
								}else{
									if(table_id==null){
										result.put("code", 500);
										result.put("message", "请选择堂食桌台!");
									}else{
										StoreTable storetable = storeTableService.getStoreTableById(table_id);
										if(storetable==null){
											result.put("code", 500);
											result.put("message", "桌台信息错误，确认失败!");
										}else{
											if(storetable.getState()==1){
												storetable.setCorrent_order(order.getOrder_id());
												storetable.setState(2);
												storeTableService.updateStoreTable(storetable);
												order.setState(state);
												order.setTable_id(table_id);
												storeOrderService.updateOrder(order);
												storeOrderService.sendOrderDetailPrint(order_id);
												storeOrderService.sendOrderDetailSingelPrint(order_id);
												result.put("code", 1);
											}else{
												result.put("code", 500);
												result.put("message", "桌台状态错误，请重新选择!");
											}
										}
									}
								}
							}
						}
					}
				}else{
					result.put("code", 500);
					result.put("message", "订单状态错误，操作失败!");
				}
			}else{
				result.put("code", 500);
				result.put("message", "订单数据错误，操作失败!");
			}
		}
		CommonUtils.setMaptoJson(response, result);
	}
	
}
