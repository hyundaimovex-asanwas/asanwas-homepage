<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �� �� �� : �����
* �ۼ����� : 2005�� 10�� 20��
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
* 2005/11/12 : ����� : �亯�� �Խ������� ����
******************************************/
%>

<%@ page import="com.hmm.asan.asanway.admin.NoticeBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="java.util.HashMap" %>

<%
	String category = "adminnotice";
	NoticeBean nb = new NoticeBean(category);
	nb.Read(request, response);
%>

<jsp:useBean id="read" class="java.util.HashMap" scope="request" />
<jsp:useBean id="fileread" class="java.util.ArrayList" scope="request" />

<jsp:useBean id="preview" class="java.util.HashMap" scope="request" />
<jsp:useBean id="nextview" class="java.util.HashMap" scope="request" />

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>

<script language="javascript">

<!--
	function doDel(idx)
	{
		var idx = idx;

		if (confirm("�����Ͻðڽ��ϱ�?")) {
			location.href="/asanway/admin/admin_notice_action.jsp?cmd=D&idx="+idx;
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
					<jsp:include page="/asanway/common/admin_leftmenu.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>��� �Խ���</b></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr>
                            <td>
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr bgcolor="F2F1E2">
                                  <td width="100" height="30" align="center" bgcolor="DEDDCF">����</td>
                                  <td colspan="5" bgcolor="F2F1E2" style="padding-left:5;"><%= ( read.get("TITLE") == null ) ? "" : Utility.ko( (String)read.get("TITLE") ) %></td>
                                </tr>
                                <tr>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                </tr>
                                <tr>
                                  <td height="30" align="center" bgcolor="DEDDCF">�����
                                  </td>
                                  <td bgcolor="F2F1E2" style="padding-left:5;"><%= read.get("REGTIME").toString().substring(0, 10) %></td>
                                  <td width="80" align="center" bgcolor="DEDDCF">÷������</td>
                                  <td bgcolor="F2F1E2" td width="100" style="padding-left:5;">
                                  <table>
	                                  <tr><td>
    	                              <% if( fileread.size() == 0 ) { %>
    	                              ����.
    	                              <% } else {
    	                                  	for(int i = 0; i < fileread.size() ; i++) {
    	                                  	    HashMap hm = (HashMap)fileread.get(i);
    									%>
    									<tr>
    										<td><a href="/asanway/common/download.jsp?dir=adminnotice&filename=<%= Utility.ko((String)hm.get("FILE")) %>&sysfilename=<%= hm.get("SYSFILE") %>"><img src="../img/icon_file.gif" border="0"></a>
    	                                  <% } }  %>
	                                  </table>
                                  </td>
                                  <td width="80" align="center" bgcolor="DEDDCF">��ȸ </td>
                                  <td width="100" bgcolor="F2F1E2" style="padding-left:5;"><%= read.get("HIT") %></td>
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
                      <td >
                      <!-- ������ ������-->
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
						<% if( preview.size() != 0 ) { %>
                          <tr>
                            <td colspan="2" height="1" bgcolor="DBDACB"></td>
                          </tr>
                          <tr>
                            <td width="100" height="30" align="center" bgcolor="F2F1E2">������</td>
                            <td style="padding-left:5;"><a href="admin_notice_read.jsp?idx=<%= preview.get("IDX") %>"><%= Utility.ko( (String)preview.get("TITLE") )%></a></td>
                          </tr>
						<% } %>
                          <tr>
                            <td colspan="2" height="1" bgcolor="DBDACB"></td>
                          </tr>
						<% if( nextview.size() != 0 )  {%>
                          <tr>
                            <td width="100"  height="30" align="center" bgcolor="F2F1E2">������</td>
                            <td style="padding-left:5;"><a href="admin_notice_read.jsp?idx=<%= nextview.get("IDX") %>"><%= Utility.ko( (String)nextview.get("TITLE") ) %></a></td>
                          </tr>
                          <tr>
                            <td colspan="2" height="1" bgcolor="DBDACB"></td>
                          </tr>
						<% } %>
                        </table>
                        <!--  ������ ������-->
                      </td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;">
                      	  <a href="admin_notice_write.jsp?idx=<%= read.get("IDX") %>"><img src="../img/bt_27.gif"  border="0"></a>
                      	  <%if(read.get("REGUSER").toString().equals((String)session.getAttribute("adminidx")) || session.getAttribute("admingrade").toString().equals("0")){%>
	                      	 <a href="admin_notice_modify.jsp?idx=<%= read.get("IDX") %>"><img src="../img/bt_08.gif" width="40" height="20" border="0"></a>
	                     	 <a href="javascript:doDel('<%= read.get("IDX")  %>')"><img src="../img/bt_09.gif" width="40" height="20" hspace="3" border="0"></a>
	                      <%}%>
	                      <a href="admin_notice.jsp"><img src="../img/bt_10.gif" width="40" height="20" border="0"></a>
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
</body>
</html>
