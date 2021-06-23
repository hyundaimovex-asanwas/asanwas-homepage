<%@ page language="java" contentType="text/html; charset=utf-8"%> 
<%@ include file="/common/properties_utf8.jsp" %> 
<%@ include file="/common/session_utf8.jsp" %>
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
<script language="JavaScript" src="<%=imageServer%>/chn_img/inc/java.js"></script>
<script language="javascript"> 
    function fc_print()
    { 
       //document.all.prt.style.display="none";
       var win = window.open("/common/blank.jsp","print","left=-10000,top=-10000,width="+ (document.all.print_area.offsetWidth + 18) + ",height="+document.all.print_area.offsetHeight);
       
       //document.all.prt.style.display = "";
       // window.print();
    } 
</script> 



<style type="text/css">
<!--
.style1 {font-family: SimHei}
-->
</style>
</head>
<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="/chn/include/start/tour_start_top_utf8.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="/chn/include/start/tour_start_left_utf8.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/chn_img/start/tit_start01.gif"></td>
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
                <td><img src="<%=imageServer%>/chn_img/start/img_top_start01.jpg"></td>
              </tr>
              <tr>
                <td height="10"></td>
              </tr>
              <tr> 
                <td> 
                  <!-- / Ǹ޴ -->
                  <table width="690" cellpadding="0" cellspacing="0" border="0">
                    <tr> 
                      <td width="102" height="28"><a href="packup01.jsp"><img src="<%=imageServer%>/chn_img/start/tab_start0101.gif" border="0" onMouseOver="this.src='<%=imageServer%>/chn_img/start/tab_start0101_on.gif'" onMouseOut="this.src='<%=imageServer%>/chn_img/start/tab_start0101.gif'"></a></td>
							<td width="102"><img src="<%=imageServer%>/chn_img/start/tab_start0102_on.gif"></td>
							<td width="2"><img src="<%=imageServer%>/chn_img/start/tab_start0111.gif"></td>
							<td width="482" background="<%=imageServer%>/chn_img/start/tab_start0112.gif"></td>
							<td width="2"><img src="<%=imageServer%>/chn_img/start/tab_start0113.gif"></td>
                    </tr>
                  </table>
                  <table width="690" class="bg_lgreen" cellpadding="0" cellspacing="0" border="0">
                    <tr> 
                        <td  height="33" class="txt_dgreen style1" style="padding-top:10px; padding-left:15px; padding-bottom:10px;">① 10倍率以上的双眼望远镜，带有160mm以上望远镜头的照相机，24倍以上光学缩放镜头摄像机<br>
                        ② 除了个人治疗目的以外，无商标和说明书而不可确认其成分和用途的药品和商品<br>
                        ③ 游客个人文化生活及旅行方便为目的指定种类和数量以外的印数品、图纸、录像带<br>
                        ④ 伪造钞票<br>
                        ⑤ 除医疗目的以外的毒药、麻醉药以及其它毒性化学物质<br>
                        ⑥ 武器、弹药、爆发物、军用品、凶器、放射性物质、引火物质<br>
                        ⑦ 无限通信设备及其零部件<br>
                        ⑧ 传染病发病地区的物品<br>
                        ⑨ 其它不适合于观光的物品 </td>
                    </tr>
                  </table>
                  <!-- Ǹ޴ / -->
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
                      <td width="115"><img src="<%=imageServer%>/chn_img/start/img_start0121.jpg"></td>
                      <td width="19"></td>
                      <td><img src="<%=imageServer%>/chn_img/start/txt_start0121.gif"></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td><img src="<%=imageServer%>/chn_img/start/img_start0122.jpg"></td>
                      <td>&nbsp;</td>
                      <td><img src="<%=imageServer%>/chn_img/start/txt_start0122.gif"></td>
                    </tr>
                  </table></td>
              </tr>
              <tr> 
                <td> <table width="690" border="0" align="right" cellpadding="0" cellspacing="0">
                      <tr> 
                        <td height="10"></td>
                      </tr>
                      <tr> 
                        <td align="right"> <a href="javascript:;" onClick="fc_print()"><img src="<%=imageServer%>/chn_img/start/btn_start_print.gif" class="btn" name=prt id=prt></a> 
                          <!-- μϱ -->
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
        <%@ include file="/chn/include/footer_utf8.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>	