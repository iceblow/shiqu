package com.daoshun.shiqu.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.common.QueryResult;
import com.daoshun.shiqu.pojo.Store;
import com.daoshun.shiqu.pojo.StoreSigner;
import com.daoshun.shiqu.pojo.StoreUser;

/**
 * @author wangcl
 *
 */
@Service("storeUserService")
@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
public class StoreUserService extends BaseService {

	public StoreUser getStoreUserByPhone(String phone) {
		StoreUser storeUser = (StoreUser) dataDao.getFirstObjectViaParam("from StoreUser where delflag = 0 and phone = :phone ", new String[] { "phone" }, phone);
		return storeUser;
	}

	public StoreUser getStoreUserByStorePhone(String phone, Long store_id) {
		StoreUser storeUser = (StoreUser) dataDao.getFirstObjectViaParam("from StoreUser where delflag = 0 and phone = :phone and store_id = :store_id", new String[] { "phone", "store_id" }, phone,
				store_id);
		return storeUser;
	}
	
	public StoreUser getCheckStoreUserByStorePhone(String phone, Long store_id) {
		StoreUser storeUser = (StoreUser) dataDao.getFirstObjectViaParam("from StoreUser where phone = :phone and store_id = :store_id", new String[] { "phone", "store_id" }, phone,
				store_id);
		return storeUser;
	}

	public Store getStoreById(long store_id) {
		Store store = dataDao.getObjectById(Store.class, store_id);
		return store;
	}

	@SuppressWarnings("unchecked")
	public QueryResult<StoreUser> getStoreUserListByStorePage(long store_id, Integer pageIndex, int pageSize) {
		String hql = "from StoreUser where delflag = 0 and store_id = :store_id order by privilege";
		String[] params = new String[] { "store_id" };
		List<StoreUser> list = (List<StoreUser>) dataDao.pageQueryViaParam(hql, pageSize, pageIndex, params, store_id);
		String counthql = "select count(*) " + hql;
		long total = (long) dataDao.getFirstObjectViaParam(counthql, params, store_id);
		QueryResult<StoreUser> result = new QueryResult<StoreUser>(list, total);
		return result;
	}

	public StoreUser getStoreUserById(Long id) {
		StoreUser info = dataDao.getObjectById(StoreUser.class, id);
		return info;
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void addStoreUser(StoreUser user) {
		dataDao.addObject(user);
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void updateStoreUser(StoreUser user) {
		dataDao.updateObject(user);
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void delStoreUser(StoreUser user) {
		dataDao.deleteObject(user);
	}

	@SuppressWarnings("unchecked")
	public QueryResult<StoreSigner> getStoreSignerListByPage(long store_id, Integer pageIndex, int pageSize) {
		String hql = " from StoreSigner where delflag = 0 and store_id = :store_id";
		String[] params = new String[] { "store_id" };
		List<StoreSigner> list = (List<StoreSigner>) dataDao.pageQueryViaParam(hql, pageSize, pageIndex, params, store_id);
		String counthql = "select count(*) " + hql;
		long count = (long) dataDao.getFirstObjectViaParam(counthql, params, store_id);
		QueryResult<StoreSigner> result = new QueryResult<StoreSigner>(list, count);
		return result;
	}

	public StoreSigner getStoreSignerById(Long id) {
		StoreSigner info = dataDao.getObjectById(StoreSigner.class, id);
		return info;
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void addStoreSigner(StoreSigner user) {
		dataDao.addObject(user);
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void updateStoreSigner(StoreSigner user) {
		dataDao.updateObject(user);
	}

	public StoreSigner getStoreSignerByName(long store_id, String name) {
		String hql = " from StoreSigner where store_id = :store_id and name = :name";
		String[] params = new String[] { "store_id", "name" };
		StoreSigner info = (StoreSigner) dataDao.getFirstObjectViaParam(hql, params, store_id, name);
		return info;
	}

	public List<StoreSigner> getStoreSignerByStoreId(long sotre_id) {
		String hql = " from StoreSigner where store_id = :store_id and delflag = 0 ";
		List<StoreSigner> signerlist = (List<StoreSigner>) dataDao.getObjectsViaParam(hql, new String[] { "store_id" }, sotre_id);
		return signerlist;
	}
	
	@SuppressWarnings("unchecked")
	public List<Store> getStoreUserList(String phone ,String password){
		String hql = "from Store where store_id in (select store_id  from StoreUser where phone = :phone and password = :password and delflag = 0  and (  privilege = 1 or privilege = 10 ) )";
		List<Store> storelist = (List<Store>) dataDao.getObjectsViaParam(hql, new String[]{"phone","password"}, phone, CommonUtils.MD5(password));
		return storelist;
	}
}
