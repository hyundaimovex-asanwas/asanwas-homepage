<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �� �� �� : Mr.K JM
* �ۼ����� : 2005�� 10�� 25��
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>

<%
	String category = request.getParameter("category");
	if(category == null) category = "openevent1";
	
	String t = "";
	if( category.equals("openevent1") ) t = "�����̺�Ʈ1";
	if( category.equals("openevent2") ) t = "�����̺�Ʈ2";
%>

<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.support.EventBean1" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	EventBean1 sb = new EventBean1();
	sb.Read(request, response);
%>
<jsp:useBean id="read" class="java.util.HashMap" scope="request" />

<%@ page import="java.text.SimpleDateFormat" %>
<%
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yyyyMMdd");
	String ymd = myformat.format(yymmdd);	// 20051101
%>

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "30";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("support_main.jsp?flag=1");
	}
%>


<script language="javascript">

<!--
	function doDel(idx)
	{
		var idx = idx;

		if (confirm("�����Ͻðڽ��ϱ�?")) {
			// Ȯ�� ��ư�� ������ �� �����ؾ� �� ���α׷�
			location.href="event_delete.jsp?category=<%= category %>&idx="+idx;
		} else {
			// ��� ��ư�� ������ �� �����ؾ� �� ���α׷�
		}
	}
//-->

</script>


</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">

<jsp:include page="/asanway/common/top.jsp" flush="true" />

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="25" bgcolor="E4E3C3">
    	<jsp:include page="/asanway/common/topbutton.jsp" flush="true" />
	</td>
  </tr>
  <tr> 
    <td valign="top"><table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" ><table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                 <td valign="top" bgcolor="FCFCF6">
					<jsp:include page="left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td valign="top" style="padding: 15 0 0 20;"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b><%= t %></b></td>
                    </tr>
                    <tr> 
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr> 
                            <td> 
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td height="1" bgcolor="D3D2C3" colspan="6"></td>                                                                    
                                </tr>                                                                
                                <tr bgcolor="F2F1E2"> 
                                	<td width="100" height="30" align="center" bgcolor="DEDDCF">�ۼ���</td>
                                	<td width="100" bgcolor="F2F1E2" style="padding-left:5;"><%= Utility.ko( (String)read.get("NAME"))  %></td>
                                	<td width="100" height="30" align="center" bgcolor="DEDDCF">�����</td>
                                	<td width="100" bgcolor="F2F1E2" style="padding-left:5;"><%= read.get("REGTIME").toString().substring(0,10) %></td>
                                	<td width="100" height="30" align="center" bgcolor="DEDDCF">��õ��</td>
                                	<td width="100" bgcolor="F2F1E2" style="padding-left:5;"><%= read.get("HIT") %></td>                                	                                	
                                </tr>    
                                <tr> 
                                  <td height="1" bgcolor="D3D2C3" colspan="6"></td>                                                                    
                                </tr>                                                                                                                            
                                <tr bgcolor="F2F1E2"> 
                                  <td width="100" height="30" align="center" bgcolor="DEDDCF">����</td>
                                  <td bgcolor="F2F1E2" style="padding-left:5;" colspan="5"><%= Utility.ko( (String)read.get("TITLE") ) %></td>
                                </tr>                                
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td height="5"></td>
                    </tr>
                    <tr> 
                      <td valign="top" style="padding:10 10 10 10;"><%= Utility.ko( (String)read.get("CONTENT") ) %></td>
                    </tr>
                    <tr> 
                      <td height="7"></td>
                    </tr>                                                              
                     
                    <tr> 
                      <td height="2" bgcolor="D3D2C3"></td>
                    </tr>                                       
                    <tr> 
                      <td align="right"   style="padding-top:5;">
                      <a href="javascript:doDel('<%= read.get("IDX")  %>')"><img src="../img/bt_09.gif" width="40" height="20" hspace="3" border="0"></a>
                      <a href="event_list1.jsp?category=<%= category %>"><img src="../img/bt_10.gif" width="40" height="20" border="0"></a>
                      </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td bgcolor="E4E3C3" height="10"></td>
  </tr>
  <tr> 
    <td  height="15"></td>
  </tr>
  <tr> 
    <td height="30"  bgcolor="D4D4B2">
		<jsp:include page="/asanway/common/copyright.jsp" flush="true" />
    </td>
  </tr>
</table>

<iframe id='cframe' name='cframe' src='about:blank' width=0 height=0 frameborder=0 border=0></iframe>

</body>
</html>
