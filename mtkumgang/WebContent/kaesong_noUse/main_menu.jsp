<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.KsTourNotice"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%
//변수 선언
int board_seq			= 0;
int ref_no				= 0; 
int level_no			= 0;
int sort_no				= 0;
int read_num			= 0;
String title			= ""; 
String content			= "";
String user_nick		= "";
String use_yn			= "";
String user_level		= "";
int board_top_no		= 0;
String user_id			= "";

int pageSize			= 4;
int blockSize			= 4;
//게시판 타입결정
String boardType		= "15";
//String pageNum = "5";
//String McNum = "6";
//String sub="5";


// DB연결 객체(ibatis사용)  
KsTourNotice dao = new KsTourNotice();
CommonBoard commonDao = new CommonBoard();
// 검색 - 컬럼명
String part       = ParamUtil.getReqParameter(request.getParameter("part"));
// 검색 - 검색어
String keyword    = ParamUtil.getReqParameter(request.getParameter("keyword"));
// 검색 - 파라메터
String key_str = "&part="+part+"&keyword="+keyword;

//요청된 페이지 넘버
int requestedPage = Util.parseInt(request.getParameter("page"), 1);

//한 페이지 당 게시물 숫자
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// 현재의 블록에서의 위치
int position = Util.parseInt(request.getParameter("position"), 1);

// 블럭 당 페이지 숫자  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);


// 게시물 목록
Tbrd_board_ma_bean record [] = dao.getList(requestedPage, pageSize, part, keyword );

// 전체 게시물 수
int allCount = commonDao.getTotalCount(boardType, part,keyword);
// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);
%>
<html>
<head>
<title>::: 개성 관광 :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<style>
<!--
body {
	background-image: url(/kaesong/images/kaesong_main/main_bg.gif);
	background-repeat: repeat-x;
	background-color: #F7F7F7;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
#Layer1 {
	position:absolute;
	z-index:1;
	visibility: hidden;
}
-->
</style>
<script language="JavaScript" type="text/JavaScript">

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
<script language=javascript>
<!--
function autoblur(){
if(event.srcElement.tagName == "A") document.body.focus();
}
document.onfocusin = autoblur;

function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}
//-->
function go_URL(url_val)
{
	if (url_val != "")
		location.href = url_val;
}
</script>

<script language="javascript">
function familyPop(val)
{
   if(val !=""){
          window.open(val,"family");
   }
}


//팝업띄우는 펑션
function checkPopup()
{
	if(getCookie("ksopen") != "done" )		// 불러온 쿠키의 값이 "done"이 아니면~
    {																	
     window.open("/kaesong/popup/pop071112.jsp","fee2","width=400,height=380,top=0,left=0");	//새창 띄워라. ()
    }
	


}	//펑션블럭 끝


function getCookie( name )
{
        var nameOfCookie = name + "=";
        var x = 0;
        while ( x <= document.cookie.length )
        {
                var y = (x+nameOfCookie.length);
                if ( document.cookie.substring( x, y ) == nameOfCookie ) {
                        if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
                                endOfCookie = document.cookie.length;
                        return unescape( document.cookie.substring( y, endOfCookie ) );
                }
                x = document.cookie.indexOf( " ", x ) + 1;
                if ( x == 0 )
                        break;
        }
        return "";
}

</script>
</head>
<body onLoad="checkPopup()">

