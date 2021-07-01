<%@ page contentType="text/html;charset=MS949"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%@ page import="kr.co.imjk.util.Util"%>

<%
int sizeLimit = 5 * 1024 * 1024 ;	

String photo_save_path = "D:/myWorks/HDAsan/WebContent/Sales/file/testfiles";


	//객체 생성과 동시에 업로드.. 췟;; 확인해보니 아래와같다. 2008-09-09 심동현
	//MultipartRequest 를 사용할 경우 파일이름을 변경하여 업로드할 수 없다ㅏ.
	//왜냐하면 multi 생성시 바로 업로드 되기 때문이다.
	//따라서 업로드 후에 파일명을 변경하는 방법을 선택해야 한다.
	MultipartRequest multi	= new MultipartRequest(request, photo_save_path, sizeLimit,"KSC5601", new DefaultFileRenamePolicy());

	//BSAphoto 컴포넌트에서 던져주는 폼의 파일명 name="filename"
//	String filename 	= Util.getString(multi.getParameter("filename"),"");	
	String filename 	= Util.getString(multi.getFilesystemName("fileName"),"");

%>
<%=filename%>