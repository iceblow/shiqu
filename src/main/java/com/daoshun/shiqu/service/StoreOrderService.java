package com.daoshun.shiqu.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.common.QueryResult;
import com.daoshun.shiqu.pojo.Order;
import com.daoshun.shiqu.pojo.OrderDetail;
import com.daoshun.shiqu.pojo.StoreArea;
import com.daoshun.shiqu.pojo.StoreTable;

/**
 * @author qiuch
 * 
 */
@Service("storeOrderService")
@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
public class StoreOrderService extends BaseService{

	public QueryResult<Order> getOrderListByStoreId(long store_id,Integer is_out,Integer state,String order_time,String keyword,int pageIndex,int pageSize){
		StringBuffer orderhql = new StringBuffer();
		orderhql.append(" from Order where store_id = "+store_id);
		if(is_out!=null){
			orderhql.append( " and is_out = " +is_out);
		}
		if(state!=null){
			orderhql.append(" and state = "+state );
//			if(state==0){
//				orderhql.append( " and ( state = 1  or  state = 2 )");
//			}else if(state==1){
//				orderhql.append( " and ( state = 3  or  state = 4 or  state = 5 )");
//			}
		}
		if(!CommonUtils.isEmptyString(order_time)){
			orderhql.append( " and date(order_time) = '"+order_time+"' ");
		}
		if(!CommonUtils.isEmptyString(keyword)){
			orderhql.append(" and order_name like '%"+keyword+"%'" );
		}
		List<Order> orderlist = (List<Order>) dataDao.pageQueryViaParam(orderhql.toString()+" order by order_time desc",pageSize,pageIndex, null);
		for(Order order:orderlist){
			if(order.getTable_id()>0){
				StoreTable table = dataDao.getObjectById(StoreTable.class, order.getTable_id());
				StoreArea area = dataDao.getObjectById(StoreArea.class, table.getArea_id());
				order.setTable_no(area.getArea_name()+table.getTable_no());
			}
			List<OrderDetail> orderdetails = order.getMenu_list();
			List<OrderDetail> neworderdetail = new ArrayList<OrderDetail>();
			for(OrderDetail detail:orderdetails){
				if(detail.getDetail_flg()>=0){
					neworderdetail.add(detail);
				}
			}
			order.setMenu_list(neworderdetail);
		}
		long count = (long) dataDao.getFirstObjectViaParam("select count(*) "+orderhql.toString(), null);
		QueryResult<Order> result = new QueryResult<Order>(orderlist,(int)count);
		return result;
	}
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void updateOrder(Order order){
		dataDao.updateObject(order);
	}
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void updateOrderDetail(OrderDetail orderdetail){
		dataDao.updateObject(orderdetail);
	}
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void delOrderDetail(OrderDetail orderdetail){
		dataDao.deleteObject(orderdetail);
	}
}
