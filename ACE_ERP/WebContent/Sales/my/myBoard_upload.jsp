<%--
  - �ۼ���: ������
  - ����: 2006.04.17
  - ���۱� ǥ��: IMJ Korea
  - ����: ����� - ���� �ڸ�Ʈ�� �Խ��� ���� ���ε�
--%>
<%@ page info="tempfile upload"  contentType="text/html;charset=euc-kr" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="kr.co.imjk.util.Config"%>
<%@ page import="kr.co.imjk.util.HtmlUtil"%>
<%@ page import="kr.co.imjk.util.Util"%>
<%@ page import="kr.co.imjk.util.StringUtil"%>
<%@ page import="kr.co.imjk.board.dao.TourGalleryBoard"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.util.*"%>
<%
  
	String saveDir 		=  Config.getInstance().getProperty("imjkmd","memGalleryUpload");
	saveDir = saveDir+Util.getToMonth()+"/";
	int maxSize = 5*1024*1024;

   //÷������ �뷮 üũ
    if(request.getContentLength() > maxSize ){

		out.println("<script language=\"javascript\">");
		out.println("<!--");
		out.println("alert('�ִ�뷮�� 5M�� ���� �� �����ϴ�.');");
		out.println("//-->");
		out.println("</script>");
		out.flush();
		out.close();

		return;
	}	
    //÷������ �뷮 üũ
 
	MultipartRequest multi = new MultipartRequest(request, saveDir, maxSize,"euc-kr", new DefaultFileRenamePolicy());
	String mode					   		= Util.getString(multi.getParameter("mode"),"");
	String realFileName    		= Util.getString(multi.getParameter("realFileName"),"");
	String virtualFileName    = Util.getString(multi.getParameter("virtualFileName"),"");
	


		String fileName = new String();
		String fileSystemName = new String();
		Enumeration enum = multi.getFileNames();
		  File systemFile = null;
		  File tempFile = null;
		  int sepIndex = 0;
		  String fileExtName = "";
			String virtualName = "";
			
			while(enum.hasMoreElements())
			{  
				fileName = (String)enum.nextElement();
				fileSystemName = multi.getFilesystemName(fileName);
			  //Ȯ���� �̾Ƴ���
			  sepIndex = fileSystemName.indexOf(".");
		    if(sepIndex>0){
		        fileExtName =  fileSystemName.substring(sepIndex);
		    }
			  //������Ʈ �� ���� ã��
			  systemFile = new File(saveDir+fileSystemName);
		    //������Ʈ �� ������ ������..
		    //�����̸� 
		    String fileSeq = Util.getSeqText();
		  
			  if(systemFile.exists()){
			      //���� �̸��� ��������ȣ�� �����Ѵ�.
			      virtualName = fileSeq+fileExtName;
			      tempFile = new File(saveDir+virtualName);
			      //������ �����Ѵ�.
			      systemFile.renameTo(tempFile);
			  }
			}
%>
	<script language="javascript">
	<!--
	
	  
    //���Ͼ��ε� 1
    // ���� ��Ͽ� �߰�
		parent.addFileList('<%= realFileName%>','<%= virtualName%>');
	//-->
	</script>
