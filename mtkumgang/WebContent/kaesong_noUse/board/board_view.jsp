<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %> 
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.KsTourNotice"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>


<%
//request parameters
int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
String part        	= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword    	= ParamUtil.getReqParameter(request.getParameter("keyword"));

String key_str = "&part="+part+"&keyword="+keyword;

//변수 선언
String cmd			= "";
String board_type	= "";
String title		= "";
String content		= "";
String user_id		= "";
String user_name	= "";
String regdate		= "";
int read_num		= 0;
String use_yn		= "";
String type_code	= "";
String type_name	= "";
String virtual_name	= "";
String real_name	= "";
int recomm_num		= 0;

int prev_board_seq  = 0;
int next_board_seq	= 0;

String prev_title		= "";
String next_title		= "";

String pageNum = "5";
String McNum = "6";
String sub="5";


KsTourNotice dao = new KsTourNotice();

dao.updateReadnum(board_seq);

Tbrd_board_ma_bean[] recordview = dao.getPrevAndNextBoard(board_seq);

int totalCount = recordview.length;


for(int i=0; i<totalCount; i++){
	Tbrd_board_ma_bean tbean = recordview[i];
	String gubun = tbean.getGubun();
	
	if(gubun.equals("NOW")){
		title					= tbean.getTitle();
		content					= tbean.getContent();
		content					= content.replaceAll("\"", "'");
		regdate					= tbean.getReg_date_String();
		read_num				= tbean.getRead_num();
		
	}else if(gubun.equals("PREV")){
		prev_board_seq	= tbean.getBoard_seq();
		prev_title			= tbean.getTitle();
	}else if(gubun.equals("NEXT")){
		next_board_seq	= tbean.getBoard_seq();
		next_title			= tbean.getTitle();
	}
}	


%>
<html>
<head>
<title>::: 개성 관광 :::</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<style type="text/css">
<!--
#Layer1 {	position:absolute;
	z-index:1;
	visibility: hidden;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style1 {color: #fe842b}
-->
</style>
<script type="text/JavaScript">
function autoblur(){
if(event.srcElement.tagName == "A") document.body.focus();
}
document.onfocusin = autoblur;
<!--
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

function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}

