<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<html> 
<head> 
<title> �ݰ������   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td height="87" valign="top">
			<!-- top menu flash -->
              <script language="javascript">
                  show_flash_F("topFlash","<%=imageServer%>/tour_swf/topMenu1.swf?aaa=<%=aaa%>&bbb=<%=bbb%>","910","87","transparent","")
              </script>
            </td>
		</tr>
		<tr>
			<td height="165" valign="top">
				<!-- top flash -->
              <script language="javascript">
                  show_flash_F("topFlash08","<%=imageServer%>/tour_swf/topFlash08.swf","100%","165","transparent","")
              </script>
			</td>
		</tr>
		</table>		
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/tour_img/leftMenu08.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/footer/tit_footer01.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">ȸ��Ұ�</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="24"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="277">
								<table width="277" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/tour_img/footer/img_intro.jpg"></td></tr>
								<tr><td height="13"></td></tr>
								<tr><td><img src="<%=imageServer%>/tour_img/footer/txt_intro_03.gif"></td></tr>
								</table>
							</td>
							<td width="413">
								<table width="413" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/tour_img/footer/txt_intro_01.gif"></td></tr>
								<tr><td height="30"></td></tr>
								<tr><td><img src="<%=imageServer%>/tour_img/footer/txt_intro_02.gif"></td></tr>
								<tr><td height="70"></td></tr>
								</table>
								<table width="413" cellpadding="0" cellspacing="0" border="0">
								<tr><td valign="top" height="21" colspan="2"><img src="<%=imageServer%>/tour_img/footer/txt01.gif"></td></tr>
								<tr>
									<td width="12"></td>
									<td width="401">����ƻ�(��)�������ߣ(�)��Hyundai Asan Corp.</td>
								</tr>
								<tr><td height="12" colspan="2"></td></tr>
								<tr><td height="1" class="line_g" colspan="2"></td></tr>
								<tr><td height="15" colspan="2"></td></tr>
								<tr><td valign="top" height="21" colspan="2"><img src="<%=imageServer%>/tour_img/footer/txt02.gif"></td></tr>
								<tr>
									<td></td>
									<td>1999�� 2�� 5��</td>
								</tr>
								<tr><td height="12" colspan="2"></td></tr>
								<tr><td height="1" class="line_g" colspan="2"></td></tr>
								<tr><td height="15" colspan="2"></td></tr>
								<tr><td valign="top" height="21" colspan="2"><img src="<%=imageServer%>/tour_img/footer/txt03.gif"></td></tr>
								<tr>
									<td></td>
									<td>
										- ������ ���� : ����� ���α� ������ ����׷����<a href="/include/contactus.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_footer_maptel.gif" hspace="5" align="absmiddle"></a><!-- �൵����ó�ȳ� --><br>
										- �ݰ��� ����� : ������ ���� ������<br>
										- ������ ����� : Ȳ�ص� ������ ������ 163��<br>
										- ���� �繫�� : ������ ���� ������ �ʵ��� ��28����<br><span style="margin-left:98px">ȭ���� �ƻ� �ްԼ�</span><br></td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
				<!--  content / -->
			</td>
		</tr>
		</table>
		<!--------  center area /-------->
	</td>
</tr>
<tr>
	<td valign="bottom">
		<!--/ footer -->           
        <%@ include file="footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>