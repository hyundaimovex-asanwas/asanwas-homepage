<%--
  - �ۼ���: ������
  - �ۼ� ����: 2006.06.01
  - ���� ������ : ������
  - ���� ������ : 2006.06.05
  - ���۱� ǥ��: IMJ Korea
  - ����: ID /��й�ȣ ã�� ��� page 
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>
<%
	String cmd = request.getParameter("cmd");
	String result = request.getParameter("result");
	if ( result == null || result.trim().equals("") ) result ="0";	
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String sRePage = "";

	if ( result.equals("0") && ( cmd.equals("IS") || cmd.equals("PS") ) )
	{
		// return page url
		if ( cmd.equals("IS") ) 
			sRePage = "/member/id_search.jsp";
		else
			sRePage = "/member/pwd_search.jsp";

		//error show
		cmd = "SE";
	}

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
			

				<table border="0" cellpadding="0" cellspacing="0" width="644" id="tarea">
				<tr>
					<td align="center">

					<!----- CONTENTS START----->
					<!-- ���̵� ã��-->
					<%if (cmd.equals("IS")){%>
						<table border="0" cellpadding="0" cellspacing="0" width="510">
						<tr>
							<td style="padding-left:10"><img src="/img/member/img_search_0103.gif"></td>
						</tr>
						<tr><td height="5"></td></tr>
						</table>

						<table border="0" cellpadding="0" cellspacing="0" width="510" height="130" background="/img/common/box_510_bg.gif">
						<tr>
							<td height="10" valign="top"><img src="/img/common/box_510_top.gif"></td>
						</tr>
						<tr>
							<td align="center">

							<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td style="padding-left:10"><b class="red"><%=name%></b> ���� ���̵�� <b class="red"><%=id%></b> �Դϴ�.</td>
							</tr>
							</table>

							</td>
						</tr>
						<tr>
							<td height="10" valign="bottom"><img src="/img/common/box_510_bottom.gif"></td>
						</tr>
						</table>
						<!-- //���̵� ã��-->
						<!-- Button-->
						<table border="0" cellpadding="0" cellspacing="0" width="510">
						<tr><td height="15"></td></tr>
						<tr>
							<td align="center"><a href="/member/login.jsp"><img src="/img/common/btn_submit.gif"></a>&nbsp;
							<!--<a href="#"><img src="/img/common/btn_rewrite.gif"></a></td>-->
						</tr>
						</table>
						<!-- //Button-->

					<%}else if(cmd.equals("PS")){%>
						<table border="0" cellpadding="0" cellspacing="0" width="644" height="50"><tr><td></td></tr></table>

						<!-- ��й�ȣ ã��-->
						<table border="0" cellpadding="0" cellspacing="0" width="510">
						<tr>
							<td style="padding-left:10"><img src="/img/member/img_search_0104.gif"></td>
						</tr>
						<tr><td height="5"></td></tr>
						</table>

						<table border="0" cellpadding="0" cellspacing="0" width="510" height="130" background="/img/common/box_510_bg.gif">
						<tr>
							<td height="10" valign="top"><img src="/img/common/box_510_top.gif"></td>
						</tr>
						<tr>
							<td align="center">

							<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td style="padding-left:10">ȸ������ ��й�ȣ�� ȸ�����Խ� �Է��Ͻ� �̸��� �ּҷ� �߼��߽��ϴ�. </td>
							</tr>
							</table>

							</td>
						</tr>
						<tr>
							<td height="10" valign="bottom"><img src="/img/common/box_510_bottom.gif"></td>
						</tr>
						</table>
						<!-- //��й�ȣ ã��-->

						<!-- Button-->
						<table border="0" cellpadding="0" cellspacing="0" width="510">
						<tr><td height="15"></td></tr>
						<tr>
							<td align="center"><a href="/member/login.jsp"><img src="/img/common/btn_submit.gif"></a>&nbsp;
							<!--<a href="#"><img src="/img/common/btn_rewrite.gif"></a></td>-->
						</tr>
						</table>
						<!-- //Button-->
					<%}else if(cmd.equals("SE")){%>
					<table border="0" cellpadding="0" cellspacing="0" width="644" height="50"><tr><td></td></tr></table>

						<!-- ������� -->
						<table border="0" cellpadding="0" cellspacing="0" width="510">
						<tr>
							<td style="padding-left:10"></td>
						</tr>
						<tr><td height="5"></td></tr>
						</table>

						<table border="0" cellpadding="0" cellspacing="0" width="510" height="130" background="/img/common/box_510_bg.gif">
						<tr>
							<td height="10" valign="top"><img src="/img/common/box_510_top.gif"></td>
						</tr>
						<tr>
							<td align="center">

							<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td style="padding-left:10">
										<b>"�Է��Ͻ� ������ ��ġ�ϴ� ȸ�������� �����ϴ�"</b>
										<br><br>����/Ż�� ���θ� �ٽ� �ѹ� Ȯ���Ͽ� �ֽñ� �ٶ��ϴ�.
										<br>�α��ΰ� �����Ͽ� ��� ������ �߻��ϴ� ��� Ȩ������ �����ڿ��� �����Ͽ� �ֽʽÿ�.
										<br>webamster@hdasan.com
										<br>���� �ݰ������ Ȩ�������� ȸ���� �ƴϽö�� ���� ȸ�������� �ϼż� ���� ���񸣸� ������������.
										<br>
								</td>
							</tr>
							</table>

							</td>
						</tr>
						<tr>
							<td height="10" valign="bottom"><img src="/img/common/box_510_bottom.gif"></td>
						</tr>
						</table>
						<!-- //������� -->

						<!-- Button-->
						<table border="0" cellpadding="0" cellspacing="0" width="510">
						<tr><td height="15"></td></tr>
						<tr>
							<td align="center"><a href="/member/join_name.jsp">ȸ�������ϱ�</a>&nbsp;
							<a href="<%=sRePage%>"> �ٽ��Է��ϱ� </a></td>
						</tr>
						</table>
						<!-- //Button-->
					<%}%>
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
