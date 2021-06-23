<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<%  
String pageNum = "1";
String subNum = "1";
String McNum = "4";
String sub = "1";
%>
<html>
<head>
<title>::: Mt.Kumgang Tour :::</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script language="JavaScript" src="<%=imageServer%>/eng_img/inc/java.js"></script>

<script language="javascript"> 
    function fc_print()
    { 
       //document.all.prt.style.display="none";
       var win = window.open("/common/blank.jsp","print","left=-10000,top=-10000,width="+ (document.all.print_area.offsetWidth + 18) + ",height="+document.all.print_area.offsetHeight);
       
       //document.all.prt.style.display = "";
       // window.print();
    } 
</script> 
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="/eng/include/start/tour_start_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="/eng/include/start/tour_start_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/eng_img/start/tit_start01.gif"></td>
						<td align="right" class="linemap"></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

<DIV id="print_area" class=newpage style="width:690">				
            <table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
              <tr>
                <td height="11"></td>
              </tr>
              <tr>
                <td><img src="<%=imageServer%>/eng_img/start/img_top_start01.jpg"></td>
              </tr>
              <tr>
                <td height="10"></td>
              </tr>
              <tr> 
                <td> 
                  <!-- / ÅÇ¸Þ´º -->
                  <table width="690" cellpadding="0" cellspacing="0" border="0">
                    <tr> 
                      <td width="102" height="28"><img src="<%=imageServer%>/eng_img/start/tab_start0101_on.gif"></td>
							<td width="102"><a href="packup02.jsp"><img src="<%=imageServer%>/eng_img/start/tab_start0102.gif" onmouseover="this.src='<%=imageServer%>/eng_img/start/tab_start0102_on.gif'" onmouseout="this.src='<%=imageServer%>/eng_img/start/tab_start0102.gif'"></a></td>
							<td width="2"><img src="<%=imageServer%>/eng_img/start/tab_start0111.gif"></td>
							<td width="482" background="<%=imageServer%>/eng_img/start/tab_start0112.gif"></td>
							<td width="2"><img src="<%=imageServer%>/eng_img/start/tab_start0113.gif"></td>
                  </table>
                  <table width="690" class="bg_lgreen" cellpadding="0" cellspacing="0" border="0">
                    <tr> 
                      <td  height="33" class="txt_dgreen"><img src="<%=imageServer%>/tour_img/bu/bu_dgreen_arw.gif" style="margin:0 5 2 16px;"><strong>Note 
                        :</strong> You cannot carry cell phones in North Korea. 
                        Entrust your cell phone to your guide.</td>
                    </tr>
                  </table>
                  <!-- ÅÇ¸Þ´º / -->
                </td>
              </tr>
              <tr>
                <td height="30"></td>
              </tr>
              <tr> 
                <td> <table width="690" cellpadding="0" cellspacing="0" border="0">
                    <tr class="bpad_15" valign="top"> 
                      <td width="135"><img src="<%=imageServer%>/eng_img/start/img_start0101.gif" width="115" height="100"></td>
                      <td width="210"><img src="<%=imageServer%>/eng_img/start/txt_start0101.gif" style="margin-top:10px;"></td>
                      <td width="135"><img src="<%=imageServer%>/eng_img/start/img_start0102.gif" width="115" height="100"></td>
                      <td width="210"><img src="<%=imageServer%>/eng_img/start/txt_start0102.gif" style="margin-top:10px;"></td>
                    </tr>
                    <tr class="bpad_15" valign="top"> 
                      <td><img src="<%=imageServer%>/eng_img/start/img_start0103.jpg" width="115" height="100"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/txt_start0103.gif" style="margin-top:10px;"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/img_start0104.jpg" width="115" height="100"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/txt_start0104.gif" style="margin-top:10px;"></td>
                    </tr>
                    <tr class="bpad_15" valign="top"> 
                      <td><img src="<%=imageServer%>/eng_img/start/img_start0105.jpg" width="115" height="100"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/txt_start0105.gif" style="margin-top:10px;"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/img_start0106.jpg" width="115" height="100"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/txt_start0106.gif" style="margin-top:10px;"></td>
                    </tr>
                    <tr class="bpad_15" valign="top"> 
                      <td><img src="<%=imageServer%>/eng_img/start/img_start0107.jpg" width="115" height="100"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/txt_start0107.gif" style="margin-top:10px;"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/img_start0108.jpg" width="115" height="100"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/txt_start0108.gif" style="margin-top:10px;"></td>
                    </tr>
                    <tr class="bpad_15" valign="top"> 
                      <td><img src="<%=imageServer%>/eng_img/start/img_start0109.jpg" width="115" height="100"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/txt_start0109.gif" style="margin-top:10px;"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/img_start0110.jpg" width="115" height="100"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/txt_start0110.gif" style="margin-top:10px;"></td>
                    </tr>
                    <tr class="bpad_15" valign="top"> 
                      <td><img src="<%=imageServer%>/eng_img/start/img_start0111.jpg" width="115" height="100"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/txt_start0111.gif" style="margin-top:10px;"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/img_start0112.jpg" width="115" height="100"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/txt_start0112.gif" style="margin-top:10px;"></td>
                    </tr>
                    <tr class="bpad_15" valign="top"> 
                      <td><img src="<%=imageServer%>/eng_img/start/img_start0113.jpg" width="115" height="100"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/txt_start0113.gif" style="margin-top:10px;"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/img_start0114.jpg" width="115" height="100"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/txt_start0114.gif" style="margin-top:10px;"></td>
                    </tr>
                    <tr> 
                      <td height="10" colspan="4"></td>
                    </tr>
                    <tr> 
                      <td align="right" colspan="4"> <a href="javascript:;" onclick="fc_print()"><img src="<%=imageServer%>/eng_img/start/btn_start_print.gif" class="btn" name=prt id=prt></a> 
                        <!-- ÀÎ¼âÇÏ±â -->
                      </td>
                    </tr>
                  </table></td>
              </tr>
            </table>
			</div> 
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