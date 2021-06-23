/**
 * <PRE>
 * Filename : FileDownLoad.java
 * Class    : com.abn.util.FileDownLoad
 * Comment  : 파일 다운로드 기능
 * </PRE>
 * @version   1.0	
 * @author    최수용
 */
package com.hmm.ejb.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

/**
 * @ FileDownLoad.java	2004. 9. 21.
 *
 * Copyright Samsung Networks Ltd All Rights Reserved.
 *
 * This software is the proprietary information of Samsung Networks Ltd  
 * Use is subject to license terms.
 *
 */
public class FileDownLoad
{
	HttpServletResponse response;
	ServletOutputStream out;
	File downFile;
	String fileName = "";
	String contentType = "";
    
	/**
	 * fileName이 null이면 기본적으로 downFile의 파일이름으로 다운로드 함.
	 * contentType이 null이면 기본적으로 application/x-msdownload로 정해짐.
	 * 
	 * @param response 사용자의 response
	 * @param downFile 다운될 원본파일의 절대경로 File객체
	 * @param fileName 다운될 파일명
	 * @param contentType 다운될 파일의 MIME 타입
	 * @throws IOException
	 */
	public FileDownLoad(HttpServletResponse response, File downFile, 
			String fileName, String contentType) 
	throws IOException
	{
		response.reset();
		this.response = response;
		out = response.getOutputStream();
		this.downFile = downFile;
		this.fileName = fileName;
		this.contentType = contentType;

		String convertedNm = new String(fileName.getBytes("EUC-KR"),"8859_1");

		if(contentType == null)
		{
			response.setContentType("application/x-msdownload");
		}
		if(fileName == null)
		{
			fileName = downFile.getName();
		}
		response.setHeader("Content-Disposition","attachment; filename="+convertedNm);
	}
    
	/**
	 * 파일 다운받기
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	public void download() throws FileNotFoundException, IOException
	{
		byte[] buffer = new byte[1024];
		int byteData = 0;
		int offset = 0;


		FileInputStream in = new FileInputStream(downFile);
        
		while( (byteData = in.read(buffer, offset, buffer.length)) != -1)
		{
			out.write(buffer, 0, byteData);
		}
		in.close();
	}
}
