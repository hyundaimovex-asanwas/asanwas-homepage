<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �ۼ��� : �����
* �ۼ����� : 2005�� 10�� 18��
* ��� ���� : ��� ����Ʈ
**
* �����ð�  : ������ : ��������
*
*
******************************************/
%>

<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	AuthBean ab = new AuthBean();
	ab.List(request, response);
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
	String searchkey = request.getParameter("searchkey");
	if(searchkey == null) searchkey = "";
	String searchvalue= request.getParameter("searchvalue");
	if(searchvalue == null) searchvalue = "";
%>

<html>
<head>
<%@include file="/asanway/common/head.jsp"%>

<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("admin_main.jsp?flag=1");
	}
%>
<script language="javascript">
	   <!--
	   		function openwin(idx) {
				if(idx){
					window.open("/asanway/admin/pop_modify.jsp?idx="+idx,"admin"," width=700, height=500, top=200, left=300, scrollbars=no");
				}
				else{
					window.open("/asanway/admin/pop_write.jsp","admin"," width=700, height=500, top=200, left=300, scrollbars=no");
				}
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
                      <td height="40" align="right"><a href="javascript:openwin();"><img src="../img/bt_22.gif" width="68" height="20" border="0"></a></td>
                    </tr>
                    <tr>
                      <td height="5"></td>
                    </tr>
                    <tr>
                      <td>
                       <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="3" bgcolor="D3D2C3" colspan=14></td>
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

						<form name=frm method=post>
                          <tr>
                            <td height="24" align="center" width=60>���̵�</td>
                            <td></td>
                            <td align="center" width=60>�̸�</td>
                            <td></td>
                            <td align="center" width=130>�̸���</td>
                            <td></td>
                         	<td align="center">�����</td>
                            <td></td>
                            <td align="center" width=60>�����</td>
                          </tr>

                          <tr>
                            <td height="1" bgcolor="D3D2C3"  colspan=9></td>
                          </tr>

						<% if ( list.size() == 0 ) { %>
							<tr>
                            	<td height="25" align="center"  colspan=9>��ϵ� ��ڰ� �����ϴ�.</td>
                          	</tr>
                        <% } else {
									int num = count - (int)helper.getPagesize()*(currentP-1);

									for(int i = 0; i < list.size(); i++) {
										HashMap hm = (HashMap)list.get(i);

		                %>
	                           <tr>
	                            <td height="25" align="center"><a href="javascript:openwin(<%=hm.get("IDX")%>);"><%=hm.get("ID")%></a></td>
	                            <td></td>
	                            <td style="padding-left:5;"><a href="javascript:openwin(<%=hm.get("IDX")%>)"><%=Utility.ko((String)hm.get("NAME"))%></a></td>
	                            <td></td>
	                            <td align="center"><%=hm.get("EMAIL")%></td>
	                            <td></td>
	                            <td align=center>
		                        	<%//���� ����Ʈ
		                        		ab.AuthList(request, response,(String)hm.get("IDX"));
		                        		ArrayList authlist = (ArrayList) request.getAttribute("authlist");

		                        		for(int j = 0; j < authlist.size(); j++) {
			                            	HashMap hmauth = (HashMap)authlist.get(j);
			                         		out.print(Utility.ko((String)hmauth.get("NAME")));
			                         		if(j != authlist.size()-1){out.print(",");}
										}
									%>
								</td>
	                            <td></td>
	                            <td align="center"><%=hm.get("REGTIME").toString().substring(0, 10)%></td>
	                          </tr>

	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"  colspan=9></td>
	                          </tr>
 						<%
								}
							}
						%>
						</form>

                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;"><a href="javascript:openwin();"><img src="../img/bt_22.gif" width="68" height="20" border="0"></a></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><b>*������ ��å*</b></td>
                          </tr>
                          <tr>
                            <td height="5"></td>
                          </tr>
                          <tr>
                            <td height="20">1. ������ڿ� ���۰����ڷ� ����</td>
                          </tr>
                          <tr>
                            <td height="20">2. ���۰����ڴ� �ʱ� setting</td>
                          </tr>
                          <tr>
                            <td height="20">3. ������ڰ� ����� ��� ����Ʈ�� ����ϴ�⡯ ���·� ��ϵǸ� ���۰����ڸ���
                              ����ϵʡ� ���·� ���� �� �� �ִ�.</td>
                          </tr>
                          <tr>
                            <td height="20">4. �����ڰ� ����� ��� ����Ʈ�� ������ �Ǹ����� ����ȴ�.(WEBSITE������
                              �������ڡ��� ��ϵȴ�.) </td>
                          </tr>
                          <tr>
                            <td height="20">5. ������Խ����� �̿��Ͽ� ������ ���� �ǰ��� �ְ� ���� �� �ֵ��� �Ѵ�.</td>
                          </tr>
                          <tr>
                            <td height="20">6. ��ϴ��� DB���� ��� ������ �ԷµǾ� ������ website�� ǥ������ �ʴ�
                              ���¸� ���Ѵ�.</td>
                          </tr>
                          <tr>
                            <td height="20">7. ��ϵ� �̶� ��ϴ�� ������ ����Ʈ�� website�� ǥ���� ���¸� ���Ѵ�.
                            </td>
                          </tr>
                        </table></td>
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
</body>
</html>
