<%@ page language="java" contentType="text/html; charset=utf-8"%> 
<%@ include file="/common/properties_utf8.jsp" %> 
<%@ include file="/common/session_utf8.jsp" %>
<%
String pageNum = "1";
String subNum = "1";
String McNum = "2";
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
<script language="JavaScript" type="text/JavaScript">
<!--
/* function autoblur(){
if(event.srcElement.tagName == "A") document.body.focus();
}
document.onfocusin = autoblur;
*/
/*  High-peak season/ Peak season/ Low season/ 레이어 페이지 */
function sea_show_01()
{
 
	document.all("season_01").style.display="";
	document.all("season_02").style.display="none";
	document.all("season_03").style.display="none";
	document.all("season_04").style.display="none";
}

function sea_show_02()
{
	document.all("season_01").style.display="none";
	document.all("season_02").style.display="";
	document.all("season_03").style.display="none";
	document.all("season_04").style.display="none";
}

function sea_show_03()
{
	document.all("season_01").style.display="none";
	document.all("season_02").style.display="none";
	document.all("season_03").style.display="";	
	document.all("season_04").style.display="none";
}

function sea_show_04()
{
	document.all("season_01").style.display="none";
	document.all("season_02").style.display="none";
	document.all("season_03").style.display="none";	
	document.all("season_04").style.display="";
}

/*SHOW 01*/

function sub_show_01()
{
	document.all("sub_season_01").style.display="";
	document.all("sub_season_02").style.display="none";
	document.all("sub_season_03").style.display="none";
}

function sub_show_02()
{
	document.all("sub_season_01").style.display="none";
	document.all("sub_season_02").style.display="";
	document.all("sub_season_03").style.display="none";
}

function sub_show_03()
{
	document.all("sub_season_01").style.display="none";
	document.all("sub_season_02").style.display="none";
	document.all("sub_season_03").style.display="";	
}
/*SHOW 02*/
function sub_show_04()
{
	document.all("sub_season_04").style.display="";
	document.all("sub_season_05").style.display="none";
	document.all("sub_season_06").style.display="none";
}

function sub_show_05()
{
	document.all("sub_season_04").style.display="none";
	document.all("sub_season_05").style.display="";
	document.all("sub_season_06").style.display="none";
}

function sub_show_06()
{
	document.all("sub_season_04").style.display="none";
	document.all("sub_season_05").style.display="none";
	document.all("sub_season_06").style.display="";	
}

/*SHOW 03*/
function sub_show_07()
{
	document.all("sub_season_07").style.display="";
	document.all("sub_season_08").style.display="none";
	document.all("sub_season_09").style.display="none";
}

function sub_show_08()
{
	document.all("sub_season_07").style.display="none";
	document.all("sub_season_08").style.display="";
	document.all("sub_season_09").style.display="none";
}

function sub_show_09()
{
	document.all("sub_season_07").style.display="none";
	document.all("sub_season_08").style.display="none";
	document.all("sub_season_09").style.display="";	
}

/*SHOW 04*/
function sub_show_10()
{
	document.all("sub_season_10").style.display="";
	document.all("sub_season_11").style.display="none";
	document.all("sub_season_12").style.display="none";
}

function sub_show_11()
{
	document.all("sub_season_10").style.display="none";
	document.all("sub_season_11").style.display="";
	document.all("sub_season_12").style.display="none";
}

function sub_show_12()
{
	document.all("sub_season_10").style.display="none";
	document.all("sub_season_11").style.display="none";
	document.all("sub_season_12").style.display="";	
}


