<%--
  - �ۼ���: ������
  - �ۼ� ����: 2006.06.01
  - ���� ������ : ������
  - ���� ������ : 2006.06.01
  - ���۱� ǥ��: IMJ Korea
  - ����: ������ ���� ��� ������ , ���� ���� ���������� �߰��� ���׸� ������.
			 action page : member_action.jsp ,  cmd = "I"  : ����
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.net.*" %>
<%@ page import= "com.hmm.asan.common.util.Utility"%>

<%
	//���� �ܰ迡�� ����� ������(�Ǹ����� ������) ���� ���� step 2.
	String sRefUrl = "";
	if ( request.getHeader("Referer") != null ) sRefUrl = request.getHeader("Referer");
	if ( sRefUrl.indexOf("member_action.jsp") == -1 ) response.sendRedirect("/member/join_agreement.jsp");
	
	String name = request.getParameter("name");
	String regno1 = request.getParameter("regno1");
	String regno2 = request.getParameter("regno2");

	//�ֹε�Ϲ�ȣ
	String regno = regno1 + regno2;

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

<script language="javascript">

<!--
	function idcheck()
	{
		var x=document.form.id;

		if (x.value=="")
		{
			alert("ID�� �Է��� �ּ���");
			x.focus();
			return;
		}
		else
		{
			if (!is_range(x.value, 4, 10)) 
			{
				alert("ID�� 4~10�ڸ��� �Է��� �ֽʽÿ�.");
				x.focus();
				return;
			}
			else if ( !isUserid(x) )
			{
				alert("ID�� ������ ���ڸ� ����Ͻ� �� �ֽ��ϴ�.");
				x.focus();
				return;
			}
			else
			{
				var winOpts="width=450,height=232,scrollbars=no";
				var url = "/member/pop_check_id.jsp"+
					 "?id=" + x.value;
				 window.open(url,"IDCheck",winOpts);
			}
		}
	}

	function zip_search(val)
	{
		window.open('/member/pop_search_zip.jsp?type=' + val,'','width=450,height=381,top=200,left=200,scrollbars=no');
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
			alert("id�� �Է��� �ֽʽÿ�.");
			form.id.focus();
			return false;
		}

		if (!is_range(form.id.value, 4, 10)) 
		{
			alert("ID�� 4~10�ڸ��� �Է��� �ֽʽÿ�.");
			form.id.focus();
			return false;
		}

		if (!isUserid(form.id))
		{
			alert("ID�� ������ ���ڸ� ����Ͻ� �� �ֽ��ϴ�.");
			form.id.focus();
			return false;
		}

		//��� ��ȣ Ȯ��
		if( form.pwd.value=="" )
		{
			alert("��й�ȣ�� �Է��� �ֽʽÿ�.");
			form.pwd.focus();
			return false;
		}

		if (!is_range(form.pwd.value, 4, 10)) 
		{
			alert("��й��� 4~10�ڸ��� �Է��� �ֽʽÿ�.");
			form.pwd.focus();
			return false;
		}

		if (!isUserid(form.pwd))
		{
			alert("��й�ȣ�� ������ ���ڸ� ����Ͻ� �� �ֽ��ϴ�.");
			form.pwd.focus();
			return false;
		}

		if( form.pwd2.value=="" )
		{
			alert("��й�ȣȮ���� �Է��� �ֽʽÿ�.");
			form.pwd2.focus();
			return false;
		}

		if( form.pwd.value != form.pwd2.value )
		{
			alert("��� ��ȣ�� ��ġ���� �ʽ��ϴ�. �ٽ� �Է��� �ֽʽÿ�.");
			form.pwd2.value = "";
			form.pwd2.focus();
			return false;
		}

		//�̸�,�ֹι�ȣ
		if( form.name.value=="" )
		{
			alert("�̸��� �Է��� �ֽʽÿ�.");
			form.name.focus();
			return false;
		}

		var regno = form.regno1.value + form.regno2.value;
		if (!Jumin_Num_Check(regno) )
		{
			alert("��ȿ���� ���� �ֹε�Ϲ�ȣ�Դϴ�.");
			form.regno1.focus();
			return false;
		}
		else
		{
			form.regno.value = regno;
		}

		//���� ����
		if( form.birthdayy.selectedIndex == 0)
		{
			alert("��������� �Է��ϼ��� .");
			form.birthdayy.focus();
			return false;
		}

		if( form.birthdaym.selectedIndex == 0 )
		{
			alert("��������� �Է��ϼ��� .");
			form.birthdaym.focus();
			return false;
		}

		if( form.birthdayd.selectedIndex == 0 )
		{
			alert("��������� �Է��ϼ��� .");
			form.birthdayd.focus();
			return false;
		}

		if( form.birthdayd.selectedIndex != 0 && form.birthdayd.selectedIndex != 0 && form.birthdayd.selectedIndex != 0)
		{
			form.birthday.value = form.birthdayy.options[form.birthdayy.selectedIndex].value +form.birthdaym.options[form.birthdaym.selectedIndex].value +form.birthdayd.options[form.birthdayd.selectedIndex].value ;
		}
		else
		{
			alert("��������� �Է��ϼ��� .");
			form.birthdayy.focus();
			return false;
		}

		if( !form.birthgbn[0].checked  && !form.birthgbn[1].checked)
		{
			alert("���� ������  ������ �ּ��� .");
			return false;
		}

		//�ּ� �Է� Ȯ��
		if( form.zip1.value=="" || form.zip2.value=="")
		{
			alert("�����ȣ��  �Է��� �ֽʽÿ�.");
			form.zip1.focus();
			return false;
		}
		else
		{
			form.zip.value = form.zip1.value + form.zip2.value;
		}

		if( form.addr1.value=="" || form.addr2.value=="")
		{
			alert("�ּҸ�  �Է��� �ֽʽÿ�.");
			form.addr2.focus();
			return false;
		}

		//��ȭ��ȣ
		if( form.tel1.value=="" || form.tel2.value=="" || form.tel3.value== "")
		{
			alert("��ȭ��ȣ or �ڵ�����ȣ �� ��Ȯ��  �Է��� �ֽʽÿ�.");
			form.tel1.focus();
			return false;
		}
		else if(isNumberCheck(form.tel1.value+form.tel2.value+form.tel3.value))
		{
			alert("��ȭ��ȣ or �ڵ�����ȣ �� ���ڸ� �Է� �����մϴ�..");
			form.tel1.focus();
			return false;
		}
		else
		{
			form.tel.value = form.tel1.value + "-" + form.tel2.value+ "-" + form.tel3.value;
		}

		//�̸��� Ȯ��
		if( form.email.value==""  )
		{
			alert("�̸��� �ּҸ�   �Է��� �ֽʽÿ�.");
			form.email.focus();
			return false;
		}
		else if(!CheckEmail(form.email.value))
		{
			alert("�ùٸ� �̸��� �ּҰ� �ƴմϴ�. �ٽ� �Է��� �ֽʽÿ�.");
			form.email.focus();
			return false;
		}
		
		//sms ���ſ���
		if ( form.issmscheck.disabled == false ) 
		{
			if ( form.issmscheck.checked == true ) 
				form.issms.value = "0";
		} 

		//���� ���ſ���
		if ( form.checkisletter.checked == true )
		{
			form.isletter.value = "1";
		}
		
		//ID�ߺ� Ȯ��
		if( form.checkid.value=="" )
		{
			alert("ID�ߺ�Ȯ���� ���ֽʽÿ�.");
			return false;
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
					<td width="10"><img src="/img/common/tit_left.gif"></td>
					<td><img src="/img/member/tit_02.gif"></td>
					<td align="right"><img src="/img/member/tit_img_01.gif"></td>
				</tr>
				</table>
				<!----- //Title----->

				<table border="0" cellpadding="0" cellspacing="0" width="644" height="20"><tr><td></td></tr></table>

				<table border="0" cellpadding="0" cellspacing="0" width="644" id="tarea">
				<form name="form" method="post" action="member_action.jsp" onSubmit="return checkForm()">
                     	<input type="hidden" name="cmd" value="I">
                     	<input type=hidden name=isreal value="0">
                     	<input type=hidden name=area value="">
                     	<input type=hidden name=checkid value="">
				<tr>
					<td align="center">

					<!----- CONTENTS START----->
					<!-- �ܰ�-->
					<table border="0" cellpadding="0" cellspacing="0" width="">
					<tr align="center">
						<td width="83"><img src="/img/member/img_step01.gif"></td>
						<td width="72"><img src="/img/member/img_step_arrow.gif"></td>
						<td width="83"><img src="/img/member/img_step02.gif"></td>
						<td width="72"><img src="/img/member/img_step_arrow.gif"></td>
						<td width="83"><img src="/img/member/img_step03_on.gif"></td>
						<td width="72"><img src="/img/member/img_step_arrow.gif"></td>
						<td width="83"><img src="/img/member/img_step04.gif"></td>
					</tr>
					</table>
					<!-- //�ܰ�-->
					<table border="0" cellpadding="0" cellspacing="0" width="644" height="30"><tr><td></td></tr></table>

					<table cellpadding="0" cellspacing="0" width="624">
					<tr>
						<td class="ti_b" style="padding-left:9"><img src="/img/member/ico_plus.gif" align="absmiddle"> ǥ�ô� �ʼ� �Է� �׸� �Դϴ�.</td>
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
						<td><INPUT TYPE="text" NAME="name" style="width:120; height:18;" class="gray_input" maxlength=20 value="<%=name%>" readonly></td>
					</tr>
					<tr height="30">
						<input type=hidden name=regno value="<%=regno.trim()%>">
						<td><img src="/img/member/ico_plus.gif" align="absmiddle"> <img src="/img/member/img_join_0305.gif" align="absmiddle"></td>
						<td><INPUT TYPE="text" NAME="regno1" style="width:70; height:18;" class="gray_input" value="<%=regno1%>" maxlength=6 onKeyup="movenext(this.form.regno1,this.form.regno2,6);" readonly> - <INPUT TYPE="text" NAME="regno2" style="width:70; height:18;" class="gray_input" value="<%=regno2%>" maxlength=7 readonly> &nbsp;&nbsp;
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
											<option value=<%=i%>><%=i%></option>
										<%}%>
									</SELECT>
								</td>
								<td width="10"></td>
								<td width="">
									<SELECT NAME="birthdaym" STYLE="width:60px;">
										 <option value="">����</option>
	                            		<%for(int i=1;i<13;i++){%>
											<option value="<%=Utility.toString(Integer.toString(i),2)%>" ><%=Utility.toString(Integer.toString(i),2)%></option>
										<%}%>
									</SELECT>
								</td>
								<td width="10"></td>
								<td width="">
									<SELECT NAME="birthdayd" STYLE="width:60px;">
										<option value="">����</option>
	                            		<%for(int i=1;i<=31;i++){%>
											<option value="<%=Utility.toString(Integer.toString(i),2)%>" ><%=Utility.toString(Integer.toString(i),2)%></option>
										<%}%>
									</SELECT>
								</td>
								<%
									//checked ������� ( �ֹι�ȣ�� ������ ������ ����Ѵ� )
									String sYy     = regno1.substring(0,2);
									String sMm     = regno1.substring(2,4);
									String sDd     = regno1.substring(4);
									String sGenda  = regno2.substring(0,1);
									int nGenda = Integer.parseInt(sGenda);
									if ( nGenda < 3 ) sYy = "19"+sYy; 	else sYy = "20"+sYy; 
								%>
								<script>
									document.form.birthdayy.value = "<%=sYy%>";
									document.form.birthdaym.value = "<%=sMm%>";
									document.form.birthdayd.value = "<%=sDd%>";
								</script>

								<td width="10"></td>
								<td width=""><INPUT TYPE="radio" NAME="birthgbn" value="S" checked> ���&nbsp;&nbsp; <INPUT TYPE="radio" NAME="birthgbn" value="L"> ����</td>
							</tr>
							</table>
						</td>
					</tr>
					<tr height="30">
						<td><img src="/img/member/ico_plus.gif" align="absmiddle"> <img src="/img/member/img_join_0301.gif" align="absmiddle"></td>
						<td><INPUT TYPE="text" NAME="id" style="width:120; height:18;" class="gray_input" maxlength=10>
						<a href="javascript:idcheck()"><img src="/img/member/btn_check_id.gif" align="absmiddle"></a>
						<span style="font-size:11px;word-spacing:-2px">�ִ� 10�ڱ��� �Է� �����ϸ� Ư�����ڴ� ����� �� �����ϴ�.</span></td>
					</tr>
					<tr height="30">
						<td><img src="/img/member/ico_plus.gif" align="absmiddle"> <img src="/img/member/img_join_0302.gif" align="absmiddle"></td>
						<td><INPUT TYPE="password" NAME="pwd" style="width:120; height:18;" class="gray_input" maxlength=10>
						<span style="font-size:11px;word-spacing:-2px">�ִ� 10�ڱ��� �Է� �����ϸ� Ư�����ڴ� ����� �� �����ϴ�.</span> </td>
					</tr>
					<tr height="30">
						<td><img src="/img/member/ico_plus.gif" align="absmiddle"> <img src="/img/member/img_join_0303.gif" align="absmiddle"></td>
						<td><INPUT TYPE="password" NAME="pwd2" style="width:120; height:18;" class="gray_input" maxlength=10></td>
					</tr>
					<tr height="75">
						<input type=hidden name=zip value="">
						<td valign="top" style="padding-top:8"><img src="/img/member/ico_plus.gif" align="absmiddle"> <img src="/img/member/img_join_0307.gif" align="absmiddle"></td>
						<td>
							<table border="0" cellpadding="0" cellspacing="0">
							<tr height="22">
								<td>
								<INPUT TYPE="text" NAME="zip1" style="width:50; height:18;" class="gray_input"  maxlength=3> - <INPUT TYPE="text" NAME="zip2" style="width:50; height:18;" class="gray_input" maxlength=3>
								<a href="javascript:zip_search('mem');" ><img src="/img/member/btn_sch_zip.gif" align="absmiddle" border=0></a></td>
							</tr>
							<tr height="22">
								<td><INPUT TYPE="text" NAME="addr1" style="width:450; height:18;" class="gray_input" maxlength=100></td>
							</tr>
							<tr height="22">
								<td><INPUT TYPE="text" NAME="addr2" style="width:450; height:18;" class="gray_input" maxlength=100></td>
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
												<option value=<%=aMobileNum[i]%>><%=aMobileNum[i]%></option>
										<%}%>
										<option value="">---</option>
										<%for ( int i = 0 ; i < aTelNum.length; i++) { %>
												<option value=<%=aTelNum[i]%>><%=aTelNum[i]%></option>
										<%}%>
									</SELECT>
									&nbsp;- <INPUT TYPE="text" NAME="tel2" style="width:50; height:18;" class="gray_input" maxlength=4> - <INPUT TYPE="text" NAME="tel3" style="width:50; height:18;" class="gray_input" maxlength=4>
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
								<td width=""><INPUT TYPE="text" NAME="email" style="width:200; height:18;" class="gray_input" maxlength=100></td>
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
						<td align="center"><input type=image src="/img/common/btn_join_apply.gif" border=0></td>
					</tr>
					</table>
					<!-- //Button-->


					<table border="0" cellpadding="0" cellspacing="0" width="624">
					<tr>
						<td></td>
					</tr>
					</table>

					<!----- //CONTENTS END----->

</body>
</html>
