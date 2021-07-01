/**
 * <PRE>
 * Filename : FileDownLoad.java
 * Class    : com.abn.util.FileDownLoad
 * Comment  : ���� �ٿ�ε� ���
 * </PRE>
 * @version   1.0	
 * @author    �ּ���
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
	 * fileName�� null�̸� �⺻������ downFile�� �����̸����� �ٿ�ε� ��.
	 * contentType�� null�̸� �⺻������ application/x-msdownload�� ������.
	 * 
	 * @param response ������� response
	 * @param downFile �ٿ�� ���������� ������ File��ü
	 * @param fileName �ٿ�� ���ϸ�
	 * @param contentType �ٿ�� ������ MIME Ÿ��
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
	 * ���� �ٿ�ޱ�
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
