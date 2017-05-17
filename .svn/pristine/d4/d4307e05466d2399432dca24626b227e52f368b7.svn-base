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
import javax.persistence.Transient;

/**
 * 菜品统计信息
 * 
 * @author qiuch
 *
 */
@Entity
@Table(name = "t_menu_statistics")
public class MenuStatistics {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	@Column(name = "store_id", length = 20, nullable = false)
	private long store_id;
	// 菜品id
	@Column(name = "menu_id", length = 20, nullable = false)
	private long menu_id;
	// 当日销售分数
	@Column(name = "total_sell")
	private int total_sell;
	
	// 统计的类型 1 日统计 2周统计 3 月统计
	@Column(name = "type")
	private int type;
	
	// 显示的时间 日统计：xxxx年xx月xx日 2xxxx年第xx周 3xxxx年xx月
	@Column(name = "show_date")
	private String show_date;
	
	// 统计的开始时间
	@Column(name = "start_time")
	private Date start_time;
	// 统计的结束时间
	@Column(name = "end_time")
	private Date end_time;
	
	@Transient
	private String menu_name;
	
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
	public long getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(long menu_id) {
		this.menu_id = menu_id;
	}
	public int getTotal_sell() {
		return total_sell;
	}
	public void setTotal_sell(int total_sell) {
		this.total_sell = total_sell;
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
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	
}
