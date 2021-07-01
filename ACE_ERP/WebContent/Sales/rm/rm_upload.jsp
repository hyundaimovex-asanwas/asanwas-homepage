<% /*
   설명: 관광 상품/객실 구성(RM)쪽 파일 첨부 업로드
   
  */
%>
<%@ page info="tempfile upload"  contentType="text/html;charset=euc-kr" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="kr.co.imjk.util.HtmlUtil"%>
<%@ page import="kr.co.imjk.util.Util"%>
<%@ page import="kr.co.imjk.util.StringUtil"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="sales.common.HDConstant"%>
<%
	//String saveDir 		=  HDConstant.FILE_UPLOAD_PATH_FILE+"ctscard/";		//운영서버 첨부파일 저장 경로
	String saveDir 		=  "D:/myWorks1/HDAsan/WebContent/Sales/file/"+ "ctscard/";	//심동현/로컬 첨부파일 저장 경로

	
	System.out.println("start::");    
	
	//String saveDir = "C:\\fileupTest/";
		
	int maxSize = 10*1024*1024;						//맥스 사이즈 설정 10M
	
    //첨부파일 용량 체크
    if(request.getContentLength() > maxSize ){

		out.println("<script language=\"javascript\">");
		out.println("<!--");
		out.println("alert('최대용량은 10M를 넘을 수 없습니다.');");
		out.println("//-->");
		out.println("</script>");
		out.flush();
		out.close();

		return;
	}	
    //첨부파일 용량 체크
     
    //파일복사 
	MultipartRequest multi	= new MultipartRequest(request, saveDir, maxSize,"euc-kr", new DefaultFileRenamePolicy());
	
    //FORM 개체에서 넘어온 데이터 	
	String mode				= Util.getString(multi.getParameter("mode"),"");
	String realFileName 	= Util.getString(multi.getParameter("realFileName"),"");
	String virtualFileName	= Util.getString(multi.getParameter("virtualFileName"),"");
	String mCcSid			= Util.getString(multi.getParameter("m_cc_sid"),"");
	System.out.println("mode::"+mode);                       //입력 모드  
	System.out.println("realFileName::"+realFileName);       //화면상 파일명
	System.out.println("virtualFileName::"+virtualFileName); //시스템 파일명
	System.out.println("mCcSid::"+mCcSid); //카드 sid
	
	System.out.println("===============================================================::"); //시스템 파일명
	 
	String fileName = new String();
	String fileSystemName = new String();

	Enumeration enu = multi.getFileNames(); //여러개 업로드 된 파일의 이름
	
	File systemFile = null;
	File tempFile = null;
	int sepIndex = 0;
	String fileExtName = "";
	String virtualName = "";
	int intTot = 0;
	
	
	//System.out.println("intTot::"+intTot); 

	
	
	while(enu.hasMoreElements())
	{  
		
		fileName = (String)enu.nextElement();
		fileSystemName = multi.getFilesystemName(fileName);
		
		System.out.println("원래 이름::::"+fileSystemName); 
		
		//System.out.println("intTot::::"+intTot); 
		
		if(fileSystemName!=null){
			
			intTot = intTot + 1 ;
			
			//확장자 뽑아내기
			sepIndex = fileSystemName.indexOf(".");
			
			 
			if(sepIndex>0){
				fileExtName =  fileSystemName.substring(sepIndex);
			}
			//System.out.println("확장자==="+fileExtName);	//.JPG
			//업데이트 된 파일 찾기
			systemFile = new File(saveDir+fileSystemName);
			
			//System.out.println("STEP5.3::"); 
			//업로드된 파일이 서버에 존재하면 (cos.jar는 무조건 업로드하고 그다음 이름을 고침)
			//파일이름을 변경해줍니다.
			String fileSeq = Util.getSeqText();
			    
			if(systemFile.exists()){
			    //파일 이름을 시퀀스번호로 변경한다.
			    virtualName = mCcSid+"_"+fileSeq+".jpg";	//접두에 SID_소문자jpg로 통일! 
			    //virtualName = fileSeq+fileExtName;
			    System.out.println("서버에서 저장된 이름virtualName===="+virtualName);
			    
			    tempFile = new File(saveDir+virtualName);
			    //서버에 저장한다.
			    systemFile.renameTo(tempFile);
			}
			//out.close();
		}
	}
%>
	<script language="javascript">
	<!--
		parent.addFileList('<%= realFileName%>','<%= virtualName%>');
	//-->
	</script>
