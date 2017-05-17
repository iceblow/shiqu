/**
 * 
 */
package com.daoshun.shiqu.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.pojo.AreaInfo;

/**
 * @author qiuch
 * 
 */
@Service("commonService")
@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
public class CommonService extends BaseService {

	/**
	 * 获取地区列表
	 */
	public Map<String, Object> getArea() {
		Map<String, Object> result = new HashMap<String, Object>();
		String hql = "from AreaInfo where parent_id = :pid";
		String params[] = new String[] { "pid" };
		List<AreaInfo> provinceList = (List<AreaInfo>) dataDao.getObjectsViaParam(hql, params, 0l);
		for (AreaInfo province : provinceList) {
			List<AreaInfo> cityList = (List<AreaInfo>) dataDao.getObjectsViaParam(hql, params, province.getId());
			for (AreaInfo city : cityList) {
				List<AreaInfo> areaList = (List<AreaInfo>) dataDao.getObjectsViaParam(hql, params, city.getId());
				city.setList(areaList);
			}
			province.setList(cityList);
		}
		result.put("area_list", provinceList);
		String version = (String) dataDao.getFirstObjectViaParam("select value from SysConfig where id = 1 ", null);
		result.put("version", CommonUtils.parseInt(version, 0));
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public List<AreaInfo> getAreaByParentid(long parentid){
		String hql = "from AreaInfo where parent_id = :pid";
		List<AreaInfo> arealist = (List<AreaInfo>) dataDao.getObjectsViaParam(hql,  new String[] { "pid" }, parentid);
		return arealist;
	}
	
	public AreaInfo getAreaInfoById(long id){
		return dataDao.getObjectById(AreaInfo.class, id);
	}

	/**
	 * 获取地区版本
	 */
	public String getAreaVer() {
		String version = (String) dataDao.getFirstObjectViaParam("select value from SysConfig where id = 1 ", null);
		return version;
	}

	/**
	 * 获取version
	 */
	public Map<String, Object> getVersoin() {
		Map<String, Object> result = new HashMap<String, Object>();
		String hql = "select value from SysConfig where id = :key";
		String params[] = new String[] { "key" };
		result.put("version", dataDao.getFirstObjectViaParam(hql, params, 2l));
		result.put("version_str", dataDao.getFirstObjectViaParam(hql, params, 3l));
		result.put("apk_url", dataDao.getFirstObjectViaParam(hql, params, 4l));
		return result;
	}

	/**
	 * 获取关于
	 */
	public String getAbout() {
		return (String) dataDao.getFirstObjectViaParam("select value from SysConfig where id = 5 ", null);
	}
}
