<%@ page language="java" contentType="text/html; charset=euc-kr"%><%@ include file="/common/properties.jsp" %><%@ page import="java.util.HashMap" %><%@ page import="java.util.ArrayList" %><%@ page import="com.hmm.asan.www.member.MemberBean" %><%@ page import="com.hmm.asan.common.util.Utility" %><%
String strGallery = new String("");  //xml 만들기기 위한 String
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
//지역코드
HashMap areahm = new HashMap();
areahm.put("1","서울");
areahm.put("2","부산");
areahm.put("3","대구");
areahm.put("4","인천");
areahm.put("5","광주");
areahm.put("6","대전");
areahm.put("7","울산");
areahm.put("8","경기");
areahm.put("9","강원");
areahm.put("10","충북");
areahm.put("11","충남");
areahm.put("12","전북");
areahm.put("13","전남");
areahm.put("14","경북");
areahm.put("15","경남");
areahm.put("16","제주");

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