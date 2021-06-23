<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : 김미의
* 작성날자 : 2005년 10월 25일
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>


<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.cyber.WallpaperBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	WallpaperBean bean = new WallpaperBean();
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

	String category = "wallpaper";
%>

<html>
<head>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "19";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>

<script language="javascript">
<!--
  		function doUpdateStatus(idx, status) {
			uframe.location.href = "status_update.jsp?idx=" + idx + "&status="+status+"&tablename=ceotrend";
  		}

  		function doDel(idx){
			var idx = idx;
			if (confirm("삭제하시겠습니까?")) {
				location.href="/asanway/cyber/cyber_wallpaper_action.jsp?cmd=D&idx="+idx;
			}
		}

		function goInsert()
		{

			var form = document.form;

			if( form.img1.value=="" )
			{
				alert("이미지를 선택하세요.");
				form.img1.focus();
				return false;
			}

			return true;

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
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>월페이퍼</b></td>
                    </tr>
                    <tr>
                      <td height="1" bgcolor="D3D2C3"></td>
                    </tr>
                    <tr>
                      <td height="15"></td>
                    </tr>
                    <tr>
                      <td style="padding-top:5;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<% if( list.size() == 0 ) {  %>
									<tr valign="top">
										<td align="center" colspan=9>등록된 이미지가  없습니다. </td>
									</tr>
						<% } else { %>
								<tr valign="top">
									<td></td>
						<%
									int i = 0;
									int num = 4;
									int k = 0;

									for( i = 0; i < list.size()  ; i++ ) {
										HashMap hm = (HashMap)list.get(i);
						%>

								<% if((i != 0 )&& (i % (num) ==0)) { %>
									</tr>
										<tr><td colspan="9" height="15"></td></tr>
										<tr><td colspan="9" height="1" bgcolor="#DBDACB"></td></tr>
										<tr><td colspan="9" height="15"></td></tr>
									<tr><td></td>
								<% } %>
									<td>
										<table border="0" cellpadding="0" cellspacing="0" width="134">
										<tr>
											<td colspan="2" align=center>
												<img src="/asanway/common/download.jsp?filename=<%= Utility.ko((String)hm.get("IMG3"))%>&dir=wallpaper&sysfilename=<%= Utility.ko((String)hm.get("SYSIMG3"))%>" border="0" width="134" height="128">
											</td>
										</tr>
										<tr>
											<td colspan="2" height=5></td>
										</tr>
										<tr height="30" valign="top">
											<td colspan="2"  align=center>
											 <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
				                                <tr>
				                                  <td width="55%" height="16" class="pass"><img src="../img/bottom_02.gif" width="2" height="2" hspace="4" align="absmiddle">1024*768
				                                  </td>
				                                  <td width="45%" ><a href="/asanway/common/download.jsp?filename=<%= Utility.ko((String)hm.get("IMG1"))%>&dir=wallpaper&sysfilename=<%= Utility.ko((String)hm.get("SYSIMG1"))%>" ><img src="../img/bt_32.gif" border=0></a></td>
				                                </tr>
				                                <tr>
				                                  <td height="16" class="pass"><img src="../img/bottom_02.gif" width="2" height="2" hspace="4" align="absmiddle">1280*1024</td>
				                                  <td>
													<%if(hm.get("IMG2")==null){%>
														<img src="../img/bt_32.gif" border=0>
													<%}else{%>
														<a href="/asanway/common/download.jsp?filename=<%= Utility.ko((String)hm.get("IMG2"))%>&dir=wallpaper&sysfilename=<%= Utility.ko((String)hm.get("SYSIMG2"))%>" ><img src="../img/bt_32.gif" border=0></a>
													<%}%>
												  </td>
				                                </tr>
				                              </table>
				                            </td>
				                        </tr>
				                        <tr>
											<td colspan="2" height=5></td>
										</tr>
										<tr>
											<td colspan="2" style="padding-left:5">
												<select name="status" style="width:80px;height:20px" onChange="doUpdateStatus(<%= hm.get("IDX") %>, this.value)">
				                                	<option value="0" <% if( hm.get("STATUS").equals("0") ) { %>selected <% } %> value="0">등록대기</option>
				                                	<option value="1" <% if( hm.get("STATUS").equals("1") ) { %>selected <% } %> value="1">등록됨</option>
				                                </select>&nbsp;
				                                <a href="javascript:doDel('<%= hm.get("IDX")  %>')"><img src="../img/bt_09.gif" width="40" height="20" hspace="3" border="0" align=absmiddle></a>
				                            </td>
				                        </tr>
										</table>
									</td>
									<td></td>

								<% if((i == (list.size()-1)) ||(( i+1) == num)) {
										for( k = 1; k < num-(i%num) ; k++ ) {
								%>
										<td width="134">&nbsp;</td><td></td>
								<%	} %>
										</tr>
								<% } %>
							<%	}%>
						<%	}%>
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
									<a href="/asanway/cyber/cyber_wallpaper_list.jsp?page=<%=helper.getBeforegroup()%>"><img src="../img/bt_05.gif" width="36" height="11" hspace="8"></a>
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
										<a href="/asanway/cyber/cyber_wallpaper_list.jsp?page=<%= i %>"><%= i %></a>&nbsp;
										<%  }
									  } %>
									<% if(totalP  == 0) { %>1<% } %>
								</td>

								<td>
									<%if(helper.getAftergroup() > 0){%>
										<a href="/asanway/cyber/cyber_wallpaper_list.jsp.jsp?page=<%=helper.getAftergroup()%>"><img src="../img/bt_06.gif" width="36" height="11" hspace="8" border=0></a>
									<% } else { %>
										<img src="../img/bt_06.gif" width="36" height="11" hspace="8">
									<% } %>
								</td>
							</tr>
						</table>
					<!-- --------------------------- 페이지 ----------------------- -->
                        </td>
                    </tr>
                    <tr>
                      <td height="1" bgcolor="D3D2C3"></td>
                    </tr>
                     <tr>
                      <td height="10" ></td>
                    </tr>
                     <tr>
                      <td height="20" ><img src="../img/bt_13.gif" hspace="4" align="absmiddle"><b>등록하기</b></td>
                    </tr>

                    <tr>
                      <td align="right"   style="padding-top:5;">
						<!-- --------------------------- 월페이퍼 등록  start----------------------- -->
						<form name="form" method="post" action="cyber_wallpaper_action.jsp?cmd=I"  enctype="multipart/form-data" onSubmit="return goInsert()">
							<input type="hidden" name="category" value="<%=category%>">
	                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                          <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;" width=100>이미지(1024*768)</td>
	                            <td style="padding-left:5;"><input type="file" name="img1" size="31" style="width:300px;height:20px">
	                            </td>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                          <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">이미지(1280*1024)</td>
	                            <td style="padding-left:5;"><input type="file" name="img2" size="31" style="width:300px;height:20px"></td>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                          <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">썸네일 이미지</td>
	                            <td style="padding-left:5;">
	                            	<input type="file" name="img3" size="31" style="width:300px;height:20px">(*권장 사이즈:134 *128) &nbsp;
	                            </td>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                           <tr>
			                      <td align="right"   style="padding-top:5;" colspan=2><input type="image" src="../img/bt_07.gif" width="40" height="20" border="0" align=absmiddle></td>
			                    </tr>
	                        </table>
							<!-- --------------------------- 월페이퍼 등록  end----------------------- -->

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
