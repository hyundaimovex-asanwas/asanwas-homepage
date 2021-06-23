<%--
  - 작성자: 이소연
  - 일자: 2006.07.03
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 마이페이지>나의예약보기
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%
  String McNum = "0";
  String sub = "0";
  String pageNum = "2";
%>
<%
//request parameters
String r_mail = ParamUtil.getReqParameter(request.getParameter("r_mail"), "");
String r_pass = ParamUtil.getReqParameter(request.getParameter("r_pass"), "");
int idx	= Util.parseInt(request.getParameter("idx"), 1);

//변수선언

int cnt = 0;
int accept_sid = 0;
int tour_accept_sid = 0;
String tot_tour_amt = "0";
String tot_pay_amt = "0";
int tot_result_amt = 0;
String r_name = "";
String r_stdt = "";
String r_edt = "";
String regdate = "";
String regtime  = "";
String r_stat= "";
String r_tel= "";
String r_mob= "";
String depart_date= "";
String depart_date_str= "";
String arrive_date= "";
String nights= "";
String final_type = "";
String final_time = "";
String rscod = "";
String status_cd = "";
int sum_price = 0;
String saveDirName = "reservationUserLink";
String userImage = "";
String raccept_no = "";
String van_idx_no = "";

if (idx > 0){
    
	//DAO
	ReservationInfo dao = new ReservationInfo();
      //DTO
	Reservation_bean bean[] = dao.getRevInfo(idx);
	
	accept_sid= bean[0].getAccept_sid();
	cnt= bean[0].getCnt();
	//r_stat= bean[0].getRstat();
	
	//tot_tour_amt = NumberFormat.getInstance().format(tbean2.getTot_tour_amt());
	sum_price = bean[0].getSum_price();
	//sum_price= NumberFormat.getInstance().format(sum_price);
	
	r_name= bean[0].getRname();
	r_mail= bean[0].getRmail();
	r_edt= bean[0].getRedt();
	regdate = bean[0].getRegdate();
	regtime = bean[0].getRegtime();
	r_tel = bean[0].getRtel();
	r_mob = bean[0].getRmob();
	depart_date = bean[0].getDepart_date();
	depart_date_str = StringUtil.strReplace(depart_date,"-","");
	arrive_date = bean[0].getArrive_date();
	nights = bean[0].getNights();
	//tot_tour_amt = NumberFormat.getInstance().format(bean[0].getTot_tour_amt())+"원";
	final_type = bean[0].getFinal_type();
	final_time = bean[0].getFinal_time();
	rscod = bean[0].getRscod();
	raccept_no = bean[0].getAccept_no();
	van_idx_no = bean[0].getVan_idx_no();
	
}else{

}

File systemFile = null;
String saveDir  =  Config.getInstance().getProperty("imjkmd","reservationUserUpload");

%>
<html>
<head>
<title> 금강산관광   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script language="javascript">
<!--
  function PageMov(val) {
     if (val == "list"){
        document.form.action="reservation_list.jsp";
     }else if(val == "02"){
        document.form.action="reservation_02.jsp";
     }
     document.form.submit();
  }
  
  function PayMov(val,vbl,vcl,vdl,vel,vfl, vgl) {

     var form=document.payForm;
     form.c_pay_amt.value = val;
     form.r_order_nm.value = vbl;
     form.r_order_tel_no.value = vcl;
     form.r_order_e_mail.value = vdl;
     form.r_user_key.value = vel;
     form.rsv_sid.value = vfl;
     form.c_pay_manage_no.value = vgl;

     window.name = "mainpage";
     form.target = "actionFrame";
     form.action="http://com.hdasan.com/cPlugOnline.asp";
     form.submit();
  }

   function RevCancle(val,vbl,vcl,vdl) {
         var form=document.cancleForm;
         var cfm
	  cfm=confirm("예약 취소 하시겠습니까?")
	  if(cfm){ 
            form.pDepart_date.value = val;
            form.pAccept_sid.value = vbl;
            form.pU_ip.value = vcl;
            form.pRsv_sid.value = vdl;
            window.name = "mainpage";
            form.target = "actionFrame";
            form.action="reservation_process.jsp";
            form.submit();
        }
   }



	//	카드할인 팝
