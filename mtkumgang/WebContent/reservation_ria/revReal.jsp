<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="java.net.*"%>
<%
     //����, �ֹι�ȣ1, �ֹι�ȣ 2�� Ria �κ��� ���� �޴´�.
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

    
     //�Ǹ� ���� ������ ������ pass 
     //���� ���� �ʰ� "Y"�� �Ѱ��ش�. 
	 //���ɸ� ����Ѵ�.
	  //����,���   = "1"    (20 ~  )
	  //���   = "2"    (17 ~19)
	  //�ߵ�   = "3"    (14 ~16)
	  //�ʵ�   = "4"    (8  ~13)
	  //�Ƶ�   = "5"    (3  ~7 )
	  //����   = "6"    (0  ~2 )     
/* 1800��� ����ڴ� 9, 0
	1900��� ����ڴ� 1, 2
	2000��� ����ڴ� 3, 4

	�ܱ��ε�Ϲ�ȣ�� �����żҽŰ��ȣ��
	1900��� ����ڴ� 5, 6
	2000��� ����ڴ� 7, 8*/
              
		  realYn = "Y";

		  juminSeven = revJumin2.substring(0,1);	//�ֹι�ȣ ���ڸ��� 1°�ڸ���. 

		  if (  "9".equals(juminSeven) ||  "0".equals(juminSeven)){
			  
			  juminPart = "18"+ revJumin1.substring(0,2);

		  }else if (  "1".equals(juminSeven) ||  "2".equals(juminSeven) ||  "5".equals(juminSeven) ||  "6".equals(juminSeven)){

			  juminPart = "19"+ revJumin1.substring(0,2);

		  }else if (  "3".equals(juminSeven) ||  "4".equals(juminSeven) ||  "7".equals(juminSeven) ||  "8".equals(juminSeven)){
		
			  juminPart = "20"+ revJumin1.substring(0,2);

		  }

		  juminAge = Integer.parseInt(now_year) - Integer.parseInt(juminPart) + 1; 	//���� ����. 2007 - 1975 + 1 = 33
		  
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
	  

// Ria�� ���� ���� �Ѵ�.
StringBuffer strAd = new StringBuffer();

strAd.append("&realKind="+realKind.trim()+"&realYn="+realYn.trim() +"&");
out.println(strAd.toString());
%>