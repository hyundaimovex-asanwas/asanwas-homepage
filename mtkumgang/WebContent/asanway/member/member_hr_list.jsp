<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �ۼ��� : �����
* �ۼ����� : 2005�� 12�� 06��
* ��� ���� : ������ ȸ��  ���
**
* �����ð�  : ������ : ��������
*
*
******************************************/
%>

<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.member.HrMemberBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	HrMemberBean bean = new HrMemberBean();
	bean.List(request, response);

	String totalMember = (String)request.getAttribute("totalMember");
%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="helper" class="com.hmm.asan.common.util.PagingHelper" scope="request" />

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
	String searchkey1 = request.getParameter("searchkey1");		//����
	if(searchkey1 == null) searchkey1 = "";

	String searchkey2 = request.getParameter("searchkey2");		//����
	if(searchkey2 == null) searchkey2 = "";

	String searchvalue= request.getParameter("searchvalue");	//�̸�
	if(searchvalue == null) searchvalue = "";
	%>

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
	 	function CheckAll(){
	 	  <% if( list.size() == 1 ) {  %>
				var cbox = document.delAll.chk;
		   		var val;

				if(document.delAll.chk.checked) {val = false;} else {val = true;}
				document.delAll.chk.checked = val;

		    <%}else if(list.size() > 1 ){%>
				var cbox = document.delAll.chk;
		   		var val;

				if(document.delAll.chk[0].checked) {val = false;} else {val = true;}
		        for(var i = 0; i < cbox.length; i++) {
	    	        document.delAll.chk[i].checked = val;
	        	}

		    <%}%>
		}
	   //-->
   </script>
