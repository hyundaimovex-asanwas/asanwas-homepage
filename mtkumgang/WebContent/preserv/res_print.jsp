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
//request parameters
int idx	= Util.parseInt(request.getParameter("rsv_sid"), 1);


//변수선언
	//예약정보
	String cust_nm=""; //고객 성명
	String regi_no=""; //고객 주민번호
	String goods_nm=""; //상품
	String accept_no = "";
	String rstat = "";//상태
	String regtime=""; //신청시각 (시각포함)
	String client_nm = ""; //대리점명
	String tel_no = "";//대리점 전화
	
	
	//결제관련
	String pay_cd="";
	String pay_date="";
	String order_nm = "";
	int pay_amt = 0;
	String van_idx_no = "";
	String card_no="";
	String agree_no="";
	String app_no = "";
	String bank_nm = "";
	String bank_acct = "";
	   
   	String spa_yn= "";

if (idx > 0){
    
	//DAO
	ReservationInfo dao = new ReservationInfo();
      //DTO
	Reservation_bean bean[] = dao.getRsvConfirm18(idx);

	
cust_nm	   = bean[0].getCust_nm();
regi_no    = bean[0].getRegi_no();
goods_nm   = bean[0].getGoods_nm();  
accept_no  = bean[0].getAccept_no(); 
rstat      = bean[0].getRstat();   
regtime    = bean[0].getRegtime();   
client_nm  = bean[0].getClient_nm(); 
tel_no     = bean[0].getTel_no();    
pay_cd     = bean[0].getPay_cd();    
pay_date   = bean[0].getPay_date();  
order_nm   = bean[0].getOrder_nm();  
pay_amt    = bean[0].getPay_amt();   
van_idx_no = bean[0].getVan_idx_no();
card_no    = bean[0].getCard_no();   
agree_no   = bean[0].getAgree_no();  
app_no     = bean[0].getApp_no();    
bank_nm    = bean[0].getBank_nm();   
bank_acct  = bean[0].getBank_acct(); 

spa_yn	   = bean[0].getSpa_yn(); //온천당첨 여부
	
}else{

}




%>



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<style type="text/css">
<!--
.style1 {
	color: #565656;
	font-family: "돋움", Verdana;
	font-size: 12px;
}
.style2 {
	color: #3F667D;
	font-family: "돋움", Verdana;
	font-size: 12px;
	font-weight: bold;
}
.style3 {
	color: #00A5D5;
	font-family: "돋움", Verdana;
	font-size: 11px;
}
.style4 {
	color: #000000;
	font-family: "돋움", Verdana;
	font-size: 11px;
}
.style5 {
	color: #565656;
	font-family: "돋움", Verdana;
	font-size: 12px;
	font-weight: bold;
}
.style6 {
	color: #00A5D5;
	font-family: "돋움", Verdana;
	font-size: 12px;
}
-->
</style>
<script language=javascript>
	//카드 영수증 팝업
	function popReceipt(idx){
		var receiptURL ="http://admin.kcp.co.kr/Modules/Sale/Card/ADSA_CARD_BILL_Receipt.jsp?c_trade_no=" + idx;
	   	window.open(receiptURL,"cardReceipt","width=420,height=670,top=0,left=0");
	}
</script>
</head>

<body>
<table width="690" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="54"><img src="<%=imageServer%>/reservation/img/title_confirm.gif" border=0></td>
  </tr>
  <tr>
    <td height="1px" bgcolor="E6E6E6"></td>
  </tr>
</table>

<br>
<table width="690" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="30" colspan="7"><img src="<%=imageServer%>/reservation/img/img_c_04_01.gif" width="150" height="14"></td>
  </tr>
  <tr>
    <td height="2" colspan="7" bgcolor="424242"></td>
  </tr>
  <tr>
    <td width="75" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_01.gif" width="21" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td width="258" height="26" class="style2">&nbsp;<%=cust_nm%></td>
    <td width="1" height="26" bgcolor="DDDDDD"></td>
    <td width="97" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_02.gif" width="62" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td width="258" height="26" class="style1">&nbsp;<%=regi_no%></td>
  </tr>
  <tr>
    <td height="1" colspan="7" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td width="75" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_03.gif" width="41" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td width="258" height="26" class="style2">&nbsp;<%=goods_nm%></td>
    <td width="1" height="26" bgcolor="DDDDDD"></td>
    <td width="97" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_04.gif" width="52" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td width="258"height="26" class="style2">&nbsp;<%=accept_no%></td>
  </tr>
  <tr>
    <td height="1" colspan="7" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td width="75" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_15.gif" width="42" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td width="258" height="26" class="style1">&nbsp;<%=rstat%></td>
    <td width="1" height="26" bgcolor="DDDDDD"></td>
    <td width="97" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_06.gif" width="31" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td height="26" class="style1">&nbsp;<%=regtime%></td>
  </tr>
  <tr>
    <td height="1" colspan="7" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td width="75" height="26" bgcolor="F9F9F9" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_09.gif" width="31" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td width="258" height="26" class="style1">&nbsp;<%=client_nm%></td>
    <td width="1" height="26" bgcolor="DDDDDD"></td>
    <td width="97" height="26" bgcolor="F9F9F9" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_10.gif" width="67" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td height="26" class="style1">&nbsp;<%=tel_no%></td>
  </tr>
  <tr>
    <td height="1" colspan="7" bgcolor="424242"></td>
  </tr>