/*    if(getCookie("cardDC") != "done" )		// 불러온 쿠키의 값이 "done"이 아니면~
    {																	
		PopCard();
    };
	
	function PopCard(){
	   	window.open("/popup/pop061109.jsp","cardDC","width=438,height=193,top=0,left=0");
	}*/

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

	//카드 영수증 팝업
	function popReceipt(idx){
		var receiptURL ="http://admin.kcp.co.kr/Modules/Sale/Card/ADSA_CARD_BILL_Receipt.jsp?c_trade_no=" + idx;
	   	window.open(receiptURL,"cardReceipt","width=420,height=670,top=0,left=0");
	}

-->
</script>
</head>

<body onload="PopCard();">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/mypage/tour_mypage_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174" height="100%">
				<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td height="50%" valign="top">
			<!--  left menu flash -->
			<%@ include file="../../include/mypage/tour_mypage_left.jsp" %>
			<!--  left menu flash -->
					</td>
				</tr>
				<tr>
					<td height="50%" valign="bottom"><img src="<%=imageServer%>/tour_img/mypage/img_left_callcenter.jpg" width="174" height="46"></td>
				</tr>
				</table>
			</td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/mypage/tit_reservation.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">나의 예약정보</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="24"></td></tr>
				<tr>
					<td>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td>
								<table cellpadding="0" cellspacing="0" border="0">
								<tr><td height="13"></td></tr>
								<tr><td height="100" valign="top"><img src="<%=imageServer%>/tour_img/mypage/txt_reservation2.gif"></td></tr>
								<tr><td height="77" valign="top"><img src="<%=imageServer%>/tour_img/mypage/tab01_on.gif" class="btn"><img src="<%=imageServer%>/tour_img/mypage/tab02.gif" class="btn"><img src="<%=imageServer%>/tour_img/mypage/tab03.gif" class="btn"></td></tr>
								</table>
							</td>
							<td align="right"><img src="<%=imageServer%>/tour_img/mypage/img_reservation2.jpg"></td></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="530">
								<!-- / 예약내용 -->
								<table cellspacing="0" cellpadding="0" border="0" width="510">
								<tr>
								       <td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket01.gif" hspace="5"><!-- 예약내용 --></td>
								</tr>
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								<tr>
									<td width="88" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket01.gif"><!-- 여행기간 --></td>
									<td colspan="3"><%=depart_date%> ~ <%=arrive_date%></td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td width="88" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket02.gif"><!-- 숙박일수 --></td>
									<td width="166"><%=nights%></td>
									<td width="112"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket03.gif"><!-- 예약일시 --></td>
									<td width="144"><%=regdate%>&nbsp;<%=regtime%></td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket04.gif"><!-- 인원 --></td>
									<td><%=cnt%>명</td>
									<td><!--<img src="<%=imageServer%>/tour_img/mypage/txt_ticket05.gif">--><!-- 예약상태 --></td>
									<td><!--<%=final_type%>--></td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket06.gif"><!-- 총액 --></td>
									<td>
									<%=NumberFormat.getInstance().format(sum_price)%>
									</td>
									<td><img src="<%=imageServer%>/tour_img/mypage/txt_ticket07.gif"><!-- 결제마감일시 --></td>
									<td>
                                       <%
                                         if(final_type.equals("F")){
                                           out.println("<font color='red'>"+final_time+"</font>");
                                         }else{
                                           out.println(final_time);
                                         }
                                       %>
									</td>
								</tr>
								<tr><td height="1" colspan="4" class="line_dg"></td></tr>
								</table>
								<!-- 예약내용 / -->

								<!-- / 예약자정보 -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:30px;">
								<tr>
									<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket02.gif" hspace="5"><!-- 예약자정보 --></td>
								</tr>
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								<tr>
									<td width="102" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket21.gif"><!-- 예약자이름 --></td>
									<td width="139"><%=r_name%></td>
									<td width="85"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket22.gif"><!-- 이메일 --></td>
									<td width="184"><%=r_mail%></td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket23.gif"><!-- 핸드폰번호 --></td>
									<td><%=r_mob%></td>
									<td><img src="<%=imageServer%>/tour_img/mypage/txt_ticket24.gif"><!-- 전화번호 --></td>
									<td><%=r_tel%></td>
								</tr>
								<tr><td height="1" colspan="4" class="line_dg"></td></tr>
								</table>
								<!-- 예약자정보 / -->

