<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 		: ������ ����
 * ���α׷�ID 	: MY010S
 * J  S  P		: my010s
 * �� �� ��		: My020Manager,My020DAO,My020DTO,My010DAO
 * �� �� ��		: ����ǥ
 * �� �� ��		: 2006-06-26
 * �������		: ���������� (��ȸ)
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>
<%@ page import="sales.common.*"%>
<%@ page import="java.util.*, java.text.*,java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Set" %>
<%@ page import="sales.menu.my.My010Manager" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.org.util.CalendarUtil"%>
<%@ page import="sales.org.util.ClassUtil"%>
<%@ page import="sales.org.util.StringUtil"%>
<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan

   ArrayList data3 = new ArrayList();
   SmartRequest sr3 = new SmartRequest(request);
   String where_sql3     = "";

   int len3 = 0;
   BaseDataClass bean3;
   String key = request.getParameter("search_key");
   String values = request.getParameter("search_value");
   String out_login_id = "nkp0908";

   
   where_sql3 = "";
   if (values !=  null && !values.equals("")){
      where_sql3=" AND " + key + " like '%" + values + "%'";
   } 
   

   sr3.setObject("out_login_id",(Object)out_login_id);
   sr3.setObject("where_sql",(Object)where_sql3);
   My010Manager manager3 = new My010Manager();
   data3 = manager3.list(sr3);
 //     out.println(data3);
   manager3.close();

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

 <script> 
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	}
	
   function view_send(brd_no){
   	 var f = document.form1;
      f.action="my010v.jsp";
      f.brd_no.value = brd_no;
      f.method = "POST";
      f.target="";
      
      f.submit();
   }
   function sel_chk(){
    var f = document.form1;
      if(f.search_value.value==""){alert('�˻�� �־� �ּ���'); f.search_value.focus();  return;}
      f.action='my210s.jsp';
      f.taget='';
      f.method = "POST";
      f.submit();
   }
   function sel_chk_enter(){
   
      if(event.keyCode=="13"){
         sel_chk()
       }
   }
   function write_ok(){
    var f = document.form1;
       f.action='my210i.jsp';
       f.target='';
             f.method = "POST";
       f.submit();
   }
  
   </script>


</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		


<table width="845" border="0" cellspacing="0" cellpadding="0" ID="Table3">
<form name='form1' method='post'>
	<input type="hidden" name="brd_no" value="">
  <tr> 
	<td height="30" colspan='5'>
      <table border="0" cellspacing="0" cellpadding="0" ID="Table4">
		<tr> 
		  <td height="25">
			<select name="sel"  style="font-size=9pt;color : #ffffff ;background-color:#797979">
			<option value ="BRD_SUBJECT" >����</option>
			<option value ="BRD_SEND_LOGIN_ID" >�������</option>
			</select>&nbsp;					
		  </td>
		  <td width="86"><input type="text" name="str"  value="" size="12" style="height:19px; border:1 solid; border-color: #cccccc; font-size: 12px;" onKeyDown="javascript:sel_chk_enter(form1);" ID="Text1"></td>
		  <td width="34"><a href="javascript:sel_chk(this.form1);"><img src="<%=dirPath%>/Sales/images/b_search.gif" border="0"></a></td>
		</tr>
	  </table>
	</td>
  </tr>
  <tr> 
	<td height="2" colspan='5' bgcolor="#CEC8DD"></td>
  </tr>
  <tr bgcolor="#F3F0F9"> 
	<td width="50" align='center'><b><font color="#555555">��ȣ</font></b></td>
	<td width="425"align='center'><b><font color="#555555">����</font></b></td>
	<td width="60" align='center'><b><font color="#555555">÷������</font></b></td>
	<td width="110" align='center'><b><font color="#555555">�������</font></b></td>
	<td width="130" align='center'><b><font color="#555555">������</font></b></td>
  </tr>
  <tr> 
	<td height="1" colspan='5' bgcolor="#CEC8DD"></td>
  </tr>
  <tr> 
	<td width="100%" colspan=5><div id='hscroll_box'><div id='vscroll_box'>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0" ID="Table5">
        <%
           if(data3 == null || data3.size() < 1 ) {
        %>
		<tr>
		  <td colspan='5' align='center' height='200'><b>���������� �����ϴ�.</b></td>
		</tr>
        <%
           }
           else {
              len3 = data3.size();
              bean3 = null;
              int tocnt = data3.size();
              for(int h=0; h<len3; h++) {
                 bean3 = (BaseDataClass)data3.get(h);
        %>
  		<tr> 
          <td width="50" align='center' height='20'><%=tocnt--%></td>
          <td width="425" align='left'>&nbsp;&nbsp;<a href="javascript:view_send('<%=bean3.get("brd_no")%>');">  <%=bean3.get("brd_subject")%></a></td>
          <td width="60" align='center'><% if (bean3.get("real_file") == null || bean3.get("real_file").equals("")) {%><img src="<%=dirPath%>/Sales/images/file.gif" border="0">
		<% } %></td>
          <td width="110" align="center"><%=bean3.get("send_login_id")%></td>
          <td width="130" align="center"><%=bean3.get("send_date")%></td>
		</tr>
		<tr> 
          <td height=1 colspan='5'></td> 
		</tr>
		<tr>
		  <td height="1" colspan="6" background="<%=dirPath %>/Sales/images/line_pt.gif"></td>
		</tr>
     	<%
     			}
     		}
     	%>
	  </table>
	</td>
  </tr>
  <tr>
	<td height="4" colspan='6' bgcolor="#ECE9F1"></td>
  </tr>
</form>
</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

