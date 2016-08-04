package edu.taru.common.utils;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;

import org.nutz.lang.Lang;
import org.nutz.lang.util.NutMap;
import org.nutz.log.Log;
import org.nutz.log.Logs;

import edu.taru.project.admin.user.entity.User;

public class Toolkit {

	public static final String HASH_ALGORITHM = "SHA-1";
	public static final int HASH_INTERATIONS = 1024;
	public static final int SALT_SIZE = 8;

	/**
	 * 验证密码
	 * 
	 * @param plainPassword
	 *            明文密码
	 * @param password
	 *            密文密码
	 * @return 验证成功返回true
	 */
	public static boolean validatePassword(String plainPassword, String password) {
		byte[] salt = Encodes.decodeHex(password.substring(0, 16));
		byte[] hashPassword = Digests.sha1(plainPassword.getBytes(), salt,
				HASH_INTERATIONS);
		return password.equals(Encodes.encodeHex(salt)
				+ Encodes.encodeHex(hashPassword));
	}

	/**
	 * 生成安全的密码，生成随机的16位salt并经过1024次 sha-1 hash
	 */
	public static String entryptPassword(String plainPassword) {
		byte[] salt = Digests.generateSalt(SALT_SIZE);
		byte[] hashPassword = Digests.sha1(plainPassword.getBytes(), salt,
				HASH_INTERATIONS);
		return Encodes.encodeHex(salt) + Encodes.encodeHex(hashPassword);
	}

	/**
	 * 隐藏邮箱 邮箱显示为 3*******0@qq.com
	 * 
	 * @param user
	 * @return
	 */
	public static User entryptEmail(User user) {
		String email = user.getEmail();
		if (null != email) {
			String[] splitEmail = email.split("@");
			char[] c = splitEmail[0].toCharArray();
			for (int i = 1; i < (splitEmail[0].length() - 1); i++) {
				c[i] = '*';
			}
			String before_A = String.valueOf(c);
			String entryptEmail = before_A + "@" + splitEmail[1];
			user.setEmail(entryptEmail); // 隐藏邮箱
		}
		user.setPassword("******"); // 隐藏密码
		return user;
	}

	/**
	 * 获取用户真实IP地址，不使用request.getRemoteAddr();的原因是有可能用户使用了代理软件方式避免真实IP地址,
	 * 
	 * 可是，如果通过了多级反向代理的话，X-Forwarded-For的值并不止一个，而是一串IP值，究竟哪个才是真正的用户端的真实IP呢？
	 * 答案是取X-Forwarded-For中第一个非unknown的有效IP字符串。
	 * 
	 * 如：X-Forwarded-For：192.168.1.110, 192.168.1.120, 192.168.1.130,
	 * 192.168.1.100
	 * 
	 * 用户真实IP为： 192.168.1.110
	 * 
	 * @param request
	 * @return
	 */
	public static String getIpAddress(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	public static final Log log = Logs.get();

	public static String captcha_attr = "nutz_captcha";

	public static boolean checkCaptcha(String expected, String actual) {
		if (expected == null || actual == null || actual.length() == 0
				|| actual.length() > 24)
			return false;
		return actual.equalsIgnoreCase(expected);
	}

	public static String passwordEncode(String password, String slat) {
		String str = slat + password + slat + password.substring(4);
		return Lang.digest("SHA-512", str);
	}

	private static final String Iv = "\0\0\0\0\0\0\0\0";
	private static final String Transformation = "DESede/CBC/PKCS5Padding";

	public static String _3DES_encode(byte[] key, byte[] data) {
		SecretKey deskey = new SecretKeySpec(key, "DESede");
		IvParameterSpec iv = new IvParameterSpec(Iv.getBytes());
		try {
			Cipher c1 = Cipher.getInstance(Transformation);
			c1.init(Cipher.ENCRYPT_MODE, deskey, iv);
			byte[] re = c1.doFinal(data);
			return Lang.fixedHexString(re);
		} catch (Exception e) {
			log.info("3DES FAIL?", e);
			e.printStackTrace();
		}
		return null;
	}

	public static String _3DES_decode(byte[] key, byte[] data) {
		SecretKey deskey = new SecretKeySpec(key, "DESede");
		IvParameterSpec iv = new IvParameterSpec(Iv.getBytes());
		try {
			Cipher c1 = Cipher.getInstance(Transformation);
			c1.init(Cipher.DECRYPT_MODE, deskey, iv);
			byte[] re = c1.doFinal(data);
			return new String(re);
		} catch (Exception e) {
			log.debug("BAD 3DES decode", e);
		}
		return null;
	}

	public static NutMap kv2map(String kv) {
		NutMap re = new NutMap();
		if (kv == null || kv.length() == 0 || !kv.contains("="))
			return re;
		String[] tmps = kv.split(",");
		for (String tmp : tmps) {
			if (!tmp.contains("="))
				continue;
			String[] tmps2 = tmp.split("=", 2);
			re.put(tmps2[0], tmps2[1]);
		}
		return re;
	}

	public static byte[] hexstr2bytearray(String str) {
		byte[] re = new byte[str.length() / 2];
		for (int i = 0; i < re.length; i++) {
			int r = Integer.parseInt(str.substring(i * 2, i * 2 + 2), 16);
			re[i] = (byte) r;
		}
		return re;
	}
}
