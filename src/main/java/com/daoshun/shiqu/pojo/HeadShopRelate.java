package com.daoshun.shiqu.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 总店和店铺关联表
 * @author shenyj
 *
 */
@Entity
@Table(name = "t_head_shop_relate")
public class HeadShopRelate {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	
	@Column(name = "headid", length = 20, nullable = false)
	private long headid;

	@Column(name = "storeid", length = 20, nullable = false)
	private long storeid;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getHeadid() {
		return headid;
	}

	public void setHeadid(long headid) {
		this.headid = headid;
	}

	public long getStoreid() {
		return storeid;
	}

	public void setStoreid(long storeid) {
		this.storeid = storeid;
	}
}
