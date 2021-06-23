<%--
  - 작성자: 김종섭 
  - 작성 일자: 2006.06.01
  - 최종 수정자 : 김종섭
  - 최종 수정일 : 2006.06.14
  - 저작권 표시: IMJ Korea
  - 설명: 실명확인페이지 , 로직은 실명을 확인하지 않고 , 가입자에 주민번호와 이름을 가지고
			중복가입 확인 여부만을 처리한다. 향후 실명확인 시스템 연동시 이 페이지를 이용하면
			된다.
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import= "com.hmm.asan.common.util.Utility"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ include file="/common/header.jsp" %>
<%
	//동의가 이루어 졌는지 확인 필요. step1
	//String sRefUrl = "";
	//if ( request.getHeader("Referer") != null ) sRefUrl = request.getHeader("Referer");
	//if ( sRefUrl.indexOf("join_agreement.jsp") == -1 ) response.sendRedirect("/member/join_agreement.jsp");

%>
<%
     String name   = new String();
     String regno1 = new String();
     String regno2 = new String();
     String returnUrl = new String();
     
     String resultName = new String();
     String resultJumin = new String();
     String resultJumin1 = new String();
     String resultJumin2 = new String();
     String resultCode = new String();
     
     name   = ParamUtil.getReqParameter(request.getParameter("name"),"");
     regno1 = ParamUtil.getReqParameter(request.getParameter("regno1"),"");
     regno2 = ParamUtil.getReqParameter(request.getParameter("regno2"),"");
     resultCode = ParamUtil.getReqParameter(request.getParameter("resultCode"),"");
     resultName = ParamUtil.getReqParameter(request.getParameter("resultName"),"");
     resultJumin = ParamUtil.getReqParameter(request.getParameter("resultJumin"),"");
     if (!resultJumin.equals("")){
        resultJumin1 = resultJumin.toString().substring(0,6);
        resultJumin2 = resultJumin.toString().substring(6,13);
     }
     returnUrl = "test1.hdasan.com/member/join_agreement.jsp";
     
     //실명 인증 서버로 연결 한다.
     //실명 인증 서버로 부터 return 을 받는다.
     if (name != "" && regno1 != "" && regno2 != ""){
          response.sendRedirect ("http://www.mtkumgang.com/webCom/cNameCheckWEB.asp?revJumin1="+regno1.trim()+"&revJumin2="+regno2.trim()+"&revName="+name.trim()+"&returnUrl="+returnUrl.trim());
          //http://www.mtkumgang.com/webCom/cNameCheckWEB.asp?revJumin1=751217&revJumin2=2036619&revName=이소연&returnUrl=test1.hdasan.com/member/join_agreement.jsp
     }else{
     
     }
    
%>
<%
  String McNum= "0";
  String sub= "0";
%>

<script language="JavaScript" src="<%=imageServer%>/tour_common/checkform.js"></script>

<script language="javascript">
<!--

	function checkForm()
	{
		var form = document.form;
		
		if (!form.agrck[0].checked == true){
		    alert("약관에 동의해 주십시오.");
		    return;
		}

		if (!form.privacy_chk[0].checked == true){
		    alert("개인정보취급방침에 동의해 주십시오.");
		    return;
		}
		
	    if(form.name.value == ""){
		   alert("이름을 입력해 주십시오");
		   form.name.focus();
		   return;
	    }
	    s_str = form.name.value;
	    if ( s_str.match(/\S/)==null ) {
		  alert("공백만 입력하면 안됩니다. 이름을 입력해 주십시오.");
		  form.name.focus();
		   return;
	    }
        
	    if(form.regno1.value == ""){
		   alert("주민번호를 입력해 주십시오");
		   form.regno1.focus();
		   return;
	    }
	    s_str = form.regno1.value;
	    if ( s_str.match(/\S/)==null ) {
		  alert("공백만 입력하면 안됩니다. 주민번호를 입력해 주십시오.");
		  form.regno1.focus();
		   return;
	    }	 
	    if(form.regno2.value == ""){
		   alert("주민번호를 입력해 주십시오");
		   form.regno2.focus(); 
		   return;
	    }   	    
	    s_str = form.regno2.value;
	    if ( s_str.match(/\S/)==null ) {
		  alert("공백만 입력하면 안됩니다. 주민번호를 입력해 주십시오.");
		  form.regno2.focus();
		   return;
	    }  
    
		var regno = form.regno1.value + form.regno2.value;
		if (!Jumin_Num_Check(regno) ) 
		{
			alert("유효하지 않은 주민등록번호입니다.");
			form.regno1.focus();
			return;
		}
		
		//form.action="join_agreement.jsp";
		form.action="member_action.jsp";
		form.submit();
		
	}


