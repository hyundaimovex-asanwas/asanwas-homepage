/*******************************************************************************
 * 1.클래스   명 : LogUtil.java
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
 * @version 1.0 2006-02-02
 ******************************************************************************/

package sales.org.common.log;

import java.io.PrintWriter;
import java.io.StringWriter;

import org.apache.log4j.Logger;

public class LogUtil{
	private LogUtil(){}
  protected static Logger logger = Logger.getLogger(LogUtil.class.getName());
	
  public static void debug(String str) {
		logger.debug(str);	
	}

	public static void warn(String str) {
		logger.warn(str);
	}

	public static void info(String str) {
		logger.info(str);
	}

	public static void error(String str) {
		logger.error(str);
	}

	public static void fatal(String str) {
		logger.fatal(str);
	}

	public static void debug(Object o, String str) {

		logger.debug(getClassName(o) + ":" + str);	
	}

	public static void warn(Object o, String str) {
		logger.warn(getClassName(o) + ":" + str);
	}

	public static void info(Object o, String str) {
		logger.info(getClassName(o) + ":" + str);
	}

	public static void error(Object o, String str) {
		logger.error(getClassName(o) + ":" + str);
	}

	public static void fatal(Object o, String str) {
		logger.fatal(getClassName(o) + ":" + str);
	}

	public static void error(Throwable e) {
		logger.error(e.getMessage());
		logger.error(toTrace(e));
	}

	public static void error(String str,Throwable e) {
		logger.error(str + ":" + e.getMessage());
		logger.error(str + ":" + toTrace(e));
	}

	public static void error(Object o,Throwable e) {
		logger.error(getClassName(o) + ":" + e.getMessage());
		logger.error(getClassName(o) + ":" + toTrace(e));
	}

	public static void error(Object o, String str,Throwable e) {
		logger.error(getClassName(o) + ":" + str + ":" + e.getMessage());
		logger.error(getClassName(o) + ":" + str + ":" + toTrace(e));
	}

	private static String getClassName(Object o) {
		String fullName = o.getClass().getName();
		String name = null;
		if(o != null) {
			int lastIndex = fullName.lastIndexOf(".");
			if(lastIndex == -1) {
				name = fullName;
			}else {
				name = fullName.substring(lastIndex+1);
			}
		}
		return name;
	}
	
	private static String toTrace(Throwable e) {
		StringWriter sw = new StringWriter();
		PrintWriter pw = new PrintWriter(sw);
		e.printStackTrace(pw);
		pw.flush();
		return sw.toString();
	}
}