<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �� �� �� : �����
* �ۼ����� : 2005�� 10�� 20��
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
* 2005/11/12 : ����� : �亯�� �Խ������� ����
******************************************/
%>

<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.admin.NoticeBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	String category = "adminnotice";

	NoticeBean nb = new NoticeBean(category);
	nb.List(request, response);
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
	String searchkey = request.getParameter("searchkey");
	if(searchkey == null) searchkey = "";
	String searchvalue= request.getParameter("searchvalue");
	if(searchvalue == null) searchvalue = "";
%>

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">

<jsp:include page="/asanway/common/top.jsp" flush="true" />
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="25" bgcolor="E4E3C3">
    	<jsp:include page="/asanway/common/topbutton.jsp" flush="true" />
	</td>
  </tr>
  <tr>
    <td valign="top"><table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" ><table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top" bgcolor="FCFCF6">
					<jsp:include page="/asanway/common/admin_leftmenu.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>������Խ���</b></td>
                    </tr>
                    <tr>
                      <td><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr>
                            <td>

                            <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                            <form name="search" method="get" action="admin_notice.jsp">
                                <tr>
                                  <td height="40" align="right"  style="padding-right:15;">

	                                <select name="searchkey"  style="width:80px;height:20px">
                                      <option value="title" <% if( searchkey.equals("title") ) { %>selected<% } %> >����</option>
                                      <option value="content" <% if( searchkey.equals("content") ) { %>selected<% } %>>����</option>
                                    </select>

                                     <input type="text" name="searchvalue" style="width:240px;height:20px" value='<%= searchvalue %>'>
									 <a href="javascript:search.submit()"><img src="../img/bt_04.gif" border="0" align="absmiddle"></a>
                                  </td>
                                </tr>
                            </form>
                              </table>

							</td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td height="5"></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="3" bgcolor="D3D2C3" colspan=13></td>
                          </tr>
                          <tr>
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
                            <td bgcolor="C4C3BA"  width="1"></td>
                            <td></td>
                          </tr>
                          <tr>
                            <td height="24" align="center" width=40><font color="433C2C">��ȣ</font></td>
                            <td></td>
                            <td align="center" width=60>�̸�</td>
                            <td></td>
                            <td align="center" width=140>�̸���</td>
                            <td></td>
                            <td align="center">����</td>
                            <td></td>
                            <td align="center" width=60>÷������</td>
                            <td></td>
                            <td align="center" width=70>�����</td>
                            <td></td>
                            <td align="center" width=40>��ȸ</td>
                          </tr>
						  <tr>
                            <td height="3" bgcolor="D3D2C3" colspan=13></td>
                          </tr>

						<% if ( list.size() == 0 ) { %>
                          <tr>
                            <td height="25" align="center" colspan="13">��ϵ� ���� �����ϴ�. </td>
                          </tr>
						  <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=13></td>
                          </tr>
					<% } else {

						int num = count - (int)helper.getPagesize()*(currentP-1);


					    	for ( int i = 0 ; i < list.size(); i++) {
					    	    HashMap hm = (HashMap)list.get(i);

					%>
							<tr>
                            <td height="25" align="center"><%= num-- %></td>
                            <td></td>
                            <td style="padding-left:5;"><%=Utility.ko((String)hm.get("REGNAME"))%></td>
                            <td></td>
                            <td style="padding-left:5;"><%= hm.get("EMAIL") %></td>
                            <td></td>
                            <td style="padding-left:5;"><%=(hm.get("LEVEL").toString().equals("0"))? "" :Utility.replyHTML("/img/common/ico_re.gif",hm.get("LEVEL").toString())%><a href="admin_notice_read.jsp?idx=<%= hm.get("IDX") %>"><%= Utility.getStringcut( 25, Utility.ko((String)hm.get("TITLE")) ) %></a><% if( Utility.NewDay((String)hm.get("REGTIME")) ) {%> <img src="/asanway/img/bt_19.gif"><% } %></td>
                            <td></td>
                            <td align="center"><!--<img src="../img/bt_18.gif" width="16" height="16">-->
                            	<% if(filelist.size() == 0 )  {%>
	                            ����
	                            <% } else {
	                                for(int j = 0; j < filelist.size(); j++) {
	                                    HashMap file = (HashMap)filelist.get(j);
	                                if( hm.get("IDX").equals(file.get("BOARDIDX")) ) {
	                                %>
		                            <a href="/asanway/common/download.jsp?dir=bodo&filename=<%= Utility.ko( (String)file.get("FILE") ) %>&sysfilename=<%= file.get("SYSFILE") %>"><img src="/asanway/img/icon_file.gif" border="0"></a>
	                            <% } } } %>
                            </td>
                            <td></td>
                            <td align="center"><%= hm.get("REGTIME").toString().substring(0, 10) %></td>
                            <td></td>
                            <td align="center"><%= hm.get("HIT")%></td>
                          </tr>
                           <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=13></td>
                          </tr>
					<% }	}	%>

                           <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=13></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td height="50" align="center">
					<!-- --------------------------- ������ ----------------------- -->
						<Table border="0" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td>
								<%if(helper.getBeforegroup() > 0){%>
									<a href="/asanway/admin/admin_notice.jsp?page=<%=helper.getBeforegroup()%>"><img src="../img/bt_05.gif" width="36" height="11" hspace="8"></a>
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
										<a href="/asanway/admin/admin_notice.jsp?page=<%= i %>"><%= i %></a>&nbsp;
										<%  }
									  } %>
									<% if(totalP  == 0) { %>1<% } %>
								</td>

								<td>
									<%if(helper.getAftergroup() > 0){%>
										<a href="/asanway/admin/admin_notice.jsp.jsp?page=<%=helper.getAftergroup()%>"><img src="../img/bt_05.gif" width="36" height="11" hspace="8"></a>
									<% } else { %>
										<img src="../img/bt_05.gif" width="36" height="11" hspace="8">
									<% } %>
								</td>
							</tr>
						</table>
					<!-- --------------------------- ������ ----------------------- -->
                        </td>
                    </tr>
                    <tr>
                      <td height="1" bgcolor="D3D2C3"></td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;"><a href="admin_notice_write.jsp"><img src="../img/bt_07.gif" width="40" height="20" border="0"></a></td>
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
    <td height="30"  bgcolor="D4D4B2">
		<jsp:include page="/asanway/common/copyright.jsp" flush="true" />
    </td>
  </tr>
</table>

</body>
</html>
