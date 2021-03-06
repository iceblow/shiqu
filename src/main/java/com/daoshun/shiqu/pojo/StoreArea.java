/**
 * 
 */
package com.daoshun.shiqu.pojo;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * @author qiuch
 *
 */
@Entity
@Table(name = "t_store_area")
public class StoreArea {

	// 区域id
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	// 商家id
	@Column(name = "store_id", length = 20, nullable = false)
	private long store_id;
	// 区域名称
	@Column(name = "area_name", length = 50)
	private String area_name;
	// 打印机1
	@Column(name = "print_id1", length = 20, nullable = false)
	private long print_id1;
	// 打印机2
	@Column(name = "print_id2", length = 20, nullable = false)
	private long print_id2;
	// 打印机3
	@Column(name = "print_id3", length = 20, nullable = false)
	private long print_id3;
	@OneToMany(fetch = FetchType.EAGER)
	@JoinColumn(name = "area_id")
	private List<StoreTable> table_list;

	@Transient
	private String print_name1;
	
	@Transient
	private String print_name2;
	
	@Transient
	private String print_name3;
	
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

	public String getArea_name() {
		return area_name;
	}

	public void setArea_name(String area_name) {
		this.area_name = area_name;
	}

	public long getPrint_id1() {
		return print_id1;
	}

	public void setPrint_id1(long print_id1) {
		this.print_id1 = print_id1;
	}

	public long getPrint_id2() {
		return print_id2;
	}

	public void setPrint_id2(long print_id2) {
		this.print_id2 = print_id2;
	}

	public long getPrint_id3() {
		return print_id3;
	}

	public void setPrint_id3(long print_id3) {
		this.print_id3 = print_id3;
	}

	public List<StoreTable> getTable_list() {
		return table_list;
	}

	public void setTable_list(List<StoreTable> table_list) {
		this.table_list = table_list;
	}

	public String getPrint_name1() {
		return print_name1;
	}

	public void setPrint_name1(String print_name1) {
		this.print_name1 = print_name1;
	}

	public String getPrint_name2() {
		return print_name2;
	}

	public void setPrint_name2(String print_name2) {
		this.print_name2 = print_name2;
	}

	public String getPrint_name3() {
		return print_name3;
	}

	public void setPrint_name3(String print_name3) {
		this.print_name3 = print_name3;
	}
	
}
