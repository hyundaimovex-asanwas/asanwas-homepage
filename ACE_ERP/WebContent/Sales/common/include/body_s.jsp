<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	     : ���α׷� ����
 * ���α׷�ID 	 : 
 * J  S  P		 : body_s.jsp ������ ���ۿ�
 * �� �� ��		 : -
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2007-07-24
 * �������		 : ��ü ������ ���� �κ� (����� �޴� ����)
 * [��  ��   ��  ��][������] ����
 * [2007-09-11][�ɵ���] Ÿ��Ʋ �ٿ�  �޴���, ��θ� ��ũ��Ʈ �Ϸ�
 * [2008-01-17][�ɵ���] �ε� ǥ�ÿ� iFrame ����
 *****************************************************************************/
%>
<!--------------------------------- BODY Start ------------------------------->		
<%
	String dirPath = request.getContextPath();
%>
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	onLoad="fnOnLoad();">

	<!--  loading file ���¹� �÷���  -->
	<iframe id="loadingBar" 
			name="loadingBar" 
			style="display:none; position:absolute;left: expression((document.body.clientWidth - 402)/2);top: expression((document.body.clientHeight - 148)/2);z-index:9" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/include/loadingSales.jsp" 
			width="402px" 
			height="148px">
	</iframe>
	
		<table width="1000" height="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="123" valign="top"><!--// ?????-->
				<jsp:include page="/Sales/common/include/left_mn1.jsp" flush="true"/>
				<%//@include file="/Sales/common/include/left_mn1.jsp"%></td>  <!--//�̰� �����ε�-->
				<td valign="top"><!--// ????? --> 
				<jsp:include page="/Sales/common/include/top_mn.jsp" flush="true"/>
				<%//@include file="/Sales/common/include/top_mn.jsp"%></td>
			</tr>
			<tr>
			    <td height="10"></td>
			</tr>    
			
<!-- ������ BODY START --> 			
			<tr>
				<td align="center" valign="top">
					<table width="845" border="0" cellspacing="0" cellpadding="0">
                       <tr> 
                         <td>
                         	<table width="845px">
                         		<tr>
                         			<td>
                         			<jsp:include page="/Sales/common/include/title.jsp" flush="true"/>
                         				<%//@include file="/Sales/common/include/title.jsp"%> 
                         			</td>
                         		</tr>
                         	</table>
                         </td>
                       </tr>
						<tr>
							<td height="10px"></td>
						</tr>
						<tr> 
							<td>