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
<%
  String pageNum = "2";
%>
<%
//request parameters
String r_mail = ParamUtil.getReqParameter(request.getParameter("r_mail"), "");
String r_pass = ParamUtil.getReqParameter(request.getParameter("r_pass"), "");
int idx	= Util.parseInt(request.getParameter("idx"), 1);

//��������

int cnt = 0;
int accept_sid = 0;
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
String arrive_date= "";
String nights= "";
String final_type = "";
String final_time = "";

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
	final_type = bean[0].getFinal_type();
	final_time = bean[0].getFinal_time();
	
}else{

}
%>
<html>
<head>
<title> �ݰ������ </title>
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
  
  function PayMov(val,vbl,vcl,vdl) {
     var form=document.payForm;
     //form.c_pay_amt.value = val;
     form.c_pay_amt.value = "1000";
     form.r_order_nm.value = vbl;
     form.r_order_tel_no.value = vcl;
     form.r_order_e_mail.value = vdl;

     
     window.name = "mainpage";
     form.target = "actionFrame";
     form.action="http://com.hdasan.com/cPlugOnline.asp";
     form.submit();
  }
-->
</script>
</head>

<body>

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
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">���� ��������</span></td>
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
								<!-- / ���೻�� -->
								<table cellspacing="0" cellpadding="0" border="0" width="510">
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
									<td width="166"><%=nights%></td>
									<td width="112"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket03.gif"><!-- �����Ͻ� --></td>
									<td width="144"><%=regdate%>&nbsp;<%=regtime%></td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket04.gif"><!-- �ο� --></td>
									<td><%=cnt%>��</td>
									<td><img src="<%=imageServer%>/tour_img/mypage/txt_ticket05.gif"><!-- ������� --></td>
									<td><%=r_stat%></td>
								</tr>
								<tr><td height="1" colspan="4" class="tabline"></td></tr>
								<tr>
									<td height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket06.gif"><!-- �Ѿ� --></td>
									<td>
									<%=tot_tour_amt%>
									</td>
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
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:30px;">
								<tr>
									<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket02.gif" hspace="5"><!-- ���������� --></td>
								</tr>
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								<tr>
									<td width="102" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket21.gif"><!-- �������̸� --></td>
									<td width="139"><%=r_name%></td>
									<td width="85"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket22.gif"><!-- �̸��� --></td>
									<td width="184"><%=r_mail%></td>
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
	for(int i=0;i<record.length; i++){ 
		Reservation_bean tbean2 = record[i];
		
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
        
%>


								<!-- / ����`����`���������� -->
            <%
            		if (pre_upjang_info == "" || !pre_upjang_info.equals(upjang_info)){ //ȣ�ں����(1)...
            %>
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:30px;">
								<tr>
									<td valign="top" height="26" colspan="4"><img src="<%=imageServer%>/tour_img/mypage/stit_ticket03.gif" hspace="5"><!-- ����`����`���������� --></td>
								</tr>
								<tr><td height="2" colspan="4" class="line_dg"></td></tr>
								<tr>
									<td width="65" height="26"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket31.gif"><!-- ���� --></td>
									<td width="175"><%=hotel_nm%></td>
									<td width="65"><img src="<%=imageServer%>/tour_img/mypage/txt_ticket32.gif"><!-- ���� --></td>
									<td width="205"><%=room_nm%></td>
								</tr>
								<tr><td height="1" colspan="4" class="line_dg"></td></tr>
								</table>
								<table cellspacing="1" cellpadding="1" border="0" width="510" style="margin:14 0 14 0px;" class="tabline">
								<tr align="center">
									<td class="bg_white" height="26">�̸�</td>
									<td class="bg_white">�ֹε�Ϲ�ȣ</td>
									<td class="bg_white">������</td>
									<td class="bg_white">���ɱ���</td>
									<td class="bg_white">�������</td>
									<td class="bg_white">�Աݾ�</td>
									<td class="bg_white">��������</td>
								</tr>
	        <%
	            } //ȣ�ں����(1)...
	        %>								

								<tr align="center">
									<td class="bg_white" height="26"><%=cust_nm%></td>
									<td class="bg_white"><%=regi_no%></td>
									<td class="bg_white">
									<%
									  if (rstat.equals("�̳�") && tstat.equals("�Ϸ�")){
									%>
									   <a href="javascript:;" onclick="window.open ('popup_useinfo.jsp?cust_sid=<%=cust_sid%>', 'userview', 'width=530,height=540,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize');">
									   <img src="<%=imageServer%>/tour_img/btn/btn_s_ok.gif"></a><!-- �Ϸ� -->
								    <%
								      }else if (rstat.equals("�̳�") && tstat.equals("���Է�")){
								    %>
									   <a href="javascript:;" onclick="window.open ('popup_useinfo.jsp?cust_sid=<%=cust_sid%>', 'userview', 'width=530,height=540,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize');">
									   <img src="<%=imageServer%>/tour_img/btn/btn_s_notinsert.gif"></a><!-- ���Է� -->
								    <%
                                      }else if(rstat.equals("�ϳ�")){
                                    %>
                                       <a href="javascript:alert('�������Ŀ��� ������ �� �����ϴ�.');"><img src="<%=imageServer%>/tour_img/btn/btn_s_ok.gif"></a>
                                    <%
                                      }else{
                                      
                                      }
								    %>
									</td>
									<td class="bg_white">����</td>
									<td class="bg_white rpad_10" align="right"><%=tot_tour_amt%></td>
									<td class="bg_white rpad_10" align="right"><%=tot_pay_amt%></td>
									<td class="bg_white">
									<%
									  if (tstat.equals("�Ϸ�") && rstat.equals("�ϳ�")){
									%>
									    <a href="javascript:;" onclick="window.open ('popup_accountinfo.jsp', 'payview', 'width=520,height=600,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize');">
									    <img src="<%=imageServer%>/tour_img/btn/btn_s_accountok.gif">
									    </a><!-- �����Ϸ� -->
									<%
                                      }else if (tstat.equals("�Ϸ�") && rstat.equals("�̳�")){  
									%>
									    <a href="javascript:PayMov(<%=tot_result_amt%>,'<%=cust_nm%>','<%=r_mob%>','<%=r_mail%>');">
									    <img src="<%=imageServer%>/tour_img/btn/btn_s_notaccount.gif">
									    </a>
									<%
                                      }else if (tstat.equals("���Է�") && rstat.equals("�̳�")){  
									%>
									    <a href="javascript:alert('�������� �Է��Ͻ� �� ���� ���� �մϴ�.');">
									    <img src="<%=imageServer%>/tour_img/btn/btn_s_notaccount.gif">
									    </a>
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

								<!-- / �ϴܹ�ư -->
								<table cellspacing="0" cellpadding="0" border="0" width="510" style="margin-top:14px;">
								<tr><td height="1" colspan="2" class="line_dg"></td></tr>
								<tr><td height="13" colspan="2"></td></tr>
								<tr>
									<td><a href="javascript:PageMov('list');"><img src="<%=imageServer%>/tour_img/btn/btn_listgo.gif"></a><!-- ������� --></td>
									<td align="right">
									   <a href="javascript:PageMov('02');"><img src="<%=imageServer%>/tour_img/btn/btn_account.gif" class="btn"></a><!-- �����ϱ� -->
									<%if(final_type.equals("F")){%>
									   <a href="javascript:alert('������������ ����Ǿ����ϴ�.');"><img src="<%=imageServer%>/tour_img/btn/btn_resercancel.gif" class="btn"></a><!-- ������� --><a href="javascript:;" onclick="window.open ('popup_reservation_ticket.jsp?idx=<%=idx%>', 'movieview', 'width=518,height=600,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_ticketview.gif"></a><!-- ����Ƽ�Ϻ��� --></td>
								    <%}else{%>
									   <a href="javascript:alert('���� ��� ���μ��� �̵�');"><img src="<%=imageServer%>/tour_img/btn/btn_resercancel.gif" class="btn"></a><!-- ������� --><a href="javascript:;" onclick="window.open ('popup_reservation_ticket.jsp', 'movieview', 'width=518,height=600,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_ticketview.gif"></a><!-- ����Ƽ�Ϻ��� --></td>
									<%}%>
								</tr>
								</table>
								<!-- �ϴܹ�ư / -->

							</td>
							<td width="160" style="padding-top:25px;">
								<table width="160" cellpadding="0" cellspacing="0" border="0" class="bg_sky3">
								<tr><td><img src="<%=imageServer%>/tour_img/mypage/tip_01.gif"></td></tr>
								<tr>
									<td class="txt_dblue fs11 lh13" style="padding:12 5 7 11px;"><strong>1) �ּ�</strong>: ��/��, ��/��, ��/��<br>���� Ȯ���ϸ�, �ֹε����<br>�� �������� �����Ͽ� Ʋ��<br>��� ������ �ΰ��˴ϴ�.</td>
								</tr>
								<tr>
									<td class="txt_dblue fs11 lh13" style="padding:0 5 0 11px;"><strong>2) ����/����</strong>: ��ǰ� �ٸ� ��� ������ �ΰ��Ǹ�,<br>�ݵ�� ����ƻ� ����ڿ�<br>��ȭ�Ͽ� Ȯ�� �����ñ�<br>�ٶ��ϴ�.</td>
								</tr>
								<tr>
									<td class="txt_dblue fs11 lh13" style="padding:0 5 2 11px;">(�� ����ƻ� ������ �̼���<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 02-3669-3724)</td>
								</tr>
								<tr>
									<td style="padding:0 5 10 11px;">
										<table width="100%" cellpadding="0" cellspacing="0" border="0">
										<tr>
											<td colspan="3" class="txt_dblue fs11 lh13" style="padding:5 0 7 0px;">--------- ���� ---------</td>
										</tr>
										<tr valign="top">
											<td width="6"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_rec.gif" vspace="4"></td>
											<td width="37" class="txt_dblue fs11 lh13">��   ��:</td>
											<td class="txt_dblue fs11 lh13">����� �ֺ�,<br>������ ����</td>
										</tr>
										<tr valign="top">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_dblue_rec.gif" vspace="4"></td>
											<td class="txt_dblue fs11 lh13">�ڿ���:</td>
											<td class="txt_dblue fs11 lh13">����� ��ȣ,<br>������ ��ǥ.</td>
										</tr>
										<tr valign="top">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_dblue_rec.gif" vspace="4"></td>
											<td class="txt_dblue fs11 lh13">��   ��:</td>
											<td class="txt_dblue fs11 lh13">����� �л�,<br>������ ����.</td>
										</tr>
										<tr valign="top">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_dblue_rec.gif" vspace="4"></td>
											<td class="txt_dblue fs11 lh13">���л�:</td>
											<td class="txt_dblue fs11 lh13">����� OO���б�<br>������ �л�</td>
										</tr>
										</table>
									</td>
								</tr>
								</table>

								<table cellpadding="0" cellspacing="0" border="0"><tr><td height="10"></td></tr></table>

								<table width="160" cellpadding="0" cellspacing="0" border="0" class="bg_lbrown">
								<tr><td><img src="<%=imageServer%>/tour_img/mypage/tip_02.gif"></td></tr>
								<tr>
									<td class="txt_brown fs11 lh13" style="padding:12 5 7 11px;"><strong>������ ��</strong>: (��110-793)<br>����� ���α� �赿 1410-2<br>������� �¶��� ����� ��</td>
								</tr>
								<tr>
									<td class="txt_brown fs11 lh13" style="padding:0 5 10 11px;">(���� �޸鿡 �ֹε�Ϲ�ȣ��<br>������ �������� �����ֽñ�<br>�ٶ��ϴ�.)</td>
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
   <input type="hidden" name="r_user_key" value="�׽�Ʈ��ǰ">
   <input type="hidden" name="c_pay_gubn" value="050">
   <input type="hidden" name="c_pay_manage_no" value="12345678">
   <input type="hidden" name="c_return_url" value="">
   <input type="hidden" name="c_pay_amt">
   <input type="hidden" name="r_order_nm">
   <input type="hidden" name="r_order_tel_no">
   <input type="hidden" name="r_order_e_mail">
</form>

				<div id="payment" style="position:absolute;width:560px;height:530px;display:none">
				<iframe name="actionFrame" width="560" frameborder="0" height="530" src="about:blank"></iframe>
</body>
</html>