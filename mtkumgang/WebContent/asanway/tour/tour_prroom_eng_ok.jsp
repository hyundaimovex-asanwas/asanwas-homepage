<%--
  - 작성자: 이소연
  - 일자: 2006.06.13
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - PR Room 등록 및 수정 삭제
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="kr.co.imjk.board.dao.BestQuestion"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourPrRoomEng"%>
<%@ page import="kr.co.imjk.util.*"%>

<%
	String saveDir	= Util.getString(Config.getInstance().getProperty("imjkmd","adminPrroomUpload"),"");
    String fileRootDir = Util.getString(Config.getInstance().getProperty("imjkmd","adminPrroomLink"),"/asanway/upload/adminPrroomUpload/");	
	
	// Config.getInstance().getProperty("imjkmd","editUpload");
	
	int maxSize = 5*1024*1024;

   //첨부파일 용량 체크
    if(request.getContentLength() > maxSize ){

		out.println("<script language=\"javascript\">");
		out.println("<!--");
		out.println("alert('최대용량은 5M를 넘을 수 없습니다.');");
		out.println("//-->");
		out.println("</script>");
		out.flush();
		out.close();

		return;
	}

	MultipartRequest multi = new MultipartRequest(request, saveDir, maxSize,"euc-kr", new DefaultFileRenamePolicy());

	//request parameters
	int board_seq			= ParamUtil.getIntParameter(multi.getParameter("board_seq"));
	int attach_seq			= ParamUtil.getIntParameter(multi.getParameter("attach_seq"));
	int requestedPage	= ParamUtil.getIntParameter(multi.getParameter("requestedPage"));


	String title		 = ParamUtil.getReqParameter(multi.getParameter("title"));
	String content		 = ParamUtil.getReqParameter(multi.getParameter("content"));
	content				 = content.replaceAll("'", "\"");
	String cmd			 = ParamUtil.getReqParameter(multi.getParameter("cmd"));
	String part			 = ParamUtil.getReqParameter(multi.getParameter("part"));
	String keyword		 = ParamUtil.getReqParameter(multi.getParameter("keyword"));

	String saveDirName	 = ParamUtil.getReqParameter(multi.getParameter("saveDirName"));
	
	
	String realFileName01  = Util.getString(multi.getParameter("realFileName01"),"");  //썸네일
	String realFileName02  = Util.getString(multi.getParameter("realFileName02"),"");  //이미지
	String type_code       = Util.getString(multi.getParameter("type_code"),"");       // 1 : 이미지, 2: 동영상
	if (type_code == "1" || type_code.equals("1")){
	   content = "";
	}
	
	Tbrd_attach_file_de_bean file_bean = new Tbrd_attach_file_de_bean();
    
    
    //썸네일 + 이미지 공통  
    String fileName = new String();
	String fileSystemName = new String();
	
	Enumeration enum = multi.getFileNames();
	
	//썸네일 + 이미지 공통
	File systemFile = null;
	File tempFile = null;
	
	int sepIndex = 0;
	
	//썸네일 + 이미지 공통
	String fileExtName = "";
	String virtualName = "";

	String[] fileArry = new String[2];
	int i=0;
	while(enum.hasMoreElements())
	{  
	    
	   //(썸네일, 이미지를)배열로 받는다.
		fileName = (String)enum.nextElement();
		fileSystemName = Util.getString(multi.getFilesystemName(fileName),"");
		//out.println("fileSystemName=>"+fileSystemName);
		fileArry[i] = fileSystemName;
		
		i++;  //배열 증가
    }
		
    String fileSeq = Util.getSeqText();
	
    //썸네일 처리
    if(fileArry[1] != null && (!fileArry[1].equals("") || fileArry[1] != "")){
    	         
         //확장자 뽑아내기
         sepIndex = fileArry[1].indexOf(".");
         if(sepIndex>0){
               fileExtName =  fileArry[1].substring(sepIndex);
         }
         //업데이트 된 파일 찾기
         systemFile = new File(saveDir+fileArry[1]);
         //업데이트 된 파일이 있으면..
         //파일이름 
         //String fileSeq = Util.getSeqText();
          
         if(systemFile.exists()){
             //파일 이름을 시퀀스번호로 변경한다.
             virtualName = fileSeq+fileExtName;
             tempFile = new File(saveDir+virtualName);
             //서버에 저장한다.
             systemFile.renameTo(tempFile);
         
         	//첨부파일 정보 SET
         	file_bean.setThumbnail_real_name(fileRootDir+fileArry[1].trim());
         	file_bean.setThumbnail_virtual_name(fileRootDir+virtualName);
         	file_bean.setAttach_file_seq(attach_seq);
         	file_bean.setBoard_seq(board_seq);
         }
                 
    }
    
    //이미지 처리
    if(fileArry[0] != null && (!fileArry[0].equals("") || fileArry[0] != "")){
    	         
         //확장자 뽑아내기
         sepIndex = fileArry[0].indexOf(".");
         if(sepIndex>0){
               fileExtName =  fileArry[0].substring(sepIndex);
         }
         //업데이트 된 파일 찾기
         systemFile = new File(saveDir+fileArry[0]);
         //업데이트 된 파일이 있으면..
         //파일이름 
         //String fileSeq = Util.getSeqText();
          
         if(systemFile.exists()){
             //파일 이름을 시퀀스번호로 변경한다.
             virtualName = fileSeq+fileExtName;
             tempFile = new File(saveDir+virtualName);
             //서버에 저장한다.
             systemFile.renameTo(tempFile);
         
         	//첨부파일 정보 SET
         	file_bean.setReal_name(fileRootDir+fileArry[0].trim());
         	file_bean.setVirtual_name(fileRootDir+virtualName);
         	file_bean.setAttach_file_seq(attach_seq);
         	file_bean.setBoard_seq(board_seq);
         }
                 
    } 

    //out.println("썸네일:"+fileArry[1]+"<br>");
    //out.println("이미지:"+fileArry[0]+"<br>===============<br>");
    //out.println(file_bean.getThumbnail_virtual_name()+"<br>");
    //out.println(file_bean.getVirtual_name()+"<br>===============<br>");
    //out.println(file_bean.getThumbnail_real_name()+"<br>");
    //out.println(file_bean.getReal_name()+"<br>===============<br>");
    //out.println("fileSystemName:"+fileSystemName+"<br>");
    
    //if (file_bean.getThumbnail_real_name() == ""){
    //       out.println("썸네일 없음<br>");
    //}else{
    //       out.println("썸네일<br>");
    //}
    //
    //if (file_bean.getReal_name() == ""){
    //       out.println("이미지 없음<br>");
    //}else{
    //      out.println("이미지<br>");
    //}

    //변수 선언
    String board_type	= "10";
    
    //DAO
    TourPrRoomEng dao = new TourPrRoomEng();
    //DTO
    Tbrd_board_ma_bean bean = new Tbrd_board_ma_bean();
    
    bean.setBoard_seq(board_seq);
    bean.setTitle(title);
    bean.setContent(content);
    bean.setUser_id("admin");
    bean.setUser_name("관리자");
    bean.setType_code(type_code);
    
    int result = 0;
    
    if(cmd.equals("insert")){
    	result = dao.insert(bean, file_bean);
    }else if(cmd.equals("edit")){
    	if(fileArry[1].equals("") && fileArry[0].equals("") ){
    		//내용만 업데이트
    		result = dao.update(bean);
    	}else{
    		//내용과 첨부파일 업데이트
    		result = dao.update(bean, file_bean);
    	}
    }else if(cmd.equals("del")){
    
    	result = dao.delete(board_seq);
    	
    }else if(cmd.equals("attachDel")){
    
    	CommonBoard commonDao = new CommonBoard();
        result = commonDao.resetAttachFile(attach_seq);
        
    }
    
    
    if(result>0){
       if(cmd.equals("attachDel")){
%>

            <SCRIPT LANGUAGE="JavaScript">
	        <!--
	         alert('성공적으로 처리 되었습니다.');
	         parent.delAttachRow();
	        
	        //-->
	        </SCRIPT>
<%
     }else{
%>
    
	        <SCRIPT LANGUAGE="JavaScript">
	        <!--
	         alert('성공적으로 처리 되었습니다.');
	         parent.location.href="tour_prroom_eng.jsp";
	        //-->
	        </SCRIPT>
<%
      }
  }else{
%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
		alert('처리에 실패하였습니다. 잠시후 다시 사용하여 주십시요.');
		history.back();
		//-->
		</SCRIPT>
<%
}		
%>