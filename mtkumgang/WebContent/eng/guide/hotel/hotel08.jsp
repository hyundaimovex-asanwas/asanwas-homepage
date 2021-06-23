<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<%  
String pageNum = "1";
String subNum = "2";
String McNum = "4";
String sub = "8";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>::: Mt.Kumgang Tour :::</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script language="JavaScript" src="<%=imageServer%>/eng_img/inc/java.js"></script>
</head>

<body>
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="/eng/include/guide/tour_guide_top.jsp" %>
		<!-------- top area / -------->
		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0"> 
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="/eng/include/guide/tour_guide_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/eng_img/guide/routeguide2_title_08.gif"></td>
					  
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
                  <tr>
                    <td height="36"></td>
                  </tr>
                  <tr>
                    <td><table width="690" cellpadding="0" cellspacing="0" border="0">
                        <tr valign="top">
                          <td width="264"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                              <tr>
                                <td><img src="<%=imageServer%>/eng_img/guide/txt_hotel08.gif"></td>
                              </tr>
                              <tr>
                                <td height="12"></td>
                              </tr>
                              <tr>
                                <td><img src="<%=imageServer%>/eng_img/guide/txt_hotel081.gif"></td>
                              </tr>
                              <tr>
                                <td height="25"></td>
                              </tr>
                              <tr>
                                <td><img src="<%=imageServer%>/eng_img/guide/txt_hotel082.gif"></td>
                              </tr>
                              <tr>
                                <td height="12"></td>
                              </tr>
                              <tr>
                                <td><img src="<%=imageServer%>/eng_img/guide/txt_hotel083.gif"></td>
                              </tr>
                              <tr>
                                <td height="12"></td>
                              </tr>
                              <tr>
                                <td><img src="<%=imageServer%>/eng_img/guide/txt_hotel084.gif"></td>
                              </tr>
                              <tr>
                                <td height="12"></td>
                              </tr>
                              <tr>
                                <td><img src="<%=imageServer%>/eng_img/guide/txt_hotel085.gif"></td>
                              </tr>
                          </table></td>
                          <td width="426"><img src="<%=imageServer%>/eng_img/guide/img_hotel08.jpg" ></td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="30"></td>
                  </tr>
                  <tr>
                    <td valign="top"><!-- / detail table  -->
                        <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="232">
                          <col width="458">
                          <tr valign="top" class="bpad_25">
                            <td><img src="<%=imageServer%>/eng_img/guide/img_hotel0801.jpg"></td>
                            <td><img src="<%=imageServer%>/eng_img/guide/txt_hotel0801.gif" style="margin-top:11px;"></td>
                          </tr>
                        </table>
                      <!-- detail table / -->
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
        <%@ include file="/eng/include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>
</body>
</html>
</body>
</html>
