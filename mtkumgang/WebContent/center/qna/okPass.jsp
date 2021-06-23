<?xml version="1.0" encoding="euc-kr" ?>
<%@ page contentType="text/xml; charset=euc-kr" %>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.util.*"%>

<% 
//request parameters
int board_seq			= ParamUtil.getIntParameter(request.getParameter("board_seq"));
String password		= ParamUtil.getReqParameter(request.getParameter("password"));

String value = "0";

System.out.println("board_seq===>"+board_seq);
System.out.println("password===>"+password);
//DAO
CommonBoard commonDao = new CommonBoard();
boolean result = commonDao.getPasswordYn(board_seq, password);

if(result){
  value = "1";
}
%>


<passYn>
        <result><%=value%></result>
</passYn>
