<%--
  - 설명: 파일 첨부 업로드
--%>
<%@ page info="tempfile upload"  contentType="text/html;charset=euc-kr" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="kr.co.imjk.util.HtmlUtil"%>
<%@ page import="kr.co.imjk.util.Util"%>
<%@ page import="kr.co.imjk.util.StringUtil"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="Account.common.HDConstant"%>
<%
  	String saveDir 		=  HDConstant.FILE_UPLOAD_PATH_ACCOUNT+"vend/";	//서버 거래처 
	//String saveDir 		=  "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Pms/file/pu010/";	//로컬 첨부파일 저장 경로
	//String saveDir 		=  "/asanwas/구매/pu010/";	//서버 첨부파일 저장 경로

	//String saveDir = "C:\\fileupTest/"; //로컬..
		
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
	
	//System.out.println("mode::"+mode);                       //입력 모드  
	//System.out.println("realFileName::"+realFileName);       //화면상 파일명
	//System.out.println("virtualFileName::"+virtualFileName); //시스템 파일명
	
	//System.out.println("===============================================================::"); //시스템 파일명
	 
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
		
		//System.out.println("fileName::"+fileName); 
		
		fileSystemName = multi.getFilesystemName(fileName);
		
		//System.out.println("fileSystemName::::"+fileSystemName); 
		
		//System.out.println("intTot::::"+intTot); 
		
		if(fileSystemName!=null){
			
			intTot = intTot + 1 ;
			
			//확장자 뽑아내기
			sepIndex = fileSystemName.indexOf(".");
			
			//System.out.println("STEP5.1::"); 
			if(sepIndex>0){
				fileExtName =  fileSystemName.substring(sepIndex);
			}
			
			//System.out.println("STEP5.2::"); 
		    
			//업데이트 된 파일 찾기
			systemFile = new File(saveDir+fileSystemName);
			
			//System.out.println("STEP5.3::"); 
			//업데이트 된 파일이 있으면..
			//파일이름 
			String fileSeq = Util.getSeqText();
			  
			//System.out.println("STEP6::"); 
			    
			if(systemFile.exists()){
			    //파일 이름을 시퀀스번호로 변경한다.
			    virtualName = fileSeq+fileExtName;
			    tempFile = new File(saveDir+virtualName);
			    //서버에 저장한다.
			    systemFile.renameTo(tempFile);
			    //System.out.println("STEP66::"); 
			    //parent.addFileList(realFileName,virtualName);
			    
			    	out.println("<script language=\"javascript\">");
					out.println("<!--");
					out.println("parent.addFileList('"+fileSystemName+"','"+virtualName+"', "+intTot+", '"+fileName+"' )");
					out.println("//-->");
					out.println("</script>");
					out.flush();
					//out.close();
			    //System.out.println("STEP67::"); 
			}
			
			//out.close();
		}
		
		/*
		
		//확장자 뽑아내기
		sepIndex = fileSystemName.indexOf(".");
		
		System.out.println("STEP5.1::"); 
		if(sepIndex>0){
			fileExtName =  fileSystemName.substring(sepIndex);
		}
		
		System.out.println("STEP5.2::"); 
	    
		//업데이트 된 파일 찾기
		systemFile = new File(saveDir+fileSystemName);
		
		System.out.println("STEP5.3::"); 
		//업데이트 된 파일이 있으면..
		//파일이름 
		String fileSeq = Util.getSeqText();
		  
		System.out.println("STEP6::"); 
		    
		if(systemFile.exists()){
		    //파일 이름을 시퀀스번호로 변경한다.
		    virtualName = fileSeq+fileExtName;
		    tempFile = new File(saveDir+virtualName);
		    //서버에 저장한다.
		    systemFile.renameTo(tempFile);
		}
		
		*/
	}
			
	//System.out.println("STEP7::"); 
%>
	<script language="javascript">
	<!--
	//파일업로드 1
    // 파일 목록에 추가
    //    alert("step8");
    	
	//-->
	</script>
