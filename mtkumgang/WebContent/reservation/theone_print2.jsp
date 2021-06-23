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


//��������
	//��������
	String cust_nm=""; //�� ����
	String regi_no=""; //�� �ֹι�ȣ
	String goods_nm=""; //��ǰ
	String accept_no = "";
	String rstat = "";//����
	String regtime=""; //��û�ð� (�ð�����)
	String client_nm = ""; //�븮����
	String tel_no = "";//�븮�� ��ȭ
	
	
	//��������
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

spa_yn	   = bean[0].getSpa_yn(); //��õ��÷ ����
	
}else{

}




%>



<html>
<head>
<title>����ƻ� �¶��� ���ࡡ����������������������������������������������������������������������������������������������������������</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<style type="text/css">
<!--
.style1 {
	color: #565656;
	font-family: "����", Verdana;
	font-size: 12px;
}
.style2 {
	color: #3F667D;
	font-family: "����", Verdana;
	font-size: 12px;
	font-weight: bold;
}
.style3 {
	color: #00A5D5;
	font-family: "����", Verdana;
	font-size: 11px;
}
.style4 {
	color: #000000;
	font-family: "����", Verdana;
	font-size: 11px;
}
.style5 {
	color: #565656;
	font-family: "����", Verdana;
	font-size: 12px;
	font-weight: bold;
}
.style6 {
	color: #00A5D5;
	font-family: "����", Verdana;
	font-size: 12px;
}
-->
</style>
<script language=javascript>
	//ī�� ������ �˾�
	function popReceipt(idx){
		var receiptURL ="http://admin.kcp.co.kr/Modules/Sale/Card/ADSA_CARD_BILL_Receipt.jsp?c_trade_no=" + idx;
	   	window.open(receiptURL,"cardReceipt","width=420,height=670,top=0,left=0");
	}



//Ȯ���� �˾�
function popConfirm(idx){
	var receiptURL ="theone_print.jsp?rsv_sid=" + idx;
   	window.open(receiptURL,"rsvConfirm","width=730,height=670,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize");

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
    <td width="75" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_09.gif" width="31" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td width="258" height="26" class="style1">&nbsp;<%=client_nm%></td>
    <td width="1" height="26" bgcolor="DDDDDD"></td>
    <td width="97" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_10.gif" width="67" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td height="26" class="style1">&nbsp;<%=tel_no%></td>
  </tr>
  <tr>
    <td height="1" colspan="7" bgcolor="424242"></td>
  </tr>

<%if(spa_yn.equals("Y")){%>
  <tr>
    <td height="46" colspan="7" class="style1">��<b>�� ������ <font color=#FF3300>"������ 5,000�� �ݰ��� ��õ ���� ����"</font> ������ ���� �� �ֽ��ϴ�~! </b><br>
		���� <b>"��õ ���� ����"</b> ���� ���δ� ���� ����� �� �ź������� Ȯ���� �帳�ϴ�.
	</td>
  </tr>
  <tr>
    <td height="1" colspan="7" bgcolor="424242"></td>
  </tr>
<%}%>


  <tr>
    <td height="33" colspan="7"  class="style3">* ������ ��¥���� ������� ���Աݽ�<span class="style4"> �������⡯</span> ���¿��� ����� �ǰ��Ͽ� ������ ��ҵ� �� �ֽ��ϴ�.<br>
    * ���ǻ����� <span class="style4">���� �븮�� �Ǵ� ���� �ݼ���(02-3669-3000)�� ����</span> �ٶ��ϴ�.</td>
  </tr>

  <%
	if(rstat.equals("����Ȯ��(�ԱݿϷ�)")){//�Ա��̸� Ȯ���� ��ư �����ֱ� 
  %>
  <tr>
    <td height="23" colspan="7"  class="style3">* �� Ȯ������ �ҵ������ �� ���� �������� ȿ���� �����ϴ�.</td>
  </tr>
  <tr>
    <td colspan="7" align="center"><a href="javascript:popConfirm('<%=idx%>')"><img src="<%=imageServer%>/reservation/img/btn_print.gif"  border=0></a></td>
  </tr>
  <%
	}
  %>
  <tr>
    <td colspan="7" align="right"><a href="javascript:window.close();")"><img src="<%=imageServer%>/tour_img/btn/btn_pop_close.gif"  border=0></a>&nbsp;&nbsp;&nbsp;</td>
  </tr>

</table>


</body>
</html>


