<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �ۼ��� : �����
* �ۼ����� : 2005�� 10�� 28��
* ��� ���� : ȸ�� ����
**
* �����ð�  : ������ : ��������
*
*
******************************************/
%>

<%@ page import="com.hmm.asan.asanway.member.MemberBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="java.util.HashMap" %>

<%
	MemberBean bean = new MemberBean();
	bean.Read(request, response);

	String mtype = request.getParameter("mtype");
	if(mtype == null) mtype = "";

	String menutitle = "";

	if(mtype.equals("1")){
		menutitle = "14���̸�ȸ�� ";
	}else if(mtype.equals("2")){
		menutitle = "������ ";
	}else{
		menutitle = "�Ϲ�ȸ��";
	}

	//����
	HashMap jobhm = new HashMap();
		jobhm.put("1","������");
		jobhm.put("2","ȸ���");
		jobhm.put("3","�л�");
		jobhm.put("4","�ڿ���");
		jobhm.put("5","������");
		jobhm.put("6","��Ÿ");

	//�̸���
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

	//�ڵ��� ��ȣ
	HashMap mobilehm = new HashMap();
		mobilehm.put("1","010");
		mobilehm.put("2","011");
		mobilehm.put("3","016");
		mobilehm.put("4","017");
		mobilehm.put("5","018");
		mobilehm.put("6","019");
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
%>

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("member_main.jsp?flag=1");
	}
%>

