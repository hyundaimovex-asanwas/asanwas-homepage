<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : ���� ����
 * ���α׷�ID   : my710i
 * J  S  P		: my710i
 * �� �� ��		: My710i
 * �� �� ��		: �ڰ汹, �ɵ���
 * �� �� ��     : 2010-05-20
 * �������		: ���� ����, ���� �Ϸ�� "���� �߼۵Ǿ����ϴ�" �� �� �ٽ� ���� ȭ������
 * [����  ����][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-03-11][�ɵ���] �� �Խ��� Ÿ������ ����. (menuID= 404)
 * [2010-05-20][�ڰ汹] ����ƻ� ������+�븮�� ����ڰ� ���� ��밡���� ���� ������(����ȭ��) �ű� ����.
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.menu.my.My710Manager" %>
<%@ page import="sales.menu.my.My710DTO" %>
<%@ page import="sales.org.common.*"%>

<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourGalleryBoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>

<%	// ContextPath ���� ����.
   String dirPath = request.getContextPath(); //HDASan
   
   String recipient	= HDUtil.nullCheckStr(request.getParameter("brd_creator"));
   String recipient_name	=HDUtil.nullCheckStr(request.getParameter("brd_creator_name"));
   
   String ref 			= HDUtil.nullCheckStr(request.getParameter("ref"));
   String ref_step 	= HDUtil.nullCheckStr(request.getParameter("ref_step"));
   String ref_level = HDUtil.nullCheckStr(request.getParameter("ref_level"));
   String work_flag = "";
	work_flag 	= HDUtil.nullCheckStr(request.getParameter("work_flag"));
   if (work_flag == null || work_flag.equals("")){
       work_flag = "INSERT";
   }
	
   String brd_gu = "01";	//�Խ��� ���� �ڵ�
   String brd_no = "";	//�Խ��� ���� �ڵ�
   
      
   if (ref == null || ref.equals("")){
       ref = "0";
   }
   if (ref_step == null || ref_step.equals("")){
       ref_step = "0";
   }
   if (ref_level == null || ref_level.equals("")){
       ref_level = "0";
   }
   
   
//���� ����- ���Ͼ��ε�� ������ �� _---------------------
String cmd	= "";			//�۾����� (�μ�Ʈ | ����)
String title= "";			//����
String content	= "";		//����
String passwd	= "";		//���
String writer	= "";		//�ۼ��� ���̵�
String writer_name	= "";

String user_id = "";
String user_name = "";
String virtual_name	= "";
String real_name		= "";
String fullFilename	= "";

String fileNameList = "";	//���� ����Ʈ ������ (������)

Tbrd_attach_file_de_bean[] fileRecord = null;	//���� ÷�ο� ��~!

if (work_flag.equals("MODIFY")){	//�Խù���ȣ�� ������ ����Ʈ�� �ν���
	cmd = "edit";

   ArrayList data3 = new ArrayList();
   SmartRequest sr3 = new SmartRequest(request);
   String where_sql3     = "";
   
   brd_gu = HDUtil.nullCheckStr(request.getParameter("brd_gu"));
   brd_no = HDUtil.nullCheckStr(request.getParameter("brd_no"));

   int len3 = 0;
   BaseDataClass bean3;
   String key 		= HDUtil.nullCheckStr(request.getParameter("search_key"));
   String values 	= HDUtil.nullCheckStr(request.getParameter("search_value"));
   
   sr3.setObject("where_sql",(Object)where_sql3);
   sr3.setObject("brd_no", (Object)brd_no);
   My710Manager manager3 = new My710Manager();
   My710DTO dto = manager3.select(sr3);
   manager3.close();

	//������ �о�� �� �ֱ� (update�� ���
	title 	= dto.getBrd_subject();		//����
	content	= dto.getBrd_contents();	//����
	writer	= dto.getBrd_creator();		//�ۼ���
	//recipient	=	dto.getBrd_recipient();	//������ 
	writer_name	= dto.getBrd_creator_name();		//�ۼ��� �̸�
	//recipient_name	=	dto.getBrd_recipient_name();	//������ �̸�


	//���ϸ���Ʈ html �����
    StringBuffer sb = new StringBuffer();
	String real_fileList = dto.getReal_file();	//���� �ҷ��ͼ� 
	String sys_fileList = dto.getSys_file();
	fileNameList = real_fileList;				// �ý����� ����Ʈ�� ����.

	String real_file[] = real_fileList.split(":");	//�迭�� ����
	String sys_file[] = sys_fileList.split(":");	//�迭�� ����
	
		for(int j=0; j<sys_file.length; j++){

			sb.append("<option value='"+sys_file[j]+ "'>" + real_file[j] +"</option>"); 
		};

	//÷�ζ��� ���� html�ڵ� �����                     
	fullFilename = sb.toString();     	

    //�ڱⰡ �� �۸� ���� ����
//	if(user_id.equals(session_id)) deleteYn = true;

}else{
	cmd = "insert";
	//user_id = session_id;
	//user_name = session_name;
//	regdate = Util.getDate();
}
//���� ����- ���Ͼ��ε�� ������ �� _---------------------   
%>

