<%@ page info="tempfile upload"  contentType="text/html;charset=euc-kr" %>
<%@ page import="kr.co.imjk.util.Config"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.io.*"%>
<%@ page import="Account.common.HDConstant"%>
<%
	request.setCharacterEncoding("euc-kr");   //�̰� �����ϴϱ�....�ѱ��� �������� �ʳ�...

	String mode				= Util.getString(request.getParameter("mode"),"");
	String realFileName		= Util.getString(request.getParameter("realFileName"),"");
	String virtualFileName	= Util.getString(request.getParameter("virtualFileName"),"");
	
	/*	
	System.out.println("a010050_deleteFile::");                       
	System.out.println("mode::"+mode);                       //�Է� ���  
	System.out.println("realFileName::"+realFileName);       //ȭ��� ���ϸ�  ���ÿ����� �ѱ۸��� �������� ����. 
	System.out.println("virtualFileName::"+virtualFileName); //�ý��� ���ϸ�
    */
	
	String saveDir 	=  HDConstant.FILE_UPLOAD_PATH_ACCOUNT+"vend/";	//���� ÷������ ���� ���
	//String saveDir 	=  "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Pms/file/pu010/";	//���� ÷������ ���� ���
	//String saveDir 	=  "/asanwas/����/pu010/";	//���� ÷������ ���� ���

	//String saveDir 		=  "C:\\fileupTest/";	//����......

	String FilePath = saveDir+virtualFileName;
	File del = new File(FilePath);			
	
	//System.out.println("FilePath::"+FilePath); //���
				
	if (del.exists()){
		//System.out.println("�����ֿ�::"); //���
		del.delete();
		//System.out.println("����::"); //���	
		out.println("<script language=\"javascript\">");
		out.println("<!--");
		out.println("parent.delResult('"+realFileName+"','"+virtualFileName+"')");
		out.println("//-->");
		out.println("</script>");
		out.flush();
		//out.close();
	}else{
		System.out.println("���Ͼ���::"); //���
	}
%>
	<script language="javascript">
	<!--
    // ���� ���� ������ ���� ��Ͽ��� �����ϱ� ����  ȣ��
		//parent.delResult();
	//-->
	</script>