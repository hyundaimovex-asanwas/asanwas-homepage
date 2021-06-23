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
     
     String juminSeven = new String();
     
     String realYn = new String();
     String juminPart = new String();
     int juminAge = 0;
     java.util.Calendar c = java.util.Calendar.getInstance();
     String now_year  = String.valueOf(c.get(java.util.Calendar.YEAR));
     
     revName   = ParamUtil.getReqParameter(request.getParameter("revName"),"");
     revJumin1 = ParamUtil.getReqParameter(request.getParameter("revJumin1"),"");
     revJumin2 = ParamUtil.getReqParameter(request.getParameter("revJumin2"),"");
     returnUrl = "www.mtkumgang.com/reservation_ria/revReal.jsp";   

    
     //실명 인증 서버로 연결은 pass 
     //인증 받지 않고 "Y"를 넘겨준다. 
	 //연령만 계산한다.
	  //성인,대딩   = "1"    (20 ~  )
	  //고등   = "2"    (17 ~19)
	  //중등   = "3"    (14 ~16)
	  //초등   = "4"    (8  ~13)
	  //아동   = "5"    (3  ~7 )
	  //유아   = "6"    (0  ~2 )     
/* 1800년대 출생자는 9, 0
	1900년대 출생자는 1, 2
	2000년대 출생자는 3, 4

	외국인등록번호와 국내거소신고번호는
	1900년대 출생자는 5, 6
	2000년대 출생자는 7, 8*/
              
		  realYn = "Y";

		  juminSeven = revJumin2.substring(0,1);	//주민번호 뒷자리중 1째자리수. 

		  if (  "9".equals(juminSeven) ||  "0".equals(juminSeven)){
			  
			  juminPart = "18"+ revJumin1.substring(0,2);

		  }else if (  "1".equals(juminSeven) ||  "2".equals(juminSeven) ||  "5".equals(juminSeven) ||  "6".equals(juminSeven)){

			  juminPart = "19"+ revJumin1.substring(0,2);

		  }else if (  "3".equals(juminSeven) ||  "4".equals(juminSeven) ||  "7".equals(juminSeven) ||  "8".equals(juminSeven)){
		
			  juminPart = "20"+ revJumin1.substring(0,2);

		  }

		  juminAge = Integer.parseInt(now_year) - Integer.parseInt(juminPart) + 1; 	//나이 구함. 2007 - 1975 + 1 = 33
		  
		  if ( juminAge >= 20){
			  realKind = "1";
		  }else if( juminAge >= 17 && juminAge <= 19) {
			  realKind = "2";
		  }else if( juminAge >= 14 && juminAge <= 16) {
			  realKind = "3";
		  }else if( juminAge >= 8 && juminAge <= 13) {
			  realKind = "4";
		  }else if( juminAge >= 3 && juminAge <= 7) {
			  realKind = "5";
		  }else if( juminAge <= 2) {
			  realKind = "6";
		  }
	  

// Ria로 값을 전달 한다.
StringBuffer strAd = new StringBuffer();

strAd.append("&realKind="+realKind.trim()+"&realYn="+realYn.trim() +"&");
out.println(strAd.toString());
%>