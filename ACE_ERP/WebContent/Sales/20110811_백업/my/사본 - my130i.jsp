<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.HDConstant" %>
<%
/******************************************************************************
 * �ý��۸�      	: ����������
 * ���α׷�ID 	: MY130I
 * J  S  P      : my130i
 * �� �� ��      		: My130I
 * �� �� ��      		: ����ǥ
 * �� �� ��      		: 2006-06-15
 * �������      	: ���÷��ΰ���(���)
 * ��������      	:
 * �� �� ��      		: 
 * ������������    	: 
 * TODO         :
 * TODO         :
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description    :  JAVA Import 

%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description    :  �ڹ��ڵ�

   // ContextPath
    String dirPath = request.getContextPath(); //HDASan
   	String servletPath = "/services/servlet/sales.common.my.BaseServlet";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
   <head>
<!-- HEAD ���� -->
	<jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
         Style Sheet, Common Java Script Link
=============================================================================*/
%>
   
 <script> 
<!--
	function fnOnLoad(){
	
	}
	
	
	// ���
	function fnInsert() {
		if(document.all.real_files.value != "") {
			fnFileUpload();
		} else {
			fnInsert2();
		}
	}
	function fnInsert2() {
		var f = document.form1;
		
		f.action = "<%=dirPath%><%=servletPath%>";

		f.actId.value = "my130s";
		f.process_flag.value = '<%=HDConstant.PROCESS_TYPE_INSERET%>'; // �۾� Ÿ��
		f.brd_contents.value = myEditor.editBox.document.body.innerHTML;
		 
		f.brd_subject.value = document.all.brd_subject_1.value;
		f.brd_creator.value = document.all.brd_creator_1.value;
		f.method = "post";
		f.submit();
	}
	
	
	// ���  
	function fnCancel() {
		var f = document.form1;
		
		f.action = "<%=dirPath%><%=servletPath%>";

		f.actId.value = "my130s";
		f.process_flag.value = '<%=HDConstant.PROCESS_TYPE_SEARCH%>'; // �۾� Ÿ��

		f.method = "post";
		f.submit();
	}
	function fnFileUpload() {
		var f = document.fileForm;
		f.action = "<%=dirPath%>/Sales/my/fileUpload.jsp";
		f.target = "fileUploadFrame";
		f.submit();
	}
	
	//-->

  
   </script>
 
</head>
<!--------------------------------- BODY Start ------------------------------->
<jsp:include page="/Sales/common/include/body_s.jsp"/>
<!-- ���α׷� ���� BODY START -->
           <!-- ���� �ڵ� �κ� ����  -->
 				<table width="845" border="0" cellspacing="0" cellpadding="0" ID="Table1">
                            <tr>
                              <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">�� &nbsp;&nbsp;&nbsp;��&nbsp;</font></b></td>
                              <td colspan="3" style="padding-top:3px">&nbsp;&nbsp;
                                <input type="text" name="brd_subject_1" maxlength="40" size="70" ID="Text1" value=""></td>
                            </tr>
                            <tr>
                              <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                            </tr>
                            <tr>
                              <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">�� �� ��&nbsp;</font></b></td>
                              <td style="padding-top:3px" colspan="3">&nbsp;&nbsp;
                                <input type="text" name="brd_creator_1" size="20" ID="Text2" value=""></td>
                            </tr>
                            <tr>
                              <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                            </tr>
                             <form  name="fileForm" method="post" enctype="multipart/form-data">
                            <tr>
                              <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">÷������&nbsp;</font></b></td>
                              <td style="padding-top:3px" colspan="3">&nbsp;&nbsp;
                                <input type="file" name="real_files" size="60" ID="File1"></td>
                            </tr>
                             </form> 
                            <tr>
                              <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                            </tr>
                             <form name="form1">  
                            <tr>
                              <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">�� &nbsp;&nbsp;&nbsp;��&nbsp;</font></b></td>
                              <td style="padding-top:3px" colspan="3">&nbsp;&nbsp;
                                <!--==========================================//-->
                               <iframe src="<%=dirPath%>/Sales/common/htmlEditor/myEditor.htm" frameborder="0" marginWidth=0 marginHeight=0 width="750" height="400" scrolling="no" name="myEditor"></iframe>
                            <!--==========================================//-->
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
                              <td colspan="4" align="center" style="padding-top:5px">
                              <a href="javascript:fnInsert();"><img src="../images/b_ok.gif" alt="" border="0"></a>&nbsp;&nbsp;
                              <a href="javascript:fnCancel();"><img src="../images/b_cancel.gif" alt="" border="0"></a></td>
                            </tr>
                          </table></td>
                  </tr>
               <!-- ���� �ڵ� �κ� ��  -->
               </table>
            </td>
         </tr>
<!-- ���α׷� ���� BODY END -->
      </table>
       <input type="hidden" name="actId" 			value=""> 	<!-- �׼� ID -->
      
		<input type="hidden" name="process_flag" 	value=""> 	<!-- �۾� �÷��� -->
      	<input type="hidden" name="brd_contents" value=""> <!--  ���� -->
      	<input type="hidden" name="brd_subject" value="">	<!-- ���� -->
      	<input type="hidden" name="brd_creator" value=""> 	<!-- �ۼ���-->
      	<input type="text" name="real_file" 	value="">
      	<input type="text" name="sys_file" 	value="">
      	<iframe id="fileUploadFrame" 
          	name="fileUploadFrame"
			style="visibility:hidden; position:absolute; left:0px; top:0px;" 
			Frameborder="0" width="0px" height="0px">
		</iframe>   
         </form>
<!---------------------------------- BODY End -------------------------------->
    <jsp:include page="/Sales/common/include/body_e.jsp"/>

