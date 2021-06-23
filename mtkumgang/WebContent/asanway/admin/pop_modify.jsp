<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 10월 19일
* 요약 설명 : 운영자 리스트
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	AuthBean ab = new AuthBean();
	ab.CateList(request, response);
	ab.MenuList(request, response,request.getParameter("idx"));
	ab.Read(request,response);
%>
<jsp:useBean id="catelist" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="menulist" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="read" class="java.util.HashMap" scope="request" />

<html>
<head>
<%@include file="/asanway/common/head.jsp"%>

<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("admin_main.jsp?flag=1");
	}
%>
<script language="javascript">
	   <!--
   		function setAuthData(idx) {
			var form = document.frm;
			var obj_check = null;
			var obj = null;

			if(form.auth_check == null) return;

			if(form.auth_check.length == null) {
				obj = form.auth;
				obj_check = form.auth_check;
			} else {
				obj = form.auth[idx];
				obj_check = form.auth_check[idx];
			}

			if(obj_check.checked)
				obj.value = "1";
			else
				obj.value = "0";
		}

		function doDel(idx)
		{
			var idx = idx;

			if (confirm("삭제하시겠습니까?")) {
				location.href="/asanway/admin/admin_action.jsp?cmd=Delete&idx="+idx;
			}
		}

		function checkForm() {
			var form = document.frm;

			if(form.email.value == "") {
				alert("이메일을 입력해 주십시오.");
				form.email.focus();
				return false;
			}

			if(getBytes(form.email.value) > 100 ) {
				alert("이메일은 100자 이내로 입력해 주십시오.");
				form.email.focus();
				return false;
			}

			if(CheckEmail(form.email.value) == false) {
				alert("올바른 이메일 주소가 아닙니다. 다시 입력해 주십시오.");
				form.email.focus();
				return false;
			}

			if(form.password.value == "") {
				alert("비밀번호를 입력해 주십시오.");
				form.password.focus();
				return false;
			}

			if(getBytes(form.password.value) > 20 ) {
				alert("비밀번호는 20자 내로 입력해 주십시오.");
				form.password.focus();
				return false;
			}

			if(isAlphaNumCheck(form.password.value) == false) {
				alert("비밀번호는 영문과 숫자만 사용 가능합니다.");
				form.password.focus();
				return false;
			}

			if(form.password2.value == "") {
				alert("비밀번호를 한 번더 입력해 주십시오.");
				form.password2.focus();
				return false;
			}

			if(form.password.value != form.password2.value) {
				alert("비밀번호가 일치하지 않습니다. 다시 입력해 주십시오.");
				form.password2.focus();
				return false;
			}

			return true;
		}

	   //-->
   </script>

</head>

<body leftmargin="0" topmargin="0">
<form name=frm method=post  action=admin_action.jsp onSubmit="return checkForm();">
	<input type=hidden name=cmd value="Update">
	<input type=hidden name=idx value="<%=request.getParameter("idx")%>">
