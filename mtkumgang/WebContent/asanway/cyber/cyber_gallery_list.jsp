<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �� �� �� : ������
* �ۼ����� : 2005�� 10�� 13��
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>


<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.cyber.GalleryBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	String category = request.getParameter("category");
  	String menuidx = "";
	if(category.equals("gallery")){
		menuidx = "17";
	}else{
		menuidx = "22";
	}

	GalleryBean bean = new GalleryBean();
	bean.List(request, response);
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
	String section1 = request.getParameter("section1");
	if(section1 == null) section1 = "";
	String section2= request.getParameter("section2");
	if(section2 == null) section2 = "";

	// �˻�
	String searchkey = request.getParameter("searchkey");
	if(searchkey == null) searchkey = "";
	String searchvalue= request.getParameter("searchvalue");
	if(searchvalue == null) searchvalue = "";
%>

<html>
<head>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>

<script language="javascript">
<!--
	// �̹���  â ���� ��ũ��Ʈ
	 function viewGallery(idx, category) {
	  sw = screen.width;  // to center: use desired width
	  sh = screen.height;  // to center: use desired height
	  cx = (sw-700) * 0.5  // to center: (.5*sw) - (w*.5)
	  cy = (sh-450) * 0.5  // to center: (.5*sh) - (h*.5)
	  window.open('cyber_gallery_pop.jsp?idx='+idx+'&category='+category,'AsanGallery','left='+cx+',top='+cy+',width=680,height=600,fullscreen=0,toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0');
	 }

		//
  		function doUpdateStatus(idx, status) {
			uframe.location.href = "status_update.jsp?idx=" + idx + "&status="+status+"&tablename=gallery";
  		}
