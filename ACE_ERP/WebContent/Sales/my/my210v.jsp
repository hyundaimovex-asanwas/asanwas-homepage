<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 공지사항
 * 프로그램ID 	: CU010i
 * J  S  P		: cu010i
 * 서 블 릿		: Cu010i
 * 작 성 자		: 남기표
 * 작 성 일		: 2006-05-16
 * 기능정의		: 공지사항 (상세)
 * [수  정   일  자][수정자] 내용
 * [2008-01-03][심동현] 새 메뉴트리 적용
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
	<!--
	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
								
		fnInit(); 

	}	
	
	function fnInit(){
	};
	
	function list(){
		var f = document.form1;
		f.action = "my210s.jsp";
		f.submit();
	}
	
	function edit(){
		var  f = document.form1;
		f.work_flag.value = "MODIFY";
		f.action = "my210m.jsp";
		f.submit();
	}
	
	function reply(){
		var f = document.form1;
		f.action = "my210r.jsp";
		f.submit();
	}
	
	function fnDelete() {
		var f = document.form1;
		f.work_flag.value = "DELETE";
		f.action = "my210p.jsp";
		f.submit();
	}	

	
	//-->
	</script>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

		<table border="0" cellpadding="0" cellspacing="0" width="624" bgcolor="#F2F1E2">
		  <form name="form1" >                                                                                                                                 
		  <input type="hidden" name="brd_no" value="<%=brd_no%>">                                                                                            
		  <input type="hidden" name="brd_gu" value="<%=brd_gu%>">                                                                                            
		  <input type="hidden" name="search_key" value="<%=key%>">                                                                                           
		  <input type="hidden" name="search_values" value="<%=values%>">                                                                                     
		  <input type="hidden" name="ref" value="<%=ref%>">                                                                                                 
		  <input type="hidden" name="ref_step" value="<%=ref_step%>">                                                                                       
		  <input type="hidden" name="work_flag">
		  <input type="hidden" name="idx" value="404">		  

			<col width="11"></col>
			<col width="47" style="padding-left:10"></col>
			<col width="1"></col>
			<col width="418" style="padding-left:10"></col>
			<col width="47" style="padding-left:10"></col>
			<col width="1"></col>
			<col width="88" style="padding-left:10"></col>
			<col width="11"></col>
			<tr>
				<td valign="top" rowspan="3" background="http://www.hdasan.com/img/common/bbs_left_bg.gif"><img src="http://www.hdasan.com/img/common/bbs_tleft.gif"></td>
				<td colspan="6" height="1" bgcolor="#DEDDCF"></td>
				<td valign="top" rowspan="3" background="http://www.hdasan.com/img/common/bbs_right_bg.gif"><img src="http://www.hdasan.com/img/common/bbs_tright.gif"></td>
			</tr>
			<tr height="30">
				<td><img src="http://www.hdasan.com/img/common/bbs_title.gif"></td>
				<td><img src="http://www.hdasan.com/img/common/bbs_bar_center.gif"></td>
				<td class="bbs"><%=dto.getBrd_subject()%></td>
				<td><img src="http://www.hdasan.com/img/common/bbs_name.gif"></td>
				<td><img src="http://www.hdasan.com/img/common/bbs_bar_center.gif"></td>
				<td class="bbs"><%=dto.getBrd_creator()%></td>
			</tr>
			<tr><td colspan="6" height="1" bgcolor="#DEDDCF"></td></tr>
			<tr height="30">
				<td valign="bottom" rowspan="2" background="http://www.hdasan.com/img/common/bbs_left_bg.gif"><img src="http://www.hdasan.com/img/common/bbs_bleft.gif"></td>
				<td><img src="http://www.hdasan.com/img/common/bbs_file.gif"></td>
				<td><img src="http://www.hdasan.com/img/common/bbs_bar_center.gif"></td>
				<td class="bbs">
					<%// if( fileread.size() == 0 ) { %>
                      <%// } else {
                        //  	for(int i = 0; i < fileread.size() ; i++) {
                         // 	    HashMap hm = (HashMap)fileread.get(i);
					  %>
							<a href="/common/download.jsp?dir=bodo&filename=<%//= Utility.ko((String)hm.get("FILE")) %>&sysfilename=<%//= hm.get("SYSFILE") %>"><%//= Utility.ko((String)hm.get("FILE")) %></a>
                    <% //} }  %>
				</td>
				<td><img src="http://www.hdasan.com/img/common/bbs_date.gif"></td>
				<td><img src="http://www.hdasan.com/img/common/bbs_bar_center.gif"></td>
				<td class="bbs"><%=dto.getBrd_cdate2()%></td>
						<td valign="bottom" rowspan="2" background="http://www.hdasan.com/img/common/bbs_right_bg.gif"><img src="http://www.hdasan.com/img/common/bbs_bright.gif"></td>
					</tr>
					<tr><td colspan="6" height="1" bgcolor="#DEDDCF"></td></tr>
					</table>

					<table border="0" cellpadding="0" cellspacing="0" width="624" height="280">
					<tr>
						<td valign="top" style="padding: 15 20 20 15" class="bbs">
						<%=dto.getBrd_contents()%></td>
			</tr>
		  </form>                                                                                                          
		</table>
		<!-- //Press READ-->

		<!-- Before & After-->
		<table border="0" cellpadding="0" cellspacing="0" width="624">
			<tr><td colspan="2" height="1" bgcolor="#DBDACB"></td></tr>
			<%// if( preview.size() != 0 ) { %>
				<tr height="25">
					<td width="105" bgcolor="#F2F1E2" align="center"><img src="http://www.hdasan.com/img/common/bbs_before.gif"></td>
					<td width="" style="padding-left:10" class="bbs"><a href="press_read.jsp?navi=060200&idx=이전인덱스">이전타이틀</a></td>
				</tr>
				<tr><td colspan="2" height="1" bgcolor="#DBDACB"></td></tr>
			<%// } %>
			<%// if( nextview.size() != 0 )  {%>
				<tr height="25">
					<td width="105"  bgcolor="#F2F1E2" align="center"><img src="http://www.hdasan.com/img/common/bbs_after.gif"></td>
					<td style="padding-left:10" class="bbs"><a href="press_read.jsp?navi=060200&idx=다음인덱스">다음 타이틀</a></td>
				</tr>
				<tr><td colspan="2" height="1" bgcolor="#DBDACB"></td></tr>
			<%// } %>
		</table>
		<!-- //Before & After-->

		<!-- Button-->
		<table border="0" cellpadding="0" cellspacing="0" width="624">
			<tr><td height="8"></td></tr>
			<tr>
				<td align="right">
					<!-- a href="javascript:reply();"><img src="../images/b_reply.gif" border="0"></a-->                                                    
					<a href="javascript:edit();"><img src="../images/b_edit.gif" border="0"></a>                                                            
					<a href="javascript:fnDelete();"><img src="../images/b_del.gif" border="0"></a>                                                         
					<a href="javascript:list();"><img src="../images/b_list.gif" border="0"></a>
					
				</td>
			</tr>
		</table>
		<!-- Button-->
<br><br>

                                                                                                                                                        
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

<%
	} catch (Exception e) {
		e.printStackTrace();
	}
%>	