<html>
<head>
<title>Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"> 
</head>
<body leftmargin=0 topmargin=0 marginheight=0 marginwidth=0 style="font-family:돋움;font-size:9pt" >
<script>
    function send()
    {
        document.frm.action="result.jsp";
        document.frm.target="result";
        document.frm.submit();
    }
</script>
<form name="frm" method="post">
<table width="100%" Height="100%">
  <tr>
    <td>
     <textarea name="qry" cols="" rows="" style="width:1280px;height:300px"></textarea>
    </td>
  </tr>
  <tr>
    <td>
     <a href="javascript:send()">보내기</a>
    </td>
  </tr>
  <tr>
    <td width="100%" height="100%">
    <iframe name="result" src="about:blank"width=100% height="100%"></iframe>
    </td>
  </tr>
</table>
</form>
</body>
</html>