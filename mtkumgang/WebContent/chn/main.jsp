<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
 
<html> 
<head> 
<title>::: Mt.Kumgang Tour :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script language="JavaScript" src="<%=imageServer%>/chn_img/inc/java.js"></script>
<script language="JavaScript">
//�˾����� ���
function checkPopup()
{

  //  if(getCookie("pop080811chn") != "done" ) {		// �ҷ��� ��Ű�� ���� "done"�� �ƴϸ�~
  //     window.open("/chn/popup/pop080811_chn.jsp","0811eng","width=400,height=300,top=0,left=20");	//��â �����. ()
//	}

}
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
<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr>
    <td width="194" valign="top"><img src="<%=imageServer%>/chn_img/guide/chn_logo.gif"></td>
    <td width="690" height="87" valign="top"><table cellpadding="0" cellspacing="0">
      <tr>
        <td height="34" valign="top" align="right"><a href="http://www.mtkumgang.com/" target="_blank"><img src="<%=imageServer%>/chn_img/common/korea_bt.gif" border="0"></a></td>
      </tr>
      <!--������ ����-->
      <tr>
        <td height="29"><table cellpadding="0" cellspacing="0">
          <tr>
            <td><a href="/chn/preview/intro.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01','','<%=imageServer%>/chn_img/common/top_menu1on.gif',1);MM_showHideLayers('Layer1','','show','Layer2','','hide','Layer3','','hide','Layer4','','hide')"><img src="<%=imageServer%>/chn_img/common/top_menu1.gif" name="topsub_01" border="0"></a></td>
            <td><a href="/chn/reservation/reservation_process.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02','','<%=imageServer%>/chn_img/common/top_menu2on.gif',1);MM_showHideLayers('Layer1','','hide','Layer2','','show','Layer3','','hide','Layer4','','hide')"><img src="<%=imageServer%>/chn_img/common/top_menu2.gif" name="topsub_02" border="0"></a></td>
            <td><a href="/chn/start/packup01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03','','<%=imageServer%>/chn_img/common/top_menu3on.gif',1);MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','show','Layer4','','hide')"><img src="<%=imageServer%>/chn_img/common/top_menu3.gif" name="topsub_03" border="0"></a></td>
            <td><a href="/chn/guide/course/course01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04','','<%=imageServer%>/chn_img/common/top_menu4on.gif',1);MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','hide','Layer4','','show')"><img src="<%=imageServer%>/chn_img/common/top_menu4.gif" name="topsub_04" border="0"></a></td>
          </tr>
        </table></td>
      </tr>
      <!--������ ��-->
      <!--������ ����-->
      <tr>
        <td height="24" valign="top"><div id="Layer1" style="position:absolute; z-index:1; visibility: hidden;">
          <table cellpadding="0" cellspacing="0">
            <tr>
              <td width="45"></td>
              <td><a href="/chn/preview/intro.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01_01','','<%=imageServer%>/chn_img/common/top_submenu1_01on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu1_01.gif" name="topsub_01_01" border="0"></a></td>
              <td><a href="/chn/preview/story.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01_02','','<%=imageServer%>/chn_img/common/top_submenu1_02on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu1_02.gif" name="topsub_01_02" border="0"></a></td>
              <td><a href="/chn/preview/gallery/gallery_list.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01_03','','<%=imageServer%>/chn_img/common/top_submenu1_03on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu1_03.gif" name="topsub_01_03" border="0"></a></td>
              <td><a href="/chn/preview/pr_room/pr_list.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01_04','','<%=imageServer%>/chn_img/common/top_submenu1_04on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu1_04.gif" name="topsub_01_04" border="0"></a></td>
            </tr>
          </table>
        </div>
              <div id="Layer2" style="position:absolute; z-index:2; visibility: hidden;">
                <table cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="230"></td>
                    <td><a href="/chn/reservation/reservation_process.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02_01','','<%=imageServer%>/chn_img/common/top_submenu2_01on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu2_01.gif" name="topsub_02_01" border="0"></a></td>
                    <td><a href="/chn/reservation/basic_goods_01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02_02','','<%=imageServer%>/chn_img/common/top_submenu2_02on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu2_02.gif" name="topsub_02_02" border="0"></a></td>
                    <td><a href="/chn/reservation/price/price_list.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02_03','','<%=imageServer%>/chn_img/common/top_submenu2_03on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu2_03.gif" name="topsub_02_03" border="0"></a></td>
                    <td><a href="/chn/reservation/agent/agent_list.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02_04','','<%=imageServer%>/chn_img/common/top_submenu2_04on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu2_04.gif" name="topsub_02_04" border="0"></a></td>
                  </tr>
                </table>
              </div>
          <div id="Layer3" style="position:absolute; z-index:3; visibility: hidden;">
                <table cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="318"></td>
                    <td><a href="/chn/start/packup01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03_01','','<%=imageServer%>/chn_img/common/top_submenu3_01on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu3_01.gif" name="topsub_03_01" border="0"></a></td>
                    <td><a href="/chn/start/traffic.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03_02','','<%=imageServer%>/chn_img/common/top_submenu3_02on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu3_02.gif" name="topsub_03_02" border="0"></a></td>
                    <td><a href="/chn/start/admission.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03_03','','<%=imageServer%>/chn_img/common/top_submenu3_03on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu3_03.gif" name="topsub_03_03" border="0"></a></td>
                    <td><a href="/chn/start/keeping.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03_04','','<%=imageServer%>/chn_img/common/top_submenu3_04on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu3_04.gif" name="topsub_03_04" border="0"></a></td>
                  </tr>
                </table>
          </div>
          <div id="Layer4" style="position:absolute; z-index:4; visibility: hidden;">
                <table cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="280"></td>
                    <td><a href="/chn/guide/course/course01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_01','','<%=imageServer%>/chn_img/common/top_submenu4_01on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu4_01.gif" name="topsub_04_01" border="0"></a></td>
                    <td><a href="/chn/guide/hotel/hotel01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_02','','<%=imageServer%>/chn_img/common/top_submenu4_02on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu4_02.gif" name="topsub_04_02" border="0"></a></td>
                    <td><a href="/chn/guide/food/food01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_03','','<%=imageServer%>/chn_img/common/top_submenu4_03on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu4_03.gif" name="topsub_04_03" border="0"></a></td>
                    <td><a href="/chn/guide/play/play01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_04','','<%=imageServer%>/chn_img/common/top_submenu4_04on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu4_04.gif" name="topsub_04_04" border="0"></a></td>
                    <td><a href="/chn/guide/etc/etcguide.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_05','','<%=imageServer%>/chn_img/common/top_submenu4_05on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu4_05.gif" name="topsub_04_05" border="0"></a></td>
                  </tr>
                </table>
          </div></td>
      </tr>
      <!--������ ��-->
    </table></td>
    <td colspan="2"></td>
  </tr>
  <tr>
    <td height="165" colspan="2" valign="top"><script language="javascript">
                  writeObject("<%=imageServer%>/chn_img/chn_swf/chn_main.swf","100%","529","transparent")
              </script></td>
    <td width="187" bgcolor="#FFFFFF"></td>
				<td bgcolor="#FFFFFF"></td>
    <!--<td background="<%=imageServer%>/chn_img/common/main_right.jpg" bgcolor="3F7D7C"></td>-->
  </tr>
