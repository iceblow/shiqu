/**
 * 
 */
package com.daoshun.shiqu.service.manage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.common.QueryResult;
import com.daoshun.shiqu.pojo.Advert;
import com.daoshun.shiqu.pojo.Feedback;
import com.daoshun.shiqu.pojo.ManageUser;
import com.daoshun.shiqu.pojo.Refuse;
import com.daoshun.shiqu.pojo.SysConfig;
import com.daoshun.shiqu.pojo.UserInfo;
import com.daoshun.shiqu.service.BaseService;

/**
 * 后台管理常用Service
 * 
 * @author qiuch
 *
 */
@Service("maCommonService")
@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
public class MaCommonService extends BaseService {

	/**
	 * @param 登录名
	 * @param 密码
	 * @return 错误消息
	 */
	public ManageUser login(String name) {
		ManageUser mUser = (ManageUser) dataDao.getFirstObjectViaParam("from ManageUser where name = :name ", new String[] { "name" }, name);
		return mUser;
	}

	public List<Advert> getBanner() {
		List<Advert> adverts = dataDao.getAllObject(Advert.class);
		for (Advert advert : adverts) {
			advert.setPic_url(getFilePathById(advert.getPic()));
		}
		return adverts;
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void editBanner(Advert advert) {
		dataDao.updateObject(advert);
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void addBanner(String url, long fileId) {
		Advert advert = new Advert();
		advert.setPic(fileId);
		advert.setUrl(url);
		dataDao.addObject(advert);
	}

	public Map<String, Object> getVersion() {
		Map<String, Object> result = new HashMap<String, Object>();
		String hql = "select value from SysConfig where id = :key";
		String params[] = new String[] { "key" };
		result.put("innerversion", dataDao.getFirstObjectViaParam(hql, params, 2l));
		result.put("userversion", dataDao.getFirstObjectViaParam(hql, params, 3l));
		result.put("aboutus", dataDao.getFirstObjectViaParam(hql, params, 5l));
		return result;
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public Map<String, Object> editVersion(String innerversion, String userversion, String aboutus, long fileid) {
		Map<String, Object> result = new HashMap<String, Object>();
		String hql = "from SysConfig where id = :key";
		String params[] = new String[] { "key" };
		SysConfig innerVer = (SysConfig) dataDao.getFirstObjectViaParam(hql, params, 2l);
		innerVer.setValue(innerversion);
		dataDao.updateObject(innerVer);
		SysConfig userVer = (SysConfig) dataDao.getFirstObjectViaParam(hql, params, 3l);
		userVer.setValue(userversion);
		dataDao.updateObject(userVer);
		if (fileid != 0) {
			SysConfig apkUrl = (SysConfig) dataDao.getFirstObjectViaParam(hql, params, 4l);
			apkUrl.setValue(getFilePathById(fileid));
			dataDao.updateObject(apkUrl);
		}
		SysConfig about = (SysConfig) dataDao.getFirstObjectViaParam(hql, params, 5l);
		about.setValue(aboutus);
		dataDao.updateObject(about);
		result.put("innerversion", innerversion);
		result.put("userversion", userversion);
		result.put("aboutus", aboutus);
		return result;
	}

	@SuppressWarnings("unchecked")
	public QueryResult<Feedback> getFeedBack(Integer page, Integer pageSize) {
		List<Feedback> feedbacks = (List<Feedback>) dataDao.pageQueryViaParam("from Feedback order by time desc ", pageSize, page, null);
		for (Feedback feedback : feedbacks) {
			UserInfo userInfo = dataDao.getObjectById(UserInfo.class, feedback.getUser_id());
			if (userInfo != null) {
				feedback.setPhone(userInfo.getPhone());
				if (!CommonUtils.isEmptyString(userInfo.getReal_name())) {
					feedback.setName(userInfo.getReal_name());
				} else if (!CommonUtils.isEmptyString(userInfo.getNick_name())) {
					feedback.setName(userInfo.getNick_name());
				} else {
					feedback.setName(userInfo.getUser_name());
				}
			} else {
				feedback.setName("匿名用户");
				feedback.setPhone("暂无号码");
			}
		}
		String counthql = "select count(id) from Feedback";
		long total = (long) dataDao.getFirstObjectViaParam(counthql, null);
		QueryResult<Feedback> result = new QueryResult<Feedback>(feedbacks, total);
		return result;
	}

	public Advert getAdvert(Long id) {
		Advert info = dataDao.getObjectById(Advert.class, id);
		return info;
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void delAdvert(Advert advert) {
		dataDao.deleteObject(advert);
	}

	@SuppressWarnings("unchecked")
	public QueryResult<UserInfo> getUserInfoListByPage(Integer pageIndex, int pageSize, String keywords) {
		String hql = " from UserInfo where 1=1";
		if(!CommonUtils.isEmptyString(keywords)){
			hql += " and (user_name like '%"+keywords+"%' or real_name like '%"+keywords+"%' or nick_name like '%"+keywords+"%' or phone like '%"+keywords+"%')";
		}
		hql += " order by create_time desc";
		List<UserInfo> list = (List<UserInfo>) dataDao.pageQueryViaParam(hql, pageSize, pageIndex, null);
		if(list != null && list.size() > 0){
			for (UserInfo userInfo : list) {
				if(userInfo.getAvatar() != 0){
					userInfo.setAvatar_url(getFilePathById(userInfo.getAvatar()));
				}
			}
		}
		String counthql = "select count(*) "+hql;
		long total = (long) dataDao.getFirstObjectViaParam(counthql, null);
		QueryResult<UserInfo> result = new QueryResult<UserInfo>(list, total);
		return result;
	}

	public List<UserInfo> getUserInfoList() {
		List<UserInfo> list = dataDao.getAllObject(UserInfo.class);
		return list;
	}

	public List<Refuse> getRefuseList() {
		List<Refuse> list = dataDao.getAllObject(Refuse.class);
		return list;
	}

	public Refuse getRefuse(Long id) {
		Refuse info = dataDao.getObjectById(Refuse.class, id);
		return info;
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void updateRefuse(Refuse refuse) {
		dataDao.updateObject(refuse);
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void addRefuse(Refuse refuse) {
		dataDao.addObject(refuse);
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void delRefuse(Refuse refuse) {
		dataDao.deleteObject(refuse);
	}
}
