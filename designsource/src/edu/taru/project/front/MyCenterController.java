package edu.taru.project.front;

import java.io.File;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.nutz.aop.interceptor.ioc.TransAop;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Files;
import org.nutz.mvc.Mvcs;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.AdaptBy;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.filter.CheckSession;
import org.nutz.mvc.impl.AdaptorErrorContext;
import org.nutz.mvc.upload.TempFile;
import org.nutz.mvc.upload.UploadAdaptor;

import edu.taru.common.Constants;
import edu.taru.common.utils.IdGen;
import edu.taru.common.utils.StringUtils;
import edu.taru.common.utils.Toolkit;
import edu.taru.project.admin.user.entity.User;
import edu.taru.project.admin.user.entity.UserAuth;
import edu.taru.project.admin.user.service.UserAuthService;
import edu.taru.project.admin.user.service.UserService;


@IocBean
@Ok("json")
@Filters(@By(type=CheckSession.class, args={"user", "/index"}))
public class MyCenterController extends IndexController {

	@Inject
	private UserService userService;
	
	@Inject
	private UserAuthService userAuthService;
	
	/**
	 * 个人信息保存
	 * 该方法需要拦截，判断是否存在session
	 * @param user
	 * @return
	 */
	@At(value={"/front/myInfoUpdate"})
	@Ok("redirect:/front/myCenterForm?userId=${obj }") //防止表单重复提交，应该重定向
	public Object save (@Param("..") User user, HttpSession session) {
		if (StringUtils.isNotBlank(user.getId())) { //修改个人信息
			boolean flag = userService.update(user);
			if (flag) {
				User entryptEmailUser = Toolkit.entryptEmail(userService.get(User.class, user.getId()));
				session.setAttribute("user", entryptEmailUser); //更新session
				//return myCenter(userService.get(User.class, user.getId()));
				return user.getId();
			}
				
		} 
		return error(Constants.SERVICE_ERROR); 
	}
	
	/**
	 * 上传头像
	 * @param id
	 * @param tf
	 * @param err
	 * @param request
	 * @param session
	 * @return
	 */
	@At("/front/uploadUserAvatar")
	@Ok("redirect:/front/myCenterForm?userId=${obj.id }") //防止表单重复提交，应该重定向
	@AdaptBy(type = UploadAdaptor.class, args = { Constants.UPLOAD_AVATAR_URI_TEMP, 
												   Constants.DATA_BUFFER_SIZE, 
												   Constants.UTF_8, 
												   Constants.TEMP_FILE_SIZE_MAX, 
												   Constants.IMAGE_SIZE_MAX} )
	public Object uploadUserAvatar (@Param("id") String id, @Param("avatar") TempFile tf, 
			 HttpServletRequest request, HttpSession session, AdaptorErrorContext err) {
		String msg = null;
        if (null != err && null != err.getAdaptorErr()) {
            msg = Constants.FILE_SIZE_INVALID;
        } else if (tf == null) {
            msg = Constants.EMPTY_FILE;
        } else if (!("image/png".equals(tf.getContentType()) || "image/bmp".equals(tf.getContentType()) || "image/jpeg".equals(tf.getContentType()))) {
        	msg = Constants.IMAGE_FORMAT_ERROR;
        } else {
        	ServletContext servletContext = request.getSession().getServletContext();
        	@SuppressWarnings("deprecation")
			boolean flag1 = Files.copy(tf.getFile(), new File(servletContext.getRealPath("/") 
        			+ Constants.UPLOAD_AVATAR_URI + id + Constants.IMAGE_UPLOAD_PNG));
        	if(flag1) {
        		User user = userService.get(User.class, id);
        		user.setAvatar(id + Constants.IMAGE_UPLOAD_PNG);//设置头像
        		User entryptEmailUser = Toolkit.entryptEmail(user);
				session.setAttribute("user", entryptEmailUser); //更新session
        		boolean flag2 = userService.update(user);
        		if(flag1 && flag2) 
        			msg = Constants.IMAGE_UPLOAD_SUCCESS; //上传成功，刷新页面
        	} 
        	else msg = Constants.IMAGE_UPLOAD_FAILE;
        }
        if (msg != null)
            Mvcs.getHttpSession().setAttribute("uploadAvatarMsg", msg);
        return (User) Mvcs.getHttpSession().getAttribute("user"); //适配器报错的话，其他参数都会是null
	}
	
	/**
	 * 认证页面跳转
	 * @param id
	 * @return
	 */
	@At("front/authenticationForm")
	public View authenticationForm (@Param("userId") String id) {
		User myself = userService.get(User.class, id);
		return authentication(myself);
	}
	
