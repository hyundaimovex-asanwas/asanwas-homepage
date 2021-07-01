<%@ page contentType="text/html;charset=MS949"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%@ page import="kr.co.imjk.util.Util"%>

<%
int sizeLimit = 5 * 1024 * 1024 ;	

String photo_save_path = "D:/myWorks/HDAsan/WebContent/Sales/file/testfiles";


	//°´Ã¼ »ý¼º°ú µ¿½Ã¿¡ ¾÷·Îµå.. ®X;; È®ÀÎÇØº¸´Ï ¾Æ·¡¿Í°°´Ù. 2008-09-09 ½Éµ¿Çö
	//MultipartRequest ¸¦ »ç¿ëÇÒ °æ¿ì ÆÄÀÏÀÌ¸§À» º¯°æÇÏ¿© ¾÷·ÎµåÇÒ ¼ö ¾ø´Ù¤¿.
	//¿Ö³ÄÇÏ¸é multi »ý¼º½Ã ¹Ù·Î ¾÷·Îµå µÇ±â ¶§¹®ÀÌ´Ù.
	//µû¶ó¼­ ¾÷·Îµå ÈÄ¿¡ ÆÄÀÏ¸íÀ» º¯°æÇÏ´Â ¹æ¹ýÀ» ¼±ÅÃÇØ¾ß ÇÑ´Ù.
	MultipartRequest multi	= new MultipartRequest(request, photo_save_path, sizeLimit,"KSC5601", new DefaultFileRenamePolicy());

	//BSAphoto ÄÄÆ÷³ÍÆ®¿¡¼­ ´øÁ®ÁÖ´Â ÆûÀÇ ÆÄÀÏ¸í name="filename"
//	String filename 	= Util.getString(multi.getParameter("filename"),"");	
	String filename 	= Util.getString(multi.getFilesystemName("fileName"),"");

%>
<%=filename%>