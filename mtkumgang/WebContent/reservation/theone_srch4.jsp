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
String rmail = ParamUtil.getReqParameter(request.getParameter("rmail"), "");
String rpass = ParamUtil.getReqParameter(request.getParameter("rpass"), "");
int idx	= Util.parseInt(request.getParameter("idx"), 1);

//변수선언

int cnt = 0;
int accept_sid = 0;
String tot_tour_amt = "0";
String tot_pay_amt = "0";
String r_name = "";
String r_stdt = "";
String r_edt = "";
String regdate = "";
String regtime  = "";
String r_stat= "";
String r_tel= "";
String r_mob= "";
String depart_date= "";
String depart_date_str="";
String arrive_date= "";
String nights= "";
String final_type = "";
String final_time = "";
String rscod = "";
String goods_cd = "";
String goods_nm = "";
String status_cd = "";
String saveDirName = "reservationUserLink";
String userImage = "";
String raccept_no = "";
String van_idx_no = "";
String stat_txt ="";	//예약상태에 따른 버튼 표시	20090422

if (idx > 0){
    
	//DAO
	ReservationInfo dao = new ReservationInfo();
      //DTO
	Reservation_bean bean[] = dao.getRevInfo(idx);
	accept_sid= bean[0].getAccept_sid();
	
	cnt= bean[0].getCnt();
	r_stat= bean[0].getRstat();
	r_name= bean[0].getRname();
	rmail= bean[0].getRmail();
	r_edt= bean[0].getRedt();
	regdate = bean[0].getRegdate();
	regtime = bean[0].getRegtime();
	r_tel = bean[0].getRtel();
	r_mob = bean[0].getRmob();
	r_stat= bean[0].getRstat();

	depart_date = bean[0].getDepart_date();
	depart_date_str = StringUtil.strReplace(depart_date,"-","");
	arrive_date = bean[0].getArrive_date();
	nights = bean[0].getNights();
	//tot_tour_amt = NumberFormat.getInstance().format(bean[0].getTot_tour_amt())+"원";
	final_type = bean[0].getFinal_type();
	final_time = bean[0].getFinal_time();
	rscod = bean[0].getRscod();
	goods_cd = bean[0].getGoods_cd();
	goods_nm = bean[0].getGoods_nm();
	raccept_no = bean[0].getAccept_no();
//	van_idx_no = bean[0].getVan_idx_no();
	goods_nm= bean[0].getGoods_nm();

	if(r_stat.equals("1")){
		stat_txt="";
	}else if(r_stat.equals("2")){
		stat_txt="";
	}else if(r_stat.equals("3")){
		stat_txt="예약완료";
	}else if(r_stat.equals("4")){
		stat_txt="";
	}
}else{

}

File systemFile = null;
String saveDir  =  Config.getInstance().getProperty("imjkmd","reservationUserUpload");

%>
<html>
<head>
<title>현대아산 온라인 예약　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>

