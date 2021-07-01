
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
<%@ page import="sales.menu.my.My210Manager" %>
<%@ page import="sales.menu.my.My710Manager" %>
<%@ page import="sales.menu.my.My400Manager" %>
<%@ page import="sales.menu.my.My120I" %>
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
	//공지사항 부르기
	SmartRequest sr3 = new SmartRequest(request);
	
		String key 			= HDUtil.nullCheckStr(request.getParameter("search_key"));
		String values 		= HDUtil.nullCheckStr(request.getParameter("search_value"));
		String requestedPage = HDUtil.nullCheckStr(request.getParameter("requestedPage"));
		String pageSize  	= "10";  	//1페이지에 표시될 개수
		String where_sql3     = "";
		int	view_cnt=6;
	
		//조건절 만들기.
		if (values !=  null && !values.equals("")){	
	    	where_sql3=" AND " + key + " like '%" + values + "%'";
		}
	   	where_sql3 = "";	// 임시 기본값 세팅
	   
		ArrayList data3 = new ArrayList();	//게시물 리스트를 받아올 것 생성.
		int len3 = 0;
		String brd_gu = "01";	//보드 구분~!
		BaseDataClass bean3;
	
		ArrayList data_all = new ArrayList();	//게시물 전체 카운트를 받아올 것 생성.     
		
	
		sr3.setObject("where_sql",(Object)where_sql3);	//조건절 세팅
		sr3.setObject("brd_gu",(Object)brd_gu);			//보드 구분 세팅
		sr3.setObject("requestedPage",(Object)requestedPage);			//요청페이지 세팅
		sr3.setObject("pageSize",(Object)pageSize);			//페이지 사이즈 세팅
	
		My210Manager manager3 = new My210Manager();
		//data3 		= manager3.list(sr3);		//화면에 표시될 리스트 불러오기.
		manager3.close();
	//공지사항 끝 //////////////////////////////////////////////////////////////////


	//쪽지함 시작 //////////////////////////////////////////////////////////////////
	SmartRequest sr4= new SmartRequest(request);

		String v_login_name ="";
		String v_login_id = "";
		v_login_id = (String)session.getAttribute("vusrid"); 
		v_login_name = (String)session.getAttribute("vusrnm");
	
		key 		 = sr4.getString("search_key");
		values 		 = sr4.getString("search_value");
		// 결국 한글을 받아오면서 깨지는 것이 문제입니다. ㅠ_ㅠ;; 움..
		// 멀티파트로 보내니 된다!
		requestedPage = sr4.getString("requestedPage");
		pageSize  	 = "6";  	//1페이지에 표시될 개수
		String where_sql4    = "";
	

	   
		ArrayList data4 = new ArrayList();	//게시물 리스트를 받아올 것 생성.
		int len4 = 0;
		brd_gu = "01";	//보드 구분~!
		BaseDataClass bean4;
	
		
		ArrayList data_all4 = new ArrayList();	//게시물 전체 카운트를 받아올 것 생성.     
		
		//이부분을 해줘야 매니저파일에서 sr.getObject()로 읽어올 수 있다.
		sr4.setObject("where_sql",(Object)where_sql3);	//조건절 세팅
		sr4.setObject("brd_gu",(Object)brd_gu);			//보드 구분 세팅
		sr4.setObject("requestedPage",(Object)requestedPage);	//요청페이지 세팅
		sr4.setObject("pageSize",(Object)pageSize);			//페이지 사이즈 세팅
		sr4.setObject("search_key",(Object)key);			//페이지 사이즈 세팅
		sr4.setObject("v_login_id",(Object)v_login_id);		//로긴 아이디 셋팅 
		sr4.setObject("v_login_name",(Object)v_login_name);		//로긴 이름 셋팅 
		
		My710Manager manager4 = new My710Manager();
		//data4 		= manager4.list(sr4);		//화면에 표시될 리스트 불러오기.
		//data_all4 	= manager4.alllist(sr4);	//해당 조건의 전체 게시물 숫자 카운트해오기
		manager4.close();
	
	//쪽지함 끝//////////////////////////////////////////////////////////////////////


	//미결함 시작 //////////////////////////////////////////////////////////////////
	SmartRequest sr_ap= new SmartRequest(request);	

		requestedPage = "1";
		pageSize  	 = "6";  	//1페이지에 표시될 개수
//		String where_sql4    = "";
	   
		ArrayList data_ap = new ArrayList();	//게시물 리스트를 받아올 것 생성.
		int len_ap = 0;
		BaseDataClass bean_ap;
	
		//이부분을 해줘야 매니저파일에서 sr.getObject()로 읽어올 수 있다.
//		sr4.setObject("where_sql",(Object)where_sql3);	//조건절 세팅
//		sr4.setObject("brd_gu",(Object)brd_gu);			//보드 구분 세팅
		sr_ap.setObject("requestedPage",(Object)requestedPage);	//요청페이지 세팅
		sr_ap.setObject("pageSize",(Object)pageSize);			//페이지 사이즈 세팅
//		sr4.setObject("search_key",(Object)key);			//페이지 사이즈 세팅
		sr_ap.setObject("v_login_id",(Object)v_login_id);		//로긴 아이디 셋팅 
		
		My400Manager manager_ap = new My400Manager();
		//data_ap		= manager_ap.list(sr_ap);		//화면에 표시될 리스트 불러오기.
		manager_ap.close();
	
	//미결함 끝//////////////////////////////////////////////////////////////////////
	
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