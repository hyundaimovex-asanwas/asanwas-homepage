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
 * TODO			: 
 * TODO			: 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import

%>
<%@ page import="sales.common.*"%>
<%@ page import="java.util.*, java.text.*,java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Set" %>
<%@ page import="sales.menu.my.My210Manager" %>
<%@ page import="sales.menu.my.My210DTO" %>
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
   String brd_gu = request.getParameter("brd_gu");
   String brd_no = request.getParameter("brd_no");
   String work_flag =request.getParameter("work_flag");
   String ref =request.getParameter("ref");
   String ref_step =request.getParameter("ref_step");

   int len3 = 0;
   BaseDataClass bean3;
   String key = request.getParameter("search_key");
   String values = request.getParameter("search_value");
   
   sr3.setObject("where_sql",(Object)where_sql3);
   sr3.setObject("brd_no", (Object)brd_no);
   My210Manager manager3 = new My210Manager();
   My210DTO dto = manager3.select(sr3);
   manager3.close();

	 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<!-- HEAD 정보 -->
	<jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>		
	<script language="javascript">
	<!--
	function list(){
		var f = document.form1;
		f.action = "my110i.jsp";
		f.submit();
	}
	
	function edit(){
		var  f = document.form1;
		f.work_flag.value = "MODIFY";
		f.action = "my110m.jsp";
		f.submit();
	}
	
	function reply(){
		var f = document.form1;
		f.action = "my110r.jsp";
		f.submit();
	}
	
	function fnDelete() {
		var f = document.form1;
		f.work_flag.value = "DELETE";
		f.action = "my110p.jsp";
		f.submit();
	}	

	
	//-->
	</script>
	</head>
<!-- 프로그램 들어가는 BODY START -->
<jsp:include page="/Sales/common/include/body_s.jsp"/>
					<!-- 실제 코딩 부분 시작  -->
							<table width="845" border="0" cellspacing="0" cellpadding="0" ID="Table1">
                                     <tr> 
                                       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                                     </tr>							
                                     <tr> 
                                       <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">제  &nbsp;&nbsp;&nbsp;목&nbsp;</font></b></td>
                                       <td colspan="3" style="padding-top:3px">&nbsp;&nbsp;<%=dto.getBrd_subject()%></td>
                                     </tr>
                                     <tr> 
                                       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                                     </tr>
                                     <tr> 
                                       <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">작 성 자&nbsp;</font></b></td>
                                       <td width="340" style="padding-top:3px">&nbsp;&nbsp;<%=dto.getBrd_creator()%></td>
                                       <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">작 성 일&nbsp;</font></b></td>
                                       <td width="345" align="left" style="padding-top:3px">&nbsp;&nbsp;<%=dto.getBrd_cdate2()%></td>
                                     </tr>
                                     <tr> 
                                       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                                     </tr>
                              	   <tr>
                              	     <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">첨부파일&nbsp;</font></b></td>
                              	     <td colspan="3">&nbsp;&nbsp;<%=dto.getSys_file()%></td>
                              	   </tr>
                              	   <tr> 
                                       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                                     </tr>
                                     <tr> 
                                       <td colspan="4" align="center"> 
                              	         <table width="100%" border="0" cellspacing="0" cellpadding="10" ID="Table2">
                                           <tr> 
                                             <td height='80' valign='top'><%=dto.getBrd_contents()%></td>
                                           </tr>
                                         </table></td>
                                     </tr>
                                     <tr> 
                                       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                                     </tr>
                                     <tr align="center"> 
                                       <td align="right" colspan="4" style="padding-top:5px"> 
                                         <table width="100%" cellspacing="0" cellpadding="0" border="0">
                                           <tr> 
                                             <td align="right">
	                                             <a href="javascript:reply();"><img src="../images/b_reply.gif" border="0"></a>
	                                             <a href="javascript:edit();"><img src="../images/b_edit.gif" border="0"></a>
	                                             <a href="javascript:fnDelete();"><img src="../images/b_del.gif" border="0"></a>
	                                             <a href="javascript:list();"><img src="../images/b_list.gif" border="0"></a></td>
                                           </tr>
                                         </table></td>
                                     </tr>
                                   </table></td>
						</tr>
					<!-- 실제 코딩 부분 끝  -->
					</table>
				</td>
			</tr>
<!-- 프로그램 들어가는 BODY END -->		
  					<form name="form1" method="post">
                      <input type="hidden" name="brd_no" value="<%=brd_no%>">
                      <input type="hidden" name="brd_gu" value="<%=brd_gu%>">
                      <input type="hidden" name="search_key" value="<%=key%>">
                      <input type="hidden" name="search_values" value="<%=values%>">
                       <input type="hidden" name="ref" value="<%=ref%>">
                       <input type="hidden" name="ref_step" value="<%=ref_step%>">
                      <input type="hidden" name="work_flag">
                     </form> 	
		</table>
		           


<jsp:include page="/Sales/common/include/body_e.jsp"/>
<%
	} catch (Exception e) {
		e.printStackTrace();
	}
%>	