<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �� �� �� : Czar
* �ۼ����� : 05.11.14
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.support.QnaBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	
	QnaBean bean = new QnaBean();
	bean.List(request, response, category);
%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="helper" class="com.hmm.asan.common.util.PagingHelper" scope="request" />

<%
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "29";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("support_main.jsp?flag=1");
	}
%>
     	<jsp:include page="/asanway/common/topbutton.jsp" flush="true" />
	</td>
  </tr>
  <tr>
    <td valign="top"><table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" ><table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top" bgcolor="FCFCF6">
					<jsp:include page="left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>QNA ����Ʈ</b></td>
                    </tr>
                    <tr>
                      <td><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr>
                            <td>

                            <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                            <form name="search" method="get" action="list.jsp">
                            <input type="hidden" name="category" value="<%= category %>">
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
                            <td height="3" bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
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
                          </tr>
                          <tr>
                            <td width="60" height="24" align="center"><font color="433C2C">��ȣ</font></td>
                            <td></td>
                            <td align="center"><font color="433C2C">����</font></td>
                            <td></td>
                            <td width="100" align="center"><font color="433C2C">�ۼ���</font></td>
                            <td></td>
                            <td width="100" align="center">�����</td>
                            <td></td>
                            <td width="120" align="center"><font color="433C2C">��ȸ��</font></td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

					<% if ( list.size() == 0 ) { %>
                          <tr>
                            <td height="25" align="center" colspan="9">��ϵ� ���� �����ϴ�.
                          </tr>
                    <% } else {
						int num = count - (int)helper.getPagesize()*(currentP-1);

						for(int i = 0; i < list.size(); i++) {
							HashMap hm = (HashMap)list.get(i);
                    %>
                          <tr>
                            <td height="25" align="center"><%= num-- %></td>
                            <td></td>
                            <td style="padding-left:5;"><% if( !hm.get("LEVEL").toString().equals("0") ) {  %><img src="/asanway/img/bt_re.gif"><% } %> <a href="qna_read.jsp?category=<%= category %>&idx=<%= hm.get("IDX") %>"><%= (hm.get("TITLE") == null) ? "" : Utility.getStringcut( 25, Utility.ko((String)hm.get("TITLE")) ) %></a><% if( Utility.NewDay((String)hm.get("REGTIME")) ) {%> <img src="/asanway/img/bt_19.gif"><% } %></td>
                            <td></td>
                            <td align="center"><%= hm.get("LEVEL").toString().equals("0") ? Utility.ko( (String)hm.get("NAME") ) : "������" %></td>
                            <td></td>
                            <td align="center"><%= hm.get("REGTIME").toString().substring(0, 10) %></td>
                            <td></td>
                            <td align="center">

	                            <!--
                            	<select name="status" style="width:80px;height:20px" onChange="doUpdateStatus(<%= hm.get("IDX") %>, this.value)">
                                	<option value="0" <% if( hm.get("STATUS").equals("0") ) { %>selected <% } %> value="0">��ϴ��</option>
                                	<option value="1" <% if( hm.get("STATUS").equals("1") ) { %>selected <% } %> value="1">��ϵ�</option>
                              </select>                                                            
                               -->
                               <%= hm.get("HIT") %>
                               
                               </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

					<% } } %>

                          <tr>
                            <td height="2" bgcolor="D3D2C3"></td>
                            <td height="2" bgcolor="D3D2C3"></td>
                            <td height="2" bgcolor="D3D2C3"></td>
                            <td height="2" bgcolor="D3D2C3"></td>
                            <td height="2" bgcolor="D3D2C3"></td>
                            <td height="2" bgcolor="D3D2C3"></td>
                            <td height="2" bgcolor="D3D2C3"></td>
                            <td height="2" bgcolor="D3D2C3"></td>
                            <td height="2" bgcolor="D3D2C3"></td>
                          </tr>

                        </table>




                      </td>
                    </tr>
                    <tr>
                      <td height="50" align="center">

                      <!-- -------------------- ����¡ -----------------------
                      <table border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="right"><img src="../img/bt_05.gif" width="36" height="11" hspace="8"></td>
                            <td><b>1</b> . <a href="#">2 </a>. <a href="#">3 </a>.
                              <a href="#">4 </a>. <a href="#">5 </a>. <a href="#">6
                              </a>. <a href="#">7 </a>. <a href="#">8 </a>. <a href="#">9</a>
                              . <a href="#">10</a></td>
                            <td><img src="../img/bt_06.gif" width="36" height="11" hspace="8"></td>
                          </tr>
                        </table>
                      <!-- -------------------- ����¡ ----------------------->


					<!-- --------------------------- ������ ----------------------- -->
						<Table border="0" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td>
								<%if(helper.getBeforegroup() > 0){%>
									<a href="qna_list.jsp?category=<%= category %>&page=<%=helper.getBeforegroup()%>"><img src="../img/bt_05.gif" border=0 width="36" height="11" hspace="8"></a>
								<% } else { %>
									<img src="../img/bt_05.gif" border=0 width="36" height="11" hspace="8">
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
										<a href="qna_list.jsp?category=<%= category %>&page=<%= i %>"><%= i %></a>&nbsp;
										<%  }
									  } %>
									<% if(totalP  == 0) { %>1<% } %>
								</td>
								<td>
									<%if(helper.getAftergroup() > 0){%>
										<a href="qna_list.jsp?category=<%= category %>&page=<%=helper.getAftergroup()%>"><img src="../img/bt_06.gif" border=0 width="36" height="11" hspace="8"></a>
									<% } else { %>
										<img src="../img/bt_06.gif" border=0 width="36" height="11" hspace="8">
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
                      <td align="right"   style="padding-top:5;"></td>
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

<iframe id='uframe' name='uframe' src='about:blank' width=0 height=0 frameborder=0 border=0></iframe>
</body>
</html>