<script language="javascript">
<!--
  function PageMov(val) {
     if (val == "list"){
        document.form.action="theone_srch2.jsp";
     }
     document.form.submit();
  }
  
  
  function paySum(val,vbl,vcl,vdl,vel,vfl) {
     var form = document.myform;
     var form2 = document.payForm;
     
     var pay_sum = 0; 
     var r_order_nm = "";
     var r_order_tel_no = "";
     var r_order_e_mail = "";
     var rsv_sid = "";
     var u_pay_amt = "";
     var cnt = 0;

     for (num=0;num<form.tour_pay.length;num++){//for        
         if(form.tour_pay[num].checked == true && form.tour_pay[num].value !="0" ){//if
               pay_sum = pay_sum + parseInt(form.tour_pay[num].value);
               if(cnt < 1){
                if(form.cust_nm[num].value != ""){
                      form2.r_order_nm.value = form.cust_nm[num].value;//vbl
                      form2.r_order_tel_no.value = form.r_mob[num].value;//vcl
                      form2.r_order_e_mail.value = form.rmail[num].value;//vdl
                      form2.rsv_sid.value = form.rsv_sid[num].value;//vfl
                      form2.u_pay_amt.value = form.tour_pay[num].value;//val
                 }
               }else{
                 if(form.cust_nm[num].value != ""){
                    
                   form2.rsv_sid.value += "|"+form.rsv_sid[num].value;//vfl : 토큰에 들어가는 각 예약sid 
                   form2.u_pay_amt.value += "|"+form.tour_pay[num].value;//val : 토큰에 들어가는 각 결제금액
                 }
               }
               cnt = cnt +1;
         }else {//if

         }//if
     }//for
     
     
     form.pay_amt.value = pay_sum;
     if(pay_sum > 0){

         eval(pay_button).innerHTML="<a href='javascript:PayMov()'><img src='<%=imageServer%>/tour_img/btn/btn_account.gif' class='btn'></a>";
     }else{
			eval(pay_button).innerHTML="";
     }
     pay_sum = setComma(pay_sum);
     eval(pay_amt).innerHTML="결제하실 금액 :&nbsp;&nbsp;&nbsp;<span class='txt_sky b fs14'>"+pay_sum+"원</span>";

     
     //결제정보setting    
     var form2 = document.payForm;
     //테스트 금액
     //form2.c_pay_amt.value = "2007";
     form2.c_pay_amt.value = form.pay_amt.value;
	 //form2.u_pay_amt.value = u_pay_amt;
     //form2.r_order_nm.value = r_order_nm;
     //form2.r_order_tel_no.value = r_order_tel_no;
     //form2.r_order_tel_no.value = "123456789|123456789";
     //form2.r_order_e_mail.value = r_order_e_mail;
     //form2.rsv_sid.value = rsv_sid;
//alert(form2.rsv_sid.value);
//alert(form2.u_pay_amt.value);
  }
  
  
  function setComma(str) 
  { 
          str = ""+str+""; 
          var retValue = ""; 
          for(i=0; i<str.length; i++) 
          { 
                  if(i > 0 && (i%3)==0) { 
                          retValue = str.charAt(str.length - i -1) + "," + retValue; 
                   } else { 
                          retValue = str.charAt(str.length - i -1) + retValue; 
                  } 
          } 
          return retValue; 
  } 
 
  function PayMov()
  {
     var form=document.payForm;
     window.name = "mainpage";
     form.target = "actionFrame";
     <%
     String manage_no="";
     ReservationInfo dao3 = new ReservationInfo();
     //manage_no = dao3.getManageNo(); //결제신청번호
     %>
     //alert('<%=manage_no%>');
     form.c_pay_manage_no.value = '<%=dao3.getManageNo()%>';
     //alert(form.c_pay_manage_no.value);
     //return;
     form.action="http://com.hdasan.com/cPlugOnline.asp";
     
     //alert(form.r_order_tel_no.value);
     
     form.submit();
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

	//카드 영수증 팝업
	function popReceipt(idx){
		var receiptURL ="http://admin.kcp.co.kr/Modules/Sale/Card/ADSA_CARD_BILL_Receipt.jsp?c_trade_no=" + idx;
	   	window.open(receiptURL,"cardReceipt","width=420,height=670,top=0,left=0");
	}

	//확인증 팝업
	function popConfirm(idx){
		var receiptURL ="theone_print.jsp?rsv_sid=" + idx;
	   	window.open(receiptURL,"rsvConfirm","width=730,height=670,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize");

	}




-->
</script>
</head>

<body onload="paySum('');">

<table width="690" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td height="54"><img src="<%=imageServer%>/tour_img/mypage/tit_reservation.gif"></td>
  </tr>
  <tr>
    <td height="1px" bgcolor="E6E6E6"></td>
  </tr>
  <tr>
    <td height="16">&nbsp;</td>
  </tr>
  <tr>
    <td align=center>


		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td>
				<!-- / content  -->
<form name="myform" method="post">				
<input type="hidden" name="pay_amt">
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr>	
					<td style="padding:20 0 10 16"><img src="<%=imageServer%>/reservation/img/title_srch4.gif"></td>
				</tr>

				<tr>
					<td valign="top">
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="530"><br>
								<!-- / 관광객기본정보 -->


								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:30px;">
								  <tr>
									<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket03.gif" hspace="5"><!-- 숙소`객실`관광객정보 --></td>
								  </tr>
								  <tr><td height="2" colspan="4" class="line_dg"></td></tr>
								  <tr>
									<td width="90" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket51.gif"><!-- 숙소 --></td>
									<td width=420 colspan=3 align=left><%=goods_nm%></td>
								  </tr>
								  <tr><td height="1" colspan="5" class="line_dg"></td></tr>
								</table>
<%
int cust_sid = 0;
int rsv_sid  = 0;
int m_rsv_sid  = 0;
int pre_m_rsv_sid  = 0;
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
int tstat_cnt = 0;  //상세정보 미입력 count
String pay_yn = "";

//DAO2
ReservationInfo dao2 = new ReservationInfo();
// 관광객 목록

Reservation_bean record [] = dao2.getTourList(accept_sid);
%>

<% if(record.length <= 0){ %>
    
    
    
<%}else{

	//리스트 화면에 전시
	int record_num = 0;
	pre_upjang_info = "";
		
	for(int i=0;i<record.length; i++){ 
       Reservation_bean tbean2 = record[i];	
       rsv_sid  = tbean2.getRsv_sid();
	  m_rsv_sid = tbean2.getM_rsv_sid();
       //out.println(rsv_sid);
        cust_sid = tbean2.getCust_sid();
        cust_nm = tbean2.getCust_nm();
        regi_no = tbean2.getRegi_no();
        regi_yn = tbean2.getRegi_yn();
        hotel_nm = tbean2.getHotel_nm();
        room_nm = tbean2.getRoom_nm();
        upjang_info = tbean2.getUpjang_info();
        upjang_sid = tbean2.getUpjang_sid();
        room_type_sid = tbean2.getRoom_type_sid();
        tot_tour_amt = NumberFormat.getInstance().format(tbean2.getTot_tour_amt());
        tot_pay_amt = NumberFormat.getInstance().format(tbean2.getTot_pay_amt());
        rstat = tbean2.getRstat();
        tstat = tbean2.getTstdt();
        status_cd = tbean2.getStatus_cd();
        pay_yn= tbean2.getPay_yn();
		van_idx_no = tbean2.getVan_idx_no();

       systemFile = new File(saveDir+StringUtil.strReplace(regi_no,"-","")+".jpg");
       if(systemFile.exists()){
          userImage = "/asanway/upload/reservationUserUpload/"+StringUtil.strReplace(regi_no,"-","")+".jpg";
       }else{
          userImage = imageServer+"/tour_img/mypage/_temp_pic.gif";
       }
       
%>

            <%
            		if (pre_m_rsv_sid == 0 || pre_m_rsv_sid!=m_rsv_sid){ //방장변경시(1) 제목줄 넣기
            %>

								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin:14 0 0 0px;" class="tabline">
								  <tr height="18" align=center>
									<td class="bg_white"><%=hotel_nm%> - <%=room_nm%></td>
								  </tr>
								</table>
								<table cellspacing="1" cellpadding="1" border="0" width="510" style="margin:0 0 0 0px;" class="tabline">
								  <tr align="center" height="26">
									<td width=60 class="bg_white">이름</td>
									<td width=120 class="bg_white">주민등록번호</td>
									<td width=70 class="bg_white">연령구분</td>
									<td width=70 class="bg_white">관광요금</td>
									<td width=70 class="bg_white">입금액</td>
									<td width=60 class="bg_white">결제여부</td>
								  </tr>
	        <%
	            } //방장변경시(1)...
	        %>								
								<tr align="center">
									<td class="bg_white" height="26"><%=cust_nm%></td>
									<td class="bg_white"><%=regi_no%></td>
									<td class="bg_white">성인</td>
									<td class="bg_white rpad_10" align="right"><%=tot_tour_amt%></td>
									<td class="bg_white rpad_10" align="right"><%=tot_pay_amt%></td>																	
									<td class="bg_white">
									<%if( status_cd.equals("RA") ){%>
        										<%
        									 	   if (pay_yn.equals("Y")){	//완료인 경우 영수증 띄우기
        										%>
        									   	   <a href="javascript:popReceipt('<%=van_idx_no%>')"><img src="<%=imageServer%>/reservation/img/btn_paid.gif" border=0></a>
            									<%
            									   }else{
            									%>									
            									    <input type="checkbox" name="tour_pay" class="noborder" value="<%=tbean2.getTot_tour_amt()%>" onClick="paySum('<%=tbean2.getTot_tour_amt()%>','<%=cust_nm%>','<%=r_mob%>','<%=rmail%>','<%=rscod%>','<%=rsv_sid%>')">
            									    <input type="hidden" name="cust_nm" value="<%=cust_nm%>">
            									    <input type="hidden" name="r_mob" value="<%=r_mob%>">
            									    <input type="hidden" name="rmail" value="<%=rmail%>">
            									    <input type="hidden" name="rscod" value="<%=rscod%>">
            									    <input type="hidden" name="rsv_sid" value="<%=rsv_sid%>">
            									<%
            									   }
            									%>									
									<%}else if( status_cd.equals("RR") ){%>
									         <font color=blud>예약취소신청중</fonr>
									<%}else if( status_cd.equals("RC") ){%>
									         <font color=red>예약취소완료</font>
								       <%}%>
									
									</td>

								</tr>
            <%
            		if (record_num > 0 && pre_m_rsv_sid!=m_rsv_sid){ //방장변경시(2)...
            %>
		
								</table> 
	        <%
	                 } //방장변경시(2)...
	                 
	               record_num = record_num +1;
	               pre_m_rsv_sid = m_rsv_sid; //방장코드를 담는다.

	            }//for
        %>
        <input type="checkbox" name="tour_pay" style="display:none">
            <input type="hidden" name="cust_nm">
            <input type="hidden" name="r_mob">
            <input type="hidden" name="rmail">
            <input type="hidden" name="rscod">
            <input type="hidden" name="rsv_sid">
        <%
         }//if
         
        %>	 
								<!-- 총결제금액 -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin:14 0 0 0px;">
								<tr><td height="1" class="line_dg"></td></tr>
								  <tr>
									<td height="53" colspan="2"><B>※ <font color=red>결제완료</font>를 클릭하시면 신용카드 전표를 출력하실 수 있습니다.</B><br>

									</td>
								  </tr>


								<tr>
								  <td height="30" align="right" class="rpad_10" bgcolor="#F7F7F7">
									<div id="pay_amt"></div><!--결제금액보기-->
								  </td>
								</tr>
								</table>
								<!-- 관광객기본정보 / -->

								<!-- / 결제정보 -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:30px;">
								<tr>
									<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket05.gif" hspace="5"><!-- 결제정보 --></td>
								</tr>
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								<tr>
									<td width="88" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket51.gif"><!-- 상품명 --></td>
									<td width="173"><%=goods_nm%></td>
									<td width="98"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket52.gif"><!-- 신청서번호 --></td>
									<td width="151"><span class="txt_sky"><%=raccept_no%></span></td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket53.gif"><!-- 주문자명 --></td>
									<td><%=r_name%></td>
									<td><img src="<%=imageServer%>/tour_img/mypage/txt_ticket54.gif"><!-- 이메일 --></td>
									<td><%=rmail%></td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket55.gif"><!-- 전화번호 --></td>
									<td><%=r_tel%></td>
									<td><img src="<%=imageServer%>/tour_img/mypage/txt_ticket56.gif"><!-- 휴대폰 번호 --></td>
									<td><%=r_mob%></td>
								</tr>
								<tr><td height="1" colspan="4" class="line_dg"></td></tr>
								</table>
								<!-- 결제정보 / -->

								<!-- / 하단버튼 -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:14px;">
								  <tr>
									<td><a href="javascript:PageMov('list');"><img src="<%=imageServer%>/tour_img/btn/btn_listgo.gif"></a><!-- 목록으로 --></td>
									<td align="right">
                                    	<div id="pay_button"></div><!-- 결제하기 --><!-- 예약상세보기화면으로 -->
									</td>
								  </tr>
								</table>
								<!-- 하단버튼 / -->

							</td>
							<td width="160" style="padding-top:25px;">
								<table width="160" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/tour_img/mypage/tip_03.gif"></td></tr>
								<!--<tr><td class="tpad_10"><a href="javascript:;" onclick="window.open ('http://www.mtkumgang.com/mypage/reservation/popup_public_useguide.html', 'movieview', 'width=450,height=427,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/mypage/btn_desc_public.gif"></a></td></tr>-->
								<!--<tr><td class="tpad_5"><a href="javascript:;" onclick="window.open ('http://www.mtkumgang.com/mypage/reservation/popup_safeisp_useguide.html', 'movieview', 'width=450,height=320,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/mypage/btn_desc_safeisp.gif"></a></td></tr>-->
								</table>
							</td>
						</table>
						<!-- list table / -->
					</td>
				</tr>
				</table>
</form>				
				<!--  content / -->
			</td>
		</tr>
		</table>
		<!--------  center area /-------->
	</td>
  </tr>
  <tr>
    <td align="right"><a href="javascript:window.close();")"><img src="<%=imageServer%>/tour_img/btn/btn_pop_close.gif"  border=0></a>&nbsp;&nbsp;&nbsp;</td>
  </tr>


