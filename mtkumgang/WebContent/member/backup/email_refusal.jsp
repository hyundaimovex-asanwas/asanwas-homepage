<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>

<body leftmargin="0" topmargin="0" bgcolor="#FCFCF6">
<!---------- GNB AREA---------->
<%@ include file="/common/gnb.jsp" %>
<!---------- //GNB AREA---------->


<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
<tr valign="top">
	<td width="206">
		<!----- LEFT MENU----->
		<table border="0" cellpadding="0" cellspacing="0" height="100%" background="/img/common/menu_bg.gif">
		<tr>
			<td valign="top">
				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" 	codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0" 	width="206" height="522">
				<param name="movie" value="/swf/HA_subnavi_8.swf">
				<param name="quality" value="high">
				<param name="wmode" value="opaque">
				<embed src="/swf/HA_subnavi_8.swf" quality="high" 
				pluginspage="http://www.macromedia.com/go/getflashplayer" 
				type="application/x-shockwave-flash" 
				wmode="opaque"
				width="206" height="522"></embed>
				</object></td>
		</tr>
		<tr>
			<td valign="bottom"><%@ include file="/member/menu_member.jsp" %></td>
		</tr>
		</table>
		<!----- //LEFT MENU----->
	</td>
	<td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		<tr valign="top">
			<td bgcolor="#E4E0C2" height="29">
				
				<!----- Navigrtion----->
				<table border="0" cellpadding="0" cellspacing="0" width="644" height="29" background="/img/common/navi_bg.gif">
				<tr>
					<td align="right" class="navi"><a href="#">Home</a> / <font color="#4E4700">�̸����ּ� ���ܼ��� �ź�</span></td>
				</tr>
				</table>
				<!----- //Navigrtion----->

			</td>
		</tr>
		<tr><td height="20"></td></tr>
		<tr valign="top">
			<td>
				<!----- Title----->
				<table border="0" cellpadding="0" cellspacing="0" width="644" background="/img/common/tit_bg.gif">
				<tr>
					<td width="10"><img src="/img/common/tit_left.gif"></td>
					<td><img src="/img/member/tit_03.gif"></td>
					<td align="right"><img src="/img/member/tit_img_01.gif"></td>
				</tr>
				</table>
				<!----- //Title----->

				<!----- ����ũ������-->
				<%@ include file="/common/textsize.jsp" %>
				<!----- //����ũ������-->
				<table border="0" cellpadding="0" cellspacing="0" width="644" height="30"><tr><td></td></tr></table>
				
				<table border="0" cellpadding="0" cellspacing="0" width="644">
				<tr>
					<td align="center">
					
					<!----- CONTENTS START----->	
					<table border="0" cellpadding="0" cellspacing="0" width="624" background="/img/common/box_624_1_bg.gif">
					<tr><td><img src="/img/common/box_624_1_top.gif"></td></tr>
					<tr>
						<td style="padding:10 15 8 15 ; text-align:justify">�츮 ����ƻ�(��)�� �����ϴ� ������(www.hdasan.com/ www.mtKumgang.com) ȸ������ ������������ �������� Ÿ���� ������ �����ϱ� ����, �� ������Ʈ�� �Խõ� �̸��� �ּҰ� ���ڿ��� ���� ���α׷��̳� �� ���� ����� ��ġ�� �̿��Ͽ� �������� �����Ǵ� ���� �ź��ϸ�, �̸� ���ݽ� ������Ÿ������� ����ó������ �����Ͻñ� �ٶ��ϴ�. </b></td>
					</tr>
					<tr><td><img src="/img/common/box_624_1_bottom.gif"></td></tr>
					</table>

					<!----- //CONTENTS END----->
					
					</td>
				</tr>
				</table>

			</td>
		</tr>
		<tr><td height="50"></td></tr>
		<tr><td height="10" bgcolor="#F1F1DB"></td></tr> <!--//�ϴ� 10�ȼ�����//-->
		</table>
	</td>
</tr>
</table>

<!---------- FOOTER AREA---------->
<%@ include file="/common/footer.jsp" %>
<!---------- //FOOTER AREA---------->

<!----- Mt.Kumgang----->
<%@ include file="/common/mt_gumgang.jsp" %>
<!----- //Mt.Kumgang----->

<!----- Top----->
<%@ include file="/common/top.jsp" %>
<!----- //Top----->

</body>
</html>
