<%--
  - �ۼ���: �̼ҿ�
  - ����: 2006.06.08  
  - ���۱� ǥ��: IMJ Korea
  - ����: ����Ʈ - ���ǥ����
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="kr.co.imjk.reservation.bean.Price_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.PriceInfo"%>
<%@ page import="java.util.*"%>
<%
//���� ����
String menu_item1 = new String(); //����
String menu_item4 = new String(); //�ڼ�
String use_date = new String(); //����(�Ⱓ)

int upjang_sid = 0;
String menu_item2 = new String();
String menu_item3 = new String();
String menu_item5 = new String();
String menu_nm = new String();
int end_persons = 0;
String amt1 = "0";
String amt2 = "0";
String amt3 = "0";
String amt4 = "0";
String amt5 = "0";
String amt6 = "0";
String upjang_nm = new String();
String upjang_cd = new String();
String pre_upjang_cd = new String();
String persons_info = new String();

String room_type_nm = new String();
int std_persons = 0;

String McNum = "2";
String sub = "5";
String pageNum = "5";
String subNum = "";

// DB���� ��ü(ibatis���)  
PriceInfo dao = new PriceInfo();

// �˻����� (����Ʈ�� �������ٰ�..)
menu_item1 = ParamUtil.getReqParameter(request.getParameter("menu_item1"),"20");
menu_item4 = ParamUtil.getReqParameter(request.getParameter("menu_item4"),"28");
use_date = ParamUtil.getReqParameter(request.getParameter("use_date"),"20071101");

Price_bean price_record[] = dao.getPriceList(menu_item1,menu_item4,use_date);

%>