</table>
<tr>
	<td valign="bottom">
		<!--/ footer -->
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="922">
				<table width="884" cellpadding="0" cellspacing="0" border="0" class="footer2">
				<tr valign="top"> 
					<td width="145" height="20" rowspan="2"><a href="javascript:;" onClick="javascript:familyPop('http://www.hyundai-asan.com/chnlish/index.jsp')"><img src="<%=imageServer%>/chn_img/footer_logo.gif"></a></td>
					<td width="645" class="tpad_3">
					<a href="/chn/include/intro.jsp"><img src="<%=imageServer%>/chn_img/footer_01.gif"></a>
					<a href="/chn/include/agreement.jsp"><img src="<%=imageServer%>/chn_img/footer_02.gif"></a>
					<a href="/chn/include/privacy.jsp"><img src="<%=imageServer%>/chn_img/footer_03.gif"></a>
					<a href="/chn/include/contactus.jsp"><img src="<%=imageServer%>/chn_img/footer_04.gif"></a>
					</td>
					<td width="135">
						<!--<table width="132" height="17" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td align="center" style="background:url('<%=imageServer%>/tour_img/bgbox_select.gif');fixed no-repeat left top;">
								<script>
								var strCombo = ""
								+ "<select name='family' style='width:128px; height:15px;' onchange='javascript:familyPop(document.all.family.value);'>"
								+ "<option value='' selected>FAMILY SITE</option>"
								+ "<option value='http://www.hyundaigroup.com'>����׷�</option>"
								+ "<option value='http://www.hyundai-asan.com'>����ƻ�</option>"
								+ "<option value='http://www.unikorea.go.kr'>���Ϻ�</option>"
								+ "<option value='http://www.knto.or.kr'>�ѱ���������</option>"
								+ "<option value='http://tour.goseong.org'>��������</option>"
								<%if(session_isfrom.equals("a")){%>
								+ "<option value='http://toursales.hdasan.com/services/index.jsp?ut=A&c_sid=<%=session_client_sid%>&c_id=<%=session_id%>'>�븮������</option>"
							          <%}else if(session_isfrom.equals("c")){%>
							          + "<option value='http://toursales.hdasan.com/services/index.jsp?ut=C&c_sid=<%=session_client_sid%>&c_id=<%=session_id%>'>���»�����</option>"
						                     <%}%>
								+ "</select>";
								SS_write(strCombo, 6, '', 'down');
								</script>
							</td>
						</tr>
						</table>-->
					</td>
				</tr>
				<!--<tr><td height="61" colspan="2" valign="top"><img src="<%=imageServer%>/tour_img/footer_right.gif"></td></tr>-->
				</table>
			</td>
			<td valign="top" style="padding-top:40px;"><!-- <a href="#top"><img src="<%=imageServer%>/tour_img/btn/btn_top.gif"></a> --></td>
		</tr>
		</table>
		
		
