<%--
  - 작성자: 김종섭 
  - 작성 일자: 2006.06.01
  - 최종 수정자 : 김종섭
  - 최종 수정일 : 2006.06.01
  - 저작권 표시: IMJ Korea
  - 설명: 가입자 정보 기록 페이지 , 기존 제작 페이지에서 추가된 사항만 수정함.
			 action page : member_action.jsp ,  cmd = "I"  : 가입
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.net.*" %>
<%@ page import= "com.hmm.asan.common.util.Utility"%>

<%
	//이전 단계에서 진행된 페이지(실명인증 페이지) 인지 점검 step 2.
	String sRefUrl = "";
	//if ( request.getHeader("Referer") != null ) sRefUrl = request.getHeader("Referer");
	//if ( sRefUrl.indexOf("member_action.jsp") == -1 ) response.sendRedirect("/member/join_agreement.jsp");
	
	String name = "";
	String regno1 = "";
	String regno2 = "";

	//주민등록번호
	String regno = regno1 + regno2;

	//이메일
	HashMap emailhm = new HashMap();
		emailhm.put("1","hanmail.net");
		emailhm.put("2","dreamwiz.com");
		emailhm.put("3","freechal.com");
		emailhm.put("4","hanmir.com");
		emailhm.put("5","hotmail.com");
		emailhm.put("6","korea.com");
		emailhm.put("7","lycos.co.kr");
		emailhm.put("8","naver.com");
		emailhm.put("9","netian.com");
		emailhm.put("10","yahoo.co.kr");
		emailhm.put("11","shinbiro.com");
		emailhm.put("12","paran.com");
		emailhm.put("13","nate.com");

	// 핸드폰 번호.
	String[] aMobileNum = {"010", "011", "016", "017", "019"};

	//전국 전화번호 국번
	String[] aTelNum = {"02", "031", "032", "033", "041", "042", "043", "051", "052", "053", "054", "055", "061", "062", "063", "064"};
%>
<%
  String McNum= "0";
  String sub= "0";
%>
<html>
<head>
<title> 금강산관광      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>

<script language="JavaScript" src="<%=imageServer%>/tour_common/checkform.js"></script>

<script language="javascript">

