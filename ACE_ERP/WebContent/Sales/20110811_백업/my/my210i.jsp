<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�       : ������
 * ���α׷�ID       : CU010i
 * J  S  P		: my210i
 * �� �� ��		: My210i
 * �� �� ��		: �̺���
 * �� �� ��     : 2006-05-16
 * �������		: �������� ����
 * [����  ����][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-03-11][�ɵ���] �� �Խ��� Ÿ������ ����. (FCKeditor)
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
   String dirPath = request.getContextPath(); //HDASan
   
   String ref = request.getParameter("ref");
   String ref_step = request.getParameter("ref_step");
   String ref_level = request.getParameter("ref_level");
   String work_flag = request.getParameter("work_flag");
   String brd_gu = "01";
   if (ref == null || ref.equals("")){
       ref = "0";
   }
   if (ref_step == null || ref_step.equals("")){
       ref_step = "0";
   }
   if (ref_level == null || ref_level.equals("")){
       ref_level = "0";
   }
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
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	}
<!--	
function send_ok(){
	var f = document.form1;
	
    if(f.brd_subject.value==""){alert("������ �Է��� �ּ���!");  f.brd_subject.focus(); return;}
   if(f.brd_creator.value==""){alert("�̸��� �Է��� �ּ���!");  f.brd_creator.focus(); return;}

   f.brd_contents.value = myEditor.editBox.document.body.innerHTML

   if(f.brd_contents.value==""){
      alert("������ �Է��� �ּ���!");
      return;
    }
   if(f.brd_passwd.value==""){alert("��й�ȣ�� �Է��� �ּ���!");  f.brd_passwd.focus(); return;}
   if (f.ref.value == "0"){ 
   	  f.work_flag.value = "INSERT";
   }
   else {
   	  f.work_flag.value = "REPLY";
   }
   
   f.action='my210p.jsp';
   f.target="";
   f.method = "POST";
   f.submit();
}
function cancel(){
	var f = document.form1;
	f.action='my210s.jsp';
	f.target='';
	f.method='POST';
	f.submit();
}
//-->
</script>

<script type="text/javascript" src="<%=dirPath%>/Common/js/fckeditor.js"></script>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

 					<table width="845" border=1 cellspacing="0" cellpadding="0" ID="Table1">
                      <form name="form1" enctype="MULTIPART/FORM-DATA">
                        <tr>
                          <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">�� &nbsp;&nbsp;&nbsp;��&nbsp;</font></b></td>
                          <td colspan="3" style="padding-top:3px">&nbsp;&nbsp;
                            <input type="text" name="brd_subject" maxlength="40" size="70" ID="Text1" value=""></td>
                        </tr>
                        <tr>
                          <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                        </tr>
                        <tr>
                          <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">�� �� ��&nbsp;</font></b></td>
                          <td style="padding-top:3px" colspan="3">&nbsp;&nbsp;
                            <input type="text" name="brd_creator" size="20" ID="Text2" value=""></td>
                        </tr>
                        <tr>
                          <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                        </tr>
                        <!-- tr>
              <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">÷������&nbsp;</font></b></td>
              <td style="padding-top:3px" colspan="3">&nbsp;&nbsp;
                <input type="file" name="file" size="60" ID="File1"></td>
            </tr-->
            <tr>
              <td bgcolor="E1E1E1" height="1" colspan="4"></td>
            </tr>
            <tr>
              <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">�� &nbsp;&nbsp;&nbsp;��&nbsp;</font></b></td>
              <td style="padding-top:3px" colspan="3">&nbsp;&nbsp;
               <iframe src="<%=dirPath%>/Sales/common/htmlEditor/myEditor.htm" frameborder="0" marginWidth=0 marginHeight=0 width="750" height="400" scrolling="no" name="myEditor"></iframe>
              </td>
            </tr>
            <tr>
              <td bgcolor="E1E1E1" height="1" colspan="4"></td>
            </tr>
            <tr>
              <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">��й�ȣ&nbsp;</font></b></td>
              <td style="padding-top:3px" colspan="3">&nbsp;&nbsp;
                <input type="password" name="brd_passwd" size="4" maxlength='4' ID="Text3"></td>
            </tr>
            <tr>
              <td bgcolor="E1E1E1" height="1" colspan="4"></td>
            </tr>
            <tr bgcolor="92C306">
              <td colspan="4" height="1"></td>
            </tr>
            <tr>
              <td colspan="4" align="center" style="padding-top:5px"><a href="javascript:send_ok();"><img src="../images/b_ok.gif" alt="" border="0"></a>&nbsp;&nbsp;<a href="javascript:cancel();"><img src="../images/b_cancel.gif" alt="" border="0"></a></td>
            </tr>
             <input type="hidden" name="brd_gu" value="<%=brd_gu%>">
             <input type="hidden" name="ref" value="<%=ref%>">
             <input type="hidden" name="ref_step" value="<%=ref_step%>">
             <input type="hidden" name="ref_level" value="<%=ref_level%>">
             <input type="hidden" name="work_flag">
             <input type="hidden" name="brd_contents">          
		  </form>
        </table>


<!-- �� �� -->
				<form name="form" method="post" action="insert.jsp" onSubmit="return goInsert()">
				<input type="hidden" name="category" value="category">
				<input type="hidden" name="status" value="0">
				
                  <table width="845" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td> 
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="94">
                      	   <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">�����</td>
                            <td style="padding-left:5;"><input type="text" name="regday" style="width:100px;height:20px"  maxlength=10 onClick=Calendar(this); readonly></td>
                          </tr>                      
                          <tr> 
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr> 
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">����</td>
                            <td style="padding-left:5;"> <input type="text" name="title" style="width:400px;height:20px" > </td>
                          </tr>
                          <tr> 
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>                         
                          <tr> 
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>����</p></td>
                            <td  style="padding: 10 10 10 10 ;">
<!--								<FCK:editor id="content" basePath="/Common/FCKeditor/" width="100%" height="300" 
									toolbarSet="asan" 
									customConfigurationsPath="/Common/js/fckconfig.js"
									imageBrowserURL="/Common/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector"
									linkBrowserURL="/Common/FCKeditor/editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector" >
								</FCK:editor>-->
								
			<FCK:editor id="EditorDefault" basePath="/HDAsan/FCKeditor/"
				width="100%" height="300" 
				toolbarSet="Default" 
				imageBrowserURL="/HDAsan/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector"
				linkBrowserURL="/HDAsan/FCKeditor/editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector"
				flashBrowserURL="/HDAsan/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Flash&Connector=connectors/jsp/connector"
				imageUploadURL="/HDAsan/FCKeditor/editor/filemanager/upload/simpleuploader?Type=Image"
				linkUploadURL="/HDAsan/FCKeditor/editor/filemanager/upload/simpleuploader?Type=File"
				flashUploadURL="/HDAsan/FCKeditor/editor/filemanager/upload/simpleuploader?Type=Flash">
				This is some <strong>sample text</strong>. You are using <a href="http://www.fredck.com/fckeditor/">FCKeditor</a>.
			</FCK:editor>
                            </td>
                          </tr>
                          <tr> 
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                        </table>
                        </td>
                    </tr>
                    <tr> 
                      <td align="right"   style="padding-top:5;"> 
                        <div align="right"><input type="image" src="<%=dirPath%>/Sales/images/b_ok.gif" width="40" height="20" border="0">
                        </div>
                      </td>
                    </tr>
                    <tr> 
                      <td height="50" align="center">&nbsp;</td>
                    </tr>
                  </table>
			</form>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

