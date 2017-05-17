package com.daoshun.shiqu.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "t_menu_unit")
public class MenuUnit {
		// 单位id
		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		@Column(name = "unit_id", length = 20, nullable = false)
		private long unit_id;
		
		// 点菜单位
		@Column(name = "unit_name", length = 500)
		private String unit_name;

		public long getUnit_id() {
			return unit_id;
		}

		public void setUnit_id(long unit_id) {
			this.unit_id = unit_id;
		}

		public String getUnit_name() {
			return unit_name;
		}

		public void setUnit_name(String unit_name) {
			this.unit_name = unit_name;
		}
}
