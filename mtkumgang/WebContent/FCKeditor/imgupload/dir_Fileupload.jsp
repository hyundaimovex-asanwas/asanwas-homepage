<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.hmm.ejb.common.*" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ include file="dir_config.inc" %>

<%
	// ���� ������
	String h_path = "";

	// ������ ���丮 (������)
	String savePath = g_path; // ������ ���丮 (������)

	String msg = "";

	int sizeLimit = 5 * 1024 * 1024 ; // 5�ް����� ���� �Ѿ�� ���ܹ߻�

	try{
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit,"euc-kr",new DefaultFileRenamePolicy());
		Enumeration formNames = multi.getFileNames();  // ���� �̸� ��ȯ

		h_path = multi.getParameter("h_path");

		savePath = savePath + h_path; // ������ ���丮 (������)
		//savePath = session.getServletContext().getRealPath(savePath);
		

		while(formNames.hasMoreElements()){
			String formName = (String)formNames.nextElement(); // �ڷᰡ ���� ��쿣 while ���� ���
			String fileName = multi.getFilesystemName(formName); // ������ �̸� ���

			if(fileName == null) {   // ������ ���ε� ���� �ʾ�����
				msg = "�̹��� ���ε忡 �����Ͽ����ϴ�. �ٽ� �õ��ϼ���.";
			} else {  // ������ ���ε� �Ǿ�����
				msg = "�̹��� ���ε尡 �����Ǿ����ϴ�.";
			} // end if

		} //end while

	} catch(Exception e) {
	out.print(e);
	//	e.printStackTrace();
	} 
%>

<script>
	//alert("savePath: <%=savePath%> / <%=msg%>");
	alert("<%=msg%>");
	window.location.href = "dir_Filelist.jsp?h_path=<%=h_path%>";
</script>
