<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<html>
<head>
	<title>SHA256 �׽�Ʈ</title>
	<meta http-equiv="content-type" content="text/html; charset=euc-kr" />
	<link rel="stylesheet" href="style.css" type="text/css">
	<script src="ajax.js" language="JavaScript"></script>
	<script language="JavaScript">
		function sha256( URL )
		{
			var form = document.getElementById( "sha256_form" );
			form.oCipherText.value = (GetHttpRequest( URL, "iPlainText=" + encodeURIComponent(form.iPlainText.value))).trim();
		}
	</script>
</head>
<body>
<form name="sha256_form">
	<table border="0" width="500" celpadding="5">
		<tr>
			<td width="100">�ؽ� �� �޽���</td>
			<td width="*"><input type="text" name="iPlainText" style="width:100%;" /></td>
		</tr>
		<tr>
			<td>�ؽ� �� �޽���</td>
			<td><input type="text" name="oCipherText" style="width:100%;" readonly="readonly" /></td>
		</tr>
		<tr>
			<td colspan="2"><input type="button" value="�ؽ�" name="enc" onclick="JavaScript:sha256('sha256hash.jsp');" /></td>
		</tr>
	</table>
</form>
</body>
</html>
