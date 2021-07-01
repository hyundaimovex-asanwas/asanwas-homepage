/*******************************************************************************
 * 1.Ŭ����   �� : PropertiesUtil.java
 * 2.Ŭ���� ���� :
 * 3.���� ���̺� :
 * 4.���� Ŭ���� :
 * 5.���� ������ :
 * 6.��   ��  �� : ���¼�
 * 7.�� �� �� �� : 2004-03-30
 * 8.�� �� �� �� :
 * . <��¥>       ; <���� ����> (<�����ڸ�>)
 * . 2004-03-24      ;
 * @author ���¼�
 * @version 1.0 2004-03-30
 ******************************************************************************/

package sales.org.util;

import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;

public class PropertiesUtil {
	private PropertiesUtil() {
	}

	/*****************************************************************************
	 * ���Ǳ� ���� ����
	 ****************************************************************************/
	public static Properties getProperties(String confFileName) {
		Properties Props = null;
		File confFile = null;
		FileInputStream confStream = null;
		try {
			confFile = new File(confFileName);
			confStream = new FileInputStream(confFile);
			Props = new Properties();
			Props.load(confStream);
		} catch (Exception e) {
			try {
				if (confStream != null) {
					confStream.close();
				}
			} catch (Exception es) {
				es.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				if (confStream != null) {
					confStream.close();
				}
			} catch (Exception es) {
				es.printStackTrace();
			}
		}
		return Props;
	}

	/*****************************************************************************
	 * Ŭ���� �н����� ���Ǳ� ������ã�Ƽ� �����ִ� �޼ҵ�
	 ****************************************************************************/
	public static String getConfFile(String FileName) {
		String classPath = System.getProperty("java.class.path");
		int tempcounter = 0;
		int tempmaker = 0;
		String tempstring = null;
		for (tempcounter = 0; tempcounter < classPath.length(); tempcounter++) {
			if (classPath.charAt(tempcounter) == File.pathSeparatorChar) {
				tempmaker = tempmaker + 1;
			}
		}
		String[] classlist = new String[tempmaker];
		for (tempcounter = 0; tempcounter < tempmaker; tempcounter++) {
			if (tempcounter == 0) {
				classlist[tempcounter] = classPath.substring(0, classPath.indexOf(File.pathSeparator));
				tempstring = classPath.substring(classPath.indexOf(File.pathSeparator) + 1, classPath.length());
			} else {
				classlist[tempcounter] = tempstring.substring(0, tempstring.indexOf(File.pathSeparator));
				tempstring = tempstring.substring(tempstring.indexOf(File.pathSeparator) + 1, tempstring.length());
			}
		}
		tempstring = null;
		//���� ������ ���� �ϴ� �� üũ ���ʷ� ã���͸� ����
		for (tempcounter = 0; tempcounter < tempmaker; tempcounter++){
			File filecheck = new File(classlist[tempcounter] + File.separator + FileName);
			if (filecheck.exists()) {
				tempstring = filecheck.getAbsolutePath();
				break;
			}
		}
		if (StringUtil.isNull(tempstring)) {
			tempstring = FileName;
		}
		return tempstring;
	}
}
