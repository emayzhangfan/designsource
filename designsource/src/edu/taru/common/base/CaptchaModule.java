package edu.taru.common.base;

import java.awt.image.BufferedImage;

import javax.servlet.http.HttpSession;

import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import cn.apiclub.captcha.Captcha;
import cn.apiclub.captcha.backgrounds.GradiatedBackgroundProducer;
import cn.apiclub.captcha.gimpy.FishEyeGimpyRenderer;
import edu.taru.common.utils.Toolkit;

/**
 * 图片验证码模块
 * @author 张帆
 * @date 2016年3月28日
 */
@IocBean
@At("/captcha")
public class CaptchaModule {

	@At("/next")
    @Ok("raw:png")
    public BufferedImage next(HttpSession session, @Param("w") int w, @Param("h") int h) {
        if (w * h < 1) { //长或宽为0?重置为默认长宽.
            w = 120;
            h = 60;
        }
        Captcha captcha = new Captcha.Builder(w, h)
                                .addText().addBackground(new GradiatedBackgroundProducer())
//                                .addNoise(new StraightLineNoiseProducer()).addBorder()
                                .gimp(new FishEyeGimpyRenderer())
                                .build();
        String text = captcha.getAnswer();
        session.setAttribute(Toolkit.captcha_attr, text);
        return captcha.getImage();
    }
}
