/**
 * 작성일 : 2005-01-25
 * 작성자 : csangsu
 * Copy Write : Hyundai Merchant Marine Co. LTD.
 */
package com.hmm.ejb.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;

import com.hmm.ejb.util.EJBStringUtil;

/**
 * <PRE>
 * Filename : FileUtil.java
 * Class    : ns.common.util.FileUtil
 * Comment  : 파일에 관련된 utility class
 * </PRE>
 * @version   1.0
 * @author    JeonHyunChul
*/

public class FileUtil {
	/**
	* FileTool생성자
	*/
	public FileUtil() {

	}

	/**
	* r_file 내용을 outputstream에 쓴다.
	* @param String  r_file	원본 파일명
	* @param OutputStream outputstream	복사될 Stream
	* @return boolean 		성공하면 true, 실패하면 false리턴
	*/
	public static boolean dumpFile(String r_file, OutputStream outputstream) {
		byte abyte0[] = new byte[4096];
		boolean flag = true;
		FileInputStream fiStream = null;
		try {
			fiStream = new FileInputStream(r_file);
			int i;
			while ((i = fiStream.read(abyte0)) != -1)
				outputstream.write(abyte0, 0, i);

			fiStream.close();
		} catch (Exception ex) {
			try {
				if (fiStream != null)
					fiStream.close();
			} catch (Exception ex1) {
			}
			flag = false;
		} finally {
			try {
				if (fiStream != null)
					fiStream.close();
			} catch (Exception ex2) {
			}
		}

		return flag;
	}

	/**
	* r_file 을 w_file로 복사한다.
	* @param String  r_file	원본 파일명
	* @param String  w_file	생성 파일명
	* @return boolean 		성공하면 true, 실패하면 false리턴
	*/
	public static boolean copyFile(String r_file, String w_file) {
		boolean flag = true;
		FileOutputStream foStream = null;
		String saveDirectory = null;
		File dir = null;

		try {

			int iIndex = w_file.lastIndexOf("/");

			if (iIndex > 0) {
				saveDirectory =
					w_file.substring(0, (w_file.lastIndexOf("/") + 1));

				dir =
					new File(
						EJBStringUtil.replaceString(saveDirectory, "//", "/"));

				if (!dir.isDirectory()) {
					dir.mkdirs();
				}

			}

			foStream = new FileOutputStream(w_file);
			flag = dumpFile(r_file, foStream);
			foStream.close();
		} catch (Exception ex) {
			try {
				if (foStream != null)
					foStream.close();
			} catch (Exception ex1) {
			}

			flag = false;
		} finally {
			try {
				if (foStream != null)
					foStream.close();
			} catch (Exception ex2) {
			}
		}
		return flag;
	}

	/**
	* r_file 내용을 outputstream에 쓴다.
	* @param String  r_file	원본 파일명
	* @param OutputStream outputstream	복사될 Stream
	*/
	public static void dumpFile(File r_file, OutputStream outputstream)
		throws Exception {
		byte abyte0[] = new byte[4096];

		FileInputStream fistream = null;

		try {
			fistream = new FileInputStream(r_file);
			int i;
			while ((i = fistream.read(abyte0)) != -1)
				outputstream.write(abyte0, 0, i);
			fistream.close();
		} catch (Exception ex) {
			try {
				if (fistream != null)
					fistream.close();
			} catch (Exception ex1) {
			}
			throw ex;
		} finally {
			try {
				if (fistream != null)
					fistream.close();
			} catch (Exception ex2) {
			}
		}
	}

	/**
	* r_file 을 w_file로 복사한다.
	* @param String  r_file	원본 파일명
	* @param String  w_file	생성 파일명
	*/
	public static void copyFile(File r_file, File w_file) throws Exception {

		FileOutputStream fostream = null;

		try {
			fostream = new FileOutputStream(w_file);
			dumpFile(r_file, fostream);
			fostream.close();
		} catch (Exception ex) {
			try {
				if (fostream != null)
					fostream.close();
			} catch (Exception ex1) {
			}
			throw ex;
		} finally {
			try {
				if (fostream != null)
					fostream.close();
			} catch (Exception ex2) {
			}
		}
	}

	public static long getDirSize(String fpath) {
		long totalsize = 0;
		File f = new File(fpath);
		long Size = 0;
		int i = 0;

		// 예외 처리.
		if (f == null)
			return 0;

		// 예외 처리.
		if (!f.isDirectory()) {
			if (f.isFile())
				return f.length();
			else
				return 0;
		}

		int filecount = java.lang.reflect.Array.getLength(f.list());

		File[] flist = new File[filecount];

		flist = f.listFiles();
		while (i < filecount) {
			if (flist[i].isDirectory()) {
				totalsize = totalsize + getDirSize(flist[i].getPath());
			} else if (flist[i].isFile()) {
				totalsize = totalsize + flist[i].length();
			}
			i++;
		}
		return totalsize;
	}

	/**
	* 파일을 삭제한다.
	* @param String  aDelFileName	원본 파일명
	* @return boolean 파일이 존재하지 않거나 디렉토리인 경우 false
	*/
	public static boolean deleteFile(String aDelFileName) throws Exception {
		try {
			File delFile = new File(aDelFileName);
			if (delFile.exists() == false || delFile.isDirectory() == true) {
				return false;
			}

			delFile.delete();
		} catch (Exception e) {
			throw e;
		}

		return true;
	}
}
