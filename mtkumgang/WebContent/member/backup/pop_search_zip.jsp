<%--
  - �ۼ���: ������
  - �ۼ� ����: 2006.06.01
  - ���� ������ : ������
  - ���� ������ : 2006.06.01
  - ���۱� ǥ��: IMJ Korea
  - ����: �����ȣ ã��
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hmm.asan.www.member.MemberBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	String dong = request.getParameter("dong");
	if(dong == null) dong = "";
	String type = request.getParameter("type");
	if(type == null) type = "";

	ArrayList ziplist = null;
	String addr = "";
	String addrShow = "";
	String area = "";

	if(dong != null && !dong.equals("")){
		MemberBean bean = new MemberBean();
		bean.ZipSearch(request, response);
		ziplist = (ArrayList) request.getAttribute("list");
	}


	//�����ڵ�
	HashMap areahm = new HashMap();
		areahm.put("1","����");
		areahm.put("2","�λ�");
		areahm.put("3","�뱸");
		areahm.put("4","��õ");
		areahm.put("5","����");
		areahm.put("6","����");
		areahm.put("7","���");
		areahm.put("8","���");
		areahm.put("9","����");
		areahm.put("10","���");
		areahm.put("11","�泲");
		areahm.put("12","����");
		areahm.put("13","����");
		areahm.put("14","���");
		areahm.put("15","�泲");
		areahm.put("16","����");

%>

<script language="javascript">
	<!--
	function zip_inputcheck(x){
		if ( x.str_zip.value == ""  ){
			alert("������ �Է��Ͻʽÿ�");
			x.str_zip.focus();
			return;
		}
		x.submit();
	}

	function zipreturn(zipcode,addr,area,type) {
		var x=opener.document.form;
		var tmp1 = zipcode.substring(0,3);
		var tmp2 = zipcode.substring(4,7);

		var fname1,fname2,fname3,fname4;

		if (type == "mem") {
			fname1 = x.zip1;
			fname2 = x.zip2;
			fname3 = x.addr1;
			fname4 = x.addr2;
			x.area.value = area;
		}
		else if (type == "agent") {
			fname1 = x.agentzip1;
			fname2 = x.agentzip2;
			fname3 = x.agentaddr1;
			fname4 = x.agentaddr2;
		}

		else if (type == "czip") {
			fname1 = x.czip1;
			fname2 = x.czip2;
			fname3 = x.caddr1;
			fname4 = x.caddr2;
		}

		else if (type == "hzip") {
			fname1 = x.hzip1;
			fname2 = x.hzip2;
			fname3 = x.haddr1;
			fname4 = x.haddr2;
		}

		fname1.value = tmp1;
		fname2.value = tmp2;
		fname3.value = addr;

		fname4.focus();

		window.close();
	}
	-->
</script>
<BODY topmargin="10" leftmargin="10">
<!----- Title----->
<table border="0" cellpadding="0" cellspacing="0" width="430" bgcolor="#234790">
<tr>
	<td><img src="/img/member/pop_tit_02.gif"></td>
	<td width="75" align="right"><img src="/img/common/pop_logo.gif"></td>
</tr>
</table>
<!----- Title----->
<table border="0" cellpadding="0" cellspacing="0" width="430" height="10"><tr><td></td></tr></table>

<!----- Box----->
<table border="0" cellpadding="0" cellspacing="0" width="430" height="100">
<tr><td height="15"></td></tr>
<tr>
	<td align="center">
		<!----- Contents----->
		<!-- �ּ��Է�-->
		<table border="0" cellpadding="0" cellspacing="0" width="">
		<form name=form method=post action="pop_search_zip.jsp">
			<input type = hidden name=type value="<%=type%>">
			<tr>
				<td class="bbs">�Է��Ͻ� �ּ��� ��/��/�� �̸��� �Է��ϼ���.</td>
			</tr>
			<tr><td height="3"></td></tr>
			<tr>
				<td class="bbs">��) ȫ��4��</td>
			</tr>
			<tr><td height="10"></td></tr>
			<tr>
				<td>
					<INPUT TYPE="text" NAME="dong" style="width:175; height:18;" class="gray_input" value="<%=dong%>">
					<input type=image src="/img/common/btn_search.gif" align="absmiddle" border=0>
				</td>
			</tr>
		</form>
		<tr><td height="20"></td></tr>
		</table>
		<!-- //�ּ��Է�-->

		<table border="0" cellpadding="0" cellspacing="0" width="390">
		<tr>
			<td background="/img/common/bg_dot_01.gif" height="1"></td>
		</tr>
		<tr><td height="10"></td></tr>
		</table>

		<!-- ���-->
		<div id=scroll style="width: 390; height: 140; overflow: auto">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<%if(dong != null && !dong.equals("")){ %>
			<col width="60"></col>
			<col width=""></col>
			<% if ( ziplist.size() == 0 )  { %>
				<tr height="18">
					<td colspan=2 align=center>�˻��� ������ �����ϴ�.</td>
				</tr>
			<% } else {
					for( int i = 0; i < ziplist.size(); i++) {
						HashMap hm = (HashMap)ziplist.get(i);
						addrShow = Utility.ko((String)hm.get("TDIRDA1")).trim()+ " " + Utility.ko((String)hm.get("TDIRDA2")).trim()+ " " + Utility.ko((String)hm.get("TDIRDA3")).trim() + " " + Utility.ko((String)hm.get("TDIRDA4")).trim();
						addr = Utility.ko((String)hm.get("TDIRDA1")).trim()+ " " + Utility.ko((String)hm.get("TDIRDA2")).trim()+ " " + Utility.ko((String)hm.get("TDIRDA3")).trim();
						for( int j = 1; j < areahm.size(); j++) {
								if(areahm.get(Integer.toString(j)).toString().trim().equals(Utility.ko(hm.get("TDIRDA1").toString()).trim())){
								area = Integer.toString(j);
							}
						}
			%>
				<tr height="18">
					<td><a href="javascript:zipreturn('<%=hm.get("TDIRZIP").toString().trim()%>','<%=addr%>','<%=area%>','<%=type%>');"><%=hm.get("TDIRZIP")%></a></td>
					<td><a href="javascript:zipreturn('<%=hm.get("TDIRZIP").toString().trim()%>','<%=addr%>','<%=area%>','<%=type%>');"><%=addrShow%></a></td>
				</tr>
		<%}}}%>
		</table>
		</div>

		<!-- //���-->

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
