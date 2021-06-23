<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 11월 15일
* 요약 설명 : 스크랩 마스터 공통 (신문, 잡지, 방송, 인터넷)
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%@ page import="com.hmm.asan.asanway.cyber.ScrapBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="java.util.HashMap" %>

<%
	String menutitle = "";
	String downfolder = "";
	String category = request.getParameter("category");

	if(category=="" ){
		out.println("<script language=javascript>");
		out.println("	alert('잘못된 경로로 접근하셨습니다.  다시 시도해 주십시오.');");
		out.println("	history.go(-1);");
		out.println("	</script>");
	}else {
		if(category.equals("magazine")){
			menutitle = "스크랩마스터 - 잡지기사 스크랩";
			downfolder = "scrap";

		}else if(category.equals("broadcast")){
			menutitle = "스크랩마스터 - 방송기사 스크랩";
			downfolder = "scrap";

		}else if(category.equals("internet")){
			menutitle = "스크랩마스터 - 인터넷 기사 스크랩";
			downfolder = "scrap";

		}else{
			out.println("<script language=javascript>");
			out.println("	alert('잘못된 경로로 접근하셨습니다. 다시 시도해 주십시오.');");
			out.println("	history.go(-1);");
			out.println("	</script>");
		}
	}
%>

<%
	ScrapBean bean = new ScrapBean(category);
	bean.Read(request, response);

	//구분 값
	HashMap section1hm = new HashMap();
		section1hm.put("1","사업관련기사");
		section1hm.put("2","한반도관련기사");
		section1hm.put("3","기타기사");
%>

<jsp:useBean id="read" class="java.util.HashMap" scope="request" />

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "20";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>

<script language="javascript">