</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">
<jsp:include page="/asanway/common/top.jsp" flush="true" />

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="25" bgcolor="E4E3C3"><jsp:include page="/asanway/common/topbutton.jsp" flush="true" /></td>
  </tr>
  <tr>
    <td valign="top"><table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" ><table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top" bgcolor="FCFCF6"><jsp:include page="/asanway/common/member_leftmenu.jsp" flush="true" /></td>
                <td width="2"></td>
              </tr>
            </table>
          </td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
			   	    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>������ȸ��</b></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                           <form name="search" method="get" action="member_hr_list.jsp">
	                          <tr>
	                            <td>
	                             	<table width="100%"  border="0" cellpadding="0" cellspacing="0">
	                                <tr>
	                                  <td height="40" align="right"  style="padding-right:15;">
	                                  	����
		                                <select name="searchkey1"  style="width:80px;height:20px" >
	                                      	<option value="" >==��ü==</option>
		                                    <%for ( int i = 1 ; i < countryList.size(); i++) {%>
													<option value=<%=i%> <%if(searchkey1.equals(Integer.toString(i))){%> selected <%}%>><%=countryList.get(Integer.toString(i))%></option>
											<%}%>
	                                    </select>
										����
	                                    <select name="searchkey2"  style="width:80px;height:20px" >
	                                    	 <option value="" >==��ü==</option>
		                                     <%for ( int i = 1 ; i < jobgroup.size(); i++) {%>
													<option value=<%=i%> <%if(searchkey2.equals(Integer.toString(i))){%> selected <%}%>><%= jobgroup.get(Integer.toString(i))%></option>
											 <%}%>
	                                    </select>

	                                     <input type="text" name="searchvalue" style="width:240px;height:20px" value='<%= searchvalue %>'>
										 <a href="javascript:search.submit()"><img src="../img/bt_04.gif" border="0" align="absmiddle"></a>
	                                  </td>
	                                </tr>
	                              </table>
	                            </td>
	                          </tr>
	                       </form>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td height="5"></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                          <td height="1" bgcolor="D3D2C3" colspan=13></td>
                          </tr>
                          <tr>
                            <td height="6"></td>
                            <td bgcolor="C4C3BA" width="1"></td>
                            <td height="6"></td>
                            <td bgcolor="C4C3BA" width="1"></td>
                            <td></td>
                            <td bgcolor="C4C3BA"  width="1"></td>
                            <td></td>
                            <td bgcolor="C4C3BA"  width="1"></td>
                            <td></td>
                            <td bgcolor="C4C3BA"  width="1"></td>
                            <td></td>
                            <td bgcolor="C4C3BA"  width="1"></td>
                            <td></td>
                          </tr>

                          <tr>
                            <td height="24" align="center" width=40>����</td>
                            <td></td>
                            <td width="100" height="24" align="center">�̸�</td>
                            <td></td>
                            <td align="center" width=100>����</td>
                            <td></td>
                            <td width="130" align="center">�����</td>
                            <td></td>
                            <td width="100" align="center">����</td>
                            <td></td>
                            <td width="100" align="center">���� </td>
                            <td></td>
                            <td width="80" align="center">����� </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=13></td>
                          </tr>

						<form name="delAll" method="post" action="member_hr_action.jsp?cmd=DA">
						<% if ( list.size() == 0 ) { %>
                          <tr>
                            <td height="25" align="center" colspan=13>��ϵ� ������ ȸ���� �����ϴ�.</td>
                          </tr>
	                    <% } else {
								int num = count - (int)helper.getPagesize()*(currentP-1);

								for(int i = 0; i < list.size(); i++) {
									HashMap hm = (HashMap)list.get(i);
	                    %>
	                          <tr>
	                            <td height="24" align="center"><input type=checkbox name="chk" value="<%=hm.get("IDX") %>"></td>
	                            <td></td>
	                            <td width="70" height="24" align="center"><a href="member_hr_read.jsp?idx=<%= hm.get("IDX") %>"><%=(hm.get("LNAME")==null)?"":Utility.ko((String)hm.get("LNAME")) %> <%=(hm.get("LNAME")==null)?"":Utility.ko((String)hm.get("FNAME")) %> <%=(hm.get("MNAME")==null)?"":Utility.ko((String) hm.get("MNAME"))%></a></td>
	                            <td></td>
	                            <td width="100" align="center"><%=jobgroup.get(hm.get("JOBGROUP"))%></td>
	                            <td></td>
	                            <td width="100" align="center"><%=Utility.ko((String)hm.get("COMPANY"))%></td>
	                            <td></td>
	                            <td width="100" align="center"><%=Utility.ko((String)hm.get("POSITION"))%></td>
	                            <td></td>
	                            <td width="100" align="center"><%=countryList.get(hm.get("COUNTRY"))%></td>
	                            <td></td>
	                            <td width="100" align="center"><%= hm.get("REGTIME").toString().substring(0, 10) %></td>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3" colspan=13></td>
	                          </tr>
						<%
								}
							}
						%>

                          <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=13></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td height="50" align="center" width=100%>
                      	<!-- --------------------------- ������ ----------------------- -->
						<Table border="0" cellspacing="0" cellpadding="0" align="center" width=100%>
							<tr>
								<td width=120 align=left>
									<a href="javascript:CheckAll();"><img src=../img/btn_select_all.gif border=0 align=absmiddle></a>
									<input type=image src="../img/bt_09.gif" border=0 align=absmiddle>
								</td>
								<td width=600>
									<Table border="0" cellspacing="0" cellpadding="0" align="center" >
										<tr>
											<td>
											<%if(helper.getBeforegroup() > 0){%>
												<a href="/asanway/member/member_hr_list.jsp?page=<%=helper.getBeforegroup()%>"><img src="../img/bt_05.gif" width="36" height="11" hspace="8" border=0></a>
											<% } else { %>
												<img src="../img/bt_05.gif" width="36" height="11" hspace="8">
											<% } %>
											</td>
											<td>
												<%
												  for(int i = startP; i <= endP; i++){
													if(i > totalP) break;
														if(i == currentP){
												%>
													<b><font color="#CE261D"><%= i %></font></b>&nbsp;
													<%  } else { %>
													<a href="/asanway/member/member_hr_list.jsp?page=<%= i %>"><%= i %></a>&nbsp;
													<%  }
												  } %>
												<% if(totalP  == 0) { %>1<% } %>
											</td>
											<td>
												<%if(helper.getAftergroup() > 0){%>
													<a href="/asanway/member/member_hr_list.jsp?page=<%=helper.getAftergroup()%>"><img src="../img/bt_05.gif" width="36" height="11" hspace="8" border=0></a>
												<% } else { %>
													<img src="../img/bt_05.gif" width="36" height="11" hspace="8">
												<% } %>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<!-- --------------------------- ������ ----------------------- -->
                      </td>
                    </tr>
                    </form>

                    <tr>
                      <td height="1" bgcolor="D3D2C3"></td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;">
                      	<a href="member_hr_write.jsp"><img src="../img/bt_24.gif" width="59" height="20" border="0" align=absmiddle></a>
                      	<a href="member_hr_excel.jsp"><img src=../img/btn_down_excel.gif border=0 align=absmiddle></a>
                      </td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
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
<iframe id='uframe' name='uframe' src='about:blank' width=0 height=0 frameborder=0 border=0></iframe>
</body>
</html>
