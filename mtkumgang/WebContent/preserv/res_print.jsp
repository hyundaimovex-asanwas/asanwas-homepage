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
    <td height="46" colspan="7" class="style1">��<b>�� ������ <font color=#FF3300>"������ 5,000�� �ݰ��� ��õ ���� ����"</font> ������ ���� �� �ֽ��ϴ�~! </b><br>
		���� <b>"��õ ���� ����"</b> ���� ���δ� ���� ����� �� �ź������� Ȯ���� �帳�ϴ�.
	</td>
  </tr>
  <tr>
    <td height="1" colspan="7" bgcolor="424242"></td>
  </tr>
<%}%>


  <tr>
    <td height="66" colspan="7"  class="style3">* ������ ��¥���� ������� ���Աݽ�<span class="style4"> �������⡯</span> ���¿��� ����� �ǰ��Ͽ� ������ ��ҵ� �� �ֽ��ϴ�.<br>
    * ���ǻ����� <span class="style4">���� �븮�� �Ǵ� ���� �ݼ���(02-3669-3000)�� ����</span> �ٶ��ϴ�.</td>
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
	if(pay_cd.equals("�ſ�ī�� �¶��ΰ���")){
  %>

<!-- �ſ�ī�� �¶��ΰ���-->
  <tr>
    <td height="1" colspan="7" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td width="75" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_11.gif" width="32" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td width="873" height="26" class="style2" COLSPAN=4>&nbsp;<a href="javascript:popReceipt('<%=van_idx_no%>')">����������</a></td>
  </tr>
  <%
	}else if(pay_cd.equals("�ſ�ī�� ��ȭ����")){
  %> 

<!--�ſ�ī�� ��ȭ����-->
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
	}else if(pay_cd.equals("������� �Ա�")){
  %> 

<!--������� �Ա�-->
  <tr>
    <td height="1" colspan="7" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td width="75" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_13.gif" width="42" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td width="258" height="26" class="style2">&nbsp;����<%=bank_nm%></td>
    <td width="1" height="26" bgcolor="DDDDDD"></td>
    <td width="97" height="26" style="padding-left:10px"><img src="<%=imageServer%>/reservation/img/txt_14.gif" width="31" height="12"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif" width="1" height="26"></td>
    <td height="26" class="style2">&nbsp;������¹�ȣ<%=bank_acct%></td>
  </tr>
<!-- -->
  <%
	}
  %>
  <tr>
    <td height="1" colspan="7" bgcolor="#424242"></td>
  </tr>
		<tr>
    <td height="33" colspan="7"  class="style3">* �� Ȯ������ �ҵ������ �� ���� �������� ȿ���� �����ϴ�.</td>
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
    <td width="665" height="30" colspan="7" class="style1"><span class="style2">������û��� :</span> �����簳 �� ��� �Ǵ� �����Ͻ� �븮������ ��û�Ͻ� �� �ֽ��ϴ�.</td>
  </tr>
		<tr>
		  <td align="right" class="style2"><img src="<%=imageServer%>/reservation/img/b.gif" width="3" height="5">&nbsp;</td>
    <td height="24" colspan="7" class="style2">������� ȯ��</td>
  </tr>
		<tr>
		  <td align="right" class="style1">&nbsp;</td>
    <td height="61" colspan="7" class="style1"><span class="style5">ȯ�Һ���</span><br>
    - �����簳 ���� : 100%<br>
    - �����簳 ���� ������û���� : 100%<br>
    - �����簳 ���� ������û���� : ����� �ݰ���/�������� ǥ�ؾ���� �����ϴ�. </td>
  </tr>
		<tr>
		  <td align="right" class="style1">&nbsp;</td>
    <td height="51" colspan="7" class="style1"><span class="style5">ȯ�ҽ�û���</span><br>
    - ��� �Ǵ� �����Ͻ� �븮���� ȯ���� ��û�Ͻø� �����Ͻ� ������ ���·� �Ա��� �帳�ϴ�.<br>
    - ������ ���� öȸ ��� �����Ͽ� ���� �����Ͻ� ������� ȯ�� �� ������ å���� �δ����� �ʽ��ϴ�.</td>
  </tr>
		<tr>
		  <td align="right" class="style2"><img src="<%=imageServer%>/reservation/img/b.gif" width="3" height="5">&nbsp;</td>
    <td height="24" colspan="7" class="style2">������(�ݰ�������� �ش�)</td>
  </tr>
		<tr>
		  <td align="right" class="style1">&nbsp;</td>
    <td colspan="7" class="style1">- �����簳�� ~ 1���� ���� : 50%<br>
    - �����簳 �� 1���� �ʰ� ~ 2���� ���� : 40%<br>
    - �����簳 �� 2���� �ʰ� ~ 6���� ���� : 30%</td>
  </tr>
		<tr>
		  <td align="right" class="style1">&nbsp;</td>
    <td height="83" colspan="7" class="style1">�� ���(����) : ����� ���� �ܱݰ�ȣ�� ���Ĵٵ� ���� 2��1�� ����(����: ��) <img src="<%=imageServer%>/reservation/img/contents_04_01.gif" width="366" height="50"></td>
  </tr>
		<tr>
		  <td align="right" class="style1">&nbsp;</td>
    <td height="13" colspan="7" class="style1"> - ��� ��������� 2009�� 2�� ������ ���� �ݾ��̸� ���� ����� �� �ֽ��ϴ�.<br>
												- ���� ��û�� ���� ����Ͽ� ���� ��û�� �ο����� ���� �ش� ���ڽü��� ���� �Ϸ�� ���<br>
�����԰� �����Ͽ� �������� ������ �� �ֽ��ϴ�. </td>
  </tr>
		<tr>
		  <td align="right" class="style1">&nbsp;</td>
    <td height="30" colspan="7" class="style1">�� ���������� ��� ������ ������� ������ ������û�Ͽ� �켱������ ������ �帮���� ����ϰڽ��ϴ�.</td>
  </tr>
		<tr>
		  <td align="right" class="style2"><img src="<%=imageServer%>/reservation/img/b.gif" width="3" height="5">&nbsp;</td>
    <td height="33" colspan="7" class="style2">���ǻ���</td>
  </tr>
		<tr>
		  <td align="right" class="style1">&nbsp;</td>
    <td colspan="7" class="style1">- Ÿ�� �絵�� �Ұ��ϸ�, Ÿ ���ΰ� �ߺ��Ͽ� ������� �ʽ��ϴ�.<br>
	- �����簳 �� ���Բ��� ������ ��û�Ͻ� ��� ��翡 �ǰ��̻� ������ �����Ͽ��� �մϴ�.<br>
    - ���� ������ �ǰ��̻� ��Ÿ ����� ���� ������ ������ ��ƴٰ� �Ǵܵ� ��� ����� ���� ��������� ü����<br>
   &nbsp;&nbsp;�����ϰų� ������ ������ �� �ֽ��ϴ�.</td>
  </tr>
		<tr>
		  <td align="right" class="style1">&nbsp;</td>
    <td height="63" colspan="7" class="style1"> �� ����ǥ�ؾ���� <span class="style6">Ȩ������(http://www.mtkumgang.com(�ݰ���), http://www.ikaesong.com(����)) �Ǵ� ���, �븮��<br>
    </span>&nbsp;&nbsp;&nbsp;&nbsp;��� Ȯ�� �����ϸ� ���� ��û �� ������ Ȯ���Ͻñ� �ٶ��ϴ�.</td>
  </tr>
</table>

</body>
</html>


