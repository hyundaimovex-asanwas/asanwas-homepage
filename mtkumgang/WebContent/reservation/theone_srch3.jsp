<%--
  - �ۼ���: �ɵ���
  - ����: 2009.04.22
  - ���۱� ǥ��: ����ƻ�
  - ����: �¶��ο��� > ���� ��������
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

//��������

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
String goods_nm = "";	//goods_nm�� �޾ƿ�..;
String stat_txt ="";	//������¿� ���� ��ư ǥ��	20090422


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
	//tot_tour_amt = NumberFormat.getInstance().format(bean[0].getTot_tour_amt())+"��";
	final_type = bean[0].getFinal_type();
	final_time = bean[0].getFinal_time();
	rscod = bean[0].getRscod();
	raccept_no = bean[0].getAccept_no();
	van_idx_no = bean[0].getVan_idx_no();
	goods_nm= bean[0].getGoods_nm();

	if(r_stat.equals("1")){
		stat_txt="<a href=javascript:PageMov('1');><img src='"+imageServer+"/reservation/img/theone_ani_paycall.gif' class=btn></a>";
	}else if(r_stat.equals("2")){
		stat_txt="<a href=javascript:PageMov('2');><img src='"+imageServer+"/reservation/img/theone_ani_payok.gif' class=btn></a>";
	}else if(r_stat.equals("3")){
		stat_txt="<img src='"+imageServer+"/reservation/img/theone_ani_paydone.gif' class=btn>";
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
<title>����ƻ� �¶��� ���ࡡ����������������������������������������������������������������������������������������������������������</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>

<script language="javascript">
<!--
  function PageMov(val) {
     if (val == "list"){
        document.form.action="theone_srch2.jsp";
     }else if(val == "2"){
        document.form.action="theone_srch4.jsp";
     }else if(val == "1"){
        alert(" ����ƻ� �����ȳ�(02-3669-3000) ");
		return;

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
	  cfm=confirm("���� ��� �Ͻðڽ��ϱ�?")
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



	//	ī������ ��
/*    if(getCookie("cardDC") != "done" )		// �ҷ��� ��Ű�� ���� "done"�� �ƴϸ�~
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
-->
</script>
</head>

<body>


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
    <td

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td  align=center>
				<!-- / content  -->
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr>	
					<td style="padding:20 0 10 16"><img src="<%=imageServer%>/reservation/img/title_srch3.gif"></td>
				</tr>

				<tr>
					<td valign="top" align=center>
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td  align=center>
								<!-- / ���೻�� -->
								<table cellspacing="0" cellpadding="0" border="0" width="510">
								<tr>
								       <td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket01.gif" hspace="5"><!-- ���೻�� --></td>
								</tr>
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								<tr>
									<td width="88" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket04.gif"><!-- �ο� --></td>
									<td width="166"><%=cnt%>��</td>
									<td width="112"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket03.gif"><!-- �����Ͻ� --></td>
									<td width="144"><%=regdate%>&nbsp;<%=regtime%></td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket06.gif"><!-- �Ѿ� --></td>
									<td>
									<%=NumberFormat.getInstance().format(sum_price)%>
									</td>
									<td><!-- <img src="<%=imageServer%>/tour_img/mypage/txt_ticket07.gif"> ���������Ͻ� --></td>
									<td>
                                       <%
//                                         if(final_type.equals("F")){
//                                           out.println("<font color='red'>"+final_time+"</font>");
//                                         }else{
//                                           out.println(final_time);
//                                         }
                                       %>
									</td>
								</tr>
								<tr><td height="1" colspan="4" class="line_dg"></td></tr>
								</table>
								<!-- ���೻�� / -->

								<!-- / ���������� -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:30px;">
								<tr>
									<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket02.gif" hspace="5"><!-- ���������� --></td>
								</tr>
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								<tr>
									<td width="102" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket21.gif"><!-- �������̸� --></td>
									<td width="139"><%=r_name%></td>
									<td width="85"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket22.gif"><!-- �̸��� --></td>
									<td width="184"><%=rmail%></td>
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

								<table cellspacing="0" cellpadding="0" border="0" width="510">
								<tr>
									<td valign="top" height="26" colspan="4" style="padding-top:8px">�� ���� 3�� �̳� �Ա����� ������ �ڵ� ��� �� �� �ֽ��ϴ�.</td>
								</tr>
								</table>

								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:30px;">
								  <tr>
									<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket03.gif" hspace="5"><!-- ����`����`���������� --></td>
								  </tr>
								  <tr><td height="2" colspan="4" class="line_dg"></td></tr>
								  <tr>
									<td width="90" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket51.gif"><!-- ���� --></td>
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
String rstat ="";  //��������
String tstat ="";  //�����������Կ���
String adult = ""; //���ɱ���
String pay_yn = "";

//DAO2
ReservationInfo dao2 = new ReservationInfo();
// ������ ���

Reservation_bean record [] = dao2.getTourList(accept_sid);
%>

<% if(record.length <= 0){ %>	
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:30px;">
								<tr>
									<td valign="top" height="26" colspan="4">��ϵ� ������ ������ �����ϴ�.</td>
								</tr>
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								</table>                      
<%}else{
    
	//����Ʈ ȭ�鿡 ����
	int record_num = 0;
	pre_upjang_info = "";
	String manage_no="";
	ReservationInfo dao3 = new ReservationInfo();

	for(int i=0;i<record.length; i++){ 
		  Reservation_bean tbean2 = record[i];
		  rsv_sid  = tbean2.getRsv_sid();
		  m_rsv_sid = tbean2.getM_rsv_sid();
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
				van_idx_no = tbean2.getVan_idx_no();
                
                systemFile = new File(saveDir+StringUtil.strReplace(regi_no,"-","")+".jpg");
                if(systemFile.exists()){
                   userImage = "/asanway/upload/reservationUserUpload/"+StringUtil.strReplace(regi_no,"-","")+".jpg";
                }else{
                   userImage = imageServer+"/tour_img/mypage/_temp_pic.gif";
                }
                
                manage_no = dao3.getManageNo(); //������û��ȣ
%>


								<!-- / ��ǰ���� -->
            <%
            		if (pre_m_rsv_sid == 0 || pre_m_rsv_sid!=m_rsv_sid){ //���庯���(1) ������ �ֱ�
            %>

								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin:14 0 0 0px;" class="tabline">
								  <tr height="18" align=center>
									<td class="bg_white"><%=hotel_nm%> - <%=room_nm%></td>
								  </tr>
								</table>
								<table cellspacing="1" cellpadding="1" border="0" width="510" style="margin:0 0 0 0px;" class="tabline">
								  <tr align="center" height="26">
									<td width=60 class="bg_white">�̸�</td>
									<td width=120 class="bg_white">�ֹε�Ϲ�ȣ</td>
									<td width=70 class="bg_white">���ɱ���</td>
									<td width=70 class="bg_white">�������</td>
									<td width=70 class="bg_white">�Աݾ�</td>
									<td width=60 class="bg_white">��������</td>
								  </tr>
	        <%
	            } //���庯���(1)...
	        %>

								  <tr align="center" height="26">
									<td class="bg_white"><%=cust_nm%></td>
									<td class="bg_white"><%=regi_no%></td>
									<td class="bg_white">����</td>
									<td class="bg_white rpad_10" align="right"><%=tot_tour_amt%></td>
									<td class="bg_white rpad_10" align="right"><%=tot_pay_amt%></td>
									<td class="bg_white">
									<%if( status_cd.equals("RA")  ||  status_cd.equals("DP")){%>
        									<%
        									  if(pay_yn.equals("Y")){	//�Ϸ��� ��� ������ ����
        									%>
       									   	   <a href="javascript:popReceipt('<%=van_idx_no%>')"><img src="<%=imageServer%>/reservation/img/btn_paid.gif" border=0></a>
        									    <!-- �����Ϸ� -->
        									<%
                                              }else{  
        									%>
        									    <img src="<%=imageServer%>/tour_img/btn/btn_s_notaccount.gif"  style="cursor:hand" onclick="alert('�ϴ��� �����ϱ� ��ư�� �����ø�\n����ȭ������ �̵��մϴ�.');">
        									<%
                                              }                        
        									%>
      							    <%}%>
									</td>
								  </tr>
            <%
            		if (record_num > 0 && pre_m_rsv_sid!=m_rsv_sid){ //���庯���(2)...
            %>
		
								</table> 
	        <%
	                 } //���庯���(2)...
	                 
	               record_num = record_num +1;
	               pre_m_rsv_sid = m_rsv_sid; //�����ڵ带 ��´�.


	}//for
            
}//if
%>
								<!-- ����`����`���������� / -->

								<!-- / �ϴܹ�ư -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:14px;">
								  <tr><td height="1" colspan="2" class="line_dg"></td></tr>
								  <tr>
									<td height="53" colspan="2"><B>�� ������ ��ȭ �� ������ Ȯ���Ǿ�� �����Ͻ� �� �ֽ��ϴ�.</B><br>
										<B>�� ����ƻ� �����ȳ� (02-3669-3000)</B>
									</td>
								  </tr>
<!--								  <tr>
									<td height="53" colspan="2"><B>�� �������ζ��� �����ϷḦ Ŭ���Ͻø� <font size=3 color=blue>ī�念����</font>�� Ȯ���Ͻ� �� �ֽ��ϴ�.</B>
									</td>
								  </tr>-->
														
								<tr>
									<td><a href="javascript:PageMov('list');"><img src="<%=imageServer%>/tour_img/btn/btn_listgo.gif"></a><!-- ������� --></td>
									 <td align="right"><%=stat_txt%></td>
								</tr>

								</table>
								<!-- �ϴܹ�ư / -->

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
</table>

<br><br><br>










<form name="form" method="post">
   <input type="hidden" name="rmail" value="<%=rmail%>">
   <input type="hidden" name="rpass" value="<%=rpass%>">
   <input type="hidden" name="idx" value="<%=idx%>">
</form>
<form name="payForm" method="post">
   <input type="hidden" name="r_user_key" >  <!--��ǰ��-->
   <input type="hidden" name="c_pay_gubn" value="050">  <!--�¶��ΰ�������-->
   <input type="hidden" name="c_pay_manage_no">  <!--����������ȣ-->
   <input type="hidden" name="c_return_url" value="http://www.mtkumgang.com/mypage/reservation/cResultOnline.jsp">  <!--����-->
   <input type="hidden" name="c_pay_amt">  <!--�����ݾ�-->
   <input type="hidden" name="r_order_nm">  <!--�ֹ��ڸ�-->
   <input type="hidden" name="r_order_tel_no">  <!--�޴�����ȣ-->
   <input type="hidden" name="r_order_e_mail">  <!--E-Mail-->
   <input type="hidden" name="rsv_sid">  <!--���� SID (�߰�)-->
   
   <input type="hidden" name="c_terminal_id" value="�ܸ���Ƶ�">
   <input type="hidden" name="c_acct_join_no" value="���͹�ȣ">
   <input type="hidden" name="c_van_cd" value="���ڵ�">
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