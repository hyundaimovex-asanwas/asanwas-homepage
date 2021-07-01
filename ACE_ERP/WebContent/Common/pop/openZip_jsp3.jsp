<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
<%@ page 
language="java"
contentType="text/html; charset=EUC-KR"
pageEncoding="EUC-KR"
%>

<%@page import="java.net.URL"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="java.io.StringReader"%>
<%@page import="org.xml.sax.InputSource"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.w3c.dom.Node"%>


<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%//blog.naver.com/matrix1597?Redirect=Log&logNo=70084687187
	String server = "samp.xml";
	URL url;
	URLConnection connection;
	InputStream is;
	InputStreamReader isr;
	BufferedReader br;
	String strXML = new String();	//xml 내용을 저장하기 위한 변수
 
	try{
	  url = new URL(server);	//URL세팅
	  connection = url.openConnection();	//접속
	  is = connection.getInputStream();		//inputStream 이용
	  isr = new InputStreamReader(is);
	  br = new BufferedReader(isr);
	  String buf = null;
	  
	  while(true){	//무한반복
	   buf = br.readLine();	// 화면에 있는 내용을 \n단위로 읽어온다.
	   if(buf ==null){	//null일 경우 화면이 끝난 경우이므로
		    break;	//반복문 끝
	   }else{
		    strXML += buf+" \n";	//strXML에 출력된 내용을 기억시킨다.
	   }
	  }
	}catch(Exception e){
	  e.printStackTrace();
	}
	
	 DocumentBuilder _docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
	 Document document   = _docBuilder.parse(new InputSource(new java.io.StringReader(strXML))); 
	 	 //strXML을 StringReader에 담고 InputSource 클래스를 이용 DocumentBuilder.parse 메소드를 이용하여 
	 	 //document 문서로 만든다.
	 document.setDocumentURI(server);
	  
	 NodeList noneList = document.getDocumentElement().getChildNodes();	//XML노드를 가져온다
	 List list = new ArrayList();//결과를 담을 배열 list생성

	 for(int i =0; i<noneList.getLength();i++){ //노드 길이만큼
	  Node row = noneList.item(i);	// node row에 item들을 가져온다.
	  NodeList child = row.getChildNodes(); //row에 childNode를 Nodelist에 담고
	  
	  HashMap map = new HashMap(); //결과의 행이 많으므로 hashmap이용 키값과 이름을 기억시킬 수 있으므로 좋다. 추천
	  for(int a = 0; a<child.getLength();a++){
		Node nodeList = child.item(a);
	   	out.println(a + " : "+nodeList.getTextContent());
		map.put(nodeList.getNodeName() , nodeList.getTextContent());
	  }
	  list.add(map);
	 } 
%>
<META http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<META name="GENERATOR" content="IBM WebSphere Studio">
<META http-equiv="Content-Style-Type" content="text/css">
<LINK href="../../theme/Master.css" rel="stylesheet" type="text/css">
<TITLE>openZip.jsp</TITLE>
</HEAD>
<script language="javascript">
	<!--

	-->
</script>
<BODY>

<%//=list %>


</BODY>
</HTML>



 