<!--
	function doDel(idx)
	{
		var idx = idx;

		if (confirm("삭제하시겠습니까?")) {
			location.href="/asanway/cyber/cyber_scrap_action.jsp?category=<%=category%>&cmd=D&idx="+idx;
		}
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
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" >
          	<table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top" bgcolor="FCFCF6">
					<jsp:include page="/asanway/cyber/left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table>
          </td>
          <td valign="top" bgcolor="FCFCF6">
          	<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b><%=menutitle%></b></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr>
                            <td>
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">

                                <tr>
                                  <td height="30" align="center" bgcolor="DEDDCF">일자</td>
                                  <td bgcolor="F2F1E2" style="padding-left:5;"><%= read.get("PUBDATE").toString().substring(0, 10) %></td>
                                  <td width="100" align="center" bgcolor="DEDDCF">매체 </td>
                                  <td width="100" bgcolor="F2F1E2" style="padding-left:5;"><%=(read.get("SECTION2") == null)?"":Utility.ko((String)read.get("SECTION2"))%></td>
                                  <td width="100" align="center" bgcolor="DEDDCF">조회수 </td>
                                  <td width="100" bgcolor="F2F1E2" style="padding-left:5;"><%= read.get("HIT") %></td>
                                </tr>
                                <tr>
                                  <td height="1" bgcolor="D3D2C3" colspan="6"></td>
                                </tr>
                                 <tr bgcolor="F2F1E2">
                                  <td width="100" height="30" align="center" bgcolor="DEDDCF">제목</td>
                                  <td colspan="3" bgcolor="F2F1E2" style="padding-left:5;"><%= Utility.ko( (String)read.get("TITLE") ) %></td>
                                  <td width="100" align="center" bgcolor="DEDDCF">기사구분 </td>
                                  <td width="100" bgcolor="F2F1E2" style="padding-left:5;"><%= section1hm.get(read.get("SECTION1"))%></td>
                                </tr>

                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>

                    <!--동영상 start-->
                    <tr>
                      <td height="5"></td>
                    </tr>
                   <%if(category.equals("magazine")) { %>
                    <tr>
                      <td valign="top" style="padding:10 10 10 10;" align=center>
                      <div id=scroll style="width: 650; height: 500; overflow: auto">
                      	<img src="/asanway/common/download.jsp?filename=<%= Utility.ko((String)read.get("IMGFILE"))%>&dir=scrap&sysfilename=<%= Utility.ko((String)read.get("SYSIMGFILE"))%>" border="0" >
                      </div>
                      </td>
                    </tr>
                   <%}else{ %>
	                   <% if(read.get("FILELOC") != null){%>
		                    <tr>
		                      <td valign="top" style="padding:10 10 10 10;">
		                      	<table border="0" cellpadding="0" cellspacing="0" width="624">
								<tr valign="top">
		                      		<td width="185"><img src="/img/cyberpr/speech_01.gif"></td>
									<td width="255">
										<table cellpadding=0 cellspacing=0>
										<tr>
											<td height=12></td>
										</tr>
										<tr>
											<td>
												<OBJECT id="mediaPlayer" classid="CLSID:22D6F312-B0F6-11D0-94AB-0080C74C7E95"
												type="application/x-oleobject" width=233 height=163 vspace=0 hspace=0 align="middle" style="left:0px; top:0px;">
												<param name="AllowChangeDisplaySize" value="false">
												<param name="AllowScan" value="true">
												<param name="AnimationAtStart" value="false">
												<param name="AudioStream" value="-1">
												<param name="AutoRewind" value="true">
												<param name="AutoSize" value="false">
												<param name="AutoStart" value="true">
												<param name="Balance" value="0">
												<param name="BufferingTime" value="5">
												<param name="ClickToPlay" value="true">
												<param name="CurrentMarker" value="-1">
												<param name="CurrentPosition" value="-1">
												<param name="CursorType" value="0">
												<param name="DisplayBackColor" value="0">
												<param name="DisplayForeColor" value="16777215">
												<param name="DisplayMode" value="0">
												<param name="DisplaySize" value="0">
												<param name="EnableContextMenu" value="false">
												<param name="Enabled" value="true">
												<param name="EnableFullScreenControls" value="false">
												<param name="EnablePositionControls" value="true">
												<param name="EnableTracker" value="true">
												<param name="InvokeURLs" value="true">
												<param name="Language" value="-1">
												<param name="Mute" value="false">
												<param name="PlayCount" value="1">
												<param name="PreviewMode" value="false">
												<param name="Rate" value="1">
												<param name="SelectionEnd" value="-1">
												<param name="SelectionStart" value="-1">
												<param name="SendErrorEvents" value="true">
												<param name="SendKeyboardEvents" value="false">
												<param name="SendMouseClickEvents" value="false">
												<param name="SendMouseMoveEvents" value="false">
												<param name="SendOpenStateChangeEvents" value="true">
												<param name="SendPlayStateChangeEvents" value="true">
												<param name="SendWarningEvents" value="true">
												<param name="ShowAudioControls" value="false">
												<param name="ShowCaptioning" value="false">
												<param name="ShowControls" value="false">
												<param name="ShowDisplay" value="false">
												<param name="ShowGotoBar" value="false">
												<param name="ShowPositionControls" value="false">
												<param name="ShowStatusBar" value="false">
												<param name="ShowTracker" value="false">
												<param name="TransparentAtStart" value="false">
												<param name="VideoBorder3D" value="true">
												<param name="VideoBorderColor" value="0">
												<param name="VideoBorderWidth" value="0">
												<param name="Volume" value="-400">
												<param name="WindowlessVideo" value="-1">
												<param name="Filename" value="<%=read.get("FILELOC") %>">
												</OBJECT>
											</td>
										</tr>
										</table>
										<script>
											function play(){
												document.mediaPlayer.play();
											}
											function stop(){
												document.mediaPlayer.stop();
											}
											function pause(){
												document.mediaPlayer.pause();
											}
											function fastForward(){
												document.mediaPlayer.fastForward();
											}
											function fastReverse(){
												document.mediaPlayer.fastReverse();
											}
											function soundon(){
												document.mediaPlayer.Mute = false;
											}
											function soundoff(){
												document.mediaPlayer.Mute = true;
											}

										</script>
										<MAP NAME="player">
											<AREA SHAPE="" HREF="#" COORDS="11,7,36,22" onClick="javascript:fastReverse();"  onFocus="blur()">
											<AREA SHAPE="" HREF="#" COORDS="36,7,61,22" onClick="javascript:play();" onFocus="blur()">
											<AREA SHAPE="" HREF="#" COORDS="63,7,88,22" onClick="javascript:stop();" onFocus="blur()">
											<AREA SHAPE="" HREF="#" COORDS="90,7,115,22" onClick="javascript:fastForward();"  onFocus="blur()">
											<AREA SHAPE="" HREF="#" COORDS="176,7,216,22" onClick="javascript:soundon();"  onFocus="blur()">
											<AREA SHAPE="" HREF="#" COORDS="223,7,243,22" onClick="javascript:soundoff();"  onFocus="blur()">
										</MAP>
									</td>
									<td width="35"><img src="/img/cyberpr/speech_04.gif"></td>
								</tr>
								</table>
							  </td>
		                    </tr>
	                    <!--동영상 end-->
						<%}%>
	                    <tr>
	                      <td height="5"></td>
	                    </tr>
	                    <tr>
	                      <td valign="top" style="padding:10 10 10 10;"><%= (read.get("CONTENT") == null)?"":Utility.ko( (String)read.get("CONTENT") ) %></td>
	                    </tr>
					<%}%>


                    <tr>
	                    <td colspan="2" height="1" bgcolor="DBDACB"></td>
	                </tr>
	                <tr>
                      <td height="5"></td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;">
                      <a href="cyber_scrap_modify.jsp?category=<%=category%>&idx=<%= read.get("IDX") %>"><img src="../img/bt_08.gif" width="40" height="20" border="0"></a>
                      <a href="javascript:doDel('<%= read.get("IDX")  %>')"><img src="../img/bt_09.gif" width="40" height="20" hspace="3" border="0"></a>
                      <a href="cyber_scrap_list.jsp?category=<%=category%>"><img src="../img/bt_10.gif" width="40" height="20" border="0"></a>
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
<iframe id='cframe' name='cframe' src='about:blank' width=0 height=0 frameborder=0 border=0></iframe>
</body>
</html>


