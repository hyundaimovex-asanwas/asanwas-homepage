<%--
  - �ۼ���: ������
  - �ۼ� ����: 2006.06.01
  - ���� ������ : ������
  - ���� ������ : 2006.06.12
  - ���۱� ǥ��: IMJ Korea
  - ����: ȸ������ �Ϸ�
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="com.hmm.asan.www.member.LoginBean" %>
<%@ include file="/common/header.jsp" %>
<%
	//���� �ܰ迡�� ����� ������(�����Է� ��) ���� ���� step 3.
	String sRefUrl = "";
	if ( request.getHeader("Referer") != null ) sRefUrl = request.getHeader("Referer");
	if ( sRefUrl.indexOf("member_action.jsp") == -1 ) response.sendRedirect("/member/join_agreement.jsp");
	
	String name = request.getParameter("name");
	String id = request.getParameter("id");

	//�α��� �ϱ� ( cookie �ο��Ѵ�.)
	LoginBean lb = new LoginBean();
	int result = lb.Login(request, response);
%>

<body leftmargin="0" topmargin="0" bgcolor="#FCFCF6">

<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
<tr valign="top">
	<td width="206">
		
	</td>
	<td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		<tr valign="top">
			<td bgcolor="#E4E0C2" height="29">

			</td>
		</tr>
		<tr><td height="20"></td></tr>
		<tr valign="top">
			<td>
			

				<table border="0" cellpadding="0" cellspacing="0" width="644">
				<tr>
					<td align="center">

					<!----- CONTENTS START----->
					<!-- �ܰ�-->
					<table border="0" cellpadding="0" cellspacing="0" width="">
					<tr align="center">
						<td width="83"><img src="/img/member/img_step01.gif"></td>
						<td width="72"><img src="/img/member/img_step_arrow.gif"></td>
						<td width="83"><img src="/img/member/img_step02.gif"></td>
						<td width="72"><img src="/img/member/img_step_arrow.gif"></td>
						<td width="83"><img src="/img/member/img_step03.gif"></td>
						<td width="72"><img src="/img/member/img_step_arrow.gif"></td>
						<td width="83"><img src="/img/member/img_step04_on.gif"></td>
					</tr>
					</table>
					<!-- //�ܰ�-->
					<table border="0" cellpadding="0" cellspacing="0" width="644" height="30"><tr><td></td></tr></table>



					<table border="0" cellpadding="0" cellspacing="0" width="624" height="140" background="/img/common/box_624_3_bg.gif">
					<tr>
						<td height="10" valign="top"><img src="/img/common/box_624_3_top.gif"></td>
					</tr>
					<tr>
						<td style="padding-left:30">

						<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td height="30" valign="top"><img src="/img/member/img_join_0401.gif"></td>
						</tr>
		
							<tr>
								<td style="padding-left:10"><b class="red"><%=name%></b> ���� ȸ�������� �������� ���� �帳�ϴ�.<br>
								����ƻ꿡�� �����ϴ� �پ��� ���񽺸� ���� ������ �� �ֽ��ϴ�.<br><br>
								ȸ������ ���̵�� <b class="red"><%=id%></b> �Դϴ�</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="10" valign="bottom"><img src="/img/common/box_624_3_bottom.gif"></td>
					</tr>
					</table>
					<!-- //���-->

					<!-- Button-->
					<table border="0" cellpadding="0" cellspacing="0" width="624"> 
					<tr><td height="15" colspan=3></td></tr>
					<tr>
						<td align="center" width=120><a href="/index.jsp">���ι湮</a></td>
						<td align="center" width=120><a href="/index.jsp">���̹� ����</a></td>
						<td align="center" width=120><a href="/index.jsp">�̿밡�̵�</a></td>
					</tr>
					</table>
					<!-- //Button-->

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

</body>
</html>