//-->
</script>
<html>
<head>
<title> 금강산관광      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../include/member/tour_member_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/tour_img/leftMenu07.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/mem/tit_mem01.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">회원가입</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>
<form name="form" method="post" >
 		<input type = hidden name=cmd value="C">
 		<input type = hidden name=mtype value="">
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/mem/img_top_mem01.jpg"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="19" class="bg_dblue" valign="top"><img src="<%=imageServer%>/tour_img/mem/txt_mem11.gif" style="margin:4 0 0 12px;"></td></tr>
						<tr>
							<td style="padding:7 2 7 7px;">
								<div style="width:678px;height:214px;overflow:auto;" class="div06">
<strong>제1장 총칙 </strong><br><br>

제1조(목적)<br>
 이 약관은 현대아산(주)가 제공하는 mt.KumGang서비스(이하 서비스라 합니다.)의 이용조건 및 절차에 관한 사항과 기타 필요한 사항을 규정함을 목적으로 합니다.<br><br>

제 2 조 (이용약관의 효력 및 변경)<br>
 ① 이 약관은 서비스 메뉴 및 회사에 게시하여 공시함으로써 효력이 발생합니다.<br>
 ② 회사는 합리적인 사유가 발생될 경우에는 이 약관을 변경할 수 있으며, 약관이 변경된 경우에는 지체 없이 이를 공시합니다.<br>
 ③ 회원제서비스 이용고객은 변경된 약관 사항에 동의하지 않으면 서비스 이용을 중단하고 이용계약을 해지할 수 있습니다. 약관의 효력발생일 이후의 계속적인 서비스 이용은 약관의 변경사항에 동의 한 것으로 간주합니다.<br><br>

제 3 조 (약관의 적용)<br>
 ① 이 약관에 명시되지 아니한 사항에 대해서는 관계법령 및 서비스별 안내의 취지에 따라 적용할 수 있습니다.<br><br>
	
제 4 조 (용어의 정의)<br>
 ① 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.<br>
   1. 회사라 함은 현대아산(주)을 말합니다.<br>
   2. 서비스라 함은 현대아산(주)에서 제공하는 각종 서비스를 말합니다.<br>
   3. 이용고객 이라 함은 회원제서비스를 이용하는 이용자를 말합니다.<br>
   4. 이용계약 이라 함은 서비스 이용과 관련하여 회사와 이용고객간에 체결하는 계약을 말합니다.<br>
   5. 이용자번호(ID)라 함은 이용고객의 식별과 이용고객의 서비스 이용을 위하여 이용고객이 선정하고 회사가 부여하는 문자와 숫자의 조합을 말합니다.<br>
   6. 비밀번호라 함은 이용고객이 부여받은 이용자번호와 일치된 이용고객임을 확인하고 이용고객의 권익보호를 위하여 이용고객이 선정한 문자와 숫자의 조합을 말합니다.<br>
   7. 단말기라 함은 회사가 제공하는 서비스를 이용하기 위해 이용고객이 설치한 개인용 컴퓨터 및 모뎀 등을 말합니다.<br><br>


<strong>제 2 장 약관의 효력</strong><br><br>
제 5 조 (서비스의 구분)<br>
 ① 서비스의 종류와 내용 등은 회사의 서비스별 안내에서 별도로 정하는 바에 의합니다.<br><br>
	
제 6 조 (이용계약의 성립 및 체결단위)<br>
 ① 이용계약은 이용고객의 이용신청에 대하여 회사의 이용승낙으로 성립합니다.<br><br>
	
제 7 조 (이용 신청 및 약관의 동의)<br>
 ① 회사는 현대아산(주) 약관에 동의하신 이용자에게 대부분의 서비스를 제공합니다.<br>
   이용자가 등록절차를 거쳐 동의 버튼을 누름으로써 이 서비스 약관에 동의한 것으로 간주합니다.<br><br>