<html>
<head>
<title> �ݰ������   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/reservation/tour_reservation_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="../../include/reservation/tour_reservation_left.jsp" %>
			<!--  left menu flash -->			
			</td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/apply/tit_app03.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">����/��û</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">���ǥ</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="22"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/apply/top_txt_app03.gif"></td></tr>
				<tr>
					<td style="padding-left:73px">
						<!-- / �����,������, �ؼ�����, �ּ����� �Ⱓǥ �׷��� -->
						<img src="<%=imageServer%>/tour_img/apply/tab_period01.gif"><br>&nbsp;
						<!-- �����,������, �ؼ�����, �ּ����� �Ⱓǥ �׷��� / -->
					</td>
				</tr>
				<tr>
					<td>
						<!-- / ������ -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="25" valign="top"><img src="<%=imageServer%>/tour_img/apply/stit_seasonchoice.gif" hspace="5"></td></tr>
						<tr>
							<td>
							<%if (menu_item1.equals("30")){ %>
								<a href="price_list.jsp?menu_item1=30&menu_item4=<%=menu_item4%>&use_date=20070801"><img src="<%=imageServer%>/tour_img/apply/tab_day01on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_day01on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_day01on.gif'"></a><a href="price_list.jsp?menu_item1=20&menu_item4=<%=menu_item4%>&use_date=20071101"><img src="<%=imageServer%>/tour_img/apply/tab_day02.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_day02on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_day02.gif'"></a><a href="price_list.jsp?menu_item1=01&menu_item4=<%=menu_item4%>&use_date=20071201"><img src="<%=imageServer%>/tour_img/apply/tab_day04.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_day04on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_day04.gif'"></a><img src="<%=imageServer%>/tour_img/apply/tab_day_rig.gif" width=414 height=28>
							<%}else if (menu_item1.equals("20")){ %>
								<a href="price_list.jsp?menu_item1=30&menu_item4=<%=menu_item4%>&use_date=20070801"><img src="<%=imageServer%>/tour_img/apply/tab_day01.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_day01on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_day01.gif'"></a><a href="price_list.jsp?menu_item1=20&menu_item4=<%=menu_item4%>&use_date=20071101"><img src="<%=imageServer%>/tour_img/apply/tab_day02on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_day02on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_day02on.gif'"></a><a href="price_list.jsp?menu_item1=01&menu_item4=<%=menu_item4%>&use_date=20071201"><img src="<%=imageServer%>/tour_img/apply/tab_day04.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_day04on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_day04.gif'"></a><img src="<%=imageServer%>/tour_img/apply/tab_day_rig.gif" width=414 height=28>
							<%}else if (menu_item1.equals("01")){ %>
								<a href="price_list.jsp?menu_item1=30&menu_item4=<%=menu_item4%>&use_date=20070801"><img src="<%=imageServer%>/tour_img/apply/tab_day01.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_day01on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_day01.gif'"></a><a href="price_list.jsp?menu_item1=20&menu_item4=<%=menu_item4%>&use_date=20071101"><img src="<%=imageServer%>/tour_img/apply/tab_day02.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_day02on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_day02.gif'"></a><a href="price_list.jsp?menu_item1=01&menu_item4=<%=menu_item4%>&use_date=20071201"><img src="<%=imageServer%>/tour_img/apply/tab_day04on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_day04on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_day04on.gif'"></a><img src="<%=imageServer%>/tour_img/apply/tab_day_rig.gif" width=414 height=28>
							<%}else{%>
								<a href="price_list.jsp?menu_item1=30&menu_item4=<%=menu_item4%>&use_date=20070801"><img src="<%=imageServer%>/tour_img/apply/tab_day01.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_day01on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_day01.gif'"></a><a href="price_list.jsp?menu_item1=20&menu_item4=<%=menu_item4%>&use_date=20071101"><img src="<%=imageServer%>/tour_img/apply/tab_day02.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_day02on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_day02.gif'"></a><a href="price_list.jsp?menu_item1=01&menu_item4=<%=menu_item4%>&use_date=20071201"><img src="<%=imageServer%>/tour_img/apply/tab_day04.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_day04on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_day04.gif'"></a><img src="<%=imageServer%>/tour_img/apply/tab_day_rig.gif" width=414 height=28>
							<%}%>
							</td>
						</tr>
						<tr>
							<td height="33" class="bg_lgreen lpad_15 txt_dgreen"><img src="<%=imageServer%>/tour_img/bu/bu_dgreen_rec.gif" align="absmiddle"> 
							
							
							<% if(menu_item1.equals("30")){%>
							      <strong>�ּ�����</strong>�Ⱓ : <strong>7.27 ~ 8.11 / 9.28 ~ 10.27</strong>
						    <%}else if(menu_item1.equals("20")){%>
							      <strong>������</strong>�Ⱓ : <strong>3.20 ~ 7.26 / 8.12 ~ 9.27 / 10.28 ~ 11.30</strong>
							<%}else if(menu_item1.equals("01")){%>
							      <strong>�񼺼���</strong>�Ⱓ : <strong>1.1 ~ 3.19 / 12.1 ~ 31</strong>
							<%}%>
							
							
							</td>
						</tr>
						</table>
						<!-- ������ / -->
					</td>
				</tr>
				<tr><td height="37"></td></tr>
				<tr>
					<td valign="top">
						<!-- / �Ⱓ ���̺� -->
						<!-- �Ⱓ ���̺� �� -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td>
                             <%
                               if (menu_item4.equals("28")){  //2�� 3��
                             %> 
                             	<img src="<%=imageServer%>/tour_img/apply/tab_pricetab01on.gif">
                             	<a href="price_list.jsp?menu_item1=<%=menu_item1%>&menu_item4=27&use_date=<%=use_date%>"><img src="<%=imageServer%>/tour_img/apply/tab_pricetab02.gif"></a>
                             	<a href="price_list.jsp?menu_item1=<%=menu_item1%>&menu_item4=30&use_date=<%=use_date%>"><img src="<%=imageServer%>/tour_img/apply/tab_pricetab03.gif"></a>
                             <%
                               }else if (menu_item4.equals("27")){  //1�� 2��
                             %>
                             	<a href="price_list.jsp?menu_item1=<%=menu_item1%>&menu_item4=28&use_date=<%=use_date%>"><img src="<%=imageServer%>/tour_img/apply/tab_pricetab01.gif">
                             	<img src="<%=imageServer%>/tour_img/apply/tab_pricetab02on.gif"></a>
                             	<a href="price_list.jsp?menu_item1=<%=menu_item1%>&menu_item4=30&use_date=<%=use_date%>"><img src="<%=imageServer%>/tour_img/apply/tab_pricetab03.gif"></a>
                             <%
                               }else if (menu_item4.equals("30")){  //����
                             %>
                             	<a href="price_list.jsp?menu_item1=<%=menu_item1%>&menu_item4=28&use_date=<%=use_date%>"><img src="<%=imageServer%>/tour_img/apply/tab_pricetab01.gif">
                             	<a href="price_list.jsp?menu_item1=<%=menu_item1%>&menu_item4=27&use_date=<%=use_date%>"><img src="<%=imageServer%>/tour_img/apply/tab_pricetab02.gif"></a>
                             	<img src="<%=imageServer%>/tour_img/apply/tab_pricetab03on.gif"></a>
                             <%
                               }
                             %>
							</td>
							<td align="right" valign="bottom" class="rpad_10">(���� : <strong>��,1��</strong>)</td>
						</tr>
						</table>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="2" colspan="9" class="line_dg"></td></tr>
						<tr align="center">
							<td width="140" height="28"><img src="<%=imageServer%>/tour_img/txt_price01.gif"><!-- ���Ǹ� --></td>
							<td width="140"><img src="<%=imageServer%>/tour_img/txt_price02.gif"><!-- ȣ�ڸ� --></td>
							<td width="50"><img src="<%=imageServer%>/tour_img/txt_price03.gif"><!-- ���� --></td>
							<td width="60"><img src="<%=imageServer%>/tour_img/txt_price04.gif"><!-- ���� --></td>
							<td width="60"><img src="<%=imageServer%>/tour_img/txt_price05.gif"><!-- ���л� --></td>
							<td width="60"><img src="<%=imageServer%>/tour_img/txt_price06.gif"><!-- �߰�� --></td>
							<td width="60"><img src="<%=imageServer%>/tour_img/txt_price07.gif"><!-- �ʵ� --></td>
							<td width="60"><img src="<%=imageServer%>/tour_img/txt_price08.gif"><!-- �Ƶ� --></td>
							<td width="60"><img src="<%=imageServer%>/tour_img/txt_price09.gif"><!-- ���� --></td>
						</tr>
						<tr><td height="1" colspan="9" class="line_dg"></td></tr>
						</table>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="140" align="center"><col width="550">
						
            <% 
            if(price_record.length <= 0){ 
            %>
            
						<tr>
							<td class="cglg" colspan="2" align="center" height="200">��ϵ� �����Ͱ� �����ϴ�.</td>
						</tr>

            <%
            }else{
            	//����Ʈ ȭ�鿡 ����
            	pre_upjang_cd = "";
            	int record_num = 0;
            	for(int i=0;i<price_record.length; i++){ 
            		Price_bean tbean   = price_record[i];
            		
                    upjang_nm = tbean.getUpjang_nm();
                    upjang_cd = tbean.getUpjang_cd();    

	                upjang_sid	= tbean.getUpjang_sid();
	                menu_item1	= tbean.getMenu_item1();
                    menu_item2	= tbean.getMenu_item2();
                    menu_item3	= tbean.getMenu_item3();
                    menu_item4	= tbean.getMenu_item4();
                    menu_item5	= tbean.getMenu_item5();
                    menu_nm	= tbean.getMenu_nm();
                    end_persons	= tbean.getEnd_persons();
                    std_persons	= tbean.getStd_persons();
                    persons_info	= tbean.getPersons_info();
                    
                    amt1 = NumberFormat.getInstance().format(tbean.getAmt1());
                    amt2 = NumberFormat.getInstance().format(tbean.getAmt2());
                    amt3 = NumberFormat.getInstance().format(tbean.getAmt3());
                    amt4 = NumberFormat.getInstance().format(tbean.getAmt4());
                    amt5 = NumberFormat.getInstance().format(tbean.getAmt5());
                    amt6 = NumberFormat.getInstance().format(tbean.getAmt6());
                    room_type_nm	= tbean.getRoom_type_nm();
                    
            %>
 
 
             <%
            		if (record_num > 0 && !pre_upjang_cd.equals(upjang_cd)){ //ȣ�ں����(2)...

            %>
            
					  </table>
				  </td>
				  </tr>
						<tr><td height="2" colspan="2" class="line_dg"></td></tr>
	        <%
	            } //ȣ�ں����(2)...
	               
	               
	               %>
            <%
            		if (pre_upjang_cd == "" || !pre_upjang_cd.equals(upjang_cd)){ //ȣ�ں����(1)...
            %>
						<tr>
							<td class="cglg"><%=upjang_nm%></td>
							<td>
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<col width="140" align="center"><col width="50" align="center">
								<col width="50" align="right" class="rpad_10"><col width="50" align="right" class="rpad_10"><col width="50" align="right" class="rpad_10">
								<col width="50" align="right" class="rpad_10"><col width="50" align="right" class="rpad_10"><col width="50" align="right" class="rpad_10">
	        <%
	            } //ȣ�ں����(1)...
	        %>
								<tr>
									<td height="23" class="cglg"><!--<%=room_type_nm%>--><%=menu_nm%></td>
									<td class="cglg"><!--<%=std_persons%>--><%=persons_info%></td>
									<td class="cglg"><%=amt1%></td>
									<td class="cglg"><%=amt2%></td>
									<td class="cglg"><%=amt3%></td>
									<td class="cglg"><%=amt4%></td>
									<td class="cglg"><%=amt5%></td>
									<td class="cglg"><%=amt6%></td>
								</tr>
            <%
	               
	               record_num = record_num +1;
	               pre_upjang_cd = upjang_cd; //ȣ���ڵ带 ��´�..
	        %>

	        <%
	            }//for
	        %>
						    </table>
						
	                      </td>
						</tr>
						<tr><td height="2" colspan="2" class="line_dg"></td></tr>
	        <%
	        } //price_record.length <= 0
	        %>	

			  </table>						
						<!-- �Ⱓ ���̺� / -->
		  </td>
		  </tr>

				<tr><td height="29"></td></tr>
				
				
				
				
