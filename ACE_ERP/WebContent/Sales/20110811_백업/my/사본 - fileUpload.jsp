<%--
 * Comment : 게시물 등록하기
 * History : 구태영 2001-11-07 Ver1.0.0 최초작성
 --%> 

<%@ page language="java" contentType="text/html; charset=KSC5601"%>
<%@ page import="java.io.File"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %><%@ page import="sales.common.StringUtil" %><%@ page import="java.net.URLEncoder" %><%@ page import="java.net.URLDecoder" %><%@ page import="sales.common.HDConstant" %> 
 
<%
	/** MultipartRequest Initialization **/

//	MultipartRequest multiReq = new MultipartRequest( request, location.tmpFileZone );

	// 파일 업로드시 필요한 폴더  
	MultipartRequest multiReq = new MultipartRequest( request,  HDConstant.FILE_UPLOAD_PATH_NOTICES, 1024*1024*20); // 파일임시 

	/** Request Parameter Initialization **/

	/*********************************************************************
		파일 처리 Logic
	 *********************************************************************
		① 전송된 파일이 있는지 체크한다.

		② 현재 전송된 파일의 이름이 서버에 존재유무를 체크한다.

		③ 중복되는 파일이 없을경우 
			* 파일저장위치(fileStorePath)에 저장한다..

		④ 중복되는 파일이 있을경우 
			* 파일 임시저장 위치(tmpFileStorePath)에 저장한다..
			* 파일명을 변경시켜가면서 파일저장위치에 있는 파일과 중복여부를 체크한다.
			* 중복이 안되는 파일명이 완성될 경우 파일저장위치로 이동시킨다.
	**********************************************************************/


//	String fileStorePath = location.noticeFileZone;		// 파일 저장 위치
//	String tmpFileStorePath = location.tmpFileZone;	// 파일 임시저장 위치

//	String fileStorePath = "D:/MyArea/02 Project/WorkSpace/Java/HDASanAgent/WebContent/Sales/file/notices/"+gubun+"/";		// 파일 저장 위치
	String fileStorePath = HDConstant.FILE_UPLOAD_PATH_NOTICES;		// 파일 저장 위치
	String tmpFileStorePath = HDConstant.FILE_UPLOAD_PATH_NOTICES;	// 파일 임시저장 위치

	String real_file = ""; // 디비에 저장할 실제 파일명
	String sys_file = ""; // 실제 파일에 넣은 파일명 

	String sendFileName = multiReq.getFilesystemName("real_files");	// 파일 명( 전송된 파일명)
	
	real_file = StringUtil.encoding(sendFileName); // 전송된 파일명을 인코딩하여 변수에 담는다 
	
	String saveFileName = null;	// 저장 파일명

	boolean fileExists  = false;	// 첨부파일 중복 여부
	boolean isChange = false;	// 첨부파일 변경 여부

	/****************
	  ① 파일 첨부 여부
	****************/
	if( sendFileName != null || sendFileName != "" ) {

		String fileName = sendFileName.substring( 0, sendFileName.lastIndexOf('.') );//  파일 확장자 제거된 파일명
		//String newFileName =  fileName.replace( ' ', '_' );	// 공백을 "_" 로 변경
		String newFileName = fileName;
		String fileExt = sendFileName.substring(sendFileName.lastIndexOf('.'));		//  파일 (확장자)

		int count=0;
		StringUtil.encoding(fileName);

		File tmpUp = new File( tmpFileStorePath + fileName + fileExt );	//저장된 파일
		File up = new File( fileStorePath +  StringUtil.encoding( newFileName) + fileExt );		// 파일 중복 비교용

		/****************
		 ② 파일명 중복체크
		****************/
		if ( !up.exists() ) {
			/************
			  ③ 미중복시
			************/
			tmpUp.renameTo( up );	// 파일 이동( 임시 → 정상 )
			saveFileName = newFileName + fileExt;// 변경 파일 저장

		} else {
			/**********
			  ④ 중복시 
			**********/
			do {
				count++;
				// 파일명이 중복이 안될 때까지 파일명+ 번호+확장자로 만들어 변경
				up = new File( fileStorePath + StringUtil.encoding(newFileName) + count + fileExt );	// 새로운 파일명으로 다시 생성(절대경로)

				saveFileName = newFileName + count + fileExt;   // 변경 파일 저장
				
				

			} while( up.exists() );  // 파일명이 중복 체크

			isChange = tmpUp.renameTo( up );	// 중복된 파일의 파일명 변경
		}
		
		sys_file = StringUtil.encoding(saveFileName);
		
	} 
		
%>

<script language="javascript">
	<!--
		// 게시물 저장
		parent.document.all.real_file.value = '<%=real_file%>';
		parent.document.all.sys_file.value = '<%=sys_file%>';
		parent.fnInsert2();
		
	-->
</script>
