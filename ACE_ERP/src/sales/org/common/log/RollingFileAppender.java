/*******************************************************************************
 * 1.Ŭ����   �� : RollingFileAppender.java
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
