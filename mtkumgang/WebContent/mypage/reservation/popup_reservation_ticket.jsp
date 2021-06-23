<%--
  - �ۼ���: �̼ҿ�
  - ����: 2006.07.03
  - ���۱� ǥ��: IMJ Korea
  - ����: ������ - ����������>���ǿ��ຸ��
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%
  String pageNum = "2";
%>
<%
//request parameters
int idx	= Util.parseInt(request.getParameter("idx"), 1);

//��������
String r_mail = "";
String r_pass = "";
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
String arrive_date= "";
String nights= "";
String final_type = "";
String final_time = "";
int sum_price = 0;
String saveDirName = "reservationUserLink";
String userImage = "";
String raccept_no = "";

if (idx > 0){
    
	//DAO
	ReservationInfo dao = new ReservationInfo();
    //DTO
	Reservation_bean bean[] = dao.getRevInfo(idx);
	accept_sid= bean[0].getAccept_sid();
	
	cnt= bean[0].getCnt();
	r_stat= bean[0].getRstat();
	r_name= bean[0].getRname();
	r_mail= bean[0].getRmail();
	r_edt= bean[0].getRedt();
	regdate = bean[0].getRegdate();
	regtime = bean[0].getRegtime();
	r_tel = bean[0].getRtel();
	r_mob = bean[0].getRmob();
	depart_date = bean[0].getDepart_date();
	arrive_date = bean[0].getArrive_date();
	nights = bean[0].getNights();
	//tot_tour_amt = NumberFormat.getInstance().format(bean[0].getTot_tour_amt())+"��";
	sum_price = bean[0].getSum_price();
	final_type = bean[0].getFinal_type();
	final_time = bean[0].getFinal_time();
	raccept_no = bean[0].getAccept_no();
	
}else{

}
File systemFile = null;
String saveDir  =  Config.getInstance().getProperty("imjkmd","reservationUserUpload");
%>
<html>
<head>
<title>�ݰ������  </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
</script>
</head>

<body class="popmargin">

<!-- �˾������� : 519 * 600 ���ν�ũ�ѻ����.. -->
<table cellspacing="0" cellpadding="0" border="0" width="470">
<tr>
	<td>
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/mypage/pop_tit_ticket.gif"><!-- Ÿ��Ʋ --></td></tr>
		<tr><td colspan="2" height="30"></td></tr>
		<tr>
			<td height="19" class="lpad_10"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_arw.gif" hspace="3" vspace="2" align="texttop"><span class="b txt_dblue">��û�� ��ȣ : </span><span class="txt_sky"><%=raccept_no%></span></td>
			<td align="right" class="rpad_10 fs11">�����û�� : <%=regdate%></td>
		</tr>
		<tr><td colspan="2" height="2" class="tabline"></td></tr>
		</table>
	</td>
</tr>
<tr>
	<td valign="top" align="center">
		<!-- / ���೻�� -->
		<table cellspacing="0" cellpadding="0" border="0" width="470" style="margin-top:20px;">
		<tr>
			<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket01.gif" hspace="5"><!-- ���೻�� --></td>
		</tr>
		<tr><td height="2" colspan="4" class="line_dg"></td></tr>
		<tr>
			<td width="88" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket01.gif"><!-- ����Ⱓ --></td>
			<td colspan="3"><%=depart_date%> ~ <%=arrive_date%></td>
		</tr>
		<tr><td height="1" colspan="4" class="tabline"></td></tr>
		<tr>
			<td width="88" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket02.gif"><!-- �����ϼ� --></td>
			<td width="146"><%=nights%></td>
			<td width="112"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket03.gif"><!-- �����Ͻ� --></td>
			<td width="124"><%=regdate%>&nbsp;<%=regtime%></td>
		</tr>
		<tr><td height="1" colspan="4" class="tabline"></td></tr>
		<tr>
			<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket04.gif"><!-- �ο� --></td>
			<td><%=cnt%>��</td>
			<td><img src="<%=imageServer%>/tour_img/mypage/txt_ticket05.gif"><!-- ������� --></td>
			<td><%=final_type%></td>
		</tr>
		<tr><td height="1" colspan="4" class="tabline"></td></tr>
		<tr>
			<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket06.gif"><!-- �Ѿ� --></td>
			<td><%=NumberFormat.getInstance().format(sum_price)%></td>
			<td><img src="<%=imageServer%>/tour_img/mypage/txt_ticket07.gif"><!-- ���������Ͻ� --></td>
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
		<!-- ���೻�� / -->

		<!-- / ���������� -->
		<table cellspacing="0" cellpadding="0" border="0" width="470" style="margin-top:30px;">
		<tr>
			<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket02.gif" hspace="5"><!-- ���������� --></td>
		</tr>
		<tr><td height="2" colspan="4" class="line_dg"></td></tr>
		<tr>
			<td width="102" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket21.gif"><!-- �������̸� --></td>
			<td width="119"><%=r_name%></td>
			<td width="85"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket22.gif"><!-- �̸��� --></td>
			<td width="164"><%=r_mail%></td>
		</tr>
		<tr><td height="1" colspan="4" class="tabline"></td></tr>
		<tr>
			<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket23.gif"><!-- �ڵ�����ȣ --></td>
			<td><%=r_mob%></td>
			<td><img src="<%=imageServer%>/tour_img/mypage/txt_ticket24.gif"><!-- ��ȭ��ȣ --></td>
			<td><%=r_tel%></td>
		</tr>
		<tr><td height="1" colspan="4" class="line_dg"></td></tr>
		</table>
		<!-- ���������� / -->

