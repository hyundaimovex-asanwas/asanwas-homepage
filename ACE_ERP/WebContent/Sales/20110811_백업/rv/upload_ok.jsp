<%@ page contentType="text/html;charset=MS949"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%@ page import="kr.co.imjk.util.Util"%>

<%
int sizeLimit = 5 * 1024 * 1024 ;	

String photo_save_path = "D:/myWorks/HDAsan/WebContent/Sales/file/testfiles";


	//��ü ������ ���ÿ� ���ε�.. �X;; Ȯ���غ��� �Ʒ��Ͱ���. 2008-09-09 �ɵ���
	//MultipartRequest �� ����� ��� �����̸��� �����Ͽ� ���ε��� �� ���٤�.
	//�ֳ��ϸ� multi ������ �ٷ� ���ε� �Ǳ� �����̴�.
	//���� ���ε� �Ŀ� ���ϸ��� �����ϴ� ����� �����ؾ� �Ѵ�.
	MultipartRequest multi	= new MultipartRequest(request, photo_save_path, sizeLimit,"KSC5601", new DefaultFileRenamePolicy());

	//BSAphoto ������Ʈ���� �����ִ� ���� ���ϸ� name="filename"
//	String filename 	= Util.getString(multi.getParameter("filename"),"");	
	String filename 	= Util.getString(multi.getFilesystemName("fileName"),"");

%>
<%=filename%>