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
        <%@ include file="/eng/include/preview/tour_preview_top.jsp" %>
		<!-------- top area / -------->
		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0"> 
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="/eng/include/preview/tour_preview_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/eng_img/preview/img_preview02.gif"></td>
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
                <td height="19" colspan="3"><img src="<%=imageServer%>/eng_img/preview/img_top_preview02.gif"></td>
              </tr>
              <tr> 
                <td height="41">&nbsp;</td>
              </tr>
              <tr> 
                <td width="213"><img src="<%=imageServer%>/eng_img/preview/img_history01.jpg"></td>
                <td width="21"></td>
                <td width="456"><img src="<%=imageServer%>/eng_img/preview/img_history01.gif"></td>
              </tr>
              <tr> 
                <td height="20"></td>
              </tr>
              <tr> 
                <td><img src="<%=imageServer%>/eng_img/preview/img_history02.jpg"></td>
                <td></td>
                <td><img src="<%=imageServer%>/eng_img/preview/img_history02.gif"></td>
              </tr>
              <tr> 
                <td height="20"></td>
              </tr>
              <tr> 
                <td><img src="<%=imageServer%>/eng_img/preview/img_history02.jpg"></td>
                <td></td>
                <td><img src="<%=imageServer%>/eng_img/preview/img_history03.gif"></td>
              </tr>
            </table>
            <table width="690" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td style="padding: 50  0  10 0 "><img src="<%=imageServer%>/eng_img/preview/txt_history00.gif"></td>
              </tr>
            </table>
            <table width="690" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="80" rowspan="4"  style="padding-top:38"><img src="<%=imageServer%>/eng_img/preview/2006.gif"></td>
                <td width="16" rowspan="4"></td>
                <td width="32" valign="bottom" style="padding-top:38"><strong>07.17</strong></td>
                <td width="43" rowspan="4"></td>
                <td rowspan="2" style="padding-top:38">Hwajinpo Asan Rest Area 
                  and Hotel <br>
                  Oekumgang opened. </td>
              </tr>
              <tr> 
                <td align="left">&nbsp;</td>
              </tr>
              <tr> 
                <td align="left"><strong>05.27</strong></td>
                <td align="left">Pilot tour of Inner Mt. Kumgang.</td>
              </tr>
              <tr> 
                <td align="left"><strong>04.28 </strong></td>
                <td align="left">The 24th MBC Children’s Song Festival held.</td>
              </tr>
              <tr> 
                <td height="31" colspan="5">&nbsp;</td>
              </tr>
              <tr> 
                <td rowspan="12" valign="top"><img src="<%=imageServer%>/eng_img/preview/2005.gif"></td>
                <td rowspan="12">&nbsp;</td>
                <td valign="top"><strong>10.04</strong></td>
                <td rowspan="12">&nbsp;</td>
                <td>The sacred fire of the 86th Ulsan National <br>
                  Sports Festival was lit.</td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td valign="top"><strong>09.01</strong></td>
                <td>Okryukwan, Beach Hotel and East <br>
                  Onjeonggak opened.</td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td><strong>08.31</strong></td>
                <td>Construction of the Family Reunion Center initiated.</td>
              </tr>
              <tr> 
                <td valign="top"><strong>07.17</strong></td>
                <td>Chairwoman, Hyun Jeong-eun met North <br>
                  Korean leader, Kim Jong-il</td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td valign="top"><strong>06.08</strong></td>
                <td>Open Concert held in celebration of the <br>
                  millionth visit to Mt. Kumgang.</td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td valign="top"><strong>04.01</strong></td>
                <td>Tree Planting Event with newly weds from <br>
                  South and North participants. </td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td><strong>02</strong></td>
                <td>Movie entitled ‘The Daring Family’ filmed.</td>
              </tr>
              <tr> 
                <td height="31" colspan="5">&nbsp; </td>
              </tr>
              <tr> 
                <td rowspan="4" valign="top"><img src="<%=imageServer%>/eng_img/preview/2004.gif"></td>
                <td rowspan="4">&nbsp;</td>
                <td><strong>11.20 </strong></td>
                <td rowspan="4">&nbsp;</td>
                <td>Daewoongjeon, the main building of Shingyesa temple was built. 
                </td>
              </tr>
              <tr> 
                <td><strong>11.19</strong></td>
                <td>Construction of Mt. Kumgang Golf Course started. </td>
              </tr>
              <tr> 
                <td><strong>09.07</strong></td>
                <td>The sacred fire of the Chungbuk National Sports Festival was 
                  lit. </td>
              </tr>
              <tr> 
                <td><strong>07.02</strong></td>
                <td>Hotel Kumgangsan opened. </td>
              </tr>
              <tr> 
                <td height="31">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td><img src="<%=imageServer%>/eng_img/preview/2003.gif"></td>
                <td>&nbsp;</td>
                <td valign="top"><strong>09</strong></td>
                <td>&nbsp;</td>
                <td valign="top">Overland tour to Mt. Kumgang was launched. <br></td>
              </tr>
              <tr> 
                <td height="31">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td><img src="<%=imageServer%>/eng_img/preview/2002.gif"></td>
                <td>&nbsp;</td>
                <td valign="top"><strong>04~present</strong> </td>
                <td>&nbsp;</td>
                <td valign="top">The 4th~14th Family Reunion are held. </td>
              </tr>
              <tr> 
                <td height="31">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td><img src="<%=imageServer%>/eng_img/preview/2001.gif"></td>
                <td>&nbsp;</td>
                <td valign="top"><strong>08.14</strong></td>
                <td>&nbsp;</td>
                <td valign="top">International Motorcycle Touring Event hold.</td>
              </tr>
              <tr> 
                <td height="31">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td rowspan="4" valign="top"><img src="<%=imageServer%>/eng_img/preview/2000.gif"></td>
                <td rowspan="4">&nbsp;</td>
                <td><strong>09.30</strong></td>
                <td rowspan="4">&nbsp;</td>
                <td>North Korean leader, Kim Jong-il visited Mt. Kumgang. </td>
              </tr>
              <tr> 
                <td><strong>06.15</strong></td>
                <td>Inter-Korean Summit was held.</td>
              </tr>
              <tr> 
                <td><strong>05.24</strong></td>
                <td>The pier of the Kosung Port constructed</td>
              </tr>
              <tr> 
                <td><strong>05.08</strong></td>
                <td>Miss Korea Contest was held.</td>
              </tr>
              <tr> 
                <td height="31"></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td rowspan="3" valign="top"><img src="<%=imageServer%>/eng_img/preview/1998.gif"></td>
                <td rowspan="3">&nbsp;</td>
                <td valign="top"><strong>11.18 </strong></td>
                <td rowspan="3">&nbsp;</td>
                <td>Cruise tour to Mt. Kumgang opened Maiden voyage of ‘Hyundai 
                  Kumgang’ cruise liner </td>
              </tr>
              <tr> 
                <td valign="top"><strong>10.30</strong></td>
                <td>The late Hyundai Group Founder, Chung, Ju-yung met North Korean 
                  leader Kim Jong-il </td>
              </tr>
              <tr> 
                <td valign="top"><strong>06.16</strong></td>
                <td>The late Hyundai Group Founder, Chung Ju-yung visited North 
                  Korea bringing a symbolic gift - a herd of cattle</td>
              </tr>
              <tr> 
                <td height="31">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td rowspan="2" valign="top"><img src="<%=imageServer%>/eng_img/preview/1989.gif"></td>
                <td rowspan="2">&nbsp;</td>
                <td valign="top"><strong>01.31</strong></td>
                <td rowspan="2">&nbsp;</td>
                <td>The Mt. Kumgang Development Protocol concluded in Pyeongyang. 
                </td>
              </tr>
              <tr> 
                <td valign="top"><strong>01.24</strong></td>
                <td>The late Hyundai Group Founder, Chung Ju-yung made a first 
                  visit to North Korea and agreed in principle on Mt. Kumgang 
                  tourism business and Joint Development of Siberia</td>
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