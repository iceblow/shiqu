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
 * 后台管理用户表
 * 
 * @author qiuch
 *
 */
@Entity
@Table(name = "t_manage_user")
public class ManageUser {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	// 用户名
	@Column(name = "name", length = 50)
	private String name;
	// 密码
	@Column(name = "password")
	private String password;
	// 权限 1管理员 10代理商 20总店长
	@Column(name = "privilege")
	private int privilege;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getPrivilege() {
		return privilege;
	}

	public void setPrivilege(int privilege) {
		this.privilege = privilege;
	}
}
