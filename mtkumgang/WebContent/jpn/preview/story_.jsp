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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>::: Mt.Kumgang Tour :::</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script language="JavaScript" src="<%=imageServer%>/jpn_img/inc/java.js"></script>
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
        <%@ include file="/jpn/include/preview/tour_preview_top_utf8.jsp" %>
		<!-------- top area / -------->
		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0"> 
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="/jpn/include/preview/tour_preview_left_utf8.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/jpn_img/preview/img_preview02.gif"></td>
						<td align="right" class="linemap">&nbsp;</td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				
            <table width="690" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr> 
                <td height="19" colspan="3"><img src="<%=imageServer%>/jpn_img/preview/img_top_preview02.gif"></td>
              </tr>
              <tr> 
                <td height="41">&nbsp;</td>
              </tr>
              <tr> 
                <td width="213"><img src="<%=imageServer%>/jpn_img/preview/img_history01.jpg"></td>
                <td width="21"></td>
                <td width="456"><img src="<%=imageServer%>/jpn_img/preview/img_history01.gif"></td>
              </tr>
              <tr> 
                <td height="20"></td>
              </tr>
              <tr> 
                <td><img src="<%=imageServer%>/jpn_img/preview/img_history02.jpg"></td>
                <td></td>
                <td><img src="<%=imageServer%>/jpn_img/preview/img_history02.gif"></td>
              </tr>
              <tr> 
                <td height="20"></td>
              </tr>
              <tr> 
                <td><img src="<%=imageServer%>/jpn_img/preview/img_history02.jpg"></td>
                <td></td>
                <td><img src="<%=imageServer%>/jpn_img/preview/img_history03.gif"></td>
              </tr>
            </table>
            <table width="690" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td style="padding: 50  0  10 0 "><img src="<%=imageServer%>/jpn_img/preview/txt_history00.gif"></td>
              </tr>
            </table>
            <table width="690" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="80" rowspan="4"  style="padding-top:38"><img src="<%=imageServer%>/jpn_img/preview/2006.gif"></td>
                <td width="16" rowspan="4"></td>
                <td width="32" valign="bottom" style="padding-top:38"><strong>07.17</strong></td>
                <td width="43" rowspan="4"></td>
                <td rowspan="2" style="padding-top:38">花津浦・牙山休憩所, 外金剛ホテル会館 <br></td>
              </tr>
              <tr>
                <td align="left">&nbsp;</td>
              </tr>
              <tr>
                <td align="left"><strong>05.27</strong></td>
                <td align="left">内金剛観光コース踏査</td>
              </tr>
              <tr>
                <td align="left"><strong>04.28 </strong></td>
                <td align="left">第24回 MBC創作動揺祭  </td>
              </tr>
              <tr>
                <td height="31" colspan="5">&nbsp;</td>
              </tr>
              <tr>
                <td rowspan="12" valign="top"><img src="<%=imageServer%>/jpn_img/preview/2005.gif"></td>
                <td rowspan="12">&nbsp;</td>
                <td valign="top"><strong>10.04</strong></td>
                <td rowspan="12">&nbsp;</td>
                <td>第86回 ウルサン全国体全聖火採火 </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td valign="top"><strong>09.01</strong></td>
                <td>玉流館, ビーチホテル, オンジョンカク東館会館 </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><strong>08.31</strong></td>
                <td>離散家族面会所着工</td>
              </tr>
              <tr>
                <td valign="top"><strong>07.17</strong></td>
                <td>ヒョンジョンウン会長 金正日国防委員長面談 </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td valign="top"><strong>06.08</strong></td>
                <td>‘金剛山観光100万名突破’記念音楽会 </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td valign="top"><strong>04.01</strong></td>
                <td>南北新婚夫婦、木を植える行事 </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><strong>02</strong></td>
                <td>映画 ‘肝の大きい家族(ガンクン家族)’ 撮影 </td>
              </tr>
              <tr>
                <td height="31" colspan="5">&nbsp;</td>
              </tr>
              <tr>
                <td rowspan="4" valign="top"><img src="<%=imageServer%>/jpn_img/preview/2004.gif"></td>
                <td rowspan="4">&nbsp;</td>
                <td><strong>11.20 </strong></td>
                <td rowspan="4">&nbsp;</td>
                <td>神溪寺大雄殿諾成  </td>
              </tr>
              <tr>
                <td><strong>11.19</strong></td>
                <td>金剛山ゴルフ場着工</td>
              </tr>
              <tr>
                <td><strong>09.07</strong></td>
                <td>忠北全国体全聖火採火</td>
              </tr>
              <tr>
                <td><strong>07.02</strong></td>
                <td>金剛山ホテル会館 </td>
              </tr>
              <tr>
                <td height="31">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><img src="<%=imageServer%>/jpn_img/preview/2003.gif"></td>
                <td>&nbsp;</td>
                <td valign="top"><strong>09</strong></td>
                <td>&nbsp;</td>
                <td valign="top">金剛山陸路観光実施<br></td>
              </tr>
              <tr>
                <td height="31">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><img src="<%=imageServer%>/jpn_img/preview/2002.gif"></td>
                <td>&nbsp;</td>
                <td valign="top"><strong>04~現在</strong> </td>
                <td>&nbsp;</td>
                <td valign="top">現在第4次 – 14次南北離散家族互逢行事 </td>
              </tr>
              <tr>
                <td height="31">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><img src="<%=imageServer%>/jpn_img/preview/2001.gif"></td>
                <td>&nbsp;</td>
                <td valign="top"><strong>08.14</strong></td>
                <td>&nbsp;</td>
                <td valign="top">国際モータサイクルツアー大会</td>
              </tr>
              <tr>
                <td height="31">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td rowspan="4" valign="top"><img src="<%=imageServer%>/jpn_img/preview/2000.gif"></td>
                <td rowspan="4">&nbsp;</td>
                <td><strong>09.30</strong></td>
                <td rowspan="4">&nbsp;</td>
                <td>金正日国方委員長金剛山訪問</td>
              </tr>
              <tr>
                <td><strong>06.15</strong></td>
                <td>南北正常会談</td>
              </tr>
              <tr>
                <td><strong>05.24</strong></td>
                <td>高城埠頭巡行竣工</td>
              </tr>
              <tr>
                <td><strong>05.08</strong></td>
                <td>ミスコリア選抜大会</td>
              </tr>
              <tr>
                <td height="31"></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td rowspan="3" valign="top"><img src="<%=imageServer%>/jpn_img/preview/1998.gif"></td>
                <td rowspan="3">&nbsp;</td>
                <td valign="top"><strong>11.18 </strong></td>
                <td rowspan="3">&nbsp;</td>
                <td>現代金剛号初の出航</td>
              </tr>
              <tr>
                <td valign="top"><strong>10.30</strong></td>
                <td>鄭周永名誉会長　金正一国防委員長面談 </td>
              </tr>
              <tr>
                <td valign="top"><strong>06.16</strong></td>
                <td>鄭周永名誉会長　牛追い訪北 </td>
              </tr>
              <tr>
                <td height="31">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td rowspan="2" valign="top"><img src="<%=imageServer%>/jpn_img/preview/1989.gif"></td>
                <td rowspan="2">&nbsp;</td>
                <td valign="top"><strong>01.31</strong></td>
                <td rowspan="2">&nbsp;</td>
                <td>金剛山観光開発議定書締結(ピョンヤン) </td>
              </tr>
              <tr>
                <td valign="top"><strong>01.24</strong></td>
                <td>鄭周永名誉会長最初の訪問/ 金剛山観光及びシベリア共同開発議定書締結 
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
        <%@ include file="/jpn/include/footer_utf8.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>
</body>
</html>