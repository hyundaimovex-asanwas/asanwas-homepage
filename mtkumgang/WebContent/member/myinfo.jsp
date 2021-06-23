<%--
  - 작성자: 김종섭 
  - 작성 일자: 2006.06.08
  - 최종 수정자 : 김종섭
  - 최종 수정일 : 2006.06.08
  - 저작권 표시: IMJ Korea
  - 설명: 회원가입 정보 변경 
			변경 불가 : 아이디와 성명, 주민번호
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="com.hmm.asan.www.member.MemberBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.net.*" %>

<%//로그인 체크 %>
<%@ include file="/common/logincheck.jsp" %>
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
	    
		window.open('/member/pop_search_zip.jsp?type=' + val,'','width=450,height=381,top=200,left=200,scrollbars=no');
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


<body leftmargin="0" topmargin="0" bgcolor="#FCFCF6">

				<!----- Title----->
				<table border="0" cellpadding="0" cellspacing="0" width="644" background="/img/common/tit_bg.gif">
				<tr>
					<td height=50> <b>회원 수정</b></td>
				</tr>
				</table>
				<!----- //Title----->

				

				<table border="0" cellpadding="0" cellspacing="0" width="644" id="tarea">
				<form name="form" method="post" action="member_action.jsp" onSubmit="return checkForm()">
                     	<input type="hidden" name="cmd" value="U">
						<input type=hidden name=area value="">
				<tr>
					<td align="center">

					<!----- CONTENTS START----->
					<table border="0" cellpadding="0" cellspacing="0" width="644" height="30"><tr><td></td></tr></table>

					<table cellpadding="0" cellspacing="0" width="624">
					<tr>
						<td class="ti_b" style="padding-left:9"><img src="/img/member/ico_plus.gif" align="absmiddle"> 표시는 필수 입력 항목 입니다. <br>*이름, 아이디, 주민등록번호는 수정하실 수 없습니다.</td>
					</tr>
					<tr>
						<td colspan="2" height="8"></td>
					</tr>
					</table>

					<!-- 입력-->
					<table border="0" cellpadding="0" cellspacing="0" width="624" height="2" bgcolor="#BFBEA3"><tr><td></td></tr></table>
					<table border="0" cellpadding="0" cellspacing="1" width="624" bgcolor="#BFBEA3">
						<col width="100" bgcolor="#EFEFE1" style="padding-left:8"></col>
						<col width="524" bgcolor="#FCFCF6" style="padding-left:8"></col>
					<tr height="30">
						<td><img src="/img/member/ico_plus.gif" align="absmiddle"> <img src="/img/member/img_join_0304.gif" align="absmiddle"></td>
						<td><INPUT TYPE="text" NAME="name" style="width:120; height:18;" class="gray_input" maxlength=20 value="<%=Utility.ko((String)read.get("NAME"))%>" readonly></td>
					</tr>
					<tr height="30">
						<input type=hidden name=regno value="">
						<td><img src="/img/member/ico_plus.gif" align="absmiddle"> <img src="/img/member/img_join_0305.gif" align="absmiddle"></td>
						<td><INPUT TYPE="text" NAME="regno1" style="width:70; height:18;" class="gray_input" value="<%=read.get("REGNO").toString().substring(0, 6)%>" maxlength=6 onKeyup="movenext(this.form.regno1,this.form.regno2,6);" readonly> - <INPUT TYPE="text" NAME="regno2" style="width:70; height:18;" class="gray_input" value="<%=read.get("REGNO").toString().substring(6)%>" maxlength=7 readonly> &nbsp;&nbsp;
						</td>
					</tr>
					<tr height="30">
						<input type=hidden name=birthday value="">
						<td><img src="/img/member/ico_plus.gif" align="absmiddle"> <img src="/img/member/img_join_0306.gif" align="absmiddle"></td>
						<td>
							<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="">
									<SELECT NAME="birthdayy" STYLE="width:60px;">
										<option value="">선택</option>
	                            		<%for(int i=Utility.getYear();i>=1900;i--){%>
											<option value=<%=i%><%if(Integer.parseInt(read.get("BIRTHDAY").toString().substring(0, 4)) == i ){%> selected <%}%>><%=i%></option>
										<%}%>
									</SELECT>
								</td>
								<td width="10"></td>
								<td width="">
									<SELECT NAME="birthdaym" STYLE="width:60px;">
										 <option value="">선택</option>
	                            		<%for(int i=1;i<13;i++){%>
											<option value="<%=Utility.toString(Integer.toString(i),2)%>" <%if(read.get("BIRTHDAY").toString().substring(4, 6).equals(Utility.toString(Integer.toString(i),2))){%> selected <%}%>><%=Utility.toString(Integer.toString(i),2)%></option>
										<%}%>
									</SELECT>
								</td>
								<td width="10"></td>
								<td width="">
									<SELECT NAME="birthdayd" STYLE="width:60px;">
										<option value="">선택</option>
	                            		<%for(int i=1;i<=31;i++){%>
											<option value="<%=Utility.toString(Integer.toString(i),2)%>" <%if(read.get("BIRTHDAY").toString().substring(6, 8).equals(Utility.toString(Integer.toString(i),2)) ){%> selected <%}%>><%=Utility.toString(Integer.toString(i),2)%></option>
										<%}%>
									</SELECT>
								</td>
								<td width="10"></td>
								<td width="">
									<input type="radio" name="birthgbn" value="S" <%if(read.get("BIRTHGBN").equals("S")){%> checked <%}%>>양력&nbsp;
                            		<input type="radio" name="birthgbn" value="L" <%if(read.get("BIRTHGBN").equals("L")){%> checked <%}%>>음력 &nbsp;
								</td>
							</tr>
							</table>
						</td>
					</tr>
					<tr height="30">
						<td><img src="/img/member/ico_plus.gif" align="absmiddle"> <img src="/img/member/img_join_0301.gif" align="absmiddle"></td>
						<td><INPUT TYPE="text" NAME="id" style="width:120; height:18;" class="gray_input" maxlength=10 readonly value="<%=read.get("ID").toString()%>"></td>
					</tr>
					<tr height="30">
						<td><img src="/img/member/ico_plus.gif" align="absmiddle"> <img src="/img/member/img_join_0302.gif" align="absmiddle"></td>
						<td><INPUT TYPE="password" NAME="pwd" style="width:120; height:18;" class="gray_input" maxlength=10 value="<%=read.get("PWD").toString()%>">
						<span style="font-size:11px;word-spacing:-2px">최대 10자까지 입력 가능하며 특수문자는 사용할 수 없습니다.</span> </td>
					</tr>
					<tr height="30">
						<td><img src="/img/member/ico_plus.gif" align="absmiddle"> <img src="/img/member/img_join_0303.gif" align="absmiddle"></td>
						<td><INPUT TYPE="password" NAME="pwd2" style="width:120; height:18;" class="gray_input" maxlength=10 value="<%=read.get("PWD").toString()%>"></td>
					</tr>
					<tr height="75">
						<input type=hidden name=zip value="">
						<td valign="top" style="padding-top:8"><img src="/img/member/ico_plus.gif" align="absmiddle"> <img src="/img/member/img_join_0307.gif" align="absmiddle"></td>
						<td>
							<table border="0" cellpadding="0" cellspacing="0">
							<tr height="22">
								<td>
								<INPUT TYPE="text" NAME="zip1" style="width:50; height:18;" class="gray_input"  maxlength=3  value="<%=sZip1%>"> - <INPUT TYPE="text" NAME="zip2" style="width:50; height:18;" class="gray_input" maxlength=3  value="<%=sZip2%>">
								<a href="javascript:zip_search('mem');" ><img src="/img/member/btn_sch_zip.gif" align="absmiddle" border=0></a></td>
							</tr>
							<tr height="22">
								<td><INPUT TYPE="text" NAME="addr1" style="width:450; height:18;" class="gray_input" maxlength=100 value="<%=Utility.ko((String)read.get("ADDR1"))%>"></td>
							</tr>
							<tr height="22">
								<td><INPUT TYPE="text" NAME="addr2" style="width:450; height:18;" class="gray_input" maxlength=100 value="<%=Utility.ko((String)read.get("ADDR2"))%>"></td>
							</tr>
							</table>
						</td>
					</tr>
					
					<tr height="30">
						<input type=hidden name=tel value="">
						<td style="padding-left:17">연락처</td>
						<td>
							<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<SELECT NAME="tel1" STYLE="width:50px;"  onChange="changeMobileChecked(this)">
										<option value="">선택</option>
										<%for ( int i = 0 ; i < aMobileNum.length; i++) { %>
												<option value=<%=aMobileNum[i]%><%if( Utility.getTel((String)read.get("TEL"),1).equals(aMobileNum[i]) ){%> selected <%}%>><%=aMobileNum[i]%></option>
										<%}%>
										<option value="">---</option>
										<%for ( int i = 0 ; i < aTelNum.length; i++) { %>
												<option value=<%=aTelNum[i]%><%if( Utility.getTel((String)read.get("TEL"),1).equals(aTelNum[i]) ){%> selected <%}%>><%=aTelNum[i]%></option>
										<%}%>
									</SELECT>
									&nbsp;- <INPUT TYPE="text" NAME="tel2" style="width:50; height:18;" class="gray_input" maxlength=4 value="<%=Utility.getTel((String)read.get("TEL"),2)%>"> - <INPUT TYPE="text" NAME="tel3" style="width:50; height:18;" class="gray_input" maxlength=4 value="<%=Utility.getTel((String)read.get("TEL"),2)%>">
								</td>
							</tr>
							<tr>
								<input type=hidden name=issms value="">
							    <td>
							    SMS 수신을 원하시면 이동전화 번호를 등록하여 주십시요.<BR>
							    <input type="checkbox" name="issmscheck" disabled>금강산 관광 홈페이지에서 제공하는 정보를 문자메시지로 받겠습니다.
							    </td>
							</tr>
							</table>
						</td>
					</tr>
					<tr height="50">
						<td valign="top" style="padding-top:8"><img src="/img/member/ico_plus.gif" align="absmiddle"> <img src="/img/member/img_join_0313.gif" align="absmiddle"></td>
						<td>
							<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width=""><INPUT TYPE="text" NAME="email" style="width:200; height:18;" class="gray_input" maxlength=100 value="<%=read.get("EMAIL")%>"></td>
							</tr>
							<tr>
								<input type=hidden name=isletter value="">
								<td width="">
								1:1상담, 고객관련 서비스 및 비밀번호 찾기에 필요 합니다.<br>
								주로 사용하시는 이메일 주소를 입력하여 주시고, 다음 한메일(hanmail.net)은 메일 수신이 되지 않을 수 있으니 가급적 사용을 자제하여 주십시요.<br>
								<input type="checkbox" name="checkisletter"> 금강산 관광 홈페이지에서 제공하는 메일링 서비스를 받겠습니다.
								</td>
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

							<table border="0" cellpadding="0" cellspacing="0">
							<tr><td height="5"></td></tr>
							<tr>
								<td style="font-size:11px;word-spacing:-2px">Daum 메일은 온라인우표제로 인해 메일 수신이 안될 수 있으니 다른 메일 계정을 등록해 주시기 바랍니다.</td>
							</tr>
							</table>
						</td>
					</tr>
					</table>
					<!-- //입력-->

					<!-- Button-->
					<table border="0" cellpadding="0" cellspacing="0" width="624">
					<tr><td height="15"></td></tr>
					<tr>
						<td align="center"><input type=image src="/img/common/btn_join_apply.gif" border=0> &nbsp;&nbsp; <a href="withdrawal.jsp">회원탈퇴</a></td>
					</tr>
					</table>
					<!-- //Button-->


					<!----- //CONTENTS END----->

</body>
</html>