<%
int cust_sid = 0;
String cust_nm = "";
String regi_no = "";
String regi_yn = "";
String hotel_nm = "";
String room_nm = "";
String upjang_info = "";
String pre_upjang_info = "";
int upjang_sid = 0;
int room_type_sid = 0;
String rstat ="";  //��������
String tstat ="";  //�����������Կ���
int tstat_cnt = 0;  //������ ���Է� count

//DAO2
ReservationInfo dao2 = new ReservationInfo();
// ������ ���

Reservation_bean record [] = dao2.getTourList(accept_sid);
%>

<% if(record.length <= 0){ %>
    

<%}else{

	//����Ʈ ȭ�鿡 ����
	
	int record_num = 0;
	pre_upjang_info = "";
	for(int i=0;i<record.length; i++){ 
		Reservation_bean tbean2 = record[i];
		
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
        
                systemFile = new File(saveDir+StringUtil.strReplace(regi_no,"-","")+".jpg");
                if(systemFile.exists()){
                   userImage = "/asanway/upload/reservationUserUpload/"+StringUtil.strReplace(regi_no,"-","")+".jpg";
                }else{
                   userImage = imageServer+"/tour_img/mypage/_temp_pic.gif";
                }  
            
%>
    
		    <!-- / ����`����`���������� -->
            <%
            		if (pre_upjang_info == "" || !pre_upjang_info.equals(upjang_info)){ //ȣ�ں����(1)...
            %>
            
		         <table cellspacing="0" cellpadding="0" border="0" width="470" style="margin-top:30px;">
		         <tr>
		         	<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket03.gif" hspace="5"><!-- ����`����`���������� --></td>
		         </tr>
		         <tr><td height="2" colspan="4" class="line_dg"></td></tr>
		         <tr>
		         	<td width="65" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket31.gif"><!-- ���� --></td>
		         	<td width="155"><%=hotel_nm%></td>
		         	<td width="65"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket32.gif"><!-- ���� --></td>
		         	<td width="185"><%=room_nm%></td>
		         </tr>
		         <tr><td height="1" colspan="4" class="line_dg"></td></tr>
		         </table>
		         <!-- ����`����`���������� / -->
                 
		         <!-- / ����`����`���������� -->
		         <table cellspacing="1" cellpadding="1" border="0" width="470" style="margin:14 0 14 0px;" class="tabline">
		         <tr align="center">
		         	<td class="bg_white fs11" height="26">�̸�</td>
		         	<td class="bg_white fs11">�ֹε�Ϲ�ȣ</td>
		         	<td class="bg_white fs11">������</td>
		         	<td class="bg_white fs11">����</td>
		         	<td class="bg_white fs11">����</td>
		         	<td class="bg_white fs11">�������</td>
		         	<td class="bg_white fs11">�Աݾ�</td>
		         	<td class="bg_white fs11">��������</td>
		         </tr>
	        
	        <%
	            } //ȣ�ں����(1)...
	        %>
	        
                 <tr align="center">
                 	<td class="bg_white" height="26"><%=cust_nm%></td>
                 	<td class="bg_white"><%=regi_no%></td>
                 	<td class="bg_white">
                 	<%
                 	  if (tstat.equals("�Ϸ�")){
                 	%>
                 	   <img src="<%=imageServer%>/tour_img/btn/btn_s_ok.gif"><!-- �Ϸ� -->
                     <%
                       }else if (tstat.equals("���Է�")){
                       tstat_cnt = tstat_cnt +1;
                     %>
                 	   <img src="<%=imageServer%>/tour_img/btn/btn_s_notinsert.gif"><!-- ���Է� -->								    
                     <%
                       }else{
                       
                       }
                     %>
                 	</td>
                 	<td class="bg_white"><img src="<%=userImage%>" height=17 width=30></td>
                 	<td class="bg_white">����</td>
                 	<td class="bg_white rpad_10" align="right"><%=tot_tour_amt%></td>
                 	<td class="bg_white rpad_10" align="right"><%=tot_pay_amt%></td>
                 	<td class="bg_white">
                 	<%
                 	  if (rstat.equals("�ϳ�")){
                 	%>
                 	    <img src="<%=imageServer%>/tour_img/btn/btn_s_accountok.gif"><!-- �����Ϸ� -->
                 	<%
                       }else if (rstat.equals("�̳�")){  
                 	%>
                 	    <img src="<%=imageServer%>/tour_img/btn/btn_s_notaccount.gif">
                 	<%
                       }else{
                       
                       }
                 	%>
                 	</td>
                 </tr>
									        
            <%
            		if (record_num > 0 && !pre_upjang_info.equals(upjang_info)){ //ȣ�ں����(2)...
            %>
								</table>
	        <%
	                 } //ȣ�ں����(2)...
	               
	               record_num = record_num +1;
	               pre_upjang_info = upjang_info; //ȣ���ڵ带 ��´�..
	        %>
	        <%
	            }//for
	            
	         }//if
	         
	        %>	
	        
		<!-- ����`����`���������� / -->
		<!-- / �Ǹ޴� -->
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr><td height="1" class="line_dg"><img src="<%=imageServer%>/tour_img/spacer.gif" width="1" height="1" name="top"></td></tr>
		<tr><td height="20"></td></tr>
		<tr><td><img src="<%=imageServer%>/tour_img/mypage/20061108present.jpg" border=0><!-- �̺�Ʈ �ȳ� --></TD></TR>
		<tr><td height="20"></td></tr>
		<tr>
			<td><a href="#01"><img src="<%=imageServer%>/tour_img/mypage/tab_ticket01.gif" onmouseover="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket01_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket01.gif'"></a><a href="#02"><img src="<%=imageServer%>/tour_img/mypage/tab_ticket02.gif" onmouseover="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket02_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket02.gif'"></a><a href="#03"><img src="<%=imageServer%>/tour_img/mypage/tab_ticket03.gif" onmouseover="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket03_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket03.gif'"></a><a href="#04"><img src="<%=imageServer%>/tour_img/mypage/tab_ticket04.gif" onmouseover="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket04_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket04.gif'"></a><a href="#05"><img src="<%=imageServer%>/tour_img/mypage/tab_ticket05.gif" onmouseover="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket05_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket05.gif'"></a><a href="#06"><img src="<%=imageServer%>/tour_img/mypage/tab_ticket06.gif" onmouseover="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket06_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket06.gif'"></a><a href="#07"><img src="<%=imageServer%>/tour_img/mypage/tab_ticket07.gif" onmouseover="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket07_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/mypage/tab_ticket07.gif'"></a></td>
		</tr>
		<tr><td height="30"></td></tr>
		</table>
		<!-- �Ǹ޴� / -->

		<!-- / ����Ȯ������ -->
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr valign="top">
			<td width="43"><img src="<%=imageServer%>/tour_img/mypage/01.gif" hspace="12"></td>
			<td width="427">
				<table cellspacing="0" cellpadding="0" border="0" width="427">
				<tr><td colspan="2" height="23" valign="top"><img src="<%=imageServer%>/tour_img/mypage/pop_stit_01.gif" name="01"></td></tr>
				<tr valign="top">
					<td width="16">��</td>
					<td width="411"><span class="txt_sky"><u><%=r_name%></u></span> ���� ������ <span class="txt_sky"><u><%=regdate%>&nbsp;<%=regtime%></u></span> �� �����Ǿ����ϴ�.</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td>��</td>
					<td>�Է��Ͻ� �̸��ϰ� ��й�ȣ�� ��û�� ������ ������¸� ��ȸ�ϰ�<br>��Ÿ ������ �����ϴµ� �ʿ��Ͽ��� �� �޸��� �νñ� �ٶ��ϴ�.</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td>��</td>
					<td>�������� ������ �Է� �� ������� ������  <span class="txt_sky"><u><%=final_time%></u></span> ����<br>�̷������ ������ �ڵ���� ���� �˷��帳�ϴ�.</td>
				</tr>
				<tr><td colspan="2" height="5"></td></tr>
				<tr valign="top">
					<td></td>
					<td>- �ݰ������  �� ��Ÿ ������ �޸� '����'���� �湮�ϴ� ��ǰ�̹Ƿ�<br>&nbsp;&nbsp;&nbsp;������ �������Է¿� �Ű�� �ֽñ� �ٶ��ϴ�.<br>- �Ʒ� ������ ��ǰ� �ٸ� ��� ���� ����˻�ҿ��� ������ �ΰ��Ͽ���<br>&nbsp;&nbsp;&nbsp;�������� ���ϴ� ���� ������ �����ϰ� �Է��� �ֽñ� �ٶ��ϴ�.</td>
				</tr>
				<tr><td colspan="2" height="5"></td></tr>
				<tr valign="top">
					<td></td>
					<td class="lpad_10">1) �ּ� : ��/��, ��/��, ��/�� ���� Ȯ���ϸ�, �ֹε������ ��������<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�����Ͽ� Ʋ�� ��� ������ �ΰ��˴ϴ�.<br>2) ���� / ���� : ���� ��ǰ� �ٸ� ��� ������ �ΰ��Ǹ�, �ݵ��<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����ƻ� ����ڿ� ��ȭ�Ͽ� Ȯ�ι����ñ� �ٶ��ϴ�.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(�� ����ƻ� �¶��δ���� : 02-3669-3000)</td>
				</tr>
				<tr><td colspan="2" height="5"></td></tr>
				<tr valign="top">
					<td></td>
					<td><u>* ���� *</u><br>- �ֺ� = ����� �ֺ�, ������ ����<br>- �ڿ��� = ����� ��ȣ, ������ ��ǥ<br>- �л� = ����� �л�, ������ ����<br>- ���л� = ����� �ۡ۴��б�, ������ �л�</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td>��</td>
					<td>�ݰ������   ����Ʈ ����ȭ�鿡�� [�¶��ο��� ���Ŭ��] ><br>[����Ȯ���ϱ�] �� ���ø� ������ �Է� �� ������� ������<br>�Ͻ� �� �ֽ��ϴ�.</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td>��</td>
					<td>�������� ������ JPG�� ��ĵ�Ͽ� ���ε��Ͻðų� �������� 1�Ÿ� ����<br>�ּž� �մϴ�.<br>������ ������ ���� ���� �޸鿡 �������� �ֹε�Ϲ�ȣ�� ������ ��<br>�����ֽñ� �ٶ��ϴ�.<br>
					- <strong>������ ��</strong> : (��.110-793) ����� ���α� �赿 1410-2 �������<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�¶��� ����� ��</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td>��</td>
					<td>������� ������ �ſ�ī�� ����, ������ü�� �����ϰ� �ֽ��ϴ�.<br>���� ��� ������������ �ʿ��Ͽ���(�ſ�ī������� ī��� �������ʿ�)<br>�ŷ� �������Ʈ Ȥ�� �ŷ� ī�����Ʈ���� ������������ �߱޹����ñ�<br>�ٶ��ϴ�.</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td>��</td>
					<td>��Ÿ ������ ���� ���Ǵ� �� ����ƻ� �ݼ��� 02-3669-3000�� �̿���<br>�ֽø� �˴ϴ�.</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr><td colspan="2" align="right"><a href="#top"><img src="<%=imageServer%>/tour_img/btn/btn_top2.gif" class="btn"></a></td></tr>
		<tr><td colspan="2" style="padding:4 0 30 0px;"><img src="<%=imageServer%>/tour_img/mypage/hline470.gif"></td></tr>
		</table>
		<!-- ����Ȯ������ / -->

		<!-- / �������ȳ� -->
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr valign="top">
			<td width="43"><img src="<%=imageServer%>/tour_img/mypage/02.gif" hspace="12"></td>
			<td width="427">
				<table cellspacing="0" cellpadding="0" border="0" width="416">
				<tr><td colspan="2" height="23" valign="top"><img src="<%=imageServer%>/tour_img/mypage/pop_stit_02.gif" name="02"></td></tr>
				<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/mypage/pop_img_21.gif"></td></tr>
				<tr><td colspan="2" height="20"></td></tr>
				<tr valign="top">
					<td width="16"><strong>1.</strong></td>
					<td width="400"><strong>ž�� ���ӽð� (������ �����ð�)</strong><br>- 2�� 3�� : 14:30<br>- 1�� 2�� : 06:00<br>�� ž�� ���ӽð��� ���� �ʵ��� �����ϼž� �ϸ�, ����������� �ȳ���<br>&nbsp;&nbsp;&nbsp;&nbsp;�����Ͽ� �ֽñ� �ٶ��ϴ�.</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td><strong>2.</strong></td>
					<td><strong>������ : </strong>ȭ���� �ƻ� �ްԼ�<br><strong>�ּ� : </strong>������ ���� ������ �ʵ��� ��28����<br>- �൵</td>
				</tr>
				<tr><td colspan="2" height="5"></td></tr>
				<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/mypage/pop_img_22.gif"></td></tr>
				<tr><td colspan="2" height="15"></td></tr>
				<tr valign="top">
					<td><strong>3.</strong></td>
					<td><strong>���Ա��ɻ�� �غ�</strong><br>
					- �ź���, ž�±�, ���ԽŰ��� �� �����ϼ̴ٰ� ���ƿ��ô� �� ����<br>&nbsp;&nbsp;&nbsp;�ϼž� �մϴ�.<br>
					�� �ź���(�ֹε����, ����������, ����)�� �����ø� ž���� �����ǿ���<br>&nbsp;&nbsp;&nbsp;&nbsp;�ݵ�� �����Ͻñ� �ٶ��ϴ�.<br>
					�� ���ֱ���, �ùα���, �ܱ����� �ݵ�� ������ �����Ͻñ� �ٶ��ϴ�.<br>
					�� �����ϴ� �������� ���� ���ⱹ�� ������ ����ϴ� ���̹Ƿ� �Ѽյ���<br>&nbsp;&nbsp;&nbsp;&nbsp;�ʵ��� ���� �ٶ��ϴ�.<br>
					�� ���� ��ȭ : ����ƻ� ���繫�� ( Tel. 033-681-9400) </td>
				</tr>
				</table>
			</td>
		</tr>
		<tr><td colspan="2" align="right"><a href="#top"><img src="<%=imageServer%>/tour_img/btn/btn_top2.gif" class="btn"></a></td></tr>
		<tr><td colspan="2" style="padding:4 0 30 0px;"><img src="<%=imageServer%>/tour_img/mypage/hline470.gif"></td></tr>
		</table>
		<!-- �������ȳ� / -->

		<!-- / ����ȳ� -->
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr valign="top">
			<td width="43"><img src="<%=imageServer%>/tour_img/mypage/03.gif" hspace="12"></td>
			<td width="427">
				<table cellspacing="0" cellpadding="0" border="0" width="416">
				<tr><td colspan="2" height="23" valign="top"><img src="<%=imageServer%>/tour_img/mypage/pop_stit_03.gif" name="03"></td></tr>
				<tr valign="top">
					<td width="16"><strong>1.</strong></td>
					<td width="400"><strong>�������� �̿� ������ ���� ��</strong><br>�ݰ����ܵ��� ���������� �����ϸ� �ݰ����ܵ����� ���������������<br>�պ� �������(3õ��)�� ������ �����ϼž� �մϴ�.</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td><strong>2.</strong></td>
					<td><strong>��ü���� �̿� ��</strong><br>�������κ��� ��ü�� ���������� �̿��Ͻô� �е��� �ּ� 5��������<br>(02-3669-3000)�� ������ȣ�� ž���ο� ���� �ݵ�� �뺸�Ͻñ� �ٶ��ϴ�.<br>�� ������ȣ�� ������ ���� ���δ뿡 �뺸�ؾ߸� ���뼱 �˹��� �����<br>&nbsp;&nbsp;&nbsp;&nbsp;�����մϴ�</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td><strong>3.</strong></td>
					<td><strong>�������� �̿� ��(����)</strong><br>������ ���Ǹ� ���Ͽ� ���������� ��߽ð��� �����ð��� ����<br>��������������� ������ ���������� �����մϴ�.<br>�ʿ��Ͻ� �������� �Ʒ��� ���� ���۾�ü�� ���� �����Ͽ� �ֽñ�<br>�ٶ��ϴ�. (1�δ� �պ���� 3���� ���� ����)</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<!-- / ����`����`���������� -->
				<table cellspacing="1" cellpadding="1" border="0" width="407" style="margin:14 0 14 0px;" class="tabline">
				<tr align="center">
					<td class="bg_white fs11" height="26">����</td>
					<td class="bg_white fs11">����ȸ��</td>
					<td class="bg_white fs11">����ó</td>
					<td class="bg_white fs11">��߽ð�</td>
					<td class="bg_white fs11">�����</td>
					<td class="bg_white fs11">�൵</td>
				</tr>
				<tr align="center">
					<td class="bg_white fs11" height="26" rowspan="4">����<br>���<br>�ݰ���<br>(������)</td>
					<td class="bg_white fs11" rowspan="2">��ȭ����<br>(����)</td>
					<td class="bg_white fs11 lpad_10" align="left" rowspan="2">(02)<br>733-0017</td>
					<td class="bg_white fs11">09:00</td>
					<td class="bg_white fs11 lpad_5" align="left">�赿 ������<br>���������� ��</td>
					<td class="bg_white fs11"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_descview.gif"></a><!-- �󼼺��� --></td>
				</tr>
				<tr align="center">
					<td class="bg_white fs11">09:15</td>
					<td class="bg_white fs11 lpad_5" align="left">��ȭ�� �ݰ���ȭ<br>���� ��</td>
					<td class="bg_white fs11"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_descview.gif"></a><!-- �󼼺��� --></td>
				</tr>
				<tr align="center">
					<td class="bg_white fs11" rowspan="2">�������<br>(����)</td>
					<td class="bg_white fs11 lpad_10" align="left" rowspan="2">(02)<br>575-7710</td>
					<td class="bg_white fs11">09:00</td>
					<td class="bg_white fs11 lpad_5" align="left">�б��� �����ȭ��<br>�� ����������</td>
					<td class="bg_white fs11"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_descview.gif"></a><!-- �󼼺��� --></td>
				</tr>
				<tr align="center">
					<td class="bg_white fs11">09:30</td>
					<td class="bg_white fs11 lpad_5" align="left">��� ���տ��<br>�Ա� ���������� ��</td>
					<td class="bg_white fs11"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_s_descview.gif"></a><!-- �󼼺��� --></td>
				</tr>
				</table>
				<!-- ����`����`���������� / -->
			</td>
		</tr>
		<tr><td colspan="2" align="right"><a href="#top"><img src="<%=imageServer%>/tour_img/btn/btn_top2.gif" class="btn"></a></td></tr>
		<tr><td colspan="2" style="padding:4 0 30 0px;"><img src="<%=imageServer%>/tour_img/mypage/hline470.gif"></td></tr>
		</table>
		<!-- ����ȳ� / -->

		<!-- / �������غ���׾ȳ� -->
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr valign="top">
			<td width="43"><img src="<%=imageServer%>/tour_img/mypage/04.gif" hspace="12"></td>
			<td width="427">
				<table cellspacing="0" cellpadding="0" border="0" width="416">
				<tr><td colspan="2" height="23" valign="top"><img src="<%=imageServer%>/tour_img/mypage/pop_stit_04.gif" name="04"></td></tr>
				<tr valign="top">
					<td width="16"><strong>1.</strong></td>
					<td width="400"><strong>���� �غ�</strong><br>�� �ֹε���� �� �ź����� ���� ������ �ֽñ� �ٶ��ϴ�.<br>1) �� �� : ������ �´� ����, ���࿡ ������ ���� �� �Ź�, ���� ��<br>2) ���鵵�� : ġ��, ġ��, �鵵��(���� �� �񴩴� ��ġ�Ǿ� ����)<br>3) �� �� ǰ : �ݰ��� ������ ������ �����Ƿ� ���� ���ุ �غ�<br>4) �� Ÿ : �賶, ������, �尩, ���� ��</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td><strong>2.</strong></td>
					<td><strong>������� ȭ�� : </strong>�̴޷�($), �ſ�ī��<!-- �� �ݰ������  ī��<br>�� ����ī�� ���� �޷�ȯ�� �� ���ŷο� ������ �ʿ�����ϴ�.--></td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td><strong>3.</strong></td>
