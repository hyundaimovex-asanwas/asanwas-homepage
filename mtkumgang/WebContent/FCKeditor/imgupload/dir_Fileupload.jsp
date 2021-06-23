<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.hmm.ejb.common.*" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ include file="dir_config.inc" %>

<%
	// 저장 폴더명
	String h_path = "";

	// 저장할 디렉토리 (절대경로)
	String savePath = g_path; // 저장할 디렉토리 (절대경로)

	String msg = "";

	int sizeLimit = 5 * 1024 * 1024 ; // 5메가까지 제한 넘어서면 예외발생

	try{
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit,"euc-kr",new DefaultFileRenamePolicy());
		Enumeration formNames = multi.getFileNames();  // 폼의 이름 반환

		h_path = multi.getParameter("h_path");

		savePath = savePath + h_path; // 저장할 디렉토리 (절대경로)
		//savePath = session.getServletContext().getRealPath(savePath);
		

		while(formNames.hasMoreElements()){
			String formName = (String)formNames.nextElement(); // 자료가 많을 경우엔 while 문을 사용
			String fileName = multi.getFilesystemName(formName); // 파일의 이름 얻기

			if(fileName == null) {   // 파일이 업로드 되지 않았을때
				msg = "이미지 업로드에 실패하였습니다. 다시 시도하세요.";
			} else {  // 파일이 업로드 되었을때
				msg = "이미지 업로드가 성공되었습니다.";
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