function openEvent() {
	//window.open("/cummunity/quiz/070711_event_1.jsp","event1","width=700,height=650,top=0,left=0");
}
//-->
</script>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"></head>
<body onLoad="MM_preloadImages('/kaesong/images/board/leftmenu_01o.gif','/kaesong/images/board/leftmenu_02o.gif','/kaesong/images/board/leftmenu_03o.gif','/kaesong/images/board/leftmenu_04o.gif','/kaesong/images/kaesong_main/top_menu_2o.gif')">
	<table cellpadding="0" cellspacing="0" width="100%" height="100%">
		<tr>
			<td height="235" background="/kaesong/images/info/sub_02.gif">
				<table width="890" cellpadding="0" cellspacing="0">
					<tr>
						<td>
						 <table width="890" cellpadding="0" cellspacing="0">
               <tr>
                <td width="240" colspan="2" align="left" valign="top" style="padding-left:45px; padding-top:37px;"><a href="/kaesong/main.jsp"><img src="/kaesong/images/kaesong_main/main_1_26.gif" border="0"></a></td>
                <!--탑메뉴시작-->
                <td valign="top" style="padding-top:7px;"><table cellpadding="0" cellspacing="0">
                  <tr>
                   <!--탑메뉴 start-->
                   <td align="right" style="padding-bottom:13px;"><table cellpadding="0" cellspacing="0">
                     <tr>
                      <td><a href="/member/login.jsp" target="_blank"><img src="/kaesong/images/kaesong_main/login_bt.gif" border="0"></a></td>
                      <td><a href="/member/join_agreement.jsp" target="_blank"><img src="/kaesong/images/kaesong_main/join_bt.gif" border="0"></a></td>
                      <td><a href="/mypage/reservation/reservation_confirm.jsp" target="_blank"><img src="/kaesong/images/kaesong_main/mypage_bt.gif" border="0"></a></td>
                      <td><img src="/kaesong/images/kaesong_main/sitemap_bt.gif" border="0"></td>
                      <td><a href="/tour/gaesung_01.jsp" target="_blank"><img src="/kaesong/images/kaesong_main/bt_go_1.gif" border="0"></a></td>
                      <td><a href="/tour/baekdusan_01.jsp" target="_blank"><img src="/kaesong/images/kaesong_main/bt_go_2.gif" border="0"></a></td>
                     </tr>
                   </table></td>
                   <!--탑메뉴 end-->
                  </tr>
                  <tr>
                   <!--원뎁스 메뉴 start-->
                   <td><table cellpadding="0" cellspacing="0">
                     <tr>
                      <td><img src="/kaesong/images/kaesong_main/top_menu_0.gif"></td>
                      <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('main_img_1','','/kaesong/images/kaesong_main/top_menu_1o.gif',1);MM_showHideLayers('Layer1','','show','Layer2','','hide','Layer3','','hide','Layer4','','hide','Layer5','','hide','Layer6','','hide')"><img src="/kaesong/images/kaesong_main/top_menu_1.gif" name="main_img_1" border="0"></a></td>
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
                   </table></td>
                   <!--원뎁스 메뉴 end-->
                  </tr>
                  <tr>
                   <!--투뎁스 서브메뉴 start-->
										<td height="20px" valign="top" style="padding-left:10px; padding-top:3px;">
										<div id="Layer1" style="position:absolute; z-index:1; style="height:17px;">
										<table cellpadding="0" cellspacing="0">
										<tr>
										<td><a href="../info/info_01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_1','','/kaesong/images/kaesong_main/sub_1o.gif',1)"><img src="/kaesong/images/kaesong_main/sub_1.gif" name="sub_img_1" border="0"></a></td>
										<td><a href="../info/info_02.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_2','','/kaesong/images/kaesong_main/sub_2o.gif',1)"><img src="/kaesong/images/kaesong_main/sub_2.gif" name="sub_img_2" border="0"></a></td>
										<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_3','','/kaesong/images/kaesong_main/sub_3o.gif',1)"><img src="/kaesong/images/kaesong_main/sub_3.gif" name="sub_img_3" border="0"></a></td>
										</tr>
										</table>
										</div>
										<div id="Layer2" style="position:absolute; z-index:2; visibility: hidden; style="height:17px;">
										<table cellpadding="0" cellspacing="0">
										<tr>
										<td style="padding-left:114px;"><a href="../trip/trip_01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_4','','/kaesong/images/kaesong_main/2sub_1o.gif',1)"><img src="/kaesong/images/kaesong_main/2sub_1.gif" name="sub_img_4" border="0"></a></td>
										<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_5','','/kaesong/images/kaesong_main/2sub_2o.gif',1)"><img src="/kaesong/images/kaesong_main/2sub_2.gif" name="sub_img_5" border="0"></a></td>
										<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_6','','/kaesong/images/kaesong_main/2sub_3o.gif',1)"><img src="/kaesong/images/kaesong_main/2sub_3.gif" name="sub_img_6" border="0"></a></td>
										<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_7','','/kaesong/images/kaesong_main/2sub_4o.gif',1)"><img src="/kaesong/images/kaesong_main/2sub_4.gif" name="sub_img_7" border="0"></a></td>
										</tr>
										</table>
										</div>
										<div id="Layer3" style="position:absolute; z-index:3; visibility: hidden; style="height:17px;">
										<table cellpadding="0" cellspacing="0">
										<tr>
										<td style="padding-left:217px;"><a href="../start/start_01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_8','','/kaesong/images/kaesong_main/3sub_1o.gif',1)"><img src="/kaesong/images/kaesong_main/3sub_1.gif" name="sub_img_8" border="0"></a></td>
										<td><a href="../start/start_02.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_9','','/kaesong/images/kaesong_main/3sub_2o.gif',1)"><img src="/kaesong/images/kaesong_main/3sub_2.gif" name="sub_img_9" border="0"></a></td>
										<td><a href="../start/start_03.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_10','','/kaesong/images/kaesong_main/3sub_3o.gif',1)"><img src="/kaesong/images/kaesong_main/3sub_3.gif" name="sub_img_10" border="0"></a></td>
										<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_11','','/kaesong/images/kaesong_main/3sub_4o.gif',1)"><img src="/kaesong/images/kaesong_main/3sub_4.gif" name="sub_img_11" border="0"></a></td>
										</tr>
										</table>
										</div>
										<div id="Layer4" style="position:absolute; z-index:4; visibility: hidden; style="height:17px;">
										<table cellpadding="0" cellspacing="0">
										<tr>
										<td style="padding-left:321px;"><a href="../reservation/reservation_01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_12','','/kaesong/images/kaesong_main/4sub_1o.gif',1)"><img src="/kaesong/images/kaesong_main/4sub_1.gif" name="sub_img_12" border="0"></a></td>
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
										<td><a href="../board/board_list.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_19','','/kaesong/images/kaesong_main/6sub_3o.gif',1)"><img src="/kaesong/images/kaesong_main/6sub_3.gif" name="sub_img_19" border="0"></a></td>
										<td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_img_20','','/kaesong/images/kaesong_main/6sub_4o.gif',1)"><img src="/kaesong/images/kaesong_main/6sub_4.gif" name="sub_img_20" border="0"></a></td>
										</tr>
										</table>
										</div>
										</td>
										<!--투뎁스 서브메뉴 end-->	
                  </tr>
                </table></td>
                <!--탑메뉴끝-->
               </tr>
             </table>						
						</td>
					</tr>
					<tr>
						<td><img src="/kaesong/images/board/sub_visual_6.jpg"></td>
					</tr>
					<tr>
						<td><img src="/kaesong/images/info/sub_topbg.gif"></td>
					</tr>
			 </table>
		 </td>
		</tr>
		<tr>
			
    <td height="100%" valign="top"> <table width="890" height="100%" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="100%" valign="top" style="padding-left:30px;" width="220"> 
            <!--레프트메뉴시작-->
            <table cellpadding="0" cellspacing="0">
              <tr> 
                <td><img src="/kaesong/images/board/leftmenu_title.gif"></td>
              </tr>
              <tr> 
                <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_01','','/kaesong/images/board/leftmenu_01o.gif',1)"><img src="/kaesong/images/board/leftmenu_01.gif" name="sub_01" border="0"></a></td>
              </tr>
              <tr>
                <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_02','','/kaesong/images/board/leftmenu_02o.gif',1)"><img src="/kaesong/images/board/leftmenu_02.gif" name="sub_02" border="0"></a></td>
              </tr>
              <tr> 
                <td><img src="/kaesong/images/board/leftmenu_03o.gif" name="sub_03" border="0"></td>
              </tr>
              <tr> 
                <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_04','','/kaesong/images/board/leftmenu_04o.gif',1)"><img src="/kaesong/images/board/leftmenu_04.gif" name="sub_04" border="0"></a></td>
              </tr>
            </table>
            <!--레프트메뉴끝-->
          </td>
          <td valign="top"> <table cellpadding="0" cellspacing="0">
              <tr> 
                <td style="padding-right:20px;"width="670" height="31" align="right" valign="top" background="/kaesong/images/info/subtop_bg.gif"><a href="../main.jsp" class="linemap">Home</a> 
                  &gt; <a href="#" class="linemap">고객센터</a> &gt; <span class="linemap_now">공지사항</span></td>
              </tr>
              <tr> 
                <td background="/kaesong/images/info/submiddle_bg.gif" style="padding-left:30px;"> 
                  <!--컨텐츠영역 시작--->
                  <table width="610" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td><img src="/kaesong/images/board/menu_06_con1.gif" width="118" height="19"></td>
                    </tr>
                    <tr> 
                      <td style="padding-top:28px; padding-bottom:25px;"><img src="/kaesong/images/board/menu_06_txt.gif" width="181" height="14"> 
                        <table width="610" align="center" cellpadding="0" cellspacing="0">
                          <tr> 
                            <td> 
                              <!--- 게시판 ------>
                              <table width="610" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td colspan="3"><table width="610" border="0" cellpadding="0" cellspacing="1" bgcolor="a9a9a9">
                                      <tr> 
                                        <td width="88" height="2" colspan="3" bgcolor="ffffff"><table width="610" border="0" cellpadding="0" cellspacing="0">
                                            <tr> 
                                              <td width="78"><img src="/kaesong/images/board/tips_title.gif" width="78" height="23"></td>
                                              <td width="10">&nbsp;</td>
                                              <td class="page_s"><strong><%=title%></strong></td>
                                            </tr>
                                          </table></td>
                                      </tr>
                                    </table></td>
                                </tr>
                                <tr> 
                                  <td colspan="3"><table width="610" border="0" cellspacing="0" cellpadding="0">
                                      <tr> 
                                        <td>&nbsp;</td>
                                        
                                        <td width="46" align="center"><img src="/kaesong/images/board/tips_days.gif" width="30" height="14"></td>
                                        <td width="80" class="page_s"><%=regdate%></td>
                                        <td width="1"><img src="/kaesong/images/board/bot_tip.gif" width="1" height="12"></td>
                                        <td width="40" align="center"><img src="/kaesong/images/board/tips_hits.gif" width="30" height="14"></td>
                                        <td width="40" height="25" align="center" class="page_s"><%=read_num%></td>
                                      </tr>
                                    </table></td>
                                </tr>
                                <tr> 
                                  <td height="1" colspan="3" bgcolor="CCCCCC"></td>
                                </tr>
                                <tr> 
                                  <td colspan="3" > <table width="610" border="0" cellspacing="0" cellpadding="0" height=300>
                                      <tr> 
                                        <td class="page_s" style="padding:15 15 15 15"><%=content%></td>
                                      </tr>
                                    </table></td>
                                </tr>
                                <tr> 
                                  <td height="2" colspan="3" bgcolor="A9A9A9"></td>
                                </tr>
                                <tr> 
                                  <td><img src="/kaesong/images/board/pre.gif" width="78" height="25"></td>
                                  <td width="10">&nbsp;</td>
                                  <td width="562" class="page_s">
								   <%if(prev_board_seq > 0){%>									
									   <a href="board_view.jsp?board_seq=<%=prev_board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>" class="listtxt06"><%=prev_title%></a>
								   <% }else{ %>
									이전글이 존재하지 않습니다.
								   <% } %>							
								  </td>
                                </tr>
                                <tr> 
                                  <td height="1"></td>
                                  <td height="1" colspan="2" bgcolor="A9A9A9"></td>
                                </tr>
                                <tr> 
                                  <td><img src="/kaesong/images/board/next.gif" width="78" height="26"></td>
                                  <td>&nbsp;</td>
                                  <td class="page_s">
								   <%if(next_board_seq > 0){%>
									  <a href="board_view.jsp?board_seq=<%=next_board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>" class="listtxt06"><%=next_title%></a>
								   <% }else{ %>
									  다음글이 존재하지 않습니다.	
								   <% } %>
								  </td>
                                </tr>
                                <tr> 
                                  <td height="2" colspan="3" bgcolor="A9A9A9"></td>
                                </tr>
                              </table>
                              <!--- 게시판 ------>
                            </td>
                          </tr>
                          <tr> 
                            <td height="19">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><div align="right"><a href="board_list.jsp?requestedPage=<%=requestedPage%><%=key_str%>"><img src="/kaesong/images/board/button_list.gif" width="60" height="20" border="0"></a></div></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td style="padding-top:28px; padding-bottom:25px;">&nbsp;</td>
                    </tr>
                  </table>
                  <!--컨텐츠영역 끝-->
                </td>
              </tr>
              <tr> 
                <td style="padding-bottom:10px;"><img src="/kaesong/images/info/subbottom_bg.gif"></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
		</tr>
		<tr>
			<td></td>
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
<!--   < % @ include file="/inc/bottom.jsp" % > 띄어쓰기를 붙이세요  -->
	</table>
</body>
</html>
