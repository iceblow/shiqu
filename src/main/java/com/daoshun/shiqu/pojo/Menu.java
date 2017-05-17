package com.daoshun.shiqu.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "t_menu")
public class Menu {

	// 菜品id
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "menu_id", length = 20, nullable = false)
	private long menu_id;
	@Column(name = "store_id", length = 20, nullable = false)
	private long store_id;
	// 菜品名称
	@Column(name = "menu_name", length = 500)
	private String menu_name;
	// 菜品名称拼音首字母
	@Column(name = "spell")
	private String spell;
	// 分类id
	@Column(name = "category_id", length = 20, nullable = false)
	private long category_id;
	// 分类
	@Column(name = "category", length = 50)
	private String category;
	// 菜品图片
	@Column(name = "pic", length = 20, nullable = false)
	private long pic;
	// 单价
	@Column(name = "price")
	private float price;
	// 原价
	@Column(name = "origin_price")
	private float origin_price;
	// 单位
	@Column(name = "unit", length = 10)
	private String unit;
	//送厨单位
	@Column(name = "kitunit", length = 255)
	private String kitunit;
	// 说明
	@Column(name = "description", length = 500)
	private String description;
	// 是否热销 1热销 0 不是
	@Column(name = "is_hot", length = 2)
	private int is_hot;
	// 是否需称重 1需称重 0 不需
	@Column(name = "is_weigh", length = 2)
	private int is_weigh;
	// 是否可打折，0不可 1可
	@Column(name = "can_discount", length = 2)
	private int can_discount;
	// 口味-多个，分隔
	@Column(name = "taste", length = 255)
	private String taste;
	//沽清 1卖完 0 没卖完
	@Column(name = "sell_out", length = 2)
	private int sell_out;
	//打印机1
	@Column(name = "print_id1", length = 20, nullable = false)
	private long print_id1;
	//打印机2
	@Column(name = "print_id2", length = 20, nullable = false)
	private long print_id2;
	//打印机3
	@Column(name = "print_id3", length = 20, nullable = false)
	private long print_id3;
	
	// 0正常 1删除
	@Column(name = "delflag", length = 1)
	private int delflag;
	// @ManyToOne(cascade = CascadeType.REFRESH, optional = false)
	// @JoinColumn(name = "store_id", referencedColumnName = "store_id")
	// private Store store;
	@Transient
	private String pic_url;

	public long getMenu_id() {
		return menu_id;
	}

	public void setMenu_id(long menu_id) {
		this.menu_id = menu_id;
	}

	public long getStore_id() {
		return store_id;
	}

	public void setStore_id(long store_id) {
		this.store_id = store_id;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public long getPic() {
		return pic;
	}

	public void setPic(long pic) {
		this.pic = pic;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getIs_hot() {
		return is_hot;
	}

	public void setIs_hot(Integer is_hot) {
		this.is_hot = is_hot;
	}

	public String getTaste() {
		return taste;
	}

	public void setTaste(String taste) {
		this.taste = taste;
	}

	public String getPic_url() {
		return pic_url;
	}

	public void setPic_url(String pic_url) {
		this.pic_url = pic_url;
	}

	public long getCategory_id() {
		return category_id;
	}

	public void setCategory_id(long category_id) {
		this.category_id = category_id;
	}

	public void setIs_hot(int is_hot) {
		this.is_hot = is_hot;
	}

	public int getIs_weigh() {
		return is_weigh;
	}

	public void setIs_weigh(int is_weigh) {
		this.is_weigh = is_weigh;
	}

	public String getSpell() {
		return spell;
	}

	public void setSpell(String spell) {
		this.spell = spell;
	}

	public int getCan_discount() {
		return can_discount;
	}

	public void setCan_discount(int can_discount) {
		this.can_discount = can_discount;
	}

	public String getKitunit() {
		return kitunit;
	}

	public void setKitunit(String kitunit) {
		this.kitunit = kitunit;
	}

	public int getSell_out() {
		return sell_out;
	}

	public void setSell_out(int sell_out) {
		this.sell_out = sell_out;
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

	public int getDelflag() {
		return delflag;
	}

	public void setDelflag(int delflag) {
		this.delflag = delflag;
	}

	public float getOrigin_price() {
		return origin_price;
	}

	public void setOrigin_price(float origin_price) {
		this.origin_price = origin_price;
	}
}
