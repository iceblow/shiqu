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
 * 每日统计信息
 * 
 * @author qiuch
 *
 */
@Entity
@Table(name = "t_daily_statistics")
public class DailyStatistics {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	@Column(name = "store_id", length = 20, nullable = false)
	private long store_id;
	// 当日总销售额
	@Column(name = "total_sell")
	private float total_sell;
	// 当日顾客数
	@Column(name = "total_customers")
	private int total_customers;
	// 当日下单数
	@Column(name = "total_order")
	private int total_order;
	// 支付宝总额
	@Column(name = "paypal_num")
	private float paypal_num;
	// 刷卡总额
	@Column(name = "card_num")
	private float card_num;
	// 现金总额
	@Column(name = "cash_num")
	private float cash_num;
	// 充值卡总额
	@Column(name = "charge_num")
	private float charge_num;
		
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

	public float getTotal_sell() {
		return total_sell;
	}

	public void setTotal_sell(float total_sell) {
		this.total_sell = total_sell;
	}

	public int getTotal_customers() {
		return total_customers;
	}

	public void setTotal_customers(int total_customers) {
		this.total_customers = total_customers;
	}

	public int getTotal_order() {
		return total_order;
	}

	public void setTotal_order(int total_order) {
		this.total_order = total_order;
	}

	public float getPaypal_num() {
		return paypal_num;
	}

	public void setPaypal_num(float paypal_num) {
		this.paypal_num = paypal_num;
	}

	public float getCard_num() {
		return card_num;
	}

	public void setCard_num(float card_num) {
		this.card_num = card_num;
	}

	public float getCash_num() {
		return cash_num;
	}

	public void setCash_num(float cash_num) {
		this.cash_num = cash_num;
	}

	public float getCharge_num() {
		return charge_num;
	}

	public void setCharge_num(float charge_num) {
		this.charge_num = charge_num;
	}
	
}
