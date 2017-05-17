package com.daoshun.shiqu.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 打印机配置表
 * 
 * @author wangcl
 *
 */
@Entity
@Table(name = "t_print_info")
public class PrintInfo {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	
	// 店铺id
	@Column(name = "store_id", length = 20, nullable = false)
	private long store_id;
	
	//打印机编号
	@Column(name = "print_sn", nullable = false)
	private String print_sn;
	
	//打印机秘钥
	@Column(name = "print_key", nullable = false)
	private String print_key;
	
	//打印机名称
	@Column(name = "print_name")
	private String print_name;
	
	//打印机类型 1：窄型打印机 2：宽型打印机
	@Column(name = "type")
	private Integer type;
	
	//适用范围 1：通用 2：结账 3：收银 4：厨房总单 5：厨房分单 6：退菜单
	@Column(name = "scope")
	private Integer scope;
	
	//打印份数
	@Column(name = "print_num")
	private Integer print_num;
	
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

	public String getPrint_sn() {
		return print_sn;
	}

	public void setPrint_sn(String print_sn) {
		this.print_sn = print_sn;
	}

	public String getPrint_key() {
		return print_key;
	}

	public void setPrint_key(String print_key) {
		this.print_key = print_key;
	}

	public String getPrint_name() {
		return print_name;
	}

	public void setPrint_name(String print_name) {
		this.print_name = print_name;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getScope() {
		return scope;
	}

	public void setScope(Integer scope) {
		this.scope = scope;
	}

	public Integer getPrint_num() {
		return print_num;
	}

	public void setPrint_num(Integer print_num) {
		this.print_num = print_num;
	}
	
}