<!-- LOGGER TRACKING SCRIPT V.30 FOR www.mtkumgang.com / 17211 : FAIL-SAFE TYPE / DO NOT ALTER THIS SCRIPT. -->
<!-- COPYRIGHT (C) 2002-2006 BIZSPRING INC. LOGGER(TM) ALL RIGHTS RESERVED. -->
<script language="JavaScript">/* LOGGER TRACKING SCRIPT V.30a : 17211 *//*X*//* COPYRIGHT 2002-2006 BIZSPRING INC. *//*X*//* DO NOT MODIFY THIS SCRIPT. *//*X*/var _TRK_DOMAIN="logger.co.kr";var _trk_bMSIE=(document.all)?true:false;var _trk_bJS12=(window.screen)?true:false;function _trk_escape(_str) { var str, ch; var bEncURI = "N"; eval("try{bEncURI=encodeURI('Y');}catch(_e){ }" ); if( bEncURI == "Y" ) str=encodeURI(_str); else str = escape(_str); str=str.split("+").join("%2B"); str=str.split("/").join("%2F"); str=str.split("&").join("%26"); str=str.split("?").join("%3F"); str=str.split(":").join("%3A"); str=str.split("#").join("%23"); return str;}function _trk_setCookie(name,value,expire) { var today=new Date(); today.setTime(today.getTime()+ expire ); document.cookie=name+"="+value+"; path=/; expires="+today.toGMTString()+";";}function _trk_getCookie(name) { var cookieName=name+"="; var x=0; while(x<=document.cookie.lchnth) { var y=(x+cookieName.lchnth); if(document.cookie.substring(x,y)==cookieName) {  if((endOfCookie=document.cookie.indexOf(";",y))==-1) endOfCookie=document.cookie.lchnth;  return unescape(document.cookie.substring(y,endOfCookie)); } x=document.cookie.indexOf(" ",x)+1; if(x == 0) break; } return "";}function _trk_getParameter(name) { var paraName=name+"="; var URL=""+self.document.location.search; var tURL=""; eval("try{ tURL=top.document.location.search; }catch(_e){}"); URL=URL+"&"+tURL; if(URL.indexOf(paraName)!=-1) { var x=URL.indexOf(paraName)+paraName.lchnth; var y=URL.substr(x).indexOf("&"); if(y!=-1) return URL.substring(x,x+y); else return URL.substr(x); } return "";}function _trk_make_code(_TRK_SERVER,_TRK_U) { var dt=document.title.toString(); dt=dt.substr(0,128); var dr=self.document.referrer; var tdr=""; eval("try{ tdr=top.document.referrer; }catch(_e){}"); var tdu=""; eval("try{ tdu=top.document.location.href; }catch(_e){}"); var bFrm=false; if(dr==tdu) { dr=tdr; bFrm=true; } if(dr=="undefined") dr=""; var du=self.document.location.href; if(du.substr(0,4)=="file") return ""; var adKeyVal = ""; if(bFrm) { adKeyVal=_trk_getParameter("OVKEY"); if(adKeyVal!="" && du.indexOf("OVKEY=")<0) {  if(du.indexOf("?")!=-1) du=du+"&OVKEY="+adKeyVal; else du=du+"?OVKEY="+adKeyVal;  adKeyVal=_trk_getParameter("OVRAW");  if(adKeyVal!="" && du.indexOf("OVRAW=")<0 ) if(du.indexOf("?")!=-1) du=du+"&OVRAW="+adKeyVal; else du=du+"?OVRAW="+adKeyVal; } else {  adKeyVal=_trk_getParameter("netpia");  if(adKeyVal!="" && du.indexOf("netpia=")<0 ) if(du.indexOf("?")!=-1) du=du+"&netpia="+adKeyVal; else du=du+"?netpia="+adKeyVal; } adKeyVal=_trk_getParameter("logger_kw"); if(adKeyVal!="" && du.indexOf("logger_kw=")<0 )  if(du.indexOf("?")!=-1) du=du+"&logger_kw="+adKeyVal; else du=du+"?logger_kw="+adKeyVal; adKeyVal=_trk_getParameter("source"); if(adKeyVal!="" && du.indexOf("source=")<0 )  if(du.indexOf("?")!=-1) du=du+"&source="+adKeyVal; else du=du+"?source="+adKeyVal; } var ce=navigator.cookieEnabled?"Y":"N"; var je=navigator.javaEnabled()?"Y":"N"; var ss=""; var cd = ""; if(_trk_bJS12) { ss=screen.width+"x"+screen.height; cd=screen.colorDepth; } if(!dt) dt=""; if(!dr) dr=""; if(!du) du=""; if(!ce) ce=""; if(!je) je=""; var t = new Date; var tye=(_trk_bMSIE)?(t.getYear()):(t.getFullYear()); var tmo=t.getMonth()+1; var tda=t.getDate(); var tho=t.getHours(); var tmi=t.getMinutes(); var tse=t.getSeconds(); var tzo=t.getTimezoneOffset(); var tc = ""; var prtcl=document.location.protocol.indexOf("https")!=-1?"https://":"http://"; if(prtcl=="https://") _TRK_SERVER="ssl."+_TRK_DOMAIN; tc=tc+prtcl+_TRK_SERVER; var bPNF=((typeof _TRK_PI)!="undefined" && _TRK_PI=="PNF")?true:false; if(bPNF) tc=tc+"/tracker_click.tsp"; else tc=tc+"/tracker.tsp"; tc=tc+"?u="+_TRK_U+"&XU=&EXEN="+_EXEN; if(bPNF) { tc=tc+"&rnd="+Math.random()+"&CKFL="+_TRK_PI+"&CKDATA="+_trk_escape(du); } else { tc=tc+"&dr="+_trk_escape(dr)+"&XDR="+"&dt="+_trk_escape(dt)+"&du="+_trk_escape(du); if((typeof _TRK_CP)!="undefined" && _TRK_CP!="") tc=tc+"&CP="+_trk_escape(_TRK_CP)+"&XCP="; if((typeof _TRK_PI)!="undefined" && _TRK_PI!="") tc=tc+"&PI="+_TRK_PI; if((typeof _TRK_PN)!="undefined" && _TRK_PN!="") tc=tc+"&PN="+_trk_escape(_TRK_PN); if((typeof _TRK_MF)!="undefined" && _TRK_MF!="") tc=tc+"&MF="+_trk_escape(_TRK_MF); if((typeof _TRK_OA)!="undefined" && _TRK_OA!="") tc=tc+"&OA="+_TRK_OA; if((typeof _TRK_OP)!="undefined" && _TRK_OP!="") tc=tc+"&OP="+_trk_escape(_TRK_OP); if((typeof _TRK_OE)!="undefined" && _TRK_OE!="") tc=tc+"&OE="+_TRK_OE; if((typeof _TRK_CC)!="undefined" && _TRK_CC!="") tc=tc+"&CC="+_TRK_CC; if((typeof _TRK_RK)!="undefined" && _TRK_RK!="") tc=tc+"&RK="+_trk_escape(_TRK_RK); if((typeof _TRK_SX)!="undefined" && _TRK_SX!="") tc=tc+"&SX="+_TRK_SX; if((typeof _TRK_AG)!="undefined" && _TRK_AG!="") tc=tc+"&AG="+_TRK_AG; if((typeof _TRK_IK)!="undefined" && _TRK_IK!="") tc=tc+"&IK="+_trk_escape(_TRK_IK); tc=tc+"&js=Y"+"&ss="+escape(ss)+"&cd="+cd+"&ce="+ce+"&je="+je+"&tzo="+tzo+"&tye="+tye+"&tmo="+tmo+"&tda="+tda+"&tho="+tho+"&tmi="+tmi+"&tse="+tse; } return tc;}var _TRK_LIFE=_trk_getParameter("_L_");if(_TRK_LIFE=="") _TRK_LIFE=14;_TRK_LIFE = parseInt(_TRK_LIFE)*24*60*60*1000;var _TRK_U="";var _TRK_U_P=_trk_getParameter("_U_");var _TRK_U_C= _trk_getCookie("_TRK_U");if(_TRK_U_C!="") _TRK_U=_TRK_U_C;if(_TRK_U_P!="") _TRK_U=_TRK_U_P;if(_TRK_U!="" && _TRK_U_P!="") _trk_setCookie("_TRK_U",_TRK_U,_TRK_LIFE);var _TRK_CC_C=_trk_getCookie("_TRK_CC");var _TRK_CC_P=_trk_getParameter("_C_");if((typeof _TRK_CC)!="undefined" && _TRK_CC!="") _TRK_CC_P=_TRK_CC;if(_TRK_CC_C!="") _TRK_CC=_TRK_CC_C;if(_TRK_CC_P!="") _TRK_CC=_TRK_CC_P;if((typeof _TRK_CC)!="undefined" && _TRK_CC!="" && _TRK_CC_P!="") _trk_setCookie("_TRK_CC",_TRK_CC,_TRK_LIFE);var _TRK_RK_C=_trk_getCookie("_TRK_RK");var _TRK_RK_P=_trk_getParameter("_R_");if((typeof _TRK_RK)!="undefined" && _TRK_RK!="") _TRK_RK_P=_TRK_RK;if(_TRK_RK_C!="") _TRK_RK=_TRK_RK_C;if(_TRK_RK_P!="") _TRK_RK=_TRK_RK_P;if((typeof _TRK_RK)!="undefined" && _TRK_RK!="" && _TRK_RK_P!="") _trk_setCookie("_TRK_RK",_TRK_RK,_TRK_LIFE);var _SS_LIFE = 30*60*1000;var _EXEN = _trk_getCookie("_EXEN");if( _EXEN == "" ) _EXEN = 0; _EXEN ++;_trk_setCookie("_EXEN",_EXEN,_SS_LIFE);var _trk_code_base=_trk_make_code("trk1.logger.co.kr","17211");var _trk_code_chan="";if(_TRK_U!="") _trk_code_chan=_trk_code_base.replace(/\?u=17211&XU=/g,"?u="+_TRK_U+"&XU=");var _trk_img_base=new Image();var _trk_img_chan=new Image();var _trk_img_base_click=new Image();var _trk_img_chan_click=new Image();if(_trk_bJS12==true) { if(_trk_bMSIE) { _trk_img_base.src=_trk_code_base; if(_TRK_U!="") _trk_img_chan.src=_trk_code_chan; } else { setTimeout("_trk_img_base.src=_trk_code_base;",1); if(_TRK_U!="") setTimeout("_trk_img_chan.src=_trk_code_chan;",1); }} else { if(_trk_bMSIE) document.write('<div style=\"display: none\">'); document.write('<img src=\"'+_trk_code_base+'\" height=\"0\" width=\"0\">'); if(_TRK_U!="") document.write('<img src=\"'+_trk_code_chan+'\" height=\"0\" width=\"0\">'); if(_trk_bMSIE) document.write('</div>');}function _trk_flashContentsView(_TRK_CP) { var _trk_code_flash=_trk_code_base; _trk_code_flash=_trk_code_flash.replace(/&CP=.*&XCP=/g,"&XCP="); _trk_code_flash=_trk_code_flash.replace(/&dr=.*&XDR=/g,"&XDR="); _trk_img_base_click.src=_trk_code_flash+"&dr=&CP="+_trk_escape(_TRK_CP)+"&rnd="+Math.random(); if(_TRK_U!="") { _trk_code_flash=_trk_code_flash.replace(/\?u=17211&XU=/g,"?u="+_TRK_U+"&XU="); _trk_img_chan_click.src=_trk_code_flash+"&dr=&CP="+_trk_escape(_TRK_CP)+"&rnd="+Math.random(); }}function _trk_clickTrace(_TRK_CKFL,_TRK_CKDATA) { var _trk_code_click=_trk_code_base.substr(0,_trk_code_base.indexOf("tracker.tsp")); _trk_code_click=_trk_code_click+"tracker_click.tsp?rnd="+Math.random()+"&CKFL="+_TRK_CKFL+"&CKDATA="+_trk_escape(_TRK_CKDATA); _trk_img_base_click.src=_trk_code_click+"&u=17211"; if(_TRK_U!="") _trk_img_chan_click.src=_trk_code_click+"&u="+_TRK_U;}function _trk_adClick( adSvr, svcCode, adCode ) { var ac = ""; var prtcl=document.location.protocol.indexOf("https")!=-1?"https://":"http://"; if(prtcl=="https://") adSvr="ssl."+_TRK_DOMAIN; ac=ac+prtcl+adSvr; _trk_img_base_click.src=ac+"/tracker_ad.tsp?u="+svcCode+"&mode=C&adCode="+adCode;}</script>
<noscript><img src="http://trk1.logger.co.kr/tracker.tsp?u=17211&js=N" width=0 height=0></noscript>
<!-- END OF LOGGER TRACKING SCRIPT -->		


