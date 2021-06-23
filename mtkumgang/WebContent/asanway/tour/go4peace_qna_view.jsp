<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.board.Plz_BoardBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%
	Plz_BoardBean pb = new Plz_BoardBean();
	pb.Read(request, response);
	// 로그인 여부 체크
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
<SCRIPT LANGUAGE="JavaScript">
<!--
function write_ok() {
	var form = document.writeFrm;

	if(form.REPLY.value.length <= 0) {
		alert("답변 내용을 입력해 주세요.");
		form.REPLY.focus();
		return;
	} 

	form.submit();
}


function chk(){	
	
	f = document.mainForm;

  
    if(f.reply_content.value==""){
		alert ("답변 내용을 입력해주세요");
		f.reply_content.focus();
		return;
	}

	if(confirm("답변이 이메일로 발송됩니다. 등록하시겠습니까?")){
	    f.submit();
	}else{
		return;
	}



}


function openDel(){
	var form = document.writeFrm;
	if(confirm("정말 삭제하시겠습니까?")){
		
		form.action = "go4peace_	qna_delete_ok.jsp?idx="+<%= read.get("IDX") %>;
		form.submit();
	}else{
		return;
	}
}



//-->
</SCRIPT>
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
          		        <span class=locon>묻고답하기</span>
          		        </TD>
          	          </TR>
          	       <!-- //loc -->
          	       </TABLE>
                  </TD>
               </TR>
          	<TR valign=top>
                <!-- main -->
                <TD width=650 valign=top>
				<form name="writeFrm" action="go4peace_qna_modify_ok.jsp" method="post" enctype="multipart/form-data">
	  <input type="hidden" name="CATEGORY" value="qna">
	  <input type="hidden" name="MEM_ID" value="<%= read.get("MEM_ID") %>">
	  <input type="hidden" name="MEM_NAME" value="<%= Utility.ko((String)read.get("MEM_NAME")) %>">
	  <input type="hidden" name="idx" value="<%= idx %>">
	  <input type="hidden" name="EMAIL" value="<%=read.get("EMAIL") %>">
	  <input type="hidden" name="RPL_YN" value="Y">
	  
	  

                	<table width=650 border=0 cellspacing=0 cellpadding=0>
                	<tr>
                		<td>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                			<tr>
                				<td class='title'><img src=../img/tour_img/bu_blue_title.gif align=texttop class=rmar10>묻고답하기</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>
                
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<col width=100>
                				<tr><td colspan=6 height=2 class=linec1></td></tr>
                				<tr height=28>
                					<td class='tdcolor th' align=center>제목</td>
                					<td class=lpad10 colspan=7>
                					<%= Utility.ko((String)read.get("TITLE")) %>
                					</td>
                				</tr>
                				<tr><td colspan=6 height=1 class=linec0></td></tr>
                				<tr height=28>
                					<td class='tdcolor th' align=center>작성자</td>
                					<td class=lpad10><%= Utility.ko((String)read.get("MEM_NAME")) %>(<%=read.get("MEM_ID")%>)</td>
                					<td class='tdcolor th' align=center>등록일</td>
                					<td class=lpad10><%=read.get("REG_DATE").toString().substring(0,10)%></td>
                					<td class='tdcolor th' align=center>답변일</td>
                					<td class=lpad10><%=(read.get("RPL_DATE")==null ? "" : read.get("RPL_DATE").toString().substring(0,10))%></td>
                				</tr>
                				<tr><td colspan=6 height=1 class=linec0></td></tr>    
                				<tr height=28>
                					<td class='tdcolor th' align=center>이메일</td>
                					<td class=lpad10><%=read.get("EMAIL")%></td>
                					<td class='tdcolor th' align=center>연락처</td>
                					<td class=lpad10><%=read.get("TEL")%></td>
									<td class='tdcolor th' align=center></td>
                					<td class=lpad10>
									
									</td>
                				</tr>
                				<tr><td colspan=6 height=1 class=linec0></td></tr>
                				<tr height=28>
                                 <td class='tdcolor th' align=center valign=top style=padding-top:7;>문의내용</td>
                                 <td colspan=4 class=lpad10 style='padding-top:7;padding-bottom:7;' height=100 valign=top>
                                 <%=Utility.nl2br(Utility.ko((String)read.get("CONTENT")))%>
                                 </td>
                				</tr>
                				<tr><td colspan=6 height=1 class=linec1></td></tr>
                				<tr height=28>
                                 <td class='tdcolor th' align=center valign=top style=padding-top:7;>답변내용</td>
                                 <td colspan=4 class=lpad10 style='padding-top:7;padding-bottom:7;' height=100 valign=top>
                                 <textarea name=REPLY cols=75 rows=10><%=Utility.ko((String)read.get("REPLY"))%></textarea>
                                 
                                 </td>
                				</tr>
                				<tr><td colspan=6 height=1 class=linec1></td></tr>
                			</table>


							

                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                					<td align=right>
									<!--
                						<img src=../img//tour_img/btn_l.gif align=absmiddle><input type=button value=확인 onclick="location.href='tour_review_edit.jsp'" class=btn ><img src=../img//tour_img/btn_r.gif align=absmiddle><img src=../img//tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
                						<img src=../img//tour_img/btn_l.gif align=absmiddle><input type=button value=삭제 onclick="javascript:openDel()" class=btn ><img src=../img//tour_img/btn_r.gif align=absmiddle><img src=../img//tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
                						<img src=../img//tour_img/btn_l.gif align=absmiddle><input type=button value=목록 class=btn onclick="location.href='tour_review.jsp'"><img src=../img//tour_img/btn_r.gif align=absmiddle>
										-->
										<%// if(use_yn.equals("1")){%>
											<%// if(reply_yn.equals("0") ){ %>
											  <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=답변등록  class=btn onclick="javascript:write_ok()" ><img src=../img/tour_img/btn_r.gif align=absmiddle><img src=../img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
											<%//  }else{%>
											  <!--img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=답변수정  class=btn onclick="javascript:chk(this)" ><img src=../img/tour_img/btn_r.gif align=absmiddle><img src=../img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;-->
											<%//}%>
										     <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=질문삭제  class=btn onclick="javascript:openDel()" ><img src=../img/tour_img/btn_r.gif align=absmiddle><img src=../img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
									     <%//}%>
										<img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=목록 class=btn onclick="location.href='go4peace_qna.jsp?category=go4qna'"><img src=../img/tour_img/btn_r.gif align=absmiddle>         					
									 
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
