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
@Table(name = "t_coupon")
public class Coupon {

	// 优惠券
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "coupon_id", length = 20, nullable = false)
	private long coupon_id;
	@Column(name = "store_id", length = 20, nullable = false)
	private long store_id;
	// 优惠券金额
	@Column(name = "amount")
	private float amount;
	// 最低消费
	@Column(name = "min_money")
	private float min_money;
	// 说明
	@Column(name = "description", length = 500)
	private String description;
	// 开始时间
	@Column(name = "from_time")
	private Date from_time;
	// 结束时间
	@Column(name = "end_time")
	private Date end_time;
	// 有效标志 0 无效 1有效
	@Column(name = "is_valid", length = 2, nullable = false, columnDefinition = "default 1")
	private int is_valid;
	// 限领数量
	@Column(name = "limit_num")
	private int limit_num;
	// @ManyToOne(cascade = CascadeType.REFRESH, optional = false)
	// @JoinColumn(name = "store_id", referencedColumnName = "store_id")
	// private Store store;
	// 是否领取
	@Transient
	private int is_geted;
	
	//已使用
	@Transient
	private int usecount;

	public long getCoupon_id() {
		return coupon_id;
	}

	public void setCoupon_id(long coupon_id) {
		this.coupon_id = coupon_id;
	}

	public long getStore_id() {
		return store_id;
	}

	public void setStore_id(long store_id) {
		this.store_id = store_id;
	}

	public float getAmount() {
		return amount;
	}

	public void setAmount(float amount) {
		this.amount = amount;
	}

	public float getMin_money() {
		return min_money;
	}

	public void setMin_money(float min_money) {
		this.min_money = min_money;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getFrom_time() {
		return from_time;
	}

	public void setFrom_time(Date from_time) {
		this.from_time = from_time;
	}

	public Date getEnd_time() {
		return end_time;
	}

	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}

	public int getIs_valid() {
		return is_valid;
	}

	public void setIs_valid(int is_valid) {
		this.is_valid = is_valid;
	}

	public int getLimit_num() {
		return limit_num;
	}

	public void setLimit_num(int limit_num) {
		this.limit_num = limit_num;
	}

	public int getIs_geted() {
		return is_geted;
	}

	public void setIs_geted(int is_geted) {
		this.is_geted = is_geted;
	}

	public int getUsecount() {
		return usecount;
	}

	public void setUsecount(int usecount) {
		this.usecount = usecount;
	}
}
