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
	String strXML = new String();	//xml ������ �����ϱ� ���� ����
 
	try{
	  url = new URL(server);	//URL����
	  connection = url.openConnection();	//����
	  is = connection.getInputStream();		//inputStream �̿�
	  isr = new InputStreamReader(is);
	  br = new BufferedReader(isr);
	  String buf = null;
	  
	  while(true){	//���ѹݺ�
	   buf = br.readLine();	// ȭ�鿡 �ִ� ������ \n������ �о�´�.
	   if(buf ==null){	//null�� ��� ȭ���� ���� ����̹Ƿ�
		    break;	//�ݺ��� ��
	   }else{
		    strXML += buf+" \n";	//strXML�� ��µ� ������ ����Ų��.
	   }
	  }
	}catch(Exception e){
	  e.printStackTrace();
	}
	
	 DocumentBuilder _docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
	 Document document   = _docBuilder.parse(new InputSource(new java.io.StringReader(strXML))); 
	 	 //strXML�� StringReader�� ��� InputSource Ŭ������ �̿� DocumentBuilder.parse �޼ҵ带 �̿��Ͽ� 
	 	 //document ������ �����.
	 document.setDocumentURI(server);
	  
	 NodeList noneList = document.getDocumentElement().getChildNodes();	//XML��带 �����´�
	 List list = new ArrayList();//����� ���� �迭 list����

	 for(int i =0; i<noneList.getLength();i++){ //��� ���̸�ŭ
	  Node row = noneList.item(i);	// node row�� item���� �����´�.
	  NodeList child = row.getChildNodes(); //row�� childNode�� Nodelist�� ���
	  
	  HashMap map = new HashMap(); //����� ���� �����Ƿ� hashmap�̿� Ű���� �̸��� ����ų �� �����Ƿ� ����. ��õ
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



 
