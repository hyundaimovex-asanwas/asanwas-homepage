<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 고객관리
 * 프로그램ID 		: CU010i
 * J  S  P		: cu010i
 * 서 블 릿		: Cu010i
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-05-16
 * 기능정의		: 대리점 관리 (조회 등록 삭제 수정)
 * 수정내용		: 
 * 수 정 자		: 이병욱
 * 최종수정일자 	: 2006-05-16 
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%@ page import="java.util.*, java.text.*,java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Set" %>
<%@ page import="sales.menu.sy.HolidayManager" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.org.util.CalendarUtil"%>
<%@ page import="sales.org.util.ClassUtil"%>
<%@ page import="sales.org.util.StringUtil"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

    ArrayList data3 = new ArrayList();
    SmartRequest sr3 = new SmartRequest(request);
    String where_sql3     = "";
    String work_flag     = sr3.getString("work_flag");
    Calendar cal = Calendar.getInstance();
  
     java.text.DateFormat df = null; 
     String year = null;
     String curr_year = null;
     int len3 = 0;
     BaseDataClass bean3;
     
     curr_year = Integer.toString(cal.get(Calendar.YEAR));
	 curr_year = (curr_year.length() != 4) ? "0000" + curr_year : curr_year;
	 curr_year = curr_year.substring(curr_year.length() - 4);
     
     if (request.getParameter("year") == null){
        year = curr_year;
     }
     else {
        year = request.getParameter("year");
     }
    where_sql3=" and detail like '" + year + "%'";
    sr3.setObject("work_flag",(Object)work_flag);
    sr3.setObject("where_sql",(Object)where_sql3);  
   
    HolidayManager manager3 = new HolidayManager();
    data3 = manager3.list(sr3);
    manager3.close();
	 
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>	
<script language="javascript">
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
	}

</script>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		


<table width="100%" border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:1px;width:310px;height:300px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
    <form name="form2" method="post">
	<tr>
		<td height=25  border="0">년도 : <select name="year" onchange="refresh();">
		<% for (int i=Integer.parseInt(curr_year)-4;i<Integer.parseInt(curr_year)+6;i++){%>
		   <option value="<%=i%>" <% if (Integer.parseInt(year) == i) { out.println("selected");}%>> <%=i%> </option>
		<% }%>   
		</select></td>
	</tr>
	</form>
	<tr> 
		<td> 
			<table width="100%" border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:0px;width:260px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
               <tr>
                 <td>
                 
