package com.daoshun.shiqu.service.wap;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.daoshun.exception.CustomException;
import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.common.Constants;
import com.daoshun.shiqu.netdata.StoreInfo;
import com.daoshun.shiqu.pojo.AreaInfo;
import com.daoshun.shiqu.pojo.Collection;
import com.daoshun.shiqu.pojo.Coupon;
import com.daoshun.shiqu.pojo.DeliveryAddress;
import com.daoshun.shiqu.pojo.Menu;
import com.daoshun.shiqu.pojo.MenuCategory;
import com.daoshun.shiqu.pojo.MyCoupon;
import com.daoshun.shiqu.pojo.Order;
import com.daoshun.shiqu.pojo.OrderDetail;
import com.daoshun.shiqu.pojo.Store;
import com.daoshun.shiqu.pojo.StoreCategory;
import com.daoshun.shiqu.pojo.StorePic;
import com.daoshun.shiqu.pojo.UserInfo;
import com.daoshun.shiqu.service.BaseService;

@Service("wapStoreService")
@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
public class WapStoreService extends BaseService{

	public HashMap<String, Object> getStoreList(String location, String keywords, Long category_id, Integer sort, int page_size, int page, String area) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		StringBuffer sql = new StringBuffer("select s.store_id, s.store_name, s.category_name, s.is_out, s.min_send, s.sales_num, s.pic, ");
		sql.append(" getdistance( s.longitude, s.latitude, " + location + ") as distance, ");
		sql.append(" convert(timestampdiff(day, s.create_time, now()) < 30, unsigned ) as is_new, ");
		sql.append(" (select count(c.coupon_id) from t_coupon c where c.store_id =s.store_id) as has_coupon ");
		sql.append(" from t_stroe s where del_flg = 0 ");
		String countSql = "select  count(store_id) from Store where del_flg = 0  ";
		if (!CommonUtils.isEmptyString(keywords)) {
			sql.append(" and store_name like '%" + keywords + "%' ");
			countSql = countSql + " and store_name like '%" + keywords + "%' ";
		}
		if (!CommonUtils.isEmptyString(area)) {
			sql.append(" and area like '%" + area + "%' ");
			countSql = countSql + " and area like '%" + area + "%' ";
		}
		if (category_id != null && category_id != 0) {
			sql.append(" and category_id = " + category_id);
			countSql = countSql + " and category_id = " + category_id;
			// sql.append(" and store_id in (select distinct store_id from t_store_category_relation where category_id = " + category_id + ")");
			// countSql = countSql + " and store_id in (select distinct store_id from t_store_category_relation where category_id = " + category_id + ")";
		}
		if(sort!=null){
			switch (sort) {
			// 综合排序（距离）
			case 1:
				sql.append(" order by getdistance( longitude, latitude, " + location + ") asc ");
				break;
			// 热度排序（销量）
			case 2:
				sql.append(" order by sales_num desc");
				break;
			default:
				break;
			}
		}
		sql.append(" limit " + page_size + " offset " + (page - 1) * page_size);
		List<Object[]> stores = dataDao.executeSql(sql.toString());
		List<StoreInfo> storeInfos = new ArrayList<StoreInfo>();
		for (Object[] objects : stores) {
			String picurl = getFilePathById(((java.math.BigInteger) objects[6]).longValue());
			// List<String> categoryList = (List<String>) dataDao.getObjectsViaParam("from StoreCategory where store_id = " + String.valueOf(objects[0]), null);
			storeInfos.add(new StoreInfo(objects, picurl));
		}
		result.put("store_list", storeInfos);
		if (storeInfos.size() < 10) {
			result.put("total", storeInfos.size());
		} else {
			result.put("total", dataDao.getCount(countSql));
		}
		return result;
	}
	
	
	@SuppressWarnings("unchecked")
	public List<StoreCategory> getStoreCategory(){
		List<StoreCategory> categorylist = (List<StoreCategory>) dataDao.getObjectsViaParam(" from StoreCategory ", null);
		for(StoreCategory category:categorylist){
			category.setPic_url(getFilePathById(category.getPic_id()));
		}
		return categorylist;
	}
	
	/**
	 * 获取菜单信息
	 */
	@SuppressWarnings("unchecked")
	public List<MenuCategory> getStoreMenu(long sid) {
		List<MenuCategory> menuCategories = (List<MenuCategory>) dataDao.getObjectsViaParam("from MenuCategory where delflg = 0 and  store_id = " + sid, null);
		for (MenuCategory menuCategory : menuCategories) {
			List<Menu> menulist = (List<Menu>) dataDao.getObjectsViaParam("from Menu where delflag = 0 and sell_out = 0 and store_id = " + sid + " and category  = '" + menuCategory.getName()
			+ "'", null);
			for(Menu menu:menulist){
				menu.setPic_url(getFilePathById(menu.getPic()));
			}
			menuCategory.setMenu_list(menulist);
		}
		return menuCategories;
	}
	
	@SuppressWarnings("unchecked")
	public Store getStoreById(long store_id,long user_id){
		Store store = dataDao.getObjectById(Store.class, store_id);
		if(store!=null){
			store.setPic_url(getFilePathById(store.getPic()));
			List<StorePic> storepiclist = (List<StorePic>) dataDao.getObjectsViaParam(" from StorePic where store_id = :store_id", new String[]{"store_id"}, store_id);
			for(StorePic storepic:storepiclist){
				storepic.setImg_url(getFilePathById(storepic.getPic_id()));
			}
			store.setStorepic_list(storepiclist);
			if(user_id>0){
				Collection usercollect = (Collection) dataDao.getFirstObjectViaParam(" from Collection where type = 1 and user_id = :user_id and collection_id = :collection_id",
								new String[]{"user_id","collection_id"},user_id,store_id );
				if(usercollect!=null){
					store.setIs_collect(1);
				}
			}
		}
		return store;
	}
	
	@SuppressWarnings("unchecked")
	public List<Coupon> getStoreCoupon(long store_id,long user_id){
		String hql = "from Coupon where is_valid = 1 and  store_id = " + store_id + " and now() between from_time and end_time ";
		List<Coupon> coupons = (List<Coupon>) dataDao.getObjectsViaParam(hql, null);
		if (user_id > 0) {
			for (Coupon coupon : coupons) {
				if (dataDao.getCount("select count(id) from MyCoupon where is_used = 0 and user_id = " + user_id + " and coupon_id = " + coupon.getCoupon_id()) > 0) {
					coupon.setIs_geted(1);
				}
			}
		}
		return coupons;
	}
	
	public Menu getMenuById(long menu_id){
		return dataDao.getObjectById(Menu.class, menu_id);
	}

	public DeliveryAddress getUserDefultAddress(long user_id){
		String hql = " from DeliveryAddress where is_default = 1 and user_id = :user_id ";
		DeliveryAddress deliveryaddress = (DeliveryAddress) dataDao.getFirstObjectViaParam(hql,new String[]{"user_id"}, user_id);
		return deliveryaddress;
	}
	
	public DeliveryAddress getAddressById(long addressid){
		return dataDao.getObjectById(DeliveryAddress.class, addressid);
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void addOrder(Integer peoplenum,String order_name,String phone,String send_time,String address,String comment,int is_out, long store_id,
			Long[] menuids, Integer[] quantitys,float allprice, long wapuserid) throws CustomException {
		if (wapuserid <= 0) {
			throw new CustomException(Constants.USER_ERR_EXCEPTION);
		}
		if (store_id <= 0) {
			throw new CustomException(Constants.STORE_ERR_EXCEPTION);
		}
		UserInfo user = dataDao.getObjectById(UserInfo.class, wapuserid);
		if(user==null){
			throw new CustomException(Constants.USER_ERR_EXCEPTION);
		}
		Store store = dataDao.getObjectById(Store.class, store_id);
		Order order = new Order();
		order.setUser_id(wapuserid);
		order.setStore_id(store_id);
		if(CommonUtils.isEmptyString(order_name)){
			order.setOrder_name(user.getUser_name());
		}else{
			order.setOrder_name(order_name);
		}
		order.setOrder_time(new Date());
		if(CommonUtils.isEmptyString(phone)){
			order.setPhone(user.getPhone());
		}else{
			order.setPhone(phone);
		}
		if(peoplenum==null){
			peoplenum = 0;
		}
		order.setPeople_num(peoplenum);
		order.setState(1);
		order.setIs_out(is_out);
		if(is_out == 1){
			if (CommonUtils.isEmptyString(send_time)) {
				int minute = (int) dataDao.getFirstObjectViaParam("select send_time from Store where store_id = " + store_id, null);
				Calendar c = Calendar.getInstance();
				c.add(Calendar.MINUTE, minute);
				order.setSend_time(CommonUtils.getTimeFormat(c.getTime(), "yyyy-MM-dd HH:mm"));
			} else {
				order.setSend_time(CommonUtils.getTimeFormat(new Date(), "yyyy-MM-dd ") + send_time);
			}
			order.setSend_money(store.getSend_money());
			order.setAddress(address);
		}
		order.setTable_id(0);
		order.setPay_type(0);
		order.setComment(comment);
		order.setCoupon_id(0l);
		order.setPrice(allprice);
		order.setTotal_price(allprice);
		order.setIs_shop_order(0);
		dataDao.addObject(order);
		float price = 0f;
		for(int i= 0;i<menuids.length;i++){
			Menu menu = dataDao.getObjectById(Menu.class, menuids[i]);
			int num = quantitys[i];
			OrderDetail orderdetail = new OrderDetail();
			orderdetail.setOrder_id(order.getOrder_id());
			orderdetail.setMenu_id(menu.getMenu_id());
			orderdetail.setMenu_name(menu.getMenu_name());
			orderdetail.setPrice(menu.getPrice());
			orderdetail.setUnit(menu.getUnit());
			orderdetail.setCan_discount(menu.getCan_discount());
			orderdetail.setIs_weigh(menu.getIs_weigh());
			orderdetail.setQuantity(num);
			orderdetail.setUnit(menu.getUnit());
			orderdetail.setKitunit(menu.getKitunit());
			orderdetail.setDetail_flg(0);
			if(menu.getIs_weigh()==1){
				orderdetail.setWeight(1);
				
			}
			orderdetail.setIs_free(0);
			dataDao.addObject(orderdetail);
			price += orderdetail.getPrice()*orderdetail.getQuantity();
		}
		order.setPrice(price);
		if(is_out == 1){
			order.setTotal_price(price+order.getSend_money());
		}else{
			order.setTotal_price(price);
		}
		dataDao.updateObject(order);
	}
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public int collectStore(long store_id, long user_id) {
		Collection collection = (Collection) dataDao.getFirstObjectViaParam("from Collection where user_id = " + user_id + " and collection_id = " + store_id + " and type = 1", null);
		if (collection == null) {
			collection = new Collection();
			collection.setCollect_time(new Date());
			collection.setCollection_id(store_id);
			collection.setType(1);
			collection.setUser_id(user_id);
			dataDao.addObject(collection);
			return 0 ;
		} else {
			dataDao.deleteObject(collection);
			return 1 ;
		}
	}
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void getCoupon(long coupon_id, long user_id) {
		MyCoupon myCoupon = new MyCoupon();
		myCoupon.setCoupon(dataDao.getObjectById(Coupon.class, coupon_id));
		myCoupon.setUser_id(user_id);
		myCoupon.setCoupon_no(CommonUtils.makeRandomNo());
		dataDao.addObject(myCoupon);
	}
	
	public UserInfo getUserInfoByWxOpenId(String openid){
		String hql =" from UserInfo where weixin_openid = :openid ";
		UserInfo user = (UserInfo) dataDao.getFirstObjectViaParam(hql, new String[]{"openid"}, openid);
		return user;
	}
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void addUserInfo(UserInfo user){
		dataDao.addObject(user);
	}
	
	public List<AreaInfo> getAreaInfoByParentname(String area){
		AreaInfo parentarea = (AreaInfo) dataDao.getFirstObjectViaParam(" from AreaInfo where name like'%"+area+"%' ", null );
		if(parentarea!=null){
			String hql = " from AreaInfo where parent_id = :parent_id ";
			List<AreaInfo> arealist = (List<AreaInfo>) dataDao.getObjectsViaParam(hql, new String[]{"parent_id"},parentarea.getId());
			return arealist;
		}
		return null;
	}
}
