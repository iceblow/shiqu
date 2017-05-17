package com.daoshun.shiqu.pojo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "t_collection")
public class Collection {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	// 收藏用户id
	@Column(name = "user_id", length = 20, nullable = false)
	private long user_id;
	// 收藏类型 1店铺 2菜品
	@Column(name = "type")
	private int type;
	// 收藏对象id
	@Column(name = "collection_id", length = 20, nullable = false)
	private long collection_id;
	// 收藏时间
	@Column(name = "collect_time")
	private Date collect_time;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getUser_id() {
		return user_id;
	}

	public void setUser_id(long user_id) {
		this.user_id = user_id;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public long getCollection_id() {
		return collection_id;
	}

	public void setCollection_id(long collection_id) {
		this.collection_id = collection_id;
	}

	public Date getCollect_time() {
		return collect_time;
	}

	public void setCollect_time(Date collect_time) {
		this.collect_time = collect_time;
	}
}
