<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�        	: ����������
 * ���α׷�ID  	: CU010i
 * J  S  P 		: cu010i
 * �� �� ��      		: Cu010i
 * �� �� ��          	: �̺���
 * �� �� ��          	: 2006-05-16
 * �������         	: �������� (���)
 * ��������         	:
 * �� �� ��          	: 
 * ������������  	: 
 * TODO      	:
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
   	String out_login_id = "nkp0908";
   	String send_login_id = "0908nkp";
   	String send_ip = "100.200.1.152";
	String work_flag = request.getParameter("work_flag");	
	String send_date = request.getParameter("send_date");   

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
   <head>

 <jsp:include page="/Sales/common/include/head.jsp"/>
 <title></title>
<script language=javascript>
<!-- 
function send_ok(){
	var f = document.form1;
    if(f.brd_subject.value==""){alert("������ �Է��� �ּ���!");  f.brd_subject.focus(); return;}
    if(f.out_login_id.value==""){alert("�޴»���� �Է��� �ּ���!"); f.out_login.focus(); return;}

   f.brd_contents.value = myEditor.editBox.document.body.innerHTML

   if(f.brd_contents.value==""){
      alert("������ �Է��� �ּ���!");
      return;
    }
   
   f.action='my020p.jsp';
   f.target="";
   f.method="POST";
   f.submit();
}
function cancel(){
	var f = document.form1;
	f.action='my020s.jsp';
	f.target=''; 
	f.method='POST';
	f.submit();
}
//-->
</script>
   </head>
<!--------------------------------- BODY Start ------------------------------->
   <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   onLoad="namosw_init_slide_layers('layer1', 2); MM_preloadImages('<%=dirPath %>/Sales/images/com_top_m01.gif','<%=dirPath %>/Sales/images/com_top_m02.gif','<%=dirPath %>/Sales/images/com_top_m03.gif','<%=dirPath %>/Sales/images/com_top_m04.gif','<%=dirPath %>/Sales/images/com_top_m05.gif','<%=dirPath %>/Sales/images/com_top_m06.gif','<%=dirPath %>/Sales/images/com_top_m07.gif','<%=dirPath %>/Sales/images/com_top_m08.gif','<%=dirPath %>/Sales/images/com_top_m01_on.gif','<%=dirPath %>/Sales/images/com_top_m02_on.gif','<%=dirPath %>/Sales/images/com_top_m03_on.gif','<%=dirPath %>/Sales/images/com_top_m04_on.gif','<%=dirPath %>/Sales/images/com_top_m05_on.gif','<%=dirPath %>/Sales/images/com_top_m06_on.gif','<%=dirPath %>/Sales/images/com_top_m07_on.gif','<%=dirPath %>/Sales/images/com_top_m08_on.gif','<%=dirPath %>/Sales/images/com_top_m09_on.gif')">
      <table width="1000" height="100%" border="0" cellpadding="0" cellspacing="0">
         <tr>
            <td width="123" valign="top"><!--// ���̵�޴�--><jsp:include page="/Sales/common/include/left_mn1.jsp"/></td>  <!--// ���̵�޴� ��-->
            <td valign="top"><!--// ž�޴����� --> <jsp:include page="/Sales/common/include/top_mn.jsp"/></td> <!--// ž�޴� ��-->
         </tr>
         <tr>
             <td height="10"></td>
         </tr>
<!-- ���α׷� ���� BODY START -->
         <tr>
            <td align="center" valign="top">
               <table width="845" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                     <td><!-- Ÿ��Ʋ INCLUDE --><jsp:include page="/Sales/common/include/title.jsp"/></td><!-- Ÿ��Ʋ INCLUSDE �� -->
                  </tr>
           <!-- ���� �ڵ� �κ� ����  -->
                  <tr>
                     <td height="10"></td>
                  </tr>
                  <tr>
                     <td><table width="845" border="0" cellspacing="0" cellpadding="0" ID="Table1">
                          <form name="form1" enctype="MULTIPART/FORM-DATA" method="POST">
                            <tr>
                              <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">�� &nbsp;&nbsp;&nbsp;��&nbsp;</font></b></td>
                              <td colspan="3" style="padding-top:3px">&nbsp;&nbsp;
                                <input type="text" name="brd_subject" maxlength="40" size="70" ID="Text1" value=""></td>
                            </tr>
                            <tr>
                              <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                            </tr>
                            <tr>
                              <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">�޴»��&nbsp;</font></b></td>
                              <td style="padding-top:3px" colspan="3">&nbsp;&nbsp;
                                <input type="text" name="out_login_id" size="20" ID="Text2" value=""></td>
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
                              <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                            </tr>
                            <tr bgcolor="92C306">
                              <td colspan="4" height="1"></td>
                            </tr>
                            <tr>
                              <td colspan="4" align="center" style="padding-top:5px"><a href="javascript:send_ok();"><img src="../images/b_ok.gif" alt="" border="0"></a>&nbsp;&nbsp;<a href="javascript:cancel();"><img src="../images/b_cancel.gif" alt="" border="0"></a></td>
                            </tr>
                             <input type="hidden" name="work_flag">
                             <input type="hidden" name="brd_contents">
                             <input type="hidden" name="send_login_id" value="<%=send_login_id%>">
                             <input type="hidden" name="out_login_id">
                             <input type="hidden" name="send_ip" value="<%=send_ip%>">
                             <input type="hidden" naem="send_date">
                              </form>
                          </table></td>
                  </tr>
               <!-- ���� �ڵ� �κ� ��  -->
               </table>
            </td>
         </tr>
<!-- ���α׷� ���� BODY END -->
      </table>
<!---------------------------------- BODY End -------------------------------->
   </body>
</html>