<strong>제 3 장  이용자의 의무</strong><br><br>
제 8 조 (서비스의 보류 및 중지)<br>
 ① 회사는 다음 각 호에 해당하는 서비스 이용신청에 대하여는 승낙을 하지 않을 수 있습니다.<br>
   1.	타인 명의로 신청한 경우<br>
   2. 회원가입 등록정보에 기재한 내용이 허위임이 밝혀졌을 경우<br>
   3. 기타 이용신청고객의 귀책사유로 이용승낙이 곤란한 경우<br>
 ② 회사는 서비스 이용신청이 다음 각 호에 해당하는 경우에는 그 신청에 대한 승낙 제한사유가 해소될 때까지는 승낙을 하지 않을 수 있습니다.<br>
   1. 회사가 설비의 여유가 없는 경우<br>
   2. 회사의 기술상 지장이 있는 경우<br>
   3. 기타 회사의 귀책사유로 이용승낙이 곤란한 경우<br>
 ③ 회사는 제 2 항의 규정에 의하여 이용신청이 불승낙 되거나 승낙을 제한하는 경 우에는 이를 이용신청고객에게 즉시 알려야 합니다.<br>
 ④ 회사는 이용신청고객이 미성년자인 경우에는 서비스별 안내에서 정하는 바에 따라 승낙을 보류할 수 있습니다.<br><br>

제 9 조 (이용자 ID 부여 및 변경)<br>
 ① 회사는 회원제서비스 이용고객에 대하여 서비스별 약관에 정하는 바에 따라 이용자 ID를 부여합니다.<br>
 ② 이용자 ID는 다음 각 호에 해당하는 경우에는 이용고객 또는 회사의 요청에 의하여 변경 할 수 있습니다.<br>
   1. 이용자 ID가 이용자의 전화번호 또는 주민등록번호 등으로 등록되어 사생활 침해가 우려가 있는 경우<br>
   2. 타인에게 혐오감을 주거나 미풍양속에 어긋나는 경우<br>
   3. 기타 합리적인 사유가 있는 경우<br>
 ③ 이용고객은 이용자ID를 제 3 자에게 사용하게 할 수 없으며, 이용자ID 및 비밀번호 관리에 주의를 다하여야 합니다.<br>
 ④ 기타 이용자ID의 관리 및 변경 등에 관한 사항은 서비스별 안내에 정하는 바에 의합니다.<br><br>


<strong>제 4 장 서비스의 중지 및 종료</strong><br><br>
제 10 조 (천재지변)<br>
 ① 회사는 전시, 사변, 천재지변 또는 이에 준하는 국가비상사태가 발생하거나 발생할 우려가 있는 경우와 전기통신사업에 의한 기간통신사업자가 전기통신서비스를 중지하는 등기타 부득이한 사유가 있는 경우에는 서비스의 전부 또는 일부를 제한하거나 정지할 수 있습니다.<br>
 ② 회사는 제 1 항의 규정에 의하여 서비스의 이용을 제한하거나 정지한 때에는 그 사유 및 제한 기간 등을 지체 없이 이용고객에게 알려야 합니다.<br><br>

제 11 조 (서비스 중지)<br>
 ① 회사는 이용고객의 서비스 이용내용이 다음 각 호에 해당하는 경우에는 게시물을 삭제하거나 서비스의 전부 또는 일부의 이용을 제한하거나 정지할 수 있습니다.<br>
   1. 이용고객의 의무를 이행하지 아니한 경우<br>
   2. 서비스의 안정적인 운영을 방해하는 경우<br>
   3. 수신자의 의사에 반하는 음란, 저속, 위협적인 내용이나 광고성 정보, 전자우편 등을 지속적으로 전송하는 경우<br>
   4.	정보통신 설비의 오 동작이나 정보 등의 파괴를 유발시키는 컴퓨터 바이러스 프로그램을 유포하는 경우<br>
   5.	타인의 지적재산권을 침해하는 내용을 게시, 게재 , 전자메일 또는 기타의 방법으로 전송하는 경우<br>
   6. 정보통신윤리위원회의 시정요구가 있거나 불법선거운동과 관련하여 선거관리위원회의 유권해석을 받은 경우<br>
   7. 타인의 아이디(ID)와 비밀번호(PESSWORD)를 사용하는 경우<br>
   8. 서비스 정보를 이용하여 얻은 정보를 회사의 사전 승낙 없이 복제 또는 유통시키거나 상업적으로 이용하는 경우<br>
   9. 전기통신 관련법령 등에 위배되는 경우<br>
   10. 다른 사용자의 개인정보를 수집 또는 저장하는 경우<br>
   11. 당사의 승인을 받지 않고 광고 , 판촉물, 정크메일, 스팸, 행운의 편지 등 기타 다른 형태의 권유를 게시, 거재, 전자메일 또는 기타 방법으로 전송하는 경우<br>
   12. 제 3 자의 권리를 침해하거나 타인을 비방하는 경우 <br><br>

