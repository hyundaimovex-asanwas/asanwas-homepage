

<%@ page info="tempfile upload"  contentType="text/html;charset=euc-kr" %>

<!-- ���� ���ε� ó���� ���� MultipartRequest ��ü�� ����Ʈ -->
<%@ page import="com.oreilly.servlet.MultipartRequest" %> 
<!-- ���� �ߺ�ó�� ��ü ����Ʈ -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> 

<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="kr.co.imjk.util.HtmlUtil"%>
<%@ page import="kr.co.imjk.util.Util"%>
<%@ page import="kr.co.imjk.util.StringUtil"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="Account.common.HDConstant"%>

<%@ page import="kr.co.imjk.util.Config"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>



<%
  request.setCharacterEncoding("euc-kr");
  
 //���ε� ��� 
 String uploadPath = "C:\\";
 //String uploadPath =  HDConstant.FILE_UPLOAD_PATH_FILE;
 
 //int size = 10*1024*1024;        // ���ε� ���� �ִ� ũ�� ����
 
 int size = 1*1024*1024;		   //�ƽ� ������ ���� 1M

 //System.out.println("::filesize::"+request.getContentLength());
 //System.out.println("::request.getInputStream()::"+request.getInputStream());

//÷������ �뷮 üũ
 if(request.getContentLength() > size ){

	out.println("<script language=\"javascript\">");
	out.println("<!--");
	out.println("alert('�ִ�뷮�� 1M�� ���� �� �����ϴ�.');");
	out.println("//-->");
	out.println("</script>");
	out.flush();
	out.close();

	return;
 }

  //System.out.println("::uploadPath::"+uploadPath);
  
  /*
  File file_chk = new File(uploadPath);			 
	
  System.out.println("file_chk.exists()::"+file_chk.exists());
 	
  
  if (file_chk.exists()){
    out.println("<script language=\"javascript\">");
	out.println("<!--");
	out.println("alert('���� ���ϸ��� �����մϴ�2.');");
	out.println("//-->");
	out.println("</script>");
	out.flush();
	out.close();
	//  return;
  }
  */

  String filename="";
  //���� ���ε�. ������ ������ ���ڰ��� ��� ����request ��ü ����, 
  //���ε� ���, ���� �ִ� ũ��, �ѱ�ó��, ���� �ߺ�ó��(�ߺ�ó���� �ڿ� ���ڰ� ����.)
  MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "euc-kr", new DefaultFileRenamePolicy());
  //System.out.println("uploadPath::"+uploadPath+"::size::"+size);
  
  //���ε��� ���ϵ��� Enumeration Ÿ������ ��ȯ
  //Enumeration���� �����͸� �̾ƿö� ������ �������̽� Enumeration��ü�� java.util ��Ű���� ���� �Ǿ������Ƿ�
  //java.util.Enumeration�� import ���Ѿ� �Ѵ�.  
  Enumeration files = multi.getFileNames();

   
  // ���ε��� ���ϵ��� �̸��� ����
  String file = (String)files.nextElement();
  
  //System.out.println("file::"+file);
  filename = multi.getFilesystemName(file);
  
  //System.out.println("filename::"+filename);
   
%>

<script language="javascript">

	<!--
    //���Ͼ��ε� 1
    //���� ��Ͽ� �߰�
    	parent.fnAddFileList('<%= filename%>');
	//-->
</script>