<!--					<td><strong>�ݰ������  ī��(����) �ȳ�</strong><br> �ݰ������  ī��(����)�� ������ ��� �в� �������� �Բ� �߱޵Ǵ�<br>����ī��μ� �ݰ���Ư���������� ��� �����մϴ�.<br>1) ��� ��� : ��ȭ(\)�� ����ī�忡 ���� ���� ȯ���� �޷�($) ����<br>&nbsp;&nbsp;&nbsp;(��) 15���� ������ (ȯ�� 1,050����) �� �� $142 ����<br>2) ���� ��� : �ݰ��� �ܵ�(��) �� �ݰ��� ����(������ ����)<br>3) ȯ �� : ���� ��, ������ �������� ���� �ݾ� ��ȭ(\)�� ȯ��</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td><strong>4.</strong></td>-->
					<td><strong>�޴���� ǰ��</strong><br>�� �ڵ����� �ݰ����ܵ����� ���������� ���� �� ����<br>1) 10�� �̻��� �־Ȱ� �� ������, 160�и����� �̻��� ������� �޸�<br>&nbsp;&nbsp;&nbsp;������, 24�����̻�(��Ƽ�� ����)�� �ܷ�� �޸� ���� ī�޶�<br>2) ������ ���� �μ⹰ (�Ź�, ����, å ��)<br>3) ��������, ������ �� ��Ź�ǰ<br>4) �Ƿ������ ���� ��ǰ�� ������ ����, ����, �׹ۿ� ������ ȭ�й���<br>5) ��Ÿ ������ �������� ���� ����</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr><td colspan="2" align="right"><a href="#top"><img src="<%=imageServer%>/tour_img/btn/btn_top2.gif" class="btn"></a></td></tr>
		<tr><td colspan="2" style="padding:4 0 30 0px;"><img src="<%=imageServer%>/tour_img/mypage/hline470.gif"></td></tr>
		</table>
		<!-- �������غ���׾ȳ� / -->

		<!-- / �˾Ƶѻ��� -->
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr valign="top">
			<td width="43"><img src="<%=imageServer%>/tour_img/mypage/05.gif" hspace="12"></td>
			<td width="427">
				<table cellspacing="0" cellpadding="0" border="0" width="416">
				<tr><td colspan="2" height="23" valign="top"><img src="<%=imageServer%>/tour_img/mypage/pop_stit_05.gif" name="05"></td></tr>
				<tr valign="top">
					<td width="16"><strong>1.</strong></td>
					<td width="400"><strong>�ݰ����� ����</strong><br>���ؾ� ���������� ����� ����</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td><strong>2.</strong></td>
					<td><strong>�� �� : </strong>220V (�ݰ��� ���� �ü���)</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td><strong>3.</strong></td>
					<td><strong>������ݿ� ���Ե� ����</strong><br>1) �����(���������� �� �ݰ���)<br>2) �����ȳ���<br>3) �����Ⱓ ���� ���ں� �� ����<br>4) ������ ����</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr valign="top">
					<td><strong>4.</strong></td>
					<td><strong>������ݿ� ���Ե��� ���� ����</strong><br>1) ��������� ��������������� �պ� �����<br>2) ���������� ��/����(4��)<br>3) �������� �������</td>
				</tr>
				<tr valign="top">
					<td colspan="2">
						<table cellspacing="1" cellpadding="1" border="0" width="400" style="margin:5 0 5 0px;" class="tabline">
						<tr align="center">
							<td class="bg_white fs11" height="26" width="25%">����</td>
							<td class="bg_white fs11" width="25%">Ư��</td>
							<td class="bg_white fs11" width="25%">�Ϲݼ�</td>
							<td class="bg_white fs11" width="25%">�Լ�</td>
						</tr>
						<tr align="center">
							<td class="bg_white fs11">����</td>
							<td class="bg_white fs11">$ 30</td>
							<td class="bg_white fs11">$ 25</td>
							<td class="bg_white fs11">$ 20</td>
						</tr>
						<tr align="center">
							<td class="bg_white fs11">���� ����</td>
							<td class="bg_white fs11">$ 30</td>
							<td class="bg_white fs11">$ 20</td>
							<td class="bg_white fs11">$ 15</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr valign="top">
					<td></td>
					<td>�� �� 6�� ���ϴ� ���������̳� ������ �¼��� �������� �ʴ´�.<br>&nbsp;&nbsp;&nbsp;&nbsp;�Լ��� �¼��� ������ ������ ���� ����<br>4) ��õ�� ��� (������) -2ȸ �̿�� ���Խô� $20�Դϴ�.</td>
				</tr>
				<tr valign="top">
					<td colspan="2">
						<table cellspacing="1" cellpadding="1" border="0" width="412" style="margin:5 0 5 0px;" class="tabline">
						<tr align="center">
							<td class="bg_white fs11" height="26" width="20%">����</td>
							<td class="bg_white fs11" width="20%">��/��/���</td>
							<td class="bg_white fs11" width="30%">8�ν�(����)</td>
							<td class="bg_white fs11" width="30%">15�ν�(����)</td>
						</tr>
						<tr align="center">
							<td class="bg_white fs11">$ 12</td>
							<td class="bg_white fs11">$ 10</td>
							<td class="bg_white fs11">�⺻�� $ 30 (8��)<br>1�� �߰� $ 10</td>
							<td class="bg_white fs11">�⺻�� $ 50 (15��)<br>1�� �߰� $ 10</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr><td colspan="2" align="right"><a href="#top"><img src="<%=imageServer%>/tour_img/btn/btn_top2.gif" class="btn"></a></td></tr>
		<tr><td colspan="2" style="padding:4 0 30 0px;"><img src="<%=imageServer%>/tour_img/mypage/hline470.gif"></td></tr>
		</table>
		<!-- �˾Ƶѻ��� / -->

		<!-- / ���������ǻ��� -->
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr valign="top">
			<td width="43"><img src="<%=imageServer%>/tour_img/mypage/06.gif" hspace="12"></td>
			<td width="427">
				<table cellspacing="0" cellpadding="0" border="0" width="416">
				<tr><td colspan="2" height="23" valign="top"><img src="<%=imageServer%>/tour_img/mypage/pop_stit_06.gif" name="06"></td></tr>
				<tr valign="top">
					<td width="16"><strong>1.</strong></td>
					<td width="400"><strong>���ǻ���</strong><br>1) �����̵� �� ���� �ü����̳� ���� ��� ���� �Կ�<br>2) ���� �� ���� �����⳪ ������ ����<br>3) ���Ա� �Ű�, ���� �Ű� �� ���� ����<br>4) ������ ��� �� �� �� �뺯<br>5) �ڿ��� �Ѽ��ϰų� �ڿ��� ä��<br>6) �޴���� ǰ�� �� ���Ĺ� ����<br>7) ������ ������ ����� �����ϴ� ��</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr><td colspan="2" align="right"><a href="#top"><img src="<%=imageServer%>/tour_img/btn/btn_top2.gif" class="btn"></a></td></tr>
		<tr><td colspan="2" style="padding:4 0 30 0px;"><img src="<%=imageServer%>/tour_img/mypage/hline470.gif"></td></tr>
		</table>
		<!-- ���������ǻ��� / -->

		<!-- / ǥ������ǥ -->
		<table cellspacing="0" cellpadding="0" border="0" width="470">
		<tr valign="top">
			<td width="43"><img src="<%=imageServer%>/tour_img/mypage/07.gif" hspace="12"></td>
			<td width="427">
				<table cellspacing="0" cellpadding="0" border="0" width="420">
				<tr><td colspan="2" height="23" valign="top"><img src="<%=imageServer%>/tour_img/mypage/pop_stit_07.gif" name="07"></td></tr>
				<tr>
					<td><strong>- ���Ρ����� ��ǰ(1��2��)</strong></td>
					<td align="right">* ������ ������Ʈ�� : <span class="txt_sky">2006-01-04</span></td>
				</tr>
				<tr>
					<td colspan="2">
						<table cellspacing="1" cellpadding="3" border="0" width="420" style="margin:10 0 15 0px;" class="tabline">
						<tr align="center" valign="top">
							<td class="bg_white fs11" height="26" width="40">��¥</td>
							<td class="bg_white fs11" width="65">���</td>
							<td class="bg_white fs11" width="89">�ð�</td>
							<td class="bg_white fs11" width="218">����</td>
						</tr>
						<tr align="center" valign="top">
							<td class="bg_white fs11">��1��</td>
							<td class="bg_white fs11"><br>�ݰ����ܵ�<br><br>����������<br><br>������<br><br><br><br><br><br>��ȭȸ��<br><br><br><br></td>
							<td class="bg_white fs11"><br>06:00<br>07:00<br>07:20<br>08:00<br>08:15<br>08:45<br>09:40~15:00<br>(13:30~16:10)<br><br><br><br><br>16:30<br>18:00~ (21:00) </td>
							<td class="bg_white fs11" align="left">�ݰ����ܵ� ���� �� �ݰ������� ���!<br>������ ���� (�����̵�, ������ ����)<br>������ ���<br>���� ���Ի繫�� ���� / ����<br>���� ���Ի繫�� ��� (����а�� ���)<br>���� ���Ի繫�� ���� / ����<br>���� ���Ի繫�� ���<br>���濬 �ڽ����� �� �߽�<br>������ �ڽ�����(����), �Ǵ� ��õ (����)<br>�� �ϰ� �ؼ����� �̿�<br>&nbsp;&nbsp;&nbsp;(��Ʋ���� ���:������ ���)<br>����ð� : 13:00~17:00<br>�������� ����<br>���� �� �����ð� (��õ/����)<br>������ (�ݰ���ȣ��)</td>
						</tr>
						<tr align="center" valign="top">
							<td class="bg_white fs11">��2��</td>
							<td class="bg_white fs11">�� ����<br><br><br>������<br><br><br>����������</td>
							<td class="bg_white fs11">06:30<br>08:20<br>12:00<br>15:15<br>15:30<br>16:15<br>16:30</td>
							<td class="bg_white fs11" align="left">���� 1��2���� ��ġ��~<br>����<br>������ �Ǵ� ������/�رݰ� �ڽ�����<br>�߽� �� �����ð� (��õ/����)<br>������ ������� ���Ի繫�� ����/����<br>���� ���Ի繫�� ��� (����а輱 ���)<br>���� ���Ի繫�� ����/����</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2">- ��������� ���� ������ ���� �ټ� ����� ���� �ֽ��ϴ�.<br>- ��õ��.�������� �������� ���� ��ǥ�ҿ��� �Ǹ��ϸ� �������� �ı���<br>&nbsp;&nbsp;&nbsp;�����Ͻñ� �ٶ��ϴ�.<br>- ��õ, ��������, �Ļ� ����� <span class="txt_sky">[���ǥ]</span>�� �����Ͻñ� �ٶ��ϴ�.</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr><td colspan="2" align="right"><a href="#top"><img src="<%=imageServer%>/tour_img/btn/btn_top2.gif" class="btn"></a></td></tr>
		</table>
		<!-- ǥ������ǥ / -->

		<!-- / ��ư -->
		<table cellspacing="0" cellpadding="0" border="0" width="442">
		<tr><td height="11"></td></tr>
		<tr>
			<td height="39" valign="top" align="center"><a href="javascript:;" onclick="window.print();"><img src="<%=imageServer%>/tour_img/btn/btn_print.gif" class="btn"></a><a href="javascript:;" onclick="window.close();"><img src="<%=imageServer%>/tour_img/btn/btn_confirm2.gif"></a></td>
		</tr>
		</table>
		<!-- ��ư / -->

		<!-- �ϴܹ�  --><table cellspacing="0" cellpadding="0" border="0"><tr><td><img src="<%=imageServer%>/tour_img/mypage/pop_btm_accountinfo.gif"></td></tr></table>
	</td>
</tr>
</table>

</body>
</html>
