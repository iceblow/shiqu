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
 * @author qiuch
 *
 */
@Entity
@Table(name = "t_message_info")
public class MessageInfo {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	// 0平台消息 >0商家发的消息
	@Column(name = "store_id", length = 20, nullable = false)
	private long store_id;
	// 标题
	@Column(name = "title")
	private String title;
	// 内容
	@Column(name = "content", length = 65535)
	private String content;
	// 用户id，不关联的时候为空
	@Column(name = "user_ids")
	private String user_ids;
	// 0没有优惠券 >0关联优惠券
	@Column(name = "coupon_id")
	private String coupon_id;
	
	@Column(name = "addtime")
	private Date addtime;

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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getUser_ids() {
		return user_ids;
	}

	public void setUser_ids(String user_ids) {
		this.user_ids = user_ids;
	}

	public String getCoupon_id() {
		return coupon_id;
	}

	public void setCoupon_id(String coupon_id) {
		this.coupon_id = coupon_id;
	}

	public Date getAddtime() {
		return addtime;
	}

	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}
}
