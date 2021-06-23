/*
 * @ SystemProperties.java
 *
 * TYPE : ���� Ŭ���� (com)

 * ���� : key �� �´� value�� �����Ѵ�.
 *
 *
 * ���� :
 *    1) import util.*; �� import ��Ų��.
 *    2) getProperties(key, defaultValue) �� �̿��Ͽ� �ʿ��� ���� ���� �޴´�.
 *
 * ���� :
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