<table cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table width="890" cellpadding="0" cellspacing="0">
				<tr>
					<td width="240" colspan="2" align="left" valign="top" style="padding-left:45px; padding-top:37px;"><img src="/kaesong/images/kaesong_main/main_1_26.gif"></td>
					<!--탑메뉴시작-->
					<td valign="top" style="padding-top:7px;">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<!--탑메뉴 start-->
								<td align="right" style="padding-bottom:13px;">
									<table cellpadding="0" cellspacing="0">
										<tr>
											<td><a href="/member/login.jsp" target="_blank"><img src="/kaesong/images/kaesong_main/login_bt.gif" border="0"></a></td>
											<td><a href="/member/join_agreement.jsp" target="_blank"><img src="/kaesong/images/kaesong_main/join_bt.gif" border="0"></a></td>
											<td><a href="/mypage/reservation/reservation_confirm.jsp" target="_blank"><img src="/kaesong/images/kaesong_main/mypage_bt.gif" border="0"></a></td>
											<td><img src="/kaesong/images/kaesong_main/sitemap_bt.gif" border="0"></td>
											<td><a href="/tour/gaesung_01.jsp" target="_blank"><img src="/kaesong/images/kaesong_main/bt_go_1.gif" border="0"></a></td>
											<td><a href="/tour/baekdusan_01.jsp" target="_blank"><img src="/kaesong/images/kaesong_main/bt_go_2.gif" border="0"></a></td>
										</tr>
									</table>
								</td>
								<!--탑메뉴 end-->
							</tr>
							<tr>
								<!--원뎁스 메뉴 start-->
								<td>
									<table cellpadding="0" cellspacing="0">
										<tr>
											<td><img src="/kaesong/images/kaesong_main/top_menu_0.gif"></td>
											<td><a href="#" onMouseOver="MM_swapImage('main_img_1','','/kaesong/images/kaesong_main/top_menu_1o.gif',1);MM_showHideLayers('Layer1','','show','Layer2','','hide','Layer3','','hide','Layer4','','hide','Layer5','','hide','Layer6','','hide')" onMouseOut="MM_swapImgRestore()"><img src="/kaesong/images/kaesong_main/top_menu_1.gif" name="main_img_1" border="0"></a></td>
											<td><img src="/kaesong/images/kaesong_main/top_menu_line.gif"></td>
											<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('main_img_2','','/kaesong/images/kaesong_main/top_menu_2o.gif',1);MM_showHideLayers('Layer1','','hide','Layer2','','show','Layer3','','hide','Layer4','','hide','Layer5','','hide','Layer6','','hide')"><img src="/kaesong/images/kaesong_main/top_menu_2.gif" name="main_img_2" border="0"></a></td>
											<td><img src="/kaesong/images/kaesong_main/top_menu_line.gif"></td>
											<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('main_img_3','','/kaesong/images/kaesong_main/top_menu_3o.gif',1);MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','show','Layer4','','hide','Layer5','','hide','Layer6','','hide')"><img src="/kaesong/images/kaesong_main/top_menu_3.gif" name="main_img_3" border="0"></a></td>
											<td><img src="/kaesong/images/kaesong_main/top_menu_line.gif"></td>
											<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('main_img_4','','/kaesong/images/kaesong_main/top_menu_4o.gif',1);MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','hide','Layer4','','show','Layer5','','hide','Layer6','','hide')"><img src="/kaesong/images/kaesong_main/top_menu_4.gif" name="main_img_4" border="0"></a></td>
											<td><img src="/kaesong/images/kaesong_main/top_menu_line.gif"></td>
											<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('main_img_5','','/kaesong/images/kaesong_main/top_menu_5o.gif',1);MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','hide','Layer4','','hide','Layer5','','show','Layer6','','hide')"><img src="/kaesong/images/kaesong_main/top_menu_5.gif" name="main_img_5" border="0"></a></td>
											<td><img src="/kaesong/images/kaesong_main/top_menu_line.gif"></td>
											<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('main_img_6','','/kaesong/images/kaesong_main/top_menu_6o.gif',1);MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','hide','Layer4','','hide','Layer5','','hide','Layer6','','show')"><img src="/kaesong/images/kaesong_main/top_menu_6.gif" name="main_img_6" border="0"></a></td>
											<td><img src="/kaesong/images/kaesong_main/top_menu_7.gif"></td>
										</tr>
									</table>
								</td>
								<!--원뎁스 메뉴 end-->
							</tr>
							<tr>
								<!--투뎁스 서브메뉴 start-->
										<td height="20px" valign="top" style="padding-left:10px; padding-top:3px;">
										<div id="Layer1" style="position:absolute; z-index:1; style=" onMouseOut="MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','hide','Layer4','','hide','Layer5','','hide','Layer6','','hide')"height:17px;">
										<table cellpadding="0" cellspacing="0">
										<tr>
										<td><a href="info/info_01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_1','','/kaesong/images/kaesong_main/sub_1o.gif',1)"><img src="/kaesong/images/kaesong_main/sub_1.gif" name="sub_img_1" border="0"></a></td>
										<td><a href="info/info_02.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_2','','/kaesong/images/kaesong_main/sub_2o.gif',1)"><img src="/kaesong/images/kaesong_main/sub_2.gif" name="sub_img_2" border="0"></a></td>
										<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_3','','/kaesong/images/kaesong_main/sub_3o.gif',1)"><img src="/kaesong/images/kaesong_main/sub_3.gif" name="sub_img_3" border="0"></a></td>
										</tr>
										</table>
										</div>
										<div id="Layer2" style="position:absolute; z-index:2; visibility: hidden; style="height:17px;">
										<table cellpadding="0" cellspacing="0">
										<tr>
										<td style="padding-left:114px;"><a href="trip/trip_01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_4','','/kaesong/images/kaesong_main/2sub_1o.gif',1)"><img src="/kaesong/images/kaesong_main/2sub_1.gif" name="sub_img_4" border="0"></a></td>
										<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_5','','/kaesong/images/kaesong_main/2sub_2o.gif',1)"><img src="/kaesong/images/kaesong_main/2sub_2.gif" name="sub_img_5" border="0"></a></td>
										<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_6','','/kaesong/images/kaesong_main/2sub_3o.gif',1)"><img src="/kaesong/images/kaesong_main/2sub_3.gif" name="sub_img_6" border="0"></a></td>
										<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_7','','/kaesong/images/kaesong_main/2sub_4o.gif',1)"><img src="/kaesong/images/kaesong_main/2sub_4.gif" name="sub_img_7" border="0"></a></td>
										</tr>
										</table>
										</div>
										<div id="Layer3" style="position:absolute; z-index:3; visibility: hidden; style="height:17px;">
										<table cellpadding="0" cellspacing="0">
										<tr>
										<td style="padding-left:217px;"><a href="start/start_01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_8','','/kaesong/images/kaesong_main/3sub_1o.gif',1)"><img src="/kaesong/images/kaesong_main/3sub_1.gif" name="sub_img_8" border="0"></a></td>
										<td><a href="start/start_02.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_9','','/kaesong/images/kaesong_main/3sub_2o.gif',1)"><img src="/kaesong/images/kaesong_main/3sub_2.gif" name="sub_img_9" border="0"></a></td>
										<td><a href="start/start_03.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_10','','/kaesong/images/kaesong_main/3sub_3o.gif',1)"><img src="/kaesong/images/kaesong_main/3sub_3.gif" name="sub_img_10" border="0"></a></td>
										<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_11','','/kaesong/images/kaesong_main/3sub_4o.gif',1)"><img src="/kaesong/images/kaesong_main/3sub_4.gif" name="sub_img_11" border="0"></a></td>
										</tr>
										</table>
										</div>
										<div id="Layer4" style="position:absolute; z-index:4; visibility: hidden; style="height:17px;">
										<table cellpadding="0" cellspacing="0">
										<tr>
										<td style="padding-left:321px;"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_12','','/kaesong/images/kaesong_main/4sub_1o.gif',1)"><img src="/kaesong/images/kaesong_main/4sub_1.gif" name="sub_img_12" border="0"></a></td>
										<td><a href="http://www.mtkumgang.com/reservation/agent/agent_list.jsp?area_cd=44" target="_blank" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_13','','/kaesong/images/kaesong_main/4sub_2o.gif',1)"><img src="/kaesong/images/kaesong_main/4sub_2.gif" name="sub_img_13" border="0"></a></td>
										</tr>
										</table>
										</div>
										<div id="Layer5" style="position:absolute; z-index:5; visibility: hidden; style="height:17px;">
										<table cellpadding="0" cellspacing="0">
										<tr>
										<td style="padding-left:418px;"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_14','','/kaesong/images/kaesong_main/5sub_1o.gif',1)"><img src="/kaesong/images/kaesong_main/5sub_1.gif" name="sub_img_14" border="0"></a></td>
										<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_15','','/kaesong/images/kaesong_main/5sub_2o.gif',1)"><img src="/kaesong/images/kaesong_main/5sub_2.gif" name="sub_img_15" border="0"></a></td>
										<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_16','','/kaesong/images/kaesong_main/5sub_3o.gif',1)"><img src="/kaesong/images/kaesong_main/5sub_3.gif" name="sub_img_16" border="0"></a></td>
										</tr>
										</table>
										</div>
										<div id="Layer6" style="position:absolute; z-index:6; visibility: hidden; style="height:17px;">
										<table cellpadding="0" cellspacing="0">
										<tr>
										<td style="padding-left:330px;"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_17','','/kaesong/images/kaesong_main/6sub_1o.gif',1)"><img src="/kaesong/images/kaesong_main/6sub_1.gif" name="sub_img_17" border="0"></a></td>
										<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_18','','/kaesong/images/kaesong_main/6sub_2o.gif',1)"><img src="/kaesong/images/kaesong_main/6sub_2.gif" name="sub_img_18" border="0"></a></td>
										<td><a href="board/board_list.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_19','','/kaesong/images/kaesong_main/6sub_3o.gif',1)"><img src="/kaesong/images/kaesong_main/6sub_3.gif" name="sub_img_19" border="0"></a></td>
										<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_20','','/kaesong/images/kaesong_main/6sub_4o.gif',1)"><img src="/kaesong/images/kaesong_main/6sub_4.gif" name="sub_img_20" border="0"></a></td>
										</tr>
										</table>
										</div>
										</td>
								<!--투뎁스 서브메뉴 end-->	
							</tr>
						</table>
					</td>
					<!--탑메뉴끝-->
				</tr>
		 </table>
		</td>
	</tr>
	<tr>
		<!-- 비주얼 시작 -->
		<td><img src="/kaesong/images/kaesong_main/main_img.jpg"></td>
		<!-- 비주얼 끝-->
	</tr>
	<tr>
		<td style="padding-top:17px; padding-left:30px; padding-bottom:36px;">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top">
						<table cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td width="314" style="padding-bottom:5px;"><img src="/kaesong/images/kaesong_main/news_title.gif"></td>
								<td style="padding-right:5px;"><a href="board/board_list.jsp"><img src="/kaesong/images/kaesong_main/more_bt.gif" border="0"></a></td>
							</tr>
							<tr>
								<td colspan="2"><img src="/kaesong/images/kaesong_main/news_line.gif"></td>
							</tr>
							<tr>
								<td style="padding-top:2px;" colspan="2">
									<table cellpadding="0" cellspacing="0" width="355">
									<%
										//리스트 화면에 전시
										for(int i=0;i<4; i++){ 
											Tbrd_board_ma_bean tbean = record[i];
											
											board_seq			= tbean.getBoard_seq();
											ref_no				= tbean.getRef_no(); 
											level_no			= tbean.getLevel_no(); 
											sort_no				= tbean.getSort_no(); 
											read_num			= tbean.getRead_num(); 
											title				= tbean.getTitle(); 
											content				= tbean.getContent(); 
											use_yn				= tbean.getUse_yn(); 
											user_level			= tbean.getUser_level(); 
											board_top_no		= tbean.getBoard_top_no(); 
											user_id				= tbean.getUser_id();
											use_yn				= tbean.getUse_yn();
									
											java.util.Date writeday = tbean.getReg_date();
											String reg_date_string = tbean.getReg_date_String();
											String re_img	= BoardUtil.getReImg(level_no,sort_no,imageServer);
											String new_img	= BoardUtil.getNewArticle(writeday,imageServer);
									%>	
										<tr>
											<td height="22" style="padding-left:7px;"><img src="/kaesong/images/kaesong_main/news_con.gif" vspace="5" align="absmiddle"><a href="board/board_view.jsp?board_seq=<%=board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>" class="kaesong01"> <%=title%></a></td>
										</tr>
										<tr>
										  <td><img src="/kaesong/images/kaesong_main/dot.gif"></td>
										</tr>
									<%
										}
									%>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td style="padding-left:9px;"><img src="/kaesong/images/kaesong_main/event_1.gif"></td>
					<td style="padding-left:8px;"><img src="/kaesong/images/kaesong_main/cyber_1.gif"></td>
				</tr>
			</table>
		</td>
	</tr>
	<!--bottom start-->
	<tr>
		<td background="/kaesong/images/kaesong_main/bottom_bg.gif" height="85" valign="top">
				<table width="890" cellpadding="0" cellspacing="0">
					<tr>
						<td style="padding-left:28px; padding-top:18px;"><img src="/kaesong/images/kaesong_main/bottom_img.gif"></td>
						<td align="right" valign="top" style="padding-top:15px;">	
						<SELECT name="family" style='width:128px; height:15px; font-family:돋움; font-size:11px;' onChange="window.open(this.options[this.selectedIndex].value,'_blank')">
              <option value='' selected>FAMILY SITE</option>
							<option value='http://www.hyundaigroup.com'>현대그룹</option>
							<option value='http://www.hyundai-asan.com'>현대아산</option>
							<option value='http://www.unikorea.go.kr'>통일부</option>
							<option value='http://www.knto.or.kr'>한국관광공사</option>
            </SELECT>
						</td>
					</tr>
				</table>
		</td>
	</tr>
	<!--bottom end-->
</table>
</body>
</html>
