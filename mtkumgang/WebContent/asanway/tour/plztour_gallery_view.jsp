<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.board.Plz_BoardBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%
	Plz_BoardBean pb = new Plz_BoardBean();
	pb.Read(request, response);
	// �α��� ���� üũ
	String memberlogin = (String)session.getAttribute("memberidx");
	String MEM_ID = (String)session.getAttribute("memberid");
	String MEM_NAME = (String)session.getAttribute("membername");
String idx = request.getParameter("idx");
	
%>
<jsp:useBean id="read" class="java.util.HashMap" scope="request" />
<html>
<head>
<link rel=stylesheet href=../css/tour_admin.css type=text/css>
<%@ include file="/asanway/common/head.jsp" %>
<script language="javascript">
<!--
function write_ok() {
	var form = document.writeFrm;

	if(form.TITLE.value.length <= 0) {
		alert("������ �Է��� �ּ���.");
		form.TITLE.focus();
		return;
	} else if(form.CONTENT.value.length <= 0) {
		alert("������ �Է��� �ּ���.");
		form.CONTENT.focus();
		return;
	}

	form.submit();
}

function openDel(){
	var form = document.writeFrm;
	if(confirm("���� �����Ͻðڽ��ϱ�?")){
		
		form.action = "plztour_gallery_delete_ok.jsp?idx="+<%= read.get("IDX") %>;
		form.submit();
	}else{
		return;
	}
}
-->
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
    <td valign="top">
      <table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" ><table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top" bgcolor="FCFCF6">
					<jsp:include page="/asanway/tour/left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6" align="right">
          <!--// IMJK START -->
          <TABLE cellspacing=0 cellpadding=0 width=650>
                <TR>
                  <TD>
          	      <TABLE cellspacing=0 cellpadding=0 width=650>
          	       <!-- loc -->
          	         <TR valign=top>
          		        <TD height=50 align=right style='padding-top: 10'>
          		        <img src="../img/tour_img/bu_sky.gif" align=absmiddle hspace=3><A HREF=# class=loc>Ȩ</A> > 
          		        <A HREF=# class=loc>������</A> > 
          		        <span class=locon>ȸ��������(PLZ)</A> </span></TD>
          	          </TR>
          	       <!-- //loc -->
          	       </TABLE>
                  </TD>
               </TR>
          	<TR valign=top>
                <!-- main -->
                <TD width=650 valign=top>
                	<table width=650 border=0 cellspacing=0 cellpadding=0>
                	<tr>
                		<td>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                			<tr>
                				<td class='title'><img src=../img/tour_img/bu_blue_title.gif align=texttop class=rmar10>ȸ��������(PLZ)</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>
                
                		<form name="writeFrm" action="plztour_gallery_modify_ok.jsp" method="post" enctype="multipart/form-data">
	  <input type="hidden" name="CATEGORY" value="gallery">
	  <input type="hidden" name="MEM_ID" value="<%= MEM_ID %>">
	  <input type="hidden" name="MEM_NAME" value="<%= MEM_NAME %>">
	  <input type="hidden" name="idx" value="<%= idx %>">
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<col width=100>
                				<tr><td colspan=2 height=2 class=linec1></td></tr>
                				<tr height=28>
                					<td class='tdcolor th' align=center>����</td>
                					<td class=lpad10>
                						<%= Utility.ko((String)read.get("TITLE"))%></td>
                				</tr>
                				<tr>
                					<td colspan=2 height=1 class=linec0></td>
                				</tr>
                				<tr height=28>
	                         <td class='tdcolor th' align=center valign=top style=padding-top:7;>����</td>
	                         <td class=lpad10 style='padding-top:7;padding-bottom:7;' height=150 valign=top>
															<% if(read.get("FILE_NAME0") != null) { %>
																<img src="/common/download.jsp?dir=plz&sysfilename=<%= read.get("FILE_NAME0") %>" onload="if(this.width>530) this.width=530;"><br><br>
															<% } %>
	                         <%= (read.get("CONTENT") == null) ? "" : Utility.nl2br(Utility.ko((String)read.get("CONTENT"))) %></td>
                				</tr>
                				<tr><td colspan=2 height=1 class=linec1></td></tr>
                			</table>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                                 <td align=right>
								  
                                  <!--img src=../img/tour_img/btn_l.gif align=absmiddle><input type=submit value=���� class=btn ><img src=../img/tour_img/btn_r.gif align=absmiddle><img src=../img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;-->
																  <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=���� onclick="location.href='javascript:openDel()'" class=btn ><img src=../img/tour_img/btn_r.gif align=absmiddle><img src=../img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
                                  <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=��� class=btn onclick="javascript:history.back();"><img src=../img/tour_img/btn_r.gif align=absmiddle>         					
                                 </td>
                				</tr>
                			</table>
                			</FORM>
                
                			<table border=0 cellspacing=0 cellpadding=0><tr><td height=50></td></tr></table>
                		</td>
                	</tr>
                	</table>
                </TD>
                <!-- //main -->
              </TR>
           </TABLE>  
          <!--// IMJK END -->
          </td>
        </tr>
      </table>
    </td>
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
<iframe id='uframe' name='uframe' src='about:blank' width=0 height=0 frameborder=0 border=0></iframe>
</body>
</html>
