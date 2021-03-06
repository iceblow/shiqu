package com.daoshun.shiqu.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.common.QueryResult;
import com.daoshun.shiqu.pojo.Menu;
import com.daoshun.shiqu.pojo.Order;
import com.daoshun.shiqu.pojo.OrderDetail;
import com.daoshun.shiqu.pojo.PrintInfo;
import com.daoshun.shiqu.pojo.StoreArea;
import com.daoshun.shiqu.pojo.StoreTable;

@Service("storeTableService")
@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
public class StoreTableService extends BaseService{

	@SuppressWarnings("unchecked")
	public QueryResult<StoreArea> getStoreAreaList(long store_id,int pageIndex,int pageSize){
			StringBuffer areahql = new StringBuffer();
			areahql.append(" from StoreArea where store_id = :store_id ");
			List<StoreArea> arealist = (List<StoreArea>) dataDao.pageQueryViaParam(areahql.toString(), pageSize, pageIndex, new String[]{"store_id"}, store_id);
			for(StoreArea area:arealist){
				long print_id1 =area.getPrint_id1();
				if(print_id1>0){
					PrintInfo print1 = dataDao.getObjectById(PrintInfo.class, print_id1);
					if(print1!=null){
						area.setPrint_name1(print1.getPrint_name());
					}
				}
				long print_id2 =area.getPrint_id2();
				if(print_id2>0){
					PrintInfo print2 = dataDao.getObjectById(PrintInfo.class, print_id2);
					if(print2!=null){
						area.setPrint_name2(print2.getPrint_name());
					}
				}
				long print_id3 =area.getPrint_id3();
				if(print_id3>0){
					PrintInfo print3 = dataDao.getObjectById(PrintInfo.class, print_id3);
					if(print3!=null){
						area.setPrint_name3(print3.getPrint_name());
					}
				}
			}
			long count = (long) dataDao.getFirstObjectViaParam("select count(*) "+ areahql.toString(), new String[]{"store_id"}, store_id);
			QueryResult<StoreArea> result = new QueryResult<StoreArea>(arealist,count);
			return result;
	}
	 
	public StoreArea getStoreAreaById(long id){
		return dataDao.getObjectById(StoreArea.class, id);
	}
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void saveStoreArea(StoreArea storearea){
		dataDao.saveOrUpdateObject(storearea);
	}
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void delStoreArea(Long[] ids,long store_id){
		String hql  = " from StoreArea where id = :id and store_id = :store_id";
		String[] params = {"id","store_id"};
		for(Long id:ids){
			if(id!=null&&id>0){
				StoreArea storearea = (StoreArea) dataDao.getFirstObjectViaParam(hql, params, id,store_id);
				if(storearea!=null){
					dataDao.deleteObject(storearea);
				}
			}
		}
	}
	
	public List<StoreTable> getStoreTableListByIDS(Long[] ids,long store_id){
		List<StoreTable> tablelist = new ArrayList<StoreTable>();
		String hql = "from StoreTable where id = :id and store_id = :store_id and del_flg = 0 ";
		String[] params = {"id","store_id"};
		for(Long id:ids){
			if(id!=null&&id>0){
				StoreTable storetable = (StoreTable) dataDao.getFirstObjectViaParam(hql, params, id,store_id);
				if(storetable!=null){
					StoreArea storearea = dataDao.getObjectById(StoreArea.class, storetable.getArea_id());
					if(storearea!=null){
						storetable.setArea_name(storearea.getArea_name());
					}
					tablelist.add(storetable);
				}
			}
		}
		return tablelist;
	}
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void delStoreTable(Long[] ids,long store_id){
		String hql  = " from StoreTable where id = :id and store_id = :store_id";
		String[] params = {"id","store_id"};
		for(Long id:ids){
			if(id!=null&&id>0){
				StoreTable storetable = (StoreTable) dataDao.getFirstObjectViaParam(hql, params, id,store_id);
				if(storetable!=null){
					storetable.setDel_flg(1);
					dataDao.updateObject(storetable);
//					dataDao.deleteObject(storetable);
				}
			}
		}
	}
	
	@SuppressWarnings("unchecked")
	public QueryResult<StoreTable> getTableListByStoreid(Integer area_id,String keyword,long store_id,int pageIndex,int pageSize){
		StringBuffer tablehql = new StringBuffer();
		tablehql.append(" from StoreTable where store_id = "+store_id +" and del_flg = 0 ");
		if(area_id!=null&&area_id>0){
			tablehql.append(" and area_id = "+area_id);
		}
		if(!CommonUtils.isEmptyString(keyword)){
			tablehql.append(" and table_no like '%"+keyword+"%' ");
		}
		List<StoreTable> tablelist = (List<StoreTable>) dataDao.pageQueryViaParam(tablehql.toString(), pageSize, pageIndex, null);
		for(StoreTable table:tablelist){
			if(table.getArea_id()>0){
				StoreArea area = dataDao.getObjectById(StoreArea.class, table.getArea_id());
				table.setArea_name(area.getArea_name());
			}
		}
		long count = (long) dataDao.getFirstObjectViaParam("select count(*) " + tablehql.toString(), null);
		QueryResult<StoreTable>  result = new QueryResult<StoreTable>(tablelist, count);
		return result;
	}
	