<%
     menu_item4 = ParamUtil.getReqParameter(request.getParameter("menu_item4"),"28");
     if (!menu_item4.equals("30")){  //If (1) �����ڵ尡 �ƴϸ�
%>
				<tr>
					<td valign="top">
						<!-- / ��Ÿ��ݾȳ� ���̺� -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="24" valign="top"><img src="<%=imageServer%>/tour_img/apply/stit_etcprice.gif"></td></tr>
						</table>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="2" colspan="3" class="line_dg"></td></tr>
						<tr align="center">
							<td width="86" height="28"><img src="<%=imageServer%>/tour_img/txt_price10.gif"><!-- ���� --></td>
							<td width="508"><img src="<%=imageServer%>/tour_img/txt_price11.gif"><!-- ���� --></td>
							<td width="96"><img src="<%=imageServer%>/tour_img/txt_price12.gif"><!-- ��� --></td>
						</tr>
						<col width="100" style="padding:15 5 15 30px;"><col width="360" style="padding:15 5 15 5px;"><col width="165" style="padding:15 5 15 15px;">
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						
						
						<% 
						    if (menu_item4.equals("27")){ //if(2)1��
						%>
						<tr> 
							<td class="cwlg">&nbsp;</td>
						  <td class="cwlg">&nbsp;</td>
							<td class="cwlg">&nbsp;</td>
						</tr>
					       <%
					           }else{  //if(2)	2��
					       %>
						<tr> 
							<td class="cwlg"><div align="center">�ָ����</div></td>
							<td class="cwlg"><p>�ݿ���/����� ��� : 1�� 2�� <BR>
							    <strong> ������ 30,000�� <strong>�߰�</strong><br>
							    <strong> �ּ����� 60,000�� �߰� </strong></strong></p>
						    <p>�ݿ���/����� ��� : 2�� 3��<BR><strong>������ 50,000��</B> �߰�<br>
			                    �ּ����� 90,000��</B> �߰� </strong><br>
				              </p>
						    </td>
							<td class="cwlg"><br>
						  ���л�/���θ� �ش�</td>
						</tr>
						<%
						    }  //if(2)
						%>
						
						
												<tr> 
							<td class="cwlg"><p align="center">���ݰ�<br>����<br>���</p>
						  </td>
						  <td class="cwlg"><p><strong>���ݰ����� ��� :  �⺻ 2�� 3�� ������� <font color=red>+ 50,000��</font></strong></p>
						    <p>���� ����� : ���� ���(2�� 3��) /  ���� �Ը� : �� 150����</p>						    
						    
    <table width="500" border="0" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
      <tr> 
        <td width="64" rowspan="2" bgcolor="#FFFFFF"><div align="center">����</div></td>
        <td colspan="3" bgcolor="#FFFFFF"><div align="center">�⺻ 2�� 3�� �������<br>
            (����1��/���Ĵٵ尴��)<br>
          </div></td>
        <td colspan="4" bgcolor="#F7F7F7"><div align="center"><font color="#333333"><strong>���ݰ� 
            �������<br>
            (����1��/���Ĵٵ尴��)</strong></font></div></td>
      </tr>
      <tr> 
        <td width="91" bgcolor="#FFFFFF"><div align="center">�����</div></td>
        <td width="86" bgcolor="#FFFFFF"><div align="center">������</div></td>
        <td width="88" bgcolor="#FFFFFF"><div align="center">�ּ�����</div></td>
        <td width="87" bgcolor="#F7F7F7"><div align="center"><font color="#333333"><strong>�����</strong></font></div></td>
        <td width="83" bgcolor="#F7F7F7"><div align="center"><font color="#333333"><strong>������</strong></font></div></td>
        <td width="93" bgcolor="#F7F7F7"><div align="center"><font color="#333333"><strong>�ּ�����</strong></font></div></td>
      </tr>
      <tr> 
        <td bgcolor="#FFFFFF"><div align="center">ȣ��</div></td>
        <td bgcolor="#FFFFFF"><div align="center">290,000</div></td>
        <td bgcolor="#FFFFFF"><div align="center">390,000</div></td>
        <td bgcolor="#FFFFFF"><div align="center">490,000</div></td>
        <td bgcolor="#F7F7F7"><div align="center"><font color="#333333"><strong>340,000</strong></font></div></td>
        <td bgcolor="#F7F7F7"><div align="center"><font color="#333333"><strong>440,000</strong></font></div></td>
        <td bgcolor="#F7F7F7"><div align="center"><font color="#333333"><strong>540,000</strong></font></div></td>
      </tr>
      <tr> 
        <td bgcolor="#FFFFFF"><div align="center">���</div></td>
        <td bgcolor="#FFFFFF"><div align="center">260,000</div></td>
        <td bgcolor="#FFFFFF"><div align="center">340,000</div></td>
        <td bgcolor="#FFFFFF"><div align="center">440,000</div></td>
        <td bgcolor="#F7F7F7"><div align="center"><font color="#333333"><strong>310,000</strong></font></div></td>
        <td bgcolor="#F7F7F7"><div align="center"><font color="#333333"><strong>390,000</strong></font></div></td>
        <td bgcolor="#F7F7F7"><div align="center"><font color="#333333"><strong>490,000</strong></font></div></td>
      </tr>
      <tr> 
        <td bgcolor="#FFFFFF"><div align="center">������</div></td>
        <td bgcolor="#FFFFFF"><div align="center">250,000</div></td>
        <td bgcolor="#FFFFFF"><div align="center">250,000</div></td>
        <td bgcolor="#FFFFFF"><div align="center">320,000</div></td>
        <td bgcolor="#F7F7F7"><div align="center"><font color="#333333"><strong>290,000</strong></font></div></td>
        <td bgcolor="#F7F7F7"><div align="center"><font color="#333333"><strong>300,000</strong></font></div></td>
        <td bgcolor="#F7F7F7"><div align="center"><font color="#333333"><strong>370,000</strong></font></div></td>
      </tr>
    </table>					      
					      <p> * ���ݰ� ���� �߰� ����� ���� ���� ���� �Ұ�</p>						    </td>
							<td class="cwlg">&nbsp;</td>
						</tr>
						<tr> 
							<td class="cwlw"><div align="center">ȯ�ұ���</div></td>
						  <td class="cwlw"><table width="500" border="0" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
      <tr bgcolor="#FFFFFF"> 
        <td colspan="2"><div align="center">��� ������ </div></td>
      </tr>
      <tr bgcolor="#FFFFFF"> 
        <td width="244" bgcolor="#FFFFFF"> ��� 10�� �� </td>
        <td width="245"><div align="center">����</div></td>
      </tr>
      <tr bgcolor="#FFFFFF"> 
        <td>��� 9�� �� ~ ���� ���� �� </td>
        <td><div align="center">50%</div></td>
      </tr>
      <tr bgcolor="#FFFFFF"> 
        <td>���� ���� �� </td>
        <td><div align="center">100%</div></td>
      </tr>
    </table></td>
						  <td class="cwlw"><br></td>
						</tr>
						<tr><td height="2" colspan="3" class="line_dg"></td></tr>
						</table>
						<!-- ��Ÿ��ݾȳ� ���̺� / -->
					</td>
				</tr>


<%
} else { //�����̸�
%>
				<tr>
					<td valign="top">
						<!-- / ��Ÿ��ݾȳ� ���̺� -->
						<!--<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="24" valign="top"><img src="<%=imageServer%>/tour_img/apply/stit_etcprice.gif"></td></tr>
						</table>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="2" colspan="3" class="line_dg"></td></tr>
						<tr align="center">
							<td height="28"><img src="<%=imageServer%>/tour_img/txt_price10.gif"><!-- ���� --></td>
							<!--<td><img src="<%=imageServer%>/tour_img/txt_price11.gif"><!-- ���� --></td>
							<!--<td><img src="<%=imageServer%>/tour_img/txt_price12.gif"><!-- ��� --></td>
						<!--</tr>
						<col width="100" style="padding:15 5 15 30px;"><col width="360" style="padding:15 5 15 5px;"><col width="165" style="padding:15 5 15 15px;">
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						
						
						<tr> 
							<td class="cwlg">���ϰ���</td>
							<td class="cwlg">��õ 1ȸ ��������</td>
							<td class="cwlg">2007.3.20 ������ ����</td>
						</tr>
						<tr><td height="2" colspan="3" class="line_dg"></td></tr>
						</table>
						<!-- ��Ÿ��ݾȳ� ���̺� / -->
					</td>
				</tr>

<%
} //if(1)
%>
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


</body>
</html>