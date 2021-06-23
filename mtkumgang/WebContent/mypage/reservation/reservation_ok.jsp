<%--
  - 작성자: 이소연
  - 일자: 2006.07.03
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 마이페이지>나의예약보기
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="java.util.*"%>

<%
String r_mail = "";
String r_pass = "";
String chk_confirm = "";

//request parameters
r_mail  = ParamUtil.getReqParameter(request.getParameter("r_mail"), "");
r_pass = ParamUtil.getReqParameter(request.getParameter("r_pass"), "");
chk_confirm = ParamUtil.getReqParameter(request.getParameter("chk_confirm"), "");   // 1 : 회원예약, 2:비회원예약

if(chk_confirm.equals("1")){
        ReservationInfo dao2 = new ReservationInfo();
        Reservation_bean[] recordview2 = dao2.getLogin(session_id);
        if (recordview2.length > 0){
             r_mail = recordview2[0].getRmail();
             r_pass = recordview2[0].getRpass();
        }
}else{
       if (r_mail.equals("") || r_pass.equals("")){  // 비회원예약임에도 정보가 없는경우
%>
        <script language="javascript">
            alert("예약시 예약시 등록한 정보로 인증해 주십시요.");
            document.location.href="reservation_confirm.jsp";
        </script>
<%   
       }
}


//변수선언
int cnt = 0;

ReservationInfo dao = new ReservationInfo();
Reservation_bean[] recordview = dao.getRevUser(r_mail, r_pass);

int totalCount = recordview.length;


   if (totalCount > 0){
   %>
       <form name="myform" method="post" action="reservation_list.jsp">
         <input type="hidden" name="r_mail" value="<%=r_mail%>">
         <input type="hidden" name="r_pass" value="<%=r_pass%>">
       </form>    
    <%
       out.println("<script language='javascript'>document.myform.submit();</script>");
   
   }else{
   
       out.println("<script language='javascript'>alert('등록된 예약 정보가 없습니다.');history.back();</script>");
   
   }
%>