<!--
	function idcheck()
	{
		var x=document.form.id;

		if (x.value=="")
		{
			alert("아이디를 입력해 주세요");
			x.focus();
			return;
		}
		else
		{
			if (!is_range(x.value, 4, 10)) 
			{
				alert("아이디는 4~10자리로 입력해 주십시오.");
				x.focus();
				return;
			}
			else if ( !isUserid(x) )
			{
				alert("아이디는 영문과 숫자만 사용하실 수 있습니다.");
				x.focus();
				return;
			}
			else
			{
				var winOpts="width=450,height=337,scrollbars=no";
				var url = "/member/pop_check_id.jsp"+
					 "?id=" + x.value;
				 window.open(url,"IDCheck",winOpts);
			}
		}
	}

	function zip_search(val)
	{
		window.open('/member/pop_search_zip.jsp?type=' + val,'','width=450,height=460,top=200,left=200,scrollbars=no');
	}

	function getAddr()
	{
		var form = document.form;
		if(form.checkaddr.checked)
		{
			form.agentzip.value = form.zip.value;
			form.agentzip1.value = form.zip1.value;
			form.agentzip2.value = form.zip2.value;
			form.agentaddr1.value = form.addr1.value;
			form.agentaddr2.value = form.addr2.value;
		}
		else
		{
			form.agentzip.value = "";
			form.agentzip1.value = "";
			form.agentzip2.value = "";
			form.agentaddr1.value ="";
			form.agentaddr2.value = "";
		}
	}

	function checkForm()
	{
		var form = document.form;
		if( form.id.value=="" )
		{
			alert("아이디를 입력해 주십시오.");
			form.id.focus();
			return;
		}

		if (!is_range(form.id.value, 4, 10)) 
		{
			alert("아이디는 4~10자리로 입력해 주십시오.");
			form.id.focus();
			return;
		}

		if (!isUserid(form.id))
		{
			alert("아이디는 영문과 숫자만 사용하실 수 있습니다.");
			form.id.focus();
			return;
		}

		//비밀 번호 확인
		if( form.pwd.value=="" )
		{
			alert("비밀번호를 입력해 주십시오.");
			form.pwd.focus();
			return;
		}

		if (!is_range(form.pwd.value, 4, 10)) 
		{
			alert("비밀번는 4~10자리로 입력해 주십시오.");
			form.pwd.focus();
			return;
		}

		if (!isUserid(form.pwd))
		{
			alert("비밀번호는 영문과 숫자만 사용하실 수 있습니다.");
			form.pwd.focus();
			return;
		}

		if( form.pwd2.value=="" )
		{
			alert("비밀번호확인을 입력해 주십시오.");
			form.pwd2.focus();
			return;
		}

		if( form.pwd.value != form.pwd2.value )
		{
			alert("비밀 번호가 일치하지 않습니다. 다시 입력해 주십시오.");
			form.pwd2.value = "";
			form.pwd2.focus();
			return;
		}

		//이름,주민번호
		if( form.name.value=="" )
		{
			alert("이름을 입력해 주십시오.");
			form.name.focus();
			return;
		}

		var regno = form.regno1.value + form.regno2.value;
		if (!Jumin_Num_Check(regno) )
		{
			alert("유효하지 않은 주민등록번호입니다.");
			form.regno1.focus();
			return;
		}
		else
		{
			form.regno.value = regno;
		}

		//생년 월일
		if( form.birthdayy.selectedIndex == 0)
		{
			alert("생년월일을 입력하세요 .");
			form.birthdayy.focus();
			return;
		}

		if( form.birthdaym.selectedIndex == 0 )
		{
			alert("생년월일을 입력하세요 .");
			form.birthdaym.focus();
			return;
		}

		if( form.birthdayd.selectedIndex == 0 )
		{
			alert("생년월일을 입력하세요 .");
			form.birthdayd.focus();
			return;
		}

		if( form.birthdayd.selectedIndex != 0 && form.birthdayd.selectedIndex != 0 && form.birthdayd.selectedIndex != 0)
		{
			form.birthday.value = form.birthdayy.options[form.birthdayy.selectedIndex].value +form.birthdaym.options[form.birthdaym.selectedIndex].value +form.birthdayd.options[form.birthdayd.selectedIndex].value ;
		}
		else
		{
			alert("생년월일을 입력하세요 .");
			form.birthdayy.focus();
			return;
		}

		if( !form.birthgbn[0].checked  && !form.birthgbn[1].checked)
		{
			alert("생일 구분을  선택해 주세요 .");
			return;
		}

		//주소 입력 확인
		if( form.zip1.value=="" || form.zip2.value=="")
		{
			alert("우편번호를  입력해 주십시오.");
			form.zip1.focus();
			return;
		}
		else
		{
			form.zip.value = form.zip1.value + form.zip2.value;
		}

		if( form.addr1.value=="" || form.addr2.value=="")
		{
			alert("주소를  입력해 주십시오.");
			form.addr2.focus();
			return;
		}

		//전화번호
		if( form.tel1.value=="" || form.tel2.value=="" || form.tel3.value== "")
		{
			alert("전화번호 or 핸드폰번호 를 정확히  입력해 주십시오.");
			form.tel1.focus();
			return;
		}
		else if(isNumberCheck(form.tel1.value+form.tel2.value+form.tel3.value))
		{
			alert("전화번호 or 핸드폰번호 는 숫자만 입력 가능합니다..");
			form.tel1.focus();
			return;
		}
		else
		{
			form.tel.value = form.tel1.value + "-" + form.tel2.value+ "-" + form.tel3.value;
		}

		//이메일 확인
		if( form.email.value==""  )
		{
			alert("이메일 주소를   입력해 주십시오.");
			form.email.focus();
			return;
		}
		else if(!CheckEmail(form.email.value))
		{
			alert("올바른 이메일 주소가 아닙니다. 다시 입력해 주십시오.");
			form.email.focus();
			return;
		}
		
		//sms 수신여부
		if ( form.issmscheck.disabled == false ) 
		{
			if ( form.issmscheck.checked == true ) 
				form.issms.value = "0";
		} 

		//뉴스 수신여부
		if ( form.checkisletter.checked == true )
		{
			form.isletter.value = "1";
		}
		
		//ID중복 확인
		if( form.checkid.value=="" )
		{
			alert("ID중복확인을 해주십시오.");
			return;
		}
		//return true;
		form.submit();
	}

	//핸드폰 번호 선택시 SMS 문자표시 활성화.
	var bCheckSmsOk = false;
	function changeMobileChecked(obj)
	{
		var aMobileNum = new Array(); // 핸드폰 번호
		<%
			for(int j=0; j < aMobileNum.length; j ++ ) 
			{
				out.println("aMobileNum["+j+"] = '"+aMobileNum[j]+"'"); 
			}
		%>

		bCheckSmsOk = false;
		for(i=0; i < aMobileNum.length; i++)
		{
			if (aMobileNum[i] == obj.value)
			{
				bCheckSmsOk = true;
				break;
			}
		}

		if ( bCheckSmsOk )
			document.form.issmscheck.disabled = false;
		else
			document.form.issmscheck.disabled = true;
	}

