<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%   
String McNum = "3";
String sub = "2";
String pageNum = "2";
String subNum = "";
%>
<head>
<title> �ݰ������    </title>
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
<p>				
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/start/tit_start02.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">��߾ȳ�</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">����ȳ�</span></td>
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
				<tr><td><img src="<%=imageServer%>/tour_img/start/img_top_start02.jpg"></td></tr>
				<tr>
					<td>
						<table width="685" cellpadding="0" cellspacing="0" border="0" style="margin-left:5px;">
						<tr>
							<td width="11" height="15"></td>
							<td width="674"></td>
						</tr>
						<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/start/stit_start021.gif"></td></tr>
						<tr><td colspan="2" height="12"></td></tr>
						<tr>
							<td></td>
							<td>ȭ���� �ƻ� �ްԼҴ� �ݰ��꿡 ���� ���� �������Դϴ�. �������� ���ø� Ƽ�� �߱� ���� ������ �����Ͻ� �� �ֽ��ϴ�.</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/tour_img/start/stit_start0211.gif"><!-- �൵ --></td>
						</tr>
						<tr><td colspan="2" height="10"></td></tr>
						<tr>
							<td></td>
							<td>- ������ : ȭ���� �ƻ� �ްԼ�<br>- ��&nbsp;&nbsp;&nbsp;�� : ������ ���� ������ �ʵ��� ��28����<br>- ������ ���� ���� : ����ƻ� ���繫�� �� (033)681-9400</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/tour_img/start/img_map_start02.jpg" width="674"></td>
						</tr>
						<tr><td colspan="2" height="20"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/tour_img/start/stit_start0212.gif"><!-- ž�� ���ӽð� --></td>
						</tr>
						<tr><td colspan="2" height="10"></td></tr>
						<tr>
							<td></td>
							<td>- 2�� 3�� : 12:00<br>- 1�� 2��(8�����) : 06:00<br>- 1�� 2��(11�����) : 09:30<br>- ���� : 06:00<br>�� ž�� ���ӽð��� ���� �ʵ��� �����ϼž� �ϸ�, ����������� �ȳ��� �����Ͽ� �ֽñ� �ٶ��ϴ�.</td>
						</tr>
						<tr><td colspan="2" height="47"></td></tr>
						<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/start/stit_start022.gif"></td></tr>
						<tr><td colspan="2" height="20"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/tour_img/start/stit_start0221.gif"><!-- �������� �̿� ������ ���� �� --></td>
						</tr>
						<tr><td colspan="2" height="10"></td></tr>
						<tr>
							<td></td>
							<td>ȭ���� �ƻ� �ްԼҿ� ���������� �����ϸ� ȭ���� �ƻ� �ްԼҿ��� �������Ի繫�ұ����� �պ� ��������� ������ �����ϼž� �մϴ�.</td>
						</tr>
						<tr><td colspan="2" height="12"></td></tr>
						<tr>
							<td></td>
							<td>
								<table width="674" bgcolor="#F6F6F6" cellpadding="0" cellspacing="0" border="0">
								<tr><td height="15"></td></tr>
								<tr>
									<td align="center">
										<table width="640" cellpadding="0" cellspacing="0" border="0">
										<tr valign="top">
											<td width="9"><img src="<%=imageServer%>/tour_img/bu/bu_gray_arw.gif" vspace="4"></td>
											<td width="631">������� - �ȴ�뱳 - ���� - ȫõ - ����(44��) - ���� - ����Ÿ� - ���η� - �������� ����<br>- ���������� �ܱ�(7�� ����) - ȭ���� �ƻ��ްԼ� ����</td>
										</tr>
										<tr valign="top" class="tpad_5">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_gray_arw.gif" vspace="4"></td>
											<td>������� - ��Ŀ�� - ������ - ���� - ��õ - �߾Ӱ�ӵ��� - ȫõ - ���� - ���� -��븮 - ���η� - ������������<br>- ���������� �ܱ�(7�� ����) - ȭ���� �ƻ��ްԼ� ����</td>
										</tr>
										<tr valign="top" class="tpad_5">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_gray_arw.gif" vspace="4"></td>
											<td>������ӵ��� - ���� - �߾Ӱ�ӵ��� - ȫõ - ���� - ���� - ����Ÿ� - ���η� - ������������<br>- ���������� �ܱ�(7�� ����) - ȭ���� �ƻ��ްԼ� ����</td>
										</tr>
										<tr valign="top" class="tpad_5">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_gray_arw.gif" vspace="4"></td>
											<td>������ӵ��� - ���� - �ֹ��� - ���� - �������� - ���������� �ܱ�(7�� ����) - ȭ���� �ƻ��ްԼ� ����</td>
										</tr>
										</table>
									</td>
								</tr>
								<tr><td height="15"></td></tr>
								</table>
							</td>
						</tr>
						<tr><td colspan="2" height="20"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/tour_img/start/stit_start0222.gif"><!-- ��ü���� �̿� ��   --></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>�������κ��� ��ü�� ���������� �̿��Ͻô� �е��� �ּ� 5�������� ������ �Ͻ� �븮������ ������ȣ�� ž���ο� ���� �ݵ�� �뺸�Ͻñ� �ٶ��ϴ�.<br>�� ������ȣ�� ������ ���� ���δ뿡 �뺸�ؾ߸� ���뼱 �˹��� ����� �����մϴ�</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/tour_img/start/stit_start0223.gif"><!-- �������� �̿� ��(����) --></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>������ ���Ǹ� ���Ͽ� ���������� ��߽ð��� �����ð��� ���� �����(�������Ի繫��)������ ������ ���������� �����մϴ�. �ʿ��Ͻ� �������� �Ʒ��� ���� ����ȸ��� ���� �����Ͽ� �ֽñ� �ٶ��ϴ�.</td>
						</tr>
						<tr><td colspan="2" height="27"></td></tr>
						<tr>
							<td></td>
							<td height="27" valign="top">- <strong>�ݰ������ �� ������ �������� ���� ��Ȳ</strong></td>
						</tr>
						<tr>
							<td></td>
							<td valign="top">
								<table width="674" cellpadding="1" cellspacing="1" border="0" class="tabline">
								<tr align="center">
									<td width="47" height="26" class="bg_white">����</td>
									<td width="39" class="bg_white">����</td>
									<td width="47" class="bg_white">�����</td>
									<td width="61" class="bg_white">����<br>ȸ��</td>
									<td width="67" class="bg_white">����ó</td>
									<td width="47" class="bg_white">���<br>�ð�</td>
									<td width="246" class="bg_white">�����</td>
									<td width="75" class="bg_white">�պ����<span class="fs11">(��)</span></td>
									<td width="45" class="bg_white">�൵</td>
								</tr>
								<tr align="center">
									<td class="bg_white" rowspan="2">1��2��<br>(11��)</td>
									<td class="bg_white b" rowspan="2">����</td>
									<td class="bg_white" rowspan="2">����</td>
									<td class="bg_white" rowspan="2">��ȭ<br>����</td>
									<td class="bg_white lpad_10" rowspan="2" align="left">02)<br>764-2255</td>
									<td height="26" class="bg_white">05:50</td>
									<td class="bg_white lpad_5" align="left">��ȭ����Ÿ� ���빮���� 70m ���������</td>
									<td class="bg_white" rowspan="2"><font color="#459E9D">30,000��/��</font></td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_map_gwanghwa.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a><!-- ���� --></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">06:20</td>
									<td class="bg_white lpad_5" align="left">���տ�� 6���ⱸ GS������ ��</td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_map_jamsil.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a><!-- ���� --></td>
								</tr>
								<tr align="center">
									<td class="bg_white" rowspan="15">2��3��</td>
									<td class="bg_white b" rowspan="4">����</td>
									<td class="bg_white" rowspan="4">����</td>
									<td class="bg_white" rowspan="2">��ȭ<br>����</td>
									<td class="bg_white lpad_10" rowspan="2" align="left">02)<br>733-0017</td>
									<td height="26" class="bg_white">08:00</td>
									<td class="bg_white lpad_5" align="left">�赿 ������ ���������� ��</td>
									<td class="bg_white" rowspan="4"><font color="#459E9D">30,000��/��</font></td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_map_gaedong.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a><!-- ���� --></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">08:15</td>
									<td class="bg_white lpad_5" align="left">��ȭ����Ÿ� ���빮���� 70m ���������</td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_map_gwanghwa.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a><!-- ���� --></td>
								</tr>
								<tr align="center">
									<td class="bg_white" rowspan="2">���<br>����</td>
									<td class="bg_white lpad_10" rowspan="2" align="left">02)<br>575-7710</td>
									<td height="26" class="bg_white">08:00</td>
									<td class="bg_white lpad_5" align="left">�б��� �����ȭ�� ������</td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_map_apgujung.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a><!-- ���� --></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">08:30</td>
									<td class="bg_white lpad_5" align="left">���տ�� 6���ⱸ GS������ ��</td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_map_jamsil.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a><!-- ���� --></td>
								</tr>
								<tr align="center">
									<td class="bg_white b" rowspan="4">����</td>
									<td class="bg_white" rowspan="4">��,��,��</td>
									<td class="bg_white" rowspan="4">����<br>����</td>
									<td class="bg_white lpad_10" rowspan="4" align="left">1544-5980</td>
									<td height="26" class="bg_white">06:30</td>
									<td class="bg_white lpad_5" align="left">�������� �ý� ���尭 ��</td>
									<td class="bg_white" rowspan="4"><font color="#459E9D">40,000��/��</font></td>
									<td class="bg_white"></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">06:50</td>
									<td class="bg_white lpad_5" align="left">������ ������ ���� �ⱸ ������ ��</td>
									<td class="bg_white"></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">07:30</td>
									<td class="bg_white lpad_5" align="left">û�� �ÿܹ����͹̳� �ǳ��� GS������ ��</td>
									<td class="bg_white"></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">08:00</td>
									<td class="bg_white lpad_5" align="left">õ�� �����Ʈ ������ ���� ��</td>
									<td class="bg_white"></td>
								</tr>
								<tr align="center">
									<td class="bg_white b" rowspan="4">����</td>
									<td class="bg_white" rowspan="4">��,��</td>
									<td class="bg_white" rowspan="4">���λ�<br>��������</td>
									<td class="bg_white lpad_10" rowspan="4" align="left">051)<br>851-0600</td>
									<td height="26" class="bg_white">05:50</td>
									<td class="bg_white lpad_5" align="left">������͸� KT��ȭ���� �������� ��</td>
									<td class="bg_white" rowspan="2"><font color="#459E9D">70,000��/��</font></td>
									<td class="bg_white"></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">06:10</td>
									<td class="bg_white lpad_5" align="left">��������ö ���������� ��</td>
									<td class="bg_white"></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">07:10</td>
									<td class="bg_white lpad_5" align="left">���������Ʈ ������ ���� �ްԼ�</td>
									<td class="bg_white" rowspan="2"><font color="#459E9D">60,000��/��</font></td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_map_goungjutol.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a><!-- ���� --></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">08:10</td>
									<td class="bg_white lpad_5" align="left">���뱸 �����Ʈ ��</td>
									<td class="bg_white"><a href="javascript:;" onclick="window.open ('popup_map_dongdaegu.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/tour_img/btn/btn_s_view.gif"></a><!-- ���� --></td>
								</tr>
								<tr align="center">
									<td class="bg_white b" rowspan="3">ȣ��</td>
									<td class="bg_white" rowspan="3">��,��</td>
									<td class="bg_white" rowspan="3">�۱�����<br>����</td>
									<td class="bg_white lpad_10" rowspan="3" align="left">062)<br>383-1133</td>
									<td height="26" class="bg_white">05:00</td>
									<td class="bg_white lpad_5" align="left">���� ������ �۱������ ��</td>
									<td class="bg_white" rowspan="3"><font color="#459E9D">60,000��/��</font></td>
									<td class="bg_white"></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">06:00</td>
									<td class="bg_white lpad_5" align="left">���� ����IC(ȣ����ӵ���)</td>
									<td class="bg_white"></td>
								</tr>
								<tr align="center">
									<td height="26" class="bg_white">06:50</td>
									<td class="bg_white lpad_5" align="left">���� �����Ű���� ������</td>
									<td class="bg_white"></td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td colspan="2" height="25"></td></tr>
						<tr>
							<td colspan="2" align="right"><a href="javascript:;" onclick="fc_print();"><img src="<%=imageServer%>/tour_img/btn/btn_start_print.gif" class="btn"></a><!-- �μ��ϱ� --></td>
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