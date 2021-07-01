/*********************************************************************************
 *  �ϳ����� ������ ����
 * *******************************************************************************
 *
 * 1.Ŭ����   �� : BillrateDAO.java
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
 * *****************************************************************************
 */

package sales.org.util;

import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintStream;

public class OutUtil {
	private OutUtil() {
	}

	static BufferedWriter out = null;

	static PrintStream print = null;

	public static void setOutFile(String filename, String characterSet) {
		setOutFile(filename, characterSet, false);
	}

	public static void setOutFile(String filename, boolean append) {
		setOutFile(filename, "KSC5601", append);
	}

	public static void setOutFile(String filename) {
		setOutFile(filename, "KSC5601", false);
	}

	public static void setOutFile(String filename, String characterSet,
			boolean append) {
		try {
			BufferedWriter out = new BufferedWriter(new OutputStreamWriter(System.out, StringUtil.nvl(characterSet, "ISO8859-1")));
			print = new PrintStream(new BufferedOutputStream(new FileOutputStream(filename, append)));
		} catch (Exception e) {
			System.out.println("error:" + e.getMessage());
		}
	}

	public static void println(String str) {
		try {
			print.println(str);
			print.flush();
		} catch (Exception e) {
			System.out.println("error:" + e.getMessage());
		}
	}

	public static void close() {
		if (out != null) {
			try {
				out.close();
			} catch (IOException e) {
			}
		}
	}
}