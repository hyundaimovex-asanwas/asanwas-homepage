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
                        <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td height="25" valign="top"><img src="<%=imageServer%>/jpn_img/apply/stit_seasonchoice.gif" hspace="5"></td>
                          </tr>
                          <tr>
                            <td><a href="javascript:sea_show_01();"><img src="<%=imageServer%>/jpn_img/apply/tab_day01on.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day01on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day01on.gif'"></a><a href="javascript:sea_show_02();"><img src="<%=imageServer%>/jpn_img/apply/tab_day02.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day02on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day02.gif'"></a><a href="javascript:sea_show_03();"><img src="<%=imageServer%>/jpn_img/apply/tab_day06.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day06on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day06.gif'"></a><a href="javascript:sea_show_04();"><img src="<%=imageServer%>/jpn_img/apply/tab_day05.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day05on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day05.gif'"></a><img src="<%=imageServer%>/jpn_img/apply/tab_day_rig.gif">
                            </td>
                          </tr>
                          <tr>
                            <td height="33" class="bg_lgreen lpad_15 txt_dgreen"><img src="<%=imageServer%>/jpn_img/apply/bu_dgreen_rec.gif" align="absmiddle">
                                最ピークシーズン
 期間: 5.1~5.11 / 9.27~11.1 
                          </tr>
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
                          <td class="cglg">540,000</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
					                  	<tr>
                          <td height="23" class="cglg">デラックス（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
					                  	<tr>
                          <td height="23" class="cglg">ロイヤルスイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">1,250,000</td>
                          <td class="cglg">1,250,000</td>
                          <td class="cglg">1,060,000</td>
                          <td class="cglg">940,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                        <tr>
                          <td height="23" class="cglg">スイート（オンドル）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">590,000</td>
                          <td class="cglg">590,000</td>
                          <td class="cglg">500,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
					                  	<tr>
                          <td height="23" class="cglg">スイート（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">590,000</td>
                          <td class="cglg">590,000</td>
                          <td class="cglg">500,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
			                  			<tr>
                          <td height="23" class="cglg">スタンダード（オンドル）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
		                  				<tr>
                          <td height="23" class="cglg">スタンダード（ツイン）</td>
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
                          <td class="cglg">1,250,000</td>
                          <td class="cglg">1,250,000</td>
                          <td class="cglg">1,060,000</td>
                          <td class="cglg">940,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						                  <tr>
                          <td height="23" class="cglg">ビーチ家族室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">460,000</td>
                          <td class="cglg">400,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
		                  				<tr>
                          <td height="23" class="cglg">ビーチ家族室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
			                  			<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム B</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						                  <tr>
                          <td height="23" class="cglg">ビーチコンドミニアム B</td>
                          <td class="cglg">3~6</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
					                  	<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">460,000</td>
                          <td class="cglg">400,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
				                  		<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
				                  		<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">5~6</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
				                  		<tr>
                          <td height="23" class="cglg">一般室オンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
		                  				<tr>
                          <td height="23" class="cglg">一般室ツイン</td>
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
                          <td class="cglg">590,000</td>
                          <td class="cglg">590,000</td>
                          <td class="cglg">500,000</td>
                          <td class="cglg">440,000</td>
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
                          <td class="cglg">540,000</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">460,000</td>
                          <td class="cglg">400,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
					                  	<tr>
                          <td height="23" class="cglg">スタンダードオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
					                  	<tr>
                          <td height="23" class="cglg">スタンダードツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
					                  	<tr>
                          <td height="23" class="cglg">ジュニアオンドル</td>
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
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
					                  	<tr>
                          <td height="23" class="cglg">貴賓室</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">460,000</td>
                          <td class="cglg">400,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						                  <tr>
                          <td height="23" class="cglg">デラックス</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
				                  		<tr>
                          <td height="23" class="cglg">一般室ツイン</td>
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
                    <td class="cglg"><strong>金剛ペンションタウン</strong></td>
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
                          <td class="cglg">470,000</td>
                          <td class="cglg">470,000</td>
                          <td class="cglg">400,000</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                      </tr>
						                  <tr>
                          <td height="23" class="cglg">ペンション A</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">360,000</td>
                          <td class="cglg">310,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
					                  	<tr>
                          <td height="23" class="cglg">ペンション B</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
			                  			<tr>
                          <td height="23" class="cglg">ペンション B</td>
                          <td class="cglg">3~6</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
					                  	<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">540,000</td>
                          <td class="cglg">460,000</td>
                          <td class="cglg">400,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
					                  	<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">490,000</td>
                          <td class="cglg">420,000</td>
                          <td class="cglg">370,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
				                  		<tr>
                          <td height="23" class="cglg">ペンション C</td>
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
                          <td class="cglg">450,000</td>
                          <td class="cglg">450,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
				                  		<tr>
                          <td height="23" class="cglg">温泉ビリッジ</td>
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
                          <td class="cglg">450,000</td>
                          <td class="cglg">450,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
					                  	<tr>
                          <td height="23" class="cglg">九龍一般室</td>
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
                          <td height="23" class="cglg">キャンピングカー 2人室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">450,000</td>
                          <td class="cglg">450,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
				                  		<tr>
                          <td height="23" class="cglg">キャンピングカー 2人室</td>
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
                          <td height="23" class="cglg">キャンピングカー 2人室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">キャンピングカー 2人室</td>
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
                            <td><a href="javascript:sea_show_01();"><img src="<%=imageServer%>/jpn_img/apply/tab_day01.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day01on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day01.gif'"></a><a href="javascript:sea_show_02();"><img src="<%=imageServer%>/jpn_img/apply/tab_day02on.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day02on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day02on.gif'"></a><a href="javascript:sea_show_03();"><img src="<%=imageServer%>/jpn_img/apply/tab_day06.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day06on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day06.gif'"></a><a href="javascript:sea_show_04();"><img src="<%=imageServer%>/jpn_img/apply/tab_day05.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day05on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day05.gif'"></a><img src="<%=imageServer%>/jpn_img/apply/tab_day_rig.gif">
                            </td>
                          </tr>
                          <tr>
                            <td height="33" class="bg_lgreen lpad_15 txt_dgreen"><img src="<%=imageServer%>/jpn_img/apply/bu_dgreen_rec.gif" align="absmiddle">
                                ピークシーズン
 期間:  4.12 ~ 4.30 / 5.12 ~ 5.31 / 7.12 ~ 9.26 / 11.2 ~ 11.15                          </tr>
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
                          <td height="23" class="cglg">一般室ツイン</td>
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
                          <td height="23" class="cglg">一般室ツイン</td>
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
                          <td height="23" class="cglg">キャンピングカー 2人室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">350,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">キャンピングカー 2人室</td>
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
                          <td height="23" class="cglg">デラックス(ダブル)</td>
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
                          <td height="23" class="cglg">スイートオンドル</td>
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
                          <td height="23" class="cglg">キャンピングカー 2人室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">キャンピングカー 2人室</td>
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
          </tr></table></div>
										
										
										
										
										
										
										
										
										
										<div style='display:none;' id='season_03'><table>
                  <tr>
                    <td class="style13"><!-- / 시즌선택 -->
                        <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td height="25" valign="top"><img src="<%=imageServer%>/jpn_img/apply/stit_seasonchoice.gif" hspace="5"></td>
                          </tr>
                          <tr>
                            <td>
