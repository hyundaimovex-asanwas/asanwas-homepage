<%--
  - �ۼ���: ������ 
  - �ۼ� ����: 2006.06.08
  - ���� ������ : ������
  - ���� ������ : 2006.06.08
  - ���۱� ǥ��: IMJ Korea
  - ����: ȸ������ ���� ���� 
			���� �Ұ� : ���̵�� ����, �ֹι�ȣ
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="com.hmm.asan.www.member.MemberBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.net.*" %>

<%//�α��� üũ %>
<%@ include file="/common/logincheck.jsp" %>
<%

	MemberBean bean = new MemberBean();
	bean.Read(request, response);

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

	// �ڵ��� ��ȣ.
	String[] aMobileNum = {"010", "011", "016", "017", "019"};

	//���� ��ȭ��ȣ ����
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

	//�����ȣ : ������ ���� ��� substring �� ���� ���� ��ó
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
		
		//�ֹι�ȣ
		form.regno.value = form.regno1.value + form.regno2.value;

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
		//	alert("�����ȣ��  �Է��� �ֽʽÿ�.");
		//	form.zip1.focus();
		//	return false;
		}
		else{
			form.zip.value = form.zip1.value + form.zip2.value;
		}

		if( form.addr1.value=="" || form.addr2.value==""){
			//alert("�ּҸ�  �Է��� �ֽʽÿ�.");
			//form.addr2.focus();
			//return false;
		}

		//��ȭ��ȣ
		if( form.tel1.value=="" || form.tel2.value=="" || form.tel3.value== ""){
			alert("��ȭ��ȣ/�ڵ�����ȣ �� ��Ȯ��  �Է��� �ֽʽÿ�.");
			form.tel1.focus();
			return false;
		}
		else if(isNumberCheck(form.tel1.value+form.tel2.value+form.tel3.value)){
			alert("��ȭ��ȣ/�ڵ�����ȣ �� ���ڸ� �Է� �����մϴ�..");
			form.tel1.focus();
			return false;
		}
		else{
			form.tel.value = form.tel1.value + "-" + form.tel2.value+ "-" + form.tel3.value;
		}

		//�̸��� Ȯ��
		if( form.email.value==""  ){
			alert("�̸��� �ּҸ�   �Է��� �ֽʽÿ�.");
			form.email.focus();
			return false;
		}
		else if(!CheckEmail(form.email.value)){
			alert("�ùٸ� �̸��� �ּҰ� �ƴմϴ�. �ٽ� �Է��� �ֽʽÿ�.");
			form.email.focus();
			return false;
		}
		
		//sms ���ſ���
		if ( form.issmscheck.disabled == false ) {
			if ( form.issmscheck.checked == true ) 
				form.issms.value = "0";
		} 

		//���� ���ſ���
		if ( form.checkisletter.checked == true )
		{
			form.isletter.value = "1";
		}
		
		return true;
	}

	//�ڵ��� ��ȣ ���ý� SMS ����ǥ�� Ȱ��ȭ.
	var bCheckSmsOk = false;
	function changeMobileChecked(obj)
	{
		var aMobileNum = new Array(); // �ڵ��� ��ȣ
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
					<td height=50> <b>ȸ�� ����</b></td>
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
						<td class="ti_b" style="padding-left:9"><img src="/img/member/ico_plus.gif" align="absmiddle"> ǥ�ô� �ʼ� �Է� �׸� �Դϴ�. <br>*�̸�, ���̵�, �ֹε�Ϲ�ȣ�� �����Ͻ� �� �����ϴ�.</td>
					</tr>
					<tr>
						<td colspan="2" height="8"></td>
					</tr>
					</table>

					<!-- �Է�-->
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
										<option value="">����</option>
	                            		<%for(int i=Utility.getYear();i>=1900;i--){%>
											<option value=<%=i%><%if(Integer.parseInt(read.get("BIRTHDAY").toString().substring(0, 4)) == i ){%> selected <%}%>><%=i%></option>
										<%}%>
									</SELECT>
								</td>
								<td width="10"></td>
								<td width="">
									<SELECT NAME="birthdaym" STYLE="width:60px;">
										 <option value="">����</option>
	                            		<%for(int i=1;i<13;i++){%>
											<option value="<%=Utility.toString(Integer.toString(i),2)%>" <%if(read.get("BIRTHDAY").toString().substring(4, 6).equals(Utility.toString(Integer.toString(i),2))){%> selected <%}%>><%=Utility.toString(Integer.toString(i),2)%></option>
										<%}%>
									</SELECT>
								</td>
								<td width="10"></td>
								<td width="">
									<SELECT NAME="birthdayd" STYLE="width:60px;">
										<option value="">����</option>
	                            		<%for(int i=1;i<=31;i++){%>
											<option value="<%=Utility.toString(Integer.toString(i),2)%>" <%if(read.get("BIRTHDAY").toString().substring(6, 8).equals(Utility.toString(Integer.toString(i),2)) ){%> selected <%}%>><%=Utility.toString(Integer.toString(i),2)%></option>
										<%}%>
									</SELECT>
								</td>
								<td width="10"></td>
								<td width="">
									<input type="radio" name="birthgbn" value="S" <%if(read.get("BIRTHGBN").equals("S")){%> checked <%}%>>���&nbsp;
                            		<input type="radio" name="birthgbn" value="L" <%if(read.get("BIRTHGBN").equals("L")){%> checked <%}%>>���� &nbsp;
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
						<span style="font-size:11px;word-spacing:-2px">�ִ� 10�ڱ��� �Է� �����ϸ� Ư�����ڴ� ����� �� �����ϴ�.</span> </td>
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
						<td style="padding-left:17">����ó</td>
						<td>
							<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<SELECT NAME="tel1" STYLE="width:50px;"  onChange="changeMobileChecked(this)">
										<option value="">����</option>
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
							    SMS ������ ���Ͻø� �̵���ȭ ��ȣ�� ����Ͽ� �ֽʽÿ�.<BR>
							    <input type="checkbox" name="issmscheck" disabled>�ݰ��� ���� Ȩ���������� �����ϴ� ������ ���ڸ޽����� �ްڽ��ϴ�.
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
								1:1���, ������ ���� �� ��й�ȣ ã�⿡ �ʿ� �մϴ�.<br>
								�ַ� ����Ͻô� �̸��� �ּҸ� �Է��Ͽ� �ֽð�, ���� �Ѹ���(hanmail.net)�� ���� ������ ���� ���� �� ������ ������ ����� �����Ͽ� �ֽʽÿ�.<br>
								<input type="checkbox" name="checkisletter"> �ݰ��� ���� Ȩ���������� �����ϴ� ���ϸ� ���񽺸� �ްڽ��ϴ�.
								</td>
							</tr>
							</table>
							<script>
								//SMS ���� ���� üũǥ��
								changeMobileChecked(document.form.tel1);
								var sSmscheckVal = '<%=read.get("ISSMS")%>';
								if ( sSmscheckVal == "0" ) document.form.issmscheck.checked = true;

								//���ϸ� ����Ʈ üũ
								var sLettercheckVal = '<%=ISLETTER%>';
								if ( sLettercheckVal == "1" ) document.form.checkisletter.checked = true;
							</script>

							<table border="0" cellpadding="0" cellspacing="0">
							<tr><td height="5"></td></tr>
							<tr>
								<td style="font-size:11px;word-spacing:-2px">Daum ������ �¶��ο�ǥ���� ���� ���� ������ �ȵ� �� ������ �ٸ� ���� ������ ����� �ֽñ� �ٶ��ϴ�.</td>
							</tr>
							</table>
						</td>
					</tr>
					</table>
					<!-- //�Է�-->

					<!-- Button-->
					<table border="0" cellpadding="0" cellspacing="0" width="624">
					<tr><td height="15"></td></tr>
					<tr>
						<td align="center"><input type=image src="/img/common/btn_join_apply.gif" border=0> &nbsp;&nbsp; <a href="withdrawal.jsp">ȸ��Ż��</a></td>
					</tr>
					</table>
					<!-- //Button-->


					<!----- //CONTENTS END----->

</body>
</html>