<%if(spa_yn.equals("Y")){%>
  <tr>
    <td height="46" colspan="7" class="style1">　<b>※ 고객님은 <font color=#FF3300>"선착순 5,000분 금강산 온천 무료 입장"</font> 혜택을 받을 수 있습니다~! </b><br>
		　　 <b>"온천 무료 입장"</b> 혜택 여부는 관광 출발할 때 신분증으로 확인해 드립니다.
	</td>
  </tr>
  <tr>
    <td height="1" colspan="7" bgcolor="424242"></td>
  </tr>
<%}%>


  <tr>
    <td height="66" colspan="7"  class="style3">* 지정된 날짜까지 관광요금 미입금시<span class="style4"> ‘예약대기’</span> 상태에서 약관에 의거하여 관광이 취소될 수 있습니다.<br>
    * 문의사항은 <span class="style4">예약 대리점 또는 본사 콜센터(02-3669-3000)로 문의</span> 바랍니다.</td>
  </tr>
</table>

<table width="690" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="30" colspan="7"><img src="<%=imageServer%>/reservation/img/img_c_04_02_3.gif" ></td>
  </tr>
  <tr>
    <td height="2" colspan="7" bgcolor="424242"></td>
  </tr>

  <tr>
    <td width="75" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_13.gif" width="42" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td width="258" height="26" class="style2">&nbsp;<%=pay_cd%></td>
    <td width="1" height="26" bgcolor="DDDDDD"></td>
    <td width="97" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_14.gif" width="31" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td height="26" class="style2">&nbsp;<%=pay_date%></td>
  </tr>
  <tr>
    <td height="1" colspan="7" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td width="75" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_11.gif" width="32" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td width="258" height="26" class="style2">&nbsp;<%=order_nm%></td>
    <td width="1" height="26" bgcolor="DDDDDD"></td>
    <td width="97" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_12.gif" width="42" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td width="258" height="26" class="style2">&nbsp;<%=pay_amt%></td>
  </tr>

  <%
	if(pay_cd.equals("신용카드 온라인결제")){
  %>

<!-- 신용카드 온라인결제-->
  <tr>
    <td height="1" colspan="7" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td width="75" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_11.gif" width="32" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td width="873" height="26" class="style2" COLSPAN=4>&nbsp;<a href="javascript:popReceipt('<%=van_idx_no%>')">영수증보기</a></td>
  </tr>
  <%
	}else if(pay_cd.equals("신용카드 전화승인")){
  %> 

<!--신용카드 전화승인-->
  <tr>
    <td height="1" colspan="7" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td width="75" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_17.gif"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td width="258" height="26" class="style2">&nbsp;<%=card_no%></td>
    <td width="1" height="26" bgcolor="DDDDDD"></td>
    <td width="97" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_18.gif"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td width="258" height="26" class="style2">&nbsp;<%=agree_no%></td>
  </tr>
  <%
	}else if(pay_cd.equals("가상계좌 입금")){
  %> 

<!--가상계좌 입금-->
  <tr>
    <td height="1" colspan="7" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td width="75" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_13.gif" width="42" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td width="258" height="26" class="style2">&nbsp;은행<%=bank_nm%></td>
    <td width="1" height="26" bgcolor="DDDDDD"></td>
    <td width="97" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_14.gif" width="31" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td height="26" class="style2">&nbsp;가상계좌번호<%=bank_acct%></td>
  </tr>
<!-- -->
  <%
	}
  %>
  <tr>
    <td height="1" colspan="7" bgcolor="#424242"></td>
  </tr>
		<tr>
    <td height="33" colspan="7"  class="style3">* 본 확인증은 소득공제용 및 지출 증빙으로 효력이 없습니다.</td>
  </tr>
		<tr>
    <td colspan="7" align="right"><!--<img src="<%=imageServer%>/reservation/img/btn_email.gif" width="78" height="20">&nbsp;--><a href="javascript:;" onclick="window.print();"><img src="<%=imageServer%>/reservation/img/btn_print.gif" width="77" height="20" border=0></a></td>
  </tr>
</table><br><br>

