/*********************************************************************************
 *  하나은행 데이터 이전
 * *******************************************************************************
 *
 * 1.클래스   명 : BillrateDAO.java
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