<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명      	: 마이페이지
 * 프로그램ID 	: CU010i
 * J  S  P      : cu010i
 * 서 블 릿      		: My210DAO,My210DTO,My210Manager
 * 작 성 자      		: 남기표
 * 작 성 일      		: 2006-06-15
 * 기능정의      	: 대리점문의 관리(리스트)
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
<%@ page import="sales.menu.my.My210Manager" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.org.util.CalendarUtil"%>
<%@ page import="sales.org.util.ClassUtil"%>
<%@ page import="sales.org.util.StringUtil"%>
<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

   ArrayList data3 = new ArrayList();
   SmartRequest sr3 = new SmartRequest(request);
   String where_sql3     = "";
   String brd_gu = "03";

   int len3 = 0;
   BaseDataClass bean3;
   String key = request.getParameter("search_key");
   String values = request.getParameter("search_value");
	
   if (values !=  null && !values.equals("")){
      where_sql3=" AND " + key + " like '%" + values + "%'";
   } 
   
   where_sql3 = "";
   sr3.setObject("where_sql",(Object)where_sql3);
   sr3.setObject("brd_gu",(Object)brd_gu);
   My210Manager manager3 = new My210Manager();
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
   function view_send(brd_no,ref,ref_step){
   	 var f = document.form1;
      f.action="my120v.jsp";
      f.brd_no.value = brd_no;
      f.ref.value = ref;
      f.ref_step.value = ref_step;
      f.method = "POST";
      f.target="";
      
      f.submit();
   }
   function sel_chk(){
    var f = document.form1;
      if(f.search_value.value==""){alert('검색어를 넣어 주세요'); f.search_value.focus();  return;}
      f.action='my120s.jsp';
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
       f.action='my120s.jsp';
       f.target='';
             f.method = "POST";
       f.submit();
   }
  
   </script>
 
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
		
	<table width="845" border="0" cellspacing="0" cellpadding="0" ID="Table3">
                      <form name="form1">
                      <input type="hidden" name="brd_gu" value="<%=brd_gu%>">
                      <input type="hidden" name="brd_no" value="">
                      <input type="hidden" name="ref" value="">
                      <input type="hidden" name="ref_step" value="">
                      <tr>
                        <td height="30" colspan="6" align="right">
                          <table width="845" border="0" cellspacing="0" cellpadding="0" ID="Table4">
                            <tr>
                              <td height="25">
                                 <select name="search_key"  style="font-size=9pt;color : #ffffff ;background-color:#797979">
                                      <option value ="BRD_SUBJECT" >제목</option>
                                      <option value ="BRD_CREATOR" >작성자</option>
                                 </select>
                                 <input type="text" name="search_value" size="12" style="height:19px; border:1 solid; border-color: #cccccc; font-size: 12px;" onKeyDown="javascript:sel_chk_enter();" ID="Text1"> <a href="javascript:sel_chk();"><img src="<%=dirPath%>/Sales/images/b_search.gif" border="0" align="absmiddle"></a> </td>
                              <td width="100" align="right"><a href="javascript:write_ok();"><img src="<%=dirPath%>/Sales/images/b_write.gif" border="0" align="absmiddle"></a> </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                         <td height="2" colspan='6' bgcolor="#CEC8DD"></td>
                      </tr>
                      <tr bgcolor="#F3F0F9">
                         <td width="50" align='center'><b><font color="#555555">번호</font></b></td>
                         <td width="525" align='center'><b><font color="#555555">제목</font></b></td>
                         <td width="60" align='center'><b><font color="#555555">첨부파일</font></b></td>
                         <td width="60" align='center'><b><font color="#555555">작성자</font></b></td>
                         <td width="80" align='center'><b><font color="#555555">작성일</font></b></td>
                         <td width="70" align='center'><b><font color="#555555">조회수</font></b></td>
                      </tr>
                      <tr>
                        <td height="1" colspan='6' bgcolor="#CEC8DD"></td>
                      </tr>
                   </form>
                   </table>
 
 
 
 
 <div id='hscroll_box'><div id='vscroll_box'><table width="100%" border="0" cellspacing="0" cellpadding="0" ID="Table3">
                        <%
                           if(data3 == null || data3.size() < 1 ) {
                        %>
                            <tr>
                               <td colspan='6' align='center' height='800'><b>게시물이 없습니다.</b></td>
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
                            <td height=1 colspan='6'></td>
                          </tr>
                          <tr>
                            <td width="50" align='center' height='20'><%=tocnt--%><%//=bean3.get("brd_no")%></td>
                            <td width="525" align='left'>&nbsp;&nbsp;<a href="javascript:view_send('<%=bean3.get("brd_no")%>','<%=bean3.get("ref")%>','<%=bean3.get("ref_step")%>');">
                        <%
                                int wid=0;
                                if(Integer.parseInt(bean3.get("ref_step"))>0){
                                      wid = 10 * Integer.parseInt(bean3.get("ref_step"));
                        %>
                             <img src="<%=dirPath%>/Sales/images/space.gif" width="<%=wid%>" height="10"  border="0" ><img src="<%=dirPath%>/Sales/images/re.gif" border="0">
                        <%
                                 }
                        %>
                             <%=bean3.get("brd_subject")%></a></td>
                            <td width="60" align='center'><% if (bean3.get("real_file") == null || bean3.get("real_file").equals("")) {
                            %><img src="<%=dirPath%>/Sales/images/file.gif" border="0">
                            <% } %></td>
                            <td width="60" align="center"><%=bean3.get("brd_creator")%></td>
                            <td width="80" align="center"><%=bean3.get("brd_cdate")%></td>
                            <td width="70" align="center"><%=bean3.get("brd_viewcnt")%></td>
                          </tr>
                          <tr>
                            <td height="1" colspan="6" background="<%=dirPath %>/Sales/images/line_pt.gif"></td>
                          </tr>
<%
                           }
                       }
%>
                        <tr>
                          <td height="4" colspan='6' bgcolor="#ECE9F1"></td>
                           </tr>
                      </table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