//-->
</script>


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
					<jsp:include page="/asanway/cyber/left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">

                  <table width="624" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b><%= category.equals("gallery")  ? "������" : "�ڷ�� - �̹���" %></b></td>
                    </tr>
                    <tr>
                      <td height="1" bgcolor="D3D2C3"></td>
                    </tr>
					<% if( category.equals("image") ) { %>
						<script language="javascript">
						<!--
							//�� �з��� ���� �迭
							List = new Array(5);
							List[0]=new Array(1);	// ����ƻ�
							List[1]=new Array(3);	// �������
							List[2]=new Array(4);	// ��������
							List[3]=new Array(1);	// �Ǽ����
							List[4]=new Array(1);	// ��Ÿ�������

							// 0 ����ƻ�
							List[0][0]="";

							// 1 �������
							List[1][0]="�ݰ���";
							List[1][1]="����";
							List[1][2]="��λ�";

							// 2 ��������
							List[2][0]="��ϻ���";
							List[2][1]="�ֱٸ��";
							List[2][2]="������������ ��Ȳ";
							List[2][3]="���������� ��Ȳ";

							// 3 �Ǽ����
							List[3][0]="";

							// 4 ��Ÿ�������
							List[4][0]="";



							//Ư�� ä���� �����ϸ� �ش� ī�װ��� ����
							function BuildList(num)
							{

							      //ù ��° ī�װ� ����
							      document.search.section2.selectedIndex=0;

							      //�ش� ä���� ���� ī�װ� �迭 ���̸�ŭ �ݺ�
							      for(ctr=0;ctr<List[num].length;ctr++)
							      {
								       //ī�װ��� �ش��ϴ� �޺��ڽ��� ���� ä��
								       document.search.section2.options[ctr] = new Option(List[num][ctr], ctr);
							      }

							      //select ����Ʈ ���� ����
							      document.search.section2.length = List[num].length;
							}

							function subList(num)
							{
							      document.search.section2.selectedIndex = num;
							}
						//-->
						</Script>
 						<form name="search" method="get" action="cyber_gallery_list.jsp">
	                    	<input type=hidden name=category value=<%=category%>>
	                    <tr>
	                      <td height="40" class="large">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
	                          <tr>
	                          	<td width=200>&nbsp;&nbsp;<%if(section1!=null && !section1.equals("")){%><a href="cyber_gallery_list.jsp?category=image">��ü����Ʈ</a><%}%></td>
	                            <td style="padding-left:5;" width="450" align = right>
	                            	���� &nbsp;
	                            	<select name="section1"  OnChange="BuildList(this.selectedIndex);">
	                            		<option value="0" <%=section1.equals("0") ? "selected" : "" %>>����ƻ�</option>
		                            	<option value="1" <%=section1.equals("1") ? "selected" : "" %>>�������</option>
		                            	<option value="2" <%=section1.equals("2") ? "selected" : "" %>>��������</option>
		                            	<option value="3" <%=section1.equals("3") ? "selected" : "" %>>�Ǽ����</option>
		                            	<option value="4" <%=section1.equals("4") ? "selected" : "" %>>��Ÿ�������</option>
	                            	</select>
	                            	�󼼱��� &nbsp;
	                            	<select name="section2">
		                            	<option value="">----------</option>
	                            	</select> &nbsp;
		                             <a href="javascript:search.submit()"><img src="../img/bt_04.gif" border="0" align="absmiddle"></a> &nbsp; &nbsp;
		                          </td>
	                          </tr>
	                    	</table>
	                      </td>
	                    </tr>
	                    </form>
	                    <script>
	                      <%if(!section1.equals("")){ %>
	                          	BuildList(<%=section1%>);
	                      <%}%>
						  <%if(!section1.equals("") && !section2.equals("")){ %>
                          		subList(<%=section2%>);
                          <%}%>
                         </script>
	                    <tr>
	                      <td height="1" bgcolor="D3D2C3"></td>
	                    </tr>
					<%}%>

                    <tr>
                      <td height="15"></td>
                    </tr>
                    <tr>
                      <td style="padding-top:5;">

					<% int num = 4;  %>
						<table>
							<tr>
					<% if( list.size() == 0 ) {  %>
								<td align="center">��ϵ� ������ �����ϴ�.
					<% } else {

								int i = 0;

								for( i = 0; i < list.size()  ; i++ ) {
									HashMap hm = (HashMap)list.get(i);
					%>

							<% if( i < num && num -  i % num != 0 ) { %>
								<td>
									<table width="150" border="1" cellspacing="0" cellpadding="0">
										<tr>
											<td align="center" height="150"><a href="javascript:viewGallery('<%= hm.get("IDX") %>', '<%= category %>');"><img src="/asanway/common/download.jsp?filename=<%= Utility.ko((String)hm.get("FILE"))%>&dir=gallery&sysfilename=<%= Utility.ko((String)hm.get("SYSFILE"))%>" border="0" width="132" height="88"></a>
										<tr>
											<td style="padding-top:9;"><img src="../img/bottom_02.gif" width="2" height="2" hspace="4" align="absmiddle"><a href="cyber_gallery_modify.jsp?idx=<%= hm.get("IDX") %>&category=<%= category %>"><%= Utility.getStringcut(10, Utility.ko((String)hm.get("TITLE") ) ) %></a>
										<tr>
											<td style="padding-left:5;padding-top:6;" align="center">
			                            	<select name="status" style="width:80px;height:20px" onChange="doUpdateStatus(<%= hm.get("IDX") %>, this.value)">
			                                	<option value="0" <% if( hm.get("STATUS").equals("0") ) { %>selected <% } %> value="0">��ϴ��</option>
			                                	<option value="1" <% if( hm.get("STATUS").equals("1") ) { %>selected <% } %> value="1">��ϵ�</option>
			                              </select>
									</table>

								<% }  %>

							<% if( i < num && (i+1) == list.size() ) {
									if( num - ((i+1) % num) != 4) {
										for(int j = 0; j < (num - (( i+1) % num) ); j++) {
							 %>
							<td width="155" align="center">
							<% } } } %>


							<% if( i == 4 ) { %>
								</table>

					                        </td>
					                    </tr>
					                    <tr>
					                      <td height="15"></td>
					                    </tr>
					                    <tr>
					                      <td height="1" bgcolor="D3D2C3"></td>
					                    </tr>
					                    <tr>
					                      <td height="15"></td>
					                    </tr>
					                    <tr>
					                      <td style="padding-top:5;">
								<% } %>
							<% if( i == 4 ) {  %>
							<table>
								<tr>
							<% } %>
							<% if( i > num-1 && num - i % num != 0 ) { %>
								<td>
									<table width="150" border="1" cellspacing="0" cellpadding="0">
										<tr>
											<td align="center" height="150"><a href="javascript:viewGallery('<%= hm.get("IDX") %>', '<%= category %>');"><img src="/asanway/common/download.jsp?filename=<%= Utility.ko((String)hm.get("FILE"))%>&dir=gallery&sysfilename=<%= Utility.ko((String)hm.get("SYSFILE"))%>" border="0" width="132" height="88"></a>
										<tr>
											<td style="padding-top:9;"><img src="../img/bottom_02.gif" width="2" height="2" hspace="4" align="absmiddle"><a href="cyber_gallery_modify.jsp?idx=<%= hm.get("IDX") %>&category=<%= category %>"><%= Utility.getStringcut(10, Utility.ko((String)hm.get("TITLE") ) ) %></a><% if( Utility.NewDay((String)hm.get("REGTIME")) ) {%> <img src="/asanway/img/bt_19.gif"><% } %>
										<tr>
											<td style="padding-left:5;padding-top:6;" align="center">
                            	<select name="status" style="width:80px;height:20px" onChange="doUpdateStatus(<%= hm.get("IDX") %>, this.value)">
                                	<option value="0" <% if( hm.get("STATUS").equals("0") ) { %>selected <% } %> value="0">��ϴ��</option>
                                	<option value="1" <% if( hm.get("STATUS").equals("1") ) { %>selected <% } %> value="1">��ϵ�</option>
                              </select>
									</table>
								<% }  %>

								<%	if( i > num-1 && (i+1) == list.size() ) {
//										    if ( num - ((i+1) % num) != 4) {
											for(int j = 0; j < (num - (( i+1) % num) ); j++) {
								 %>
								<td width="155" align="center">
								<%  }  } %>

				<% } } %>
					</table>

                       </td>
                    </tr>
                    <tr>
                      <td height="15"></td>
                    </tr>
                    <tr>
                      <td height="2" bgcolor="D3D2C3"></td>
                    </tr>
                    <tr>
                      <td height="50" align="center" >

					<!-- --------------------------- ������ ----------------------- -->
						<Table border="0" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td>
								<%if(helper.getBeforegroup() > 0){%>
									<a href="/asanway/cyber/cyber_gallery_list.jsp?page=<%=helper.getBeforegroup()%>&category=<%= category %>&section1=<%=section1%>&section2=<%=section2%>"><img src="../img/bt_05.gif" width="36" height="11" hspace="8" border="0"></a>
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
										<a href="/asanway/cyber/cyber_gallery_list.jsp?page=<%= i %>&category=<%= category %>&section1=<%=section1%>&section2=<%=section2%>"><%= i %></a>&nbsp;
										<%  }
									  } %>
									<% if(totalP  == 0) { %>1<% } %>
								</td>
								<td>
									<%if(helper.getAftergroup() > 0){%>
										<a href="/asanway/cyber/cyber_gallery_list.jsp?page=<%=helper.getAftergroup()%>&category=<%= category %>&section1=<%=section1%>&section2=<%=section2%>"><img src="../img/bt_06.gif" width="36" height="11" hspace="8" border=0></a>
									<% } else { %>
										<img src="../img/bt_06.gif" width="36" height="11" hspace="8">
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
                      <td align="right"   style="padding-top:5;">
                      <a href="cyber_gallery_write.jsp?category=<%= category %>"><img src="../img/bt_07.gif" width="40" height="20" hspace="4" border="0"></a>
                      </td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                  </table>
                </td>
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
