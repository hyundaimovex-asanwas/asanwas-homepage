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
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>
<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan

   	String out_login_id = "nkp0908";
   	String send_login_id = "0908nkp";
   	String send_ip = "100.200.1.152";
	String work_flag = request.getParameter("work_flag");	
	String send_date = request.getParameter("send_date");   

%>

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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

                        <table width="845" border="0" cellspacing="0" cellpadding="0" ID="Table1">
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
                          </table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

