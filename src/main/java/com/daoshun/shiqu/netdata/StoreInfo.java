/**
 * 
 */
package com.daoshun.shiqu.netdata;

/**
 * @author qiuch
 *
 */
public class StoreInfo {

	private long store_id;
	private String store_name;
	private String category_name;
	private int is_out;
	private float min_send;
	private long sales_num;
	private double distance;
	private int is_new;
	private long has_coupon;
	// List<String> category_list;
	private String pic_url;

	// public StoreInfo(Object[] data, String picurl, List<String> categoryList) {
	// category_list = categoryList;
	// pic_url = picurl;
	// }
	public StoreInfo(Object[] data, String picurl) {
		store_id = ((java.math.BigInteger) data[0]).longValue();
		store_name = String.valueOf(data[1]);
		category_name = (String) data[2];
		is_out = (int) data[3];
		min_send = (float) data[4];
		sales_num = ((java.math.BigInteger) data[5]).longValue();
		distance = (double) data[7];
		is_new = Integer.parseInt(String.valueOf(data[8]));
		has_coupon = ((java.math.BigInteger) data[9]).longValue();
		pic_url = picurl;
	}

	public long getStore_id() {
		return store_id;
	}

	public void setStore_id(long store_id) {
		this.store_id = store_id;
	}

	public String getStore_name() {
		return store_name;
	}

	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}

	public String getCategory_name() {
		return category_name;
	}

	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}

	public int getIs_out() {
		return is_out;
	}

	public void setIs_out(int is_out) {
		this.is_out = is_out;
	}

	public float getMin_send() {
		return min_send;
	}

	public void setMin_send(float min_send) {
		this.min_send = min_send;
	}

	public long getSales_num() {
		return sales_num;
	}

	public void setSales_num(long sales_num) {
		this.sales_num = sales_num;
	}

	public double getDistance() {
		return distance;
	}

	public void setDistance(double distance) {
		this.distance = distance;
	}

	public int getIs_new() {
		return is_new;
	}

	public void setIs_new(int is_new) {
		this.is_new = is_new;
	}

	public long getHas_coupon() {
		return has_coupon;
	}

	public void setHas_coupon(long has_coupon) {
		this.has_coupon = has_coupon;
	}

	public String getPic_url() {
		return pic_url;
	}

	public void setPic_url(String pic_url) {
		this.pic_url = pic_url;
	}

}
