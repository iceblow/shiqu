package com.daoshun.shiqu.pojo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "t_store_category")
public class StoreCategory {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	@Column(name = "name")
	private String name;
	@Column(name = "pic_id")
	private long pic_id;
	// 逻辑删标志位 0未删 1已删
	// @Column(name = "del_flg", length = 1, nullable = false)
	// private int del_flg;
	// 更新时间
	@Column(name = "update_time")
	private Date update_time;
	
	@Transient
	private String pic_url;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public long getPic_id() {
		return pic_id;
	}

	public void setPic_id(long pic_id) {
		this.pic_id = pic_id;
	}

	public String getPic_url() {
		return pic_url;
	}

	public void setPic_url(String pic_url) {
		this.pic_url = pic_url;
	}
}
