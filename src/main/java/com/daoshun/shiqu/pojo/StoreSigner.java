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

/**
 * 签单人表
 * 
 * @author qiuch
 *
 */
@Entity
@Table(name = "t_store_signer")
public class StoreSigner {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	// 店铺id
	@Column(name = "store_id", length = 20, nullable = false)
	private long store_id;
	// 签单人姓名
	@Column(name = "name")
	private String name;
	// 签单人公司
	@Column(name = "company")
	private String company;
	// 0正常 1删除
	@Column(name = "delflag", length = 1)
	private int delflag;

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

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public int getDelflag() {
		return delflag;
	}

	public void setDelflag(int delflag) {
		this.delflag = delflag;
	}
}
