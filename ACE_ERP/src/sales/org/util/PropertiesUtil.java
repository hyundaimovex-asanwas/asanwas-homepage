/*******************************************************************************
 * 1.클래스   명 : PropertiesUtil.java
 * 2.클래스 개요 :
 * 3.관련 테이블 :
 * 4.관련 클래스 :
 * 5.관련 페이지 :
 * 6.작   성  자 : 이태선
 * 7.작 성 일 자 : 2004-03-30
 * 8.수 정 일 자 :
 * . <날짜>       ; <수정 내용> (<개발자명>)
 * . 2004-03-24      ;
 * @author 이태선
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
	 * 컨피그 파일 리드
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
	 * 클래스 패스에서 컨피그 파일을찾아서 돌려주는 메소드
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
		//실제 파일이 존재 하는 곳 체크 최초로 찾은것만 유료
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
