package com.daoshun.shiqu.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "t_store_pic")
public class StorePic {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	// 商户id
	@Column(name = "store_id", length = 20, nullable = false)
	private long store_id;
	// 图片id
	@Column(name = "pic_id", length = 20, nullable = false)
	private long pic_id;
	// 图片地址
	@Transient
	private String img_url;

	// @ManyToOne(cascade = CascadeType.REFRESH, optional = false)
	// @JoinColumn(name = "store_id",referencedColumnName="store_id")
	// private Store store;
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

	public long getPic_id() {
		return pic_id;
	}

	public void setPic_id(long pic_id) {
		this.pic_id = pic_id;
	}

	public String getImg_url() {
		return img_url;
	}

	public void setImg_url(String img_url) {
		this.img_url = img_url;
	}
}
