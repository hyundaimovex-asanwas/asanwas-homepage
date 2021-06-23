/**
 * �ۼ��� : 2005-01-25
 * �ۼ��� : csangsu
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
 * Comment  : ���Ͽ� ���õ� utility class
 * </PRE>
 * @version   1.0
 * @author    JeonHyunChul
*/

public class FileUtil {
	/**
	* FileTool������
	*/
	public FileUtil() {

	}

	/**
	* r_file ������ outputstream�� ����.
	* @param String  r_file	���� ���ϸ�
	* @param OutputStream outputstream	����� Stream
	* @return boolean 		�����ϸ� true, �����ϸ� false����
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
	* r_file �� w_file�� �����Ѵ�.
	* @param String  r_file	���� ���ϸ�
	* @param String  w_file	���� ���ϸ�
	* @return boolean 		�����ϸ� true, �����ϸ� false����
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
	* r_file ������ outputstream�� ����.
	* @param String  r_file	���� ���ϸ�
	* @param OutputStream outputstream	����� Stream
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
	* r_file �� w_file�� �����Ѵ�.
	* @param String  r_file	���� ���ϸ�
	* @param String  w_file	���� ���ϸ�
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

		// ���� ó��.
		if (f == null)
			return 0;

		// ���� ó��.
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
	* ������ �����Ѵ�.
	* @param String  aDelFileName	���� ���ϸ�
	* @return boolean ������ �������� �ʰų� ���丮�� ��� false
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
