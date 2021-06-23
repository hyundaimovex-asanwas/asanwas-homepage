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
<script language="JavaScript" src="<%=imageServer%>/jpn_img/inc/java.js"></script>
<script language="javascript"> 
    function fc_print()
    { 
       //document.all.prt.style.display="none";
       var win = window.open("/common/blank.jsp","print","left=-10000,top=-10000,width="+ (document.all.print_area.offsetWidth + 18) + ",height="+document.all.print_area.offsetHeight);
       
       //document.all.prt.style.display = "";
       // window.print();
    } 
</script> 



<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="/jpn/include/start/tour_start_top_utf8.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="/jpn/include/start/tour_start_left_utf8.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/jpn_img/start/tit_start01.gif"></td>
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
                <td><img src="<%=imageServer%>/jpn_img/start/img_top_start01.jpg"></td>
              </tr>
              <tr>
                <td height="10"></td>
              </tr>
              <tr> 
                <td> 
                  <!-- / 탭메뉴 -->
                  <table width="690" cellpadding="0" cellspacing="0" border="0">
                    <tr> 
                      <td width="102" height="28"><a href="packup01.jsp"><img src="<%=imageServer%>/jpn_img/start/tab_start0101.gif" border="0" onMouseOver="this.src='<%=imageServer%>/jpn_img/start/tab_start0101_on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/start/tab_start0101.gif'"></a></td>
							<td width="102"><img src="<%=imageServer%>/jpn_img/start/tab_start0102_on.gif"></td>
							<td width="2"><img src="<%=imageServer%>/jpn_img/start/tab_start0111.gif"></td>
							<td width="482" background="<%=imageServer%>/jpn_img/start/tab_start0112.gif"></td>
							<td width="2"><img src="<%=imageServer%>/jpn_img/start/tab_start0113.gif"></td>
                    </tr>
                  </table>
                  <table width="690" class="bg_lgreen" cellpadding="0" cellspacing="0" border="0">
                    <tr> 
                        <td  height="33" class="txt_dgreen" style="padding-top:10px; padding-left:15px; padding-bottom:10px;">① 10倍率以上の双眼鏡/望遠鏡,160ミリ以上の望遠レンズがついてるカメラ,24倍ズーム(光学基準)以上の<br>
　　ズームレンズがついてるビデオカメラ<br>
② 個人の治療目的のためを除く,商標と説明書がなくその成分と用途が確認できない薬及び商品<br>
③ 観光客の文化生活及び便利目的として認められる種類と数量を除く印刷物,絵,文字板, 録画テープ<br>
④ 偽札<br>
⑤ 医療目的のためをのぞく毒薬,麻薬,その他の有毒性化学物質<br>
⑥ 武器,銃弾,爆発物,軍用品,凶器,放射性物質,引火物質<br>
⑦ 無線機とその付属品<br>
⑧ 伝染病が発生した地域のもの<br>
⑨ その他観光に適合でないもの</td>
                    </tr>
                  </table>
                  <!-- 탭메뉴 / -->
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
                      <td width="115"><img src="<%=imageServer%>/jpn_img/start/img_start0121.jpg"></td>
                      <td width="19"></td>
                      <td><img src="<%=imageServer%>/jpn_img/start/txt_start0121.gif"></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td><img src="<%=imageServer%>/jpn_img/start/img_start0122.jpg"></td>
                      <td>&nbsp;</td>
                      <td><img src="<%=imageServer%>/jpn_img/start/txt_start0122.gif"></td>
                    </tr>
                  </table></td>
              </tr>
              <tr> 
                <td> <table width="690" border="0" align="right" cellpadding="0" cellspacing="0">
                      <tr> 
                        <td height="10"></td>
                      </tr>
                      <tr> 
                        <td align="right"> <a href="javascript:;" onClick="fc_print()"><img src="<%=imageServer%>/jpn_img/start/btn_start_print.gif" class="btn" name=prt id=prt></a> 
                          <!-- 인쇄하기 -->
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
        <%@ include file="/jpn/include/footer_utf8.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>	