<%--
  - �ۼ���: �̼ҿ�
  - ����: 2006.07.03
  - ���۱� ǥ��: IMJ Korea
  - ����: ������ - ����������>���ǿ��ຸ��
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
chk_confirm = ParamUtil.getReqParameter(request.getParameter("chk_confirm"), "");   // 1 : ȸ������, 2:��ȸ������

if(chk_confirm.equals("1")){
        ReservationInfo dao2 = new ReservationInfo();
        Reservation_bean[] recordview2 = dao2.getLogin(session_id);
        if (recordview2.length > 0){
             r_mail = recordview2[0].getRmail();
             r_pass = recordview2[0].getRpass();
        }
}else{
       if (r_mail.equals("") || r_pass.equals("")){  // ��ȸ�������ӿ��� ������ ���°��
%>
        <script language="javascript">
            alert("����� ����� ����� ������ ������ �ֽʽÿ�.");
            document.location.href="reservation_confirm.jsp";
        </script>
<%   
       }
}


//��������
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
   
       out.println("<script language='javascript'>alert('��ϵ� ���� ������ �����ϴ�.');history.back();</script>");
   
   }
%>