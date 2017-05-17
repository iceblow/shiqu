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
 * 文件表
 * 
 * @author wangcl
 */
@Entity
@Table(name = "t_file_info")
public class FileInfo {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", length = 20, nullable = false)
	private long id;
	// 文件名
	@Column(name = "file_name", length = 500)
	private String file_name;
	// 文件相对路径
	@Column(name = "file_url", length = 500)
	private String file_url;
	// 文件类型 1普通文件 2广告图 3安卓apk
	@Column(name = "file_type", length = 2)
	private int file_type;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public String getFile_url() {
		return file_url;
	}

	public void setFile_url(String file_url) {
		this.file_url = file_url;
	}

	public int getFile_type() {
		return file_type;
	}

	public void setFile_type(int file_type) {
		this.file_type = file_type;
	}
}
