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
	
	xmlData = getURLContents("samp.xml"); // url �� xml�����͸� �ҷ����� ���� ��� 
	
	doc = TotalSearch(xmlData);       // �����͸� ��ȯ 
	
	if(doc != null){
	    Element xmlRoot = doc.getRootElement();
	    List result_doc = xmlRoot.getChildren();
	    Iterator iterator = result_doc.iterator();
	    while(iterator.hasNext()){                            //�ݺ��Ǵ� �κ� ��ŭ while�� �߰� 
	        Element e = (Element) iterator.next();
	        List statis = e.getChildren("ranking");        // �������� ��� 
	        Iterator sli = statis.iterator();
	        while(iterator.hasNext()){                            //ranking �Ʒ� �κп� �׸���̳� �� �ٸ� ���� ������ ������ while���߰�
	            Element sle = (Element) sli.next();
	            String att = sle.getChild("att").getText();            //ranking �ڽĿ� �ش� , �ϳ��� ��� 
	            String att = sle.getAttributeValue("fluctuations");    //ranking�� �ٸ� ������� ����� ���
	        }
	
	    }
	}


	//2. xml ��ȯ �κ�
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



 