<%
int cust_sid = 0;
int rsv_sid  = 0;
String cust_nm = "";
String regi_no = "";
String regi_yn = "";
String hotel_nm = "";
String room_nm = "";
String upjang_info = "";
String pre_upjang_info = "";
int upjang_sid = 0;
int room_type_sid = 0;
String rstat ="";  //결제여부
String tstat ="";  //개인정보기입여부
String adult = ""; //연령구분
String pay_yn = "";

//DAO2
ReservationInfo dao2 = new ReservationInfo();
// 관광객 목록

Reservation_bean record [] = dao2.getTourList(accept_sid);
%>

<% if(record.length <= 0){ %>	
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:30px;">
								<tr>
									<td valign="top" height="26" colspan="4">등록된 관광객 정보가 없습니다.</td>
								</tr>
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								</table>                      
<%}else{
    
	//리스트 화면에 전시
	int record_num = 0;
	pre_upjang_info = "";
	String manage_no="";
	ReservationInfo dao3 = new ReservationInfo();
	for(int i=0;i<record.length; i++){ 
		  Reservation_bean tbean2 = record[i];
		  rsv_sid  = tbean2.getRsv_sid();
                cust_sid = tbean2.getCust_sid();
                cust_nm = tbean2.getCust_nm();
                regi_no = tbean2.getRegi_no();
                regi_yn = tbean2.getRegi_yn();
                hotel_nm = tbean2.getHotel_nm();
                room_nm = tbean2.getRoom_nm();
                upjang_info = tbean2.getUpjang_info().trim();
                upjang_sid = tbean2.getUpjang_sid();
                room_type_sid = tbean2.getRoom_type_sid();
                tot_tour_amt = NumberFormat.getInstance().format(tbean2.getTot_tour_amt());
                tot_pay_amt = NumberFormat.getInstance().format(tbean2.getTot_pay_amt());
                tot_result_amt = tbean2.getTot_tour_amt() - tbean2.getTot_pay_amt();
                rstat = tbean2.getRstat();
                tstat = tbean2.getTstdt();
                tour_accept_sid = tbean2.getAccept_sid();
                status_cd = tbean2.getStatus_cd();
                pay_yn= tbean2.getPay_yn();
                
                systemFile = new File(saveDir+StringUtil.strReplace(regi_no,"-","")+".jpg");
                if(systemFile.exists()){
                   userImage = "/asanway/upload/reservationUserUpload/"+StringUtil.strReplace(regi_no,"-","")+".jpg";
                }else{
                   userImage = imageServer+"/tour_img/mypage/_temp_pic.gif";
                }
                
                manage_no = dao3.getManageNo(); //결제신청번호
%>


								<!-- / 숙소`객실`관광객정보 -->
            <%
            		if (pre_upjang_info == "" || !pre_upjang_info.equals(upjang_info)){ //호텔변경시(1)...
            %>
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:30px;">
								<tr>
									<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket03.gif" hspace="5"><!-- 숙소`객실`관광객정보 --></td>
								</tr>
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								<tr>
									<td width="65" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket31.gif"><!-- 숙소 --></td>
									<td width="175"><%=hotel_nm%></td>
									<td width="65"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket32.gif"><!-- 객실 --></td>
									<td width="205"><%=room_nm%></td>
								</tr>
								<tr><td height="1" colspan="5" class="line_dg"></td></tr>
								</table>
								<table cellspacing="1" cellpadding="1" border="0" width="510" style="margin:14 0 14 0px;" class="tabline">
								<tr align="center">
									<td class="bg_white" height="26">이름</td>
									<td class="bg_white">주민등록번호</td>
									<td class="bg_white">상세정보</td>
									<td class="bg_white">사진</td>
									<td class="bg_white">연령구분</td>
									<td class="bg_white">관광요금</td>
									<td class="bg_white">입금액</td>
									<td class="bg_white">결제여부</td>
									<td class="bg_white">예약취소</td>
								</tr>
	        <%
	            } //호텔변경시(1)...
	        %>

								<tr align="center">
									<td class="bg_white" height="26"><%=cust_nm%></td>
									<td class="bg_white"><%=regi_no%></td>
									<td class="bg_white">
									<%
									//out.println(rstat+"-"+tstat);
									  if (rstat.equals("미납") && tstat.equals("완료")){
									%>
									   <a href="javascript:;" onclick="window.open ('popup_useinfo.jsp?cust_sid=<%=cust_sid%>', 'userview', 'width=530,height=540,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize');">
									   <img src="<%=imageServer%>/tour_img/btn/btn_s_ok.gif"></a><!-- 완료 -->
								    <%
								      }else if (rstat.equals("미납") && tstat.equals("미입력")){
								    %>
									   <a href="javascript:;" onclick="window.open ('popup_useinfo.jsp?cust_sid=<%=cust_sid%>', 'userview', 'width=530,height=540,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize');">
									   <img src="<%=imageServer%>/tour_img/btn/btn_s_notinsert.gif"></a><!-- 미입력 -->
								    <%
                                      }else if(rstat.equals("완료")){
                                    %>
                                       <a href="javascript:alert('결제이후에는 수정할 수 없습니다.');"><img src="<%=imageServer%>/tour_img/btn/btn_s_ok.gif"></a>
                                    <%
                                      }else{
                                      
                                      }
								    %>
									</td>
									<td class="bg_white"><img src="<%=userImage%>" height=17 width=30></td>
									<td class="bg_white">성인</td>
									<td class="bg_white rpad_10" align="right"><%=tot_tour_amt%></td>
								       <td class="bg_white rpad_10" align="right">
								       <%
								            if(!tot_pay_amt.equals("0")){
								                 out.println(tot_tour_amt);
								            }else{
								                 out.println(tot_pay_amt);
								            }
								        %>
								        </td>
									<td class="bg_white">
									<%if( status_cd.equals("RA")  ||  status_cd.equals("DP")){%>
        									<%
        									  if (tstat.equals("완료") && pay_yn.equals("Y")){	//완료인 경우 영수증 띄우기
        									%>
        									    <a href="javascript:popReceipt('<%=van_idx_no%>')"><font color=red>결제완료</font></a>
        									    <!-- 결제완료 -->
        									<%
                                                                         }else if (tstat.equals("완료") && pay_yn.equals("")){  
        									%>
        									    <a href="javascript:PayMov(<%=tbean2.getTot_tour_amt()%>,'<%=cust_nm%>','<%=r_mob%>','<%=r_mail%>','금강산관광 <%=nights%>(<%=depart_date_str%>)','<%=rsv_sid%>','<%=manage_no%>');">
        									    <img src="<%=imageServer%>/tour_img/btn/btn_s_notaccount.gif">
        									    </a>
        									<%
                                                                        }else if (tstat.equals("미입력") && pay_yn.equals("")){  
        									%>
        									    <a href="javascript:;">
        									    <img src="<%=imageServer%>/tour_img/btn/btn_s_notaccount.gif" onclick="alert('상세정보를 입력하신 후 결제 가능 합니다.')">
        									    </a>
        									<%
                                                                        }else{
                                                                       
                                                                        }
        									%>
        							       <%}%>
									</td>
									<td class="bg_white">
									<%if(status_cd == "RA" ||  status_cd.equals("RA") ){%>
									    <%if(pay_yn.equals("") && final_type.equals("취소")){%>
									        <a href="javascript:;"><img src="<%=imageServer%>/tour_img/btn/btn_s_cancle.gif" onclick="alert('결제마감일이 경과되었습니다.')"></a>
								           <%}else{%>
								                  <%if(pay_yn.equals("Y")){%>
								                    <a href="javascript:;"><img src="<%=imageServer%>/tour_img/btn/btn_s_cancle.gif" onclick="alert('결제완료되었습니다.\n관리자에게 (우측정보)\n문의 바랍니다.')"></a>
								                  <%}else{%>
								                   <a href="javascript:;"><img src="<%=imageServer%>/tour_img/btn/btn_s_cancle.gif" onclick="RevCancle('<%=depart_date%>','<%=tour_accept_sid%>','<%=request.getRemoteAddr()%>','<%=rsv_sid%>')"></a>
								                  <%}%>
									    <%}%>
									    
									<%}else if( status_cd.equals("RR") ){%>
									         <font color=blud>예약취소신청중</fonr>
									<%}else if( status_cd.equals("RC") ){%>
									         <font color=red>예약취소완료</font>
								       <%}%>
									</td>
								</tr>
            <%
            		if (record_num > 0 && !pre_upjang_info.equals(upjang_info)){ //호텔변경시(2)...
            %>
								</table> 
	        <%
	                 } //호텔변경시(2)...
	                 
	               record_num = record_num +1;
	               pre_upjang_info = upjang_info; //호텔코드를 담는다..
	        %>
	        <%
	            }//for
	            
	         }//if
	         
	        %>
								<!-- 숙소`객실`관광객정보 / -->

								<!-- / 하단버튼 -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:14px;">
								  <tr><td height="1" colspan="2" class="line_dg"></td></tr>
								  <tr>
									<td height="53" colspan="2"><B>※ 결제여부란의 결제완료를 클릭하시면 <font size=3 color=blue>카드영수증</font>을 확인하실 수 있습니다.</B>
									</td>
								  </tr>
														
								<tr>
									<td><a href="javascript:PageMov('list');"><img src="<%=imageServer%>/tour_img/btn/btn_listgo.gif"></a><!-- 목록으로 --></td>
									
									 <td align="right">
									   <a href="javascript:PageMov('02');"><img src="<%=imageServer%>/tour_img/btn/btn_account.gif" class="btn"></a><!-- 결제하기 -->
                                                                <a href="javascript:;" onclick="window.open ('popup_reservation_ticket.jsp?idx=<%=idx%>', 'movieview', 'width=518,height=600,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_ticketview.gif"></a><!-- 예약티켓보기 -->
                                                                </td>
								</tr>

								</table>
								<!-- 하단버튼 / -->

							</td>
							<td width="160" style="padding-top:25px;">
								<table width="160" cellpadding="0" cellspacing="0" border="0" class="bg_sky3">
								<tr><td><img src="<%=imageServer%>/tour_img/mypage/tip_01.gif"></td></tr>
								<tr>
									<td class="txt_dblue fs11 lh13" style="padding:12 5 7 11px;"><strong>1) 주소</strong>: 시/도, 구/군, 동/면<br>까지 확인하며, 주민등록증<br>의 거주지와 대조하여 틀릴<br>경우 벌금이 부과됩니다.</td>
								</tr>
								<tr>
									<td class="txt_dblue fs11 lh13" style="padding:0 5 0 11px;"><strong>2) 직장/직위</strong>: 사실과 다를 경우 벌금이 부과되며,<br>반드시 현대아산 담당자와<br>통화하여 확인 받으시기<br>바랍니다.</td>
								</tr>
								<tr>
									<td class="txt_dblue fs11 lh13" style="padding:0 5 2 11px;">(☎ 현대아산 콜센터<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 02-3669-3000)</td>
								</tr>
								<tr>
									<td style="padding:0 5 10 11px;">
										<table width="100%" cellpadding="0" cellspacing="0" border="0">
										<tr>
											<td colspan="3" class="txt_dblue fs11 lh13" style="padding:5 0 7 0px;">--------- 예시 ---------</td>
										</tr>
										<tr valign="top">
											<td width="6"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_rec.gif" vspace="4"></td>
											<td width="37" class="txt_dblue fs11 lh13">주   부:</td>
											<td class="txt_dblue fs11 lh13">직장명에 주부,<br>직위에 공란</td>
										</tr>
										<tr valign="top">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_dblue_rec.gif" vspace="4"></td>
											<td class="txt_dblue fs11 lh13">자영업:</td>
											<td class="txt_dblue fs11 lh13">직장명에 상호,<br>직위에 대표.</td>
										</tr>
										<tr valign="top">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_dblue_rec.gif" vspace="4"></td>
											<td class="txt_dblue fs11 lh13">학   생:</td>
											<td class="txt_dblue fs11 lh13">직장명에 학생,<br>직위에 공란.</td>
										</tr>
										<tr valign="top">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_dblue_rec.gif" vspace="4"></td>
											<td class="txt_dblue fs11 lh13">대학생:</td>
											<td class="txt_dblue fs11 lh13">직장명에 OO대학교<br>직위에 학생</td>
										</tr>
										</table>
									</td>
								</tr>
								</table>

								<table cellpadding="0" cellspacing="0" border="0"><tr><td height="10"></td></tr></table>

								<table width="160" cellpadding="0" cellspacing="0" border="0" class="bg_lbrown">
								<tr><td><img src="<%=imageServer%>/tour_img/mypage/tip_02.gif"></td></tr>
								<tr>
									<td class="txt_brown fs11 lh13" style="padding:12 5 7 11px;"><strong>보내실 곳</strong>: (우110-793)<br>서울시 종로구 계동 140-2<br>현대빌딩12층 현대아산<br>온라인 담당자 앞</td>
								</tr>
								<tr>
									<td class="txt_brown fs11 lh13" style="padding:0 5 10 11px;">
									(사진 뒷면에 주민등록번호와<br>성함을 볼펜으로 적어주시기<br>바랍니다.)
									<br><br>
									 <strong>jpg 사진 파일 보내시는 방법 </strong>: miran@hdasan.com<br>
									 으로 이름, 주민등록번호, 사진 파일을 보내주세요
									 
									</td>
								</table>
							</td>
						</tr>
						</table>
						<!-- list table / -->
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
              <%@ include file="../../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>

