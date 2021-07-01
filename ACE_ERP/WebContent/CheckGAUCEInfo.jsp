<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.util.*,java.net.*,java.io.*"%><%
    
    ///// request 정보
    
    String strProtocol = request.getProtocol(); //Protocol
    String strServerName = request.getServerName();  //ServerName
    int nPort = request.getServerPort(); //Port
    String strMethod = request.getMethod(); //Method: Get, Post
    
    String strRemoteAddr = request.getRemoteAddr(); //RemoteAddr
    String strRemoteHost = request.getRemoteHost(); //RemoteHost
    String strRequestURI = request.getRequestURI(); //RequestURI
    
    String strUserAgent = request.getHeader("User-Agent");
    String strAccept = request.getHeader("Accept");
    
    String strContextPath = request.getContextPath();
    String strLocalAddr = request.getLocalAddr();
    String strPathInfo = request.getPathInfo();
    
    //String strRealPath = request.getRealPath("CheckGAUCEInfo.jsp");
    String strRealPath = request.getSession().getServletContext().getRealPath("CheckGAUCEInfo.jsp");
    String strServletPath = request.getServletPath();
    
    StringBuffer strRequestInfo = new StringBuffer(1026);
    String TOKEN = "####";
    String TOKEN2 = "=";
    
    strRequestInfo.append("Protocol="); strRequestInfo.append(strProtocol); strRequestInfo.append(TOKEN);
    strRequestInfo.append("ServerName="); strRequestInfo.append(strServerName); strRequestInfo.append(TOKEN);
    strRequestInfo.append("Port="); strRequestInfo.append(nPort); strRequestInfo.append(TOKEN);
    strRequestInfo.append("Method(GET/POST)="); strRequestInfo.append(strMethod); strRequestInfo.append(TOKEN);
        
    strRequestInfo.append("RemoteAddr="); strRequestInfo.append(strRemoteAddr); strRequestInfo.append(TOKEN);
    strRequestInfo.append("RemoteHost="); strRequestInfo.append(strRemoteHost); strRequestInfo.append(TOKEN);
    strRequestInfo.append("RequestURI="); strRequestInfo.append(strRequestURI); strRequestInfo.append(TOKEN);
    
    strRequestInfo.append("UserAgent="); strRequestInfo.append(strUserAgent); strRequestInfo.append(TOKEN);
    strRequestInfo.append("Accept="); strRequestInfo.append(strAccept); strRequestInfo.append(TOKEN);
    
    strRequestInfo.append("ContextPath="); strRequestInfo.append(strContextPath); strRequestInfo.append(TOKEN);
    strRequestInfo.append("LocalAddr="); strRequestInfo.append(strLocalAddr); strRequestInfo.append(TOKEN);
    strRequestInfo.append("PathInfo="); strRequestInfo.append(strPathInfo); strRequestInfo.append(TOKEN);
    
    strRequestInfo.append("RealPath="); strRequestInfo.append(strRealPath); strRequestInfo.append(TOKEN);
    strRequestInfo.append("ServletPath="); strRequestInfo.append(strServletPath); strRequestInfo.append(TOKEN);
    
    ///// Application 정보
    StringBuffer strAppInfo = new StringBuffer(1026);
    
    String strServerInfo = application.getServerInfo();
    String strMimeType = application.getMimeType("requestExample1.html");
    
    String strHostName = InetAddress.getLocalHost().getHostName();
    
    
    strAppInfo.append("ServerInfo="); strAppInfo.append(strServerInfo); strAppInfo.append(TOKEN); 
    strAppInfo.append("MimeType="); strAppInfo.append(strMimeType); strAppInfo.append(TOKEN); 
    strAppInfo.append("HostName="); strAppInfo.append(strHostName); strAppInfo.append(TOKEN); 
    
    
    
    InetAddress arInetaddress[] = InetAddress.getAllByName(strHostName);
    StringBuffer strInetAddress = new StringBuffer(128);
    for(int i = 0, len = arInetaddress.length; i < len; i++)
    {
        strInetAddress.append(arInetaddress[i].getHostAddress());
        strInetAddress.append("<br>");
    }
    
    strAppInfo.append("arInetaddress="); strAppInfo.append(strInetAddress.toString()); strAppInfo.append(TOKEN); 
    
    ///// System Property
    String strOSName = System.getProperty("os.name");
    String strJavaPath = System.getProperty("sun.boot.library.path");
    String strJavaVersion = System.getProperty("java.vm.version");
    String strJavaRuntimeVersion = System.getProperty("java.runtime.version");
    
    String strGAUCEHome = System.getProperty("GAUCE_HOME");
    String strGAUCEVersion = System.getProperty("GAUCE_VERSION");
    String strGAUCELicenseChecked = System.getProperty("GAUCE_LICENSE_CHECKED");
    
    
    StringBuffer strSystemInfo = new StringBuffer(1026);
    
    strSystemInfo.append("os.name="); strSystemInfo.append(strOSName); strSystemInfo.append(TOKEN); 
    strSystemInfo.append("sun.boot.library.path="); strSystemInfo.append(strJavaPath); strSystemInfo.append(TOKEN); 
    strSystemInfo.append("java.vm.version="); strSystemInfo.append(strJavaVersion); strSystemInfo.append(TOKEN); 
    strSystemInfo.append("java.runtime.version="); strSystemInfo.append(strJavaRuntimeVersion); strSystemInfo.append(TOKEN); 
    
    StringBuffer strGauceInfo = new StringBuffer(1026);
    
    strGauceInfo.append("GAUCE_HOME="); strGauceInfo.append(strGAUCEHome); strGauceInfo.append(TOKEN);    
    strGauceInfo.append("GAUCE_VERSION="); strGauceInfo.append(strGAUCEVersion); strGauceInfo.append(TOKEN); 
    strGauceInfo.append("GAUCE_LICENSE_CHECKED="); strGauceInfo.append(strGAUCELicenseChecked); strGauceInfo.append(TOKEN);     
    
    //Check GAUCE LIB
    File objGauceHome = null;
    
    if (null != strGAUCEHome)
    {
    	objGauceHome = new File(strGAUCEHome);
    }
    else
    {
    	//objGauceHome = new File(request.getRealPath("/WEB-INF"));
    	objGauceHome = new File(request.getSession().getServletContext().getRealPath("/WEB-INF"));
    }
    
    File objLibDir = new File(objGauceHome, "lib");
    File[] arLib = objLibDir.listFiles();
    
    StringBuffer strGauceLib = new StringBuffer(256);
    for (int i = 0, len = arLib.length; i < len; i++)
    {
    	strGauceLib.append(arLib[i].getName());
    	strGauceLib.append("<br>");
    }
    
    strGauceInfo.append("GAUCE_LIB=");
    strGauceInfo.append(strGauceLib.toString());
    
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Print Server Info</title>
<script language="javascript">

