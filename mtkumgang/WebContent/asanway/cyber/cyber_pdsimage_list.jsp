<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : 김종문
* 작성날자 : 2005년 10월 13일
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>


<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.cyber.GalleryBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	GalleryBean bean = new GalleryBean();
	bean.List(request, response);
%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="helper" class="com.hmm.asan.common.util.PagingHelper" scope="request" />

<%
	//페이징 하기 위한 값을 셋팅한다.
	int currentP = helper.getCurpage();
	int count = helper.getTotalcount();
	int totalP = helper.getTotalpage();

	int currentG = (int)((currentP-1)/helper.getGroupsize()) + 1;

	int startP = (int)((currentG-1)*helper.getGroupsize()) + 1;
	int endP = (int)(currentG*helper.getGroupsize());
%>

<%
	// 검색
	String searchkey = request.getParameter("searchkey");
	if(searchkey == null) searchkey = "";
	String searchvalue= request.getParameter("searchvalue");
	if(searchvalue == null) searchvalue = "";
%>

<html>
<head>

<%@ include file="/asanway/common/head.jsp" %>
<script language="javascript">
<!--
	// 이미지  창 띄우는 스크립트
	 function viewGallery(idx) {
	  sw = screen.width;  // to center: use desired width
	  sh = screen.height;  // to center: use desired height
	  cx = (sw-700) * 0.5  // to center: (.5*sw) - (w*.5)
	  cy = (sh-450) * 0.5  // to center: (.5*sh) - (h*.5)
	  window.open('cyber_gallery_pop.jsp?idx='+idx,'AsanGallery','left='+cx+',top='+cy+',width=680,height=600,fullscreen=0,toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0');
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
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>갤러리</b></td>
                    </tr>
                    <tr>
                      <td height="1" bgcolor="D3D2C3"></td>
                    </tr>
                    <tr>
                      <td height="15"></td>
                    </tr>
                    <tr>
                      <td style="padding-top:5;">

					<% int num = 4;  %>
						<table>
							<tr>
					<% if( list.size() == 0 ) {  %>
								<td align="center">등록된 사진이 없습니다.
					<% } else {

								int i = 0;

								for( i = 0; i < list.size()  ; i++ ) {
									HashMap hm = (HashMap)list.get(i);
					%>

							<% if( i < num && num -  i % num != 0 ) { %>
								<td>
									<table width="150" border="1" cellspacing="0" cellpadding="0">
										<tr>
											<td align="center" height="150"><a href="javascript:viewGallery('<%= hm.get("IDX") %>');"><img src="/asanway/common/download.jsp?filename=<%= Utility.ko((String)hm.get("FILE"))%>&dir=gallery&sysfilename=<%= Utility.ko((String)hm.get("SYSFILE"))%>" border="0" width="132" height="88"></a>
										<tr>
											<td style="padding-top:9;"><img src="../img/bottom_02.gif" width="2" height="2" hspace="4" align="absmiddle"><a href="cyber_gallery_modify.jsp?idx=<%= hm.get("IDX") %>"><%= Utility.getStringcut(10, Utility.ko((String)hm.get("TITLE") ) ) %></a>
										<tr>
											<td style="padding-left:5;padding-top:6;" align="center">
                            	<select name="status" style="width:80px;height:20px" onChange="doUpdateStatus(<%= hm.get("IDX") %>, this.value)">
                                	<option value="0" <% if( hm.get("STATUS").equals("0") ) { %>selected <% } %> value="0">등록대기</option>
                                	<option value="1" <% if( hm.get("STATUS").equals("1") ) { %>selected <% } %> value="1">등록됨</option>
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
											<td align="center" height="150"><a href="javascript:viewGallery('<%= hm.get("IDX") %>');"><img src="/asanway/common/download.jsp?filename=<%= Utility.ko((String)hm.get("FILE"))%>&dir=gallery&sysfilename=<%= Utility.ko((String)hm.get("SYSFILE"))%>" border="0" width="132" height="88"></a>
										<tr>
											<td style="padding-top:9;"><img src="../img/bottom_02.gif" width="2" height="2" hspace="4" align="absmiddle"><a href="cyber_gallery_modify.jsp?idx=<%= hm.get("IDX") %>"><%= Utility.getStringcut(10, Utility.ko((String)hm.get("TITLE") ) ) %></a><% if( Utility.NewDay((String)hm.get("REGTIME")) ) {%> <img src="/asanway/img/bt_19.gif"><% } %>
										<tr>
											<td style="padding-left:5;padding-top:6;" align="center">
                            	<select name="status" style="width:80px;height:20px" onChange="doUpdateStatus(<%= hm.get("IDX") %>, this.value)">
                                	<option value="0" <% if( hm.get("STATUS").equals("0") ) { %>selected <% } %> value="0">등록대기</option>
                                	<option value="1" <% if( hm.get("STATUS").equals("1") ) { %>selected <% } %> value="1">등록됨</option>
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

					<!-- --------------------------- 페이지 ----------------------- -->
						<Table border="0" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td>
								<%if(helper.getBeforegroup() > 0){%>
									<a href="/asanway/cyber/cyber_gallery_list.jsp?page=<%=helper.getBeforegroup()%>"><img src="../img/bt_05.gif" width="36" height="11" hspace="8" border="0"></a>
								<% } else { %>
									<img src="../img/bt_05.gif" width="36" height="11" hspace="8">
								<% } %>
								</td>
							<!--
								<td width="60" align="left">
								<%if(helper.getBefore() > 0){%>
									<a href="/admin/newsroom/notice/notice_list.jsp?p=<%=helper.getBefore()%>"><img src="/admin/common/img/btn_pre.gif" border="0"></a>
								<% } else { %>
									<img src="/admin/common/img/btn_pre.gif" border="0">
								<% } %>
								</td>
							-->
								<td>
									<%
									  for(int i = startP; i <= endP; i++){
										if(i > totalP) break;
											if(i == currentP){
									%>
										<b><font color="#CE261D"><%= i %></font></b>&nbsp;
										<%  } else { %>
										<a href="/asanway/cyber/cyber_gallery_list.jsp?page=<%= i %>"><%= i %></a>&nbsp;
										<%  }
									  } %>
									<% if(totalP  == 0) { %>1<% } %>
								</td>
							<!--
								<td width="64" align="right">
									<% if(helper.getAfter() > 0){%>
										<a href="/admin/newsroom/notice/notice_list.jsp?p=<%=helper.getAfter()%>"><img src="/admin/common/img/btn_next.gif" border="0"></a>
									<% } else { %>
										<img src="/admin/common/img/btn_next.gif" border="0">
									<% } %>
								</td>
							 -->
								<td>
									<%if(helper.getAftergroup() > 0){%>
										<a href="/asanway/cyber/cyber_gallery_list.jsp?page=<%=helper.getAftergroup()%>"><img src="../img/bt_06.gif" width="36" height="11" hspace="8" border=0></a>
									<% } else { %>
										<img src="../img/bt_06.gif" width="36" height="11" hspace="8">
									<% } %>
								</td>
							</tr>
						</table>
					<!-- --------------------------- 페이지 ----------------------- -->

					<!--
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
                        -->

                        </td>
                    </tr>
                    <tr>
                      <td height="1" bgcolor="D3D2C3"></td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;">
                      <a href="cyber_gallery_write.jsp"><img src="../img/bt_07.gif" width="40" height="20" hspace="4" border="0"></a>
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
