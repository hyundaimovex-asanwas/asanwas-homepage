
<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.hmm.asan.www.member.LoginBean" %>
<%@ include file="/common/session.jsp" %>

<%
     //���̵�, ��й�ȣ�� Ria �κ��� ���� �޴´�.
     String id   = new String();
     String pwd = new String();
     String userId   = new String();
     String userPwd = new String();     
     String userYn = new String();
     
     String userTel = new String();
     String userEmail = new String();
     String userName = new String();
     
     String comment = new String();
      
     //���� ���� �Ǿ��� ȸ�������� Ȯ�� �Ѵ�.     
     //����, ���� �Ǿ����� ���� ȸ���̶��......
           //���� ���� ������ ȸ�������� ��ģ��.
     //����, ���� �Ǿ��� ȸ���̶��........
           //Cookie���� ������ �´�.
           
	//login
	LoginBean lb = new LoginBean();
	int result = lb.Login(request, response);
    
    if(result == 1 ) { // ������ ȸ�� ����
      
      userYn = "Y";
      userId = request.getParameter("id");
      userPwd = request.getParameter("pwd");
      userName = session_name;
      userTel = session_tel;
      userEmail = session_email;
            
      comment = "���������� �α��� �Ǿ����ϴ�.";
      
    }else if(result == 0) {//ID ���°��
      userYn = "N";
      userId = "";
      userPwd = "";
      userName = "";
      userTel = "";
      userEmail = "";
            
      comment = "�ش� ���̵� �������� �ʽ��ϴ�.";
      
    }else {//��й�ȣ�� Ʋ�����
      userYn = "N";
      userId = "";
      userPwd = "";
      userName = "";
      userTel = "";
      userEmail = "";
      
      comment = "��й�ȣ�� Ȯ���� �ֽʽÿ�.";
      
    }
    

     // Ria�� ���� ���� �Ѵ�.
%>
<%
  StringBuffer strAd = new StringBuffer();
%>
<%

strAd.append("&userYn="+userYn+"&userId="+userId+"&userPwd="+userPwd+"&comment="+comment+"&u_name="+userName+"&u_phone="+userTel+"&u_email="+userEmail+"&");
out.println(strAd.toString());

%>