<a href="javascript:sea_show_01();"><img src="<%=imageServer%>/jpn_img/apply/tab_day01.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day01on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day01.gif'"></a><a href="javascript:sea_show_02();"><img src="<%=imageServer%>/jpn_img/apply/tab_day02.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day02on.gif'"	onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day02.gif'"></a><a href="javascript:sea_show_03();"><img src="<%=imageServer%>/jpn_img/apply/tab_day06on.gif"	onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day06on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day06on.gif'"></a><a href="javascript:sea_show_04();"><img src="<%=imageServer%>/jpn_img/apply/tab_day05.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day05on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day05.gif'"></a><img src="<%=imageServer%>/jpn_img/apply/tab_day_rig.gif">
                            </td>
                          </tr>
                          <tr>
                            <td height="33" class="bg_lgreen lpad_15 txt_dgreen"><img src="<%=imageServer%>/jpn_img/apply/bu_dgreen_rec.gif" align="absmiddle">
                                オンシーズン
 期間: 3.22 ~ 4.11 / 6.1 ~ 7.11 / 11.16 ~ 11.29</tr>
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
                                <img src="<%=imageServer%>/jpn_img/apply/tab_pricetab01on.gif"><a href="javascript:sub_show_08();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab02.gif"></a><a href="javascript:sub_show_09();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab03.gif"></a>
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
                          <td class="cglg">331,500</td>
                          <td class="cglg">292,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">デラックス（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">331,500</td>
                          <td class="cglg">292,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ロイヤルスイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">1,000,000</td>
                          <td class="cglg">1,000,000</td>
                          <td class="cglg">850,000</td>
                          <td class="cglg">750,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                        <tr>
                          <td height="23" class="cglg">スイート（オンドル）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">880,000</td>
                          <td class="cglg">880,000</td>
                          <td class="cglg">748,000</td>
                          <td class="cglg">660,000</td>
                          <td class="cglg">200,000</td>
                          <td class="cglg">160,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイート（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">440,000</td>
                          <td class="cglg">374,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダード（オンドル）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">289,000</td>
                          <td class="cglg">255,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダード（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">289,000</td>
                          <td class="cglg">255,000</td>
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
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">289,000</td>
                          <td class="cglg">255,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室オンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">300,000</td>
                          <td class="cglg">300,000</td>
                          <td class="cglg">255,000</td>
                          <td class="cglg">225,000</td>
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
                    <td class="cglg"><strong>ファミリビーチホテル </strong></td>
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
                          <td class="cglg">1,000,000</td>
                          <td class="cglg">1,000,000</td>
                          <td class="cglg">850,000</td>
                          <td class="cglg">750,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチ家族室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">331,500</td>
                          <td class="cglg">292,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチ家族室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">289,000</td>
                          <td class="cglg">255,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム B</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">289,000</td>
                          <td class="cglg">255,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム B</td>
                          <td class="cglg">3~6</td>
                          <td class="cglg">300,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">331,500</td>
                          <td class="cglg">292,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">331,500</td>
                          <td class="cglg">292,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">289,000</td>
                          <td class="cglg">255,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">5~8</td>
                          <td class="cglg">300,000</td>
                          <td class="cglg">300,000</td>
                          <td class="cglg">255,000</td>
                          <td class="cglg">225,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室オンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">289,000</td>
                          <td class="cglg">255,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室ツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">289,000</td>
                          <td class="cglg">225,000</td>
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
                          <td class="cglg">450,000</td>
                          <td class="cglg">450,000</td>
                          <td class="cglg">382,500</td>
                          <td class="cglg">337,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイートダブル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">331,500</td>
                          <td class="cglg">292,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイートツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">331,000</td>
                          <td class="cglg">292,550</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダードオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">289,000</td>
                          <td class="cglg">255,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダードツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">289,000</td>
                          <td class="cglg">255,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ジュニアオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">300,000</td>
                          <td class="cglg">300,000</td>
                          <td class="cglg">255,000</td>
                          <td class="cglg">225,000</td>
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
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">289,000</td>
                          <td class="cglg">255,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">貴賓室</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">331,500</td>
                          <td class="cglg">292,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">デラックス</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">289,000</td>
                          <td class="cglg">255,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室ツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">340,000</td>
                          <td class="cglg">289,000</td>
                          <td class="cglg">255,000</td>
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
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">246,500</td>
                          <td class="cglg">217,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション A</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">221,000</td>
                          <td class="cglg">195,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション B</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">272,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション B</td>
                          <td class="cglg">3~6</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">238,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">380,000</td>
                          <td class="cglg">380,000</td>
                          <td class="cglg">323,000</td>
                          <td class="cglg">285,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">272,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">5~8</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">38,000</td>
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
                          <td class="cglg">238,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">温泉ビリッジ</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">212,500</td>
                          <td class="cglg">187,500</td>
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
                          <td class="cglg">238,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">九龍一般室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">212,500</td>
                          <td class="cglg">187,500</td>
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
                          <td height="23" class="cglg">キャンピングカー 2人室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">238,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">キャンピングカー 2人室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">212,500</td>
                          <td class="cglg">187,500</td>
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
                          <td height="23" class="cglg">デラックス(ダブル)</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">246,500</td>
                          <td class="cglg">217,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">デラックス（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">246,500</td>
                          <td class="cglg">217,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ロイヤルスイート</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">530,000</td>
                          <td class="cglg">530,000</td>
                          <td class="cglg">450.500</td>
                          <td class="cglg">397,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
                        <tr>
                          <td height="23" class="cglg">スイート（オンドル）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">640,000</td>
                          <td class="cglg">640,000</td>
                          <td class="cglg">544,000</td>
                          <td class="cglg">480,000</td>
                          <td class="cglg">200,000</td>
                          <td class="cglg">160,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイート（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">272,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダード（オンドル）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">221,000</td>
                          <td class="cglg">195,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダード（ツイン）</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">221,000</td>
                          <td class="cglg">195,000</td>
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
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">221,000</td>
                          <td class="cglg">195,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室オンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">230,000</td>
                          <td class="cglg">230,000</td>
                          <td class="cglg">195,500</td>
                          <td class="cglg">172,500</td>
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
                          <td class="cglg">530,000</td>
                          <td class="cglg">530,000</td>
                          <td class="cglg">450,500</td>
                          <td class="cglg">397,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチ家族室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">246,500</td>
                          <td class="cglg">217,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチ家族室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">221,000</td>
                          <td class="cglg">195,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム B</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">221,000</td>
                          <td class="cglg">195,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム B</td>
                          <td class="cglg">3~6</td>
                          <td class="cglg">230,000</td>
                          <td class="cglg">230,000</td>
                          <td class="cglg">195,000</td>
                          <td class="cglg">172,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">246,500</td>
                          <td class="cglg">217,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">230,000</td>
                          <td class="cglg">230,000</td>
                          <td class="cglg">195,500</td>
                          <td class="cglg">172,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチコンドミニアム C</td>
                          <td class="cglg">5~6</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">221,000</td>
                          <td class="cglg">195,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室オンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">221,000</td>
                          <td class="cglg">195,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室ツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">221,000</td>
                          <td class="cglg">195,000</td>
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
                          <td class="cglg">320,000</td>
                          <td class="cglg">320,000</td>
                          <td class="cglg">272,000</td>
                          <td class="cglg">240,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイートダブル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">246,500</td>
                          <td class="cglg">217,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スイートツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">246,500</td>
                          <td class="cglg">217,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダードオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">221,000</td>
                          <td class="cglg">195,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">スタンダードツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">221,000</td>
                          <td class="cglg">195,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ジュニアオンドル</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">230,000</td>
                          <td class="cglg">230,000</td>
                          <td class="cglg">195,000</td>
                          <td class="cglg">172,500</td>
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
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">221,000</td>
                          <td class="cglg">195,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">貴賓室</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">290,000</td>
                          <td class="cglg">246,500</td>
                          <td class="cglg">217,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">デラックス</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">221,000</td>
                          <td class="cglg">195,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">一般室ツイン</td>
                          <td class="cglg">2~3</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">260,000</td>
                          <td class="cglg">221,000</td>
                          <td class="cglg">195,500</td>
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
                          <td class="cglg">187,000</td>
                          <td class="cglg">165,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション A</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">178,500</td>
                          <td class="cglg">157,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション B</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">212,500</td>
                          <td class="cglg">187,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション B</td>
                          <td class="cglg">3~6</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">187,000</td>
                          <td class="cglg">165,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">238,000</td>
                          <td class="cglg">210,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">212,500</td>
                          <td class="cglg">187,500</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ペンション C</td>
                          <td class="cglg">5~8</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">220,000</td>
                          <td class="cglg">187,000</td>
                          <td class="cglg">165,000</td>
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
                          <td class="cglg">200,000</td>
                          <td class="cglg">200,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">150,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">温泉ビリッジ</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">153,000</td>
                          <td class="cglg">135,000</td>
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
                          <td class="cglg">200,000</td>
                          <td class="cglg">200,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">150,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">九龍一般室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">153,000</td>
                          <td class="cglg">135,000</td>
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
                          <td height="23" class="cglg">キャンピングカー 2人室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">200,000</td>
                          <td class="cglg">200,000</td>
                          <td class="cglg">170,000</td>
                          <td class="cglg">150,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">キャンピングカー 2人室</td>
                          <td class="cglg">3~4</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">150,000</td>
                          <td class="cglg">135,000</td>
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
                          <td class="cglg">120,000</td>
                          <td class="cglg">120,000</td>
                          <td class="cglg">102,000</td>
                          <td class="cglg">90,000</td>
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
          </tr></table></div>
										
										
										
										
										
										
										
										
										
										
										
										
										
												<div style='display:none;' id='season_04'><table>
                  <tr>
                    <td class="style13"><!-- / 시즌선택 -->
                        <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td height="25" valign="top"><img src="<%=imageServer%>/jpn_img/apply/stit_seasonchoice.gif" hspace="5"></td>
                          </tr>
                          <tr>
                            <td>
																												<a href="javascript:sea_show_01();"><img src="<%=imageServer%>/jpn_img/apply/tab_day01.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day01on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day01.gif'"></a><a href="javascript:sea_show_02();"><img src="<%=imageServer%>/jpn_img/apply/tab_day02.gif"	onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day02on.gif'" onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day02.gif'"></a><a href="javascript:sea_show_03();"><img src="<%=imageServer%>/jpn_img/apply/tab_day06on.gif"	onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day06on.gif'"	onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day06.gif'"></a><a href="javascript:sea_show_04();"><img src="<%=imageServer%>/jpn_img/apply/tab_day05.gif" onMouseOver="this.src='<%=imageServer%>/jpn_img/apply/tab_day05on.gif'"	onMouseOut="this.src='<%=imageServer%>/jpn_img/apply/tab_day05on.gif'"></a><img src="<%=imageServer%>/jpn_img/apply/tab_day_rig.gif">
                            </td>
                          </tr>
                          <tr>
                            <td height="33" class="bg_lgreen lpad_15 txt_dgreen"><img src="<%=imageServer%>/jpn_img/apply/bu_dgreen_rec.gif" align="absmiddle">
                                オフシーズン
 期間: 1.1 ~ 3.21 / 11.30 ~ 12.31 </tr>
                        </table>
                      <!-- 시즌선택 / -->                    </td>
                  </tr>
                  <tr>
                    <td height="37"></td>
                  </tr>
                  <tr>
                    <td valign="top" class="style17"><!-- / 기간 테이블 -->
                        <!-- 기간 테이블 탭 --><div><div style='display:' id='sub_season_10'>
                        <table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td>
                                <img src="<%=imageServer%>/jpn_img/apply/tab_pricetab01on.gif"><a href="javascript:sub_show_11();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab02.gif"></a><a href="javascript:sub_show_12();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab03.gif"></a>
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
                          <td height="23" class="cglg">一般室オンドル</td>
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
                          <td height="23" class="cglg">ビーチ家族室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">390,000</td>
                          <td class="cglg">330,000</td>
                          <td class="cglg">280,000</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">ビーチ家族室</td>
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
                          <td height="23" class="cglg">一般室ツイン</td>
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
                          <td height="23" class="cglg">一般室ツイン</td>
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
                          <td height="23" class="cglg">キャンピングカー 2人室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">250,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">キャンピングカー 2人室</td>
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
<div style='display:none;' id='sub_season_11'>
<table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td>
                                <a href="javascript:sub_show_10();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab01.gif"></a>
								<img src="<%=imageServer%>/jpn_img/apply/tab_pricetab02on.gif"> 
								<a href="javascript:sub_show_12();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab03.gif"></a>
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
                          <td height="23" class="cglg">スイートオンドル</td>
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
                          <td height="23" class="cglg">一般室ツイン</td>
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
                          <td height="23" class="cglg">一般室ツイン</td>
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
                          <td height="23" class="cglg">キャンピングカー 2人室</td>
                          <td class="cglg">2~2</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">180,000</td>
                          <td class="cglg">0</td>
                          <td class="cglg">0</td>
                          <td class="cglg">100,000</td>
                          <td class="cglg">80,000</td>
                        </tr>
						<tr>
                          <td height="23" class="cglg">キャンピングカー 2人室</td>
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
			  <div style='display:none;' id='sub_season_12'>
