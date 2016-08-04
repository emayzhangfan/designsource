package edu.taru;

import org.nutz.mvc.annotation.ChainBy;
import org.nutz.mvc.annotation.Encoding;
import org.nutz.mvc.annotation.IocBy;
import org.nutz.mvc.annotation.Localization;
import org.nutz.mvc.annotation.Modules;
import org.nutz.mvc.annotation.SessionBy;
import org.nutz.mvc.annotation.SetupBy;
import org.nutz.mvc.impl.session.NopSessionProvider;
import org.nutz.mvc.ioc.provider.ComboIocProvider;

@ChainBy(args="mvc/project-mvc-chain.js")
@Localization(value="msg/", defaultLocalizationKey="zh-CN")
@SetupBy(value=MainSetup.class)
@IocBy(type=ComboIocProvider.class, args={"*js", "ioc/",
								           "*anno", "edu.taru",
								           "*tx", 
										   "*org.nutz.integration.quartz.QuartzIocLoader"})
@Modules(scanPackage=true)
@Encoding(input="UTF-8",output="UTF-8")
@SessionBy(NopSessionProvider.class)
public class MainModule {

}
