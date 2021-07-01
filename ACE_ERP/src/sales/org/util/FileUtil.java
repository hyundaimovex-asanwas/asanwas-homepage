/*********************************************************************************
 *  하나은행 데이터 이전
 * *******************************************************************************
 *
 * 1.클래스   명 : FileUtil.java
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


import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import sales.org.common.log.LogUtil;

public class FileUtil {

	private FileUtil() {
	}

	public static StringBuffer read(String fileName)throws IOException {
		File fileIn = new File(fileName);
		FileInputStream inStream = null;
		StringBuffer out = new StringBuffer();

		if (!fileIn.exists()) {
			fileIn = new File(searchFile(fileName));
		}
		if (fileIn.exists()) {
			try {
				inStream = new FileInputStream(fileIn); // Create the input stream.
				int bytesRead = 0; // Number of bytes read.
				byte[] buffer = new byte[1024]; // 1k byte input buffer.
	
				while ((bytesRead = inStream.read(buffer)) != -1) { // Read until EOF.
					out.append(new String(buffer));
					buffer = new byte[1024];
				}
			} catch (IOException e) {
				throw e;
			} finally {
				if(inStream  != null){try{inStream.close(); }catch(IOException e){}}
			}
		}else{
			LogUtil.debug(fileName+" is Not Exists!!");
		}
		return out;
	}
	
	public static void copy(String fileName, String targetName)throws IOException {
		File fileIn = new File(fileName);
		File fileOut = new File(targetName);
		FileInputStream inStream = null;
		FileOutputStream outStream = null;

		if (!fileIn.exists()) {
			fileIn = new File(fileName);
		}
		if (fileIn.exists()) {
			try {
				inStream = new FileInputStream(fileIn); // Create the input stream.
				outStream = new FileOutputStream(fileOut); // Create the output stream.
				int bytesRead = 0; // Number of bytes read.
				byte[] buffer = new byte[1024]; // 1k byte input buffer.
	
				while ((bytesRead = inStream.read(buffer)) != -1) { // Read until EOF.
					outStream.write(buffer, 0, bytesRead); // Write the bytes to the output.
					buffer = new byte[1024];
				}
			} catch (IOException e) {
				throw e;
			} finally {
				if(inStream  != null){try{inStream.close(); }catch(IOException e){}}
				if(outStream != null){try{outStream.close();}catch(IOException e){}}
			}
		}else{
			LogUtil.debug(fileName+" is Not Exists!!");
		}
	}

	public static void move(String fileName, String targetName)throws IOException {
		copy(fileName,targetName);
		delete(fileName);
	}

	public static void delete(String fileName){
		File fileIn = new File(fileName);

		if (!fileIn.exists()) {
			fileIn = new File(searchFile(fileName));
		}
		if (fileIn.exists()) {
			try {
				fileIn.delete();
			} catch (Exception e) {
				LogUtil.debug(fileName+" is Not Exists!!");
			}
		}
	}
	
	public static String searchFile(String fileName) {
		String filePath;
		String retFile = "";
		String tmpFile = "";
		if (fileName.endsWith(File.separator)) {
			filePath = fileName;
		} else {
			filePath = fileName.substring(0, fileName.lastIndexOf(File.separator));
		}
		tmpFile = fileName.substring(filePath.length() + 1);
		File searchDir = new File(filePath);
		String[] dirList = searchDir.list();
		for (int i = 0; i < dirList.length; i++) {
			if (tmpFile.equalsIgnoreCase(dirList[i])) {
				retFile = filePath + dirList[i];
			}
		}
		return retFile;
	}
}