	/**
	 * 认证
	 * @param user
	 * @param tf
	 * @param err
	 * @param request
	 * @param session
	 * @return
	 */
	@At("/front/authentication")
	@Ok("redirect:/front/myCenterForm?userId=${obj.id }") //防止表单重复提交，应该重定向
	@Aop(TransAop.READ_COMMITTED)
	@AdaptBy(type = UploadAdaptor.class, args = { Constants.UPLOAD_AUTH_URI_TEMP, 
												   Constants.DATA_BUFFER_SIZE, 
												   Constants.UTF_8, 
												   Constants.TEMP_FILE_SIZE_MAX, 
												   Constants.IMAGE_SIZE_MAX} )
	public Object uploadUserAuth (@Param("..") User user, @Param("auth") TempFile tf, 
			HttpServletRequest request, HttpSession session, AdaptorErrorContext err) {
		User userSession = (User) Mvcs.getHttpSession().getAttribute("user");
		String msg = null;
        if (err != null && err.getAdaptorErr() != null) {
            msg = Constants.FILE_SIZE_INVALID;
            Mvcs.getHttpSession().setAttribute("uploadUserAuthMsg", msg);
            return authenticationForm(userSession.getId());
        } else if (tf == null) {
            msg = Constants.EMPTY_FILE;
            Mvcs.getHttpSession().setAttribute("uploadUserAuthMsg", msg);
            return authenticationForm(userSession.getId());
        } else if (!("image/png".equals(tf.getContentType()) || "image/bmp".equals(tf.getContentType()) || "image/jpeg".equals(tf.getContentType()))) {
        	msg = Constants.IMAGE_FORMAT_ERROR;
        	Mvcs.getHttpSession().setAttribute("uploadUserAuthMsg", msg);
            return authenticationForm(userSession.getId());
        } else {
        	User userNew = userService.get(User.class, user.getId());
        	if (userAuthService.countByUserId(user.getId()) == 0 && userNew.getStatus() == User.NO_AUTH) { //首次认证
	        	ServletContext servletContext = request.getSession().getServletContext();
	        	@SuppressWarnings("deprecation")
				boolean flag1 = Files.copy(tf.getFile(), new File(servletContext.getRealPath("/") 
	        			+ Constants.UPLOAD_AUTH_URI + user.getId() + Constants.IMAGE_UPLOAD_PNG));
	        	if(flag1) {
	        		/*
	        		 * 创建一个认证记录
	        		 */
	        		String userAuthId = IdGen.uuid();
	        		UserAuth userAuth = new UserAuth(userAuthId, user.getId(), user.getId() + Constants.IMAGE_UPLOAD_PNG, UserAuth.NO_AUTH, new Date());
	        		UserAuth uaReturn = userAuthService.save(userAuth);//保存userAuth
	        		/*
	        		 * 设置用户状态为 待认证2 并保存
	        		 */
	        		userNew.setCardId(user.getCardId());
	        		userNew.setName(user.getName());
	        		userNew.setSex(user.getSex());
	        		userNew.setStatus(User.WAIT_AUTH); //待认证2
	        		boolean flag2 = userService.update(userNew);
	        		if(flag1 && (null != uaReturn) && flag2) {
	        			msg = Constants.IMAGE_UPLOAD_SUCCESS; //上传成功
	        			User entryptEmailUser = Toolkit.entryptEmail(userNew);
						session.setAttribute("user", entryptEmailUser);  //更新session
	        		}
	        	} 
	        	else {
	        		msg = Constants.IMAGE_UPLOAD_FAILE;
	        		Mvcs.getHttpSession().setAttribute("uploadUserAuthMsg", msg);
	                return authenticationForm(userSession.getId());
	        	} 
        	} else if (userNew.getStatus() == User.DOWN_AUTH) { //驳回用户再次认证
        		ServletContext servletContext = request.getSession().getServletContext();
	        	@SuppressWarnings("deprecation")
				boolean flag1 = Files.copy(tf.getFile(), new File(servletContext.getRealPath("/") 
	        			+ Constants.UPLOAD_AUTH_URI + user.getId() + Constants.IMAGE_UPLOAD_PNG));
	        	if(flag1) {
	        		/*
	        		 * 修改认证记录
	        		 */
	        		UserAuth userAuth = userAuthService.findByUserId(user.getId());
	        		userAuth.setStatus(UserAuth.NO_AUTH);
	        		userAuth.setCreateDate(new Date());
	        		boolean flag2_1 = userAuthService.update(userAuth);
	        		/*
	        		 * 设置用户状态为 待认证2 并保存
	        		 */
	        		userNew.setCardId(user.getCardId());
	        		userNew.setName(user.getName());
	        		userNew.setSex(user.getSex());
	        		userNew.setStatus(User.WAIT_AUTH); //待认证2
	        		boolean flag2_2 = userService.update(userNew);
	        		if(flag1 && flag2_1 && flag2_2) {
	        			msg = Constants.IMAGE_UPLOAD_SUCCESS; //上传成功
	        			User entryptEmailUser = Toolkit.entryptEmail(userNew);
	        			session.setAttribute("user", entryptEmailUser); //更新session
	        		}
	        	} 
	        	else {
	        		msg = Constants.IMAGE_UPLOAD_FAILE;
	        		Mvcs.getHttpSession().setAttribute("uploadUserAuthMsg", msg);
	                return authenticationForm(userSession.getId());
	        	}
        	}
        	else {
        		msg = Constants.REPEAT_AUTH; //重复认证，保证数据库数据唯一性
        		Mvcs.getHttpSession().setAttribute("uploadUserAuthMsg", msg);
                return authenticationForm(userSession.getId());
        	}
        }
        return userSession;
	}
}
