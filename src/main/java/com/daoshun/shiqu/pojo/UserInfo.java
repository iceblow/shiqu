package com.daoshun.shiqu.pojo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "t_user_info")
public class UserInfo {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "user_id", length = 20, nullable = false)
	private long user_id;
	// 用户名
	@Column(name = "user_name")
	private String user_name;
	// 真实姓名
	@Column(name = "real_name")
	private String real_name;
	// 昵称
	@Column(name = "nick_name")
	private String nick_name;
	// 电话
	@Column(name = "phone", length = 20)
	private String phone;
	// 密码
	@Column(name = "password")
	private String password;
	// 头像id
	@Column(name = "avatar", length = 20, nullable = false)
	private long avatar;
	// 生日
	@Column(name = "birthday")
	private Date birthday;
	// 性别
	@Column(name = "gender", length = 4)
	private String gender;
	// 第三方QQ绑定
	@Column(name = "qq_openid", length = 100)
	private String qq_openid;
	// 第三方QQ绑定
	@Column(name = "weixin_openid", length = 100)
	private String weixin_openid;
	// 用户入库时间
	@Column(name = "create_time")
	private Date create_time;
	@Transient
	private String avatar_url;
	@Transient
	private float allAmount;
	@Transient
	private Date use_time;
	@Transient
	private int is_receive;

	public long getUser_id() {
		return user_id;
	}

	public void setUser_id(long user_id) {
		this.user_id = user_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getNick_name() {
		return nick_name;
	}

	public void setNick_name(String nick_name) {
		this.nick_name = nick_name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public long getAvatar() {
		return avatar;
	}

	public void setAvatar(long avatar) {
		this.avatar = avatar;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getQq_openid() {
		return qq_openid;
	}

	public void setQq_openid(String qq_openid) {
		this.qq_openid = qq_openid;
	}

	public String getWeixin_openid() {
		return weixin_openid;
	}

	public void setWeixin_openid(String weixin_openid) {
		this.weixin_openid = weixin_openid;
	}

	public String getReal_name() {
		return real_name;
	}

	public void setReal_name(String real_name) {
		this.real_name = real_name;
	}

	public String getAvatar_url() {
		return avatar_url;
	}

	public void setAvatar_url(String avatar_url) {
		this.avatar_url = avatar_url;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public float getAllAmount() {
		return allAmount;
	}

	public void setAllAmount(float allAmount) {
		this.allAmount = allAmount;
	}

	public Date getUse_time() {
		return use_time;
	}

	public void setUse_time(Date use_time) {
		this.use_time = use_time;
	}

	public int getIs_receive() {
		return is_receive;
	}

	public void setIs_receive(int is_receive) {
		this.is_receive = is_receive;
	}
}
