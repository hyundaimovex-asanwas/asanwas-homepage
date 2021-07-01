
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 포털_정보보호
 * 프로그램ID 	: portal_sub09
 * J  S  P		: portal_sub09.jsp
 * 서 블 릿		: 
 * 기능정의		: 트리메뉴 적용한 새 정보보호 포털
 * [ 수정일자 ][수정자] 내용
 * [2011-10-17][심동현]
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
		data3 		= manager3.list(sr3);		//화면에 표시될 리스트 불러오기.
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
		data4 		= manager4.list(sr4);		//화면에 표시될 리스트 불러오기.
		data_all4 	= manager4.alllist(sr4);	//해당 조건의 전체 게시물 숫자 카운트해오기
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
		data_ap		= manager_ap.list(sr_ap);		//화면에 표시될 리스트 불러오기.
		manager_ap.close();
	
	//미결함 끝//////////////////////////////////////////////////////////////////////
	
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Security/common/include/head.jsp"/>
		<link href="<%=dirPath%>/Security/common/include/common.css" rel="stylesheet" type="text/css">
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

<jsp:include page="/Common/sys/body_s09.jsp"  flush="true"/><%//관광%>
<!--------------------------------- 코딩 부분 시작 ------------------------------->	


					<form name="form1" >
					<table width="867" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="300" align="center" valign="top">
								<table width="300" border="0" cellspacing="0" cellpadding="1">
									<tr>
										<td width="5">&nbsp;</td>
										<td width="210"><b>＊공지사항</b></td>
										<td width="85" align="right" valign="bottom"><a href="<%=dirPath%>/Sales/my/my210s.jsp"><img src="<%=dirPath%>/Sales/images/more.gif" border="0"></a></td>
									</tr>
									<tr>
										<td colspan="3"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="300" height="2"></td>
									</tr>
			                        <% //공지사항
			                           if(data3 == null || data3.size() < 1 ) {
			                        %>
									<tr>
										<td height="60" align="center" valign="middle" colspan="3">해당 자료가 존재하지 않습니다.</td>
									</tr>			                        
			                        <%
			                           }
			                           else {
			                              len3 = data3.size();
			                              if (len3>= view_cnt){
			                                 len3 = view_cnt;
			                              }
			                              bean3 = null;
			                              int tocnt = data3.size();
			                              for(int h=0; h<len3; h++) {
			                                 bean3 = (BaseDataClass)data3.get(h);
			                        %>			                        									
									<tr height="19">
										<td align="center" valign="middle"><img src="<%=dirPath%>/Sales/images/dot.gif"></td>
										<td><a href="javascript:view_send('<%=bean3.get("brd_no")%>');">
											<%=StringUtil.cut(StringUtil.strReplace(bean3.get("brd_subject"), "<br>", "") ,17)%></a></td>
										<td align="center"> <%=bean3.get("brd_cdate")%> </td>
									</tr>
								   <%
			                           }
			                       }
								   %>									
								</table>
								
							</td>
							<td width="8">&nbsp; </td>
							<td width="310" align="center" valign="top">
								<table width="310" border="0" cellspacing="0" cellpadding="1">
									<tr>
										<td width="15">&nbsp;</td>
										<td width="220" colspan=2><b>＊받은 쪽지함</b></td>
										<td width="65" align="right" valign="bottom"><a href="<%=dirPath%>/Sales/my/my710_list.jsp?idx=398"><img src="<%=dirPath%>/Sales/images/more.gif" border="0"></a></td>
									</tr>
									<tr>
										<td colspan="4"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="300" height="2"></td>
									</tr>
			                        <% //받은편지함
			                           if(data4 == null || data4.size() < 1 ) {
			                        %>
									<tr>
										<td height="60" align="center" valign="middle" colspan="4">해당 자료가 존재하지 않습니다.</td>
									</tr>			                        
			                        <%
			                        	}else {
			                              len4 = data4.size();
			                              bean4 = null;
											for(int h=0; h<len4; h++) {
			                                 	bean4 = (BaseDataClass)data4.get(h);
			                        %>			                        									
									<tr height=19>
										<td valign=middle>
											<% if(Integer.parseInt(bean4.get("brd_viewcnt"))>0){ %>
												<img src="http://static.naver.com/pwe/note/ico_note_off.gif" border="0">
											<%}else{%>
										  		<img src="http://static.naver.com/pwe/note/ico_note_on.gif" border="0">
										  	<%}%>
										</td>
										<td width=110 align=center><%=bean4.get("brd_creator")%>(<%=bean4.get("brd_creator_name")%>)</td>
										<td width=120><a href="javascript:view_send4('<%=bean4.get("brd_no")%>','<%=bean4.get("ref")%>','<%=bean4.get("ref_step")%>');">
								       	<%=StringUtil.cut(StringUtil.strReplace(bean4.get("brd_contents"), "<br>", "") ,10)%></a></td>
										<td align="center"><%=StringUtil.substrToStart(bean4.get("brd_cdate"),"[")%></td>
									</tr>
								   <%
			                           		}
			                       		}
								   %>									
								</table>
							</td>
							<td width="8">&nbsp; </td>
							<td width="241" valign=top>
								<table width="210" border="0" cellspacing="0" cellpadding="1">
									<tr>
										<td width="5">&nbsp;</td>
										<td width="65"><b>＊결재할</b></td><!-- 구분-->
										<td width="70"><b> 문서</b></td><!-- 기안자-->
										<td width="70" align="right" valign="bottom"><a href="<%=dirPath%>/Sales/my/my400i.jsp?idx=591"><img src="<%=dirPath%>/Sales/images/more.gif" border="0"></a></td>
									</tr>
									<tr>
										<td colspan="4"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="210" height="2"></td>
									</tr>
			                        <% //＊결재함
			                           if(data_ap == null || data_ap.size() < 1 ) {
			                        %>
									<tr>
										<td height="60" align="center" valign="middle" colspan="4">해당 자료가 존재하지 않습니다.</td>
									</tr>			                        
			                        <%
			                        	}else {
			                              len_ap = data_ap.size();
			                              bean_ap = null;
											for(int h=0; h<len_ap; h++) {
			                                 	bean_ap = (BaseDataClass)data_ap.get(h);
			                        %>			                        									
									<tr height=19>
										<td align="center" valign="middle"><img src="<%=dirPath%>/Sales/images/dot.gif"></td>
										<td align=center onclick="view_send_ap(<%=bean_ap.get("ap_m_sid")%>)" style="cursor:hand;"><%=bean_ap.get("doc_gu_nm")%></td>
										<td align=center onclick="view_send_ap(<%=bean_ap.get("ap_m_sid")%>)" style="cursor:hand;"><%=bean_ap.get("i_empnm")%></td>
										<td align="center" onclick="view_send_ap(<%=bean_ap.get("ap_m_sid")%>)" style="cursor:hand;"><%=bean_ap.get("i_date")%></td>
									</tr>
								   <%
			                           		}
			                       		}
								   %>									
								</table>							
							</td>							
						</tr>
						<tr height=30>
							<td colspan=5><br><br>　<font color=blue>★ [관광영업] 기본권한 요청은 사번과 함께 박경국,정하나SW에게 팝업 보내주세요.<br>
							　☆ 기본권환 외의 필요한 메뉴의  추가 권한요청은 <b>홈>관광영업>관광시스템관리>메뉴관리>권한 요청</b>에서 해주세요.</font></td>
						</tr>

						<tr height=30>
							<td colspan=5>　　<b>Download link ☞</b>　　　<a href="../file/Component.exe">ERP 사용을 위한 필수 컴포넌트 설치</a>　　<a href="../file/jwBrowser428.zip">ERP 사용이 편리한 JW멀티브라우져</a></td>
						</tr>
						<tr>
							<td height="30" colspan="5" align=left><jsp:include page="/Common/un/updatenote09.jsp" /></td>
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