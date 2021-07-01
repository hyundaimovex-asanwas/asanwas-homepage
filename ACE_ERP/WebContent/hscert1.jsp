<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*
' 	본인인증 요청 정보 입력 화면
'    (고객 인증정보 KCB팝업창에서 입력용)
*/ 
%>
<html>
<head>
<title>KCB 본인인증</title>
<script>
<!--
	function jsSubmit(){	
		var form1 = document.form1;
		var isChecked = false;
		
		for(i=0; i<form1.auth_req_cd.length; i++){
			if(form1.auth_req_cd[i].checked){
				isChecked = true;
				form1.hs_cert_msr_cd.value	= form1.auth_req_cd[i].value;			//요청수단코드
		    break;
			}
		}
		
		if(!(isChecked)){
			alert("인증수단을 버튼을 선택해주세요");
			return;
		}
		if(form1.reg_no1.value == "" || form1.reg_no2.value == ""){
			alert("주민번호를 입력해주세요");
			return;
		}

		form1.ssn.value	= form1.reg_no1.value+form1.reg_no2.value;	//주민번호
		form1.submit();
	}
//-->
</script>
</head>
<body>
<form name="form1" action="hscert2.jsp" method="post">
  <input type="hidden" name="hs_cert_msr_cd" value=""> <!-- 인증요청수단 (00:전체, 10:휴대폰, 20:신용카드, 30:공인인증서) -->
  <input type="hidden" name="ssn" value=""> <!-- 주민번호 -->
  <table>
    <tr>
      <td colspan="2"><strong> - KCB팝업에서 인증정보 입력용</strong></td>
    </tr>
    <tr>
      <td>인증수단</td>
      <td><input type="radio" name="auth_req_cd" value="00">
        전체
        <input type="radio" name="auth_req_cd" value="10" checked>
        휴대폰
        <input type="radio" name="auth_req_cd" value="20">
        신용카드
        <input type="radio" name="auth_req_cd" value="30">
        공인인증서 </td>
    </tr>
    <tr>
      <td>주민번호</td>
      <td><input type="text" name="reg_no1" value="" maxlength="6" size="8">
        -
        <input type="password" name="reg_no2" value="" maxlength="7" size="8"></td>
    </tr>
    <tr>
      <td colspan="2" align="center"><input type="button" value="확인" onClick="jsSubmit();"></td>
    </tr>
  </table>
</form>
</body>
</html>
