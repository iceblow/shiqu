package com.daoshun.shiqu.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 代理商商店关注表
 * 
 * @author qiuch
 *
 */
@Entity
@Table(name = "t_agent_shop_relate")
public class AgentStoreRelate {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	
	@Column(name = "agentid", length = 20, nullable = false)
	private long agentid;
	
	@Column(name = "storeid", length = 20, nullable = false)
	private long storeid;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getAgentid() {
		return agentid;
	}

	public void setAgentid(long agentid) {
		this.agentid = agentid;
	}

	public long getStoreid() {
		return storeid;
	}

	public void setStoreid(long storeid) {
		this.storeid = storeid;
	}
	

}
