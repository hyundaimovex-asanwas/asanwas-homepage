<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.StringUtil" %>
<%@ page import="sales.common.HDUtil" %>

<%
	String jumin = request.getParameter("ju");
	String name = request.getParameter("nm");
	
	StringUtil.printMsg("�ֹι�ȣ" , jumin, this);
	StringUtil.printMsg("����" , name, this);
	StringUtil.printMsg("������" , request.getServerName(), this);
	
	String path = request.getContextPath();
	String basePath =  request.getServerName();



	String resultCode = HDUtil.nullCheckStr(request.getParameter("resultCode"));
	String no = request.getParameter("no");
	StringUtil.printMsg("����ڵ�" , jumin, this);
	
	StringUtil.printMsg("URL", "http://com.hdasan.com/cNameCheckSYS.asp?Jumin="+jumin+"&Name="+name+"&returnURL="+basePath+path+"/Sales/common/include/confirm.jsp", this);
	
	String codeMsg = "";
	
 if (!resultCode.equals("")) {
		if (resultCode.equals("1")) {
			codeMsg = "���θ���";
		} else if (resultCode.equals("2")) {
			codeMsg = "���ξƴ� (���� ����ġ)";
		} else if (resultCode.equals("3")) {
			codeMsg = "�ڷ����";
		} else if (resultCode.equals("4")) {
			codeMsg = "�ý��� ���";
		} else if (resultCode.equals("5")) {
			codeMsg = "�ֹι�ȣ ����";
		} else if (resultCode.equals("6")) {
			codeMsg = "���������� �� 19�� ������ ��� �Ǹ����� ��ġ�� �ʰ� �ٷ� ���� �ڵ� ��µ˴ϴ�";
		} else if (resultCode.equals("9")) {
			codeMsg = "SEND �� ����Ÿ�� �̻��� ��� ";
		} else if (resultCode.equals("10")) {
			codeMsg = "����Ʈ �ڵ� ����";
		} else if (resultCode.equals("11")) {
			codeMsg = "������ ����Ʈ";
		} else if (resultCode.equals("12")) {
			codeMsg = "�ش����Ʈ ��й�ȣ ����";
		} else if (resultCode.equals("13")) {
			codeMsg = "����Ʈ ���� �ý��� ���(�����ڿ��� �����ּ���!)";
		} else if (resultCode.equals("15")) {
			codeMsg = "Decoding����";
		} else if (resultCode.equals("16")) {
			codeMsg = "Decoding ������� ";
		} else if (resultCode.equals("21")) {
			codeMsg = "��ȣȭ ����Ÿ �̻�";
		} else if (resultCode.equals("24")) {
			codeMsg = "��ȣȭ ������ ����";
		} else if (resultCode.equals("31")) {
			codeMsg = "�������";
		} else if (resultCode.equals("32") || resultCode.equals("34") || resultCode.equals("35")) {
			codeMsg = "��õ� ��Ź�帲";
		} else if (resultCode.equals("50")) {
			codeMsg = "�������� ���� ��û �ֹι�ȣ";
		}
	}
%>
<html>
	<head >
		<title>�Ǹ�����</title>
		
		<script language="javaScript">
			function fnConfirm() {
    			var url = "http://com.hdasan.com/cNameCheckSYS2.asp?Jumin=<%=jumin%>&Name=<%=name%>&returnURL=<%=basePath%><%=path%>/Sales/common/include/confirm2.jsp?no=<%=no%>";
    			location.href=url;
    	 	}
    	 	
    	 	function fnClose() {
    	 	
//    	 		opener.lc_regi_yn.Text = "Y";
//    	 		window.opener.lc_regi_yn.Index = 2;
    	 		
    	 		window.opener.fnTest('<%=no%>',"Y");
//    	 		window.opener.excelDs.namevalue(1.rowposition, "COL04") = "Y";
//    	 		opener.lc_regi_yn.ValueOfIndex("detail", lc_regi_yn.Index) = "Y";

				
    	 		window.close();
    	 	}
		</script>
	</head>
<%
	if (resultCode.equals("")) {
%>	
	<body onLoad="javascript:fnConfirm();" >
<%	
	} else if (resultCode.equals("1")) {
%>
	
	<body onLoad="javascript:fnClose();">
<%
	} else {
%>
	<table>
				<tr>
					<td>����ڵ� : <%=resultCode%> : <%=codeMsg%></td>
				</tr>
		</table>
<%
	}
%>
		
	</body>
</html>
 