/*
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);*/
//-->
</script>
<style type="text/css">
<!--
.style3 {font-weight: bold}
.style13 {font-weight: bold}
.style17 {font-weight: bold}
.style22 {font-weight: bold}
.style40 {color: #993399}
.style41 {font-family: SimHei}
-->
</style>
</head>

<body>
<DIV ID="objContents">
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="/jpn/include/reservation/tour_reservation_top_utf8.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
          <tr valign="top">
            <td width="174"><!--  left menu flash -->
                <%@ include file="/jpn/include/reservation/tour_reservation_left_utf8.jsp" %>
                <!--  left menu flash -->            </td>
            <td><strong>
            <!-- / content  -->
              </strong>
							<span id="d1">
              <table width="710" cellpadding="0" cellspacing="0" border="0">
                <tr>
                  <td class="lpad_20 style3"><!--/ TITLE & LINEMAP -->
                      <table width="690" cellpadding="0" cellspacing="0">
                        <tr>
                          <td height="54"><img src="<%=imageServer%>/jpn_img/apply/tit_app03.gif"></td>
                        </tr>
                      </table>
                    <!-- TITLE & LINEMAP/ -->                    </td>
                </tr>
                <tr>
                  <td height="1" class="line_g"></td>
                </tr>
              </table>
              <table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
                  <tr>
                    <td height="22"></td>
                  </tr>
                  <tr>
                    <td><strong><img src="<%=imageServer%>/jpn_img/apply/top_txt_app03.gif"></strong></td>
                  </tr>
                  <tr>
                    <td style="padding-left:73px"><strong>
                    <!-- / 비수기,성수기, 준성수기, 최성수기 기간표 그래프 -->
                      <img src="<%=imageServer%>/jpn_img/apply/tab_period01.gif"><br>
                    &nbsp;
                      <!-- 비수기,성수기, 준성수기, 최성수기 기간표 그래프 / -->                    
                      </strong></td>
                  </tr><td><div><div style='display:' id='season_01'><table><tr>
                    <td class="style13"><!-- / 시즌선택 -->
                      <!-- / 시즌선택 -->
<table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td height="25" valign="top"><img src="<%=imageServer%>/jpn_img/apply/stit_seasonchoice.gif" hspace="5"></td>
                          </tr>
                          <tr>
                            <td><a href="javascript:sea_show_01();"><img src="<%=imageServer%>/jpn_img/apply/tab_day01on.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day01on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day01on.gif'"></a><a href="javascript:sea_show_02();"><img src="<%=imageServer%>/jpn_img/apply/tab_day02.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day02on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day02.gif'"></a><a href="javascript:sea_show_03();"><img src="<%=imageServer%>/jpn_img/apply/tab_day05.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day05on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day05.gif'"></a><img src="<%=imageServer%>/jpn_img/apply/tab_day_rig.gif">
                            </td>
                          </tr>
                          <tr>
                            <td height="33" class="bg_lgreen lpad_15 txt_dgreen"><img src="<%=imageServer%>/jpn_img/apply/bu_dgreen_rec.gif" align="absmiddle">
                                <span class="style41">ハイシーズン期間</span> : 7.27~8.11 / 9.28~10.27                          </tr>
                      </table>
                    <!-- 시즌선택 / -->                    </td>
                  </tr>
                  <tr>
                    <td height="37"></td>
                  </tr>
                  <tr>
                    <td valign="top" class="style17"><!-- / 기간 테이블 -->
                        <!-- 기간 테이블 탭 --><div><div style='display:' id='sub_season_01'>
                        <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td>
                                <img src="<%=imageServer%>/jpn_img/apply/tab_pricetab01on.gif"> 
								<a href="javascript:sub_show_02();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab02.gif"></a> 
								<a href="javascript:sub_show_03();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab03.gif"></a>
                            </td>
                            <!--<td align="right" valign="bottom" class="rpad_10">(단위 : 원,1인)</td>-->
                          </tr>
                        </table>
                      <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td height="2" colspan="9" class="line_dg"></td>
                          </tr>
                          <tr align="center">
                            <td width="79" height="28"><img src="<%=imageServer%>/jpn_img/apply/txt_price01.gif">
                                <!-- 객실명 --></td>
                            <td width="115"><img src="<%=imageServer%>/jpn_img/apply/txt_price02.gif">
                                <!-- 호텔명 --></td>
                            <td width="51"><img src="<%=imageServer%>/jpn_img/apply/txt_price03.gif">
                                <!-- 정원 --></td>
                            <td width="70"><img src="<%=imageServer%>/jpn_img/apply/txt_price04.gif">
                                <!-- 성인 --></td>
                            <td width="68"><img src="<%=imageServer%>/jpn_img/apply/txt_price05.gif">
                                <!-- 대학생 --></td>
                            <td width="95"><img src="<%=imageServer%>/jpn_img/apply/txt_price06.gif">
                                <!-- 중고등 --></td>
                            <td width="74"><img src="<%=imageServer%>/jpn_img/apply/txt_price07.gif">
                                <!-- 초등 --></td>
                            <td width="72"><img src="<%=imageServer%>/jpn_img/apply/txt_price08.gif">
                                <!-- 아동 --></td>
                            <td width="66"><img src="<%=imageServer%>/jpn_img/apply/txt_price09.gif">
                                <!-- 유아 --></td>
                          </tr>
                          <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                          </tr>
                      </table>
                      <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="79" align="center">
                        <col width="611">
                          
                  <tr>
                    <td class="cglg"><span class="style41"><strong>金剛山ホテル本館</strong></span></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                                             <tr>
                          <td height="23" class="cglg style41">デラックス(ダブル)
 </td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg style41">デラックス（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">ロイヤルスイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">1,250,000</td>
                          <td class="cglg">1,250,000</td>
                          <td class="cglg">1,060,000</td>
                          <td class="cglg">940,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
                        <tr>
                          <td height="23" class="cglg style41">スイート（オンドル）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">590,000</td>
                          <td class="cglg">590,000</td>
                          <td class="cglg">500,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg style41">スイート（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">590,000</td>
                          <td class="cglg">590,000</td>
                          <td class="cglg">500,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">スタンダード（オンドル）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">スタンダード（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>

                    </table></td>
                  </tr>
				  <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><span class="style41"><strong>金剛山ホテル別館 
                    </strong></span></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg style41">スイートオンドル
</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">一般室オンドル
</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>						
                    </table></td>
                  </tr>

				    <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><span class="style41"><strong>ファミリビーチホテル</strong></span></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg style41">ロイヤルスイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">1,250,000</td>
                          <td class="cglg">1,250,000</td>
                          <td class="cglg">1,060,000</td>
                          <td class="cglg">940,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">ビーチ家族室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">460,000</td>
                          <td class="cglg">400,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">ビーチ家族室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">ビーチコンドミニアムＢ</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">ビーチコンドミニアムＢ</td>
                          <td class="cglg">3~6</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">ビーチコンドミニアムＣ</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">460,000</td>
                          <td class="cglg">400,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">ビーチコンドミニアムＣ</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">ビーチコンドミニアムＣ </td>
                          <td class="cglg">5~6</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">一般室オンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">一般室ツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
                    </table></td>
                  </tr>

				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong><span class="style41">外金剛ホテル</span><br>
                    </strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg style41">デラックススイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">590,000</td>
                          <td class="cglg">590,000</td>
                          <td class="cglg">500,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">スイートダブル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">460,000</td>
                          <td class="cglg">400,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">スイートツイン </td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">460,000</td>
                          <td class="cglg">400,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">スタンダードオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">スタンダードツイン </td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">ジュニアオンドル</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">450,000</td>
                          <td class="cglg">450,000</td>
                          <td class="cglg">380,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
                    </table></td>
                  </tr>

				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><span class="style41"><strong>海金剛ホテル</strong></span></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg style41">家族室</td>
                          <td class="cglg">2~4</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">貴賓室</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">460,000</td>
                          <td class="cglg">400,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">デラックス</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">一般ツイン </td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
                    </table></td>
                  </tr>
				  
				  <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><span class="style41"><strong>金剛ペンションタウン  
                    </strong></span></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg style41">ペンション A </td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">470,000</td>
                          <td class="cglg">470,000</td>
                          <td class="cglg">400,000</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">ペンション A </td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">ペンション B </td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">ペンション B </td>
                          <td class="cglg">3~6</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">ペンション C </td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">460,000</td>
                          <td class="cglg">400,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">ペンション C </td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg style41">ペンション C </td>
                          <td class="cglg">5~6</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
                    </table></td>
                  </tr>

				  <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><span class="style41"><strong>温泉ビリッジ </strong></span></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg style41">温泉ビリッジ</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">450,000</td>
                          <td class="cglg">450,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg"><span class="cglg style41">温泉ビリッジ</span></td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
                    </table></td>
                  </tr>
				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><span class="style41"><strong>九龍町 </strong></span></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg style41">九龍一般室 </td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">450,000</td>
                          <td class="cglg">450,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg"><span class="cglg style41">九龍一般室</span></td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
                    </table></td>
                  </tr>

				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><span class="style41"><strong>キャンピングカー </strong></span></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg style41">キャンピングカー2人室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">450,000</td>
                          <td class="cglg">450,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						<tr>
                          <td height="23" class="cglg"><span class="cglg style41">キャンピングカー２人室</span></td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
                    </table></td>
                  </tr>


                  <tr>
                    <td height="2" colspan="2" class="line_dg"></td>
                  </tr>
                 
              </table> </div>
<div style='display:none;' id='sub_season_02'>
<table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td>
                                <a href="javascript:sub_show_01();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab01.gif"></a>
								<img src="<%=imageServer%>/jpn_img/apply/tab_pricetab02on.gif"> 
								<a href="javascript:sub_show_03();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab03.gif"></a>
                            </td>
                            <!--<td align="right" valign="bottom" class="rpad_10">(단위 : 원,1인)</td>-->
                          </tr>
                        </table>
                      <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td height="2" colspan="9" class="line_dg"></td>
                          </tr>
                          <tr align="center">
                            <td width="79" height="28"><img src="<%=imageServer%>/jpn_img/apply/txt_price01.gif">
                                <!-- 객실명 --></td>
                            <td width="115"><img src="<%=imageServer%>/jpn_img/apply/txt_price02.gif">
                                <!-- 호텔명 --></td>
                            <td width="51"><img src="<%=imageServer%>/jpn_img/apply/txt_price03.gif">
                                <!-- 정원 --></td>
                            <td width="70"><img src="<%=imageServer%>/jpn_img/apply/txt_price04.gif">
                                <!-- 성인 --></td>
                            <td width="68"><img src="<%=imageServer%>/jpn_img/apply/txt_price05.gif">
                                <!-- 대학생 --></td>
                            <td width="95"><img src="<%=imageServer%>/jpn_img/apply/txt_price06.gif">
                                <!-- 중고등 --></td>
                            <td width="74"><img src="<%=imageServer%>/jpn_img/apply/txt_price07.gif">
                                <!-- 초등 --></td>
                            <td width="72"><img src="<%=imageServer%>/jpn_img/apply/txt_price08.gif">
                                <!-- 아동 --></td>
                            <td width="66"><img src="<%=imageServer%>/jpn_img/apply/txt_price09.gif">
                                <!-- 유아 --></td>
                          </tr>
                          <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                          </tr>
                      </table>
                      <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="79" align="center">
                        <col width="611">
                          
                  <tr>
                    <td class="cglg"><strong>金剛山ホテル本館</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                                             <tr>
                          <td height="23" class="cglg">デラックス(ダブル)</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">デラックス（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ロイヤルスイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">690,000</td>
                          <td class="cglg">690,000</td>
                          <td class="cglg">590,000</td>
                          <td class="cglg">520,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                        <tr>
                          <td height="23" class="cglg">スイート（オンドル）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイート（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダード（オンドル）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダード（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>

                    </table></td>
                  </tr>
				  <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>金剛山ホテル別館 
</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">スイートオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室オンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>						
                    </table></td>
                  </tr>

				    <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>ファミリビーチホテル</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">ロイヤルスイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">690,000</td>
                          <td class="cglg">690,000</td>
                          <td class="cglg">590,000</td>
                          <td class="cglg">520,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチ家族室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチ家族室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム B</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム B</td>
                          <td class="cglg">3~6</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">5~6</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室オンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室ツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>外金剛ホテル<br></strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">デラックススイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイートダブル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイートツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダードオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダードツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ジュニアオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>海金剛ホテル
</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">家族室</td>
                          <td class="cglg">2~4</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">貴賓室</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">デラックス</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般ツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>
				  
				  <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>金剛ペンションタウン 
</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">ペンション A</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション A</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">230,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション B</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション B</td>
                          <td class="cglg">3~6</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">5~6</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				  <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>温泉ビリッジ</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">温泉ビリッジ</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">温泉ビリッジ</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>
				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>九龍町 </strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">九龍一般室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">九龍一般室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>キャンピングカー</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">キャンピングカー2人室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">キャンピングカー2人室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="2" colspan="2" class="line_dg"></td>
                  </tr>
                 
              </table></div>
			  <div style='display:none;' id='sub_season_03'>
<table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td>
                                <a href="javascript:sub_show_01();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab01.gif"></a>
								<a href="javascript:sub_show_02();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab02.gif"></a> 
								<img src="<%=imageServer%>/jpn_img/apply/tab_pricetab03on.gif">
                            </td>
                            <!--<td align="right" valign="bottom" class="rpad_10">(단위 : 원,1인)</td>-->
                          </tr>
                        </table>
                      <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td height="2" colspan="9" class="line_dg"></td>
                          </tr>
                          <tr align="center">
                            <td width="79" height="28"><img src="<%=imageServer%>/jpn_img/apply/txt_price01.gif">
                                <!-- 객실명 --></td>
                            <td width="115"><img src="<%=imageServer%>/jpn_img/apply/txt_price02.gif">
                                <!-- 호텔명 --></td>
                            <td width="51"><img src="<%=imageServer%>/jpn_img/apply/txt_price03.gif">
                                <!-- 정원 --></td>
                            <td width="70"><img src="<%=imageServer%>/jpn_img/apply/txt_price04.gif">
                                <!-- 성인 --></td>
                            <td width="68"><img src="<%=imageServer%>/jpn_img/apply/txt_price05.gif">
                                <!-- 대학생 --></td>
                            <td width="95"><img src="<%=imageServer%>/jpn_img/apply/txt_price06.gif">
                                <!-- 중고등 --></td>
                            <td width="74"><img src="<%=imageServer%>/jpn_img/apply/txt_price07.gif">
                                <!-- 초등 --></td>
                            <td width="72"><img src="<%=imageServer%>/jpn_img/apply/txt_price08.gif">
                                <!-- 아동 --></td>
                            <td width="66"><img src="<%=imageServer%>/jpn_img/apply/txt_price09.gif">
                                <!-- 유아 --></td>
                          </tr>
                          <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                          </tr>
                      </table>
                      <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="79" align="center">
                        <col width="611">
                          
                  <tr>
                    <td class="cglg"><strong>Same-day hotel</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                                             <tr>
                          <td height="23" class="cglg">Same-day tour</td>
                          <td class="cglg">1~1</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">150,000</td>
                          <td class="cglg">150,000</td>
                          <td class="cglg">70,000</td>
                          <td class="cglg">60,000</td>
                        </tr>

                    </table></td>
                  </tr>
                  <tr>
                    <td height="2" colspan="2" class="line_dg"></td>
                  </tr>
                 
              </table></div></div>

              <table width="690" border="0" cellpadding="0" cellspacing="0">
			 
				<tr><td height="10"></td>
				</tr>
                
				</table>
              <strong>
              <!-- 기간 테이블 / -->            
              </strong></td>
          </tr></table></div><div style='display:none;' id='season_02'><table>
                  <tr>
                    <td class="style13"><!-- / 시즌선택 -->
                        <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td height="25" valign="top"><img src="<%=imageServer%>/jpn_img/apply/stit_seasonchoice.gif" hspace="5"></td>
                          </tr>
                          <tr>
                            <td><a href="javascript:sea_show_01();"><img src="<%=imageServer%>/jpn_img/apply/tab_day01.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day01on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day01.gif'"></a><a href="javascript:sea_show_02();"><img src="<%=imageServer%>/jpn_img/apply/tab_day02on.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day02on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day02on.gif'"></a><a href="javascript:sea_show_03();"><img src="<%=imageServer%>/jpn_img/apply/tab_day05.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day05on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day05.gif'"></a><img src="<%=imageServer%>/jpn_img/apply/tab_day_rig.gif">
                            </td>
                          </tr>
                          <tr>
                            <td height="33" class="bg_lgreen lpad_15 txt_dgreen"><img src="<%=imageServer%>/jpn_img/apply/bu_dgreen_rec.gif" align="absmiddle">
                                ハイシーズン期間: 3.20~7.26 / 8.12~9.27 / 10.28~11.30 
                          </tr>
                        </table>
                      <!-- 시즌선택 / -->                    </td>
                  </tr>
                  <tr>
                    <td height="37"></td>
                  </tr>
                  <tr>
                    <td valign="top" class="style17"><!-- / 기간 테이블 -->
                        <!-- 기간 테이블 탭 --><div><div style='display:' id='sub_season_04'>
                        <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td>
                                <img src="<%=imageServer%>/jpn_img/apply/tab_pricetab01on.gif"> 
								<a href="javascript:sub_show_05();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab02.gif"></a> 
								<a href="javascript:sub_show_06();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab03.gif"></a>
                            </td>
                            <!--<td align="right" valign="bottom" class="rpad_10">(단위 : 원,1인)</td>-->
                          </tr>
                        </table>
                      <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td height="2" colspan="9" class="line_dg"></td>
                          </tr>
                          <tr align="center">
                            <td width="79" height="28"><img src="<%=imageServer%>/jpn_img/apply/txt_price01.gif">
                                <!-- 객실명 --></td>
                            <td width="115"><img src="<%=imageServer%>/jpn_img/apply/txt_price02.gif">
                                <!-- 호텔명 --></td>
                            <td width="51"><img src="<%=imageServer%>/jpn_img/apply/txt_price03.gif">
                                <!-- 정원 --></td>
                            <td width="70"><img src="<%=imageServer%>/jpn_img/apply/txt_price04.gif">
                                <!-- 성인 --></td>
                            <td width="68"><img src="<%=imageServer%>/jpn_img/apply/txt_price05.gif">
                                <!-- 대학생 --></td>
                            <td width="95"><img src="<%=imageServer%>/jpn_img/apply/txt_price06.gif">
                                <!-- 중고등 --></td>
                            <td width="74"><img src="<%=imageServer%>/jpn_img/apply/txt_price07.gif">
                                <!-- 초등 --></td>
                            <td width="72"><img src="<%=imageServer%>/jpn_img/apply/txt_price08.gif">
                                <!-- 아동 --></td>
                            <td width="66"><img src="<%=imageServer%>/jpn_img/apply/txt_price09.gif">
                                <!-- 유아 --></td>
                          </tr>
                          <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                          </tr>
                      </table>
                      <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="79" align="center">
                        <col width="611">
                          
                  <tr>
                    <td class="cglg"><strong>金剛山ホテル本館</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                                             <tr>
                          <td height="23" class="cglg">デラックス(ダブル)</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">デラックス（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ロイヤルスイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">1,150,000</td>
                          <td class="cglg">1,150,000</td>
                          <td class="cglg">980,000</td>
                          <td class="cglg">860,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                        <tr>
                          <td height="23" class="cglg">スイート（オンドル）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイート（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダード（オンドル）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダード（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>

                    </table></td>
                  </tr>
				  <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>金剛山ホテル別館
</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">スイートオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室オンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>						
                    </table></td>
                  </tr>

				    <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>ファミリビーチホテル</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">ロイヤルスイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">1,150,000</td>
                          <td class="cglg">1,150,000</td>
                          <td class="cglg">980,000</td>
                          <td class="cglg">860,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチ家族室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチ家族室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム B</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム B</td>
                          <td class="cglg">3~6</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">5~6</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室オンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室ツイン
</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>外金剛ホテル</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">デラックススイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイートダブル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">460,000</td>
                          <td class="cglg">400,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイートツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダードオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダードツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ジュニアオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">300,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>海金剛ホテル
</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">家族室</td>
                          <td class="cglg">2~4</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">貴賓室</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">デラックス</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般ツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>
				  
				  <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>金剛ペンションタウン 
</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">ペンション A</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション A</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション B</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション B</td>
                          <td class="cglg">3~6</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">5~8</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				  <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>温泉ビリッジ</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">温泉ビリッジ</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">温泉ビリッジ</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>
				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>九龍町 </strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">九龍一般室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">九龍一般室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>キャンピングカー</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">キャンピングカー2人室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">キャンピングカー２人室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="2" colspan="2" class="line_dg"></td>
                  </tr>
                 
              </table> </div>
<div style='display:none;' id='sub_season_05'>
<table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td>
                                <a href="javascript:sub_show_04();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab01.gif"></a>
								<img src="<%=imageServer%>/jpn_img/apply/tab_pricetab02on.gif"> 
								<a href="javascript:sub_show_06();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab03.gif"></a>
                            </td>
                            <!--<td align="right" valign="bottom" class="rpad_10">(단위 : 원,1인)</td>-->
                          </tr>
                        </table>
                      <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td height="2" colspan="9" class="line_dg"></td>
                          </tr>
                          <tr align="center">
                            <td width="79" height="28"><img src="<%=imageServer%>/jpn_img/apply/txt_price01.gif">
                                <!-- 객실명 --></td>
                            <td width="115"><img src="<%=imageServer%>/jpn_img/apply/txt_price02.gif">
                                <!-- 호텔명 --></td>
                            <td width="51"><img src="<%=imageServer%>/jpn_img/apply/txt_price03.gif">
                                <!-- 정원 --></td>
                            <td width="70"><img src="<%=imageServer%>/jpn_img/apply/txt_price04.gif">
                                <!-- 성인 --></td>
                            <td width="68"><img src="<%=imageServer%>/jpn_img/apply/txt_price05.gif">
                                <!-- 대학생 --></td>
                            <td width="95"><img src="<%=imageServer%>/jpn_img/apply/txt_price06.gif">
                                <!-- 중고등 --></td>
                            <td width="74"><img src="<%=imageServer%>/jpn_img/apply/txt_price07.gif">
                                <!-- 초등 --></td>
                            <td width="72"><img src="<%=imageServer%>/jpn_img/apply/txt_price08.gif">
                                <!-- 아동 --></td>
                            <td width="66"><img src="<%=imageServer%>/jpn_img/apply/txt_price09.gif">
                                <!-- 유아 --></td>
                          </tr>
                          <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                          </tr>
                      </table>
                      <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="79" align="center">
                        <col width="611">
                          
                <tr>
                    <td class="cglg"><strong>金剛山ホテル本館</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                                             <tr>
                          <td height="23" class="cglg">デラックス(ダブル)
</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">デラックス（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ロイヤルスイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">620,000</td>
                          <td class="cglg">620,000</td>
                          <td class="cglg">530,000</td>
                          <td class="cglg">460,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                        <tr>
                          <td height="23" class="cglg">スイート（オンドル）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">300,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイート（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">300,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダード（オンドル）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダード（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>

                    </table></td>
                  </tr>
				  <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>金剛山ホテル別館
</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">スイートオンドル
</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室オンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>						
                    </table></td>
                  </tr>

				    <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>ファミリビーチホテル</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">ロイヤルスイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">620,000</td>
                          <td class="cglg">620,000</td>
                          <td class="cglg">530,000</td>
                          <td class="cglg">460,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチ家族室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチ家族室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム B</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム B</td>
                          <td class="cglg">3~6</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">5~8</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室オンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室ツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>外金剛ホテル</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">デラックススイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">300,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイートダブル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイートツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダードオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダードツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ジュニアオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>海金剛ホテル
</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">家族室</td>
                          <td class="cglg">2~4</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">貴賓室</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">デラックス</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般ツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>
				  
				  <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>金剛ペンションタウン 
</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">ペンション A</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション A</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション B</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション B</td>
                          <td class="cglg">3~6</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">5~8</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				  <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>温泉ビリッジ</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">温泉ビリッジ</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">温泉ビリッジ</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">150,000</td>
                          <td class="cglg">130,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>
				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>九龍町 </strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">九龍一般室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">九龍一般室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">150,000</td>
                          <td class="cglg">130,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>キャンピングカー</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">キャンピングカー2人室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">キャンピングカー2人室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">150,000</td>
                          <td class="cglg">130,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="2" colspan="2" class="line_dg"></td>
                  </tr>
                 
              </table></div>
			  <div style='display:none;' id='sub_season_06'>
<table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td>
                                <a href="javascript:sub_show_04();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab01.gif"></a>
								<a href="javascript:sub_show_05();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab02.gif"></a> 
								<img src="<%=imageServer%>/jpn_img/apply/tab_pricetab03on.gif">
                            </td>
                            <!--<td align="right" valign="bottom" class="rpad_10">(단위 : 원,1인)</td>-->
                          </tr>
                        </table>
                      <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td height="2" colspan="9" class="line_dg"></td>
                          </tr>
                          <tr align="center">
                            <td width="79" height="28"><img src="<%=imageServer%>/jpn_img/apply/txt_price01.gif">
                                <!-- 객실명 --></td>
                            <td width="115"><img src="<%=imageServer%>/jpn_img/apply/txt_price02.gif">
                                <!-- 호텔명 --></td>
                            <td width="51"><img src="<%=imageServer%>/jpn_img/apply/txt_price03.gif">
                                <!-- 정원 --></td>
                            <td width="70"><img src="<%=imageServer%>/jpn_img/apply/txt_price04.gif">
                                <!-- 성인 --></td>
                            <td width="68"><img src="<%=imageServer%>/jpn_img/apply/txt_price05.gif">
                                <!-- 대학생 --></td>
                            <td width="95"><img src="<%=imageServer%>/jpn_img/apply/txt_price06.gif">
                                <!-- 중고등 --></td>
                            <td width="74"><img src="<%=imageServer%>/jpn_img/apply/txt_price07.gif">
                                <!-- 초등 --></td>
                            <td width="72"><img src="<%=imageServer%>/jpn_img/apply/txt_price08.gif">
                                <!-- 아동 --></td>
                            <td width="66"><img src="<%=imageServer%>/jpn_img/apply/txt_price09.gif">
                                <!-- 유아 --></td>
                          </tr>
                          <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                          </tr>
                      </table>
                      <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="79" align="center">
                        <col width="611">
                          
                  <tr>
                    <td class="cglg"><strong>Same-day hotel</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                                             <tr>
                          <td height="23" class="cglg">Same-day tour</td>
                          <td class="cglg">1~1</td>
                          <td class="cglg">99,000</td>
                          <td class="cglg">99,000</td>
                          <td class="cglg">89,000</td>
                          <td class="cglg">89,000</td>
                          <td class="cglg">70,000</td>
                          <td class="cglg">60,000</td>
                        </tr>
					

                    </table></td>
                  </tr>
				 
                  <tr>
                    <td height="2" colspan="2" class="line_dg"></td>
                  </tr>
                 
              </table></div></div>

              <table width="690" border="0" cellpadding="0" cellspacing="0">
			 
				<tr><td height="10"></td>
				</tr>
                
				</table>
              <strong>
              <!-- 기간 테이블 / -->            
              </strong></td>
          </tr></table></div><div style='display:none;' id='season_03'><table>
                  <tr>
                    <td class="style13"><!-- / 시즌선택 -->
                        <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td height="25" valign="top"><img src="<%=imageServer%>/jpn_img/apply/stit_seasonchoice.gif" hspace="5"></td>
                          </tr>
                          <tr>
                            <td><a href="javascript:sea_show_01();"><img src="<%=imageServer%>/jpn_img/apply/tab_day01.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day01on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day01.gif'"></a><a href="javascript:sea_show_02();"><img src="<%=imageServer%>/jpn_img/apply/tab_day02.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day02on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day02.gif'"></a><a href="javascript:sea_show_03();"><img src="<%=imageServer%>/jpn_img/apply/tab_day05on.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day05on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day05on.gif'"></a><img src="<%=imageServer%>/jpn_img/apply/tab_day_rig.gif">
                            </td>
                          </tr>
                          <tr>
                            <td height="33" class="bg_lgreen lpad_15 txt_dgreen"><img src="<%=imageServer%>/jpn_img/apply/bu_dgreen_rec.gif" align="absmiddle">
                                ハイシーズン期間: 1.1~3.19 / 12.1~31
                          </tr>
                        </table>
                      <!-- 시즌선택 / -->                    </td>
                  </tr>
                  <tr>
                    <td height="37"></td>
                  </tr>
                  <tr>
                    <td valign="top" class="style17"><!-- / 기간 테이블 -->
                        <!-- 기간 테이블 탭 --><div><div style='display:' id='sub_season_07'>
                        <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td>
                                <img src="<%=imageServer%>/jpn_img/apply/tab_pricetab01on.gif"> 
								<a href="javascript:sub_show_08();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab02.gif"></a> 
								<a href="javascript:sub_show_09();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab03.gif"></a>
                            </td>
                            <!--<td align="right" valign="bottom" class="rpad_10">(단위 : 원,1인)</td>-->
                          </tr>
                        </table>
                      <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td height="2" colspan="9" class="line_dg"></td>
                          </tr>
                          <tr align="center">
                            <td width="79" height="28"><img src="<%=imageServer%>/jpn_img/apply/txt_price01.gif">
                                <!-- 객실명 --></td>
                            <td width="115"><img src="<%=imageServer%>/jpn_img/apply/txt_price02.gif">
                                <!-- 호텔명 --></td>
                            <td width="51"><img src="<%=imageServer%>/jpn_img/apply/txt_price03.gif">
                                <!-- 정원 --></td>
                            <td width="70"><img src="<%=imageServer%>/jpn_img/apply/txt_price04.gif">
                                <!-- 성인 --></td>
                            <td width="68"><img src="<%=imageServer%>/jpn_img/apply/txt_price05.gif">
                                <!-- 대학생 --></td>
                            <td width="95"><img src="<%=imageServer%>/jpn_img/apply/txt_price06.gif">
                                <!-- 중고등 --></td>
                            <td width="74"><img src="<%=imageServer%>/jpn_img/apply/txt_price07.gif">
                                <!-- 초등 --></td>
                            <td width="72"><img src="<%=imageServer%>/jpn_img/apply/txt_price08.gif">
                                <!-- 아동 --></td>
                            <td width="66"><img src="<%=imageServer%>/jpn_img/apply/txt_price09.gif">

                                <!-- 유아 --></td>
                          </tr>
                          <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                          </tr>
                      </table>
                      <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="79" align="center">
                        <col width="611">
                          
                  <tr>
                    <td class="cglg"><strong>金剛山ホテル本館</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                                             <tr>
                          <td height="23" class="cglg">デラックス(ダブル)</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">デラックス（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ロイヤルスイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">850,000</td>
                          <td class="cglg">850,000</td>
                          <td class="cglg">720,000</td>
                          <td class="cglg">630,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                        <tr>
                          <td height="23" class="cglg">スイート（オンドル）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイート（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダード（オンドル）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダード（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>

                    </table></td>
                  </tr>
				  <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>金剛山ホテル別館
</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">スイートオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">230,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室オンドル </td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">200,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>						
                    </table></td>
                  </tr>

				    <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>ファミリビーチホテル</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">ロイヤルスイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">850,000</td>
                          <td class="cglg">850,000</td>
                          <td class="cglg">720,000</td>
                          <td class="cglg">630,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチ家族室
</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチ家族室
</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム B</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">300,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム B</td>
                          <td class="cglg">3~6</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">300,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">230,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">5~6</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">200,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室オンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室ツイン
</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>外金剛ホテル</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">デラックススイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイートダブル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイートツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダードオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダードツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ジュニアオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>海金剛ホテル
</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">家族室</td>
                          <td class="cglg">2~4</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">貴賓室</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">デラックス</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般ツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>
				  
				  <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>金剛ペンションタウン 
</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">ペンション A</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">230,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション A</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">200,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション B</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">230,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション B</td>
                          <td class="cglg">3~6</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">200,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">300,000</td>
                          <td class="cglg">270,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">230,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">5~8</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">200,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				  <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>温泉ビリッジ</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">温泉ビリッジ</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">温泉ビリッジ</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>
				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>九龍町 </strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">九龍一般室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">九龍一般室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>キャンピングカー</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">キャンピングカー2人室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">キャンピングカー2人室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="2" colspan="2" class="line_dg"></td>
                  </tr>
                 
              </table> </div>
<div style='display:none;' id='sub_season_08'>
<table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td>
                                <a href="javascript:sub_show_07();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab01.gif"></a>
								<img src="<%=imageServer%>/jpn_img/apply/tab_pricetab02on.gif"> 
								<a href="javascript:sub_show_09();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab03.gif"></a>
                            </td>
                            <!--<td align="right" valign="bottom" class="rpad_10">(단위 : 원,1인)</td>-->
                          </tr>
                        </table>
                      <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td height="2" colspan="9" class="line_dg"></td>
                          </tr>
                          <tr align="center">
                            <td width="79" height="28"><img src="<%=imageServer%>/jpn_img/apply/txt_price01.gif">
                                <!-- 객실명 --></td>
                            <td width="115"><img src="<%=imageServer%>/jpn_img/apply/txt_price02.gif">
                                <!-- 호텔명 --></td>
                            <td width="51"><img src="<%=imageServer%>/jpn_img/apply/txt_price03.gif">
                                <!-- 정원 --></td>
                            <td width="70"><img src="<%=imageServer%>/jpn_img/apply/txt_price04.gif">
                                <!-- 성인 --></td>
                            <td width="68"><img src="<%=imageServer%>/jpn_img/apply/txt_price05.gif">
                                <!-- 대학생 --></td>
                            <td width="95"><img src="<%=imageServer%>/jpn_img/apply/txt_price06.gif">
                                <!-- 중고등 --></td>
                            <td width="74"><img src="<%=imageServer%>/jpn_img/apply/txt_price07.gif">
                                <!-- 초등 --></td>
                            <td width="72"><img src="<%=imageServer%>/jpn_img/apply/txt_price08.gif">
                                <!-- 아동 --></td>
                            <td width="66"><img src="<%=imageServer%>/jpn_img/apply/txt_price09.gif">
                                <!-- 유아 --></td>
                          </tr>
                          <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                          </tr>
                      </table>
                      <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="79" align="center">
                        <col width="611">
                          
                  <tr>
                    <td class="cglg"><strong>金剛山ホテル本館</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                                             <tr>
                          <td height="23" class="cglg">デラックス(ダブル)
</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">デラックス（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ロイヤルスイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">450,000</td>
                          <td class="cglg">450,000</td>
                          <td class="cglg">380,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                        <tr>
                          <td height="23" class="cglg">スイート（オンドル）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイート（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダード（オンドル）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダード（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>

                    </table></td>
                  </tr>
				  <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>金剛山ホテル別館 
</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">スイートオンドル
</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室オンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">160,000</td>
                          <td class="cglg">140,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>						
                    </table></td>
                  </tr>

				    <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>ファミリビーチホテル</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">ロイヤルスイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">450,000</td>
                          <td class="cglg">450,000</td>
                          <td class="cglg">380,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチ家族室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチ家族室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム B</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム B</td>
                          <td class="cglg">3~6</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">160,000</td>
                          <td class="cglg">140,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">5~6</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">160,000</td>
                          <td class="cglg">140,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室オンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室ツイン
</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>外金剛ホテル</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">デラックススイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイートダブル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイートツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダードオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダードツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ジュニアオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">160,000</td>
                          <td class="cglg">140,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>海金剛ホテル
</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">家族室</td>
                          <td class="cglg">2~4</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">貴賓室</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">デラックス</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般ツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>
				  
				  <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>金剛ペンションタウン
</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">ペンション A</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション A</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">160,000</td>
                          <td class="cglg">140,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション B</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション B</td>
                          <td class="cglg">3~6</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">160,000</td>
                          <td class="cglg">140,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">5~8</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">190,000</td>
                          <td class="cglg">160,000</td>
                          <td class="cglg">140,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				  <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>温泉ビリッジ</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">温泉ビリッジ</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">温泉ビリッジ</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">150,000</td>
                          <td class="cglg">130,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>
				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>九龍町 </strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">九龍一般室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">九龍一般室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">150,000</td>
                          <td class="cglg">130,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>

				   <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                   </tr>
				   <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="80" align="center">
                        <col width="610">
                          
                  <tr>
                    <td class="cglg"><strong>キャンピングカー</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                       <tr>
                          <td height="23" class="cglg">キャンピングカー2人室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">キャンピングカー2人室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">150,000</td>
                          <td class="cglg">130,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="2" colspan="2" class="line_dg"></td>
                  </tr>
                 
              </table></div>
			  <div style='display:none;' id='sub_season_09'>
<table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td>
                                <a href="javascript:sub_show_07();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab01.gif"></a>
								<a href="javascript:sub_show_08();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab02.gif"></a> 
								<img src="<%=imageServer%>/jpn_img/apply/tab_pricetab03on.gif">
                            </td>
                            <!--<td align="right" valign="bottom" class="rpad_10">(단위 : 원,1인)</td>-->
                          </tr>
                        </table>
                      <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td height="2" colspan="9" class="line_dg"></td>
                          </tr>
                          <tr align="center">
                            <td width="79" height="28"><img src="<%=imageServer%>/jpn_img/apply/txt_price01.gif">
                                <!-- 객실명 --></td>
                            <td width="115"><img src="<%=imageServer%>/jpn_img/apply/txt_price02.gif">
                                <!-- 호텔명 --></td>
                            <td width="51"><img src="<%=imageServer%>/jpn_img/apply/txt_price03.gif">
                                <!-- 정원 --></td>
                            <td width="70"><img src="<%=imageServer%>/jpn_img/apply/txt_price04.gif">
                                <!-- 성인 --></td>
                            <td width="68"><img src="<%=imageServer%>/jpn_img/apply/txt_price05.gif">
                                <!-- 대학생 --></td>
                            <td width="95"><img src="<%=imageServer%>/jpn_img/apply/txt_price06.gif">
                                <!-- 중고등 --></td>
                            <td width="74"><img src="<%=imageServer%>/jpn_img/apply/txt_price07.gif">
                                <!-- 초등 --></td>
                            <td width="72"><img src="<%=imageServer%>/jpn_img/apply/txt_price08.gif">
                                <!-- 아동 --></td>
                            <td width="66"><img src="<%=imageServer%>/jpn_img/apply/txt_price09.gif">
                                <!-- 유아 --></td>
                          </tr>
                          <tr>
                            <td height="1" colspan="9" class="line_dg"></td>
                          </tr>
                      </table>
                      <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <col width="79" align="center">
                        <col width="611">
                          
                  <tr>
                    <td class="cglg"><strong>Same-day hotel</strong></td>
                    <td class="style22"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <col width="115" align="center">
                      <col width="51" align="right">
                        <col width="70" align="right" class="rpad_10">
                      <col width="68" align="right" class="rpad_10">
                      <col width="95" align="right" class="rpad_10">
                        <col width="74" align="right" class="rpad_10">
                      <col width="72" align="right" class="rpad_10">
                      <col width="66" align="right" class="rpad_10">
                                             <tr>
                          <td height="23" class="cglg">Same-day tour</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">99,000</td>
                          <td class="cglg">99,000</td>
                          <td class="cglg">89,000</td>
                          <td class="cglg">89,000</td>
                          <td class="cglg">70,000</td>
                          <td class="cglg">60,000</td>
                        </tr>
                    </table></td>
                  </tr>
				 
                  <tr>
                    <td height="2" colspan="2" class="line_dg"></td>
                  </tr>
                 
              </table></div></div>

              <table width="690" border="0" cellpadding="0" cellspacing="0">
			 
				<tr><td height="10"></td>
				</tr>
                
				</table>
              <strong>
              <!-- 기간 테이블 / -->            
              </strong></td>
          </tr></table></div></div></td></tr>
          <tr>
            <td height="29"></td>
          </tr>

          <tr>
            <td valign="top"><!-- / 기타요금안내 테이블 -->
                <table width="690" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td height="24" valign="top"><img src="<%=imageServer%>/jpn_img/apply/stit_etcprice.gif"></td>
                  </tr>
                </table>
              <table width="690" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td height="2" colspan="3" class="line_dg"></td>
                  </tr>
                  <tr align="center">
                    <td width="86" height="28"><img src="<%=imageServer%>/jpn_img/apply/txt_price10.gif">
                        <!-- 구분 --></td>
                    <td width="508"><img src="<%=imageServer%>/jpn_img/apply/txt_price11.gif">
                        <!-- 내용 --></td>
                    <td width="96"><img src="<%=imageServer%>/jpn_img/apply/txt_price12.gif">
                        <!-- 비고 --></td>
                  </tr>
                  <col width="100" style="padding:15 5 15 5px;">
                <col width="360" style="padding:15 5 15 5px;">
                <col width="165" style="padding:15 5 15 15px;">
                  <tr>
                    <td height="1" colspan="3" class="line_dg"></td>
                  </tr>
                 
                  <tr>
                    <td class="cwlg style41"><div align="center">周末?用</div></td>
                    <td class="cwlg style41">星期五/星期六出? : 2天1宿<br>
旅游旺季要多付30,000?元<br>
旅游高峰期要多付60,000?元<br>  
星期五/星期六出? : 3天2宿<br>
旅游旺季要多付50,000?元<br>
旅游高峰期要多付90,000?元 </td>
                    <td class="cwlg style41">只限大?生和成年人</td>
                  </tr>
                
                  <tr>
                    <td class="cwlg style41"><p align="center">?金?<br>?光<br>?用</p></td>
                    <td class="cwlg style41"> <p>?金??光?念特?价(2007.6.1(星期五)~9.30(星期天)) : 多付30,000?元<br>
?光出?日 : 星期一、三、五出?(3天2宿?光) / ?光???模 : 每天150名</p>
                      <table width="462" border="0" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
                          <tr>
                            <td width="66" rowspan="3" bgcolor="#FFFFFF"><div align="center">?分</div></td>
                            <td width="120" colspan="2" rowspan="2" bgcolor="#FFFFFF"><div align="center">?有?准?光?用</div></td>
							<td width="262" colspan="4" bgcolor="#FFFFFF"><div align="center">?金??光?用</div></td>
                          </tr>
						  <tr>
                            <td width="141" colspan="2" bgcolor="#FFFFFF"><div align="center">2007年 5月 ~ 9月 -></div></td>
                            <td width="141" colspan="2" bgcolor="#EEEEEE"><div align="center">-> ?光?念?惠价</div></td>
                          </tr>
                          <tr>
                            <td width="55" bgcolor="#FFFFFF"><div align="center">旺季</div></td>
                            <td width="65" bgcolor="#FFFFFF"><div align="center">高峰期</div></td>
                            <td width="65" bgcolor="#FFFFFF"><div align="center">旺季</div></td>
							<td width="76" bgcolor="#FFFFFF"><div align="center">高峰期</div></td>
							<td width="65" bgcolor="#EEEEEE"><div align="center">旺季</div></td>
							<td width="76" bgcolor="#EEEEEE"><div align="center">高峰期</div></td>
                          </tr>
                          <tr>
                            <td bgcolor="#FFFFFF"><div align="center">Hotel</div></td>
                            <td bgcolor="#FFFFFF"><div align="center">390,000</div></td>
                            <td bgcolor="#FFFFFF"><div align="center">490,000</div></td>
                            <td bgcolor="#FFFFFF"><div align="center">440,000</div></td>
							<td bgcolor="#FFFFFF"><div align="center">540,000</div></td>
							<td bgcolor="#EEEEEE"><div align="center">420,000</div></td>
							<td bgcolor="#EEEEEE"><div align="center">520,000</div></td>
                          </tr>
                          <tr>
                            <td bgcolor="#FFFFFF"><div align="center">Pension</div></td>
                            <td bgcolor="#FFFFFF"><div align="center">340,000</div></td>
                            <td bgcolor="#FFFFFF"><div align="center">440,000</div></td>
                            <td bgcolor="#FFFFFF"><div align="center">390,000</div></td>
							<td bgcolor="#FFFFFF"><div align="center">490,000</div></td>
							<td bgcolor="#EEEEEE"><div align="center">370,000</div></td>
							<td bgcolor="#EEEEEE"><div align="center">470,000</div></td>
                          </tr>
                          <tr>
                            <td bgcolor="#FFFFFF"><div align="center">Village</div></td>
                            <td bgcolor="#FFFFFF"><div align="center">250,000</div></td>
                            <td bgcolor="#FFFFFF"><div align="center">320,000</div></td>
                            <td bgcolor="#FFFFFF"><div align="center">300,000</div></td>
							<td bgcolor="#FFFFFF"><div align="center">370,000</div></td>
							<td bgcolor="#EEEEEE"><div align="center">280,000</div></td>
							<td bgcolor="#EEEEEE"><div align="center">350,000</div></td>
                          </tr>
                      </table>
                      <p>* ?金??光?用不再?折?</p></td>
                     <td class="cwlg"><Br></td>
                  </tr>
                  <tr>
                    <td class="cwlw style41"><div align="center">退??定</div></td>
                    <td class="cwlw style41"><table width="500" border="0" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
                        <tr bgcolor="#FFFFFF">
                          <td colspan="2"><div align="center">取消?用</div></td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                          <td width="244" bgcolor="#FFFFFF">出?10天前</td>
                          <td width="245"><div align="center">无</div></td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                          <td>出?9天前 ~ 出??天</td>
                          <td><div align="center">50%</div></td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                          <td>起程之后</td>
                          <td><div align="center">100%</div></td>
                        </tr>
                    </table></td>
                    <td class="cwlw"><br></td>
                  </tr>
                  <tr>
                    <td height="2" colspan="3" class="line_dg"></td>
                  </tr>
									
              </table>
							
              <!-- 기타요금안내 테이블 / -->            </td>
          </tr>
        
        </table></span>
		<!--  content / -->    </td>
</tr>
</table>

		<!--------  center area /-------->
	</td>
</tr>
<tr>
	<td valign="bottom" height="20">
		<!--/ footer -->
        <%@ include file="/jpn/include/footer_utf8.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>
</DIV> 
<DIV ID="objSelection"> 
</DIV> 

</body>
</html>