<form name="form" method="post">
   <input type="hidden" name="r_mail" value="<%=r_mail%>">
   <input type="hidden" name="r_pass" value="<%=r_pass%>">
   <input type="hidden" name="idx" value="<%=idx%>">
</form>
<form name="payForm" method="post">
   <input type="hidden" name="r_user_key" >  <!--상품명-->
   <input type="hidden" name="c_pay_gubn" value="050">  <!--온라인결제구분-->
   <input type="hidden" name="c_pay_manage_no">  <!--결제관리번호-->
   <input type="hidden" name="c_return_url" value="http://www.mtkumgang.com/mypage/reservation/cResultOnline.jsp">  <!--리턴-->
   <input type="hidden" name="c_pay_amt">  <!--결제금액-->
   <input type="hidden" name="r_order_nm">  <!--주문자명-->
   <input type="hidden" name="r_order_tel_no">  <!--휴대폰번호-->
   <input type="hidden" name="r_order_e_mail">  <!--E-Mail-->
   <input type="hidden" name="rsv_sid">  <!--예약 SID (추가)-->
   
   <input type="hidden" name="c_terminal_id" value="단말기아뒤">
   <input type="hidden" name="c_acct_join_no" value="가맹번호">
   <input type="hidden" name="c_van_cd" value="밴코드">
</form>
<form name="cancleForm" method="post">
    <input type="hidden" name="pDepart_date">
    <input type="hidden" name="pAccept_sid">
    <input type="hidden" name="pRsv_sid">
    <input type="hidden" name="pU_ip">
</form>

<div id="payment" style="position:absolute;width:560px;height:10px;display:none">
<iframe name="actionFrame" width="560" frameborder="0" height="10" src="about:blank"></iframe>

</body>
</html>