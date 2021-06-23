<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 12월 08일
* 요약 설명 : 관계자 회원  등록
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="java.util.HashMap" %>

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ include file="/asanway/common/country_list.jsp" %>

<SCRIPT language=javascript1.2>
<!--
	function zip_search(val){
		window.open('/member/pop_search_zip.jsp?type=' + val,'','width=450,height=381,top=200,left=200,scrollbars=no');
	}

	function addassignment(){
		if(document.form.jobgroup.selectedIndex == 5){
			tr_assignment.style.display = '';
		}else{
			tr_assignment.style.display = 'none';
		}
	}

	function checkForm(){
		var form = document.form;

		//국적
		if( form.country.selectedIndex == 0 ){
			alert("국적을 선택해 주십시오.");
			form.country.focus();
			return false;
		}

		//이름
		if( form.lname.value=="" ){
			alert("성을 입력해 주십시오.");
			form.lname.focus();
			return false;
		}

		if( form.fname.value=="" ){
			alert("이름1을  입력해 주십시오.");
			form.fname.focus();
			return false;
		}

		//직군
		if( form.jobgroup.selectedIndex == 0 ){
			alert("직군을 선택해 주십시오.");
			form.jobgroup.focus();
			return false;
		}

		//직장
		if( form.company.value=="" ){
			alert("직장을   입력해 주십시오.");
			form.company.focus();
			return false;
		}

		//직위
		if( form.position.value=="" ){
			alert("직위를   입력해 주십시오.");
			form.position.focus();
			return false;
		}

		//직장 주소 입력시
		if( form.czip1.value!="" && form.czip2.value!="" ){
			form.czip.value = form.czip1.value + form.czip2.value
		}

		//집주소 입력시
		if( form.hzip1.value!="" && form.hzip2.value!="" ){
			form.hzip.value = form.hzip1.value + form.hzip2.value
		}

		//생년월일 입력시
		if( form.birthdayy.value!="" && form.birthdaym.value!="" && form.birthdayd.value!="" ){
			form.birthday.value = form.birthdayy.value + "-" +form.birthdaym.value  + "-" + form.birthdayd.value ;
		}

		//이메일 입력시
		if( form.email1.value!="" && form.email2.value!="" ){
			form.email.value = form.email1.value + "@" +form.email2.value ;
		}

		//전화번호 입력 확인
		if( form.tel1.value=="" && form.tel2.value=="" && form.mobile.value== ""){
			alert("전화번호중 하나는 필수입력 항목입니다.");
			form.tel1.focus();
			return false;
		}
		return true;
	}

	//학력 추가
	function scholarship_case(){
		aHtml = "<div id=scholarcaseDiv><table width=100% border=0 cellspacing=1 cellpadding=0  bgcolor=#DEDDCF><tr bgcolor=#ffffff align=center>"
		aHtml = aHtml + "<td width='15%' height=30 ><input type=text name=enteryear maxlength=4 size=10></td>"
		aHtml = aHtml + "<td width='15%'><input type=text name=graduyear maxlength=4 size=10></td>"
		aHtml = aHtml + "<td width='70%'><input type=text name=school maxlength=50 size=60></td>"
		aHtml = aHtml + "</tr></table></div>\r\n\t";
		return aHtml;
	}


	function init_scholarship(val){
		hHtml = "";
		for(i = 1; i <= val; i++){
			hHtml = hHtml + scholarship_case();
		}
		scholarship.innerHTML = hHtml;
	}


	function addscholarship(){
		var datacnt = 0;

		if(document.all.scholarcaseDiv.length) {
			datacnt = document.all.scholarcaseDiv.length;
		}else{
			datacnt = 1;
		}

		if (datacnt > 4) {
			alert("학력은 최대 5개까지 입니다");
			return;
		}else {

			cHtml = scholarship_case();

			if(datacnt > 1) {
				document.all.scholarship.all.scholarcaseDiv[datacnt-1].insertAdjacentHTML("BeforeEnd",cHtml);
			}else{
				document.all.scholarship.all.scholarcaseDiv.insertAdjacentHTML("BeforeEnd",cHtml);
			}
		}
	}

	//경력 추가
	function career_case(){
		aHtml = "<div id=careercaseDiv><table width=100% border=0 cellspacing=1 cellpadding=0  bgcolor=#DEDDCF><tr bgcolor=#ffffff align=center>"
		aHtml = aHtml + "<td width='30%' height=30><input type=text name=stdate maxlength=4 size=10> - <input type=text name=enddate maxlength=4 size=10></td>"
	    aHtml = aHtml + "<td width='70%'><input type=text name=career maxlength=50 size=70></td>"
		aHtml = aHtml + "</tr></table></div>\r\n\t";
		return aHtml;
	}


	function init_career(val){
		hHtml = "";
		for(i = 1; i <= val; i++){
			hHtml = hHtml + career_case();
		}
		careerDiv.innerHTML = hHtml;
	}


	function addcareer(){
		var datacnt = 0;

		if(document.all.careercaseDiv.length) {
			datacnt = document.all.careercaseDiv.length;
		}else{
			datacnt = 1;
		}

		if (datacnt > 4) {
			alert("경력은  최대 5개까지 입니다");
			return;
		}else {

			cHtml = career_case();

			if(datacnt > 1) {
				document.all.careerDiv.all.careercaseDiv[datacnt-1].insertAdjacentHTML("BeforeEnd",cHtml);
			}else{
				document.all.careerDiv.all.careercaseDiv.insertAdjacentHTML("BeforeEnd",cHtml);
			}
		}
	}

	//접촉사항 추가
	function contact_case(){
		aHtml = "<div id=contactDiv><table width=100% border=0 cellspacing=1 cellpadding=0  bgcolor=#DEDDCF><tr bgcolor=#ffffff align=center>"
		aHtml = aHtml + "<td width='20%' height=30 ><input type=text name=contactdate maxlength=4 size=15></td>"
	    aHtml = aHtml + "<td width='80%'><input type=text name=content maxlength=50 size=80></td>"
		aHtml = aHtml + "</tr></table></div>\r\n\t";
		return aHtml;
	}


	function init_contact(val){
		hHtml = "";
		for(i = 1; i <= val; i++){
			hHtml = hHtml + contact_case();
		}
		contact.innerHTML = hHtml;
	}


	function addcontact(){
		var datacnt = 0;

		if(document.all.contactDiv.length) {
			datacnt = document.all.contactDiv.length;
		}else{
			datacnt = 1;
		}

		if (datacnt > 4) {
			alert("접촉사항은 최대 5개까지 입니다");
			return;
		}else {
			cHtml = contact_case();
			if(datacnt > 1) {
				document.all.contact.all.contactDiv[datacnt-1].insertAdjacentHTML("BeforeEnd",cHtml);
			}else{
				document.all.contact.all.contactDiv.insertAdjacentHTML("BeforeEnd",cHtml);
			}
		}
	}


