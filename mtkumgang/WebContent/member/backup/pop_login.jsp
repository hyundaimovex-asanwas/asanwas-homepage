<%--
  - �ۼ���: ������
  - �ۼ� ����: 2006.06.12
  - ���� ������ : ������
  - ���� ������ : 2006.06.12
  - ���۱� ǥ��: IMJ Korea
  - ����: �˾� �α���
			action page : login_ok.jsp 
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%
	String sErrStr = request.getParameter("sErrStr");
	if(sErrStr == null || sErrStr.trim().equals("")) {
		sErrStr = "1";
	}

	//��Ű������ ������
	String sDomain = ROOT_DNS;
%>


<script language="javascript">
<!--
	function checkForm(){

		var form = document.form;

		if( form.id.value=="" ){
			alert("ID��  �Է��� �ֽʽÿ�.");
			form.id.focus();
			return false;
		}

		if( form.pwd.value=="" ){
			alert("��й�ȣ��   �Է��� �ֽʽÿ�.");
			form.pwd.focus();
			return false;
		}

		return true;
	}

	function openr_herf(url)
	{
		if (opener)
		{
			opener.location.href= url;
			this.close();
		}
	}
  
//-->
</script>

<body leftmargin="0" topmargin="0" bgcolor="#FCFCF6">


<!----- //CONTENTS START----->
      <table border="0" cellpadding="0" cellspacing="0" width="644" id='tarea'>
      <tr>
      	<td align="center">
      
      	<!----- CONTENTS START----->
      	<table border="0" cellpadding="0" cellspacing="0" width="624" height="190" style="border:4 solid #EEEED8">
      	<tr>
      		<td align="center">
				<form name=form method=post action=login_ok.jsp onSubmit="return checkForm();">
				<input type=hidden name=popuplogin value="1">
				<div id="showstr">
							<b>"�ݰ������ Ȩ������ �湮�� ȯ���մϴ�"</b><br>
							�α����� �Ͻø� �ݰ��� ���� Ȩ���������� �����ϴ� �پ��� ������ ����,...... <br><br>
				</div>
				<!-- ���� ������ ���� ���� ��� -->
				
				<script>
					var sShowString = "<%=sErrStr%>";
					if ( sShowString == "2" ) //id error
					{
						showstr.innerHTML = "<b>\"��ϵ��� ���� ���̵��Դϴ�.\"</b>"
																			+"<br>ȸ�����̵� Ȯ���Ͻð� �ٽ� �α����Ͽ� �ֽʽÿ�.";
																			+"<br>���̵� ��ﳪ�� ������ ���, �ϴ��� '���̵� ã��' ��ư�� Ŭ���ϼ���.";
																			+"<br><br>";
					}
					else if ( sShowString == "3" ) //password error
					{
						showstr.innerHTML = "<b>\"��й�ȣ�� ��ġ���� �ʽ��ϴ�.\"</b>"
																			+"<br>ȸ������ ��й�ȣ�� Ȯ���Ͻð� �ٽ� �α����Ͽ� �ֽʽÿ�.";
																			+"<br>��й�ȣ�� ��ﳪ�� ������ ���, �ϴ��� '��й�ȣ ã��' ��ư�� Ŭ���ϼ���.";
																			+"<br><br>";
					}
						
				</script>
				<!-- //���� ������ ���� ���� ��� -->
      			<!-- �α���-->
      			<table border="0" cellpadding="0" cellspacing="0" width="">
					<input type=hidden name=domain value="<%=sDomain%>">
      			<tr height="26">
      				<td width="55" align="right" style="padding-right:15"><img src="/img/member/img_login_01.gif"></td>
      				<td width="190"><INPUT TYPE="text" NAME="id" style="width:175; height:18;" class="gray_input" onkeypress="if (13 == event.keyCode) checkForm();" tabindex="1"></td>
      				<td width="55" rowspan="2"><input type="image" src="/img/member/btn_login.gif" tabindex="3"></a></td>
      			</tr>
      			<tr height="26">
      				<td align="right" style="padding-right:15"><img src="/img/member/img_login_02.gif"></td>
      				<td><INPUT TYPE="password" NAME="pwd" style="width:175; height:18;" class="gray_input" tabindex="2" onkeypress="if (13 == event.keyCode) onSubmit='return checkForm();'"></td>
      			</tr>
      			</table>
      			<!-- //�α���-->
				</form>
      			<table border="0" cellpadding="0" cellspacing="0" width="580">
      			<tr><td height="15"></td></tr>
      			<tr>
      				<td height="1" bgcolor="#CECE9C"></td>
      			</tr>
      			<tr><td height="25"></td></tr>
      			</table>
      
      			<table border="0" cellpadding="0" cellspacing="0" width="">
      			<tr height="26">
      				<td width="360"><img src="/img/member/img_login_03.gif"></td>
      				<td width="76">
      				
					<a href="javascript:openr_herf('id_search.jsp')"><img src="/img/member/btn_sch_id.gif" alt='ID ã��'></a>&nbsp;
					<a href="javascript:openr_herf('pwd_search.jsp')"><img src="/img/member/btn_sch_id.gif" alt='��й�ȣ ã��'></a>
      				</td>
      			</tr>
      			<tr height="26">
      				<td><img src="/img/member/img_login_04.gif"></td>
      				<td><a href="javascript:openr_herf('join_agreement.jsp')"><img src="/img/member/btn_join.gif"></a></td>
      			</tr>
      			</table>
      		</td>
      </tr>
      </table>
      
     <!----- //CONTENTS END----->


</body>
</html>
