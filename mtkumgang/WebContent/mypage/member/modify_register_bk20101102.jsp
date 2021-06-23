<%--
  - 작성자: 김종섭
  - 작성 일자: 2006.06.08
  - 최종 수정자 : 이소연
  - 최종 수정일 : 2006.08
  - 저작권 표시: IMJ Korea
  - 설명: 회원가입 정보 변경 
			변경 불가 : 아이디와 성명, 주민번호
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ include file="/common/header.jsp" %>
<%@ page import="com.hmm.asan.www.member.MemberBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.net.*" %>
<html>
<head>
<title> 금강산관광      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/checkform.js"></script>
</head>

<body>

<%//로그인 체크 %>
<%@ include file="/common/logincheck.jsp" %>
<%
  String pageNum  = "1";
  String McNum = "0";
  String sub = "0";
%>
<%
    
	MemberBean bean = new MemberBean();
	bean.Read(request, response);

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

<jsp:useBean id="read" class="java.util.HashMap" scope="request" />
<%
	String ISTRAVEL = "";
	if (read.get("ISTRAVEL") == null){
		ISTRAVEL = "";
	}else{
		ISTRAVEL = read.get("ISTRAVEL").toString();
	}

	String ISLETTER = "";
	if (read.get("ISLETTER") == null){
		ISLETTER = "";
	}else{
		ISLETTER = read.get("ISLETTER").toString();
	}

	//우편번호 : 내용이 없는 경우 substring 에 의한 에러 대처
	String sZip1 = "";
	String sZip2 = "";
	if ( read.get("ZIP") != null && !read.get("ZIP").toString().equals("") )
	{
		sZip1 = read.get("ZIP").toString().substring(0,3);
		sZip2 = read.get("ZIP").toString().substring(3,6);
	}
%>
<script language="javascript">

