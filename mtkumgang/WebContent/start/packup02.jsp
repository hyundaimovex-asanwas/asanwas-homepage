<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %> 
<% 
String McNum = "3";
String sub = "1";
String pageNum = "1";
String subNum = "";
%>
<html>
<head>
<title> �ݰ������   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
<script language="javascript"> 
    function fc_print()
    { 
       //document.all.prt.style.display="none";
       var win = window.open("/common/blank.jsp","print","left=-10000,top=-10000,width="+ (document.all.print_area.offsetWidth + 18) + ",height="+document.all.print_area.offsetHeight);
       
       //document.all.prt.style.display = "";
       // window.print();
    } 
</script> 
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../include/start/tour_start_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="../include/start/tour_start_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/start/tit_start01.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">��߾ȳ�</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">���ٸ���</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

<DIV id="print_area" class=newpage style="width:690">
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/start/img_top_start01.jpg"></td></tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td>
						<!-- / �Ǹ޴� -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td width="102" height="28"><a href="packup01.jsp"><img src="<%=imageServer%>/tour_img/start/tab_start0101.gif" onmouseover="this.src='<%=imageServer%>/tour_img/start/tab_start0101_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/start/tab_start0101.gif'"></a></td>
							<td width="102"><img src="<%=imageServer%>/tour_img/start/tab_start0102_on.gif"></td>
							<td width="2"><img src="<%=imageServer%>/tour_img/start/tab_start0111.gif"></td>
							<td width="482" background="<%=imageServer%>/tour_img/start/tab_start0112.gif"></td>
							<td width="2"><img src="<%=imageServer%>/tour_img/start/tab_start0113.gif"></td>
						</tr>
						</table>
						<table width="690" class="bg_lgreen" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td  height="33" class="txt_dgreen tpad_10 bpad_10 lpad_25 rpad_10 lh20">
								�� 10���� �̻��� �־Ȱ�/������, 160�̸� �̻��� ������� �޸� ������, 24����(���б���) �̻��� �ܷ�� �޸�<br>&nbsp;&nbsp;&nbsp;&nbsp;����ī�޶�<br>
								�� ������ ġ������� ���� ���� ������, ��ǥ�� ������ ���� �� ���а� �뵵�� �� �� ���� ��ǰ �� ��ǰ<br>
								�� �������� ��ȭ��Ȱ �� ���Ǹ������� �����Ǵ� ������ ������ ������ �μ⹰, �׸�, ������, ��ȭ������<br>
								�� ��������<br>
								�� �Ƿ������ ���� ���� ������ ����, ����, �� ���� ������ ȭ�й���<br>
								�� ����, ��ź, ���߹�, ����ǰ, ���, ��缺����, ��ȭ����<br>
								�� ������� �� �μ�ǰ<br>
								�� �������� �߻��� ������ ����<br>
								�� ��Ÿ ������ �������� �ʴ� ����
							</td>
						</tr>
						</table>
						<!-- �Ǹ޴� / -->
					</td>
				</tr>
				<tr><td height="30"></td></tr>
				<tr>
					<td>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr class="bpad_15" valign="top">
							<td width="135"><img src="<%=imageServer%>/tour_img/start/img_start0121.jpg" width="115" height="110"></td>
							<td width="555"><img src="<%=imageServer%>/tour_img/start/txt_start0121.gif" style="margin-top:2px;"></td>
						</tr>
						<tr class="bpad_15" valign="top">
							<td><img src="<%=imageServer%>/tour_img/start/img_start0122.jpg" width="115" height="110"></td>
							<td><img src="<%=imageServer%>/tour_img/start/txt_start0122.gif" style="margin-top:2px;"></td>
						</tr>
						<tr><td height="10" colspan="4"></td></tr>
						<tr>
							<td align="right" colspan="4"><a href="javascript:;" onclick="fc_print()"><img src="<%=imageServer%>/tour_img/btn/btn_start_print.gif" class="btn"></a><!-- �μ��ϱ� --></td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
</div>
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
        <%@ include file="../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>