<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*
' 	�������� ��û ���� �Է� ȭ��
'    (�� �������� KCB�˾�â���� �Է¿�)
*/ 
%>
<html>
<head>
<title>KCB ��������</title>
<script>
<!--
	function jsSubmit(){	
		var form1 = document.form1;
		var isChecked = false;
		
		for(i=0; i<form1.auth_req_cd.length; i++){
			if(form1.auth_req_cd[i].checked){
				isChecked = true;
				form1.hs_cert_msr_cd.value	= form1.auth_req_cd[i].value;			//��û�����ڵ�
		    break;
			}
		}
		
		if(!(isChecked)){
			alert("���������� ��ư�� �������ּ���");
			return;
		}
		if(form1.reg_no1.value == "" || form1.reg_no2.value == ""){
			alert("�ֹι�ȣ�� �Է����ּ���");
			return;
		}

		form1.ssn.value	= form1.reg_no1.value+form1.reg_no2.value;	//�ֹι�ȣ
		form1.submit();
	}
//-->
</script>
</head>
<body>
<form name="form1" action="hscert2.jsp" method="post">
  <input type="hidden" name="hs_cert_msr_cd" value=""> <!-- ������û���� (00:��ü, 10:�޴���, 20:�ſ�ī��, 30:����������) -->
  <input type="hidden" name="ssn" value=""> <!-- �ֹι�ȣ -->
  <table>
    <tr>
      <td colspan="2"><strong> - KCB�˾����� �������� �Է¿�</strong></td>
    </tr>
    <tr>
      <td>��������</td>
      <td><input type="radio" name="auth_req_cd" value="00">
        ��ü
        <input type="radio" name="auth_req_cd" value="10" checked>
        �޴���
        <input type="radio" name="auth_req_cd" value="20">
        �ſ�ī��
        <input type="radio" name="auth_req_cd" value="30">
        ���������� </td>
    </tr>
    <tr>
      <td>�ֹι�ȣ</td>
      <td><input type="text" name="reg_no1" value="" maxlength="6" size="8">
        -
        <input type="password" name="reg_no2" value="" maxlength="7" size="8"></td>
    </tr>
    <tr>
      <td colspan="2" align="center"><input type="button" value="Ȯ��" onClick="jsSubmit();"></td>
    </tr>
  </table>
</form>
</body>
</html>
