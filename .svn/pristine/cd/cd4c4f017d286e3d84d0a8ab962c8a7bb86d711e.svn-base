/**
 * 
 */
package com.daoshun.shiqu.pojo;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * @author qiuch
 *
 */
@Entity
@Table(name = "t_area_info")
public class AreaInfo {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	// 父级id
	@Column(name = "parent_id", length = 20, nullable = false)
	private long parent_id;
	@Column(name = "name")
	private String name;
	// 子地区列表
	@Transient
	private List<AreaInfo> list;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getParent_id() {
		return parent_id;
	}

	public void setParent_id(long parent_id) {
		this.parent_id = parent_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<AreaInfo> getList() {
		return list;
	}

	public void setList(List<AreaInfo> list) {
		this.list = list;
	}
}
