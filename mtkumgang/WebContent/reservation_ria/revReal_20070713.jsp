<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="java.net.*"%>
<%
     //성명, 주민번호1, 주민번호 2를 Ria 로부터 전달 받는다.
     String revName   = new String();
     String revJumin1 = new String();
     String revJumin2 = new String();
     String realKind = new String();
     String returnUrl = new String();
     
     String resultName = new String();
     String resultJumin = new String();
     String resultCode = null;
     
     String realYn = new String();
     String juminPart = new String();
     int juminAge = 0;
     java.util.Calendar c = java.util.Calendar.getInstance();
     String now_year  = String.valueOf(c.get(java.util.Calendar.YEAR));
     
     revName   = ParamUtil.getReqParameter(request.getParameter("revName"),"");
     revJumin1 = ParamUtil.getReqParameter(request.getParameter("revJumin1"),"");
     revJumin2 = ParamUtil.getReqParameter(request.getParameter("revJumin2"),"");
     returnUrl = "test1.hdasan.com/reservation_ria/revReal.jsp";   
    
     
     //실명 인증 서버로 연결 한다.
     //실명 인증 서버로 부터 return 을 받는다.
     resultName   = ParamUtil.getReqParameter(request.getParameter("resultName"),"");
     resultJumin  = ParamUtil.getReqParameter(request.getParameter("resultJumin"),"");
     resultCode   = ParamUtil.getReqParameter(request.getParameter("resultCode"),"");
     
     if (resultCode.equals("")){
          response.sendRedirect ("http://com.hdasan.com/cNameCheckWEBt.asp?revJumin1="+revJumin1+"&revJumin2="+revJumin2+"&revName=" + URLEncoder.encode(revName.trim())+"&returnUrl="+returnUrl.trim());
          return;
     }     
     
     if (!resultCode.equals("")){
     
              //전달 받은 값으로부터 연령대를 구분한다.
              //성인   = "1"    (20 ~  )
              //대학생 = "2"    (20 ~  )
              //고등   = "3"    (17 ~19)
              //중등   = "4"    (14 ~16)
              //초등   = "5"    (8  ~13)
              //아동   = "6"    (4  ~7 )
              //유아   = "7"    (1  ~3 )     
              if (resultCode !="1" && !resultCode.equals("1")){
                 
                  realYn = "N";
              
              }else{
              
                  realYn = "Y";
                  juminPart = "19"+resultJumin.substring(0,2);
                  juminAge = Integer.parseInt(now_year) - Integer.parseInt(juminPart);
                  
                  if ( juminAge >= 20){
                      realKind = "1";
                  }else if( juminAge <= 17 && juminAge >= 19) {
                      realKind = "2";
                  }else if( juminAge <= 14 && juminAge >= 16) {
                      realKind = "3";
                  }else if( juminAge <= 8 && juminAge >= 13) {
                      realKind = "4";
                  }else if( juminAge <= 4 && juminAge >= 7) {
                      realKind = "5";
                  }else if( juminAge <= 1 && juminAge >= 3) {
                     realKind = "6";
                  }
              
              }
              
    }        
              // Ria로 값을 전달 한다.
%>
<%
  StringBuffer strAd = new StringBuffer();
%>
<%
//strAd.append("<?xml version=\"1.0\" encoding=\"EUC-KR\" standalone=\"no\"?>");
//strAd.append("<REAL>");
//strAd.append("<REAL_LIST>");
//strAd.append("<REAL_YN>"+realYn+"</REAL_YN>");
//strAd.append("<REAL_KIND>"+realKind+"</REAL_KIND>");
//strAd.append("</REAL_LIST>");
//strAd.append("</REAL>");
//
//out.println(strAd.toString());


strAd.append("&realKind="+realKind.trim()+"&realYn="+realYn.trim() +"&");

out.println(strAd.toString());

%>
