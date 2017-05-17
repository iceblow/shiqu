package com.daoshun.shiqu.pojo;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "t_menu_category")
public class MenuCategory {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	// 商家id
	@Column(name = "store_id", length = 20, nullable = false)
	private long store_id;
	// 分类名字
	@Column(name = "name")
	private String name;
	// 更新时间
	@Column(name = "update_time")
	private Date update_time;
	//0启用，1不启用
	@Column(name = "delflg", length = 1, nullable = false)
	private int delflg;
	// 菜单列表
	@Transient
	private List<Menu> menu_list;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
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

	public long getStore_id() {
		return store_id;
	}

	public void setStore_id(long store_id) {
		this.store_id = store_id;
	}

	public List<Menu> getMenu_list() {
		return menu_list;
	}

	public void setMenu_list(List<Menu> menu_list) {
		this.menu_list = menu_list;
	}

	public void setId(long id) {
		this.id = id;
	}

	public int getDelflg() {
		return delflg;
	}

	public void setDelflg(int delflg) {
		this.delflg = delflg;
	}
}
