<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%
/*
 * ������� ���� Ȯ�μ��� ��û ���� �Է� ȭ��
 * (�� �������� KCB�˾�â���� �Է¿�)
 */ 
%>
<html>
<head>
<title>KCB ������� ���� Ȯ�μ��� ����</title>
<script>
<!--
	function jsSubmit(){	
		window.open("", "auth_popup", "width=430,height=590,scrollbar=yes");

		var form1 = document.form1;
		form1.target = "auth_popup";
		form1.submit();
	}
//-->
</script>
</head>
 <body>
	<form name="form1" action="safe_hs_cert2.jsp" method="post">
		<table>
			<tr>
				<td colspan="2"><strong> - KCB�˾����� �������� �Է¿�</strong></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="button" value="������� ���� Ȯ�μ���" onClick="jsSubmit();"></td>
			</tr>
		</table>
	</form>

	<!-- ����Ȯ�� ó����� ���� -->
	<form name="kcbResultForm" method="post" >
        <input type="hidden" name="idcf_mbr_com_cd" 		value="" 	/>
        <input type="hidden" name="hs_cert_svc_tx_seqno" 	value=""	/>
        <input type="hidden" name="hs_cert_rqst_caus_cd" 	value="" 	/>
        <input type="hidden" name="result_cd" 				value="" 	/>
        <input type="hidden" name="result_msg" 				value="" 	/>
        <input type="hidden" name="cert_dt_tm" 				value="" 	/>
        <input type="hidden" name="di" 						value="" 	/>
        <input type="hidden" name="ci" 						value="" 	/>
        <input type="hidden" name="name" 					value="" 	/>
        <input type="hidden" name="birthday" 				value="" 	/>
        <input type="hidden" name="gender" 					value="" 	/>
        <input type="hidden" name="nation" 					value="" 	/>
        <input type="hidden" name="tel_com_cd" 				value="" 	/>
        <input type="hidden" name="tel_no" 					value="" 	/>
        <input type="hidden" name="return_msg" 				value="" 	/>
	</form>  
 </body>
</html>
