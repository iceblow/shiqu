package com.daoshun.shiqu.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "t_store_table")
public class StoreTable {

	// 桌台id
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "table_id", length = 20, nullable = false)
	private long table_id;
	// 商家id
	@Column(name = "store_id", length = 20, nullable = false)
	private long store_id;
	// 区域
	@Column(name = "area_id", length = 20, nullable = false)
	private long area_id;
	// 桌号
	@Column(name = "table_no", length = 100)
	private String table_no;
	// 人数
	@Column(name = "num")
	private int num;
	// 桌台状态 1 空闲 2有客 3 预约 4不可用
	@Column(name = "state", length = 2)
	private int state;
	// 有人时的订单id
	@Column(name = "corrent_order", length = 20, nullable = false)
	private long corrent_order;
	
	//0:未删除 1:已删除
	@Column(name = "del_flg")
	private int del_flg;
	
	@Transient
	private Order order;
	
	@Transient
	private String area_name;

	public long getTable_id() {
		return table_id;
	}

	public void setTable_id(long table_id) {
		this.table_id = table_id;
	}

	public long getStore_id() {
		return store_id;
	}

	public void setStore_id(long store_id) {
		this.store_id = store_id;
	}

	public long getArea_id() {
		return area_id;
	}

	public void setArea_id(long area_id) {
		this.area_id = area_id;
	}

	public String getTable_no() {
		return table_no;
	}

	public void setTable_no(String table_no) {
		this.table_no = table_no;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public long getCorrent_order() {
		return corrent_order;
	}

	public void setCorrent_order(long corrent_order) {
		this.corrent_order = corrent_order;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public String getArea_name() {
		return area_name;
	}

	public void setArea_name(String area_name) {
		this.area_name = area_name;
	}

	public int getDel_flg() {
		return del_flg;
	}

	public void setDel_flg(int del_flg) {
		this.del_flg = del_flg;
	}

}
