/*
 * @ SystemProperties.java
 *
 * TYPE : 공통 클래스 (com)

 * 설명 : key 에 맞는 value를 리턴한다.
 *
 *
 * 사용법 :
 *    1) import util.*; 로 import 시킨다.
 *    2) getProperties(key, defaultValue) 를 이용하여 필요한 값을 리턴 받는다.
 *
 * 참고 :
 *
 *
 *
 */

package kr.co.imjk.util;

import java.io.InputStream;
import java.util.Properties;

public class SystemProperties{

	public SystemProperties() {

	}

	public String getProperties(String key, String defValue){
		InputStream is = getClass().getResourceAsStream("/woorisam.properties");
		Properties props = new Properties();
		try {
		    props.load(is);
		}
		catch (Exception e) {
		    System.err.println("Can't read the properties file. " +
		        "Make sure System.properties is in the CLASSPATH");
		    return defValue;
		}

		return props.getProperty(key,defValue);
	}
}
