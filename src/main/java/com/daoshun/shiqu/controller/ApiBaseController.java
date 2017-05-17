/**
 * 
 */
package com.daoshun.shiqu.controller;

import java.io.File;
import java.util.Date;
import java.util.Iterator;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.coobird.thumbnailator.Thumbnails;

import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.service.BaseService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * 接口控制器基类
 * 
 * @author qiuch
 *
 */
@Controller
public class ApiBaseController {

	// 压缩高度
	private int compressHeight = 200;
	// 压缩宽度
	private int compressWidth = 200;
	// 压缩质量
	private float compressQuaity = 0.9f;
	// gson,设置时间格式，去除html标签
	Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").disableHtmlEscaping().create();
	// ObjectMapper mapper = new ObjectMapper().setSerializationInclusion(Include.NON_NULL).setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).setTimeZone(TimeZone.getTimeZone("GMT+8:00"))
	// .setVisibility(PropertyAccessor.FIELD, Visibility.ANY).disable(SerializationFeature.FAIL_ON_EMPTY_BEANS);
	@Resource(name = "baseService")
	private BaseService baseService;

	// public ApiBaseController() {
	// mapper.setSerializationInclusion(Include.NON_NULL);
	// DateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	// mapper.setDateFormat( new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
	// }
	/**
	 * @param request
	 *            * @param type 文件类型
	 * @return 保存后的文件id
	 */
	protected long getFileId(HttpServletRequest request, int type) {
		return getFileId(request, false, type);
	}

	/**
	 * @param request
	 * @param isCompressed
	 *            是否压缩
	 * @param type
	 *            文件类型
	 * @return 保存后的文件id
	 */
	protected long getFileId(HttpServletRequest request, boolean isCompressed, int type) {
		long fileid = 0;
		// 创建一个通用的多部分解析器
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
		// 判断 request 是否有文件上传,即多部分请求
		if (multipartResolver.isMultipart(request)) {
			// 转换成多部分request
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			// 取得request中的所有文件名
			Iterator<String> iter = multiRequest.getFileNames();
			try {
				while (iter.hasNext()) {
					// 取得上传文件
					MultipartFile file = multiRequest.getFile(iter.next());
					if (file != null) {
						// 取得当前上传文件的文件名称
						String myFileName = file.getOriginalFilename();
						// 如果名称不为“”,说明该文件存在，否则说明该文件不存在
						if (!CommonUtils.isEmptyString(myFileName)) {
							String savePath = CommonUtils.getTimeFormat(new Date(), "yyyyMMdd") + File.separator;
							String path = CommonUtils.getLocationPath() + savePath;
							// 定义上传路径
							CommonUtils.checkPath(path);
							File localOriginFile = new File(path + myFileName);
							file.transferTo(localOriginFile);
							String extension = myFileName.substring(myFileName.lastIndexOf(".")).toLowerCase();
							String filename = CommonUtils.getTimeFormat(new Date(), "yyyyMMddhhmmssSSS") + "_" + (int) (Math.random() * 100) + "_small" + extension;
							if (isCompressed) {
								Thumbnails.of(path + myFileName).size(compressWidth, compressHeight).keepAspectRatio(false).outputQuality(compressQuaity).toFile(path + filename);
							} else {
								filename = filename.replace("_small", "");
								localOriginFile.renameTo(new File(path + filename));
							}
							fileid = baseService.uploadComplete(savePath, filename, type);
						}
					}
				}
			} catch (Exception e) {
				return fileid;
			}
		}
		return fileid;
	}

	/**
	 * @param file
	 *            * @param type 文件类型
	 * @return 保存后的文件id
	 */
	protected long getFileId(MultipartFile file, int type) {
		return getFileId(file, false, type);
	}

	/**
	 * @param file
	 * @param isCompressed
	 *            是否压缩 * @param type 文件类型
	 * @return 保存后的文件id
	 */
	protected long getFileId(MultipartFile file, boolean isCompressed, int type) {
		long fileid = 0;
		try {
			if (file != null) {
				// 取得当前上传文件的文件名称
				String myFileName = file.getOriginalFilename();
				// 如果名称不为“”,说明该文件存在，否则说明该文件不存在
				if (!CommonUtils.isEmptyString(myFileName)) {
					String savePath = CommonUtils.getTimeFormat(new Date(), "yyyyMMdd") + File.separator;
					String path = CommonUtils.getLocationPath() + savePath;
					// 定义上传路径
					CommonUtils.checkPath(path);
					File localOriginFile = new File(path + myFileName);
					file.transferTo(localOriginFile);
					String extension = myFileName.substring(myFileName.lastIndexOf(".")).toLowerCase();
					String filename = CommonUtils.getTimeFormat(new Date(), "yyyyMMddhhmmssSSS") + "_" + (int) (Math.random() * 100) + "_small" + extension;
					if (isCompressed) {
						Thumbnails.of(path + myFileName).size(compressWidth, compressHeight).keepAspectRatio(false).outputQuality(compressQuaity).toFile(path + filename);
					} else {
						filename = filename.replace("_small", "");
						localOriginFile.renameTo(new File(path + filename));
					}
					fileid = baseService.uploadComplete(savePath, filename, type);
				}
			}
		} catch (Exception e) {
			return fileid;
		}
		return fileid;
	}

	public int getCompressHeight() {
		return compressHeight;
	}

	public void setCompressHeight(int compressHeight) {
		this.compressHeight = compressHeight;
	}

	public int getCompressWidth() {
		return compressWidth;
	}

	public void setCompressWidth(int compressWidth) {
		this.compressWidth = compressWidth;
	}

	public float getCompressQuaity() {
		return compressQuaity;
	}

	public void setCompressQuaity(float compressQuaity) {
		this.compressQuaity = compressQuaity;
	}
}
