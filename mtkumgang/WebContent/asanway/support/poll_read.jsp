<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.support.PollBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	PollBean bean = new PollBean();
	bean.Read(request, response);
%>

<jsp:useBean id="readitem" class="java.util.ArrayList" scope="request" />
<%
	HashMap read = (HashMap)readitem.get(0);

	int count = 0;
	for(int i = 0; i < readitem.size(); i++) {
	    HashMap hm = (HashMap)readitem.get(i);
	    
	    count += Integer.parseInt((String)hm.get("HIT"));
	}
%>
<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "31";
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

		if (confirm("삭제하시겠습니까?")) {
			// 확인 버튼을 눌렀을 때 실행해야 할 프로그램
			location.href="poll_delete.jsp?idx="+idx;
		} else {
			// 취소 버튼을 눌렀을 때 실행해야 할 프로그램
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
                <td valign="top" style="padding: 15 0 0 20;"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>설문</b></td>
                    </tr>
                    <tr> 
                      <td> <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr> 
                            <td> <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr bgcolor="F2F1E2"> 
                                  <td width="100" height="30" align="center" bgcolor="DEDDCF">제목</td>
                                  <td colspan="5" bgcolor="F2F1E2" style="padding-left:5;"><a href="company_message_read.htm"><%= Utility.ko( (String)read.get("TITLE") ) %></a></td>
                                </tr>
                                <tr> 
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td width="80" height="1" bgcolor="D3D2C3"></td>
                                  <td width="100" height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                </tr>
                                <tr> 
                                  <td height="30" align="center" bgcolor="DEDDCF">등록일 
                                  </td>
                                  <td colspan="3" bgcolor="F2F1E2" style="padding-left:5;"><%= read.get("REGTIME").toString().substring(0, 10) %></td>
                                  <td width="80" align="center" bgcolor="DEDDCF">참여 
                                  </td>
                                  <td width="100" bgcolor="F2F1E2" style="padding-left:5;"><%= count %></td>
                                </tr>
                              </table></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="5"></td>
                    </tr>
					<tr> 
                      <td height="10"></td>
                    </tr>
                    <tr> 
                      <td valign="top">
                      <% 
                      int percent = 0;
                      for( int i = 0; i < readitem.size(); i++) {
                          HashMap hm = (HashMap)readitem.get(i);
                          %>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td valign="top" style="padding:5 0 5 10;" width="100">항목<%= i+1 %><br></td>
                            <td width="92"  style="padding:5 5 5 10;" align="center">
                            	<table border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                                <tr> 
                                  <td>
                                  <!--  <img src="../img/img_default.gif"> -->
                                  <% if( hm.get("IMG") != null && !hm.get("IMG").equals("") ) { %>
                                  		<img src="/asanway/common/download.jsp?dir=poll&filename=<%= hm.get("IMG") %>&sysfilename=<%= hm.get("SYSIMG") %>" width="82"  height="62">                                  
	                              <% } else { %>
										<img src="../img/img_default.gif">
                                  <% }  %>
                                  </td>
                                </tr>
                              </table>
                             </td>
                            <td style="padding:5 10 5 10;">
                            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td height="20"><%= Utility.ko( (String)hm.get("ITEM") ) %></td>
                                </tr>
                                <tr>
                                
                                <% percent = Integer.parseInt((String)hm.get("HIT")) == 0  ? 0 : (int)(Integer.parseInt((String)hm.get("HIT")) /  (double)count *100);  %>
                                
                                  <td><img src="../img/m_n_bar02.gif" width="<%= ( percent * 3 ) %>" height="14" hspace="3" align="absmiddle">&nbsp;
                                  <b><%= Math.round( (Integer.parseInt((String)hm.get("HIT")) * 10 /  (double)count *100) ) / 10.0 %>%</b> 
                                    (<%= hm.get("HIT") %>명)</td>
                                </tr>
                              </table>
							</td>
                          </tr>
                          <tr>
                            <td colspan="3" background="../img/line_01.gif" height="1"></td>
                          </tr>
                          </table>
						<% }  %>
						
						</td>
                    </tr>
                    <tr> 
                      <td >&nbsp; </td>
                    </tr>
                    <tr> 
                      <td align="right"   style="padding-top:5;">
                      <a href="poll_modify.jsp?idx=<%= read.get("IDX") %>"><img src="../img/bt_08.gif" width="40" height="20" border="0"></a>
                      <a href="javascript:doDel('<%= read.get("IDX")  %>')"><img src="../img/bt_09.gif" width="40" height="20" hspace="3" border="0"></a>
                      <a href="poll_list.jsp"><img src="../img/bt_10.gif" width="40" height="20" border="0"></a></td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                  </table></td>
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
    <td height="30"  bgcolor="D4D4B2"><table width="850" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../img/bottom_01.gif" align="absmiddle"></td>
          <td align="right"><a href="#"><img src="../img/bottom_02_01.gif" border="0"></a></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>