	public StoreTable getStoreTableById(long id){
		return dataDao.getObjectById(StoreTable.class,id);
	}

	@SuppressWarnings("unchecked")
	public List<StoreArea> getAreaListByStoreId(long store_id){
		return (List<StoreArea>)dataDao.getObjectsViaParam(" from StoreArea where store_id = "+store_id, null);
	}
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void updateStoreTable(StoreTable table){
		dataDao.updateObject(table);
	}
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void addStoreTable(StoreTable table){
		dataDao.addObject(table);
	}
	
	@SuppressWarnings("unchecked")
	public List<StoreTable> getStoreTableList(long store_id,long area_id){
		String hql = " from StoreTable where store_id = :store_id and area_id = :area_id and del_flg = 0";
		List<StoreTable> tablelist = (List<StoreTable>) dataDao.getObjectsViaParam(hql + " order by table_id ",new String[]{"store_id","area_id"},store_id,area_id);
		for(StoreTable table:tablelist){
			if(table.getCorrent_order()>0){
				Order order = dataDao.getObjectById(Order.class, table.getCorrent_order());
				if(order!=null){
					List<OrderDetail> orderdetails = order.getMenu_list();
					List<OrderDetail> neworderdetail = new ArrayList<OrderDetail>();
					for(OrderDetail detail:orderdetails){
						if(detail.getDetail_flg()>=0){
							neworderdetail.add(detail);
						}
					}
					order.setMenu_list(neworderdetail);
					table.setOrder(order);
				}
			}
			if(table.getArea_id()>0){
				StoreArea storearea = dataDao.getObjectById(StoreArea.class, table.getArea_id());
				if(storearea!=null){
					table.setArea_name(storearea.getArea_name());
				}
			}
		}
		return tablelist;
	}
	
	@SuppressWarnings("unchecked")
	public List<StoreTable> getStoreTableListNoUse(long store_id,long area_id){
		String hql = " from StoreTable where store_id = :store_id and area_id = :area_id and state = 1 and del_flg = 0";
		List<StoreTable> tablelist = (List<StoreTable>) dataDao.getObjectsViaParam(hql,new String[]{"store_id","area_id"},store_id,area_id);
		for(StoreTable table:tablelist){
			if(table.getCorrent_order()>0){
				Order order = dataDao.getObjectById(Order.class, table.getCorrent_order());
				if(order!=null){
					List<OrderDetail> orderdetails = order.getMenu_list();
					List<OrderDetail> neworderdetail = new ArrayList<OrderDetail>();
					for(OrderDetail detail:orderdetails){
						if(detail.getDetail_flg()>=0){
							neworderdetail.add(detail);
						}
					}
					order.setMenu_list(neworderdetail);
					table.setOrder(order);
				}
			}
			if(table.getArea_id()>0){
				StoreArea storearea = dataDao.getObjectById(StoreArea.class, table.getArea_id());
				if(storearea!=null){
					table.setArea_name(storearea.getArea_name());
				}
			}
		}
		return tablelist;
	}

	
	public long getTableCount(long store_id,int state){
		String hql = "select count(*) from StoreTable where  store_id = :store_id and state = :state and del_flg = 0";
		//有客数量
		if(state == 2){
			hql += " and corrent_order in (select order_id from Order where store_id ="+store_id+" and state <> 4 )";
		}else if(state == 5 ){
			hql += " and corrent_order in (select order_id from Order where store_id ="+store_id+" and state = 4 )";
		}
		if(state==5)
			state = 2;
		long count = (long) dataDao.getFirstObjectViaParam(hql, new String[]{"store_id","state"}, store_id,state);
		return count;
	};
	

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public int cleanTable(long table_id){
		StoreTable storetable = dataDao.getObjectById(StoreTable.class, table_id);
		if(storetable!=null){
			if(storetable.getState()==1){
				return 99;
			}else{
				if(storetable.getState()==2){
					if(storetable.getCorrent_order()==0){
						storetable.setState(1);
						dataDao.updateObject(storetable);
						return 1;
					}else{
						Order order = dataDao.getObjectById(Order.class, storetable.getCorrent_order());
						if(order==null){
							storetable.setState(1);
							dataDao.updateObject(storetable);
							return 1;
						}else{
							if(order.getState()>=3){
								storetable.setCorrent_order(0);
								storetable.setState(1);
								dataDao.updateObject(storetable);
								return 1;
							}else{
								return 100;
							}
						}
					}
				}else{
					storetable.setState(1);
					dataDao.updateObject(storetable);
					return 1;
				}
			}
		}
		return 0;
	}
	
	@SuppressWarnings("unchecked")
	public List<Menu> getMenuListById(long store_id,Long category_id){
		String menuhql = " from Menu where delflag = 0 and sell_out = 0 and store_id = "+store_id;
		if(category_id!=null&&category_id>0){
			menuhql  += " and category_id = "+category_id;
		}
		menuhql += "  order by menu_name";
		List<Menu> menulist = (List<Menu>) dataDao.getObjectsViaParam(menuhql,null);
		return menulist;
	}
	
	public Menu getMenuById(long menu_id){
		return dataDao.getObjectById(Menu.class, menu_id);
	}
	
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void addOrderDetail(OrderDetail orderdetail){
		dataDao.addObject(orderdetail);
	}
}