<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		

	<script language="javascript">
	function fnOnLoad(tree_idx){
		fnInit_tree(400);	//Ʈ���ʱ�ȭ ȣ��
	}

	/**
	 * ����ǥ������ �̿��� ���� üũ
	 */
	function isNull( text ){
		 if( text == null ) return true;  
		
		 var result = text.replace(/(^\s*)|(\s*$)/g, "");  
		
		 if( result )  
			return false;  
		 else  
			return true;  
	}
	
	//�Խ��� ���� üũ
	function send_ok(){
		var f = document.form1;
		var ff = document.fileForm;
		
//		if(f.brd_subject.value==""){alert("������ �Է��� �ּ���!");  f.brd_subject.focus(); return;}
//		if(f.brd_creator.value==""){alert("�ۼ��ڸ� �Է��� �ּ���!");  f.brd_creator.focus(); return;}
//		if(f.brd_recipient.value==""){alert("�����ڸ� �Է��� �ּ���!");  f.brd_recipient.focus(); return;}
//		if(f.brd_passwd.value==""){alert("��й�ȣ�� �Է��� �ּ���!");  f.brd_passwd.focus(); return;}
	
		var oEditor = FCKeditorAPI.GetInstance('brd_contents') ;
		var div = document.createElement("DIV");
		div.innerHTML = oEditor.GetXHTML();
		if( isNull( div.innerText ) ) { 
		  alert("������ �Է��ϼ���.");  
		  oEditor.Focus();
		  return;
		};
		
		//÷�����ϸ� 
		if(ff.fileList.options.length > 0)
		{
			f.sys_file.value = "";
			f.real_file.value = "";
			for(i=0;i<ff.fileList.options.length;i++)
			{
			  if(i==0){
				  f.sys_file.value += ff.fileList.options[i].value;
				  f.real_file.value += ff.fileList.options[i].text;
			  }else{
			    f.sys_file.value += ":"+ff.fileList.options[i].value;
			    f.real_file.value += ":"+ff.fileList.options[i].text;
			  }
			}
		}else{
			//alert("������ ���ε� ���ּ���.");
			//return;
		}
	
	//	alert(f.sys_file.value +"/"+ f.real_file.value);
		//÷�����ϸ� ó��
	   
	   f.action='my710_exec.jsp?idx=404';
	   f.target="";
	   f.method = "POST";
	   f.submit();
	};


	//��ҹ�ư : Ŭ�� >> �������
	function cancel(){
		window.history.back();
	//	var f = document.form1;
	//	f.action='my710_list.jsp?idx=404';
	//	f.target='';
	//	f.method='POST';
	//	f.submit();
	}
	
	
	//���Ͼ��ε� �Լ� 5
	//���� �̹����� ���
	var oldFileNames = "<%=fileNameList%>";


	//���Ͼ��ε� �Լ� 1
		//�̹��� ������ �ø���
	function tempUpload()
	{
		//document.domain="imjk.co.kr";
		f = document.fileForm;
	    //alert(f);
		if(f.file1.value.length == 0 || f.file1.value == "÷������ �ѿ뷮 ���� : 5M")
		{
			alert('���ε��� ������ �����Ͽ� �ֽʽÿ�');
			return;
		}
	
		var realFileName = f.file1.value;
		var idx = realFileName.lastIndexOf("\\");
		realFileName = realFileName.substring(idx+1);
		//alert(realFileName);
		if(realFileName.indexOf(".mp3") > 0 ||realFileName.indexOf(".wma") > 0 || realFileName.indexOf(".asf") > 0){
			alert("���۱� ������ ������ �ִ� mp3, wma, asf ������ �������� ÷�δ� ���� �ʽ��ϴ�.");
			return;
		}
		strArray = realFileName.split("."); 
		strArray2 = realFileName.split("|"); 
	  
		//�����̸��� [.] �� ������ �ȵȴ�.(Ȯ���� ����)
		if(strArray.length > 2){
		  alert("�����̸��� '.' �� ������ �����Ͽ� �ֽʽÿ� ");
		  return;
		}
		
		if(strArray.length < 1){
		  alert("Ȯ���ڸ��� �ݵ�� �־�� �մϴ�.  ");
		  return;
		}
		//�����̸��� [|] �� ������ �ȵȴ�.
		if(strArray2.length > 1){
		  alert("�����̸��� '|' �� ������ ��� �����Ͽ� �ֽʽÿ� ");
		  return;
		}
		
		f.target="tempUpload";	//���ε� ���� Ÿ���� iFrame !
		f.realFileName.value=realFileName;
		f.mode.value="insert";
		 
		f.action = "./my710_upload.jsp";
		f.submit();
	}

	//���Ͼ��ε� 2
		//���� ��Ͽ� �߰�: iFrame �ȿ��� ȣ���Ѵ�
	function addFileList(realName, virtualName)	{
		f = document.fileForm;
	
		if(realName!=""){
			f.fileList.options[f.fileList.options.length] = new Option(realName,virtualName);
		}
		f.file1.value ="÷���������ִ�5M���������մϴ�." ;  //f.file1.title;
	}


	//���Ͼ��ε� 3
	// ���� ��Ͽ��� ���� 
	function fileDelete(){
		f = document.fileForm;
	  
		if(f.fileList.selectedIndex==null || f.fileList.selectedIndex < 0){
			alert('������ ������ ������ �ֽʽÿ�');
			f.fileList.focus();
			return;
		}	
	
		if(confirm('������ ���� �Ͻðڽ��ϱ�?')){
			var i = f.fileList.options.selectedIndex;
			var select_val = f.fileList.options[i].value;
			var realFileName = f.file1.value;
		    var fileArray = oldFileNames.split(":");
	
			//alert(select_val);
			//alert(oldFileNames);
	
			//******** START ������ �ִ� �������� ���� ***********/
			var isNew = "i_del"; // �̰� �ݹ� �ø� ������ ���... insert_file
			 
	
			if(fileArray.length>1){
				 for(j=0;j< fileArray.length;j++){
				    tempFileName = fileArray[j];
				   if(tempFileName == select_val){
				      isNew = "u_del";		// ���Ⱑ ���� ����	update_file 
				      break;
				    }
				 }
			}
			 
			if(fileArray.length <=1){
			   if(oldFileNames == select_val){
					      isNew = "u_del";
				}
			}
			//******** END  ������ �ִ� �������� ���� ***********/
			 
			//alert(isNew);
	
			document.file_del.target="tempUpload";
			document.file_del.realFileName.value=realFileName;
			document.file_del.virtualFileName.value = select_val;
	//		document.file_del.saveDir.value = "memGalleryUpload";
			document.file_del.mode.value=isNew;
			document.file_del.action = "./my710_deleteFile.jsp";	//����� ����
			document.file_del.submit();
		}
	}




	//���Ͼ��ε� 4
	// ������ �������� ���� �� ����Ʈ���� ����
	function delResult(){
		f = document.fileForm;
	
		idx = f.fileList.selectedIndex;
		cnt = f.fileList.options.length;
		for(i=idx;i< f.fileList.options.length-1;i++){
			f.fileList.options[i] = new Option(f.fileList.options[i+1].text,f.fileList.options[i+1].value);
		}
		f.fileList.options[cnt - 1] = null;
		f.file1.value = "÷���������ִ�5M���������մϴ�.";
	}


	</script>