//-->
</script>
<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">
<jsp:include page="/asanway/common/top.jsp" flush="true" />

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="25" bgcolor="E4E3C3"><jsp:include page="/asanway/common/topbutton.jsp" flush="true" /></td>
  </tr>
  <tr>
    <td valign="top">
      <table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" >
				<table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
	              <tr>
	                <td valign="top" bgcolor="FCFCF6" width="180" > <jsp:include page="/asanway/common/member_leftmenu.jsp" flush="true" /></td>
	                <td width="2"></td>
	              </tr>
	            </table>
          </td>
          <td valign="top" bgcolor="FCFCF6" width=650>

            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr  style="padding: 15 0 0 20;">
              	<td>
              		<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			<tr>
              				<td>*표의 항목은 필수입력사항입니다. </td>
              				<td align=right>
              					<!--최종업데이트 : <input type=text name=regday readonly>-->
              				</td>
              			</tr>
              		</table>
              	</td>
              </tr>
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">
				  <form name="form" method=post action="member_hr_action.jsp?cmd=I" enctype="multipart/form-data" onSubmit="return checkForm()">
	                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                       <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>기본정보</b></td>
	                    </tr>
	                    <tr>
	                      <td>
	                        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
	                         <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                          <tr>
	                            <td width="90" height="30" valign="top" bgcolor="F2F1E2"  style="padding: 10 0 0 15 ;">* 국 적 </td>
	                            <td style="padding-left:5;">
	                            	<select name="country"  style="width:100px;height:20px" >
	                            		<option value="">선택</option>
	                            		<%for ( int i = 1 ; i < countryList.size(); i++) {%>
												<option value=<%=i%>><%=countryList.get(Integer.toString(i))%></option>
										<%}%>
									</select>
	                            </td>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                          <tr>
	                            <td height="75" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"  valign=top>* 성 명</td>
	                            <td style="padding-left:5;">
	                            	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
						              <tr height=25>
						                <td width=150>성(Last Name)</td>
						                <td><input type=text name=lname></td>
						              </tr>
						              <tr height=25>
						                <td>이름1(First Name)</td>
						                <td><input type=text name=fname></td>
						              </tr>
						              <tr height=25>
						                <td>이름2(Middle Name)</td>
						                <td><input type=text name=mname></td>
						              </tr>
						            </table>
	                            </td>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>

	                          <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">사 진</td>
	                            <td style="padding-left:5;">
	                            	<input type="file" name="img" style="width:300px;height:20px" >(* 권장 이미지 사이즈 : 200* 250)
	                            </td>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>

	                          <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">* 직 군</td>
	                            <td style="padding-left:5;">
	                            	<select name="jobgroup"  style="width:100px;height:20px" onChange="javascript:addassignment();">
	                            		<option value="">선택</option>
	                            		<%for ( int i = 1 ; i < jobgroup.size(); i++) {%>
												<option value=<%=i%>><%= jobgroup.get(Integer.toString(i))%></option>
										<%}%>
									</select>
	                            </td>
	                          </tr>

	                          <tr id="tr_assignment" style="display:none;">
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">* 출입처</td>
	                            <td style="padding-left:5;">
	                            	<input type=text name="assignment">
	                            </td>
	                          </tr>

	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>

	                          <tr>
	                            <td height="50" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">* 직 장</td>
	                            <td style="padding-left:5;">
	                            	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
						              <tr height=25>
						                <td width=100>직장명</td>
						                <td><input type=text name="company" size=40></td>
						              </tr>
						              <tr height=25>
						                <td>직 위</td>
						                <td><input type=text name="position" size=40></td>
						              </tr>
						            </table>
								</td>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                       </table>
	                    </td>
	                 </tr>
	               </table>
	                <br>

	               <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                       <td height="50" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>주소 및 연락처 </b></td>
	                    </tr>
	                    <tr>
	                      <td>
	                        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
	                         <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                          <tr>
	                            <td width="90" height="30" valign="top" bgcolor="F2F1E2"  style="padding: 10 0 0 15 ;">직장주소 </td>
	                            <td style="padding-left:5;">
	                            	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
			                          <tr>
			                            <td style="padding-left:5;">
				                            <input type=hidden name="czip">
				                            <input type=text name="czip1" size=6 maxlength=3 readonly>-
				                            <input type=text name="czip2" size=6 maxlength=3 readonly>
				                            <a href="javascript:zip_search('czip');" ><img src="/img/member/btn_sch_zip.gif" align="absmiddle" border=0></a>
			                            </td>
			                          </tr>
			                          <tr>
			                            <td style="padding-left:5;"><input type=text name="caddr1" size=70 readonly></td>
			                          </tr>
			                          <tr>
			                            <td style="padding-left:5;"><input type=text name="caddr2"  size=70></td>
			                          </tr>
	                          		</table>
	                            </td>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>

	                          <tr>
	                            <td height="75" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"  valign=top>자택주소</td>
	                            <td style="padding-left:5;">
	                            	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
			                          <tr>
			                            <td style="padding-left:5;">
				                            <input type=hidden name="hzip">
				                            <input type=text name="hzip1" size=6 maxlength=3 readonly>-
				                            <input type=text name="hzip2" size=6 maxlength=3 readonly>
				                            <a href="javascript:zip_search('hzip');" ><img src="/img/member/btn_sch_zip.gif" align="absmiddle" border=0></a>
			                            </td>
			                          </tr>
			                          <tr>
			                            <td style="padding-left:5;"><input type=text name="haddr1" size=70 readonly></td>
			                          </tr>
			                          <tr>
			                            <td style="padding-left:5;"><input type=text name="haddr2" size=70></td>
			                          </tr>
	                          		</table>
	                            </td>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>

	                          <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">일반전화</td>
	                            <td style="padding-left:5;">
	                            	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
			                          <tr>
			                            <td style="padding-left:5;">
			                            	자택 <input type=radio name="telgbn1" value="h">
			                            	직장 <input type=radio name="telgbn1" value="c" checked> &nbsp;
			                            	<input type=text name="tel1" size=40 maxlength=20>
			                            </td>
			                          </tr>
			                          <tr>
			                            <td style="padding-left:5;">
			                            	자택 <input type=radio name="telgbn2" value="h" checked>
			                            	직장 <input type=radio name="telgbn2" value="c" > &nbsp;
			                            	<input type=text name="tel2" size=40 maxlength=20>
			                            </td>
			                          </tr>
	                          		</table>
	                            </td>
	                          </tr>
							  <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                          <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"> 휴대전화</td>
	                            <td style="padding-left:5;">
	                            	<input type=text name="mobile" size=40 maxlength=20>
	                            </td>
	                          </tr>
							  <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"></td>
	                            <td style="padding-left:5;">
	                            	* 일반 전화와 휴대전화중 하나는 반드시 입력해야 합니다.
	                            </td>
	                          </tr>

	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>

	                          <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">e-mail</td>
	                            <td style="padding-left:5;">
	                            	<input type=hidden name="email" >
	                            	<input type=text name="email1" >@
	                            	<input type=text name="email2"  maxlength=20 size=40>
	                            </td>
	                          </tr>

	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
							</table>
	                    </td>
	                 </tr>
	               </table>
	               <br>

                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                       <td height="50" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>신상정보 </b></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                         <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td width="90" height="30" valign="top" bgcolor="F2F1E2"  style="padding: 10 0 0 15 ;">생년월일  </td>
                            <td style="padding-left:5;">
                        		<input type=hidden name="birthday">
                        		<input type=text name="birthdayy" maxlength=4 size=4> 년
                        		<input type=text name="birthdaym" maxlength=2 size=4> 월
                        		<input type=text name="birthdayd" maxlength=2 size=4> 일
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"  valign=top>출생지</td>
                            <td style="padding-left:5;">
                            	<input type=text name="birthplace" maxlength=30 size=70>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">취 미</td>
                            <td style="padding-left:5;">
                            	<input type=text name="hobby" maxlength=30  size=70>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"> 흡연/주량 </td>
                            <td style="padding-left:5;">
                            	<input type=text name="smoking" maxlength=30 size=70>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">종 교</td>
                            <td style="padding-left:5;">
                            	<input type=text name="religion" maxlength=30 size=70>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

                          <tr >
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">혈액형 </td>
                            <td style="padding-left:5;">
                            	<input type=text name="bloodtype" maxlength=30 size=70>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

                          <tr >
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">가족관계</td>
                            <td style="padding-left:5;">
                            	<input type=text name="family" maxlength=30 size=70>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">기타 </td>
                            <td style="padding-left:5;">
                            	<input type=text name="etc" maxlength=30 size=70>
                            </td>
                          </tr>

                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
						</table>
                    </td>
                 </tr>
               </table>
               <br>


				   <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                       	<td height="50" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>학 력 </b></td>
	                    	<td align=right>[<a href="javascript:addscholarship();">칼럼추가</a>]&nbsp;&nbsp;</td>
	                    </tr>

	                    <tr>
	                      <td colspan=2>
	                        <table width="100%" border="0" cellspacing="1" cellpadding="0"  bgcolor=#DEDDCF>
	                          <tr bgcolor="F2F1E2" align=center>
	                            <td width="15%" height="30" >입학년도</td>
	                            <td width="15%">졸업년도</td>
	                            <td width="70%">출신학교 및 전공</td>
	                          </tr>
							</table>
                          	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
                          		<tr><td><div id="scholarship"></div></td></tr>
                          	</table>
	                      </td>
	                    </tr>
	                     <tr>
	                       	<td height="30" align=right colspan=2>* 칼럼은 5개까지 추가 가능합니다.  &nbsp;</td>
	                    </tr>
	               </table>
	               <br>



	               <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                        <td height="50" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>주요경력</b></td>
	                    	<td align=right>[<a href="javascript:addcareer();">칼럼추가</a>]&nbsp;&nbsp;</td>
	                    </tr>
	                    <tr >
	                      <td colspan=2 >
	                         <table width="100%" border="0" cellspacing="1" cellpadding="0"  bgcolor=#DEDDCF>
	                          <tr bgcolor="F2F1E2" align=center >
	                            <td width="30%" height="30" >기 간 </td>
	                            <td width="70%">주요경력 </td>
	                          </tr>
							  </table>
	                          <table width="100%" border="0" cellspacing="0" cellpadding="0" >
	                          		<tr><td><div id="careerDiv"></div></td></tr>
	                          </table>
	                      </td>
	                   </tr>
	                   <tr>
	                       	<td height="30" align=right colspan=2>* 칼럼은 5개까지 추가 가능합니다.  &nbsp;</td>
	                    </tr>
	               </table>
	               <br>

	               <table width="100%" border="0" cellspacing="0" cellpadding="0">
				   		 <tr>
	                       <td height="50" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>접촉사항  </b></td>
	                       <td align=right>[<a href="javascript:addcontact();">칼럼추가</a>]&nbsp;&nbsp;</td>
	                    </tr>
	                    <tr>
	                      <td colspan=2>
	                        <table width="100%" border="0" cellspacing="1" cellpadding="0"  bgcolor=#DEDDCF>
	                          <tr bgcolor="F2F1E2" align=center>
	                            <td width="20%" height="30" >일 자</td>
	                            <td width="85%">접촉내용 </td>
	                          </tr>
							 </table>
	                         <table width="100%" border="0" cellspacing="0" cellpadding="0" >
	                          		<tr><td><div id="contact"></div></td></tr>
	                         </table>
	                    </td>
	                   </tr>
	                   <tr>
	                       	<td height="30" align=right colspan=2>* 칼럼은 5개까지 추가 가능합니다.  &nbsp;</td>
	                    </tr>
	               </table>
	               <br>

	                <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                       <td height="50" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>특기사항   </b></td>
	                    </tr>
	                    <tr>
	                      <td>
	                        <textarea name="memo" rows=3 cols=90></textarea><br><br>
	                    </td>
	                   </tr>
	                   <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                       </tr>
	               </table>
	               <br>


				   <table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
	                  <td align="right"   style="padding-top:5;">
	                    	<input type=image src="../img/bt_07.gif" border="0">
	                    	<a href="member_hr_list.jsp"><img src="../img/bt_10.gif" hspace="4" border="0"></a>
	                  </td>
	                </tr>
	                <tr>
	                  <td height="50" align="center">&nbsp;</td>
	                </tr>
				   </table>
	               </form>

	        	   </td>
	        	 </tr>
	          </table>
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
    <td height="30"  bgcolor="D4D4B2"><jsp:include page="/asanway/common/copyright.jsp" flush="true" /></td>
  </tr>
</table>
</body>
</html>

<SCRIPT language=javascript1.2>
<!--
	init_scholarship(1);
	init_career(1);
	init_contact(1);
//-->
</script>
