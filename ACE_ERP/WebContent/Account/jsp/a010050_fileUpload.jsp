<%--
  - ����: ���� ÷�� ���ε�
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
  	String saveDir 		=  HDConstant.FILE_UPLOAD_PATH_ACCOUNT+"vend/";	//���� �ŷ�ó 
	//String saveDir 		=  "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Pms/file/pu010/";	//���� ÷������ ���� ���
	//String saveDir 		=  "/asanwas/����/pu010/";	//���� ÷������ ���� ���

	//String saveDir = "C:\\fileupTest/"; //����..
		
	int maxSize = 10*1024*1024;						//�ƽ� ������ ���� 10M
	
    //÷������ �뷮 üũ
    if(request.getContentLength() > maxSize ){

		out.println("<script language=\"javascript\">");
		out.println("<!--");
		out.println("alert('�ִ�뷮�� 10M�� ���� �� �����ϴ�.');");
		out.println("//-->");
		out.println("</script>");
		out.flush();
		out.close();

		return;
	}	
    //÷������ �뷮 üũ
     
    //���Ϻ��� 
	MultipartRequest multi	= new MultipartRequest(request, saveDir, maxSize,"euc-kr", new DefaultFileRenamePolicy());
	
    //FORM ��ü���� �Ѿ�� ������ 	
	String mode				= Util.getString(multi.getParameter("mode"),"");
	String realFileName 	= Util.getString(multi.getParameter("realFileName"),"");
	String virtualFileName	= Util.getString(multi.getParameter("virtualFileName"),"");
	
	//System.out.println("mode::"+mode);                       //�Է� ���  
	//System.out.println("realFileName::"+realFileName);       //ȭ��� ���ϸ�
	//System.out.println("virtualFileName::"+virtualFileName); //�ý��� ���ϸ�
	
	//System.out.println("===============================================================::"); //�ý��� ���ϸ�
	 
	String fileName = new String();
	String fileSystemName = new String();

	Enumeration enu = multi.getFileNames(); //������ ���ε� �� ������ �̸�
	
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
			
			//Ȯ���� �̾Ƴ���
			sepIndex = fileSystemName.indexOf(".");
			
			//System.out.println("STEP5.1::"); 
			if(sepIndex>0){
				fileExtName =  fileSystemName.substring(sepIndex);
			}
			
			//System.out.println("STEP5.2::"); 
		    
			//������Ʈ �� ���� ã��
			systemFile = new File(saveDir+fileSystemName);
			
			//System.out.println("STEP5.3::"); 
			//������Ʈ �� ������ ������..
			//�����̸� 
			String fileSeq = Util.getSeqText();
			  
			//System.out.println("STEP6::"); 
			    
			if(systemFile.exists()){
			    //���� �̸��� ��������ȣ�� �����Ѵ�.
			    virtualName = fileSeq+fileExtName;
			    tempFile = new File(saveDir+virtualName);
			    //������ �����Ѵ�.
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
		
		//Ȯ���� �̾Ƴ���
		sepIndex = fileSystemName.indexOf(".");
		
		System.out.println("STEP5.1::"); 
		if(sepIndex>0){
			fileExtName =  fileSystemName.substring(sepIndex);
		}
		
		System.out.println("STEP5.2::"); 
	    
		//������Ʈ �� ���� ã��
		systemFile = new File(saveDir+fileSystemName);
		
		System.out.println("STEP5.3::"); 
		//������Ʈ �� ������ ������..
		//�����̸� 
		String fileSeq = Util.getSeqText();
		  
		System.out.println("STEP6::"); 
		    
		if(systemFile.exists()){
		    //���� �̸��� ��������ȣ�� �����Ѵ�.
		    virtualName = fileSeq+fileExtName;
		    tempFile = new File(saveDir+virtualName);
		    //������ �����Ѵ�.
		    systemFile.renameTo(tempFile);
		}
		
		*/
	}
			
	//System.out.println("STEP7::"); 
%>
	<script language="javascript">
	<!--
	//���Ͼ��ε� 1
    // ���� ��Ͽ� �߰�
    //    alert("step8");
    	
	//-->
	</script>
