<%--
  - �ۼ���: ������
  - �ۼ� ����: 2006.06.01
  - ���� ������ : ������
  - ���� ������ : 2006.06.05
  - ���۱� ǥ��: IMJ Korea
  - ����: ID �ߺ�Ȯ�� (���Խ�).
			action page : pop_check_id.jsp ( self page )
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>
<%@ include file="/common/properties.jsp" %>
<%@ page import="com.hmm.asan.www.member.MemberBean" %>

<%
	String msg = "";
	String msg_btn = "";
	String type = "";
	String id = request.getParameter("id");
	if(id == null) id = "";

	MemberBean bean = new MemberBean();
	int result = bean.IdCheck(request, response); //Ż�� ȸ�����̵� �� ������

	if (result == 0 ){	//��밡��
		type = "0";
		msg = "�Է��Ͻ� ���̵�(<b class=red>"+id+"</b>)�� ����Ͻ� �� �ֽ��ϴ�.";
		msg_btn="Y";
	}else{					//�̹� �������
		type = "1";
		msg = "�Է��Ͻ� ���̵�(<b class=red>"+id+"</b>)�� �̹� ������� ���̵��Դϴ�.<br>�ٽ� �˻��� �ֽʽÿ�.";
		msg_btn="N";
	}

%>
<script language="JavaScript" src="<%=imageServer%>/tour_common/checkform.js"></script>
<script language="javascript">
	<!--
	function returnid(val) {
		if(val == "0"){			//��밡��
			var x=document.form.id.value;
			opener.document.form.id.value = x;
			opener.document.form.checkid.value = "1";
		}
		else{				//��� �Ұ�
			opener.document.form.id.value = "";
		}
		window.close();
	}

	function idcheck(){
		var x=document.form.id;

		if (x.value==""){
			alert("���̵� �Է��� �ּ���");
			x.focus();
			return;
		}
		else{
			if (!is_range(x.value, 4, 10)) {
				alert("���̵�� 4~10�ڸ��� �Է��� �ֽʽÿ�.");
				x.focus();
				return;
			}
			else if ( !isUserid(x) ){
				alert("���̵�� ������ ���ڸ� ����Ͻ� �� �ֽ��ϴ�.");
				x.focus();
				return;
			}
		}
		
		document.form.submit();
	}
        
	 //-->
</script>
<html>
<head>
<title> �ݰ������   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
</head>

<body class="popmargin">

<!-- �˾������� : 450 * 337 -->
<table cellspacing="0" cellpadding="0" border="0" width="420">
<tr>
	<td>
			<!-- / Ÿ��Ʋ -->
			<table cellspacing="0" cellpadding="0" border="0" width="420" height="65" class="bg_dblue">
			<tr valign="top">
				<td width="296" class="tpad_20 lpad_20"><img src="<%=imageServer%>/tour_img/mem/pop_tit_idcheck.gif"></td>
				<td width="124" class="tpad_20"><img src="<%=imageServer%>/tour_img/mem/pop_logo.gif"></td>
			</tr>
			</table>
			<!-- Ÿ��Ʋ / -->
<form name="form" method="post" action="pop_check_id.jsp">
			<table cellspacing="0" cellpadding="0" border="0" width="420" height="65">
			<tr>
				<td height="114" align="center" class="tpad_10 bpad_10 lpad_15 rpad_15">
				<span class="txt_orange"><%=msg%>
				<%if (msg_btn !="N"){%>
				  <br><a href="javascript:returnid('<%=type%>')"><img src="<%=imageServer%>/tour_img/btn/btn_mem_iduse.gif" style="margin-top:22px;"></a><!-- ���̵� ��� -->
			    <%}%>
				</td>
			</tr>
			<tr><td height="1" class="line_g"></td></tr>
			<tr>
				<td height="43" align="center">
				<input type="text" name="id" value="<%=id%>" style="width:152px;">
				<a href="javascript:idcheck();"><img src="<%=imageServer%>/tour_img/btn/btn_s_idsamecheck.gif" hspace="5" align="absmiddle"></a><!-- ���̵��ߺ�Ȯ�� -->
				</td>
			</tr>
			<tr><td height="1" class="line_g"></td></tr>
			<tr>
				<td height="74" class="tpad_10 bpad_10 lpad_15 rpad_15"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_arw.gif" hspace="3" vspace="2" align="texttop">���̵�� ����, ���ڸ� �����Ͽ� 4~10�ڸ����� �����ϸ�, Ư����ȣ��<br>&nbsp;&nbsp;������ �Է��Ͻ� �� �����ϴ�.</td>
			</tr>
			</table>
</form>	
			<!-- �ϴܹ�  --><table cellspacing="0" cellpadding="0" border="0" width="100%" height="8" class="bg_dblue"><tr><td></td></tr></table>
	</td>
</tr>
</table>

</body>
</html>