제 12 조 (서비스 이용 제한 및 해제)<br>
 ① 회사는 제 11 조의 규정에 의하여 서비스 이용 제한을 제한 하고자 하는 경우<br>
   그 사유와 일시 등을 이용고객에게 통지합니다.<br>
   다만, 회사가 긴급하게 이용을 정지할 필요가 있다고 인정하는 경우에는 그러하지 아니합니다.
 ② 제 1 항의 규정에 의하여 이용정지를 통지 받은 이용고객은 그 이용정지의 통지에 대해 이의가 있을 때에는 이의신청을 할 수 있습니다.<br>
 ③ 회사는 제 2 항의 규정에 의한 이의신청에 대하여 그 확인을 위한 기간까지 이용정지를 일시 연기할 수 있으며, 그 결과를 이용고객에게 통지합니다.<br>
 ④ 회사는 이용정지기간 중에 그 이용정지사유가 해소된 것이 확인된 경우에는 이용정지 조치를 즉시 해제합니다.<br><br>

제 13 조 (회원가입 등록 정보의 변경)<br>
 이용고객은 주소 등 회원가입 등록 정보를 변경하고자 하는 경우에는 서비스별 안내에 정하는 바에 의하여 이용계약 변경 신청서나 서비스 또는 전화등을 이용하여 변경할 수 있습니다.<br><br>

제 14 조 (이용종료)<br>
 ① 이 약관에 명시되지 않은 서비스의 이용종료에 관한 기준은 관계법령 및 서비스별 안내에서 정하는 바에 의합니다.<br><br>

제 15 조 (이용자의 개인정보보호)<br>
   회사는 관련 법령이 정하는 바에 따라서 이용자의 등록정보를 포함한 이용자의 개인정보를 보호하기 위하여 노력합니다.<br>
   이용자의 개인정보보호에 관해서는 관련 법령 및 회사가 정하는 "현대아산(주) 개인정보 보호정책"에서 정한 바에 의합니다.<br><br>

제 16 조 (면책)<br>
 ① 회사는 이용고객이 회사의 서비스 제공으로부터 기대되는 이익을 얻지 못하였거나 서비스 자료에 대한 취사선택 또는 이용으로 발생하는 손해 등에 대해서는 책임이 면제됩니다.<br>
 ② 회사는 이용고객의 귀책사유로 인하여 서비스 이용의 장애가 발생한 경우에는 책임이 면제됩니다.<br>
 ③ 회사는 이용자가 게시 또는 전송한 자료의 내용에 대해서는 책임이 면제됩니다.<br>
 ④ 회사는 이용자 상호간 또는 이용자와 제 3 자 상호간에 서비스를 매개로 하여 물품거래 등을 한 경우에는 책임이 면제됩니다.<br>
 ⑤ 회사는 모든 서비스의 자료 보관 및 전송에 관한 책임이 없으며 자료의 손실이 있는 경우에도 책임이 면제됩니다.<br>
 ⑥ 본 조에 정하지 않은 세부사항은 각 서비스별 이용규칙에 따라 현대아산(주)은 책임이 면제됩니다.<br>
 ⑦ 제8조 ①항에 의거 타인의 주민등록번호와 이름을 도용했을 경우, 그 책임은 이용자에게 있으며 회사는 책임이 면제됩니다.<br><br>


부 칙 (시행일) 이 약관은 2003년 04월 01일부터 시행합니다.
</div>
							</td>
						</tr>
						<tr><td height="1" class="line_dg"></td></tr>
						<tr>
						 <td height="40" align=center>
							<input type="radio" name="agrck" value="Y" class="noborder"><img src="<%=imageServer%>/tour_img/mem/txt_mem15.gif">
							&nbsp;&nbsp;&nbsp;
							<input type="radio" name="agrck" value="N" class="noborder">
							<img src="<%=imageServer%>/tour_img/mem/txt_mem16.gif">
                         </td>
						</tr>
						<tr><td height="40"></td></tr>
						</table>


						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="19" class="bg_dblue" valign="top">　<font color="white">개인정보 수집 및 이용에 대한 안내</font></td>
							<td class="bg_dblue" align=right><a href="/include/privacy.jsp"><font color="yellow"><b>개인정보취급방침 바로가기</b></font></a>　</td>
						</tr>
						<tr>
							<td style="padding:7 2 7 7px;" colspan=2>
