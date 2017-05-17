package com.daoshun.shiqu.pojo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "t_recharge_record")
public class RechargeRecord {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	@Column(name = "user_id", length = 20, nullable = false)
	private long user_id;
	@Column(name = "card_id", length = 20, nullable = false)
	private long card_id;
	// 实付金额
	@Column(name = "money")
	private float money;
	// 充值金额
	@Column(name = "charge_money")
	private float charge_money;
	// 更新时间
	@Column(name = "charge_time")
	private Date charge_time;
	// 1充值 2 消费
	@Column(name = "type")
	private int type;

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

	public long getCard_id() {
		return card_id;
	}

	public void setCard_id(long card_id) {
		this.card_id = card_id;
	}

	public float getMoney() {
		return money;
	}

	public void setMoney(float money) {
		this.money = money;
	}

	public float getCharge_money() {
		return charge_money;
	}

	public void setCharge_money(float charge_money) {
		this.charge_money = charge_money;
	}

	public Date getCharge_time() {
		return charge_time;
	}

	public void setCharge_time(Date charge_time) {
		this.charge_time = charge_time;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
}
