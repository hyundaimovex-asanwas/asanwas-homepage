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
<%@ include file="/common/properties.jsp" %>
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
//out.print(ziplist.size());

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
<script language="JavaScript" src="<%=imageServer%>/tour_common/checkform.js"></script>
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
		var tmp2 = zipcode.substring(3,7);

		var fname1,fname2,fname3,fname4;

		if (type == "mem") {
			fname1 = x.zip1;
			fname2 = x.zip2;
			fname3 = x.addr1;
			fname4 = x.addr2;
			x.area.value = area;
		}
		else if (type == "reservation") {
			fname1 = x.zip_cd1;
			fname2 = x.zip_cd2;
			fname3 = x.address1;
			fname4 = x.address2;
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
<html>
<head>
<title> �ݰ������   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
</head>

<body class="popmargin">

<!-- �˾������� : 450 * 460 -->
<table cellspacing="0" cellpadding="0" border="0" width="420">
<tr>
	<td>
			<!-- / Ÿ��Ʋ -->
			<table cellspacing="0" cellpadding="0" border="0" width="420" height="65" class="bg_dblue">
			<tr valign="top">
				<td width="296" class="tpad_20 lpad_20"><img src="<%=imageServer%>/tour_img/mem/pop_tit_postcheck.gif"></td>
				<td width="124" class="tpad_20"><img src="<%=imageServer%>/tour_img/mem/pop_logo.gif"></td>
			</tr>
			</table>
			<!-- Ÿ��Ʋ / -->
<form name=form method=post action="pop_search_zip.jsp">
    <input type = hidden name=type value="<%=type%>">			
			<table cellspacing="0" cellpadding="0" border="0" width="420" height="65">
			<tr>
				<td height="72" class="tpad_10 bpad_10 lpad_15 rpad_15"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_arw.gif" hspace="3" vspace="2" align="texttop">�˻��� �ּ��� ���̳� ��/���� �̸��� ��ĭ ����  �Է��ϼ���.<br>&nbsp;&nbsp;(��) ����2��, ���ǵ���, �����</td>
			</tr>
			<tr><td height="1" class="line_g"></td></tr>
			<tr>
				<td height="43" align="center">
				<input type="text" name="dong" style="width:152px;" value="<%=dong%>">
				<input type=image src="<%=imageServer%>/tour_img/btn/btn_s_search.gif" width="54" height="18" align="absmiddle" border=0>
				</td>
			</tr>
			<tr><td height="1" class="line_g"></td></tr>
			<%if(dong == null || dong.equals("")){ %>
			<tr><td height="210"></td></tr>
			<tr>
				<td height="30" valign="top" align="center"><a href="javascript:;" onclick="window.close();"><img src="<%=imageServer%>/tour_img/btn/btn_pop_close.gif"></a><!-- â�ݱ� --></td>
			</tr>
			<%}%>
			</table>
</form>

<!-- ���-->
<%if(dong != null && !dong.equals("")){ %>
<div id=scroll style="width: 390; height: 180; overflow: auto">
<table border="0" cellpadding="0" cellspacing="0" width="100%">

	<col width="60"></col>
	<col width=""></col>
	<% if ( ziplist.size() == 0 )  { %>
		<tr height="18">
			<td colspan=2 align=center>�˻��� ������ �����ϴ�.</td>
		</tr>
	<% } else {
			for( int i = 0; i < ziplist.size(); i++) {
				HashMap hm = (HashMap)ziplist.get(i);
				addrShow = Utility.ko((String)hm.get("ADDRESS1")).trim()+ " " + Utility.ko((String)hm.get("ADDRESS2")).trim()+ " " + Utility.ko((String)hm.get("ADDRESS3")).trim() + " " + Utility.ko((String)hm.get("POST_BOX")).trim();
				addr = Utility.ko((String)hm.get("ADDRESS1")).trim()+ " " + Utility.ko((String)hm.get("ADDRESS2")).trim()+ " " + Utility.ko((String)hm.get("ADDRESS3")).trim() + " " + Utility.ko((String)hm.get("POST_BOX")).trim();
				for( int j = 1; j < areahm.size(); j++) {
						if(areahm.get(Integer.toString(j)).toString().trim().equals(Utility.ko(hm.get("ADDRESS1").toString()).trim())){
						area = Integer.toString(j);
					}
				}
	%>
		<tr height="18">
			<td><a href="javascript:zipreturn('<%=hm.get("ZIP_CD").toString().trim()%>','<%=addr%>','<%=area%>','<%=type%>');"><%=hm.get("ZIP_CD")%></a></td>
			<td><a href="javascript:zipreturn('<%=hm.get("ZIP_CD").toString().trim()%>','<%=addr%>','<%=area%>','<%=type%>');"><%=addrShow%></a></td>
		</tr>
<%}}%>
</table>
</div>
			
<%}%>
<!-- ���-->
    <br>
	<!-- �ϴܹ�  --><table cellspacing="0" cellpadding="0" border="0" width="100%" height="8" class="bg_dblue"><tr><td></td></tr></table>
	</td>
</tr>
</table>

</body>
</html>
