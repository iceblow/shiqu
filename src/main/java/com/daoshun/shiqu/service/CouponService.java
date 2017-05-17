package com.daoshun.shiqu.service;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.daoshun.shiqu.common.QueryResult;
import com.daoshun.shiqu.pojo.Coupon;
import com.daoshun.shiqu.pojo.MyCoupon;
import com.daoshun.shiqu.pojo.RechargeCard;
import com.daoshun.shiqu.pojo.RechargeRecord;
import com.daoshun.shiqu.pojo.UserInfo;

@Service("couponService")
@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
public class CouponService extends BaseService{

	@SuppressWarnings("unchecked")
	public QueryResult<Coupon> getCouponListByPage(long store_id, Integer pageIndex, int pageSize) {
		String hql = " from Coupon where store_id = :store_id order by from_time desc";
		String[] params = new String[]{"store_id"};
		List<Coupon> list = (List<Coupon>) dataDao.pageQueryViaParam(hql, pageSize, pageIndex, params, store_id);
		if(list != null && list.size() > 0){
			for (Coupon coupon : list) {
				String MyCouponhql = "select count(*) from MyCoupon where coupon.coupon_id = :coupon_id and is_used = 1";
				long usecount = (long) dataDao.getFirstObjectViaParam(MyCouponhql, new String[]{"coupon_id"}, coupon.getCoupon_id());
				coupon.setUsecount((int)usecount);
			}
		}
		String counthql = " select count(*) "+hql;
		long count = (long) dataDao.getFirstObjectViaParam(counthql, params, store_id);
		QueryResult<Coupon> result = new QueryResult<Coupon>(list, count);
		return result;
	}

	public Coupon getCouponById(Long coupon_id) {
		Coupon info = dataDao.getObjectById(Coupon.class, coupon_id);
		return info;
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void updateCoupon(Coupon coupon) {
		dataDao.updateObject(coupon);
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void addCoupon(Coupon coupon) {
		dataDao.addObject(coupon);
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void addMyCoupon(MyCoupon mycoupon) {
		dataDao.addObject(mycoupon);
	}

	@SuppressWarnings("unchecked")
	public QueryResult<RechargeCard> getRechargeCardListByPage(long store_id, Integer pageIndex, int pageSize) {
		String hql = "from RechargeCard where store.store_id = :store_id";
		String[] params = new String[]{"store_id"};
		List<RechargeCard> list = (List<RechargeCard>) dataDao.pageQueryViaParam(hql, pageSize, pageIndex, params, store_id);
		if(list != null && list.size() > 0){
			for (RechargeCard rechargeCard : list) {
				if(rechargeCard.getUser_id() != 0){
					UserInfo userinfo = dataDao.getObjectById(UserInfo.class, rechargeCard.getUser_id());
					if(userinfo != null){
						rechargeCard.setUserinfo(userinfo);
					}
				}
			}
		}
		String counthql = " select count(*) "+hql;
		long total = (long) dataDao.getFirstObjectViaParam(counthql, params, store_id);
		QueryResult<RechargeCard> result = new QueryResult<RechargeCard>(list, total);
		return result;
	}

	public RechargeCard getRechargeCard(long id) {
		RechargeCard info = dataDao.getObjectById(RechargeCard.class, id);
		if(info != null){
			if(info.getUser_id() != 0){
				UserInfo userinfo = dataDao.getObjectById(UserInfo.class, info.getUser_id());
				if(userinfo != null){
					info.setUserinfo(userinfo);
				}
			}
		}
		return info;
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void addRechargeCard(RechargeCard card) {
		dataDao.addObject(card);
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void addRechargeRecord(RechargeRecord record) {
		dataDao.addObject(record);
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void updateRechargeCard(RechargeCard card) {
		dataDao.updateObject(card);
	}

	@SuppressWarnings("unchecked")
	public List<Coupon> getCouponList(long store_id) {
		String hql = " from Coupon where store_id = :store_id and is_valid = 1";
		String[] params = new String[]{"store_id"};
		List<Coupon> list = (List<Coupon>) dataDao.getObjectsViaParam(hql, params, store_id);
		return list;
	}

	public MyCoupon getMyCouponByCU(long user_id, long coupon_id) {
		String hql = " from MyCoupon where is_used = 0 and user_id = :user_id and coupon.coupon_id = :coupon_id";
		String[] params = new String[]{"user_id","coupon_id"};
		MyCoupon info = (MyCoupon) dataDao.getFirstObjectViaParam(hql, params, user_id, coupon_id);
		return info;
	}

	public MyCoupon getMyCouponByCouponno(String coupon_no){
		MyCoupon mycoupon = (MyCoupon) dataDao.getFirstObjectViaParam(" from MyCoupon where coupon_no = :coupon_no ", new String[]{"coupon_no"}, coupon_no);
		return mycoupon;
	}
	
	public MyCoupon getMyCouponById(long coupon_id){
		MyCoupon mycoupon = dataDao.getObjectById(MyCoupon.class, coupon_id);
		return mycoupon;
	}
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void updateMyCoupon(MyCoupon mycoupon){
		dataDao.updateObject(mycoupon);
	}
	
	public RechargeCard getRechargeCradByCardno(long store_id,String cardno){
		String hql = " from RechargeCard where store.store_id = :store_id and card_no =:cardno ";
		RechargeCard rechargecard = (RechargeCard) dataDao.getFirstObjectViaParam(hql, new String[]{"store_id","cardno"}, store_id,cardno);
		return rechargecard;
	}
	
}
