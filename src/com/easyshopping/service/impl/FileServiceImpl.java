/*
 * 

 * 
 */
package com.easyshopping.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import com.easyshopping.FileInfo;
import com.easyshopping.FileInfo.FileType;
import com.easyshopping.FileInfo.OrderType;
import com.easyshopping.Setting;
import com.easyshopping.plugin.StoragePlugin;
import com.easyshopping.service.FileService;
import com.easyshopping.service.PluginService;
import com.easyshopping.util.FreemarkerUtils;
import com.easyshopping.util.SettingUtils;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.builder.CompareToBuilder;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;

/**
 * Service - 文件
 * 
 * 
 * @version 1.0
 */
@Service("fileServiceImpl")
public class FileServiceImpl implements FileService, ServletContextAware {

	/** servletContext */
	private ServletContext servletContext;

	@Resource(name = "taskExecutor")
	private TaskExecutor taskExecutor;
	@Resource(name = "pluginServiceImpl")
	private PluginService pluginService;

	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	/**
	 * 添加上传任务
	 * 
	 * @param storagePlugin
	 *            存储插件
	 * @param path
	 *            上传路径
	 * @param tempFile
	 *            临时文件
	 * @param contentType
	 *            文件类型
	 */
	private void addTask(final StoragePlugin storagePlugin, final String path, final File tempFile, final String contentType) {
		taskExecutor.execute(new Runnable() {
			public void run() {
				try {
					storagePlugin.upload(path, tempFile, contentType);
				} finally {
					FileUtils.deleteQuietly(tempFile);
				}
			}
		});
	}

	public boolean isValid(FileType fileType, MultipartFile multipartFile) {
		if (multipartFile == null) {
			return false;
		}
		Setting setting = SettingUtils.get();
		if (setting.getUploadMaxSize() != null && setting.getUploadMaxSize() != 0 && multipartFile.getSize() > setting.getUploadMaxSize() * 1024L * 1024L) {
			return false;
		}
		String[] uploadExtensions;
		if (fileType == FileType.flash) {
			uploadExtensions = setting.getUploadFlashExtensions();
		} else if (fileType == FileType.media) {
			uploadExtensions = setting.getUploadMediaExtensions();
		} else if (fileType == FileType.file) {
			uploadExtensions = setting.getUploadFileExtensions();
		} else {
			uploadExtensions = setting.getUploadImageExtensions();
		}
		if (ArrayUtils.isNotEmpty(uploadExtensions)) {
			return FilenameUtils.isExtension(multipartFile.getOriginalFilename(), uploadExtensions);
		}
		return false;
	}

