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
                      <td width="102" height="28"><a href="packup01.jsp"><img src="<%=imageServer%>/eng_img/start/tab_start0101.gif" border="0" onMouseOver="this.src='<%=imageServer%>/eng_img/start/tab_start0101_on.gif'" onMouseOut="this.src='<%=imageServer%>/eng_img/start/tab_start0101.gif'"></a></td>
							<td width="102"><img src="<%=imageServer%>/eng_img/start/tab_start0102_on.gif"></td>
							<td width="2"><img src="<%=imageServer%>/eng_img/start/tab_start0111.gif"></td>
							<td width="482" background="<%=imageServer%>/eng_img/start/tab_start0112.gif"></td>
							<td width="2"><img src="<%=imageServer%>/eng_img/start/tab_start0113.gif"></td>
                    </tr>
                  </table>
                  <table width="690" class="bg_lgreen" cellpadding="0" cellspacing="0" border="0">
                    <tr> 
                        <td  height="33" class="txt_dgreen" style="padding-top:10px; padding-left:15px; padding-bottom:10px;">1. Binoculars/telescope 
                          with a magnification of more than 10x, a camera with 
                          a telescopic lens more than 160mm,<br>
																										&nbsp;&nbsp&nbsp;a camcorder with a zoom lens more than 24x <br>
                          2. Drugs and other products of which the ingredients 
                          and uses are unknown because of a lack of a description 
                          or <br>
                          &nbsp;&nbsp&nbsp;trademark (except those for personal medicinal purposes)<br>
                          3. Printed materials, paints, inscribed plates, recorded 
                          tapes <br>
                          4. Counterfeit notes<br>
                          5. Toxic substances, drugs and other harmful chemicals 
                          other than those used for personal medicinal purposes<br>
                          6. Firearms, weapons, bullets, explosives, military 
                          goods, radioactive materials, flammables<br>
                          7. Walkie-talkies and its parts <br>
                          8. Things from an area where there is an epidemic <br>
                          9. Other things not appropriate for the tour</td>
                    </tr>
                  </table>
                  <!-- ÅÇ¸Þ´º / -->
                </td>
              </tr>
              <tr>
                <td height="30"><table width="690" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="33">&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td width="115"><img src="<%=imageServer%>/eng_img/start/img_start0121.jpg"></td>
                      <td width="19"></td>
                      <td><img src="<%=imageServer%>/eng_img/start/txt_start0121.gif"></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td><img src="<%=imageServer%>/eng_img/start/img_start0122.jpg"></td>
                      <td>&nbsp;</td>
                      <td><img src="<%=imageServer%>/eng_img/start/txt_start0122.gif"></td>
                    </tr>
                  </table></td>
              </tr>
              <tr> 
                <td> <table width="690" border="0" align="right" cellpadding="0" cellspacing="0">
                      <tr> 
                        <td height="10"></td>
                      </tr>
                      <tr> 
                        <td align="right"> <a href="javascript:;" onClick="fc_print()"><img src="<%=imageServer%>/eng_img/start/btn_start_print.gif" class="btn" name=prt id=prt></a> 
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