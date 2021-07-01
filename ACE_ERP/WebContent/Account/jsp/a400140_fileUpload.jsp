

<%@ page info="tempfile upload"  contentType="text/html;charset=euc-kr" %>

<!-- 파일 업로드 처리를 위한 MultipartRequest 객체를 임포트 -->
<%@ page import="com.oreilly.servlet.MultipartRequest" %> 
<!-- 파일 중복처리 객체 임포트 -->
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
  
 //업로드 경로 
 String uploadPath = "C:\\";
 //String uploadPath =  HDConstant.FILE_UPLOAD_PATH_FILE;
 
 //int size = 10*1024*1024;        // 업로드 파일 최대 크기 지정
 
 int size = 1*1024*1024;		   //맥스 사이즈 설정 1M

 //System.out.println("::filesize::"+request.getContentLength());
 //System.out.println("::request.getInputStream()::"+request.getInputStream());

//첨부파일 용량 체크
 if(request.getContentLength() > size ){

	out.println("<script language=\"javascript\">");
	out.println("<!--");
	out.println("alert('최대용량은 1M를 넘을 수 없습니다.');");
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
	out.println("alert('동일 파일명이 존재합니다2.');");
	out.println("//-->");
	out.println("</script>");
	out.flush();
	out.close();
	//  return;
  }
  */

  String filename="";
  //파일 업로드. 폼에서 가져온 인자값을 얻기 위해request 객체 전달, 
  //업로드 경로, 파일 최대 크기, 한글처리, 파일 중복처리(중복처리로 뒤에 숫자가 붙음.)
  MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "euc-kr", new DefaultFileRenamePolicy());
  //System.out.println("uploadPath::"+uploadPath+"::size::"+size);
  
  //업로드한 파일들을 Enumeration 타입으로 반환
  //Enumeration형은 데이터를 뽑아올때 유용한 인터페이스 Enumeration객체는 java.util 팩키지에 정의 되어있으므로
  //java.util.Enumeration을 import 시켜야 한다.  
  Enumeration files = multi.getFileNames();

   
  // 업로드한 파일들의 이름을 얻어옴
  String file = (String)files.nextElement();
  
  //System.out.println("file::"+file);
  filename = multi.getFilesystemName(file);
  
  //System.out.println("filename::"+filename);
   
%>

<script language="javascript">

	<!--
    //파일업로드 1
    //파일 목록에 추가
    	parent.fnAddFileList('<%= filename%>');
	//-->
</script>