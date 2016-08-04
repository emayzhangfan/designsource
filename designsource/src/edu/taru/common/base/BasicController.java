package edu.taru.common.base;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.random.R;

public class BasicController {

	@Inject protected EmailService emailService;

	protected byte[] emailKEY = R.sg(24).next().getBytes();
	
}