<!--
	function zip_search(val){
		window.open('/member/pop_search_zip.jsp?type=' + val,'','width=450,height=460,top=200,left=200,scrollbars=no');
	}

	function checkForm(mtype){
		var form = document.form;
		
		//주민번호
		form.regno.value = form.regno1.value + form.regno2.value;

		//비밀 번호 확인
		if( form.pwd.value=="" ){
			alert("비밀번호를 입력해 주십시오.");
			form.pwd.focus();
			return false;
		}

		if (!is_range(form.pwd.value, 4, 10)) {
			alert("비밀번는 4~10자리로 입력해 주십시오.");
			form.pwd.focus();
			return false;
		}

		if (!isUserid(form.pwd)) {
			alert("비밀번호는 영문과 숫자만 사용하실 수 있습니다.");
			form.pwd.focus();
			return false;
		}

		if( form.pwd2.value=="" ){
			alert("비밀번호확인을 입력해 주십시오.");
			form.pwd2.focus();
			return false;
		}

		if( form.pwd.value != form.pwd2.value ){
			alert("비밀 번호가 일치하지 않습니다. 다시 입력해 주십시오.");
			form.pwd2.value = "";
			form.pwd2.focus();
			return false;
		}

		//생년 월일
		if( form.birthdayy.selectedIndex == 0){
			alert("생년월일을 입력하세요 .");
			form.birthdayy.focus();
			return false;
		}

		if( form.birthdaym.selectedIndex == 0 ){
			alert("생년월일을 입력하세요 .");
			form.birthdaym.focus();
			return false;
		}

		if( form.birthdayd.selectedIndex == 0 ){
			alert("생년월일을 입력하세요 .");
			form.birthdayd.focus();
			return false;
		}

		if( form.birthdayd.selectedIndex != 0 && form.birthdayd.selectedIndex != 0 && form.birthdayd.selectedIndex != 0){
			form.birthday.value = form.birthdayy.options[form.birthdayy.selectedIndex].value +form.birthdaym.options[form.birthdaym.selectedIndex].value +form.birthdayd.options[form.birthdayd.selectedIndex].value ;
		}
		else{
			alert("생년월일을 입력하세요 .");
			form.birthdayy.focus();
			return false;
		}

		if( !form.birthgbn[0].checked  && !form.birthgbn[1].checked){
			alert("생일 구분을  선택해 주세요 .");
			return false;
		}

		//주소 입력 확인
		if( form.zip1.value=="" || form.zip2.value==""){
		//	alert("우편번호를  입력해 주십시오.");
		//	form.zip1.focus();
		//	return false;
		}
		else{
			form.zip.value = form.zip1.value + form.zip2.value;
		}

		if( form.addr1.value=="" || form.addr2.value==""){
			//alert("주소를  입력해 주십시오.");
			//form.addr2.focus();
			//return false;
		}

		//전화번호
		if( form.tel1.value=="" || form.tel2.value=="" || form.tel3.value== ""){
			alert("전화번호/핸드폰번호 를 정확히  입력해 주십시오.");
			form.tel1.focus();
			return false;
		}
		else if(isNumberCheck(form.tel1.value+form.tel2.value+form.tel3.value)){
			alert("전화번호/핸드폰번호 는 숫자만 입력 가능합니다..");
			form.tel1.focus();
			return false;
		}
		else{
			form.tel.value = form.tel1.value + "-" + form.tel2.value+ "-" + form.tel3.value;
		}

		//이메일 확인
		if( form.email.value==""  ){
			alert("이메일 주소를   입력해 주십시오.");
			form.email.focus();
			return false;
		}
		else if(!CheckEmail(form.email.value)){
			alert("올바른 이메일 주소가 아닙니다. 다시 입력해 주십시오.");
			form.email.focus();
			return false;
		}
		
		//sms 수신여부
		if ( form.issmscheck.disabled == false ) {
			if ( form.issmscheck.checked == true ) 
				form.issms.value = "0";
		} 

		//뉴스 수신여부
		if ( form.checkisletter.checked == true )
		{
			form.isletter.value = "1";
		}
		
		return true;
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
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/mypage/tour_mypage_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
			<%@ include file="../../include/mypage/tour_mypage_left.jsp" %>
			<!--  left menu flash -->			
			</td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/mypage/tit_memmodify.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">마이페이지</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">개인정보수정</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>
<form name="form" method="post" action="member_action.jsp" onSubmit="return checkForm()">
     	<input type="hidden" name="cmd" value="U">
		<input type=hidden name=area value="">
        <input type=hidden name=regno>
		<input type=hidden name=birthday>
		<input type=hidden name=zip>
		<input type=hidden name=issmscheck>
		<input type=hidden name=tel>
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/mypage/img_top_mypage01.jpg"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="19" class="bg_dblue" valign="top"><img src="<%=imageServer%>/tour_img/mypage/txt_mem2.gif" style="margin:4 0 0 12px;"></td></tr>
						<tr><td height="35" align="right"><img src="<%=imageServer%>/tour_img/mypage/txt_regist00.gif" hspace="10"></td></tr>
						</table>

						<!-- / insert table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="114"><col width="1"><col width="565" class="lpad_10">
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist01.gif"><!-- 이름 --></td>
							<td><%=Utility.ko((String)read.get("NAME"))%></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist02.gif"><!-- 주민등록번호 --></td>
							<td><%=read.get("REGNO").toString().substring(0, 6)%> - <%=read.get("REGNO").toString().substring(6)%></td>
						</tr>
		<input type=hidden name=regno1 value="<%=read.get("REGNO").toString().substring(0, 6)%>">
		<input type=hidden name=regno2 value="<%=read.get("REGNO").toString().substring(6)%>">
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist03.gif"><!-- 생년월일 --></td>
							<td>

							<select name="birthdayy" style="width:58px" class="fs11">
                              <option value="">선택</option>
                              <%for(int i=Utility.getYear();i>=1900;i--){%>
                              	<option value=<%=i%><%if(Integer.parseInt(read.get("BIRTHDAY").toString().substring(0, 4)) == i ){%> selected <%}%>><%=i%></option>
                              <%}%>
							</select> 년
                            <select name="birthdaym" style="width:45px" class="fs11">
                               <option value="">선택</option>
                               <%for(int i=1;i<13;i++){%>
                               	<option value="<%=Utility.toString(Integer.toString(i),2)%>" <%if(read.get("BIRTHDAY").toString().substring(4, 6).equals(Utility.toString(Integer.toString(i),2))){%> selected <%}%>><%=Utility.toString(Integer.toString(i),2)%></option>
                               <%}%>
                            </select> 월
                            <select name="birthdayd" style="width:45px" class="fs11">
                                <option value="">선택</option>
                                <%for(int i=1;i<=31;i++){%>
                                	<option value="<%=Utility.toString(Integer.toString(i),2)%>" <%if(read.get("BIRTHDAY").toString().substring(6, 8).equals(Utility.toString(Integer.toString(i),2)) ){%> selected <%}%>><%=Utility.toString(Integer.toString(i),2)%></option>
                                <%}%>
							</select> 일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  
						    <input type="radio" class="noborder" name="birthgbn" value="S" <%if(read.get("BIRTHGBN").equals("S")){%> checked <%}%>>양력&nbsp;&nbsp;&nbsp;
						    <input type="radio" class="noborder" name="birthgbn" value="L" <%if(read.get("BIRTHGBN").equals("L")){%> checked <%}%>>음력
							</td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist04.gif"><!-- 아이디 --></td>
							<td><%=read.get("ID").toString()%></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist05.gif"><!-- 비밀번호 --></td>
							<td><input type="password" name="pwd" style="width:152px;" value="<%=read.get("PWD").toString()%>"> <span class="txt_sky fs11">영문/숫자를 조합하셔서 14자 이내로 등록하여 주십시오.</span></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist06.gif"><!-- 비밀번호 확인 --></td>
							<td><input type="password" name="pwd2" style="width:152px;" value="<%=read.get("PWD").toString()%>"></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist07.gif"><!-- 우편번호 --></td>
							<td>
							<input type="text" name="zip1" style="width:50px;" maxlength="3" value="<%=sZip1%>">&nbsp;-&nbsp;
							<input type="text" name="zip2" style="width:50px;" maxlength="3" value="<%=sZip2%>">
							<a href="javascript:zip_search('mem');" ><img src="<%=imageServer%>/tour_img/btn/btn_s_postsch.gif" hspace="5" align="absmiddle"></a><!-- 우편번호검색 --></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist08.gif"><!-- 주소 --></td>
							<td><input type="text" name="addr1" style="width:463px;" maxlength=100 value="<%=Utility.ko((String)read.get("ADDR1"))%>"></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist09.gif"><!-- 나머지 주소 --></td>
							<td><input type="text" name="addr2" style="width:463px;" maxlength=100 value="<%=Utility.ko((String)read.get("ADDR2"))%>"></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr><td height="10" colspan="3"></td></tr>
						<tr>
							<td height="26"><img src="<%=imageServer%>/tour_img/mem/txt_regist10.gif"><!-- 연락처 --></td>
							<td class="bg_dgray"></td>
							<td>
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td  class="gray">						
									<select name="tel1" style="width:45px" class="fs11" onChange="changeMobileChecked(this)">
										<option value="">선택</option>
										<%for ( int i = 0 ; i < aMobileNum.length; i++) { %>
												<option value=<%=aMobileNum[i]%><%if( Utility.getTel((String)read.get("TEL"),1).equals(aMobileNum[i]) ){%> selected <%}%>><%=aMobileNum[i]%></option>
										<%}%>
										<option value="">---</option>
										<%for ( int i = 0 ; i < aTelNum.length; i++) { %>
												<option value=<%=aTelNum[i]%><%if( Utility.getTel((String)read.get("TEL"),1).equals(aTelNum[i]) ){%> selected <%}%>><%=aTelNum[i]%></option>
										<%}%>
									</select> - 
									<input type="text" name="tel2" style="width:82px;" maxlength=4 value="<%=Utility.getTel((String)read.get("TEL"),2)%>"> - 
									<input type="text" name="tel3" style="width:82px;" maxlength=4 value="<%=Utility.getTel((String)read.get("TEL"),2)%>"></td>
								</tr>
								<tr valign="top">
									<td class="tpad_3 fs11 lh14">
									<input type=hidden name=issms value="">
									<input type="checkbox" name="issmscheck" class="noborder" disabled><span class="txt_sky">금강산관광      홈페이지에서 제공하는 정보를 문자 메시지(SMS)로 받겠습니다.</span><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SMS 수신을 원하시면 이동전화 번호를 등록하여 주십시오.</td>
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
									<td  class="gray"><input type="text" name="email" style="width:321px;" maxlength=100 value="<%=read.get("EMAIL")%>"></td>
								</tr>
								<tr valign="top">
									<td class="tpad_3 fs11">
									<input type=hidden name=isletter value="">
									<input type="checkbox" name="checkisletter" class="noborder"><span class="txt_sky">금강산관광      홈페이지에서 제공하는 메일링 서비스를 받겠습니다.</span></td>
								</tr>
								<tr valign="top">
									<td class="tpad_3 fs11 lh14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1:1 상담, 고객관련 서비스 및 비밀번호 찾기에 필요합니다.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;주로 사용하시는 이메일 주소를 입력하여 주시고, 다음 한메일(hanmail.net)은 메일 수신이 되지<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;않을 수 있으니 가급적 사용을 자제하여 주십시오.</td>
								</tr>
								</table>
							<script>
								//SMS 수신 관련 체크표시
								changeMobileChecked(document.form.tel1);
								var sSmscheckVal = '<%=read.get("ISSMS")%>';
								if ( sSmscheckVal == "0" ) document.form.issmscheck.checked = true;

								//메일링 리스트 체크
								var sLettercheckVal = '<%=ISLETTER%>';
								if ( sLettercheckVal == "1" ) document.form.checkisletter.checked = true;
							</script>								
							</td>
						</tr>
						<tr><td height="7" colspan="3"></td></tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						</table>
						<!-- insert table / -->

						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="30"></td></tr>
						<tr><td align="center">						
						<input type="image" src="<%=imageServer%>/tour_img/btn/btn_mem_modify.gif" class="btn" border="0">
						<a href="modify_register.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_mem_cancel.gif" class="btn"></a>
						</td></tr>
						</table>
					</td>
				</tr>
				</table>
</form>				
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
        <%@ include file="../../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>