</head>

<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<!-- �� �� -->

        <form name="form1" enctype="MULTIPART/FORM-DATA">		
             <input type="hidden" name="brd_gu" value="<%=brd_gu%>">
             <input type="hidden" name="brd_no" value="<%=brd_no%>">
             <input type="hidden" name="recipient" value="<%=recipient%>">
             <input type="hidden" name="recipient_name" value="<%=recipient_name%>">
             <input type="hidden" name="ref" value="<%=ref%>">
             <input type="hidden" name="ref_step" value="<%=ref_step%>">
             <input type="hidden" name="ref_level" value="<%=ref_level%>">
             <input type="hidden" name="work_flag" value="<%=work_flag%>">
             <input type="hidden" name="real_file" value="">
             <input type="hidden" name="sys_file" value="">

                  <table  border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td> 
                      
                      <table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width=30 height="1" bgcolor="D3D2C3"></td>
                            <td width=50 height="1" bgcolor="D3D2C3"></td>
                            <td width=320 height="1" bgcolor="D3D2C3"></td>
                            
                          </tr>
                          <tr height="30">
                            <td colspan=2 align=center  bgcolor="F2F1E2" >������</td>
                            <td style="padding-left:5;"><input type="text" id=TEXT7 name="brd_recipient" value="<%=recipient%>" size="10" maxlength="7" class=textbox  readOnly="true">
                            	<input type="text" id=TEXT8 name="brd_recipient_name" value="<%=recipient_name%>" size="10" maxlength="20" class=textbox  readOnly="true">
	  							<input type="hidden" name="brd_creator" size="20" ID="Text2" value="<%=writer%>" class=textbox readonly>
                            <input type="hidden" name="brd_creator_name" size="20" ID="Text2" value="<%=writer_name%>" class=textbox readonly>
                            <input type="hidden" name="brd_passwd" size="14" maxlength='4' ID="Text3" value="0" class=textbox>
                            <input type="hidden" name="brd_subject" maxlength="40" size="10" ID="Text1" value="��������" class=textbox></td>
                          </tr>
                          <tr> 
                            <td colspan=3 height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr> 
                            <td colspan=3 style="padding: 6 6 6 6 ;" align=center>
							<!-- ���� : ������ ��� 2098-03-12 by �ɵ��� -->
							<FCK:editor id="brd_contents" basePath="/FCKeditor/" 
								width="440" height="300" 
								toolbarSet="memo_write" 
								imageBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector"
								linkBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector"
								flashBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Flash&Connector=connectors/jsp/connector"
								imageUploadURL="/FCKeditor/editor/filemanager/upload/simpleuploader?Type=Image"
								linkUploadURL="/FCKeditor/editor/filemanager/upload/simpleuploader?Type=File"
								flashUploadURL="/FCKeditor/editor/filemanager/upload/simpleuploader?Type=Flash">
								<%=content%>
							</FCK:editor>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan=3 height="1" bgcolor="D3D2C3"></td>
                          </tr>

			</form>                          

						<% //������ �ִ� ��� (����ȭ�� �Ǵ� �����Է½� ������ ���ε��� ��찡 �ƴ���
						if(fileRecord != null){                                                                
							StringBuffer sb = new StringBuffer();                                             
							String viewVirtual_name = "";                                                     
							String viewReal_name = "";                                                        
						                                                       
							for(int j=0; j<fileRecord.length; j++){	//���� ������ŭ
								Tbrd_attach_file_de_bean fbean = fileRecord[j];                                
								                                                       
								virtual_name		= Util.getString(fbean.getVirtual_name(),"");                  
								real_name			= Util.getString(fbean.getReal_name(),"");                       
						
								String img_name =  virtual_name;                                               
							                                                       
								if(virtual_name.lastIndexOf("/")>0){                                           
									viewVirtual_name = virtual_name.substring(virtual_name.lastIndexOf("/")+1);
								}                                                                              
								if(real_name.lastIndexOf("/")>0){                                              
									viewReal_name = real_name.substring(real_name.lastIndexOf("/")+1);         
								}                                                                              
								System.out.println("viewVirtual_name=>"+viewVirtual_name);               
								System.out.println("viewReal_name=>"+viewReal_name);                          
								
								//÷�ζ��� ���� html�ڵ� �����                     
								sb.append("<option value='"+viewVirtual_name +"'>"+viewReal_name+"</option>"); 
							}                                                                                 
							fullFilename = sb.toString();                                                     
						}                                                                                    
						%> 
                          
						<!-- ���� ÷�ο� ��-->
						<form name="fileForm" method="post" encType="multipart/form-data">
						<input type="hidden" name="realFileName">
						<input type="hidden" name="virtualFileName">
						<input type="hidden" name="mode">                          
                          <tr> 
                            <td bgcolor="F2F1E2" align=center>��<br>��<br>÷<br>��</td>
                            <td colspan=2 style="padding-left:10;padding-top:5px"><!-- ���� ���� ���ε� -->
							  <table width="100%" cellpadding="0" cellspacing="0" border=0>
								<tr>
								  <td width="305"><input type="text" name="file1" id="file1" style="width:300px;" value="÷���������ִ�5M���������մϴ�." readonly  class=textbox></td>
								  <td style="padding-left:8px">
                                      <div style="position:relative;left:0px;top:0px;height:19;width:40;background-image:url(http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_s_filesch.gif);background-repeat:no-repeat;">
                                      <input type='file' name='file_nm' onChange="this.form.file1.value=this.value" style="width:40;height:19;filter:alpha(opacity=0);"></div>
								  </td>
								</tr>
								<tr><td height="5" colspan="2"></td></tr>
								<tr>
								  <td>
									<select multiple name="fileList" style="width:300px;height:68px;border-color:#666666;background-color:#F5F2FB;font-weight:bold;">
                                         <%=fullFilename%>
									</select>
								  </td>
								  <td style="padding-left:8px" valign=top>
									<a href="javascript:tempUpload()"><img src="http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_s_upload.gif" border=0></a><br>
									<a href="javascript:fileDelete()"><img src="http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_s_del.gif" border=0></a>
								  </td>
								</tr>
							  </table>
							  �� <B>���ϸ��� ����</B>���� �÷��ּž� �ٿ�ε尡 ���� �۵��մϴ�.
							</td>
                          </tr>
						</form>

						<!-- ���� ������ ��-->
						<FORM METHOD=POST NAME="file_del">
						<input type="hidden" name="realFileName">
						<input type="hidden" name="virtualFileName">
						<input type="hidden" name="saveDir">
						<input type="hidden" name="mode">
						<input type="hidden" name="brd_gu" value="<%=brd_gu%>">
						</FORM> 
						<!-- ���� �ӽ� ���ε�� iFrame -->
						<iframe name="tempUpload" width="0" height="0" src="about:blank"></iframe>		
					                       
                          <tr> 
                            <td colspan=3 height="1" bgcolor="D3D2C3"></td>
                          </tr>
			              <tr>
			                <td colspan=3 align="center" style="padding-top:5px"><a href="javascript:send_ok();"><img src="<%=dirPath%>/Sales/images/b_ok.gif" alt="" border="0"></a>&nbsp;&nbsp;<a href="javascript:cancel();"><img src="<%=dirPath%>/Sales/images/b_cancel.gif" alt="" border="0"></a></td>
			              </tr>                          
                        </table>
                        
                        </td>
                    </tr>
                    <tr> 
                      <td height="50" align="center">&nbsp;</td>
                    </tr>
                  </table>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

<script language=javascript>
var workFlag = "<%=work_flag%>";
if(workFlag=="INSERT"){
	get_cookdata();
	document.form1.brd_creator.value=GetCookie("vusrid");//+ "("+GetCookie("vusrid")+")";
//	document.form1.brd_subject.focus();
};
</script>

<script language=javascript>
var workFlag = "<%=work_flag%>";
if(workFlag=="INSERT"){
	get_cookdata();
	document.form1.brd_creator_name.value=GetCookie("vusrnm");//+ "("+GetCookie("vusrid")+")";
//	document.form1.brd_subject.focus();
};
</script>