<!-- 달력 시작 -->
<%
    String month = "00";
    String day = "01";
	int t = 0;
	int num = 0;
    String id = "";
	
	for (int k = 0 ; k < 3 ; k++) {
%>
    <table  border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:0px;width:260px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
	  <tr valign="top"> 
	<%
		 //달력 기본 화면 Loop돌면서 12월까지 그리드를 생성한다 
		for (int j = 0; j < 4; j++) {
			num = t++;
			month = ""+((Integer.parseInt(month)+1));
			if (month.length() < 2) {
                month = "0"+month;
            }
	%>
 <td height="200"><table width=200 border=0 cellspacing=1 cellpadding=3 bgcolor=#999999>
  <tr>
     <td colspan="7" align=center width="200" valign=middle height=25><font face=Verdana, Arial, Helvetica, sans-serif><b>
      <%=month%></b></font></td>
 </tr>
 <tr bgcolor=#FCFCF3 align=center height='29'>
  <td width=29 bgcolor="#eeeeee" class=verdana_b><font color=#CC0000>일</font></td>
  <td width=29 bgcolor="#eeeeee" class=verdana_b><font color=#666666>월</font></td>
  <td width=29 bgcolor="#eeeeee" class=verdana_b><font color=#666666>화</font></td>
  <td width=29 bgcolor="#eeeeee" class=verdana_b><font color=#666666>수</font></td>
  <td width=29 bgcolor="#eeeeee" class=verdana_b><font color=#666666>목</font></td>
  <td width=29 bgcolor="#eeeeee" class=verdana_b><font color=#666666>금</font></td>
  <td width=29 bgcolor="#eeeeee" class=verdana_b><font color=#6666CC>토</font></td>
 </tr>

<%
 cal.set(Integer.parseInt(year), Integer.parseInt(month) - 1 , 1);
 int indent = cal.get(Calendar.DAY_OF_WEEK);
 cal.add(Calendar.MONTH, 1);
 cal.add(Calendar.DATE, -1);
 int numberOfDays = cal.get(Calendar.DATE);

 for (int i = 1; i < indent; i++) 
 {
  if (i == 1) 
  {
   out.println("<tr bgcolor='#FFFFFF' valign='top' height='29'>");
  }
  out.println("<td width='29'></td>");
 }


 df = new SimpleDateFormat("yyyyMMdd");
 
 for (int i = 1; i <= numberOfDays; i++) 
 {
  String cssClass = "cal_black";

  if (i>9){
     day = ""+i;
  }
  else {
     day = "0" + i;
  }
  id = month + day;
  if (day.length() == 3) 
  {
   day = day.substring(1);
  }

  if (((indent + i) - 1) % 7 == 1) 
  {  // 일요일
   out.println("<tr bgcolor='#FFFFFF' valign='top' height='29'>");
   cssClass = "cal_black";
  }
  else if (((indent + i) - 1) % 7 == 0) 
  {
   cssClass = "cal_blue";
  }
   out.println("<td width='29' id=" + id + ">");
   if (((indent + i) - 1) % 7 == 1){
   out.println("<script>sunday('" + id + "')</script>");
   }

   if (((indent + i) - 1) % 7 == 1) {
%>
  <span class="<%=cssClass%>" ><%=i%></span>
  </td>
<%
   }
   else {
%>
  <a href="javascript:paintion_back('<%=id%>','<%=((indent + i) - 1) % 7 %>');"><span class="<%=cssClass%>" ><%=i%></span></a>
  </td>
<%
   }
   if (((indent + i) - 1) % 7 == 0) 
   {
   out.println("</tr>"); //토요일
   }
 }


 if ( ( (indent == 6) && (numberOfDays > 30) ) || ( (indent == 7) && (numberOfDays > 29) ) ) 
 {
  if (41-numberOfDays-indent > 0) 
  {
   for (int i = 43 - numberOfDays - indent; i > 0; i--) 
   {
    out.println("<td> </td>");
   }
  }

  out.println("</tr>");
 } 
 else if ( (numberOfDays != 28) || (indent > 1) ) 
 {
  if (36-numberOfDays-indent > 0) 
  {
   for (int i = 36 - numberOfDays - indent; i > 0; i--) 
   {
    out.println("<td> </td>");
   }
  }

  out.println("</tr>");
 }
%>
</table>
	</td><td width="20">&nbsp;&nbsp;&nbsp;</td>
<% 
	} 
%>
		</tr>
		<tr height="4"><td colspan="8">&nbsp;</td></tr>
		</table>
	<%
}
%>
</table>							
							</td>
						</tr>
					<!-- 실제 코딩 부분 끝  -->
					</table>
				</td>
			</tr>
<!-- 프로그램 들어가는 BODY END -->			
		</table>
<form name="form1">
    <input type="hidden" name="caln_date">
    <input type="hidden" name="proType">
    <input type="hidden" name="yoil_cd">
</form>
<iframe name="hoil_proc" width="0" height="0"></iframe>
<%
	if(data3 != null && data3.size() > 0) {
		len3 = data3.size();
		bean3 = null;
	    String caln_date = "";
		for(int h=0; h<len3; h++) {
			bean3 = (BaseDataClass)data3.get(h);
			caln_date = bean3.get("caln_date");
			out.println("<script>holiday('" + caln_date.trim() + "');</script>");
		}
	}
%>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