//-->

</script>


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
<form name="form" method="post" action="member_action.jsp">
     	<input type="hidden" name="cmd" value="I">
     	<input type=hidden name=isreal value="0">
     	<input type=hidden name=area value="">
     	<input type=hidden name=checkid value="">
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/mem/img_top_mem02.jpg"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="19" class="bg_dblue" valign="top"><img src="<%=imageServer%>/tour_img/mem/txt_mem2.gif" style="margin:4 0 0 12px;"></td></tr>
						<tr><td height="35" align="right"><img src="<%=imageServer%>/tour_img/mem/txt_regist00.gif" hspace="10"></td></tr>
						</table>

						<!-- / insert table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="114"><col width="1"><col width="565" class="lpad_10">
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist01.gif"><!-- 이름 --></td>
							<td><input type="text" name="name" maxlength=20 style="width:152px;"></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist02.gif"><!-- 주민등록번호 --></td>
							<td class="txt_gray">
							<input type=hidden name="regno" value="<%=regno.trim()%>">
							<input type="text" name="regno1" style="width:152px;"  > - 
							<input type="text" name="regno2" style="width:152px;" ></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
						    <input type=hidden name="birthday" value="">
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist03.gif"><!-- 생년월일 --></td>
							<td>					
								<select name="birthdayy" style="width:58px" class="fs11">
                                  <option value="">선택</option>
                                  <%for(int i=Utility.getYear();i>=1900;i--){%>
                                  	<option value=<%=i%>><%=i%></option>
                                  <%}%>
								</select> 년							
								<select name="birthdaym" style="width:45px" class="fs11">
                                  <option value="">선택</option>
                                  <%for(int i=1;i<13;i++){%>
                                  	<option value="<%=Utility.toString(Integer.toString(i),2)%>" ><%=Utility.toString(Integer.toString(i),2)%></option>
                                  <%}%>
								</select> 월
								<select name="birthdayd" style="width:45px" class="fs11">
                                  <option value="">선택</option>
                                  <%for(int i=1;i<=31;i++){%>
                                  	<option value="<%=Utility.toString(Integer.toString(i),2)%>" ><%=Utility.toString(Integer.toString(i),2)%></option>
                                  <%}%>
								</select> 일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								
						
								<input type="radio" name="birthgbn" class="noborder" value="S"  checked>양력&nbsp;&nbsp;&nbsp;
								<input type="radio" name="birthgbn" class="noborder" value="M" >음력
							</td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist04.gif"><!-- 아이디 --></td>
							<td><input type="text" name="id" style="width:152px;" maxlength="10">
							<a href="javascript:idcheck()"><img src="<%=imageServer%>/tour_img/btn/btn_s_idsamecheck.gif" hspace="5" align="absmiddle"></a><!-- 아이디중복확인 --></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist05.gif"><!-- 비밀번호 --></td>
							<td><input type="password" name="pwd" style="width:152px;" maxlength="10"></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist06.gif"><!-- 비밀번호 확인 --></td>
							<td><input type="password" name="pwd2" style="width:152px;" maxlength="10"></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
						    <input type=hidden name="zip" value="">
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist07.gif"><!-- 우편번호 --></td>
							<td>
							<input type="text" name="zip1" style="width:50px;" maxlength="3"> - 
							<input type="text" name="zip2" style="width:50px;" maxlength="3"> - 
							<a href="javascript:zip_search('mem');"><img src="<%=imageServer%>/tour_img/btn/btn_s_postsch.gif" hspace="5" align="absmiddle"></a><!-- 우편번호검색 --></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist08.gif"><!-- 주소 --></td>
							<td><input type="text" name="addr1" style="width:463px;" maxlength="100"></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist09.gif"><!-- 나머지 주소 --></td>
							<td><input type="text" name="addr2" style="width:463px;" maxlength="100"></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr><td height="10" colspan="3"></td></tr>
						<tr>
							<td height="26"><img src="<%=imageServer%>/tour_img/mem/txt_regist10.gif"><!-- 연락처 --></td>
							<td class="bg_dgray"></td>
							<td>
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr>
								    <input type=hidden name="tel" value="">
									<td  class="gray">
									<select name="tel1" style="width:45px" class="fs11" onChange="changeMobileChecked(this)">
										<option value="">선택</option>
										<%for ( int i = 0 ; i < aMobileNum.length; i++) { %>
												<option value=<%=aMobileNum[i]%>><%=aMobileNum[i]%></option>
										<%}%>
										<option value="">---</option>
										<%for ( int i = 0 ; i < aTelNum.length; i++) { %>
												<option value=<%=aTelNum[i]%>><%=aTelNum[i]%></option>
										<%}%>
									</select> - 
									<input type="text" name="tel2" style="width:82px;" maxlength="4"> - 
									<input type="text" name="tel3" style="width:82px;" maxlength="4"></td>
								</tr>
								<tr valign="top">
								    <input type=hidden name=issms value="">
									<td class="tpad_3 fs11 lh14">
									<input type="checkbox" name="issmscheck" class="noborder" disabled>
									<span class="txt_sky">금강산관광      홈페이지에서 제공하는 정보를 문자 메시지(SMS)로 받겠습니다.</span><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SMS 수신을 원하시면 이동전화 번호를 등록하여 주십시오.</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td height="7" colspan="3"></td></tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr><td height="10" colspan="3"></td></tr>
						<tr>
							<td height="26"><img src="<%=imageServer%>/tour_img/mem/txt_regist11.gif"><!-- 이메일 주소 --></td>
							<td class="bg_dgray"></td>
							<td>
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td  class="gray"><input type="text" name="email" style="width:321px;" maxlength="100"></td>
								</tr>
								<tr valign="top">
								    <input type=hidden name=isletter value="">
									<td class="tpad_3 fs11">
									<input type="checkbox" name="checkisletter" class="noborder">
									<span class="txt_sky">금강산관광      홈페이지에서 제공하는 메일링 서비스를 받겠습니다.</span></td>
								</tr>
								<tr valign="top">
									<td class="tpad_3 fs11 lh14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1:1 상담, 고객관련 서비스 및 비밀번호 찾기에 필요합니다.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;주로 사용하시는 이메일 주소를 입력하여 주시고, 다음 한메일(hanmail.net)은 메일 수신이 되지<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;않을 수 있으니 가급적 사용을 자제하여 주십시오.</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td height="7" colspan="3"></td></tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						</table>
						<!-- insert table / -->
</form>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="30"></td></tr>
						<tr><td align="center">
						<a href="javascript:checkForm();"><img src="<%=imageServer%>/tour_img/btn/btn_mem_regist.gif" class="btn"></a>
						<a href="javascript:document.form.reset();"><img src="<%=imageServer%>/tour_img/btn/btn_mem_cancel.gif" class="btn"></a></td></tr>
						</table>
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