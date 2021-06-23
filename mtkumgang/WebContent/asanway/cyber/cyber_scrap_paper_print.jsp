<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>
<%
/****************************************
*
* �ۼ��� : �����
* �ۼ����� : 2005�� 11�� 16��
* ��� ���� : ��ũ�� ������  (�Ź�)
**
* �����ð�  : ������ : ��������
*
*
******************************************/
%>


<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.cyber.ScrapBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	String menutitle = "�Ź����  ��ũ��";
	String downfolder = "scrappaper";
	String category = "scrappaper";
%>

<%
	ScrapBean bean = new ScrapBean(category);
	bean.List(request, response);
%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="helper" class="com.hmm.asan.common.util.PagingHelper" scope="request" />
<jsp:useBean id="filelist" class="java.util.ArrayList" scope="request" />

<%
	//����¡ �ϱ� ���� ���� �����Ѵ�.
	int currentP = helper.getCurpage();
	int count = helper.getTotalcount();
	int totalP = helper.getTotalpage();

	int currentG = (int)((currentP-1)/helper.getGroupsize()) + 1;

	int startP = (int)((currentG-1)*helper.getGroupsize()) + 1;
	int endP = (int)(currentG*helper.getGroupsize());
%>

<%
	// �˻�

	String pubdate = request.getParameter("pubdate");
	if(pubdate == null) {
		pubdate = Utility.getCurrentDate();
	}

	String predate = Utility.getYesterday(pubdate);
	String nextdate = Utility.getTomorrow(pubdate);

	String section1 = request.getParameter("section1");
	if(section1 == null) section1 = "";

	String section2 = request.getParameter("section2");
	if(section2 == null) section2 = "";

	//���� ��
	HashMap section1hm = new HashMap();
		section1hm.put("1","������ñ��");
		section1hm.put("2","�ѹݵ����ñ��");
		section1hm.put("3","��Ÿ���");

	HashMap section2hm = new HashMap();
		section2hm.put("1","����");
		section2hm.put("2","������");
		section2hm.put("3","����");
%>