<table width="700" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../img/pop_bg_01.gif" width="20" height="14"></td>
    <td height="14" background="../img/pop_bg_02.gif">&nbsp;</td>
    <td align="right"><img src="../img/pop_bg_03.gif" width="20" height="14"></td>
  </tr>
  <tr>
    <td width="20" background="../img/pop_bg_04.gif">&nbsp;</td>
    <td height="40" bgcolor="234790"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td style="padding:6 0 0 3;"><img src="../img/pop_bl_01.gif" width="67" height="29"></td>
          <td align="right" valign="top"  style="padding:16 10 0 0 ;"><img src="../img/pop_bl_02.gif" width="54" height="10"></td>
        </tr>
      </table></td>
    <td width="20" background="../img/pop_bg_05.gif">&nbsp;</td>
  </tr>
  <tr>
    <td><img src="../img/pop_bg_06.gif" width="20" height="23"></td>
    <td background="../img/pop_bg_07.gif">&nbsp;</td>
    <td align="right"><img src="../img/pop_bg_08.gif" width="20" height="23"></td>
  </tr>
  <tr>
    <td background="../img/pop_bg_09.gif">&nbsp;</td>
    <td bgcolor="F1F1DB"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="30" valign="bottom" style="padding-bottom:5;"><img src="../img/bt_03.gif" width="10" height="14" hspace="5" align="absmiddle"><b><font color="#000000">운영자
            기본정보</font></b></td>
        </tr>
        <tr>
          <td height="5"></td>
        </tr>
        <tr>
          <td style="padding:0 10 0 10;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="1" bgcolor="C1B69C"></td>
                <td  bgcolor="C1B69C" colspan=3></td>
              </tr>
              <tr>
                <td height="10"></td>
                <td colspan=3></td>
              </tr>
              <tr>
                <td width="100" height="25"><img src="../img/bottom_02.gif" hspace="5" align="absmiddle">아이디</td>
                <td><font color="C1B69C">|</font> <%=read.get("ID")%></td>
                <td height="25"><img src="../img/bottom_02.gif" hspace="5" align="absmiddle">이름</td>
                <td><font color="C1B69C">|</font> <%=Utility.ko((String)read.get("NAME"))%></td>
              </tr>
              <tr>
                <td height="25"><img src="../img/bottom_02.gif" hspace="5" align="absmiddle">비밀번호</td>
                <td><font color="C1B69C">|</font> <input type="password" name="password" style="width:200px;height:20px" value="<%=read.get("PASSWORD")%>"></td>
              	<td height="25"><img src="../img/bottom_02.gif" hspace="5" align="absmiddle">비밀번호 확인</td>
                <td><font color="C1B69C">|</font> <input type="password" name="password2" style="width:200px;height:20px" value="<%=read.get("PASSWORD")%>"></td>
              </tr>
              <tr>
                <td height="25"><img src="../img/bottom_02.gif" hspace="5" align="absmiddle">이메일</td>
                <td><font color="C1B69C" colspan=3>|</font> <input type="text" name="email" style="width:200px;height:20px" value="<%=read.get("EMAIL")%>"></td>
              </tr>
              <tr>
                <td height="10"></td>
                <td colspan=3></td>
              </tr>
              <tr>
                <td height="1" bgcolor="C1B69C"></td>
                <td  bgcolor="C1B69C" colspan=3></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td height="10"></td>
        </tr>
        <tr>
          <td height="30" valign="bottom" style="padding-bottom:5;"><img src="../img/bt_03.gif" width="10" height="14" hspace="5" align="absmiddle"><b><font color="#000000">운영자
            기본권한</font></b></td>
        </tr>
        <tr>
          <td height="10"></td>
        </tr>
        <tr>
          <td>
          <div id=scroll style="width: 660; height: 170; overflow: auto">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td bgcolor="D6D3AF" height="1" colspan=<%=catelist.size()*2+1%>></td>
              </tr>

              <tr>
                <td width="1" bgcolor="D6D3AF"></td>
				<% if ( catelist.size() == 0 ) { %>
					<td>등록된 관리메뉴가 없습니다.</td>
					<td width="1" bgcolor="D6D3AF"></td>
				<%} else {
					int k = 0;
                	for(int i = 0; i < catelist.size(); i++) {
                		HashMap hmcate = (HashMap)catelist.get(i);
                %>
						<td align="center" valign=top>
							<table width="100%" border="0" cellspacing="0" cellpadding="0" >
								<tr>
									<td colspan=2 height=25 align=center bgcolor="E3E2C5"><%=Utility.ko((String)hmcate.get("NAME"))%></td>
								</tr>
								<tr>
					                <td bgcolor="D6D3AF" colspan=2></td>
					             </tr>
								<% if ( menulist.size() == 0 ) { %>
									<tr>
					                	<td height=20 colspan=2 align=center>관리메뉴없음.</td>
					             	</tr>
								<%} else {
					                	for(int j = 0; j < menulist.size(); j++) {
					                		HashMap hmmenu = (HashMap)menulist.get(j);
					                		if( hmmenu.get("CATEIDX").equals(hmcate.get("IDX")) ) {
					             %>
					             			<input type=hidden name=menuidx value=<%=hmmenu.get("IDX")%>>
											<input type=hidden name=auth value=<%=hmmenu.get("AUTH")%>>
											<tr height=20>
												<td width=80  style='word-break:break-all'>&nbsp;<%=Utility.ko((String)hmmenu.get("NAME"))%></td>
												<td width=10>
													<input type=checkbox name=auth_check onClick="setAuthData(<%=k%>)" <%if(hmmenu.get("AUTH").toString().equals("1")) out.println ("checked");%>>
												</td>
											</tr>
								<%		k++;
											}
					                  	}
					                  }
               					 %>

							</table>
						</td>
                		<td width="1" bgcolor="D6D3AF"></td>
                <%
	                  	}
	                  }
                %>

              </tr>

              <tr>
                <td bgcolor="D6D3AF" height="1" colspan=<%=menulist.size()*2+1%>></td>
              </tr>
            </table>
            </div>

           </td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
        </tr>
      </table></td>
    <td background="../img/pop_bg_10.gif">&nbsp;</td>
  </tr>
  <tr>
    <td><img src="../img/pop_bg_11.gif" width="20" height="10"></td>
    <td height="10" bgcolor="F1F1DB"></td>
    <td><img src="../img/pop_bg_12.gif" width="20" height="10"></td>
  </tr>
  <tr bgcolor="FCFCF6">
    <td height="25"></td>
	<td align="right" valign="top" style="padding-top:10;"><h3>
	<input type=image src="../img/pop_bt_03.gif" width="40" height="20" hspace="0" border="0">
	<a href="javascript:doDel(<%=request.getParameter("idx")%>);"><img src="../img/pop_bt_04.gif" width="40" height="20" hspace="4" border="0"></a>
	<a href="javascript:window.close();"><img src="../img/pop_bt_05.gif" width="40" height="20" hspace="0" border="0"></a>
	</h3></td>
	<td></td>
  </tr>
</table>
</form>
</body>
</html>
