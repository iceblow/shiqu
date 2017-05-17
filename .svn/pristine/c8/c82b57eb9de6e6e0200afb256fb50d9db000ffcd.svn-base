package com.daoshun.shiqu.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.daoshun.shiqu.pojo.ChargeStatistics;
import com.daoshun.shiqu.pojo.Menu;
import com.daoshun.shiqu.pojo.MenuStatistics;
import com.daoshun.shiqu.pojo.SaleStatistics;

/**
 * @author wangcl
 * 
 */
@Service("accountService")
@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
public class AccountService extends BaseService{

	@SuppressWarnings("unchecked")
	public List<SaleStatistics> getSaleList(int type,long store_id){
		if(type==1){
			Calendar c  = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.DATE, -6);
			Date starttime = c.getTime();
			String hql = " from SaleStatistics where type = 1 and start_time >= date(:start_time) and start_time <= date(:end_time) and store_id = :store_id order by start_time";
			String[] params = {"start_time","end_time","store_id"};
			List<SaleStatistics> salelist = (List<SaleStatistics>) dataDao.getObjectsViaParam(hql , params , starttime , new Date() , store_id );
			return salelist;
		}
		if(type==3){
			Calendar c  = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.MONTH, -6);
			String hql = " from SaleStatistics where type = 3 and start_time =  date(:start_time)  and end_time = date(:end_time) and store_id = :store_id order by start_time";
			String[] params = {"start_time","end_time","store_id"};
			List<SaleStatistics> salelist = new ArrayList<SaleStatistics>();
			for(int i=0;i<7;i++){
				c.add(Calendar.MONTH, i);
				c.set(Calendar.DAY_OF_MONTH,1);
				Date starttime = c.getTime();
				c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
				Date endtime = c.getTime();
				SaleStatistics saleStatistics = (SaleStatistics) dataDao.getFirstObjectViaParam(hql, params, starttime,endtime,store_id);
				if(saleStatistics!=null){
					salelist.add(saleStatistics);
				}
			}
			return salelist;
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<ChargeStatistics> getChargeList(int type,long store_id){
		if(type==1){
			Calendar c  = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.DATE, -6);
			Date starttime = c.getTime();
			String hql = " from ChargeStatistics where type = 1 and start_time >= date(:start_time) and start_time <= date(:end_time) and store_id = :store_id order by start_time";
			String[] params = {"start_time","end_time","store_id"};
			List<ChargeStatistics> chargelist = (List<ChargeStatistics>) dataDao.getObjectsViaParam(hql , params , starttime , new Date() , store_id );
			return chargelist;
		}
		if(type==3){
			Calendar c  = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.MONTH, -6);
			String hql = " from ChargeStatistics where type = 3 and start_time =  date(:start_time)  and end_time = date(:end_time) and store_id = :store_id order by start_time";
			String[] params = {"start_time","end_time","store_id"};
			List<ChargeStatistics> chargelist = new ArrayList<ChargeStatistics>();
			for(int i=0;i<7;i++){
				c.add(Calendar.MONTH, i);
				c.set(Calendar.DAY_OF_MONTH,1);
				Date starttime = c.getTime();
				c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
				Date endtime = c.getTime();
				ChargeStatistics chargeStatistics = (ChargeStatistics) dataDao.getFirstObjectViaParam(hql, params, starttime,endtime,store_id);
				if(chargeStatistics!=null){
					chargelist.add(chargeStatistics);
				}
			}
			return chargelist;
		}
		return null;
		
	}

	
	@SuppressWarnings("unchecked")
	public List<MenuStatistics> getMenuList(int type,long store_id){
		if(type==1){
			String hql = " from MenuStatistics where type = 1 and start_time = date(:start_time) and end_time = date(:end_time) and store_id = :store_id order by start_time";
			String[] params = {"start_time","end_time","store_id"};
			List<MenuStatistics> menulist = (List<MenuStatistics>) dataDao.getObjectsViaParam(hql , params , new Date() , new Date() , store_id );
			for(MenuStatistics menu:menulist){
				Menu storemenu = dataDao.getObjectById(Menu.class, menu.getMenu_id());
				if(storemenu!=null){
					menu.setMenu_name(storemenu.getMenu_name());
				}
			}
			return menulist;
		}
		if(type==3){
			String hql = " from MenuStatistics where type = 3 and start_time =  date(:start_time)  and end_time = date(:end_time) and store_id = :store_id order by start_time";
			String[] params = {"start_time","end_time","store_id"};
			Calendar c  = Calendar.getInstance();
			c.setTime(new Date());
			c.set(Calendar.DAY_OF_MONTH,1);
			Date starttime = c.getTime();
			c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
			Date endtime = c.getTime();
			List<MenuStatistics> menulist = (List<MenuStatistics>) dataDao.getObjectsViaParam(hql, params, starttime,endtime,store_id);
			for(MenuStatistics menu:menulist){
				Menu storemenu = dataDao.getObjectById(Menu.class, menu.getMenu_id());
				if(storemenu!=null){
					menu.setMenu_name(storemenu.getMenu_name());
				}
			}
			return menulist;
		}
		return null;
		
	}
	
	public long getMenuCount(int type,long store_id){
		if(type==1){
			String hql = "select sum(total_sell) from MenuStatistics where type = 1 and start_time = date(:start_time) and end_time = date(:end_time) and store_id = :store_id order by start_time";
			String[] params = {"start_time","end_time","store_id"};
			Long menucount = (Long) dataDao.getFirstObjectViaParam(hql , params , new Date() , new Date() , store_id );
			if(menucount==null)
				menucount = 0l;
			return menucount;
		}
		if(type==3){
			String hql = "select sum(total_sell) from MenuStatistics where type = 3 and start_time =  date(:start_time)  and end_time = date(:end_time) and store_id = :store_id order by start_time";
			String[] params = {"start_time","end_time","store_id"};
			Calendar c  = Calendar.getInstance();
			c.setTime(new Date());
			c.set(Calendar.DAY_OF_MONTH,1);
			Date starttime = c.getTime();
			c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
			Date endtime = c.getTime();
			Long menucount = (Long) dataDao.getFirstObjectViaParam(hql, params, starttime, endtime , store_id);
			if(menucount==null)
				menucount = 0l;
			return menucount;
		}
		return 0;
	}
}
