<% /*
   ����: ���� ��ǰ/���� ����(RM)�� ���� ÷�� ���ε�
   
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
	//String saveDir 		=  HDConstant.FILE_UPLOAD_PATH_FILE+"ctscard/";		//����� ÷������ ���� ���
	String saveDir 		=  "D:/myWorks1/HDAsan/WebContent/Sales/file/"+ "ctscard/";	//�ɵ���/���� ÷������ ���� ���

	
	System.out.println("start::");    
	
	//String saveDir = "C:\\fileupTest/";
		
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
	String mCcSid			= Util.getString(multi.getParameter("m_cc_sid"),"");
	System.out.println("mode::"+mode);                       //�Է� ���  
	System.out.println("realFileName::"+realFileName);       //ȭ��� ���ϸ�
	System.out.println("virtualFileName::"+virtualFileName); //�ý��� ���ϸ�
	System.out.println("mCcSid::"+mCcSid); //ī�� sid
	
	System.out.println("===============================================================::"); //�ý��� ���ϸ�
	 
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
		fileSystemName = multi.getFilesystemName(fileName);
		
		System.out.println("���� �̸�::::"+fileSystemName); 
		
		//System.out.println("intTot::::"+intTot); 
		
		if(fileSystemName!=null){
			
			intTot = intTot + 1 ;
			
			//Ȯ���� �̾Ƴ���
			sepIndex = fileSystemName.indexOf(".");
			
			 
			if(sepIndex>0){
				fileExtName =  fileSystemName.substring(sepIndex);
			}
			//System.out.println("Ȯ����==="+fileExtName);	//.JPG
			//������Ʈ �� ���� ã��
			systemFile = new File(saveDir+fileSystemName);
			
			//System.out.println("STEP5.3::"); 
			//���ε�� ������ ������ �����ϸ� (cos.jar�� ������ ���ε��ϰ� �״��� �̸��� ��ħ)
			//�����̸��� �������ݴϴ�.
			String fileSeq = Util.getSeqText();
			    
			if(systemFile.exists()){
			    //���� �̸��� ��������ȣ�� �����Ѵ�.
			    virtualName = mCcSid+"_"+fileSeq+".jpg";	//���ο� SID_�ҹ���jpg�� ����! 
			    //virtualName = fileSeq+fileExtName;
			    System.out.println("�������� ����� �̸�virtualName===="+virtualName);
			    
			    tempFile = new File(saveDir+virtualName);
			    //������ �����Ѵ�.
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
