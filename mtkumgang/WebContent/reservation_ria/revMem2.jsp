
<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.hmm.asan.www.member.LoginBean" %>
<%@ page import="java.util.*"%>
<%@ include file="/common/session.jsp" %>
<%
    //out.println(session_id+"<br>");
    //out.println(session_name+"<br>");
    //out.println(session_tel+"<br>");
    //out.println(session_email+"<br>");

    String id    = session_id;
    String name  = session_name;
    String tel   = session_tel;
    String email = session_email;
    
    String tel1 = new String();
    String tel2 = new String();
    String tel3 = new String();
    
    String Memtype = new String();
    
    if (id !=""){
       Memtype="Y";
    }else{
       Memtype="N";
    }
    
    
    //tel = "011-245-245";
    StringTokenizer tokenizer = new StringTokenizer(tel, "-");  
    int numTokens = tokenizer.countTokens();  
    String[] telExt = new String [numTokens];  
         
    int i = 0;
    for (i=0; i < numTokens; i++)  {  
      String word = tokenizer.nextToken();  
      telExt[i] = word;
    } 
    

    tel1 = telExt[0];
    tel2 = telExt[1];
    tel3 = telExt[2];
    
    
%>

<%
  StringBuffer strAd = new StringBuffer();
%>
<%

strAd.append("MemType="+Memtype+"&revName="+name+"&revEmail="+email+"&revTel1="+tel1+"&revTel2="+tel2+"&revTel3="+tel3);
out.println(strAd.toString());

%>
