<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�       : ����
 * ���α׷�ID       : CU010i
 * J  S  P      : cu010i
 * �� �� ��      : Cu010i
 * �� �� ��          : �̺���
 * �� �� ��          : 2006-05-16
 * �������         : �븮�� ���� (��ȸ ��� ���� ����)
 * ��������         :
 * �� �� ��          : �̺���
 * ������������  : 2006-05-16
 * TODO       :
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description    :  JAVA Import

%>
<%@ page import="sales.common.*"%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description    :  �ڹ��ڵ�


   // ContextPath
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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
   <head>
<!-- HEAD ���� -->
	<jsp:include page="/Sales/common/include/head.jsp"/>
      <title>[CU032] �븮������ ���� </title>

<%
/*=============================================================================
         Style Sheet, Common Java Script Link
=============================================================================*/
%>
<script language=javascript>
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

   	  f.work_flag.value = "REPLY";
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
   </head>
<!--------------------------------- BODY Start ------------------------------->
<jsp:include page="/Sales/common/include/body_s.jsp"/>
<!-- ���α׷� ���� BODY START -->
           <!-- ���� �ڵ� �κ� ����  -->
 				<table width="845" border="0" cellspacing="0" cellpadding="0" ID="Table1" >
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
                            <tr>
                              <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">÷������&nbsp;</font></b></td>
                              <td style="padding-top:3px" colspan="3">&nbsp;&nbsp;
                                <input type="file" name="file" size="60" ID="File1"></td>
                            </tr>
                            <tr>
                              <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                            </tr>
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
                                <input type="text" name="brd_passwd" size="4" maxlength='4' ID="Text3"></td>
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
                             <input type="text" name="ref" value="<%=ref%>">
                             <input type="hidden" name="ref_step" value="<%=ref_step%>">
                             <input type="hidden" name="ref_level" value="<%=ref_level%>">
                             <input type="hidden" name="work_flag">
                             <input type="hidden" name="brd_contents">          
                              </form>
                          </table></td>
                  </tr>
               <!-- ���� �ڵ� �κ� ��  -->
               </table>
            </td>
         </tr>
<!-- ���α׷� ���� BODY END -->
      </table>
      <jsp:include page="/Sales/common/include/body_e.jsp"/>
<!---------------------------------- BODY End -------------------------------->
   </body>
</html>