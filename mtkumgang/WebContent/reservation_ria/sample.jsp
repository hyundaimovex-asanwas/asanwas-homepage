<%@ page language="java" contentType="text/html; charset=euc-kr"%><%@ include file="/common/properties.jsp" %><%@ page import="java.util.HashMap" %><%@ page import="java.util.ArrayList" %><%@ page import="com.hmm.asan.www.member.MemberBean" %><%@ page import="com.hmm.asan.common.util.Utility" %><%
String strGallery = new String("");  //xml ������ ���� String
String dong = request.getParameter("dong");
if(dong == null) dong = "";
String type = request.getParameter("type");
if(type == null) type = "";
ArrayList ziplist = null;
String addr = "";
String addrShow = "";
String area = "";
if(dong != null && !dong.equals("")){
	MemberBean bean = new MemberBean();
	bean.ZipSearch(request, response);
	ziplist = (ArrayList) request.getAttribute("list");
}
//�����ڵ�
HashMap areahm = new HashMap();
areahm.put("1","����");
areahm.put("2","�λ�");
areahm.put("3","�뱸");
areahm.put("4","��õ");
areahm.put("5","����");
areahm.put("6","����");
areahm.put("7","���");
areahm.put("8","���");
areahm.put("9","����");
areahm.put("10","���");
areahm.put("11","�泲");
areahm.put("12","����");
areahm.put("13","����");
areahm.put("14","���");
areahm.put("15","�泲");
areahm.put("16","����");

strGallery="<?xml version=\"1.0\" encoding=\"EUC-KR\" standalone=\"no\"?>";
strGallery = strGallery +  "<POSTZIP>";  
  for( int i = 0; i < ziplist.size(); i++) {  //for(1)
  	HashMap hm = (HashMap)ziplist.get(i);
  	addrShow = Utility.ko((String)hm.get("ADDRESS1")).trim()+ " " + Utility.ko((String)hm.get("ADDRESS2")).trim()+ " " + Utility.ko((String)hm.get("ADDRESS3")).trim() + " " + Utility.ko((String)hm.get("POST_BOX")).trim();
  	addr = Utility.ko((String)hm.get("ADDRESS1")).trim()+ " " + Utility.ko((String)hm.get("ADDRESS2")).trim()+ " " + Utility.ko((String)hm.get("ADDRESS3")).trim() + " " + Utility.ko((String)hm.get("POST_BOX")).trim();
  	for( int j = 1; j < areahm.size(); j++) {  //for(2)
  			if(areahm.get(Integer.toString(j)).toString().trim().equals(Utility.ko(hm.get("ADDRESS1").toString()).trim())){
  			area = Integer.toString(j);
  		}
  	}  //for(2)
  
 
    strGallery = strGallery +  "<POSTZIP_LIST>";
    strGallery = strGallery +  "<ZIPCD>"+hm.get("ZIP_CD")+"</ZIPCD>";
    strGallery = strGallery +  "<ADDRESS>"+addrShow+"</ADDRESS>";
    strGallery = strGallery +  "</POSTZIP_LIST>";
 
  
   }  //for(1)
  

strGallery = strGallery +  "</POSTZIP>";
out.println(strGallery); 
%>