<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%   
  String pageNum = "3";
  String McNum = "0";
  String sub = "1";  
  
%>
<html>
<head>
<title> �ݰ������      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
<script language="javascript">
<!--
function goResv() {
	window.open("/preserv/plz_resv_pop.jsp", "", "width=730, height=500 scrollbars=no");
}
-->
</script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../include/plz/tour_plz_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="../include/plz/tour_plz_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/preview/tit_preview01.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">PLZ����</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2">��ǰ�ȳ�<img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2">��ǰ1</td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="22"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz03_01.jpg"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz03_02.jpg"></td></tr>
				<tr><td>
				
				
<table border="0" cellpadding="0" cellspacing="0" width="690">
	<tr height="2">
			<td height="2" colspan="10" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="26">
			<td width="1" align="center" bgcolor="#CCCCCC"></td>
			<td width="36" align="center">����</td>
			<td width="1" height="26" align="center" bgcolor="#CCCCCC"></td>
			<td width="22" height="26" align="center">��</td>
			<td width="138" height="26" align="center">�븮����</td>
			<td width="63" height="26" align="center">��ǥ</td>
			<td height="26" align="center">�ּ�</td>
			<td width="98" height="26" align="center">��ȭ��ȣ</td>
			<td width="84" height="26" align="center">�ѽ�</td>
			<td width="1" height="26" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="2">
			<td height="2" colspan="10" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td rowspan="28" align="center" bgcolor="#CCCCCC"></td>
			<td rowspan="28" align="center">����</td>
			<td width="1" height="672" rowspan="28" align="center" bgcolor="#CCCCCC"></td>
			<td align="center">1</td>
			<td>&nbsp;�߾���Ư���ѿ���</td>
			<td>������</td>
			<td>���� ������ �Ｚ2��38-29
		  �Ѿ���� 2F</td>
			<td>02-545-3994</td>
			<td>02-545-6882</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">2</td>
			<td>&nbsp;������H&amp;S</td>
			<td>ȫ����</td>
			<td>���� ������ �ϻ絿513-16
		  ����H&amp;S���� 3��</td>
			<td>02-3014-2501</td>
			<td>02-3014-2519</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">3</td>
			<td>&nbsp;���Ͽ��κ���Ʈ��Ʈ</td>
			<td>�ȱ���</td>
			<td>���� ������ �浿445-3 
		  ������� 14��</td>
			<td>02-6911-7700</td>
			<td>02-6911-7710</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">4</td>
			<td>&nbsp;�����ϳ����������</td>
			<td>�����</td>
			<td>���� ���ʱ� ���絿223����<br>
		  ���Ž��� 314ȣ</td>
			<td>070-7101-5519</td>
			<td>02-577-7318</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">5</td>
			<td>&nbsp;�߰���帲����</td>
			<td>������</td>
			<td>���� ���ʱ� ���絿215<br>
		  ���̺귣�� ������ 13�� 1321</td>
			<td>02-572-8161</td>
			<td>02-2155-3161</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">6</td>
			<td>&nbsp;��K�ڿ���Ʈ����</td>
			<td>����ȭ</td>
			<td>���� ������ ��䵿103-1
		  �׸����� 1��</td>
			<td>02-757-7780</td>
			<td>02-2242-4050</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">7</td>
			<td>&nbsp;��ä�ζ���</td>
			<td>�ֿ��</td>
			<td>���� ���ı� ���ݵ�28����<br>
		  ���ﷹ������Ÿ�� 1�� 2ȣ</td>
			<td>02-449-6071</td>
			<td>02-404-6078</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">8</td>
			<td>&nbsp;���̸����������</td>
			<td>����ȫ</td>
			<td>���� ���ı� ���ĵ�146-2
		  �������� 303ȣ</td>
			<td>02-515-1889</td>
			<td>02-412-5511</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">9</td>
			<td>&nbsp;�ݰ��������߿���</td>
			<td>��â��</td>
			<td>���� ��걸    �ľϵ�105-194</td>
			<td>02-779-6664</td>
			<td>02-730-6662</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">10</td>
			<td>&nbsp;��VIP���������</td>
			<td>�輺��</td>
			<td>���� ��걸 ������66    �žƺ��� 1F</td>
			<td>02-319-3322</td>
			<td>02-319-3343</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">11</td>
			<td>&nbsp;�ڷ�������񽺢�</td>
			<td>���</td>
			<td>���� ��걸 û�ĵ�1��95<br>
		  KORAIL KTX B/D 2��</td>
			<td>02-2084-7727</td>
			<td>02-2084-7719</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">12</td>
			<td>&nbsp;�߱⵶����ۿ����</td>
			<td>�赿��</td>
			<td>���� ��õ�� ��917-1    �⵶����� 11��</td>
			<td>02-2061-3311</td>
			<td>02-2645-5522</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">13</td>
			<td>&nbsp;�ݰ�����Ģ�</td>
			<td>ȫ����</td>
			<td>���� ���α� �ȱ���148����    �ؿ�ȸ��906ȣ</td>
			<td>02-739-1090</td>
			<td>(02) 739-3222</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">14</td>
			<td>&nbsp;�߼��Ͽ����</td>
			<td>���ֿ�</td>
			<td>���� ���α� ��91-1</td>
			<td>02-724-0642</td>
			<td>02-733-2884</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">15</td>
			<td>&nbsp;���ϳ�����</td>
			<td>�ڻ�ȯ</td>
			<td>���� ���α� ����1����<br>
			  (��)�ϳ�������� 5��
		  �ϳ��������ͳ��ų�</td>
			<td>02-398-6522</td>
			<td>02-6234-2301</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">16</td>
			<td>&nbsp;�߿���������</td>
			<td>������</td>
			<td>���� ���α� �λ絿43����    ���Ϻ��� 14/15F</td>
			<td>02-3705-2405</td>
			<td>02-6234-0507</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">17</td>
			<td>&nbsp;�Ե��������ߢ�</td>
			<td>������</td>
			<td>���� ���α� ��ö��266    �Ե��������ߢ�</td>
			<td>1577-3700</td>
			<td>02-736-1355</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">18</td>
			<td>&nbsp;�߸�������Ʈ��ũ</td>
			<td>������</td>
			<td>���� �߱� ������1��188-3    �鳲���� 5��</td>
			<td>02-728-8700</td>
			<td>02-2021-7827</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">19</td>
			<td>&nbsp;��NH����</td>
			<td>�Ǵ���</td>
			<td>���� ���α�    �Ź���1��163���� ���ǽþ� 7��</td>
			<td>02-3276-3947</td>
			<td>02-3276-3940</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">20</td>
			<td>&nbsp;���ѿ���������</td>
			<td>������</td>
			<td>���� ���α� �Ź���1��163    ��ȭ��<br>
		  ���ǽþƺ��� 2023</td>
			<td>02-3276-3733</td>
			<td>02-3276-3732</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">21</td>
			<td>&nbsp;�ߵ�ȭ�װ������</td>
			<td>������</td>
			<td>���� ���ϱ� ������33-13</td>
			<td>02-984-1161</td>
			<td>02-982-8804</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">22</td>
			<td>&nbsp;�η���ȭ����������</td>
			<td>�̿���</td>
			<td>���� ���ϱ� ��1��    446-13 ����Ÿ������<br>
		  1116~1117ȣ</td>
			<td>02-717-0500</td>
			<td>02-707-0050</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">23</td>
			<td>&nbsp;�߿�������</td>
			<td>�Ź���</td>
			<td>���� ���α� ��ϵ�98-5    ��ȯ���� 8��<br>
			  (��)�������� 
		  ���������</td>
			<td>02-720-0909</td>
			<td>02-747-7966</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">24</td>
			<td>&nbsp;�߱ݰ������</td>
			<td>��ȣ��</td>
			<td>���� ���α� ������75    ����õ�� 1101ȣ</td>
			<td>02-722-2118</td>
			<td>02-733-3185</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">25</td>
			<td>&nbsp;������-E�������</td>
			<td>����,<br>
		  �����</td>
			<td>���� ���α� ������ 72<br>
			  ������� ��ħ2���� ���ǽ��� 
		  1418ȣ</td>
			<td>02-720-4343</td>
			<td>02-720-4364</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">26</td>
			<td>&nbsp;�ݼ�������</td>
			<td>������</td>
			<td>���� �߱� ��â��35����    �켺���� 601ȣ</td>
			<td>02-755-5000</td>
			<td>02-778-3003</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">27</td>
			<td>&nbsp;���ϰ�����</td>
			<td>�̽���</td>
			<td>���� �߱� �����2��68-7<br>
		  ������ �����Ϻ����� 1��</td>
			<td>02-775-3333</td>
			<td>02-775-6018</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">28</td>
			<td>&nbsp;�߼����װ������</td>
			<td>��ȫ��</td>
			<td>���� �߱� ������32-2    �������� 7��<br>
		  �����װ������</td>
			<td>02-753-8585</td>
			<td>02-776-1159</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
			
		<tr align="center" height="2">
			<td height="2" colspan="10" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td width="1" rowspan="8" align="center" bgcolor="#CCCCCC"></td>
			<td rowspan="8" align="center">���</td>
			<td width="1" height="209" rowspan="8" align="center" bgcolor="#CCCCCC"></td>
			<td align="center">29</td>
			<td>&nbsp;(��)���ѿ����</td>
			<td>������</td>
			<td>��� �Ȼ�� ���ܵ�533-3    ��ǳ������ 1��</td>
			<td>031-414-6114</td>
			<td>031-410-5443</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">30</td>
			<td>&nbsp;�帲���� (��)</td>
			<td>����ȣ</td>
			<td>��� ������ �д籸������6-9<br>
			  ������������� 3��<br> 
		  313ȣ</td>
			<td>031-718-6636-8</td>
			<td>031-718-6639</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">31</td>
			<td>&nbsp;(��)�Ѽֿ����</td>
			<td>�ֿ���</td>
			<td>��� ������ �Ǽ���    �Ǽ���1165-3 205</td>
			<td>031-231-1777</td>
			<td>031-231-1780</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="33">
			<td height="33" align="center">32</td>
			<td>&nbsp;(��)�ݰ�������</td>
			<td>���ʿ�</td>
			<td width="274">����� �������� ���ǵ��� 45-5����<br>
			  ���������긣 
		  516ȣ</td>
			<td>02-3775-2266</td>
			<td></td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="32">
			<td height="32" align="center">33</td>
			<td>&nbsp;(��)�ž�����</td>
			<td>�輱��</td>
			<td width="274">��� ��õ�� ���̱� �� 543-1<br>
			  ����з��Ͼ����ǽ��� 204ȣ<br>
			  (Ȩ�÷����������Ա�)</td>
			<td>032-329-8500</td>
			<td>032-328-9958</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">34</td>
			<td>&nbsp;(��)�������Ʈ��ũ</td>
			<td>������</td>
			<td>��õ�� ������ ������    1133-12<br>
		  �Ѻ����� 402</td>
			<td>1544-6638</td>
			<td></td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">35</td>
			<td>&nbsp;(��)���ݰ�������</td>
			<td>�ֿ��</td>
			<td>��õ�� ������ ����4��    240-1<br>
		  ��Ʈ������&nbsp; 207ȣ</td>
			<td>032-815-2119&nbsp;</td>
			<td></td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">36</td>
			<td>&nbsp;(��)���̺����������</td>
			<td>�̿���</td>
			<td>��� ���� �ϻ굿��    �鼮��1324����<br>
		  �¸��Ÿ�� 2�� 1004ȣ</td>
			<td>031-902-2662</td>
			<td>031-902-5432</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
			<tr align="center" height="2">
			<td height="2" colspan="10" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td width="1" rowspan="2" align="center" bgcolor="#CCCCCC"></td>
			<td rowspan="2" align="center">�ؿ�</td>
			<td width="1" height="48" rowspan="2" align="center" bgcolor="#CCCCCC"></td>
			<td align="center">37</td>
			<td>(��)�߾Ӱ�Ӱ���</td>
			<td>���ȣ</td>
			<td>���� �߱� �Ұ����Ե�ȣ��    ����6��<br>
		  (��)�߾Ӱ�Ӱ���</td>
			<td>02-2269-8478</td>
			<td>02-2253-8478</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="24">
			<td height="24" align="center">38</td>
			<td>(��)��ؾ�</td>
			<td>ȣ��ȯ</td>
			<td>���� ���ʱ� ����2��    1338-21<br>
		  �ڸ��ƺ���Ͻ����� 1010</td>
			<td>02-6243-7071</td>
			<td>02-6243-7074</td>
			<td width="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr height="2">
			<td height="2" colspan="10" bgcolor="#CCCCCC"></td>
	</tr>
</table>








				</td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/plz/img_plz03_03.jpg" width="690" height="82" border="0" usemap="#Map"></td>
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
        <%@ include file="../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>





<map name="Map"><area shape="rect" coords="268,17,409,59" href="javascript:goResv();"></map></body>
</html>