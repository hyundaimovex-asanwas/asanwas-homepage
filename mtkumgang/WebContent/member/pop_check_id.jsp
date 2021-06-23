<%--
  - 작성자: 김종섭
  - 작성 일자: 2006.06.01
  - 최종 수정자 : 김종섭
  - 최종 수정일 : 2006.06.05
  - 저작권 표시: IMJ Korea
  - 설명: ID 중복확인 (가입시).
			action page : pop_check_id.jsp ( self page )
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>
<%@ include file="/common/properties.jsp" %>
<%@ page import="com.hmm.asan.www.member.MemberBean" %>

<%
	String msg = "";
	String msg_btn = "";
	String type = "";
	String id = request.getParameter("id");
	if(id == null) id = "";

	MemberBean bean = new MemberBean();
	int result = bean.IdCheck(request, response); //탈퇴 회원아이디 재 사용방지

	if (result == 0 ){	//사용가능
		type = "0";
		msg = "입력하신 아이디(<b class=red>"+id+"</b>)는 사용하실 수 있습니다.";
		msg_btn="Y";
	}else{					//이미 사용중임
		type = "1";
		msg = "입력하신 아이디(<b class=red>"+id+"</b>)는 이미 사용중인 아이디입니다.<br>다시 검색해 주십시오.";
		msg_btn="N";
	}

%>
<script language="JavaScript" src="<%=imageServer%>/tour_common/checkform.js"></script>
<script language="javascript">
	<!--
	function returnid(val) {
		if(val == "0"){			//사용가능
			var x=document.form.id.value;
			opener.document.form.id.value = x;
			opener.document.form.checkid.value = "1";
		}
		else{				//사용 불가
			opener.document.form.id.value = "";
		}
		window.close();
	}

	function idcheck(){
		var x=document.form.id;

		if (x.value==""){
			alert("아이디를 입력해 주세요");
			x.focus();
			return;
		}
		else{
			if (!is_range(x.value, 4, 10)) {
				alert("아이디는 4~10자리로 입력해 주십시오.");
				x.focus();
				return;
			}
			else if ( !isUserid(x) ){
				alert("아이디는 영문과 숫자만 사용하실 수 있습니다.");
				x.focus();
				return;
			}
		}
		
		document.form.submit();
	}
        
	 //-->
</script>
<html>
<head>
<title> 금강산관광   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
</head>

<body class="popmargin">

<!-- 팝업사이즈 : 450 * 337 -->
<table cellspacing="0" cellpadding="0" border="0" width="420">
<tr>
	<td>
			<!-- / 타이틀 -->
			<table cellspacing="0" cellpadding="0" border="0" width="420" height="65" class="bg_dblue">
			<tr valign="top">
				<td width="296" class="tpad_20 lpad_20"><img src="<%=imageServer%>/tour_img/mem/pop_tit_idcheck.gif"></td>
				<td width="124" class="tpad_20"><img src="<%=imageServer%>/tour_img/mem/pop_logo.gif"></td>
			</tr>
			</table>
			<!-- 타이틀 / -->
<form name="form" method="post" action="pop_check_id.jsp">
			<table cellspacing="0" cellpadding="0" border="0" width="420" height="65">
			<tr>
				<td height="114" align="center" class="tpad_10 bpad_10 lpad_15 rpad_15">
				<span class="txt_orange"><%=msg%>
				<%if (msg_btn !="N"){%>
				  <br><a href="javascript:returnid('<%=type%>')"><img src="<%=imageServer%>/tour_img/btn/btn_mem_iduse.gif" style="margin-top:22px;"></a><!-- 아이디 사용 -->
			    <%}%>
				</td>
			</tr>
			<tr><td height="1" class="line_g"></td></tr>
			<tr>
				<td height="43" align="center">
				<input type="text" name="id" value="<%=id%>" style="width:152px;">
				<a href="javascript:idcheck();"><img src="<%=imageServer%>/tour_img/btn/btn_s_idsamecheck.gif" hspace="5" align="absmiddle"></a><!-- 아이디중복확인 -->
				</td>
			</tr>
			<tr><td height="1" class="line_g"></td></tr>
			<tr>
				<td height="74" class="tpad_10 bpad_10 lpad_15 rpad_15"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_arw.gif" hspace="3" vspace="2" align="texttop">아이디는 영문, 숫자를 조합하여 4~10자리까지 가능하며, 특수기호나<br>&nbsp;&nbsp;공백은 입력하실 수 없습니다.</td>
			</tr>
			</table>
</form>	
			<!-- 하단바  --><table cellspacing="0" cellpadding="0" border="0" width="100%" height="8" class="bg_dblue"><tr><td></td></tr></table>
	</td>
</tr>
</table>

</body>
</html>
