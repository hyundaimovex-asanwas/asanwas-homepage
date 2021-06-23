<%--
  - �ۼ���: �̼ҿ�
  - ����: 2006.06.13
  - ���۱� ǥ��: IMJ Korea
  - ����: ������ - PR Room ��� �� ���� ����
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

   //÷������ �뷮 üũ
    if(request.getContentLength() > maxSize ){

		out.println("<script language=\"javascript\">");
		out.println("<!--");
		out.println("alert('�ִ�뷮�� 5M�� ���� �� �����ϴ�.');");
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
	
	
	String realFileName01  = Util.getString(multi.getParameter("realFileName01"),"");  //�����
	String realFileName02  = Util.getString(multi.getParameter("realFileName02"),"");  //�̹���
	String type_code       = Util.getString(multi.getParameter("type_code"),"");       // 1 : �̹���, 2: ������
	if (type_code == "1" || type_code.equals("1")){
	   content = "";
	}
	
	Tbrd_attach_file_de_bean file_bean = new Tbrd_attach_file_de_bean();
    
    
    //����� + �̹��� ����  
    String fileName = new String();
	String fileSystemName = new String();
	
	Enumeration enum = multi.getFileNames();
	
	//����� + �̹��� ����
	File systemFile = null;
	File tempFile = null;
	
	int sepIndex = 0;
	
	//����� + �̹��� ����
	String fileExtName = "";
	String virtualName = "";

	String[] fileArry = new String[2];
	int i=0;
	while(enum.hasMoreElements())
	{  
	    
	   //(�����, �̹�����)�迭�� �޴´�.
		fileName = (String)enum.nextElement();
		fileSystemName = Util.getString(multi.getFilesystemName(fileName),"");
		//out.println("fileSystemName=>"+fileSystemName);
		fileArry[i] = fileSystemName;
		
		i++;  //�迭 ����
    }
		
    String fileSeq = Util.getSeqText();
	
    //����� ó��
    if(fileArry[1] != null && (!fileArry[1].equals("") || fileArry[1] != "")){
    	         
         //Ȯ���� �̾Ƴ���
         sepIndex = fileArry[1].indexOf(".");
         if(sepIndex>0){
               fileExtName =  fileArry[1].substring(sepIndex);
         }
         //������Ʈ �� ���� ã��
         systemFile = new File(saveDir+fileArry[1]);
         //������Ʈ �� ������ ������..
         //�����̸� 
         //String fileSeq = Util.getSeqText();
          
         if(systemFile.exists()){
             //���� �̸��� ��������ȣ�� �����Ѵ�.
             virtualName = fileSeq+fileExtName;
             tempFile = new File(saveDir+virtualName);
             //������ �����Ѵ�.
             systemFile.renameTo(tempFile);
         
         	//÷������ ���� SET
         	file_bean.setThumbnail_real_name(fileRootDir+fileArry[1].trim());
         	file_bean.setThumbnail_virtual_name(fileRootDir+virtualName);
         	file_bean.setAttach_file_seq(attach_seq);
         	file_bean.setBoard_seq(board_seq);
         }
                 
    }
    
    //�̹��� ó��
    if(fileArry[0] != null && (!fileArry[0].equals("") || fileArry[0] != "")){
    	         
         //Ȯ���� �̾Ƴ���
         sepIndex = fileArry[0].indexOf(".");
         if(sepIndex>0){
               fileExtName =  fileArry[0].substring(sepIndex);
         }
         //������Ʈ �� ���� ã��
         systemFile = new File(saveDir+fileArry[0]);
         //������Ʈ �� ������ ������..
         //�����̸� 
         //String fileSeq = Util.getSeqText();
          
         if(systemFile.exists()){
             //���� �̸��� ��������ȣ�� �����Ѵ�.
             virtualName = fileSeq+fileExtName;
             tempFile = new File(saveDir+virtualName);
             //������ �����Ѵ�.
             systemFile.renameTo(tempFile);
         
         	//÷������ ���� SET
         	file_bean.setReal_name(fileRootDir+fileArry[0].trim());
         	file_bean.setVirtual_name(fileRootDir+virtualName);
         	file_bean.setAttach_file_seq(attach_seq);
         	file_bean.setBoard_seq(board_seq);
         }
                 
    } 

    //out.println("�����:"+fileArry[1]+"<br>");
    //out.println("�̹���:"+fileArry[0]+"<br>===============<br>");
    //out.println(file_bean.getThumbnail_virtual_name()+"<br>");
    //out.println(file_bean.getVirtual_name()+"<br>===============<br>");
    //out.println(file_bean.getThumbnail_real_name()+"<br>");
    //out.println(file_bean.getReal_name()+"<br>===============<br>");
    //out.println("fileSystemName:"+fileSystemName+"<br>");
    
    //if (file_bean.getThumbnail_real_name() == ""){
    //       out.println("����� ����<br>");
    //}else{
    //       out.println("�����<br>");
    //}
    //
    //if (file_bean.getReal_name() == ""){
    //       out.println("�̹��� ����<br>");
    //}else{
    //      out.println("�̹���<br>");
    //}

    //���� ����
    String board_type	= "10";
    
    //DAO
    TourPrRoomEng dao = new TourPrRoomEng();
    //DTO
    Tbrd_board_ma_bean bean = new Tbrd_board_ma_bean();
    
    bean.setBoard_seq(board_seq);
    bean.setTitle(title);
    bean.setContent(content);
    bean.setUser_id("admin");
    bean.setUser_name("������");
    bean.setType_code(type_code);
    
    int result = 0;
    
    if(cmd.equals("insert")){
    	result = dao.insert(bean, file_bean);
    }else if(cmd.equals("edit")){
    	if(fileArry[1].equals("") && fileArry[0].equals("") ){
    		//���븸 ������Ʈ
    		result = dao.update(bean);
    	}else{
    		//����� ÷������ ������Ʈ
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
	         alert('���������� ó�� �Ǿ����ϴ�.');
	         parent.delAttachRow();
	        
	        //-->
	        </SCRIPT>
<%
     }else{
%>
    
	        <SCRIPT LANGUAGE="JavaScript">
	        <!--
	         alert('���������� ó�� �Ǿ����ϴ�.');
	         parent.location.href="tour_prroom_eng.jsp";
	        //-->
	        </SCRIPT>
<%
      }
  }else{
%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
		alert('ó���� �����Ͽ����ϴ�. ����� �ٽ� ����Ͽ� �ֽʽÿ�.');
		history.back();
		//-->
		</SCRIPT>
<%
}		
%>