<textarea id='xmlarea' name='xmlarea' rows='8' style='width : 100%;font-size : 12px;'>
■ 개인정보의 수집 및 이용목적

회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다..

 ο 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산
구매 및 요금 결제
 ο 회원 관리
회원제 서비스 이용에 따른 본인확인 , 개인 식별 , 불량회원의 부정 이용 방지와 비인가 사용 방지 , 불만처리 등 민원처리 , 고지사항 전달
 ο 마케팅 및 광고에 활용
이벤트 등 광고성 정보 전달 , 인구통계학적 특성에 따른 서비스 제공 및 광고 게재 , 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계
 ο 기타
관계기관에 관광객정보제공



■ 수집하는 개인정보 항목

회사는 회원가입, 상담, 서비스 신청 등등을 위해 아래와 같은 개인정보를 수집하고 있습니다.

ο 수집항목 : 이름 , 생년월일 , 성별 , 로그인ID , 비밀번호 , 자택 주소 , 휴대전화번호 , 이메일 , 회사명 , 직책 , 주민등록번호 , 신용카드 정보 , 쿠키 , 접속 IP 정보 , 결제기록
ο 개인정보 수집방법 : 홈페이지(회원가입, 게시판, 관광예약) , 전화/팩스를 통한 회원가입 , 경품 행사 응모 


■ 개인정보의 보유 및 이용기간

회사는 개인정보 수집 및 이용목적이 달성된 후에는 예외 없이 해당 정보를 지체 없이 파기합니다.
</textarea>
							</td>
						</tr>
						<tr><td height="1" class="line_dg" colspan=2></td></tr>
						<tr>
						 <td height="40" colspan=2 align=center>
							<input type="radio" name="privacy_chk" value="Y" class="noborder">동의
							&nbsp;&nbsp;&nbsp;
							<input type="radio" name="privacy_chk" value="N" class="noborder">동의하지 않습니다.
                         </td>
						</tr>
						<tr><td height="40" colspan=2></td></tr>
						</table>


						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="19" class="bg_dblue" valign="top"><img src="<%=imageServer%>/tour_img/mem/txt_mem12.gif" style="margin:4 0 0 12px;"></td></tr>
						<tr>
							<td style="padding:27 0 32 0px;" align="center">
								<table width="350" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td width="75"><img src="<%=imageServer%>/tour_img/mem/txt_mem13.gif"></td>
									<td width="275"><input type="text" name="name" value="<%=resultName%>" style="width:275px;" onkeypress="if (13 == event.keyCode) checkForm();" tabindex=1 ></td>
								</tr>
								<tr><td height="9" colspan="2"></td></tr>
								<tr>
									<td><img src="<%=imageServer%>/tour_img/mem/txt_mem14.gif"></td>
									<td class="txt_gray">
									<input type="text" name="regno1" maxlength="6" value="<%=resultJumin1%>" style="width:130px;" onkeyup=movenext(this.form.regno1,this.form.regno2,6)   tabindex=2> - 
									<input type="password" name="regno2" maxlength="7" value="<%=resultJumin2%>" style="width:131px;" onkeypress="if (13 == event.keyCode) checkForm();" tabindex=3>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td height="1" class="line_dg"></td></tr>
						<tr><td height="40"></td></tr>
						<tr><td align="center"><a href="javascript:checkForm();"><img src="<%=imageServer%>/tour_img/btn/btn_mem_confirm.gif" class="btn" alt="aaaaaaa"></a><a href="javascript:document.all.reset();"><img src="<%=imageServer%>/tour_img/btn/btn_mem_cancel.gif" class="btn"></a></td></tr>
						</table>
</form>
<%
     if (!resultCode.equals("") && !resultCode.equals("1")){
           out.println("<script language='javascript'>alert('실명 인증에 실패 하였습니다.');document.location='join_agreement.jsp';</script>");
     }else if(!resultCode.equals("") && resultCode.equals("1")){
           out.println("<script language='javascript'> document.form.action='member_action.jsp'; document.form.submit(); </script>");
     }else{
           
     }
%>
					</td>
				</tr>
				</table>
				<!--  content / -->
			</td>
		</tr>
		</table>
		<!--------  center area /-------->
	</td>
</tr>
<tr>
	<td valign="bottom">
		<!--/ footer -->           
        <%@ include file="../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>