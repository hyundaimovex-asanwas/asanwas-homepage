<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �ۼ��� : �����
* �ۼ����� : 2005�� 12�� 08��
* ��� ���� : ������ ȸ��  �󼼺���
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

<script language="javascript">
<!--
	function doDel(idx){
		if (confirm("���� �Ͻðڽ��ϱ�?")) {
			location.href="/asanway/member/member_hr_action.jsp?cmd=D&idx="+idx ;
		}
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
          <td valign="top" bgcolor="FCFCF6">

          	<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr  style="padding: 15 0 0 20;">
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
              		<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor=D3D2C3>
              			<tr bgcolor=ffffff>
              				<td width=210 valign=top align=center height=250 >
              					<%if(read.get("IMG") == null || read.get("IMG").toString().equals("") || read.get("IMG").toString().equals("null") ){ } else {%>
              						<img src="/asanway/common/download.jsp?filename=<%= Utility.ko((String)read.get("IMG"))%>&dir=hrdb&sysfilename=<%= Utility.ko((String)read.get("SYSIMG"))%>" border="0" width="200" height="250">
              					<%}%>
              				</td>
              				<td align=center valign=top><br>
								<table width="98%" border="0" cellspacing="1" cellpadding="0" bgcolor=D3D2C3>
			              			<tr height=30>
			              				<td align=center width=100 bgcolor=DEDDCF>�� ��</td>
			              				<td colspan=3 bgcolor=FFFFFF> &nbsp;<%=(read.get("LNAME")==null)?"":Utility.ko((String)read.get("LNAME")) %> <%=(read.get("LNAME")==null)?"":Utility.ko((String)read.get("FNAME")) %> <%=(read.get("MNAME")==null)?"":Utility.ko((String) read.get("MNAME"))%></td>
			              			</tr>
			              			<tr height=30>
			              				<td align=center bgcolor=DEDDCF>�� �� </td>
			              				<td bgcolor=FFFFFF> &nbsp;<%=(read.get("COMPANY")==null)?"":Utility.ko((String)read.get("COMPANY"))%></td>
			              				<td align=center bgcolor=DEDDCF>�� �� </td>
			              				<td bgcolor=FFFFFF> &nbsp;<%=(read.get("POSITION")==null)?"":Utility.ko((String)read.get("POSITION"))%></td>
			              			</tr >
			              			<tr height=30>
			              				<td align=center bgcolor=DEDDCF>����ó</td>
			              				<td colspan=3 bgcolor=FFFFFF> &nbsp;<%=(read.get("ASSIGNMENT")==null)?"":Utility.ko((String)read.get("ASSIGNMENT"))%></td>
			              			</tr>
			              			<tr height=30>
			              				<td align=center bgcolor=DEDDCF>������� </td>
			              				<td colspan=3 bgcolor=FFFFFF> &nbsp;<%=(read.get("BIRTHDAY")==null)?"":Utility.ko((String)read.get("BIRTHDAY"))%></td>
			              			</tr>
			              		</table>
              				</td>
              			</tr>
              		</table>
              	</td>
              </tr>

              <tr  style="padding: 15 0 0 20;">
              	<td>
              		<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
              			<tr height=25 bgcolor=DEDDCF>
              				<td width = 100 align=center> �� �� </td>
              				<td>&nbsp;<%=(read.get("COUNTRY")==null)?"":countryList.get(read.get("COUNTRY"))%></td>
              			</tr>
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                         <tr height=25  bgcolor=DEDDCF>
              				<td width = 100 align=center> �� ��  </td>
              				<td>&nbsp;<%=(read.get("JOBGROUP")==null)?"":jobgroup.get(read.get("JOBGROUP"))%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                         <tr height=25>
              				<td width = 100 align=center> �����ּ� </td>
              				<td>&nbsp;[<%=(read.get("CZIP")==null)?"":read.get("CZIP").toString().substring(0,3)%> - <%=(read.get("CZIP")==null)?"":read.get("CZIP").toString().substring(3,6)%>] <%=(read.get("CADDR1")==null)?"":Utility.ko(read.get("CADDR1").toString() + " " + read.get("CADDR2").toString() )%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                        <tr height=25>
              				<td width = 100 align=center> ������ȭ </td>
              				<td>&nbsp;<%=(read.get("TEL1")==null)?"":read.get("TEL1")%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
						<!--
                         <tr height=25>
              				<td width = 100 align=center> �����ּ� </td>
              				<td>&nbsp;[<%=(read.get("HZIP")==null)?"":read.get("HZIP").toString().substring(0,3)%> - <%=(read.get("HZIP")==null)?"":read.get("HZIP").toString().substring(3,6)%>] <%=(read.get("HADDR1")==null)?"":Utility.ko(read.get("HADDR1").toString() + " " + read.get("HADDR2").toString() )%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
						-->
                         <tr height=25>
              				<td width = 100 align=center> ������ȭ </td>
              				<td>&nbsp;<%=(read.get("TEL2")==null)?"":read.get("TEL2")%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                         <tr height=25>
              				<td width = 100 align=center> Email </td>
              				<td>&nbsp;<%=(read.get("EMAIL")==null)?"":read.get("EMAIL")%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                         <tr height=25>
              				<td width = 100 align=center> �޴���  </td>
              				<td>&nbsp;<%=(read.get("MOBILE")==null)?"":read.get("MOBILE")%></td>
              			</tr>
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
              		</table>
					<br>

					<!-- �з� -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=3></td>
                         </tr>
              			<tr height=25  bgcolor=DEDDCF>
              				<td width = 100 align=center colspan=3> �� �� </td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=3></td>
                         </tr>
                         <tr height=25>
              				<td width = 100 align=center> ���г⵵  </td>
              				<td width = 100 align=center> �����⵵  </td>
              				<td width = 400 align=center> ����б� �� ����  </td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=3></td>
                         </tr>
						<% if ( scholarship.size() == 0 ) { %>
                          <tr>
                            <td height="25" align="center" colspan=3>��ϵ� �з�������  �����ϴ�.</td>
                          </tr>
                      	 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=3></td>
                         </tr>
	                    <% } else {
								for(int i = 0; i < scholarship.size(); i++) {
									HashMap hm = (HashMap)scholarship.get(i);
	                    %>
	                         <tr height=25>
	              				<td width = 100 align=center> <%=hm.get("SDATE")%>  </td>
	              				<td width = 100 align=center> <%=hm.get("EDATE")%>   </td>
	              				<td width = 400 align=center> <%=(hm.get("CONTENT")== null)?"":Utility.ko(hm.get("CONTENT").toString())%>   </td>
	              			</tr>
	              			 <tr>
	                            <td height="1" bgcolor="D3D2C3" colspan=3></td>
	                         </tr>
						<%
								}
							}
						%>

              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=3></td>
                         </tr>
              		</table>
              		<br>

              		<!--�Ż� ���� -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
              			<tr height=25  bgcolor=DEDDCF>
              				<td width = 100 align=center colspan=2>�Ż� ����  </td>
              			</tr>
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                         <tr height=25>
              				<td width = 100 align=center> �����  </td>
              				<td>&nbsp;<%=(read.get("BIRTHPLACE")==null)?"":Utility.ko(read.get("BIRTHPLACE").toString())%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                        <tr height=25>
              				<td width = 100 align=center> ���  </td>
              				<td>&nbsp;<%=(read.get("HOBBY")==null)?"":Utility.ko(read.get("HOBBY").toString())%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                         <tr height=25>
              				<td width = 100 align=center> ��/�ַ�  </td>
              				<td>&nbsp;<%=(read.get("SMOKING")==null)?"":Utility.ko(read.get("SMOKING").toString())%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                         <tr height=25>
              				<td width = 100 align=center> ����  </td>
              				<td>&nbsp;<%=(read.get("RELIGION")==null)?"":Utility.ko(read.get("RELIGION").toString())%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
                         <tr height=25>
              				<td width = 100 align=center> ������  </td>
              				<td>&nbsp;<%=(read.get("RLOODTYPE")==null)?"":Utility.ko(read.get("BLOODTYPE").toString())%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
                         <tr height=25>
              				<td width = 100 align=center> ��������   </td>
              				<td>&nbsp;<%=(read.get("FAMILY")==null)?"":Utility.ko(read.get("FAMILY").toString())%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

              			<tr height=25>
              				<td width = 100 align=center> ��Ÿ  </td>
              				<td>&nbsp;<%=(read.get("ETC")==null)?"":Utility.ko(read.get("ETC").toString())%></td>
              			</tr>
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
              		</table>
					<br>

              		<!-- �ֿ��� -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
              			<tr height=25  bgcolor=DEDDCF>
              				<td width = 100 align=center colspan=2> �ֿ��� </td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
                         <tr height=25>
              				<td width = 200 align=center> �� ��  </td>
              				<td width = 400 align=center> �ֿ���  </td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
						<% if ( career.size() == 0 ) { %>
                          <tr>
                            <td height="25" align="center" colspan=2>��ϵ� �ֿ��� ������  �����ϴ�.</td>
                          </tr>
                      	 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
	                    <% } else {
								for(int i = 0; i < career.size(); i++) {
									HashMap hm = (HashMap)career.get(i);
	                    %>
	                         <tr height=25>
	              				<td width = 100 align=center> <%=hm.get("SDATE")%> - <%=hm.get("EDATE")%>   </td>
	              				<td width = 400 align=center> <%=(hm.get("CONTENT")==null)?"":Utility.ko(hm.get("CONTENT").toString())%>   </td>
	              			</tr>
	              			 <tr>
	                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
	                         </tr>
						<%
								}
							}
						%>

              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=3></td>
                         </tr>
              		</table>
					<br>
              		<!-- ���˻���  -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=3></td>
                         </tr>
              			<tr height=25  bgcolor=DEDDCF>
              				<td width = 100 align=center colspan=3> ���˻��� </td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=3></td>
                         </tr>
                         <tr height=25>
              				<td width = 100 align=center> ����  </td>
              				<td width = 500 align=center> ���˳���   </td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
						<% if ( contact.size() == 0 ) { %>
                          <tr>
                            <td height="25" align="center" colspan=2>��ϵ� ���� ������  �����ϴ�.</td>
                          </tr>
                      	 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
	                    <% } else {
								for(int i = 0; i < contact.size(); i++) {
									HashMap hm = (HashMap)contact.get(i);
	                    %>
	                         <tr height=25>
	              				<td width = 100 align=center> <%=hm.get("SDATE")%>  </td>
	              				<td width = 400 align=center> <%=(hm.get("CONTENT")==null)?"":Utility.ko(hm.get("CONTENT").toString())%> </td>
	              			</tr>
	              			 <tr>
	                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
	                         </tr>
						<%
								}
							}
						%>

              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
              		</table>
					<br>

					<!--Ư�̻���  -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
              			<tr height=25  bgcolor=DEDDCF>
              				<td width = 100 align=center colspan=2>Ư�����   </td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                         <tr height=25>
              				<td width=10>&nbsp;</td>
              				<td><%=(read.get("MEMO")==null)?"":Utility.ko(read.get("MEMO").toString())%></td>
              			</tr>
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
					</table>
					<br>

					<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
              			<tr height=25  bgcolor=DEDDCF>
              				<td  colspan=2 > &nbsp; Update  :  <%=(read.get("LASTTIME")==null)?"":read.get("LASTTIME").toString().substring(0, 10) %></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
                         <tr>
                            <td height="10" colspan=2></td>
                         </tr>
                          <tr>
                            <td height="30" colspan=2 align=right>
                            	<a href="#"  onclick="window.open('member_hr_print.jsp?idx=<%=read.get("IDX")%>','','width=700,height=600,scrollbars=yes')"><img src="/img/scrap/btn_print.gif" align="absmiddle" border=0></a>
								<a href="member_hr_modify.jsp?idx=<%= read.get("IDX") %>"><img src="../img/bt_08.gif" width="40" height="20" border="0" align="absmiddle"></a>
                      			<a href="javascript:doDel('<%= read.get("IDX")  %>')"><img src="../img/bt_09.gif" width="40" height="20" hspace="3" border="0" align="absmiddle"></a>
                      			<a href="member_hr_list.jsp"><img src="../img/bt_10.gif" width="40" height="20" border="0" align="absmiddle"></a>
                            </td>
                         </tr>
					</table>
					<br>
					<br><br>
              	</td>
              </tr>
			</table>

           </td>
        </tr>
      </table
     </td>
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