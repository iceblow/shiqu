/**
 * 
 */
package com.daoshun.shiqu.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 推送设置表
 * 
 * @author qiuch
 *
 */
@Entity
@Table(name = "t_push_info")
public class PushInfo {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	// 关联用户表
	@Column(name = "user_id", length = 20, nullable = false)
	private long user_id;
	// 设备标识
	@Column(name = "client_id")
	private String client_id;
	// 设备类型 1 ios 2android 0 无效设备信息
	@Column(name = "device_type")
	private int device_type;
	// 是否接收推送 0接受 1不接受
	@Column(name = "is_receive")
	private int is_receive;

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

	public String getClient_id() {
		return client_id;
	}

	public void setClient_id(String client_id) {
		this.client_id = client_id;
	}

	public int getDevice_type() {
		return device_type;
	}

	public void setDevice_type(int device_type) {
		this.device_type = device_type;
	}

	public int getIs_receive() {
		return is_receive;
	}

	public void setIs_receive(int is_receive) {
		this.is_receive = is_receive;
	}
}
