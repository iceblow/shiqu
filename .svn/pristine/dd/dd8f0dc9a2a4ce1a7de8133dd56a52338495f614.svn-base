/**
 * 
 */
package com.daoshun.shiqu.pojo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 销售额统计表
 * 
 * @author qiuch
 *
 */
@Entity
@Table(name = "t_sale_statistics")
public class SaleStatistics {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	@Column(name = "store_id", length = 20, nullable = false)
	private long store_id;
	// 统计的开始时间
	@Column(name = "start_time")
	private Date start_time;
	// 统计的结束时间
	@Column(name = "end_time")
	private Date end_time;
	// 统计的类型 1 日统计 2周统计 3 月统计
	@Column(name = "type")
	private int type;
	// 显示的时间 日统计：xxxx年xx月xx日 2xxxx年第xx周 3xxxx年xx月
	@Column(name = "show_date")
	private String show_date;
	// 销售额（总额）
	@Column(name = "sale_num")
	private float sale_num;
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

	public Date getStart_time() {
		return start_time;
	}

	public void setStart_time(Date start_time) {
		this.start_time = start_time;
	}

	public Date getEnd_time() {
		return end_time;
	}

	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getShow_date() {
		return show_date;
	}

	public void setShow_date(String show_date) {
		this.show_date = show_date;
	}

	public float getSale_num() {
		return sale_num;
	}

	public void setSale_num(float sale_num) {
		this.sale_num = sale_num;
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
