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
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.net.*" %>
<%@ page import= "com.hmm.asan.common.util.Utility"%>

<%
	//���� �ܰ迡�� ����� ������(�Ǹ����� ������) ���� ���� step 2.
	String sRefUrl = "";
	//if ( request.getHeader("Referer") != null ) sRefUrl = request.getHeader("Referer");
	//if ( sRefUrl.indexOf("member_action.jsp") == -1 ) response.sendRedirect("/member/join_agreement.jsp");
	
	String name = "";
	String regno1 = "";
	String regno2 = "";

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
<%
  String McNum= "0";
  String sub= "0";
%>
<html>
<head>
<title> �ݰ������      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>

<script language="JavaScript" src="<%=imageServer%>/tour_common/checkform.js"></script>

<script language="javascript">

<!--
	function idcheck()
	{
		var x=document.form.id;

		if (x.value=="")
		{
			alert("���̵� �Է��� �ּ���");
			x.focus();
			return;
		}
		else
		{
			if (!is_range(x.value, 4, 10)) 
			{
				alert("���̵�� 4~10�ڸ��� �Է��� �ֽʽÿ�.");
				x.focus();
				return;
			}
			else if ( !isUserid(x) )
			{
				alert("���̵�� ������ ���ڸ� ����Ͻ� �� �ֽ��ϴ�.");
				x.focus();
				return;
			}
			else
			{
				var winOpts="width=450,height=337,scrollbars=no";
				var url = "/member/pop_check_id.jsp"+
					 "?id=" + x.value;
				 window.open(url,"IDCheck",winOpts);
			}
		}
	}

	function zip_search(val)
	{
		window.open('/member/pop_search_zip.jsp?type=' + val,'','width=450,height=460,top=200,left=200,scrollbars=no');
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
			alert("���̵� �Է��� �ֽʽÿ�.");
			form.id.focus();
			return;
		}

		if (!is_range(form.id.value, 4, 10)) 
		{
			alert("���̵�� 4~10�ڸ��� �Է��� �ֽʽÿ�.");
			form.id.focus();
			return;
		}

		if (!isUserid(form.id))
		{
			alert("���̵�� ������ ���ڸ� ����Ͻ� �� �ֽ��ϴ�.");
			form.id.focus();
			return;
		}

		//��� ��ȣ Ȯ��
		if( form.pwd.value=="" )
		{
			alert("��й�ȣ�� �Է��� �ֽʽÿ�.");
			form.pwd.focus();
			return;
		}

		if (!is_range(form.pwd.value, 4, 10)) 
		{
			alert("��й��� 4~10�ڸ��� �Է��� �ֽʽÿ�.");
			form.pwd.focus();
			return;
		}

		if (!isUserid(form.pwd))
		{
			alert("��й�ȣ�� ������ ���ڸ� ����Ͻ� �� �ֽ��ϴ�.");
			form.pwd.focus();
			return;
		}

		if( form.pwd2.value=="" )
		{
			alert("��й�ȣȮ���� �Է��� �ֽʽÿ�.");
			form.pwd2.focus();
			return;
		}

		if( form.pwd.value != form.pwd2.value )
		{
			alert("��� ��ȣ�� ��ġ���� �ʽ��ϴ�. �ٽ� �Է��� �ֽʽÿ�.");
			form.pwd2.value = "";
			form.pwd2.focus();
			return;
		}

		//�̸�,�ֹι�ȣ
		if( form.name.value=="" )
		{
			alert("�̸��� �Է��� �ֽʽÿ�.");
			form.name.focus();
			return;
		}

		var regno = form.regno1.value + form.regno2.value;
		if (!Jumin_Num_Check(regno) )
		{
			alert("��ȿ���� ���� �ֹε�Ϲ�ȣ�Դϴ�.");
			form.regno1.focus();
			return;
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
			return;
		}

		if( form.birthdaym.selectedIndex == 0 )
		{
			alert("��������� �Է��ϼ��� .");
			form.birthdaym.focus();
			return;
		}

		if( form.birthdayd.selectedIndex == 0 )
		{
			alert("��������� �Է��ϼ��� .");
			form.birthdayd.focus();
			return;
		}

		if( form.birthdayd.selectedIndex != 0 && form.birthdayd.selectedIndex != 0 && form.birthdayd.selectedIndex != 0)
		{
			form.birthday.value = form.birthdayy.options[form.birthdayy.selectedIndex].value +form.birthdaym.options[form.birthdaym.selectedIndex].value +form.birthdayd.options[form.birthdayd.selectedIndex].value ;
		}
		else
		{
			alert("��������� �Է��ϼ��� .");
			form.birthdayy.focus();
			return;
		}

		if( !form.birthgbn[0].checked  && !form.birthgbn[1].checked)
		{
			alert("���� ������  ������ �ּ��� .");
			return;
		}

		//�ּ� �Է� Ȯ��
		if( form.zip1.value=="" || form.zip2.value=="")
		{
			alert("�����ȣ��  �Է��� �ֽʽÿ�.");
			form.zip1.focus();
			return;
		}
		else
		{
			form.zip.value = form.zip1.value + form.zip2.value;
		}

		if( form.addr1.value=="" || form.addr2.value=="")
		{
			alert("�ּҸ�  �Է��� �ֽʽÿ�.");
			form.addr2.focus();
			return;
		}

		//��ȭ��ȣ
		if( form.tel1.value=="" || form.tel2.value=="" || form.tel3.value== "")
		{
			alert("��ȭ��ȣ or �ڵ�����ȣ �� ��Ȯ��  �Է��� �ֽʽÿ�.");
			form.tel1.focus();
			return;
		}
		else if(isNumberCheck(form.tel1.value+form.tel2.value+form.tel3.value))
		{
			alert("��ȭ��ȣ or �ڵ�����ȣ �� ���ڸ� �Է� �����մϴ�..");
			form.tel1.focus();
			return;
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
			return;
		}
		else if(!CheckEmail(form.email.value))
		{
			alert("�ùٸ� �̸��� �ּҰ� �ƴմϴ�. �ٽ� �Է��� �ֽʽÿ�.");
			form.email.focus();
			return;
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
			return;
		}
		//return true;
		form.submit();
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


