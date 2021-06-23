<?xml version="1.0" encoding="euc-kr" ?>
<%@ page contentType="text/xml; charset=euc-kr" %>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>

<% 
//request parameters
int board_seq			= ParamUtil.getIntParameter(request.getParameter("board_seq"));
String password		= clearXSS( ParamUtil.getReqParameter(request.getParameter("password")),avatag );

String value = "noResult";

System.out.println("board_seq===>"+board_seq);
System.out.println("password===>"+password);
//DAO
CommonBoard commonDao = new CommonBoard();
boolean result = commonDao.getPasswordYn(board_seq, password);

if(result){
  value = "yeSoK";
}
%>


<passYn>
        <result><%=value%></result>
</passYn>
