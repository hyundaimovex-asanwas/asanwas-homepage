<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �ۼ��� : �����
* �ۼ����� : 2005�� 10�� 28��
* ��� ���� : ȸ�� �󼼺���
**
* �����ð�  : ������ : ��������
*
*
******************************************/
%>

<%@ page import="com.hmm.asan.asanway.member.HrMemberBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="java.util.HashMap" %>

<%
	HrMemberBean bean = new HrMemberBean();
	bean.Read(request, response);
%>

<jsp:useBean id="read" class="java.util.HashMap" scope="request" />
<jsp:useBean id="scholarship" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="career" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="contact" class="java.util.ArrayList" scope="request" />

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ include file="/asanway/common/country_list.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("member_main.jsp?flag=1");
	}
%>
<style type="text/css">
	.tableline{border:#CCCCCC 1px solid}
	.tdline1{
		BORDER-BOTTOM: #CCCCCC 2px solid;
	    BORDER-TOP: #CCCCCC 2px solid;
	}
	.tdline2{
		BORDER-BOTTOM: #CCCCCC 2px solid;
	}
	.tdline3{
		BORDER-BOTTOM: #CCCCCC 1px solid;
		BORDER-RIGHT: #CCCCCC 1px solid;
	}
	.tdline4{
		BORDER-BOTTOM: #CCCCCC 1px solid;
	}
	.tdline5{
		BORDER-RIGHT: #CCCCCC 1px solid;
	}
	.tdline6{
		BORDER-TOP: #CCCCCC 1px solid;
	}
</style>
<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">

          	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
              <tr  style="padding: 15 15 15 15;">
              	<td>
              		<!-- ������ ������ �ι� ���� ǥ�� -->
              		<!----- Title----->
					<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#234790">
					<tr>
						<td><img src="../img/pop_tit_04.gif"></td>
						<td align="right"><img src="/img/common/pop_logo.gif"></td>
					</tr>
					</table><br>
					<!----- Title----->
              		<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="tableline">
              			<tr bgcolor=ffffff >
              				<td width=210 valign=top align=center height=250 class="tdline5">
              					<%if(read.get("IMG") == null || read.get("IMG").toString().equals("") || read.get("IMG").toString().equals("null") ){ } else {%>
              						<img src="/asanway/common/download.jsp?filename=<%= Utility.ko((String)read.get("IMG"))%>&dir=hrdb&sysfilename=<%= Utility.ko((String)read.get("SYSIMG"))%>" border="0" width="200" height="250">
              					<%}%>&nbsp;
              				</td>
              				<td align=center valign=top><br>
								<table width="98%" border="0" cellspacing="0" cellpadding="0"  class="tableline">
			              			<tr height=30>
			              				<td align=center width=100 bgcolor=DEDDCF  class="tdline3">�� ��</td>
			              				<td colspan=3 bgcolor=FFFFFF class="tdline4"> &nbsp;<%=(read.get("LNAME")==null)?"":Utility.ko((String)read.get("LNAME")) %> <%=(read.get("LNAME")==null)?"":Utility.ko((String)read.get("FNAME")) %> <%=(read.get("MNAME")==null)?"":Utility.ko((String) read.get("MNAME"))%></td>
			              			</tr>
			              			<tr height=30 class="tableline">
			              				<td align=center bgcolor=DEDDCF class="tdline3">�� �� </td>
			              				<td bgcolor=FFFFFF class="tdline3"> &nbsp;<%=(read.get("COMPANY")==null)?"":Utility.ko((String)read.get("COMPANY"))%></td>
			              				<td align=center bgcolor=DEDDCF class="tdline3">�� �� </td>
			              				<td bgcolor=FFFFFF class="tdline4"> &nbsp;<%=(read.get("POSITION")==null)?"":Utility.ko((String)read.get("POSITION"))%></td>
			              			</tr >
			              			<tr height=30 class="tableline">
			              				<td align=center bgcolor=DEDDCF class="tdline3">����ó</td>
			              				<td colspan=3 bgcolor=FFFFFF > &nbsp;<%=(read.get("ASSIGNMENT")==null)?"":Utility.ko((String)read.get("ASSIGNMENT"))%></td>
			              			</tr>
			              			<tr height=30 class="tableline">
			              				<td align=center bgcolor=DEDDCF class="tdline5">�������</td>
			              				<td colspan=3 bgcolor=FFFFFF > &nbsp;<%=(read.get("BIRTHDAY")==null)?"":Utility.ko((String)read.get("BIRTHDAY"))%></td>
			              			</tr>
			              		</table>
              				</td>
              			</tr>
              		</table>
              	</td>
              </tr>

              <tr  style="padding: 15 15 15 15;">
              	<td>
              		<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			<tr height=25 bgcolor=DEDDCF >
              				<td width = 100 align=center class="tdline1"> �� �� </td>
              				<td class="tdline1">&nbsp;<%=(read.get("COUNTRY")==null)?"":countryList.get(read.get("COUNTRY"))%></td>
              			</tr>
                         <tr height=25  bgcolor=DEDDCF >
              				<td width = 100 align=center class="tdline2"> �� ��  </td>
              				<td class="tdline2">&nbsp;<%=(read.get("JOBGROUP")==null)?"":jobgroup.get(read.get("JOBGROUP"))%></td>
              			</tr>
                         <tr height=25 >
              				<td width = 100 align=center class="tdline4"> �����ּ� </td>
              				<td class="tdline4">&nbsp;[<%=(read.get("CZIP")==null)?"":read.get("CZIP").toString().substring(0,3)%> - <%=(read.get("CZIP")==null)?"":read.get("CZIP").toString().substring(3,6)%>] <%=(read.get("CADDR1")==null)?"":Utility.ko(read.get("CADDR1").toString() + " " + read.get("CADDR2").toString() )%></td>
              			</tr>

                        <tr height=25 >
              				<td width = 100 align=center class="tdline4"> ������ȭ </td>
              				<td class="tdline4">&nbsp;<%=(read.get("TEL1")==null)?"":read.get("TEL1")%></td>
              			</tr>

                         <tr height=25 >
              				<td width = 100 align=center class="tdline4"> �����ּ� </td>
              				<td class="tdline4">&nbsp;[<%=(read.get("HZIP")==null)?"":read.get("HZIP").toString().substring(0,3)%> - <%=(read.get("HZIP")==null)?"":read.get("HZIP").toString().substring(3,6)%>] <%=(read.get("HADDR1")==null)?"":Utility.ko(read.get("HADDR1").toString() + " " + read.get("HADDR2").toString() )%></td>
              			</tr>

                         <tr height=25 >
              				<td width = 100 align=center class="tdline4"> ������ȭ </td>
              				<td class="tdline4">&nbsp;<%=(read.get("TEL2")==null)?"":read.get("TEL2")%></td>
              			</tr>

                         <tr height=25>
              				<td width = 100 align=center class="tdline4"> Email </td>
              				<td class="tdline4">&nbsp;<%=(read.get("EMAIL")==null)?"":read.get("EMAIL")%></td>
              			</tr>

                         <tr height=25>
              				<td width = 100 align=center class="tdline2"> �޴���  </td>
              				<td  class="tdline2">&nbsp;<%=(read.get("MOBILE")==null)?"":read.get("MOBILE")%></td>
              			</tr>

              		</table>
					<br>

					<!-- �з� -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			<tr height=25  bgcolor=DEDDCF>
              				<td width = 100 align=center colspan=3 class="tdline6"> �� �� </td>
              			</tr>
              			<tr height=25>
              				<td width = 100 align=center class="tdline4"> ���г⵵  </td>
              				<td width = 100 align=center class="tdline4"> �����⵵  </td>
              				<td width = 400 align=center class="tdline4"> ����б� �� ����  </td>
              			</tr>
              			<% if ( scholarship.size() == 0 ) { %>
                          <tr>
                            <td height="25" align="center" colspan=3 class="tdline4">��ϵ� �з�������  �����ϴ�.</td>
                          </tr>
                      	<% } else {
								for(int i = 0; i < scholarship.size(); i++) {
									HashMap hm = (HashMap)scholarship.get(i);
	                    %>
	                         <tr height=25>
	              				<td width = "100" align="center" class="tdline4"> <%=hm.get("SDATE")%>&nbsp;  </td>
	              				<td width = "100" align="center" class="tdline4"> <%=hm.get("EDATE")%> &nbsp;  </td>
	              				<td width = "400" align="center" class="tdline4"> <%=(hm.get("CONTENT")== null)?"":Utility.ko(hm.get("CONTENT").toString())%> &nbsp;  </td>
	              			</tr>
						<%
								}
							}
						%>
						<tr>
                            <td height="1" align="center" colspan="2" class="tdline4"></td>
                          </tr>
              		</table>
              		<br>

              		<!--�Ż� ���� -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			<tr height=25  bgcolor=DEDDCF>
              				<td width = 100 align=center colspan=2 class="tdline6">�Ż� ����  </td>
              			</tr>

                         <tr height=25>
              				<td width = 100 align=center class="tdline4"> �����  </td>
              				<td class="tdline4">&nbsp;<%=(read.get("BIRTHPLACE")==null)?"":Utility.ko(read.get("BIRTHPLACE").toString())%></td>
              			</tr>

                        <tr height=25>
              				<td width = 100 align=center class="tdline4"> ���  </td>
              				<td class="tdline4">&nbsp;<%=(read.get("HOBBY")==null)?"":Utility.ko(read.get("HOBBY").toString())%></td>
              			</tr>

                         <tr height=25>
              				<td width = 100 align=center class="tdline4"> ��/�ַ�  </td>
              				<td class="tdline4">&nbsp;<%=(read.get("SMOKING")==null)?"":Utility.ko(read.get("SMOKING").toString())%></td>
              			</tr>

                         <tr height=25>
              				<td width = 100 align=center class="tdline4"> ����  </td>
              				<td class="tdline4">&nbsp;<%=(read.get("RELIGION")==null)?"":Utility.ko(read.get("RELIGION").toString())%></td>
              			</tr>

              			<tr height=25>
              				<td width = 100 align=center class="tdline4"> ������  </td>
              				<td class="tdline4">&nbsp;<%=(read.get("RLOODTYPE")==null)?"":Utility.ko(read.get("BLOODTYPE").toString())%></td>
              			</tr>

                         <tr height=25>
              				<td width = 100 align=center class="tdline4"> ��������   </td>
              				<td class="tdline4">&nbsp;<%=(read.get("FAMILY")==null)?"":Utility.ko(read.get("FAMILY").toString())%></td>
              			</tr>

              			<tr height=25>
              				<td width = 100 align=center class="tdline2"> ��Ÿ  </td>
              				<td class="tdline2">&nbsp;<%=(read.get("ETC")==null)?"":Utility.ko(read.get("ETC").toString())%></td>
              			</tr>
              		</table>
					<br>

              		<!-- �ֿ��� -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			<tr height=25  bgcolor=DEDDCF>
              				<td width = 100 align=center colspan=2 class="tdline6"> �ֿ��� </td>
              			</tr>
              			<tr height=25>
              				<td width = 200 align=center class="tdline4"> �� ��  </td>
              				<td width = 400 align=center class="tdline4"> �ֿ���  </td>
              			</tr>
              			<% if ( career.size() == 0 ) { %>
                          <tr>
                            <td height="25" align="center" colspan=2 class="tdline4">��ϵ� �ֿ��� ������  �����ϴ�.</td>
                          </tr>
                        <% } else {
								for(int i = 0; i < career.size(); i++) {
									HashMap hm = (HashMap)career.get(i);
	                    %>
	                         <tr height=25>
	              				<td width = 100 align=center class="tdline4"> <%=hm.get("SDATE")%> - <%=hm.get("EDATE")%>   </td>
	              				<td width = 400 align=center class="tdline4"> <%=(hm.get("CONTENT")==null)?"":Utility.ko(hm.get("CONTENT").toString())%>   </td>
	              			</tr>
	              		<%
								}
							}
						%>
						 <tr>
                            <td height="1" align="center" colspan="2" class="tdline4"></td>
                          </tr>
              		</table>
					<br>
              		<!-- ���˻���  -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			<tr height=25  bgcolor=DEDDCF>
              				<td width = 100 align=center colspan=3 class="tdline6"> ���˻��� </td>
              			</tr>
              		    <tr height=25>
              				<td width = 100 align=center class="tdline4"> ����  </td>
              				<td width = 500 align=center class="tdline4"> ���˳���   </td>
              			</tr>
              			<% if ( contact.size() == 0 ) { %>
                          <tr>
                            <td height="25" align="center" colspan=2 class="tdline4">��ϵ� ���� ������  �����ϴ�.</td>
                          </tr>

	                    <% } else {
								for(int i = 0; i < contact.size(); i++) {
									HashMap hm = (HashMap)contact.get(i);
	                    %>
	                         <tr height=25>
	              				<td width = 100 align=center class="tdline4"> <%=hm.get("SDATE")%>  </td>
	              				<td width = 400 align=center class="tdline4"> <%=(hm.get("CONTENT")==null)?"":Utility.ko(hm.get("CONTENT").toString())%> </td>
	              			</tr>

						<%
								}
							}
						%>
						 <tr>
                            <td height="1" align="center" colspan="2" class="tdline4"></td>
                          </tr>
              		</table>
					<br>

					<!--Ư�̻���  -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			<tr height=25  bgcolor=DEDDCF>
              				<td width = 100 align=center colspan=2 class="tdline6">Ư�����   </td>
              			</tr>
                         <tr height=25>
              				<td width=10 class="tdline2">&nbsp;</td>
              				<td class="tdline2"><%=(read.get("MEMO")==null)?"":Utility.ko(read.get("MEMO").toString())%>&nbsp;</td>
              			</tr>
					</table>
					<br>

					<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			<tr height=25  bgcolor=DEDDCF>
              				<td  colspan=2 > &nbsp; Update  :  <%=(read.get("LASTTIME")==null)?"":read.get("LASTTIME").toString().substring(0, 10) %></td>
              			</tr>
					</table>
					<br>
					<br><br>
              	</td>
              </tr>
			</table>
</body>
</html>

<script language = javascript>
	//print();
</script>