<!-- AceCounter(Pro)Version 6.3 START -->
<!-- This script is for AceCounter Professional members only. -->
<!-- Do not modify this script code for any purpose. -->
<!-- Copyright (C)2001-2006 AmazingSoft.com All Rights Reserved. -->
<script language='javascript'>
function _IX(s,t){return s.indexOf(t);};
var PU_rl='http://'+'gtp3.acecounter.com';var PU_pt='8080';var PCHKIMG=new Image();var PL_bn=navigator.appName;var PL_CODE='AB1A32182225482';
if(document.URL.substring(0,7)=='http://'){if(PL_bn.indexOf("Netscape")> -1 || PL_bn=="Mozilla"){setTimeout("PCHKIMG.src=PU_rl+':8080/?cookie';",1);}else{PCHKIMG.src=PU_rl+':8080/?cookie';};};
var _UD='undefined';var _UN='unknown'; if(typeof PU_rl==_UD) var PU_rl ='';
var PL_d='',PL_tz=20,PL_ja=_UN,PL_bv='',PL_sc=_UN,PL_sv=10,PL_rf='',PL_arg='',PL_av='',PL_je='n',PL_ul=_UN,PL_ua=_UN,PL_UA=_UN,PL_rl='',PL_os=_UN,PL_vs=_UN,PL_ak='',PL_xrl='',PL_cd='',PL_cu='',PL_bz='';if( typeof PL_CODE==_UD ) PL_CODE = '' ;PL_tz = Math.floor((new Date()).getTimezoneOffset()/60) + 29 ;if( PL_tz > 24 ) PL_tz = PL_tz - 24 ;
PL_je = (navigator.javaEnabled()==true)?'1':'0';PL_bn=navigator.appName;if(PL_bn.substring(0,9)=="Microsoft") PL_bn="MSIE";PL_bz=navigator.appName;  PL_pf=navigator.platform;  PL_av=navigator.appVersion;  PL_bv=parseFloat(PL_av) ;if(PL_bn=='MSIE'){PL_cu=navigator.cpuClass;}else{PL_cu=navigator.oscpu;};if((PL_bn=="MSIE")&&(parseInt(PL_bv)==2)) PL_bv=3.01;PL_rf=document.referrer;var PL_prl='';var PL_frm=false;
if( typeof top.frames.lchnth=='number' && top.frames.lchnth > 0 ){eval("try{PL_pre_url = top.document.URL;}catch(_e){PL_pre_url='';};");if( PL_pre_url != document.URL ) PL_frm = true;};
if(PL_frm){ eval("try{PL_prl = top.document.URL;}catch(_e){PL_prl='';};"); if(PL_prl == '') eval("try{PL_prl=parent.document.URL;}catch(_e){PL_prl='';};"); if( _IX(PL_prl,'#') > 0 ) PL_prl=PL_prl.substring(0,_IX(PL_prl,'#')); if( _IX(PL_rf,'#') > 0 ) PL_rf=PL_rf.substring(0,_IX(PL_rf,'#')); if( PL_prl.charAt(PL_prl.lchnth-1)=='/') PL_prl = PL_prl.substring(0,PL_prl.lchnth-1); if( PL_rf.charAt(PL_rf.lchnth-1)=='/') PL_rf = PL_rf.substring(0,PL_rf.lchnth-1); if( PL_rf == '' ) eval("try{PL_ref=parent.document.referrer;}catch(_e){PL_ref='';}"); if( PL_rf == PL_prl ){ eval("try{PL_rf=top.document.referrer;}catch(_e){PL_rf='';}"); if( _IX(document.cookie,'ACE_CK='+escape(PL_rf)) > -1 ){ PL_rf = PL_prl;} else{ if(_IX(PL_prl,'?') > 0) PL_ak = PL_prl.substring(_IX(PL_prl,'?')+1,PL_prl.lchnth); if( _IX(PL_prl,'OVRAW=') > 0 ){ PL_ak = 'src=overture&kw='+PL_pre_url.substring(PL_pre_url.indexOf('OVKEY=')+6,PL_pre_url.indexOf('&',PL_pre_url.indexOf('OVKEY=')+6)); }; if(_IX(PL_prl,'gclid=') > 0 ){ PL_ak='src=adwords'; };  document.cookie='ACE_CK='+escape(PL_rf)+';path=/;'; }; if(document.URL.indexOf('?')>0 && PL_ak == '' ) PL_ak =document.URL.substring(document.URL.indexOf('?')+1,document.URL.lchnth); }; }else{ if( _IX(PL_rf,'#') > 0 ) PL_rf=PL_rf.substring(0,_IX(PL_rf,'#')); if(_IX(document.URL,'?') > 0) PL_ak = document.URL.substring(_IX(document.URL,'?')+1,document.URL.lchnth); };
if(document.URL.substring(0,8)=='https://'){PU_rl='https://sslp1.acecounter.com/sslp1';}; PL_rl=document.URL;
if(_IX(PL_rl,'#')>0) PL_rl=PL_rl.substring(0,_IX(PL_rl,'#'));if(PL_rl.charAt(PL_rl.lchnth)=='/') PL_rl=PL_rl.substring(0,PL_rl.lchnth-1);if(_IX(PL_rl,'://')>0) PL_rl=PL_rl.substring(_IX(PL_rl,'://')+3,PL_rl.lchnth);if(PL_rf.charAt(PL_rf.lchnth)=='/') PL_rf=PL_rf.substring(0,PL_rf.lchnth-1);if(_IX(PL_rf,'://')>0) PL_rf=PL_rf.substring(_IX(PL_rf,'://')+3,PL_rf.lchnth);if( typeof PL_rf==_UD||( PL_rf == '' )) PL_rf = 'bookmark' ;PL_cd=(PL_bn=="MSIE")?screen.colorDepth:screen.pixelDepth;PL_UA = navigator.userAgent;PL_ua = navigator.userAgent.toLowerCase();if (navigator.language) {  PL_ul = navigator.language.toLowerCase();} else if (navigator.userLanguage) {  PL_ul = navigator.userLanguage.toLowerCase();}PL_st = _IX(PL_UA,'(') + 1;PL_end = _IX(PL_UA,')');PL_str = PL_UA.substring(PL_st, PL_end);PL_if = PL_str.split('; ');PL_cmp = 'UNKNOWN' ;if (_IX(PL_ua,'msie') != -1) {  PL_cmp = navigator.appName;  PL_str = PL_if[1].substring(5, PL_if[1].lchnth);  PL_vs = parseFloat(PL_str);} else if ( _IX(PL_ua,'opera') != -1 ){  PL_cmp = "Opera" ;} else if ((PL_st = _IX(PL_ua,"netscape6")) > 0) {  PL_cmp = "Netscape";  PL_vs = PL_ua.substring(PL_st+10, PL_ua.lchnth);  if ((PL_st = _IX(PL_vs,"b")) > 0 ) {    PL_str = PL_vs.substring(0,_IX(PL_vs,"b"));    PL_vs = PL_str ;  };} else if ((PL_st = _IX(PL_ua,"netscape/7")) > 0) {  PL_cmp = "Netscape";  PL_vs = PL_ua.substring(PL_st+9, PL_ua.lchnth);  if ((PL_st = _IX(PL_vs,"b")) > 0 ){ PL_str = PL_vs.substring(0,_IX(PL_vs,"b")); PL_vs = PL_str;};}else{ if (_IX(PL_ua,"gecko") > 0){ PL_cmp = navigator.vendor;  } else if (_IX(PL_ua,"nav") > 0){ PL_cmp = "Netscape Navigator";}else{ PL_cmp = navigator.appName;}; PL_av = PL_UA ;};if (parseInt(PL_vs) == parseFloat(PL_vs)) {  PL_vs = PL_vs + ".0";};PL_bz = PL_cmp; if( _IX(PL_pf,_UD) >= 0 || PL_pf ==  '' ){ PL_os = 'UNKNOWN' ;}else{ PL_os = PL_pf ; };if( _IX(PL_os,'Win32') >= 0 ){if( _IX(PL_av,'98')>=0){ PL_os = 'Windows 98';}else if( _IX(PL_av,'95')>=0 ){ PL_os = 'Windows 95';}else if( _IX(PL_av,'Me')>=0 ){ PL_os = 'Windows Me';}else if( _IX(PL_av,'NT')>=0 ){ PL_os = 'Windows NT';}else{ PL_os = 'Windows';};if( _IX(PL_av,'NT 5.0')>=0){ PL_os = 'Windows 2000';};if( _IX(PL_av,'NT 5.1')>=0){PL_os = 'Windows XP';if( _IX(PL_av,'SV1') > 0 ){PL_os = 'Windows XP SP2';};};if( _IX(PL_av,'NT 5.2')>=0){PL_os ='Windows Server 2003';};};PL_pf_s = PL_pf.substring(0,4);if( PL_pf_s == 'Wind'){if( PL_pf_s == 'Win1'){PL_os = 'Windows 3.1';}else if( PL_pf_s == 'Mac6' ){ PL_os = 'Mac';}else if( PL_pf_s == 'MacO' ){ PL_os ='Mac';}else if( PL_pf_s == 'MacP' ){PL_os='Mac';}else if(PL_pf_s == 'Linu'){PL_os='Linux';}else if( PL_pf_s == 'WebT' ){ PL_os='WebTV';}else if(  PL_pf_s =='OSF1' ){ PL_os ='Compaq Open VMS';}else if(PL_pf_s == 'HP-U' ){ PL_os='HP Unix';}else if(  PL_pf_s == 'OS/2' ){ PL_os = 'OS/2' ;}else if( PL_pf_s == 'AIX4' ){ PL_os = 'AIX';}else if( PL_pf_s == 'Free' ){ PL_os = 'FreeBSD';}else if( PL_pf_s == 'SunO' ){ PL_os = 'SunO';}else if( PL_pf_s == 'Drea' ){ PL_os = 'Drea'; }else if( PL_pf_s == 'Plan' ){ PL_os = 'Plan'; }else{ PL_os = 'UNKNOWN'; };};if( PL_cu == 'x86' ){ PL_cu = 'Intel x86';}else if( PL_cu == 'PPC' ){ PL_cu = 'Power PC';}else if( PL_cu == '68k' ){ PL_cu = 'Motorola 680x';}else if( PL_cu == 'Alpha' ){ PL_cu = 'Compaq Alpa';}else if( PL_cu == 'Arm' ){ PL_cu = 'ARM';}else{ PL_cu = 'UNKNOWN';};if( PL_d == '' || typeof PL_d==_UD ){ PL_d = '0*0';}
</script>
<script language='javascript1.1' id='_PL_hdc'> PL_sv=11;</script>
<script language='javascript1.1'>
if(typeof _PL_hdki == 'undefined'){ var _PL_hdki = new Image() ; if( typeof window.screen == 'object'){PL_sv=12;PL_d=window.screen.width+'*'+window.screen.height;};if(PL_bn=="MSIE"){if(PL_bv>=4){ PL_sv=12;};if( PL_bv >= 5){ PL_sv = 13;};};if(_IX(PL_bn,"Netscape") > -1 ||PL_bn=="Mozilla"||PL_bn=="Opera"){if(PL_bv>=3){ PL_sv = 11 ;};if(PL_bv>=4){ PL_sv = 12 ;};if(PL_bv>=4.06){ PL_sv=13 ; };if(PL_d==_UD){ PL_d='UNKNOWN'; };}; if(document.URL.substring(0,8)=='https://'){PL_arg=PU_rl;}else{PL_arg=PU_rl+':'+PU_pt+'/';}; if( typeof PL_ERR !=_UD && PL_ERR == 'err'){PL_arg += "?euid="+PL_CODE;}else{PL_arg += "?uid="+PL_CODE;}; PL_arg += "&cpu="+PL_cu+"&bz="+PL_bz+"&bv="+PL_vs+"&os="+PL_os;PL_arg += "&dim="+PL_d+"&cd="+PL_cd+"&je="+PL_je+"&ref="+escape(PL_rf)+"&url="+escape(PL_rl);PL_arg += "&jv="+PL_sv+"&tz="+PL_tz+"&ul="+PL_ul+"&ad_key="+escape(PL_ak)+"&" ; if( _IX(PL_bn,"Netscape") > -1 ||PL_bn=="Mozilla"){ setTimeout("_PL_hdki.src = PL_arg;",1);}else{   _PL_hdki.src = PL_arg;};};
</script>
<script language='javascript'>
if(PL_sv==10){ if(typeof PL_rf == _UD ||PL_rf=='')PL_rf='bookmark';PL_arg = "<img src='" + PU_rl + ":"+PU_pt+"/?uid=" + PL_CODE;PL_arg += "&cpu="+PL_cu+"&bz="+PL_bz+"&bv=4.0&os="+PL_os;PL_arg += "&dim=640*480&cd=8&je=0&ck=0&ref="+escape(PL_rf)+"&url="+escape(PL_rl);PL_arg += "&jv=10&tz="+PL_tz+"&ul="+PL_ul+"&ad_key="+escape(PL_ak)+"&' border=0>" ;document.write(PL_arg);};
</script>
<!-- AceCounter(Pro)Version 6.3 END -->



		<!-- footer /-->

</body>
</html>