<script language="javascript">
<!--
	function doDel(idx,id)
	{
		if (confirm("���� �Խù��� ���� �����˴ϴ�. Ż��ó�� �Ͻðڽ��ϱ�?")) {
			location.href="/asanway/member/member_action.jsp?mtype=<%=mtype%>&cmd=D&idx="+idx + "&id=" + id;
		}
	}

	function zip_search(val){
		window.open('/member/pop_search_zip.jsp?type=' + val,'','width=450,height=381,top=200,left=200,scrollbars=no');
	}

	function getEmail(type){
		var form = document.form;
		if(type == "0"){
			form.email2.value = form.email3.options[form.email3.selectedIndex].value;
		}
		else{
			form.agentemail2.value = form.agentemail3.options[form.agentemail3.selectedIndex].value;
		}
	}

	function getAddr(){
		var form = document.form;
		if(form.checkaddr.checked){
			form.agentzip.value = form.zip.value;
			form.agentzip1.value = form.zip1.value;
			form.agentzip2.value = form.zip2.value;
			form.agentaddr1.value = form.addr1.value;
			form.agentaddr2.value = form.addr2.value;
		}
		else{
			form.agentzip.value = "";
			form.agentzip1.value = "";
			form.agentzip2.value = "";
			form.agentaddr1.value ="";
			form.agentaddr2.value = "";
		}
	}


	function checkForm(mtype){
		var form = document.form;
		/*
		if( form.id.value=="" ){
			alert("id�� �Է��� �ֽʽÿ�.");
			form.id.focus();
			return false;
		}

		if (!is_range(form.id.value, 4, 10)) {
			alert("ID�� 4~10�ڸ��� �Է��� �ֽʽÿ�.");
			form.id.focus();
			return false;
		}

		if (!isUserid(form.id)) {
			alert("ID�� ������ ���ڸ� ����Ͻ� �� �ֽ��ϴ�.");
			form.id.focus();
			return false;
		}

		//��� ��ȣ Ȯ��
		if( form.pwd.value=="" ){
			alert("��й�ȣ�� �Է��� �ֽʽÿ�.");
			form.pwd.focus();
			return false;
		}

		if (!is_range(form.pwd.value, 4, 10)) {
			alert("��й��� 4~10�ڸ��� �Է��� �ֽʽÿ�.");
			form.pwd.focus();
			return false;
		}

		if (!isUserid(form.pwd)) {
			alert("��й�ȣ�� ������ ���ڸ� ����Ͻ� �� �ֽ��ϴ�.");
			form.pwd.focus();
			return false;
		}

		if( form.pwd2.value=="" ){
			alert("��й�ȣȮ���� �Է��� �ֽʽÿ�.");
			form.pwd2.focus();
			return false;
		}

		if( form.pwd.value != form.pwd2.value ){
			alert("��� ��ȣ�� ��ġ���� �ʽ��ϴ�. �ٽ� �Է��� �ֽʽÿ�.");
			form.pwd2.value = "";
			form.pwd2.focus();
			return false;
		}

		//�̸�,�ֹι�ȣ
		if( form.name.value=="" ){
			alert("�̸��� �Է��� �ֽʽÿ�.");
			form.name.focus();
			return false;
		}

		var regno = form.regno1.value + form.regno2.value;
		if (!Jumin_Num_Check(regno) ){
			alert("��ȿ���� ���� �ֹε�Ϲ�ȣ�Դϴ�.");
			form.regno1.focus();
			return false;
		}
		else{
			form.regno.value = regno;
		}
		*/

		if( !form.gender[0].checked  && !form.gender[1].checked){
			alert("������  ������ �ּ��� .");
			return false;
		}

		//���� ����
		if( form.birthdayy.selectedIndex == 0){
			alert("��������� �Է��ϼ��� .");
			form.birthdayy.focus();
			return false;
		}

		if( form.birthdaym.selectedIndex == 0 ){
			alert("��������� �Է��ϼ��� .");
			form.birthdaym.focus();
			return false;
		}

		if( form.birthdayd.selectedIndex == 0 ){
			alert("��������� �Է��ϼ��� .");
			form.birthdayd.focus();
			return false;
		}

		if( form.birthdayd.selectedIndex != 0 && form.birthdayd.selectedIndex != 0 && form.birthdayd.selectedIndex != 0){
			form.birthday.value = form.birthdayy.options[form.birthdayy.selectedIndex].value +form.birthdaym.options[form.birthdaym.selectedIndex].value +form.birthdayd.options[form.birthdayd.selectedIndex].value ;
		}
		else{
			alert("��������� �Է��ϼ��� .");
			form.birthdayy.focus();
			return false;
		}

		if( !form.birthgbn[0].checked  && !form.birthgbn[1].checked){
			alert("���� ������  ������ �ּ��� .");
			return false;
		}

		//�ּ� �Է� Ȯ��
		if( form.zip1.value=="" || form.zip2.value==""){
			alert("�����ȣ��  �Է��� �ֽʽÿ�.");
			form.zip1.focus();
			return false;
		}
		else{
			form.zip.value = form.zip1.value + form.zip2.value;
		}

		if( form.addr1.value=="" || form.addr2.value==""){
			alert("�ּҸ�  �Է��� �ֽʽÿ�.");
			form.addr2.focus();
			return false;
		}

		//��ȭ��ȣ
		if( form.tel1.value=="" || form.tel2.value=="" || form.tel3.value== ""){
			alert("��ȭ��ȣ�� ��Ȯ��  �Է��� �ֽʽÿ�.");
			form.tel1.focus();
			return false;
		}
		else if(isNumberCheck(form.tel1.value+form.tel2.value+form.tel3.value)){
			alert("��ȭ��ȣ�� ���ڸ� �Է� �����մϴ�..");
			form.tel1.focus();
			return false;
		}
		else{
			form.tel.value = form.tel1.value + "-" + form.tel2.value+ "-" + form.tel3.value;
		}

		//�ڵ��� ��ȣ
		if( form.mobile1.selectedIndex != 0 || form.mobile2.value !="" || form.mobile3.value != ""){
			if( form.mobile1.selectedIndex== 0 || form.mobile2.value=="" || form.mobile3.value== ""){
				alert("�ڵ�����ȣ�� ��Ȯ��  �Է��� �ֽʽÿ�.");
				form.mobile1.focus();
				return false;
			}
			else if(isNumberCheck(form.mobile2.value+form.mobile3.value)){
				alert("�ڵ�����ȣ�� ���ڸ� �Է� �����մϴ�..");
				form.mobile2.focus();
				return false;
			}
			else{
				form.mobile.value = form.mobile1.options[form.mobile1.selectedIndex].value + "-" + form.mobile2.value+  "-" + form.mobile3.value;
			}
		}

		//�̸��� Ȯ��
		if( form.email1.value=="" || form.email2.value=="" ){
			alert("�̸��� �ּҸ�   �Է��� �ֽʽÿ�.");
			form.email1.focus();
			return false;
		}
		else if(!CheckEmail(form.email1.value+ "@" +form.email2.value)){
			alert("�ùٸ� �̸��� �ּҰ� �ƴմϴ�. �ٽ� �Է��� �ֽʽÿ�.");
			form.email1.focus();
			return false;
		}
		else{
			form.email.value = form.email1.value + "@" + form.email2.value;
		}

		//14�� �̸� ���� �븮�� �Է� ���� Ȯ��
		if(mtype == "1"){
			//�̸�,�ֹι�ȣ
			if( form.agentname.value=="" ){
				alert("���� �븮���̸��� �Է��� �ֽʽÿ�.");
				form.agentname.focus();
				return false;
			}

			var agentregno = form.agentregno1.value + form.agentregno2.value;
			if (!Jumin_Num_Check(agentregno) ){
				alert("��ȿ���� ���� �ֹε�Ϲ�ȣ�Դϴ�.");
				form.agentregno1.focus();
				return false;
			}
			else{
				form.agentregno.value = agentregno;
			}

			//�̸��� Ȯ��
			if( form.agentemail1.value=="" || form.agentemail2.value=="" ){
				alert("�̸��� �ּҸ�   �Է��� �ֽʽÿ�.");
				form.agentemail1.focus();
				return false;
			}
			else if(!CheckEmail(form.agentemail1.value+ "@" +form.agentemail2.value)){
				alert("�ùٸ� �̸��� �ּҰ� �ƴմϴ�. �ٽ� �Է��� �ֽʽÿ�.");
				form.agentemail1.focus();
				return false;
			}
			else{
				form.agentemail.value = form.agentemail1.value + "@" + form.agentemail2.value;
			}

			//�ּ� �Է� Ȯ��
			if( form.agentzip1.value=="" || form.agentzip2.value==""){
				alert("���� �븮�� �ּ� �����ȣ��  �Է��� �ֽʽÿ�.");
				form.agentzip1.focus();
				return false;
			}
			else{
				form.agentzip.value = form.agentzip1.value + form.agentzip2.value;
			}

			if( form.agentaddr1.value=="" || form.agentaddr2.value==""){
				alert("���� �븮�� �ּҸ�  �Է��� �ֽʽÿ�.");
				form.agentaddr2.focus();
				return false;
			}

			//��ȭ��ȣ
			if( form.agenttel1.value=="" || form.agenttel2.value=="" || form.agenttel3.value== ""){
				alert("���� �븮�� ��ȭ��ȣ�� ��Ȯ��  �Է��� �ֽʽÿ�.");
				form.agenttel1.focus();
				return false;
			}
			else if(isNumberCheck(form.agenttel1.value+form.agenttel2.value+form.agenttel3.value)){
				alert("���� �븮�� ��ȭ��ȣ�� ���ڸ� �Է� �����մϴ�..");
				form.agenttel1.focus();
				return false;
			}
			else{
				form.agenttel.value = form.agenttel1.value + "-" + form.agenttel2.value+ "-" + form.agenttel3.value;
			}
		}

		//ID�ߺ� Ȯ��
		/*
		if( form.checkid.value=="" ){
			alert("ID�ߺ�Ȯ���� ���ֽʽÿ�.");
			return false;
		}*/

		return true;
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
	                <td valign="top" bgcolor="FCFCF6"> <jsp:include page="/asanway/common/member_leftmenu.jsp" flush="true" /></td>
	                <td width="2"></td>
	              </tr>
	            </table>
          </td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                       <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>ȸ������ </b></td>
                    </tr>

                    <form name="form" method="post" action="member_action.jsp" onSubmit="return checkForm(<%=mtype%>)">
					<input type="hidden" name="cmd" value="U">
                     	<input type="hidden" name="mtype" value="<%=mtype%>">
						<input type="hidden" name="idx" value="<%= request.getParameter("idx")%>">
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="603">
                         <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td width="90" height="30" valign="top" bgcolor="F2F1E2"  style="padding: 10 0 0 15 ;">���̵�</td>
                            <td style="padding-left:5;"><%= read.get("ID") %></td>
							</tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">��й�ȣ</td>
                            <td style="padding-left:5;"><%= read.get("PWD") %></td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">�̸� </td>
                            <td style="padding-left:5;"><%= Utility.ko((String)read.get("NAME")) %></td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
							  <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">�ֹε�Ϲ�ȣ</td>
                            <td style="padding-left:5;">
                            	<%= read.get("REGNO").toString().substring(0, 6) %> - <%= read.get("REGNO").toString().substring(6, 13) %>&nbsp;&nbsp;
								<input type="radio" name="gender" value="F" <%if(read.get("GENDER")!=null && read.get("GENDER").equals("F")){%> checked <%}%>>�� &nbsp;
                            	<input type="radio" name="gender" value="M" <%if(read.get("GENDER")!=null && read.get("GENDER").equals("M")){%> checked <%}%>>��  &nbsp;
							</td>
                          </tr>
						  <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                           <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">������� </td>
                            <td style="padding-left:5;">
                            	<input type=hidden name="birthday" value="<%=read.get("BIRTHDAY")%>">
                            	<select name="birthdayy"  style="width:60px;height:20px" >
                            		<option value="">����</option>
                            		<%for(int i=Utility.getYear();i>=1900;i--){%>
										<option value=<%=i%><%if(Integer.parseInt(read.get("BIRTHDAY").toString().substring(0, 4)) == i ){%> selected <%}%>><%=i%></option>
									<%}%>
								</select> ��
								<select name="birthdaym"  style="width:60px;height:20px" >
                            		<option value="">����</option>
                            		<%for(int i=1;i<13 ;i++){%>
										<option value="<%=Utility.toString(Integer.toString(i),2)%>" <%if(read.get("BIRTHDAY").toString().substring(4, 6).equals(Utility.toString(Integer.toString(i),2))){%> selected <%}%>><%=Utility.toString(Integer.toString(i),2)%></option>
									<%}%>
								</select> ��
								<select name="birthdayd"  style="width:60px;height:20px" >
                            		<option value="">����</option>
                            		<%for(int i=1;i<31;i++){%>
										<option value="<%=Utility.toString(Integer.toString(i),2)%>" <%if(read.get("BIRTHDAY").toString().substring(6, 8).equals(Utility.toString(Integer.toString(i),2)) ){%> selected <%}%>><%=Utility.toString(Integer.toString(i),2)%></option>
									<%}%>
								</select> ��
								<input type="radio" name="birthgbn" value="S" <%if(read.get("BIRTHGBN").equals("S")){%> checked <%}%>>���&nbsp;
                            	<input type="radio" name="birthgbn" value="L" <%if(read.get("BIRTHGBN").equals("L")){%> checked <%}%>>���� &nbsp;
                            </td>
                          </tr>
						  <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
						  <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">�ּ�</td>
                            <td style="padding-left:5;">
	                            <input type="radio" name="addrgbn" value="H" <%if(read.get("ADDRGBN")!=null && read.get("ADDRGBN").equals("H")){%> checked <%}%>>���� &nbsp;
	                            <input type="radio" name="addrgbn" value="C" <%if(read.get("ADDRGBN")!=null && read.get("ADDRGBN").equals("C")){%> checked <%}%>>���� &nbsp; &nbsp;
	                            <font color="bbbbbb">|</font>&nbsp;&nbsp;
								<font color="bbbbbb">|</font>&nbsp;&nbsp;
	                            <input type=hidden name="zip" value="<%=read.get("ZIP")!=null ? read.get("ZIP"):"" %>">
	                            <input type=hidden name="area" value="<%=read.get("AREA")!=null ? read.get("AREA"):""%>">
	                            <input type=text name="zip1" value="<%=read.get("ZIP")!=null?read.get("ZIP").toString().substring(0,3) : ""%>" size=3>-
	                            <input type=text name="zip2" value="<%=read.get("ZIP")!=null?read.get("ZIP").toString().substring(3,6) : ""%>" size=3>
	                            <a href="javascript:zip_search('mem');" ><img src="/img/member/btn_sch_zip.gif" align="absmiddle" border=0></a>
                            </td>
                          </tr>
						  <tr>
                            <td height="1" bgcolor="F2F1E2"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="25" bgcolor="F2F1E2" valign="top" >&nbsp;</td>
                            <td style="padding-left:5;"><input type=text name="addr1" value="<%=Utility.ko((String)read.get("ADDR1"))%>" size=80></td>
                          </tr>
						  <tr>
                            <td height="1" bgcolor="F2F1E2"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="25" bgcolor="F2F1E2" valign="top">&nbsp;</td>
                            <td style="padding-left:5;"><input type=text name="addr2" value="<%=Utility.ko((String)read.get("ADDR2"))%>" size=80></td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
						  <tr>
                          	<input type=hidden name="tel" value="<%=read.get("TEL")%>">
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>��ȭ��ȣ</p></td>
                            <td  style="padding: 10 10 10 10 ;">
                            	<input type="radio" name="telgbn" value="H" <%if(read.get("TELGBN")!=null && read.get("TELGBN").equals("H")){%> checked <%}%>>����&nbsp;
								<input type="radio" name="telrgbn" value="C" <%if(read.get("TELGBN")!=null && read.get("TELGBN").equals("C")){%> checked <%}%>>����&nbsp; &nbsp;
	                             <font color="bbbbbb">|</font>&nbsp;&nbsp;
	                             <input type=text name="tel1" value="<%=(read.get("TEL") == null) ? "" : Utility.getTel((String)read.get("TEL"),1)%>" size=4> -
	                             <input type=text name="tel2" value="<%=(read.get("TEL") == null) ? "" : Utility.getTel((String)read.get("TEL"),2)%>" size=4> -
	                             <input type=text name="tel3" value="<%=(read.get("TEL") == null) ? "" : Utility.getTel((String)read.get("TEL"),3)%>" size=4>
	                            
	                         </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
						  <tr>
                          	<input type=hidden name="mobile" value="<%=read.get("MOBILE")%>">
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">�ڵ�����ȣ</td>
                            <td style="padding-left:5;">
								 <SELECT NAME="mobile1" STYLE="width:50px;">
										<option value="">����</option>
										<%for ( int i = 1 ; i <= mobilehm.size(); i++) {%>
												<option value=<%=mobilehm.get(Integer.toString(i))%> <%if(read.get("MOBILE") != null && Utility.getTel((String)read.get("MOBILE"),1).equals(mobilehm.get(Integer.toString(i)))){%> selected <%}%>><%=mobilehm.get(Integer.toString(i))%></option>
										<%}%>
									</SELECT> -
	                             <input type=text name="mobile2" value="<%=(read.get("MOBILE") == null) ? "" :Utility.getTel((String)read.get("MOBILE"),2)%>" size=4> -
	                             <input type=text name="mobile3" value="<%=(read.get("MOBILE") == null) ? "" :Utility.getTel((String)read.get("MOBILE"),3)%>" size=4>
							</td>
                          </tr>
						   <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

                          <%if(!read.get("ISREAL").equals("1")){%>
	                          <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>����</p></td>
	                            <td  style="padding: 10 10 10 10 ;">
									<select name="job"  style="height:20px" >
										<option value="">����</option>
										<%for ( int i = 1 ; i <= jobhm.size(); i++) {%>
												<option value=<%=i%> <%if (read.get("JOB") != null && i == Integer.parseInt((String)read.get("JOB"))){%> selected <%}%>><%=jobhm.get(Integer.toString(i))%></option>
										<%}%>
									</select>
	                            </td>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
							  <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>ȸ���
	                              </p></td>
	                            <td  style="padding: 10 10 10 10 ;"><input type=text name="company" value="<%=Utility.ko((String)read.get("COMPANY"))%>" ></td>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
                          <%}%>
						  <tr>
                          	<input type=hidden name=email value="<%=read.get("EMAIL")%>">
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">�̸���</td>
                            <td style="padding-left:5;">
                            	<input type=text name="email1" value="<%=Utility.getEmail((String)read.get("EMAIL"),1)%>" >@
                            	<input type=text name="email2" value="<%=Utility.getEmail((String)read.get("EMAIL"),2)%>" >
                                <select name="email3"  style="height:20px" onchange="getEmail('0');"  >
									<option value="">[�����Է�]</option>
									<%for ( int i = 1; i <= emailhm.size(); i++) {%>
											<option value=<%=emailhm.get(Integer.toString(i))%> <%if (emailhm.get(Integer.toString(i)).toString().trim().equals(Utility.getEmail((String)read.get("EMAIL"),2).trim())){%> selected <%}%>><%=emailhm.get(Integer.toString(i))%></option>
									<%}%>
								</select>
                            </td>
                          </tr>
						   <tr>
                            <td height="1" bgcolor="F2F1E2"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="25" bgcolor="F2F1E2" valign="top" >&nbsp;</td>
                            <td class="pass" style="padding-left:5;">* Daum ������ �¶��ο�ǥ���� ����
                              ���� ������ �ȵ� �� ������ �ٸ� ���� ������ ����� �ֽñ� �ٶ��ϴ�.</td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
						  <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>���Ѱ�������</p></td>
                            <td style="padding-left:5;">
                            	<input type="radio" name="istravel" value="0"  <%if(ISTRAVEL.equals("0")){%> checked <%}%>>������ �ʾ��� &nbsp;
                            	<input type="radio" name="istravel" value="1"  <%if(ISTRAVEL.equals("1")){%> checked <%}%>>������ ����
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>�ΰ�����<br>
                              </p></td>
                            <td style="padding-left:5;"><input type="checkbox" name="isletter" value="1" <%if(ISLETTER.equals("1")){%> checked <%}%>> �������� ����
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
						  <%if(mtype.equals("1")){%>
							<tr>
								<td height=50><b>�����븮�� ���� </b></td>
							</tr>
							<tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                        </tr>
							<tr height="30">
								<td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>����</p></td>
								<td><INPUT TYPE="text" NAME="agentname" maxlength=20 value="<%=Utility.ko((String)read.get("AGENTNAME"))%>"> </td>
							</tr>
							<tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                        </tr>
							<tr height="30">
								<input type=hidden name=agentregno value="<%=read.get("AGENTREGNO")%>">
								<td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>�ֹε�Ϲ�ȣ</p> </td>
								<td>
									<INPUT TYPE="text" NAME="agentregno1" style="width:70; height:18;" class="gray_input" maxlength=6 onKeyup=movenext(this.form.agentregno1,this.form.agentregno2,6) value="<%= read.get("REGNO").toString().substring(0, 6) %>"> -
									<INPUT TYPE="text" NAME="agentregno2" style="width:70; height:18;" class="gray_input"  maxlength=7  value="<%= read.get("REGNO").toString().substring(6, 13) %>">
								</td>
							</tr>
							<tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                        </tr>
							<tr height="30">
								<input type=hidden name=agentemail value="<%=read.get("AGENTEMAIL")%>">
								<td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>�̸��� </p></td>
								<td>
									<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td width=""><INPUT TYPE="text" NAME="agentemail1" value="<%=Utility.getEmail((String)read.get("AGENTEMAIL"),1)%>"> @ <INPUT TYPE="text" NAME="agentemail2" style="width:150; " value="<%=Utility.getEmail((String)read.get("AGENTEMAIL"),2)%>"></td>
										<td width="10"></td>
										<td width="">
											<SELECT ID="agentemail3"  STYLE="width:100px;" onChange="getEmail('1');">
												<option value="">[�����Է�]</option>
												<%for ( int i = 1; i <= emailhm.size(); i++) {%>
														<option value=<%=emailhm.get(Integer.toString(i))%> <%if (emailhm.get(Integer.toString(i)).toString().trim().equals(Utility.getEmail((String)read.get("AGENTEMAIL"),2).trim())){%> selected <%}%>><%=emailhm.get(Integer.toString(i))%></option>
												<%}%>
											</select>
										</td>
									</tr>
									</table>
								</td>
							</tr>
							<tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                        </tr>
							<tr height="75">
								<input type=hidden name=agentzip value="<%=read.get("AGENTZIP")%>">
								<td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>�ּ�</p></td>
								<td>
									<table border="0" cellpadding="0" cellspacing="0">
									<tr height="22">
										<td>
											<INPUT TYPE="text" NAME="agentzip1" style="width:50; "  readonly maxlength=3 value="<%=read.get("AGENTZIP").toString().substring(0,3)%>" > -
											<INPUT TYPE="text" NAME="agentzip2" style="width:50; "  readonly maxlength=3 value="<%=read.get("AGENTZIP").toString().substring(0,3)%>" >
											<a href="javascript:zip_search('agent')" ><img src="/img/member/btn_sch_zip.gif" align="absmiddle" border=0></a>&nbsp;&nbsp;
											<INPUT TYPE="checkbox" NAME="checkaddr" value="1" onClick="javascript:getAddr();">���� ����
										</td>
									</tr>
									<tr height="22">
										<td><INPUT TYPE="text" NAME="agentaddr1" style="width:450; height:18;" class="gray_input" readonly value="<%=Utility.ko((String)read.get("AGENTADDR1"))%>"></td>
									</tr>
									<tr height="22">
										<td><INPUT TYPE="text" NAME="agentaddr2" style="width:450; height:18;" class="gray_input" value="<%=Utility.ko((String)read.get("AGENTADDR2"))%>"></td>
									</tr>
									</table>
								</td>
							</tr>
							<tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                        </tr>
							<tr height="30">
								<input type=hidden name=agenttel value="<%=read.get("AGENTTEL")%>">
								<td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>��ȭ��ȣ</p></td>
								<td>
									<INPUT TYPE="text" NAME="agenttel1" style="width:50;"  maxlength=4 value="<%=(read.get("AGENTTEL") == null) ? "" :Utility.getTel((String)read.get("AGENTTEL"),1)%>"> -
									<INPUT TYPE="text" NAME="agenttel2" style="width:50;"  maxlength=4 value="<%=(read.get("AGENTTEL") == null) ? "" :Utility.getTel((String)read.get("AGENTTEL"),2)%>"> -
									<INPUT TYPE="text" NAME="agenttel3" style="width:50;"  maxlength=4 value="<%=(read.get("AGENTTEL") == null) ? "" :Utility.getTel((String)read.get("AGENTTEL"),3)%>">
								</td>
							</tr>
							<tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                        </tr>
							<!-- //�����븮�������Է�-->
						<%}%>
                        </table>
						</td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;">
                        	<input type=image src="../img/bt_08.gif" border="0">
                        	<a href="member_general_list.jsp?mtype=<%=mtype%>"><img src="../img/bt_10.gif" hspace="4" border="0"></a>
                        	<a href="javascript:doDel(<%=request.getParameter("idx")%>,'<%=read.get("ID")%>')"><img src="../img/bt_23.gif" border="0"></a>
                      </td>
                    </tr>
                    <tr>
                      <td height="50" align="center">&nbsp;</td>
                    </tr>
					</form>

                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table></td>
        </tr>
      </table></td>
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