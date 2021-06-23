<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<% 
  String pageNum = "3";
  String McNum = "1";
  String sub = "3";  
%> 
<html> 
<head>
<title> 금강산관광 </title>
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
        <%@ include file="../../include/preview/tour_preview_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			    <!--  left menu flash -->
				<%@ include file="../../include/preview/tour_preview_left.jsp" %>
			    <!--  left menu flash -->	
				</td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/preview/tit_preview03.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">금강산 알아보기</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">갤러리</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="22"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/preview/txt_top_preview03.gif"></td></tr>
				<tr>
					<td valign="top" align="center">
						<table width="630" cellpadding="0" cellspacing="0" border="0">
						<col width="160"><col width="160"><col width="160"><col width="150">
						<tr><td colspan="4" height="48"></td></tr>
						<tr valign="top">
						
							<td><a href="javascript:;" onclick="window.open ('popup_gallery_view.jsp?type_code=21', 'movieview', 'width=630,height=585,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/preview/img_gallery01.jpg" width="150" height="528"></a></td>
							<td><a href="javascript:;" onclick="window.open ('popup_gallery_view.jsp?type_code=22', 'movieview', 'width=630,height=585,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/preview/img_gallery02.jpg" width="150" height="528"></a></td>
							<td><a href="javascript:;" onclick="window.open ('popup_gallery_view.jsp?type_code=23', 'movieview', 'width=630,height=585,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/preview/img_gallery03.jpg" width="150" height="528"></a></td>
							<td><a href="javascript:;" onclick="window.open ('popup_gallery_view.jsp?type_code=24', 'movieview', 'width=630,height=585,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/preview/img_gallery04.jpg" width="150" height="528"></a></td>							
						</tr>
						<tr><td colspan="4" height="30"></td></tr>
						<tr>
                      <td colspan="4" height="211"><a href="javascript:;" onclick="window.open ('popup_gallery_view.jsp?type_code=25', 'movieview', 'width=630,height=585,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');">
					  <img src="<%=imageServer%>/tour_img/preview/img_gallery05.jpg" width="630" height="211" border="0"></a></td>
                    </tr>
						<tr><td colspan="4" height="48"></td></tr>
						<tr><td colspan="4"><img src="<%=imageServer%>/tour_img/preview/txt_preview03.gif" width="630"></td></tr>
						<tr><td colspan="4" height="54"></td></tr>
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
        <%@ include file="../../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>