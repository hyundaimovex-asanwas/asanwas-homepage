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
<%@ page import="com.hmm.asan.www.member.MemberBean" %>

<%
	String msg = "";
	String type = "";
	String id = request.getParameter("id");
	if(id == null) id = "";

	MemberBean bean = new MemberBean();
	int result = bean.IdCheck(request, response); //Ż�� ȸ�����̵� �� ������

	if (result == 0 ){	//��밡��
		type = "0";
		msg = "�Է��Ͻ� ���̵�(<b class=red>"+id+"</b>)�� ����Ͻ� �� �ֽ��ϴ�.<br>Ȯ�� ��ư�� �����ּ���.";
	}else{					//�̹� �������
		type = "1";
		msg = "�Է��Ͻ� ���̵�(<b class=red>"+id+"</b>)�� �̹� ������� ���̵��Դϴ�.<br>�ٽ� �˻��� �ֽʽÿ�.";
	}

%>
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
			alert("ID�� �Է��� �ּ���");
			x.focus();
			return;
		}
		else{
			if (!is_range(x.value, 4, 10)) {
				alert("ID�� 4~10�ڸ��� �Է��� �ֽʽÿ�.");
				x.focus();
				return;
			}
			else if ( !isUserid(x) ){
				alert("ID�� ������ ���ڸ� ����Ͻ� �� �ֽ��ϴ�.");
				x.focus();
				return;
			}
		}
	}

	 //-->
</script>
<BODY topmargin="10" leftmargin="10">
<!----- Title----->
<table border="0" cellpadding="0" cellspacing="0" width="430" bgcolor="#234790">
<tr>
	<td><img src="/img/member/pop_tit_01.gif"></td>
	<td width="75" align="right"><img src="/img/common/pop_logo.gif"></td>
</tr>
</table>
<!----- Title----->
<table border="0" cellpadding="0" cellspacing="0" width="430" height="10"><tr><td></td></tr></table>

<!----- Box----->
<table border="0" cellpadding="0" cellspacing="0" width="430" height="150">
<tr><td height="15"></td></tr>
<tr>
	<td align="center">
		<!----- Contents----->
		<table border="0" cellpadding="0" cellspacing="0" width="390">
		<form name="form" method=post action="pop_check_id.jsp">
			<tr>
				<td align="center">
					<input type=text name=id value="<%=id%>"> &nbsp;
					<a href="javascript:idcheck();"><img src="/img/common/btn_search.gif" align=absmiddle></a>
				</td>
			</tr>
			<tr>
				<td align="center"><%=msg%></td>
			</tr>
		</form>
		</table>

		<!-- Button-->
		<table border="0" cellpadding="0" cellspacing="0" width="390">
		<tr><td height="30"></td></tr>
		<tr>
			<td align="center">
				<a href="javascript:returnid('<%=type%>')"><img src="/img/common/btn_apply2.gif"></a>
			</td>
		</tr>
		</table>
		<!-- //Button-->

		<!----- //Contents----->
	</td>
</tr>
<tr><td height="25"></td></tr>
</table>
<!----- //Box----->

<!----- CopyRight----->
<table border="0" cellpadding="0" cellspacing="0" width="430">
<tr><td height="1" bgcolor="#CCCCCC"></td></tr>
<tr height="35">
	<td align="right" style="padding-right:15"><img src="/img/common/pop_copyright2.gif"></td>
</tr>
</table>
<!----- CopyRight----->

</BODY>
</HTML>
