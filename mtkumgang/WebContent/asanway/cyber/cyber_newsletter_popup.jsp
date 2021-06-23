<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : 김종문
* 작성날자 : 2005년 10월 27일
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>
<%@ page import="com.hmm.asan.asanway.cyber.NewsletterBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	String category = request.getParameter("category");
	
	NewsletterBean nb = new NewsletterBean();
	nb.Read(request, response);
%>

<jsp:useBean id="read" class="java.util.HashMap" scope="request" />


<%
	// 검색
	String searchkey = request.getParameter("searchkey");
	if(searchkey == null) searchkey = "";
	String searchvalue= request.getParameter("searchvalue");
	if(searchvalue == null) searchvalue = "";
%>

<html>
<head>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "16";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>

</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">



		<table width="600" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td valign="top" style="padding: 10 0 0 5;">
                
                 <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="76" valign="middle" align="center">
                      
					<img src="/asanway/common/download.jsp?filename=<%= Utility.ko((String)read.get("IMG"))%>&dir=newsletter&sysfilename=<%= Utility.ko((String)read.get("SYSIMG"))%>" border="0" style="width:580px;">
                      
                      </td>
                    </tr>
                    <tr> 
                    
                      <td background="../img/newsletter_popup_bg.gif" style="padding:0 20 0 20;">
                      
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td height="25"><img src="../img/bt_16.gif" width="6" height="11" hspace="4"> 
                              <b><font color="7A6D4E"><%= Utility.ko( (String)read.get("TITLE") ) %></font></b> </td>
                          </tr>
                          <tr> 
                            <td><font color="7A6D4E"><%= Utility.ko( (String)read.get("CONTENT") ) %></font> </td>
                          </tr>
                        </table>
                        
					</td>
                    </tr>
                    <tr> 
                      <td><img src="../img/newsletter_popup_01.gif" width="600" height="19"></td>
                    </tr>
                    <tr> 
                      <td>
                      
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td colspan="3"><img src="../img/newsletter_popup_footer_01.gif" width="600" height="19"></td>
                          </tr>
                          <tr> 
                            <td><img src="../img/newsletter_popup_footer_02.gif" width="524" height="19"></td>
                            <td><a href="#"><img src="../img/newsletter_popup_footer_04.gif" width="47" height="19" border="0"></a></td>
                            <td><img src="../img/newsletter_popup_footer_05.gif" width="29" height="19"></td>
                          </tr>
                          <tr> 
                            <td colspan="3"><img src="../img/newsletter_popup_footer_03.gif" width="600" height="16"></td>
                          </tr>
                        </table>
                       
                       </td>
                    </tr>
            <tr>
            <td>&nbsp;</td>
        	</tr>
    	</table>
    	
    	</td>
	</tr>
</table>
</body>
</html>
