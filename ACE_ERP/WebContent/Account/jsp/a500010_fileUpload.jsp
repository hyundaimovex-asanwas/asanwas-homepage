

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
<%@ page import="omsm.common.HDConstant"%>

<%

 //���ε� ��� 
 //String uploadPath = "C:\\";
 String uploadPath =  HDConstant.FILE_UPLOAD_PATH_FILE;
 
 //int size = 10*1024*1024;        // ���ε� ���� �ִ� ũ�� ����
 
 
 int size = 2*1024*1024;						//�ƽ� ������ ����

//÷������ �뷮 üũ
 if(request.getContentLength() > size ){

	out.println("<script language=\"javascript\">");
	out.println("<!--");
	out.println("alert('�ִ�뷮�� 2M�� ���� �� �����ϴ�.');");
	out.println("//-->");
	out.println("</script>");
	out.flush();
	out.close();

	return;
 }	
 
  String filename="";
  //���� ���ε�. ������ ������ ���ڰ��� ��� ����request ��ü ����, 
  //���ε� ���, ���� �ִ� ũ��, �ѱ�ó��, ���� �ߺ�ó��
  MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "euc-kr", new DefaultFileRenamePolicy());
  
  //System.out.println("uploadPath::"+uploadPath+"::size::"+size);
  
  //���ε��� ���ϵ��� Enumeration Ÿ������ ��ȯ
  //Enumeration���� �����͸� �̾ƿö� ������ �������̽� Enumeration��ü�� java.util ��Ű���� ���� �Ǿ������Ƿ�
  //java.util.Enumeration�� import ���Ѿ� �Ѵ�.
  Enumeration files = multi.getFileNames();
   
  // ���ε��� ���ϵ��� �̸��� ����
  String file = (String)files.nextElement();
  filename = multi.getFilesystemName(file);
  
  //System.out.println("filename::"+filename);
   
%>

<script language="javascript">
	<!--
	
	  
    //���Ͼ��ε� 1
    // ���� ��Ͽ� �߰�
    	parent.fnAddFileList('<%= filename%>');
	//-->
	</script>