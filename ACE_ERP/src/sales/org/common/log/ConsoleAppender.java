/*******************************************************************************
 * 1.클래스   명 : ConsoleAppender.java
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

import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;

import org.apache.log4j.Layout;
import org.apache.log4j.config.PropertyGetter;
import org.apache.log4j.config.PropertyGetter.PropertyCallback;

/**
 * <pre>
 *  
 *   [사용방법]
 *  
 * </pre>
 */
public class ConsoleAppender extends org.apache.log4j.ConsoleAppender implements PropertyCallback {
	private String encoding = "EUC-KR";

	public ConsoleAppender() {
		super();
	}

	public ConsoleAppender(Layout layout) {
		super(layout);
	}

	public ConsoleAppender(Layout layout, String target) {
		super(layout, target);
	}

	public void activateOptions() {
		PropertyGetter.getProperties(this, this, null);
		setEncoding();
	}

	public void foundProperty(Object obj, String prefix, String name, Object value) {
		if (name != null && name.equals("encoding")) {
			this.encoding = (String) value;
			setEncoding();
		}
	}

	private void setEncoding() {
		if (target.equals(SYSTEM_OUT)) {
			try {
				setWriter(new OutputStreamWriter(System.out, this.encoding));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		} else {
			setWriter(new OutputStreamWriter(System.err));
		}
	}
}
