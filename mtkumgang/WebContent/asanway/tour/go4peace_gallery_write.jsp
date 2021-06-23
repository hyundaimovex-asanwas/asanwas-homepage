<%--
  - 작성자: 이소연
  - 일자: 2006.07.26
  - 저작권 표시: IMJ Korea
  - 설명: 공지사항 > 상세보기 
  - 에디터 추가 (2007.07.28)
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%
	// 로그인 여부 체크
	String memberlogin = (String)session.getAttribute("memberidx");
	String MEM_ID = (String)session.getAttribute("memberid");
	String MEM_NAME = (String)session.getAttribute("membername");

	
%>
<html>
<head>
<link rel=stylesheet href=../css/tour_admin.css type=text/css>
<%@ include file="/asanway/common/head.jsp" %>
<script language="javascript">
<!--
function write_ok() {
	var form = document.writeFrm;

	if(form.TITLE.value.length <= 0) {
		alert("제목을 입력해 주세요.");
		form.TITLE.focus();
		return;
	} else if(form.CONTENT.value.length <= 0) {
		alert("내용을 입력해 주세요.");
		form.CONTENT.focus();
		return;
	}

	form.submit();
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
          		        <img src="../img/tour_img/bu_sky.gif" align=absmiddle hspace=3><A HREF=# class=loc>홈</A> > 
          		        <A HREF=# class=loc>고객센터</A> > 
          		        <span class=locon>공지사항</A> </span></TD>
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
                				<td class='title'><img src=../img/tour_img/bu_blue_title.gif align=texttop class=rmar10>공지사항</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>
                
                		<form name="writeFrm" action="go4peace_notice_write_ok.jsp" method="post" enctype="multipart/form-data">
	  <input type="hidden" name="CATEGORY" value="notice">
	  <input type="hidden" name="MEM_ID" value="<%= MEM_ID %>">
	  <input type="hidden" name="MEM_NAME" value="<%= MEM_NAME %>">
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<col width=100>
                				<tr><td colspan=2 height=2 class=linec1></td></tr>
                				<tr height=28>
                					<td class='tdcolor th' align=center>제목</td>
                					<td class=lpad10>
                					<input type=text name=TITLE style=width:450;>
                					</td>
                				</tr>
                				<tr><td colspan=2 height=1 class=linec0></td></tr>
                				<tr height=28>
                                                              <td class='tdcolor th' align=center valign=top style=padding-top:7;>내용</td>
                                                              <td class=lpad10 style='padding-top:7;padding-bottom:7;' height=150 valign=top>
                                                              <textarea name="CONTENT" rows="15" cols="86"></textarea> 
                                 </td>
                				</tr>
                				<tr><td colspan=2 height=1 class=linec1></td></tr>
                			</table>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                                 <td align=right>
								  
                                  <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=submit value=등록 class=btn ><img src=../img/tour_img/btn_r.gif align=absmiddle><img src=../img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
								 
								  
                                  
                                  
                                  <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=목록 class=btn onclick="javascript:history.back();"><img src=../img/tour_img/btn_r.gif align=absmiddle>         					
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
