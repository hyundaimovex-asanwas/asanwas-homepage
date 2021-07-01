<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 쪽지 읽기_pop
 * 프로그램ID 	: my710_read_pop
 * J  S  P		: my710_read_pop
 * 서 블 릿		: my710
 * 작 성 자		: 박경국, 심동현
 * 작 성 일		: 2010-05-26
 * 기능정의		: 공지사항 (상세)
 * [수  정   일  자][수정자] 내용
 * [2010-05-20][박경국] 현대아산 임직원+대리점 담당자가 같이 사용가능한 받은 쪽지함(읽기 화면) 신규 생성.
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
<%@ page import="sales.menu.my.My710Manager" %>
<%@ page import="sales.menu.my.My710DTO" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.org.util.CalendarUtil"%>
<%@ page import="sales.org.util.ClassUtil"%>
<%@ page import="sales.org.util.StringUtil"%>

<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  자바코드

try {
   // ContextPath
   String dirPath = request.getContextPath(); //HDASan
   
   ArrayList data3 = new ArrayList();
   SmartRequest sr3 = new SmartRequest(request);
   String where_sql3     = "";
	//String brd_gu = request.getParameter("brd_gu");
   
   String brd_gu 	= sr3.getString("brd_gu");
   String brd_no 	= sr3.getString("brd_no");
   String work_flag = sr3.getString("work_flag");
   String brd_creator = sr3.getString("brd_creator");
   String brd_creator_name = sr3.getString("brd_creator_name");
   String ref 		= sr3.getString("ref");
   String ref_step	= sr3.getString("ref_step");
   String pageFrom  = sr3.getString("pageFrom");


   int len3 = 0;
   BaseDataClass bean3;
   String key = sr3.getString("search_key");
   String values = sr3.getString("search_value");
   
   sr3.setObject("where_sql",(Object)where_sql3);
   sr3.setObject("brd_no", (Object)brd_no);
   sr3.setObject("brd_creator",(Object)brd_creator);
   sr3.setObject("brd_creator_name", (Object)brd_creator_name);
   My710Manager manager3 = new My710Manager();
   My710DTO dto = manager3.select(sr3);
   manager3.close();


	//파일리스트 html 만들기
    StringBuffer sb = new StringBuffer();
	String real_fileList = dto.getReal_file();	//값을 불러와서 
	String sys_fileList = dto.getSys_file();
	String fileHtml		="";

	String real_file[] = real_fileList.split(":");	//배열로 정리
	String sys_file[] = sys_fileList.split(":");	//배열로 정리
	
		for(int j=0; j<sys_file.length; j++){

			sb.append(" <a href='"+ dirPath +"/Common/sys/download.jsp?dir=board&filename="+real_file[j]+"&sysfilename="+sys_file[j]+"' >"+ real_file[j] +"</a> |");
		};
		
	fileHtml = sb.toString();
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<title> 쪽지 읽기　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</title>
    <jsp:include page="/Sales/common/include/head.jsp"/>


<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
	<script language="javascript">
	<!--
	get_cookdata();
			
	// 페이지로딩
	function fnOnLoad(tree_idx){
		fnInit(); 
	}	
	
	function fnInit(){
	};
	

	function edit(){
		var  f = document.form1;	
		if(GetCookie("vusrid")=="<%=dto.getBrd_creator()%>") {
			f.work_flag.value = "MODIFY";
			f.action = "my710_write.jsp?idx=400";
			f.submit();
		}else{
			alert("작성자만 수정 가능합니다.");
		};
	}
	
	function fnReply(){
		var f = document.form1;
		f.work_flag.value = "REPLY";
		f.action = "my710_exec.jsp?idx=400+&brd_creator="+<%=dto.getBrd_creator()%>+"&brd_creator_name="+<%=dto.getBrd_creator_name()%>;
		f.submit();
	}

	function fnKeep(){
		var f = document.form1;
		f.work_flag.value = "KEEP";
		f.action = "my710_exec.jsp";
		f.submit();
	}
	
	function fnKeep2(){
		var f = document.form1;
		f.work_flag.value = "KEEP2";
		f.action = "my710_exec.jsp";
		f.submit();
	}
	
	
	function fnDelete() {
		var f = document.form1;
		f.work_flag.value = "DELETE";
		f.action = "my710_exec.jsp";
		f.submit();
	}	
	function fnDelete2() {
		var f = document.form1;
		f.work_flag.value = "DELETE2";
		f.action = "my710_exec.jsp";
		f.submit();
	}	
	function fnDelete3() {
	var f = document.form1;
	f.work_flag.value = "DELETE3";
	f.action = "my710_exec.jsp";
	f.submit();
	}	


	
	//-->
	</script>

</head>

<!--  BODY START -->
<body border="0" leftmargin="10" topmargin="15" marginwidth="0" marginheight="0" onload="fnOnLoad()">

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

		<table border=0 cellpadding="0" cellspacing="0" bgcolor="#F2F1E2">
		  <form name="form1" method=post>
		  <input type="hidden" name="brd_no" value="<%=brd_no%>">                                                                                            
		  <input type="hidden" name="brd_gu" value="<%=brd_gu%>">                                                                                            
		  <input type="hidden" name="brd_creator" value="<%=brd_creator%>">                                                                                            
		  <input type="hidden" name="brd_creator_name" value="<%=brd_creator_name%>">                                                                                            
		  <input type="hidden" name="search_key" value="<%=key%>">                                                                                           
		  <input type="hidden" name="search_values" value="<%=values%>">                                                                                     
		  <input type="hidden" name="ref" value="<%=ref%>">                                                                                                 
		  <input type="hidden" name="ref_step" value="<%=ref_step%>">                                                                                       
		  <input type="hidden" name="work_flag">
			<col width="11"></col>
			<col width="72" style="padding-left:10"></col>
			<col width="1"></col>
			<col width="170" style="padding-left:10"></col>
			<col width="47" style="padding-left:10"></col>
			<col width="1"></col>
			<col width="108" style="padding-left:10"></col>
			<col width="11"></col>
			<tr>
				<td valign="top" rowspan="3" background="http://www.hdasan.com/img/common/bbs_left_bg.gif"><img src="http://www.hdasan.com/img/common/bbs_tleft.gif"></td>
				<td colspan="6" height="1" bgcolor="#DEDDCF"></td>
				<td valign="top" rowspan="3" background="http://www.hdasan.com/img/common/bbs_right_bg.gif"><img src="http://www.hdasan.com/img/common/bbs_tright.gif"></td>
			</tr>
			<tr height="30">
				<td><img src="http://www.hdasan.com/img/common/<% if(pageFrom.equals("710")){%>bbs_name_from<%}else{%>bbs_name_to<%};%>.gif"></td>
				<td><img src="http://www.hdasan.com/img/common/bbs_bar_center.gif"></td>
				<td class="bbs"><% if(pageFrom.equals("710")){%><%=dto.getBrd_creator()%>(<%=dto.getBrd_creator_name()%>)<%}else{%><%=dto.getBrd_recipient()%>(<%=dto.getBrd_recipient_name()%>)<%};%></td>
				<td><img src="http://www.hdasan.com/img/common/bbs_date.gif"></td>
				<td><img src="http://www.hdasan.com/img/common/bbs_bar_center.gif"></td>
				<td class="bbs"><%=dto.getBrd_cdate2()%></td>
			</tr>
			<tr><td colspan=8 height="1" bgcolor="#DEDDCF"></td></tr>
			
			<tr height="30">
				<td valign="bottom" rowspan="2" background="http://www.hdasan.com/img/common/bbs_left_bg.gif"><img src="http://www.hdasan.com/img/common/bbs_bleft.gif"></td>
				<td><img src="http://www.hdasan.com/img/common/bbs_file.gif"></td>
				<td><img src="http://www.hdasan.com/img/common/bbs_bar_center.gif"></td>
				<td class="bbs" colspan=4><%=fileHtml%></td>
				<td valign="bottom" rowspan="2" background="http://www.hdasan.com/img/common/bbs_right_bg.gif"><img src="http://www.hdasan.com/img/common/bbs_bright.gif"></td>
			</tr>
			<tr><td colspan="6" height="1" bgcolor="#DEDDCF"></td></tr>
		</table>

		<table border="0" cellpadding="0" cellspacing="0" width="460">
			<tr>
				<td valign="top" align=center style="padding-top:15" class="bbs">
				<!-- 본문 : 에디터 사용 2098-03-12 by 심동현 -->
				<FCK:editor id="brd_contents" basePath="/FCKeditor/" 
					width="440" height="300" 
					toolbarSet="asan_read">
					<%=dto.getBrd_contents()%>
				</FCK:editor>
				</td>
			</tr>
		  </form>
		  	<tr>
		  		<td>	
		  		<table border="0" cellpadding="0" cellspacing="0" width="440" align=center>
				  	<tr>
				  		<td><% if(pageFrom.equals("710")){%>※ 읽은 쪽지는 30일 후 자동 삭제됩니다.<%}else{%>보낸 쪽지는 30일 후 자동 삭제됩니다.<%}%></td>
				  		<td align=right><% if(pageFrom.equals("710")){%>앞글 | 뒷글<%}%></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>

		<!-- //Press READ -->

		<table border="0" cellpadding="0" cellspacing="0" width="460">
			<tr><td colspan="2" height="1" bgcolor="#DBDACB"></td></tr>
		</table>

		<!-- Button-->
		<table border="0" cellpadding="0" cellspacing="0" width="460">
			<tr><td height="8"></td></tr>
			<tr>
				<td align="center">
					<% if(pageFrom.equals("710")){%><a href="javascript:fnReply();"><img src="../images/b_reply.gif" border="0"></a><%}%>
					<% if(pageFrom.equals("710")){%><a href="javascript:fnKeep();"><img src="../images/b_keep.gif" border="0"></a><%}%>
					<% if(pageFrom.equals("720")){%><a href="javascript:fnKeep2();"><img src="../images/b_keep.gif" border="0"></a><%}%>
					<% if(pageFrom.equals("710")){%><a href="javascript:fnDelete();"><img src="../images/b_del.gif" border="0"></a>
					<%}else if(pageFrom.equals("720")){%><a href="javascript:fnDelete2();"><img src="../images/b_del.gif" border="0">
					<%}else if(pageFrom.equals("730")){%><a href="javascript:fnDelete3();"><img src="../images/b_del.gif" border="0"></a><%}%>

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