</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../include/member/tour_member_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/tour_img/leftMenu07.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/mem/tit_mem01.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">ȸ������</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>
<form name="form" method="post" action="member_action.jsp">
     	<input type="hidden" name="cmd" value="I">
     	<input type=hidden name=isreal value="0">
     	<input type=hidden name=area value="">
     	<input type=hidden name=checkid value="">
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/mem/img_top_mem02.jpg"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="19" class="bg_dblue" valign="top"><img src="<%=imageServer%>/tour_img/mem/txt_mem2.gif" style="margin:4 0 0 12px;"></td></tr>
						<tr><td height="35" align="right"><img src="<%=imageServer%>/tour_img/mem/txt_regist00.gif" hspace="10"></td></tr>
						</table>

						<!-- / insert table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="114"><col width="1"><col width="565" class="lpad_10">
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist01.gif"><!-- �̸� --></td>
							<td><input type="text" name="name" maxlength=20 style="width:152px;"></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist02.gif"><!-- �ֹε�Ϲ�ȣ --></td>
							<td class="txt_gray">
							<input type=hidden name="regno" value="<%=regno.trim()%>">
							<input type="text" name="regno1" style="width:152px;"  > - 
							<input type="text" name="regno2" style="width:152px;" ></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
						    <input type=hidden name="birthday" value="">
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist03.gif"><!-- ������� --></td>
							<td>					
								<select name="birthdayy" style="width:58px" class="fs11">
                                  <option value="">����</option>
                                  <%for(int i=Utility.getYear();i>=1900;i--){%>
                                  	<option value=<%=i%>><%=i%></option>
                                  <%}%>
								</select> ��							
								<select name="birthdaym" style="width:45px" class="fs11">
                                  <option value="">����</option>
                                  <%for(int i=1;i<13;i++){%>
                                  	<option value="<%=Utility.toString(Integer.toString(i),2)%>" ><%=Utility.toString(Integer.toString(i),2)%></option>
                                  <%}%>
								</select> ��
								<select name="birthdayd" style="width:45px" class="fs11">
                                  <option value="">����</option>
                                  <%for(int i=1;i<=31;i++){%>
                                  	<option value="<%=Utility.toString(Integer.toString(i),2)%>" ><%=Utility.toString(Integer.toString(i),2)%></option>
                                  <%}%>
								</select> ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								
						
								<input type="radio" name="birthgbn" class="noborder" value="S"  checked>���&nbsp;&nbsp;&nbsp;
								<input type="radio" name="birthgbn" class="noborder" value="M" >����
							</td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist04.gif"><!-- ���̵� --></td>
							<td><input type="text" name="id" style="width:152px;" maxlength="10">
							<a href="javascript:idcheck()"><img src="<%=imageServer%>/tour_img/btn/btn_s_idsamecheck.gif" hspace="5" align="absmiddle"></a><!-- ���̵��ߺ�Ȯ�� --></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist05.gif"><!-- ��й�ȣ --></td>
							<td><input type="password" name="pwd" style="width:152px;" maxlength="10"></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist06.gif"><!-- ��й�ȣ Ȯ�� --></td>
							<td><input type="password" name="pwd2" style="width:152px;" maxlength="10"></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
						    <input type=hidden name="zip" value="">
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist07.gif"><!-- �����ȣ --></td>
							<td>
							<input type="text" name="zip1" style="width:50px;" maxlength="3"> - 
							<input type="text" name="zip2" style="width:50px;" maxlength="3"> - 
							<a href="javascript:zip_search('mem');"><img src="<%=imageServer%>/tour_img/btn/btn_s_postsch.gif" hspace="5" align="absmiddle"></a><!-- �����ȣ�˻� --></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist08.gif"><!-- �ּ� --></td>
							<td><input type="text" name="addr1" style="width:463px;" maxlength="100"></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr>
							<td height="26" colspan="2"><img src="<%=imageServer%>/tour_img/mem/txt_regist09.gif"><!-- ������ �ּ� --></td>
							<td><input type="text" name="addr2" style="width:463px;" maxlength="100"></td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr><td height="10" colspan="3"></td></tr>
						<tr>
							<td height="26"><img src="<%=imageServer%>/tour_img/mem/txt_regist10.gif"><!-- ����ó --></td>
							<td class="bg_dgray"></td>
							<td>
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr>
								    <input type=hidden name="tel" value="">
									<td  class="gray">
									<select name="tel1" style="width:45px" class="fs11" onChange="changeMobileChecked(this)">
										<option value="">����</option>
										<%for ( int i = 0 ; i < aMobileNum.length; i++) { %>
												<option value=<%=aMobileNum[i]%>><%=aMobileNum[i]%></option>
										<%}%>
										<option value="">---</option>
										<%for ( int i = 0 ; i < aTelNum.length; i++) { %>
												<option value=<%=aTelNum[i]%>><%=aTelNum[i]%></option>
										<%}%>
									</select> - 
									<input type="text" name="tel2" style="width:82px;" maxlength="4"> - 
									<input type="text" name="tel3" style="width:82px;" maxlength="4"></td>
								</tr>
								<tr valign="top">
								    <input type=hidden name=issms value="">
									<td class="tpad_3 fs11 lh14">
									<input type="checkbox" name="issmscheck" class="noborder" disabled>
									<span class="txt_sky">�ݰ������      Ȩ���������� �����ϴ� ������ ���� �޽���(SMS)�� �ްڽ��ϴ�.</span><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SMS ������ ���Ͻø� �̵���ȭ ��ȣ�� ����Ͽ� �ֽʽÿ�.</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td height="7" colspan="3"></td></tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr><td height="10" colspan="3"></td></tr>
						<tr>
							<td height="26"><img src="<%=imageServer%>/tour_img/mem/txt_regist11.gif"><!-- �̸��� �ּ� --></td>
							<td class="bg_dgray"></td>
							<td>
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td  class="gray"><input type="text" name="email" style="width:321px;" maxlength="100"></td>
								</tr>
								<tr valign="top">
								    <input type=hidden name=isletter value="">
									<td class="tpad_3 fs11">
									<input type="checkbox" name="checkisletter" class="noborder">
									<span class="txt_sky">�ݰ������      Ȩ���������� �����ϴ� ���ϸ� ���񽺸� �ްڽ��ϴ�.</span></td>
								</tr>
								<tr valign="top">
									<td class="tpad_3 fs11 lh14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1:1 ���, ������ ���� �� ��й�ȣ ã�⿡ �ʿ��մϴ�.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ַ� ����Ͻô� �̸��� �ּҸ� �Է��Ͽ� �ֽð�, ���� �Ѹ���(hanmail.net)�� ���� ������ ����<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���� �� ������ ������ ����� �����Ͽ� �ֽʽÿ�.</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td height="7" colspan="3"></td></tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						</table>
						<!-- insert table / -->
</form>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="30"></td></tr>
						<tr><td align="center">
						<a href="javascript:checkForm();"><img src="<%=imageServer%>/tour_img/btn/btn_mem_regist.gif" class="btn"></a>
						<a href="javascript:document.form.reset();"><img src="<%=imageServer%>/tour_img/btn/btn_mem_cancel.gif" class="btn"></a></td></tr>
						</table>
					</td>
				</tr>
				</table>
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
        <%@ include file="../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>