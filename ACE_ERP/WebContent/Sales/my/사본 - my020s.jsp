<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 편지함 관리
 * 프로그램ID 	: MY020I
 * J  S  P		: my020i
 * 서 블 릿		: My020i
 * 작 성 자		: 남기표
 * 작 성 일		: 2006-06-27
 * 기능정의		: 보낸 편지함 (조회)
 * 수정내용		: 
 * 수 정 자		: 
 * 최종수정일자 	:  
 * TODO			: 
 * TODO			: 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import

%>
<%@ page import="sales.common.*"%>
<%@ page import="sales.common.*"%>
<%@ page import="java.util.*, java.text.*,java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Set" %>
<%@ page import="sales.menu.my.My020Manager" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.org.util.CalendarUtil"%>
<%@ page import="sales.org.util.ClassUtil"%>
<%@ page import="sales.org.util.StringUtil"%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  자바코드
try {
   // ContextPath
   String dirPath = request.getContextPath(); //HDASan

   ArrayList data3 = new ArrayList();
   SmartRequest sr3 = new SmartRequest(request);
   String where_sql3     = "";

   int len3 = 0;
   BaseDataClass bean3;
   String key = request.getParameter("search_key");
   String values = request.getParameter("search_value");
   String send_login_id = "0908nkp";

   
   where_sql3 = "";
   if (values !=  null && !values.equals("")){
      where_sql3=" AND " + key + " like '%" + values + "%'";
   } 
   

   sr3.setObject("send_login_id",(Object)send_login_id);
   sr3.setObject("where_sql",(Object)where_sql3);
   My020Manager manager3 = new My020Manager();
   data3 = manager3.list(sr3);
   manager3.close();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<jsp:include page="/Sales/common/include/head.jsp"/>
<head>
 <script> 
 function fnOnLoad(){

	}
   function view_send(brd_no){
   	 var f = document.form1;
      f.action="my020v.jsp";
      f.brd_no.value = brd_no;
      f.method = "POST";
      f.target="";
      
      f.submit();
   }
   function sel_chk(){
    var f = document.form1;
      if(f.search_value.value==""){alert('검색어를 넣어 주세요'); f.search_value.focus();  return;}
      f.action='my210s.jsp';
      f.taget='';
      f.method = "POST";
      f.submit();
   }
   function sel_chk_enter(){
   
      if(event.keyCode=="13"){
         sel_chk()
       }
   }
   function write_ok(){
    var f = document.form1;
       f.action='my210i.jsp';
       f.target='';
             f.method = "POST";
       f.submit();
   }
  
   </script>

</head>
<!--------------------------------- BODY Start ------------------------------->
   <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   onLoad="namosw_init_slide_layers('layer1', 2); MM_preloadImages('<%=dirPath %>/Sales/images/com_top_m01.gif','<%=dirPath %>/Sales/images/com_top_m02.gif','<%=dirPath %>/Sales/images/com_top_m03.gif','<%=dirPath %>/Sales/images/com_top_m04.gif','<%=dirPath %>/Sales/images/com_top_m05.gif','<%=dirPath %>/Sales/images/com_top_m06.gif','<%=dirPath %>/Sales/images/com_top_m07.gif','<%=dirPath %>/Sales/images/com_top_m08.gif','<%=dirPath %>/Sales/images/com_top_m01_on.gif','<%=dirPath %>/Sales/images/com_top_m02_on.gif','<%=dirPath %>/Sales/images/com_top_m03_on.gif','<%=dirPath %>/Sales/images/com_top_m04_on.gif','<%=dirPath %>/Sales/images/com_top_m05_on.gif','<%=dirPath %>/Sales/images/com_top_m06_on.gif','<%=dirPath %>/Sales/images/com_top_m07_on.gif','<%=dirPath %>/Sales/images/com_top_m08_on.gif','<%=dirPath %>/Sales/images/com_top_m09_on.gif')">
      <table width="1000" height="100%" border="0" cellpadding="0" cellspacing="0">
         <tr>
            <td width="123" valign="top"><!--// 사이드메뉴--><jsp:include page="/Sales/common/include/left_mn1.jsp"/></td>  <!--// 사이드메뉴 끝-->
            <td valign="top"><!--// 탑메뉴시작 --> <jsp:include page="/Sales/common/include/top_mn.jsp"/></td> <!--// 탑메뉴 끝-->
         </tr>
         <tr>
             <td height="10"></td>
         </tr>
<!-- 프로그램 들어가는 BODY START -->
         <tr>
            <td align="center" valign="top">
               <table width="845" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                     <td><!-- 타이틀 INCLUDE --><jsp:include page="/Sales/common/include/title.jsp"/></td><!-- 타이틀 INCLUSDE 끝 -->
                  </tr>
					<!-- 실제 코딩 부분 시작  -->
						<tr> 
							<td><table width="845" border="0" cellspacing="0" cellpadding="0" ID="Table3">
							      <form name='form1' method='post'>
							       <input type="hidden" name="brd_no" value="">
                                  <tr> 
                                    <td height="30" colspan='5'>
                                      <table border="0" cellspacing="0" cellpadding="0" ID="Table4">
                                        <tr> 
                                          <td height="25">
                           	   		    <select name="sel"  style="font-size=9pt;color : #ffffff ;background-color:#797979">
                           				  <option value ="BRD_SUBJECT" >제목</option>
                           				  <option value ="BRD_SEND_LOGIN_ID" >받는사람</option>
                           				</select>&nbsp;					
                           			   </td>
                                          <td width="86"><input type="text" name="str"  value="" size="12" style="height:19px; border:1 solid; border-color: #cccccc; font-size: 12px;" onKeyDown="javascript:sel_chk_enter(form1);" ID="Text1"></td>
                                          <td width="34"><a href="javascript:sel_chk(this.form1);"><img src="<%=dirPath%>/Sales/images/b_search.gif" border="0"></a></td>
                                        </tr>
                                       </table>
                                      </td>
                                    </tr>
                                      <tr> 
                                       <td height="2" colspan='5' bgcolor="#CEC8DD"></td>
                                       </tr>
                                       <tr bgcolor="#F3F0F9"> 
                                          <td width="50" align='center'><b><font color="#555555">번호</font></b></td>
                                          <td width="425"align='center'><b><font color="#555555">제목</font></b></td>
                                          <td width="60" align='center'><b><font color="#555555">첨부파일</font></b></td>
                                          <td width="110" align='center'><b><font color="#555555">받는사람</font></b></td>
                                          <td width="130" align='center'><b><font color="#555555">발송일</font></b></td>
                                       </tr>
                                       <tr> 
                                         <td height="1" colspan='5' bgcolor="#CEC8DD"></td>
                                       </tr>
                                        <tr> 
                                           <td width="100%" colspan=5><div id='hscroll_box'><div id='vscroll_box'><table width="100%" border="0" cellspacing="0" cellpadding="0" ID="Table5">
						                        <%
						                           if(data3 == null || data3.size() < 1 ) {
						                        %>
						                            <tr>
						                               <td colspan='5' align='center' height='200'><b>게시물이 없습니다.</b></td>
						                             </tr>
						                        <%
						                           }
						                           else {
						                              len3 = data3.size();
						                              bean3 = null;
						                              int tocnt = data3.size();
						                              for(int h=0; h<len3; h++) {
						                                 bean3 = (BaseDataClass)data3.get(h);
						                        %>
                           		       <tr> 
                                            <td width="50" align='center' height='20'><%=tocnt--%></td>
                                            <td width="425" align='left'>&nbsp;&nbsp;<a href="javascript:view_send('<%=bean3.get("brd_no")%>');">  <%=bean3.get("brd_subject")%></a></td>
                                            <td width="60" align='center'><% if (bean3.get("real_file") == null || bean3.get("real_file").equals("")) {%><img src="<%=dirPath%>/Sales/images/file.gif" border="0">
                            				<% } %></td>
                                            <td width="110" align="center"><%=bean3.get("out_login_id")%></td>
                                           	<td width="130" align="center"><%=bean3.get("send_date")%></td>
                                           </tr>
                                          <tr> 
                                            <td height=1 colspan='5'></td> 
                                          </tr>
                                        <tr>
			                            <td height="1" colspan="6" background="<%=dirPath %>/Sales/images/line_pt.gif"></td>
			                          </tr>
                                       <%
                                       		}
                                       	}
                                       %>
			                          </table></td></tr>

			                          <tr>
				                          <td height="4" colspan='6' bgcolor="#ECE9F1"></td>
				                      </tr>
                                  </form>
                                  </table></td>
						</tr>
					<!-- 실제 코딩 부분 끝  -->
    			</table>
            </td>
         </tr>
<!-- 프로그램 들어가는 BODY END -->
      </table>
<!---------------------------------- BODY End -------------------------------->
   </body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>