<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="net.sourceforge.barbecue.*" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.File" %>
<%@ page import="java.awt.Font" %>

<%
	String param = request.getParameter("barData");
%>
<html>
	<head>
		<title>Barcode</title>
	</head> 
	<%
		net.sourceforge.barbecue.Barcode barcode = null;
//		String reqData = "testbarcode";
		String reqData = param;
		reqData = reqData.toUpperCase();
		
		try {
			barcode = BarcodeFactory.create3of9(reqData,false); // ÈÄº¸ 
		} catch (BarcodeException e) {
		}
		
		try {
			String dirPath = "D:/temp/";
			String filePath = dirPath + reqData+".jpg";
			File cImg = new File(filePath);
			
			java.io.FileOutputStream fos = new java.io.FileOutputStream(cImg);
			
			barcode.setBarHeight(40);
			barcode.setBarWidth(1);
			net.sourceforge.barbecue.BarcodeImageHandler.outputBarcodeAsJPEGImage(barcode, fos);
				
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	%>
	<img src='D:/temp/<%=reqData%>.jpg'>
	<body>
	</body>
</html>