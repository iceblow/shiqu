package com.daoshun.shiqu.service.wap;

import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.daoshun.exception.CustomException;
import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.common.Constants;
import com.daoshun.shiqu.common.QueryResult;
import com.daoshun.shiqu.pojo.Coupon;
import com.daoshun.shiqu.pojo.MyCoupon;
import com.daoshun.shiqu.pojo.Order;
import com.daoshun.shiqu.pojo.RechargeCard;
import com.daoshun.shiqu.pojo.RechargeRecord;
import com.daoshun.shiqu.pojo.Store;
import com.daoshun.shiqu.pojo.StoreArea;
import com.daoshun.shiqu.pojo.StoreTable;
import com.daoshun.shiqu.service.BaseService;

@Service("wapOrderService")
@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
public class WapOrderService  extends BaseService{

	@SuppressWarnings("unchecked")
	public QueryResult<Order> getPresentOrderListBypage(long user_id, Integer pageIndex, int pageSize) {
		SimpleDateFormat time=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		String hql = " from Order where user_id = :user_id and (state = 1 or state = 2) order by order_time desc";
		List<Order> list = (List<Order>) dataDao.pageQueryViaParam(hql, pageSize, pageIndex, new String[]{"user_id"}, user_id);
		if(list != null && list.size() > 0){
			for (Order order : list) {
				if(order.getStore_id() != 0){
					Store store = dataDao.getObjectById(Store.class, order.getStore_id());
					if(store != null){
						order.setStore(store);
					}
				}
				if(order.getCheck_time() != null){
					order.setStr_Check_time(time.format(order.getCheck_time()));
				}
				if(order.getOrder_time() != null){
					order.setStr_Order_time(time.format(order.getOrder_time()));
				}
			}
		}
		String counthql = "select count(*) "+hql;
		long total = (long) dataDao.getFirstObjectViaParam(counthql, new String[]{"user_id"}, user_id);
		QueryResult<Order> result = new QueryResult<Order>(list, total);
		return result;
	}

	@SuppressWarnings("unchecked")
	public QueryResult<Order> getIsOutOrderListBypage(long user_id, Integer pageIndex, int is_out, int pageSize) {
		SimpleDateFormat time=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		String hql = " from Order where user_id = :user_id and is_out = :is_out and (state = 3 or state = 4 or state = 5) order by order_time desc";
		List<Order> list = (List<Order>) dataDao.pageQueryViaParam(hql, pageSize, pageIndex, new String[]{"user_id","is_out"}, user_id, is_out);
		if(list != null && list.size() > 0){
			for (Order order : list) {
				if(order.getStore_id() != 0){
					Store store = dataDao.getObjectById(Store.class, order.getStore_id());
					if(store != null){
						order.setStore(store);
					}
				}
				if(order.getCheck_time() != null){
					order.setStr_Check_time(time.format(order.getCheck_time()));
				}
				if(order.getOrder_time() != null){
					order.setStr_Order_time(time.format(order.getOrder_time()));
				}
			}
		}
		String counthql = "select count(*) "+hql;
		long total = (long) dataDao.getFirstObjectViaParam(counthql, new String[]{"user_id","is_out"}, user_id, is_out);
		QueryResult<Order> result = new QueryResult<Order>(list, total);
		return result;
	}

	public Order getOrderDetail(Long order_id) {
		Order order = dataDao.getObjectById(Order.class, order_id);
		if (order != null) {
			order.setStore(dataDao.getObjectById(Store.class, order.getStore_id()));
			if (order.getTable_id() != 0) {
				StoreTable table = dataDao.getObjectById(StoreTable.class, order.getTable_id());
				StoreArea area = dataDao.getObjectById(StoreArea.class, table.getArea_id());
				order.setTable_no(area.getArea_name()+table.getTable_no()+"/"+table.getNum()+"人座");
			}
		}
		return order;
	}

	public long getMyCouponUsedCount(long user_id, float total_price, long store_id) {
		String hql = " select count(*) from MyCoupon where is_used = 0 and now() between coupon.from_time and coupon.end_time and coupon.is_valid = 1 and min_money <= :total and user_id = :uid and coupon.store_id = :sid order by coupon.amount desc";
		long count = (long) dataDao.getFirstObjectViaParam(hql, new String[] { "total", "uid", "sid" }, total_price, user_id, store_id);
		return count;
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void cancelOrder(Long order_id) throws CustomException{
		Order order = dataDao.getObjectById(Order.class, order_id);
		if (order == null) {
			throw new CustomException(Constants.ORDER_ERR_EXCEPTION);
		}
		if (order.getState() != 1) {
			throw new CustomException(Constants.ORDER_CANCEL_EXCEPTION);
		}
		if (order.getTable_id() != 0) {
			// 看看要不要更新桌台信息
		}
		order.setState(5);
		dataDao.updateObject(order);
		
	}

	@SuppressWarnings("unchecked")
	public List<MyCoupon> getMyCouponList(long user_id, float total_price, long store_id) {
		String hql = "from MyCoupon where is_used = 0 and now() between coupon.from_time and coupon.end_time and coupon.is_valid = 1 and min_money <= :total and user_id = :uid and coupon.store_id = :sid order by coupon.amount desc";
		List<MyCoupon> coupons = (List<MyCoupon>) dataDao.getObjectsViaParam(hql, new String[] { "total", "uid", "sid" }, total_price, user_id, store_id);
		for (MyCoupon myCoupon : coupons) {
			myCoupon.setStore_name(String.valueOf(dataDao.getFirstObjectViaParam("select store_name from Store where store_id = " + store_id, null)));
		}
		return coupons;
	}

	public Coupon getCouponById(Long coupon_id) {
		Coupon coupon = dataDao.getObjectById(Coupon.class, coupon_id);
		return coupon;
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void updateOrder(Order order) {
		dataDao.updateObject(order);
	}

	public RechargeCard getRechargeCard(long user_id, long store_id) {
		String hql = " from RechargeCard where user_id = :user_id and store.store_id = :store_id";
		RechargeCard info = (RechargeCard) dataDao.getFirstObjectViaParam(hql, new String[]{"user_id","store_id"}, user_id, store_id);
		return info;
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void updateCoupon(Coupon coupon) {
		dataDao.updateObject(coupon);
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void updateRechargeCard(RechargeCard card) {
		dataDao.updateObject(card);
	}

	public MyCoupon getCouponByCouponId(Long coupon_id, Long user_id) {
		String hql = " from MyCoupon where user_id = :user_id and coupon_id = :coupon_id";
		MyCoupon info = (MyCoupon) dataDao.getFirstObjectViaParam(hql, new String[]{"user_id","coupon_id"}, user_id, coupon_id);
		return info;
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void updateMyCoupon(MyCoupon coupon) {
		dataDao.updateObject(coupon);
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void addRechargeRecord(RechargeRecord record) {
		dataDao.addObject(record);
	}

	public MyCoupon getMyCouponById(Long mycoupon_id) {
		MyCoupon info = dataDao.getObjectById(MyCoupon.class, mycoupon_id);
		return info;
	}

}
