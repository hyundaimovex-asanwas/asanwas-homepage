/*******************************************************************************
 * 1.Ŭ����   �� : ConsoleAppender.java
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

import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;

import org.apache.log4j.Layout;
import org.apache.log4j.config.PropertyGetter;
import org.apache.log4j.config.PropertyGetter.PropertyCallback;

/**
 * <pre>
 *  
 *   [�����]
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
