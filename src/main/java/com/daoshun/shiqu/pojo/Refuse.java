package com.daoshun.shiqu.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "t_refuse")
public class Refuse {
		// 单位id
		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		@Column(name = "id", length = 20, nullable = false)
		private long id;
		
		// 点菜单位
		@Column(name = "content", length = 500)
		private String content;

		public long getId() {
			return id;
		}

		public void setId(long id) {
			this.id = id;
		}

		public String getContent() {
			return content;
		}

		public void setContent(String content) {
			this.content = content;
		}

}
