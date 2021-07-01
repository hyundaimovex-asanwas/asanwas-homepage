/*******************************************************************************
 * 1.클래스   명 : RollingFileAppender.java
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

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;

import org.apache.log4j.Layout;
import org.apache.log4j.config.PropertyGetter;
import org.apache.log4j.config.PropertyGetter.PropertyCallback;

public class RollingFileAppender extends org.apache.log4j.RollingFileAppender implements PropertyCallback {
	private String encoding = "EUC-KR";

	public RollingFileAppender() {
		super();
	}

	public RollingFileAppender(Layout layout, String filename) throws IOException {
		super(layout, filename);
	}

	public RollingFileAppender(Layout layout, String filename, boolean append) throws IOException {
		super(layout, filename, append);
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
		try {
			String file = getFile();
			if (file == null){
				return;
			}
			FileOutputStream fos = new FileOutputStream(file, true);
			OutputStreamWriter osw = new OutputStreamWriter(fos, this.encoding);
			setWriter(osw);
			setQWForFiles(new OutputStreamWriter(new FileOutputStream(file, true), this.encoding));

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
