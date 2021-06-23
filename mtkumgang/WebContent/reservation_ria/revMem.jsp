
<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.hmm.asan.www.member.LoginBean" %>
<%@ include file="/common/session.jsp" %>

<%
     //아이디, 비밀번호를 Ria 로부터 전달 받는다.
     String id   = new String();
     String pwd = new String();
     String userId   = new String();
     String userPwd = new String();     
     String userYn = new String();
     
     String userTel = new String();
     String userEmail = new String();
     String userName = new String();
     
     String comment = new String();
      
     //현재 인증 되어진 회원인지를 확인 한다.     
     //만일, 인증 되어지지 않은 회원이라면......
           //전달 받은 정보로 회원인증을 거친다.
     //만일, 인증 되어진 회원이라면........
           //Cookie값을 가지고 온다.
           
	//login
	LoginBean lb = new LoginBean();
	int result = lb.Login(request, response);
    
    if(result == 1 ) { // 정상적 회원 인증
      
      userYn = "Y";
      userId = request.getParameter("id");
      userPwd = request.getParameter("pwd");
      userName = session_name;
      userTel = session_tel;
      userEmail = session_email;
            
      comment = "정상적으로 로그인 되었습니다.";
      
    }else if(result == 0) {//ID 없는경우
      userYn = "N";
      userId = "";
      userPwd = "";
      userName = "";
      userTel = "";
      userEmail = "";
            
      comment = "해당 아이디가 존재하지 않습니다.";
      
    }else {//비밀번호가 틀린경우
      userYn = "N";
      userId = "";
      userPwd = "";
      userName = "";
      userTel = "";
      userEmail = "";
      
      comment = "비밀번호를 확인해 주십시요.";
      
    }
    

     // Ria로 값을 전달 한다.
%>
<%
  StringBuffer strAd = new StringBuffer();
%>
<%

strAd.append("&userYn="+userYn+"&userId="+userId+"&userPwd="+userPwd+"&comment="+comment+"&u_name="+userName+"&u_phone="+userTel+"&u_email="+userEmail+"&");
out.println(strAd.toString());

%>
