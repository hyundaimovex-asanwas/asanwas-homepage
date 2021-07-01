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
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="sales.common.StringUtil" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.menu.my.My210Manager" %>
<%@ page import="sales.menu.my.My020Manager" %>
<%@ page import="sales.common.HDCookieManager" %>
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
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
		<link href="test.css" rel="stylesheet" type="text/css">
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
	
</script>


<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td >



					<form name="form1" >
					<table width="867" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="427" align="center">
								
								 <input type="hidden" name="brd_no" value="">
								<table width="400" border="0" cellspacing="0" cellpadding="1">
									<tr>
										<td width="5">&nbsp;</td>
										<td width="310"><img src="<%=dirPath%>/Sales/images/notice.gif" width="61" height="14"></td>
										<td width="85" align="right" valign="bottom"><a href="<%=dirPath%>/Sales/my/my210s.jsp"><img src="<%=dirPath%>/Sales/images/more.gif" border="0"></a></td>
									</tr>
									<tr>
										<td colspan="3"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="400" height="2"></td>
									</tr>
			                        <% //공지사항
			                           if(data3 == null || data3.size() < 1 ) {
			                        %>
									<tr>
										<td height="114" align="center" valign="middle" colspan="3">해당 자료가 존재하지 않습니다.</td>
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
									<tr>
										<td height="19" align="center" valign="middle"><img src="<%=dirPath%>/Sales/images/dot.gif"></td>
										<td><a href="javascript:view_send('<%=bean3.get("brd_no")%>');"><%=bean3.get("brd_subject")%></a></td>
										<td align="center"> <%=bean3.get("brd_cdate")%> </td>
									</tr>
								   <%
			                           }
			                       }
								   %>									
								</table>
								
							</td>
							<td width="8">&nbsp; </td>
							<td width="420" align="center" valign="top">
								<table width="400" border="0" cellspacing="0" cellpadding="1">
									<tr>
									<td width="5">&nbsp;</td>
										<td width="310"><img src="<%=dirPath%>/Sales/images/mail.gif" height="14"></td>
										<td width="85" align="right" valign="bottom"><a href="<%=dirPath%>/Sales/my/my010s.jsp"><img src="<%=dirPath%>/Sales/images/more.gif" border="0"></a></td>
									</tr>
									<tr>
										<td colspan="3"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="400" height="2"></td>
									</tr>
			                        <% //받은편지함
//			                           if(data6 == null || data6.size() < 1 ) {
			                        %>
									<tr>
										<td height="114" align="center" valign="middle" colspan="3">해당 자료가 존재하지 않습니다.</td>
									</tr>			                        
			                        <%
			                        /*   }
			                           else {
			                              len6 = data6.size();
			                              if (len6>= view_cnt){
			                                 len6 = view_cnt;
			                              }
			                              bean6 = null;
			                              int tocnt = data6.size();
			                              for(int h=0; h<len6; h++) {
			                                 bean6 = (BaseDataClass)data6.get(h);*/
			                        %>			                        									
									<tr>
										<td height="19" align="center" valign="middle"><img src="<%=dirPath%>/Sales/images/dot.gif"></td>
										<td><a href="javascript:view_send4"><%//=bean6.get("brd_subject")%></a></td>
										<td align="center"> <%//=bean6.get("send_date")%> </td>
									</tr>
								   <%
			                       //    }
			                       //}
								   %>									
								</table>
							</td>
						</tr>
						<tr height=30>
							<td colspan=3><br><br>　<font color=blue>★ 기본권한 요청은 사번과 함께 박경국,심동현에게 팝업 보내주세요.<br>
							　☆ 필요한 메뉴 추가권한요청은 <b>홈>관광영업>관광시스템관리>메뉴관리>권한 요청</b>에서 해주세요.</font></td>
						</tr>

						<tr height=30>
							<td>　　<b>Download link ☞</b>　　　<a href="../file/Component.exe">ERP 사용을 위한 필수 컴포넌트 설치</a></td>
							<td></td>
							<td>　　<a href="../file/jwBrowser428.zip">ERP 사용이 편리한 JW멀티브라우져</a></td>
						</tr>
						<tr>
							<td height="20" colspan="3">　　<img src="<%=dirPath%>/Sales/images/upnote.gif"></td>
						</tr>
						<tr>
							<td height="30" colspan="3" align=right><jsp:include page="/Sales/common/include/updatenote.jsp" /></td>
						</tr>
					</table>
					
						<input type="hidden" name="actId" value="">
						<input type="hidden" name="process_flag" value="">
						
					</form>




           
			</td>
		</tr>
	</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

<%
	} catch (Exception e) {
		e.printStackTrace(); 
	}
%>