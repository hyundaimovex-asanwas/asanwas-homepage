<%--
 * Comment : �Խù� ����ϱ�
 * History : ���¿� 2001-11-07 Ver1.0.0 �����ۼ�
 --%> 

<%@ page language="java" contentType="text/html; charset=KSC5601"%>
<%@ page import="java.io.File"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %><%@ page import="sales.common.StringUtil" %><%@ page import="java.net.URLEncoder" %><%@ page import="java.net.URLDecoder" %><%@ page import="sales.common.HDConstant" %> 
 
<%
	/** MultipartRequest Initialization **/

//	MultipartRequest multiReq = new MultipartRequest( request, location.tmpFileZone );

	// ���� ���ε�� �ʿ��� ����  
	MultipartRequest multiReq = new MultipartRequest( request,  HDConstant.FILE_UPLOAD_PATH_NOTICES, 1024*1024*20); // �����ӽ� 

	/** Request Parameter Initialization **/

	/*********************************************************************
		���� ó�� Logic
	 *********************************************************************
		�� ���۵� ������ �ִ��� üũ�Ѵ�.

		�� ���� ���۵� ������ �̸��� ������ ���������� üũ�Ѵ�.

		�� �ߺ��Ǵ� ������ ������� 
			* ����������ġ(fileStorePath)�� �����Ѵ�..

		�� �ߺ��Ǵ� ������ ������� 
			* ���� �ӽ����� ��ġ(tmpFileStorePath)�� �����Ѵ�..
			* ���ϸ��� ������Ѱ��鼭 ����������ġ�� �ִ� ���ϰ� �ߺ����θ� üũ�Ѵ�.
			* �ߺ��� �ȵǴ� ���ϸ��� �ϼ��� ��� ����������ġ�� �̵���Ų��.
	**********************************************************************/


//	String fileStorePath = location.noticeFileZone;		// ���� ���� ��ġ
//	String tmpFileStorePath = location.tmpFileZone;	// ���� �ӽ����� ��ġ

//	String fileStorePath = "D:/MyArea/02 Project/WorkSpace/Java/HDASanAgent/WebContent/Sales/file/notices/"+gubun+"/";		// ���� ���� ��ġ
	String fileStorePath = HDConstant.FILE_UPLOAD_PATH_NOTICES;		// ���� ���� ��ġ
	String tmpFileStorePath = HDConstant.FILE_UPLOAD_PATH_NOTICES;	// ���� �ӽ����� ��ġ

	String real_file = ""; // ��� ������ ���� ���ϸ�
	String sys_file = ""; // ���� ���Ͽ� ���� ���ϸ� 

	String sendFileName = multiReq.getFilesystemName("real_files");	// ���� ��( ���۵� ���ϸ�)
	
	real_file = StringUtil.encoding(sendFileName); // ���۵� ���ϸ��� ���ڵ��Ͽ� ������ ��´� 
	
	String saveFileName = null;	// ���� ���ϸ�

	boolean fileExists  = false;	// ÷������ �ߺ� ����
	boolean isChange = false;	// ÷������ ���� ����

	/****************
	  �� ���� ÷�� ����
	****************/
	if( sendFileName != null || sendFileName != "" ) {

		String fileName = sendFileName.substring( 0, sendFileName.lastIndexOf('.') );//  ���� Ȯ���� ���ŵ� ���ϸ�
		//String newFileName =  fileName.replace( ' ', '_' );	// ������ "_" �� ����
		String newFileName = fileName;
		String fileExt = sendFileName.substring(sendFileName.lastIndexOf('.'));		//  ���� (Ȯ����)

		int count=0;
		StringUtil.encoding(fileName);

		File tmpUp = new File( tmpFileStorePath + fileName + fileExt );	//����� ����
		File up = new File( fileStorePath +  StringUtil.encoding( newFileName) + fileExt );		// ���� �ߺ� �񱳿�

		/****************
		 �� ���ϸ� �ߺ�üũ
		****************/
		if ( !up.exists() ) {
			/************
			  �� ���ߺ���
			************/
			tmpUp.renameTo( up );	// ���� �̵�( �ӽ� �� ���� )
			saveFileName = newFileName + fileExt;// ���� ���� ����

		} else {
			/**********
			  �� �ߺ��� 
			**********/
			do {
				count++;
				// ���ϸ��� �ߺ��� �ȵ� ������ ���ϸ�+ ��ȣ+Ȯ���ڷ� ����� ����
				up = new File( fileStorePath + StringUtil.encoding(newFileName) + count + fileExt );	// ���ο� ���ϸ����� �ٽ� ����(������)

				saveFileName = newFileName + count + fileExt;   // ���� ���� ����
				
				

			} while( up.exists() );  // ���ϸ��� �ߺ� üũ

			isChange = tmpUp.renameTo( up );	// �ߺ��� ������ ���ϸ� ����
		}
		
		sys_file = StringUtil.encoding(saveFileName);
		
	} 
		
%>

<script language="javascript">
	<!--
		// �Խù� ����
		parent.document.all.real_file.value = '<%=real_file%>';
		parent.document.all.sys_file.value = '<%=sys_file%>';
		parent.fnInsert2();
		
	-->
</script>