<table width="690" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="30" colspan="8"><img src="<%=imageServer%>/reservation/img/img_c_04_03.gif" width="64" height="16"></td>
  </tr>
		<tr>
		  <td width="25" align="right" class="style1"><img src="<%=imageServer%>/reservation/img/b.gif" width="3" height="5">&nbsp;</td>
    <td width="665" height="30" colspan="7" class="style1"><span class="style2">관광신청방법 :</span> 관광재개 후 당사 또는 예약하신 대리점에서 신청하실 수 있습니다.</td>
  </tr>
		<tr>
		  <td align="right" class="style2"><img src="<%=imageServer%>/reservation/img/b.gif" width="3" height="5">&nbsp;</td>
    <td height="24" colspan="7" class="style2">예약금의 환불</td>
  </tr>
		<tr>
		  <td align="right" class="style1">&nbsp;</td>
    <td height="61" colspan="7" class="style1"><span class="style5">환불비율</span><br>
    - 관광재개 이전 : 100%<br>
    - 관광재개 이후 관광신청이전 : 100%<br>
    - 관광재개 이후 관광신청이후 : 당사의 금강산/개성관광 표준약관에 따릅니다. </td>
  </tr>
		<tr>
		  <td align="right" class="style1">&nbsp;</td>
    <td height="51" colspan="7" class="style1"><span class="style5">환불신청방법</span><br>
    - 당사 또는 예약하신 대리점에 환불을 신청하시면 예약하신 고객님의 계좌로 입금해 드립니다.<br>
    - 고객님의 예약 철회 등과 관련하여 당사는 납입하신 예약금의 환불 외 별도의 책임은 부담하지 않습니다.</td>
  </tr>
		<tr>
		  <td align="right" class="style2"><img src="<%=imageServer%>/reservation/img/b.gif" width="3" height="5">&nbsp;</td>
    <td height="24" colspan="7" class="style2">할인율(금강산관광만 해당)</td>
  </tr>
		<tr>
		  <td align="right" class="style1">&nbsp;</td>
    <td colspan="7" class="style1">- 관광재개일 ~ 1개월 이하 : 50%<br>
    - 관광재개 후 1개월 초과 ~ 2개월 이하 : 40%<br>
    - 관광재개 후 2개월 초과 ~ 6개월 이하 : 30%</td>
  </tr>
		<tr>
		  <td align="right" class="style1">&nbsp;</td>
    <td height="83" colspan="7" class="style1">※ 요금(예시) : 평수기 주중 외금강호텔 스탠다드 성인 2인1실 기준(단위: 원) <img src="<%=imageServer%>/reservation/img/contents_04_01.gif" width="366" height="50"></td>
  </tr>
		<tr>
		  <td align="right" class="style1">&nbsp;</td>
    <td height="13" colspan="7" class="style1"> - 상기 관광요금은 2009년 2월 기준한 잠정 금액이며 향후 변경될 수 있습니다.<br>
												- 관광 신청시 관광 희망일에 먼저 신청한 인원으로 인해 해당 숙박시설이 예약 완료된 경우<br>
　고객님과 협의하여 관광일이 조정될 수 있습니다. </td>
  </tr>
		<tr>
		  <td align="right" class="style1">&nbsp;</td>
    <td height="30" colspan="7" class="style1">※ 개성관광의 경우 할인이 적용되지 않으나 관광신청일에 우선적으로 배정해 드리도록 노력하겠습니다.</td>
  </tr>
		<tr>
		  <td align="right" class="style2"><img src="<%=imageServer%>/reservation/img/b.gif" width="3" height="5">&nbsp;</td>
    <td height="33" colspan="7" class="style2">유의사항</td>
  </tr>
		<tr>
		  <td align="right" class="style1">&nbsp;</td>
    <td colspan="7" class="style1">- 타인 양도는 불가하며, 타 할인과 중복하여 적용되지 않습니다.<br>
	- 관광재개 후 고객님께서 관광을 신청하실 경우 당사에 건강이상 유무를 고지하여야 합니다.<br>
    - 당사는 고객님의 건강이상 기타 약관에 정한 사유로 관광이 어렵다고 판단될 경우 약관에 따라 관광계약의 체결을<br>
   &nbsp;&nbsp;거절하거나 관광을 중지할 수 있습니다.</td>
  </tr>
		<tr>
		  <td align="right" class="style1">&nbsp;</td>
    <td height="63" colspan="7" class="style1"> ※ 관광표준약관은 <span class="style6">홈페이지(http://www.mtkumgang.com(금강산), http://www.ikaesong.com(개성)) 또는 당사, 대리점<br>
    </span>&nbsp;&nbsp;&nbsp;&nbsp;등에서 확인 가능하며 관광 신청 전 내용을 확인하시기 바랍니다.</td>
  </tr>
</table>

</body>
</html>