/**
* replaceAll 추가
*/
String.prototype.replaceAll = function( searchStr, replaceStr )
{
	var temp = this;
	while( temp.indexOf( searchStr ) != -1 )
	{
		temp = temp.replace( searchStr, replaceStr );
	}
	return temp;
}

/**
* TABLE에 cell append 후에 데이터 추가
*/
function AddValueToTable(objTable, strKey, strValue)
{
	//\ 는 \\로 변환되어야 함 -> Server에서 수행
	if (null == strKey || null == strValue)
	{
		return;
	}
	
	var nMod = objTable.rows.length %2; //MOD로 홀수 짝수 다른 색깔..
	var strOddBackColor = "#ffd9d9";
	var strOddFontColor = "#000000";
	
	var strEvenBackColor = "#f6c0ff";
	var strEvenFontColor = "#000201";
	
	var strBackColor = (1 == nMod)? strOddBackColor : strEvenBackColor;
	var strFontColor = (1 == nMod)? strOddFontColor : strEvenFontColor;
	
	var objRow = objTable.insertRow(objTable.rows.length); //테이블의 제일 마지막에 row 추가.
	var objCellName = objRow.insertCell(); //Cell을 추가, 셀을 2개만 생성하므로 각각 변수를 만든다.
	objCellName.style.backgroundColor = strBackColor;
	objCellName.innerHTML = "<font color=" + strFontColor + ">" +strKey + "</font>";
	
	var objCellValue = objRow.insertCell();
	objCellValue.style.backgroundColor = strBackColor;
	objCellValue.innerHTML = "<font color=" + strFontColor + ">" +strValue + "</font>";
}

function AddDataListToTable(objTable, strData, strToken, strKVToken)
{
	
	var arData = strData.split(strToken);
	
	for (var i = 0, len = arData.length; i < len; i++)
	{
		var arSubInfo = arData[i].split(strKVToken);
		
		if (null == arSubInfo || 2 != arSubInfo.length)
		{
			continue;
		}
		
		var strValue = arSubInfo[1];
		AddValueToTable(objTable, arSubInfo[0], strValue); // add table to key/value
	}
}

function LoadPage()
{

	var strToken = "<%=TOKEN%>";
	var strKVToken = "<%=TOKEN2%>";
	
	var heTblRequest = document.getElementById("tblRequest");
	var strRequestData = "<%=strRequestInfo%>";
	
	//Print Request Header 
	AddDataListToTable(heTblRequest, strRequestData, strToken, strKVToken);
	
	var strAppData = "<%=strAppInfo%>";
	var heTblServInfo = document.getElementById("tblServerInfo");
	//Print AppData
	AddDataListToTable(heTblServInfo, strAppData, strToken, strKVToken);
	
	var strSystemInfo = "<%=strSystemInfo%>";
	var heTblSysInfo = document.getElementById("tblSystemProperty");
	AddDataListToTable(heTblSysInfo, strSystemInfo, strToken, strKVToken);
	
	
	var strGauceInfo = "<%=strGauceInfo%>";
	var heTblGauceInfo = document.getElementById("tblGauceInfo");
	AddDataListToTable(heTblGauceInfo, strGauceInfo, strToken, strKVToken);
	
}
</script>
</head>
<body onload="LoadPage();">

	<label>Check Server Request Info At Loading JSP</label>
	<table id="tblRequest">
	</table>
	<br><br>
	
	<label>Application, ServerInfo</label>
	<table id="tblServerInfo">
	</table>
	<br><br>
	
	<label>System Property</label>
	<table id="tblSystemProperty">
	</table>
	<br><br>
	
	<label>GAUCE Info</label>
	<table id="tblGauceInfo">
	</table>
	<br><br>
</body>
</html>