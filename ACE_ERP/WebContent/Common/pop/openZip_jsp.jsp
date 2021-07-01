<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
<%@ page 
language="java"
contentType="text/html; charset=EUC-KR"
pageEncoding="EUC-KR"
%>

<%
	String xmlData = "" ;
	Document doc = null ;
	
	xmlData = getURLContents("samp.xml"); // url 은 xml데이터를 불러오는 실제 경로 
	
	doc = TotalSearch(xmlData);       // 데이터를 변환 
	
	if(doc != null){
	    Element xmlRoot = doc.getRootElement();
	    List result_doc = xmlRoot.getChildren();
	    Iterator iterator = result_doc.iterator();
	    while(iterator.hasNext()){                            //반복되는 부분 만큼 while문 추가 
	        Element e = (Element) iterator.next();
	        List statis = e.getChildren("ranking");        // 여려개일 경우 
	        Iterator sli = statis.iterator();
	        while(iterator.hasNext()){                            //ranking 아랫 부분에 항목들이나 또 다른 세부 내용이 있으면 while문추가
	            Element sle = (Element) sli.next();
	            String att = sle.getChild("att").getText();            //ranking 자식에 해당 , 하나일 경우 
	            String att = sle.getAttributeValue("fluctuations");    //ranking의 다른 내용들을 출력할 경우
	        }
	
	    }
	}


	//2. xml 변환 부분
	public Document TotalSearch(String xmlData){
	    SAXBuilder builder = null ;    
	    Document doc = null ;
	    Element root = null ;
	    try{
	        builder = new SAXBuilder();
	        doc = builder.build(new ByteArraInputStream(xmlData.getBytes()));
	        return doc ;
	    }catch(){
	    
	    }
	    return doc;
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

hummmmmmmmm

</BODY>
</HTML>



 
