package edu.taru.common;

/**
 * 常量
 * @author zhangfan
 *
 */
public class Constants {

	/**
	 * 当前版本
	 */
	public static final String VERSION = "1.0.0";
	
	/**
	 * 编码方式
	 */
	public static final String UTF_8 = "UTF-8";
	
	/**
	 * 成功，真，是
	 */
	public final static String TRUE = "true";
	
	/**
	 * 失败，假，否
	 */
	public final static String FALSE = "false";
	
	/**
	 * 错误
	 */
	public final static String ERROR = "error";
	
	/**
	 * 默认密码
	 */
	public final static String DEFAULT_PASSWORD = "123456";
	
	/**
	 * 页面刷新标识
	 */
	public final static String PAGE_REFRESH = "pageRefresh";
	
	/*
	 * 登录常量
	 */
	public final static String UPDATE_PASSWORD_SUCCESS = "密码修改成功";
	public final static String UPDATE_PASSWORD_FAILE = "密码修改失败";
	public final static String LOGINPASSWORD_WRONG = "登录密码错误";
	public final static String LOGINNAME_NOT_EXIST = "登录名不存在";
	public final static String LOGINNAME_PASSWORD_NOT_EMPTY = "登录名、密码不能为空";
	public final static String CAPTCHA_ERROR = "验证码错误";
	public final static String CAPTCHA_NULL = "验证码为空";
	public final static String LOGINING_EXIST = "该账户在其他设备已登录，是否强制登录，并下线其他设备？";
	public final static String LOGINING_EXIST_AGAIN = "该账户在其他设备已登录，请重新登录！";
	
	/*
	 * 操作常量
	 */
	public final static String OPERATION_FAILE = "操作失败，请重试！";
	public final static String NOT_DELETE_OWN = "为什么要删除自己？";
	public final static String SERVICE_ERROR = "服务器忙，请返回重试";
	public final static String REPEAT_AUTH = "请不要重复认证！";
	
	/*
	 * 上传图片常量
	 */
	public final static String UPLOAD_AVATAR_URI_TEMP = "${app.root}/WEB-INF/tmp/user_avatar"; //头像临时文件路径
	public final static String UPLOAD_AUTH_URI_TEMP = "${app.root}/WEB-INF/tmp/user_auth"; //认证照片临时文件路径
	public final static String UPLOAD_SHOW_URI_TEMP = "${app.root}/WEB-INF/tmp/show"; //发布信息展示图片临时文件路径
	public final static String DATA_BUFFER_SIZE = "8192"; //数据缓冲区大小,建议设置为8192
	public final static String TEMP_FILE_SIZE_MAX = "20000"; //临时文件的最大数量
	public final static String IMAGE_SIZE_MAX = "102400"; //图片大小上限，单位：字节
	public final static String UPLOAD_AVATAR_URI = "/upload/images/user_avatar/"; //头像保存路径
	public final static String UPLOAD_AUTH_URI = "/upload/images/user_auth/"; //认证照片保存路径
	public final static String UPLOAD_SHOW_URI = "/upload/images/show/"; //发布信息展示图片保存路径
	public final static String IMAGE_UPLOAD_PNG = ".png"; //png图片后缀
	public final static String FILE_SIZE_INVALID = "文件大小不符合规定";
	public final static String IMAGE_FORMAT_ERROR = "请上传png，bmp，jpeg格式的图片";
	public final static String EMPTY_FILE = "空文件";
	public final static String IMAGE_UPLOAD_SUCCESS = "图片上传成功";
	public final static String IMAGE_UPLOAD_FAILE = "图片上传失败";
	public final static String DEFAULT_AVATAT = "default_avatar.png"; //设置默认头像
	
	/*
	 * 收藏
	 */
	public final static String ERROR_UNDEFINED = "未知错误";
	public final static String LOGIN_FALSE = "你还没有登录，请先登录！";
	public final static String COLLECTION_SUCCESS = "收藏成功";
	public final static String UNDOCOLLECTION_SUCCESS = "取消收藏成功";
	public final static String COLLECTION_REPEAT = "您已经收藏过本商品，请不要重复收藏！";
	public final static String NOEXIST_OR_DELETED = "该商品不存在，或被删除！";
	
	/*
	 * 商品排序
	 */
	public final static String [][] GOODS_SORT = {{"collection", "收藏 ⇧"}, {"time", "时间 ⇧"}};
}