	public String upload(FileType fileType, MultipartFile multipartFile, boolean async) {
		if (multipartFile == null) {
			return null;
		}
		Setting setting = SettingUtils.get();
		String uploadPath;
		if (fileType == FileType.flash) {
			uploadPath = setting.getFlashUploadPath();
		} else if (fileType == FileType.media) {
			uploadPath = setting.getMediaUploadPath();
		} else if (fileType == FileType.file) {
			uploadPath = setting.getFileUploadPath();
		} else {
			uploadPath = setting.getImageUploadPath();
		}
		try {
			Map<String, Object> model = new HashMap<String, Object>();
			model.put("uuid", UUID.randomUUID().toString());
			String path = FreemarkerUtils.process(uploadPath, model);
			String destPath = path + UUID.randomUUID() + "." + FilenameUtils.getExtension(multipartFile.getOriginalFilename());

			for (StoragePlugin storagePlugin : pluginService.getStoragePlugins(true)) {
				File tempFile = new File(System.getProperty("java.io.tmpdir") + "/upload_" + UUID.randomUUID() + ".tmp");
				if (!tempFile.getParentFile().exists()) {
					tempFile.getParentFile().mkdirs();
				}
				multipartFile.transferTo(tempFile);
				if (async) {
					addTask(storagePlugin, destPath, tempFile, multipartFile.getContentType());
				} else {
					try {
						storagePlugin.upload(destPath, tempFile, multipartFile.getContentType());
					} finally {
						FileUtils.deleteQuietly(tempFile);
					}
				}
				return storagePlugin.getUrl(destPath);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public String upload(FileType fileType, MultipartFile multipartFile) {
		return upload(fileType, multipartFile, false);
	}

	public String uploadLocal(FileType fileType, MultipartFile multipartFile) {
		if (multipartFile == null) {
			return null;
		}
		Setting setting = SettingUtils.get();
		String uploadPath;
		if (fileType == FileType.flash) {
			uploadPath = setting.getFlashUploadPath();
		} else if (fileType == FileType.media) {
			uploadPath = setting.getMediaUploadPath();
		} else if (fileType == FileType.file) {
			uploadPath = setting.getFileUploadPath();
		} else {
			uploadPath = setting.getImageUploadPath();
		}
		try {
			Map<String, Object> model = new HashMap<String, Object>();
			model.put("uuid", UUID.randomUUID().toString());
			String path = FreemarkerUtils.process(uploadPath, model);
			String destPath = path + UUID.randomUUID() + "." + FilenameUtils.getExtension(multipartFile.getOriginalFilename());
			File destFile = new File(servletContext.getRealPath(destPath));
			if (!destFile.getParentFile().exists()) {
				destFile.getParentFile().mkdirs();
			}
			multipartFile.transferTo(destFile);
			return destPath;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<FileInfo> browser(String path, FileType fileType, OrderType orderType) {
		if (path != null) {
			if (!path.startsWith("/")) {
				path = "/" + path;
			}
			if (!path.endsWith("/")) {
				path += "/";
			}
		} else {
			path = "/";
		}
		Setting setting = SettingUtils.get();
		String uploadPath;
		if (fileType == FileType.flash) {
			uploadPath = setting.getFlashUploadPath();
		} else if (fileType == FileType.media) {
			uploadPath = setting.getMediaUploadPath();
		} else if (fileType == FileType.file) {
			uploadPath = setting.getFileUploadPath();
		} else {
			uploadPath = setting.getImageUploadPath();
		}
		String browsePath = StringUtils.substringBefore(uploadPath, "${");
		browsePath = StringUtils.substringBeforeLast(browsePath, "/") + path;

		List<FileInfo> fileInfos = new ArrayList<FileInfo>();
		if (browsePath.indexOf("..") >= 0) {
			return fileInfos;
		}
		for (StoragePlugin storagePlugin : pluginService.getStoragePlugins(true)) {
			fileInfos = storagePlugin.browser(browsePath);
			break;
		}
		if (orderType == OrderType.size) {
			Collections.sort(fileInfos, new SizeComparator());
		} else if (orderType == OrderType.type) {
			Collections.sort(fileInfos, new TypeComparator());
		} else {
			Collections.sort(fileInfos, new NameComparator());
		}
		return fileInfos;
	}

	private class NameComparator implements Comparator<FileInfo> {
		public int compare(FileInfo fileInfos1, FileInfo fileInfos2) {
			return new CompareToBuilder().append(!fileInfos1.getIsDirectory(), !fileInfos2.getIsDirectory()).append(fileInfos1.getName(), fileInfos2.getName()).toComparison();
		}
	}

	private class SizeComparator implements Comparator<FileInfo> {
		public int compare(FileInfo fileInfos1, FileInfo fileInfos2) {
			return new CompareToBuilder().append(!fileInfos1.getIsDirectory(), !fileInfos2.getIsDirectory()).append(fileInfos1.getSize(), fileInfos2.getSize()).toComparison();
		}
	}

	private class TypeComparator implements Comparator<FileInfo> {
		public int compare(FileInfo fileInfos1, FileInfo fileInfos2) {
			return new CompareToBuilder().append(!fileInfos1.getIsDirectory(), !fileInfos2.getIsDirectory()).append(FilenameUtils.getExtension(fileInfos1.getName()), FilenameUtils.getExtension(fileInfos2.getName())).toComparison();
		}
	}

}