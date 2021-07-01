<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 인덱스_관광영업
 * 프로그램ID 	: index_sales
 * J  S  P		: index_sales.jsp
 * 서 블 릿		: 
 * 작 성 자		: 심동현
 * 작 성 일		: 2006-09-14
 * 기능정의		: 트리메뉴 적용한 새 관광영업 메인화면
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2010-08-19][심동현] 새로운 초기화면. 메세지 적용, 결재목록 적용
 * [2010-09-07][심동현] 미결함 표시 
 * [2011-08-01][심동현] 쿠키에서 세션으로 변경.
 * [2013-10-21][심동현] 13 재구성-실행 이전
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="sales.common.HDUtil" %>
<%@ page import="sales.common.HDConstant" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="sales.common.StringUtil" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>


<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>
<%// local ServerScript
	// 현대아산 직원, 대리점/협력업체 구분
	// Value = ERP, Value=Tour
	// ERP인 경우 = 
	
try {
	
	
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
		<link href="<%=dirPath%>/Sales/common/include/common.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="<%=dirPath %>/Sales/common/include/menu_click.js"></script>
		<script language="javascript" src="<%=dirPath%>/Sales/common/include/menu.js"></script>
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
<script language="javascript">
	/* 페이지로딩 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
	}
	 
	function fnInit() {
	}

	/* 공지사항 */
	function view_send(brd_no){

		var f = document.form1;
		f.action="<%=dirPath%>/Sales/my/my210_read.jsp?idx=404";
		f.brd_no.value = brd_no;
		f.method = "POST";
		f.target="";
		
		f.submit();
	} 
	/* 받은 쪽지함 */
   function view_send4(brd_no,ref,ref_step){
		var readURL ="<%=dirPath%>/Sales/my/my710_read_pop.jsp?pageFrom=710&idx=400&brd_no="+brd_no+"&ref="+ref+"&ref_step="+ref_step;
	   	window.open(readURL,"memoRead_from","width=480,height=450,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize");
   }
	
	/* 결재할 문서 */
	function view_send_ap(ap_m_sid){
		var f = document.form1;
		f.action="<%=dirPath%>/Sales/my/my400s.jsp?idx=591";
		f.ap_m_sid.value = ap_m_sid;
		f.method = "POST";
		f.target="";
		
		f.submit();
	}
	
	
</script>


<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
</head>

<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/><%//관광%>
<!--------------------------------- 코딩 부분 시작 ------------------------------->	


					<form name="form1" >
					<table width="867" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="300" align="center" valign="top">
							
								
							</td>
							<td width="8">&nbsp; </td>
							<td width="310" align="center" valign="top">
								
							</td>
							<td width="8">&nbsp; </td>
							<td width="241" valign=top>
								
							</td>							
						</tr>
					

						<tr>
							<td height="30" colspan="5" align=left><jsp:include page="/Common/un/updatenote10.jsp" /></td>
						</tr>
					</table>
						<input type="hidden" name="brd_no" value="">
						<input type="hidden" name="actId" value="">
						<input type="hidden" name="process_flag" value="">
						<input type="hidden" name="ap_m_sid" value="">
						
					</form>


<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>


<%
	} catch (Exception e) {
		e.printStackTrace(); 
	}
%>