<table width="690" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td>
                                <a href="javascript:sub_show_10();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab01.gif"></a>
								<a href="javascript:sub_show_11();"><img src="<%=imageServer%>/jpn_img/apply/tab_pricetab02.gif"></a> 
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
          </tr></table></div>
										
										
										
										
										
										
										
										
										
										
										
										</div></td></tr>
										
										
										
										
										
										
										
										
										
										
										
										
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
                    <td class="cwlg"><div align="center">大人
週末料金
該当</div></td>
                    <td class="cwlg">金曜日/土曜日出発：一泊二日<br>
シーズン　30,000WON追加<br>
ハイシーズン　60,000WON追加<br>  
金曜日/土曜日出発：二泊三日<br>
シーズン　50,000WON追加<br>
ハイシーズン　90,000WON追加</td>
                    <td class="cwlg">大学生/
だけ</td>
                  </tr>
                
                  <tr>
                    <td class="cwlg"><p align="center">内金剛
観光料金
</p></td>
                    <td class="cwlg"> <p>内金剛観光記念特別割引販売（2007.6.1（金）～9.30（日）：追加料金30,000WON
　　　　　観光出発日：月、水、金曜日出発（二泊三日）/観光規模：日150名 
</p>
                      <table width="462" border="0" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
                          <tr>
                            <td width="66" rowspan="3" bgcolor="#FFFFFF"><div align="center">区別</div></td>
                            <td width="120" colspan="2" rowspan="2" bgcolor="#FFFFFF"><div align="center">既存観光料金</div></td>
							<td width="262" colspan="4" bgcolor="#FFFFFF"><div align="center">内金剛観光料金</div></td>
                          </tr>
						  <tr>
                            <td width="141" colspan="2" bgcolor="#FFFFFF"><div align="center">2007年5月~9月→ </div></td>
                            <td width="141" colspan="2" bgcolor="#EEEEEE"><div align="center">→　観光記念割引 </div></td>
                          </tr>
                          <tr>
                            <td width="55" bgcolor="#FFFFFF"><div align="center">シーズン</div></td>
                            <td width="65" bgcolor="#FFFFFF"><div align="center">ハイシーズン</div></td>
                            <td width="65" bgcolor="#FFFFFF"><div align="center">シーズン</div></td>
							<td width="76" bgcolor="#FFFFFF"><div align="center">ハイシーズン</div></td>
							<td width="65" bgcolor="#EEEEEE"><div align="center">シーズン</div></td>
							<td width="76" bgcolor="#EEEEEE"><div align="center">ハイシーズン</div></td>
                          </tr>
                          <tr>
                            <td bgcolor="#FFFFFF"><div align="center">ホテル</div></td>
                            <td bgcolor="#FFFFFF"><div align="center">390,000</div></td>
                            <td bgcolor="#FFFFFF"><div align="center">490,000</div></td>
                            <td bgcolor="#FFFFFF"><div align="center">440,000</div></td>
							<td bgcolor="#FFFFFF"><div align="center">540,000</div></td>
							<td bgcolor="#EEEEEE"><div align="center">420,000</div></td>
							<td bgcolor="#EEEEEE"><div align="center">520,000</div></td>
                          </tr>
                          <tr>
                            <td bgcolor="#FFFFFF"><div align="center">ペンション</div></td>
                            <td bgcolor="#FFFFFF"><div align="center">340,000</div></td>
                            <td bgcolor="#FFFFFF"><div align="center">440,000</div></td>
                            <td bgcolor="#FFFFFF"><div align="center">390,000</div></td>
							<td bgcolor="#FFFFFF"><div align="center">490,000</div></td>
							<td bgcolor="#EEEEEE"><div align="center">370,000</div></td>
							<td bgcolor="#EEEEEE"><div align="center">470,000</div></td>
                          </tr>
                          <tr>
                            <td bgcolor="#FFFFFF"><div align="center">ビリッジ</div></td>
                            <td bgcolor="#FFFFFF"><div align="center">250,000</div></td>
                            <td bgcolor="#FFFFFF"><div align="center">320,000</div></td>
                            <td bgcolor="#FFFFFF"><div align="center">300,000</div></td>
							<td bgcolor="#FFFFFF"><div align="center">370,000</div></td>
							<td bgcolor="#EEEEEE"><div align="center">280,000</div></td>
							<td bgcolor="#EEEEEE"><div align="center">350,000</div></td>
                          </tr>
                      </table>
                      <p> 内金剛観光追加料金は各種割引適用不可</p></td>
                     <td class="cwlg"><Br></td>
                  </tr>
                  <tr>
                    <td class="cwlw"><div align="center">払戻し規定</div></td>
                    <td class="cwlw"><table width="500" border="0" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
                        <tr bgcolor="#FFFFFF">
                          <td colspan="2"><div align="center">キャンセル手数料</div></td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                          <td width="244" bgcolor="#FFFFFF">出発10日前 </td>
                          <td width="245"><div align="center">なし</div></td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                          <td>出発9日前～観光開始前 </td>
                          <td><div align="center">50%</div></td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                          <td>観光開始後</td>
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