</table>
<br><br><br>
<form name="form" method="post">
   <input type="hidden" name="rmail" value="<%=rmail%>">
   <input type="hidden" name="rpass" value="<%=rpass%>">
   <input type="hidden" name="idx" value="<%=idx%>">
</form>
<form name="payForm" method="post">
   <input type="hidden" name="r_user_key" value="금강산관광 <%=nights%>(<%=depart_date_str%>)">  <!--상품명-->
   <input type="hidden" name="c_pay_gubn" value="050">  <!--온라인결제구분-->
   <input type="hidden" name="c_pay_manage_no">  <!--결제관리번호-->
   <input type="hidden" name="c_return_url" value="http://www.mtkumgang.com/reservation/cResultOnline2.jsp">  <!--리턴-->
   <input type="hidden" name="c_pay_amt">  <!--결제금액(총액)-->
   <input type="hidden" name="u_pay_amt">  <!--결제금액(개별)-->
   <input type="hidden" name="r_order_nm">  <!--주문자명-->
   <input type="hidden" name="r_order_tel_no">  <!--휴대폰번호-->
   <input type="hidden" name="r_order_e_mail">  <!--E-Mail-->
   <input type="hidden" name="rsv_sid">  <!--예약 SID (추가)-->
      
   <input type="hidden" name="c_terminal_id" value="단말기아뒤">
   <input type="hidden" name="c_acct_join_no" value="가맹번호">
   <input type="hidden" name="c_van_cd" value="밴코드">
</form>

<div id="payment" style="position:absolute;width:560px;height:530px;display:none">
<iframe name="actionFrame" width="560" frameborder="0" height="530" src="about:blank"></iframe>

</body>
</html>