<%@ include file="/common/logincheck.jsp" %>
<%@ include file="/common/staffcheck.jsp" %>



					<table border="0" cellpadding="0" cellspacing="0" height="10"><tr><td></td></tr></table><!-- �ǾƷ� ����-->

					<!-----������ ----->
					<!-----������ ----->
				  <!--������ / ���� / ����  ī�װ� ���� (section2)-->
				  <%if (section2 != null &&  !section2.equals("")){%>
					  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
							  <tr>
								<td style="padding: 7 5 3 5;">
									<b>���� ���� ��ũ��(<%=pubdate%>_<%=section2hm.get(section2.toString())%>)<b>
								 </td>
							  </tr>
							</table>
							<%for (int k=1; k < 4 ; k++){ %>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								  <tr>
									<td bgcolor="DEDDCF" style="padding: 7 5 3 5;">
									  <table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
										  <td style="left-padding: 10 0 0 0;"><%=k%>. <%=section1hm.get(Integer.toString(k))%></td>
										</tr>
									  </table></td>
								  </tr>
								</table>
								 <table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
								  <td height="1" bgcolor="D3D2C3"></td>
								  <td bgcolor="D3D2C3"></td>
								  <td bgcolor="D3D2C3"></td>
								</tr>
								<% if ( list.size() == 0 ) { %>
								<% } else {
											int num = count - (int)helper.getPagesize()*(currentP-1);
									    	for ( int i = 0 ; i < list.size(); i++) {
									    	    HashMap hm = (HashMap)list.get(i);
									    	    if(hm.get("SECTION2").toString().equals(section2.toString()) && hm.get("SECTION1").toString().equals(Integer.toString(k))){
								%>
									<tr>
									  <td height="25"></td>
										<td style="padding:8 5 3 5;" valign="top"  width="5">
										  <img src="/img/common/bl02.gif" align="absmiddle">
										</td>
										<td style="padding:8 10 3 0;">
											<a href="#" onclick="window.open('/scrap/pop_paper.jsp?idx=<%= hm.get("IDX") %>','','width=950,height=760,scrollbars=yes')"><%= Utility.ko((String)hm.get("CONTENT")) %></a>
										</td>
									</tr>
									<tr>
									  <td height="1" bgcolor="D3D2C3" colspan=3></td>
									</tr>
								<% }	} }%>
							  </table>
							  <table border="0" cellpadding="0" cellspacing="0" height="10"><tr><td></td></tr></table><!--����-->
						  <%}%>

				  <!--��� / �ѹݵ� / ��Ÿ ���   ī�װ� ���� (section1) -->
				  <%}else if (section1 != null &&  !section1.equals("")) { %>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
							  <tr>
								<td style="padding: 7 5 3 5;">
									<b>���� ���� ��ũ��(<%=pubdate%>_<%=section1hm.get(section1)%>)<b>
								 </td>
							  </tr>
							</table>
							<%for (int l=1; l < 4 ; l++){ %>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								  <tr>
									<td bgcolor="DEDDCF" style="padding: 7 5 3 5;">
									  <table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
										  <td style="left-padding: 10 0 0 0;"><%=l%>. <%=section2hm.get(Integer.toString(l))%></td>
										</tr>
									  </table></td>
								  </tr>
								</table>
								 <table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
								  <td height="1" bgcolor="D3D2C3"></td>
								  <td bgcolor="D3D2C3"></td>
								  <td bgcolor="D3D2C3"></td>
								</tr>
								<% if ( list.size() == 0 ) { %>
								<% } else {
											int num = count - (int)helper.getPagesize()*(currentP-1);
									    	for ( int i = 0 ; i < list.size(); i++) {
									    	    HashMap hm = (HashMap)list.get(i);
									    	    if(hm.get("SECTION2").toString().equals(Integer.toString(l)) && hm.get("SECTION1").toString().equals(section1)){
								%>
									<tr>
									  <td height="25"></td>
										<td style="padding:8 5 3 5;" valign="top"  width="5">
										  <img src="/img/common/bl02.gif" align="absmiddle">
										</td>
										<td style="padding:8 10 3 0;">
											<a href="#" onclick="window.open('/scrap/pop_paper.jsp?idx=<%= hm.get("IDX") %>','','width=950,height=760,scrollbars=yes')"><%= Utility.ko((String)hm.get("CONTENT")) %></a>
										</td>
									</tr>
									<tr>
									  <td height="1" bgcolor="D3D2C3" colspan=3></td>
									</tr>
								<% }	} }%>
							  </table>
							  <table border="0" cellpadding="0" cellspacing="0" height="10"><tr><td></td></tr></table><!--����-->
						  <%}%>

				  <!-----��ü���---->
				  <%}else{ %>
						 <%for (int k=1; k < 4 ; k++){ %>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
							  <tr>
								<td style="padding: 7 5 3 5;">
									<b>[<%=pubdate%>]&nbsp;&nbsp; <%=section2hm.get(Integer.toString(k))%><b>
								 </td>
							  </tr>
							</table>
							<%for (int l=1; l < 4 ; l++){ %>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								  <tr>
									<td bgcolor="DEDDCF" style="padding: 7 5 3 5;">
									  <table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
										  <td style="left-padding: 10 0 0 0;"><%=l%>. <%=section1hm.get(Integer.toString(l))%></td>
										</tr>
									  </table></td>
								  </tr>
								</table>
								 <table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
								  <td height="1" bgcolor="D3D2C3"></td>
								  <td bgcolor="D3D2C3"></td>
								  <td bgcolor="D3D2C3"></td>
								</tr>
								<% if ( list.size() == 0 ) { %>
								<% } else {
											int num = count - (int)helper.getPagesize()*(currentP-1);
									    	for ( int i = 0 ; i < list.size(); i++) {
									    	    HashMap hm = (HashMap)list.get(i);
									    	    if(hm.get("SECTION1").toString().equals(Integer.toString(l)) && hm.get("SECTION2").toString().equals(Integer.toString(k))){
								%>
									<tr>
									  <td height="25"></td>
										<td style="padding:8 5 3 5;" valign="top"  width="5">
										  <img src="/img/common/bl02.gif" align="absmiddle">
										</td>
										<td style="padding:8 10 3 0;">
											<a href="#" onclick="window.open('/scrap/pop_paper.jsp?idx=<%= hm.get("IDX") %>','','width=950,height=760,scrollbars=yes')"><%= Utility.ko((String)hm.get("CONTENT")) %></a>
										</td>
									</tr>
									<tr>
									  <td height="1" bgcolor="D3D2C3" colspan=3></td>
									</tr>
								<% }	} }%>
							  </table>
							  <table border="0" cellpadding="0" cellspacing="0" height="10"><tr><td></td></tr></table><!--����-->
						  <%}%>
						<table border="0" cellpadding="0" cellspacing="0" height="10"><tr><td></td></tr></table><!--����-->
					  <%}%>
				  <%}%>

				  <table border="0" cellpadding="0" cellspacing="0" height="10"><tr><td></td></tr></table><!--����-->


<script javascript>
	print();
</script>

