/**
 * 
 */
package com.daoshun.shiqu.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * 商户端用户表
 * 
 * @author qiuch
 *
 */
@Entity
@Table(name = "t_store_user")
public class StoreUser {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	// 关联商户id
	@Column(name = "store_id", length = 20, nullable = false)
	private long store_id;
	// 姓名
	@Column(name = "name", length = 50)
	private String name;
	// 手机号（登录）
	@Column(name = "phone", length = 20)
	private String phone;
	// 密码
	@Column(name = "password")
	private String password;
	// 权限 1管理（店长） 10收银 20点单（跑堂）
	@Column(name = "privilege")
	private int privilege;
	// 折扣率
	@Column(name = "discount")
	private float discount;
	// 抹零上限
	@Column(name = "limitreset")
	private float limitreset;
	// 设备信息
	@Column(name = "client_id")
	private String client_id;
	// 0正常 1删除(离职)
	@Column(name = "delflag", length = 1)
	private int delflag;
	@Transient
	private String store_name;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getStore_id() {
		return store_id;
	}

	public void setStore_id(long store_id) {
		this.store_id = store_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getPrivilege() {
		return privilege;
	}

	public void setPrivilege(int privilege) {
		this.privilege = privilege;
	}

	public float getDiscount() {
		return discount;
	}

	public void setDiscount(float discount) {
		this.discount = discount;
	}

	public String getClient_id() {
		return client_id;
	}

	public void setClient_id(String client_id) {
		this.client_id = client_id;
	}

	public int getDelflag() {
		return delflag;
	}

	public void setDelflag(int delflag) {
		this.delflag = delflag;
	}

	public float getLimitreset() {
		return limitreset;
	}

	public void setLimitreset(float limitreset) {
		this.limitreset = limitreset;
	}

	public String getStore_name() {
		return store_name;
	}

	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
}
