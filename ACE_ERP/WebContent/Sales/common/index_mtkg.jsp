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
   ArrayList data3 = new ArrayList(); //공지사항
   ArrayList data4 = new ArrayList(); //고객문의
   ArrayList data5 = new ArrayList(); //대리점문의
   ArrayList data6 = new ArrayList(); //받은편지함
   SmartRequest sr3 = new SmartRequest(request);
   int view_cnt = 6;                  //보여질 게시물 갯수
   
   String where_sql3     = "";
   String brd_gu = "";
   String out_login_id = "nkp0908";

   int len3 = 0;
   int len4 = 0;
   int len5 = 0;
   int len6 = 0;
   BaseDataClass bean3;
   BaseDataClass bean4;
   BaseDataClass bean5;
   BaseDataClass bean6;

   My020Manager manager4 = new My020Manager();
   My210Manager manager3 = new My210Manager();
   brd_gu = "01";
   sr3.setObject("brd_gu",(Object)brd_gu);
   data3 = manager3.list(sr3);
   
   brd_gu = "02";
   sr3.setObject("brd_gu",(Object)brd_gu);
   data4 = manager3.mainlist(sr3);

   brd_gu = "03";
   sr3.setObject("brd_gu",(Object)brd_gu);
   data5 = manager3.mainlist(sr3);
   
   sr3.setObject("out_login_id",(Object)out_login_id);
   data6 = manager4.list(sr3);
   
   manager3.close();	
   manager4.close();
   
   // 새로만든거 메인용 
   
   String servletPath = "/servlet/sales.common.my.BaseServlet";
   
   
  	My120I m120 = new My120I();
 	
  	ArrayList data1 = m120.main_select(request, response);
  	
	BaseDataClass param = (BaseDataClass)request.getAttribute("PARAM");
   %>







<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
		<link href="test.css" rel="stylesheet" type="text/css">
		<link href="<%=dirPath%>/Sales/common/include/common.css" rel="stylesheet" type="text/css">
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
<script language="javascript">
	/* 페이지로딩 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
	};
		 
	function fnInit() {
	};

		
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
					<table width="867" border=0 cellspacing="0" cellpadding="0" bordercolor=blue>
						<tr>
							<td width="427" align="center">	</td>
							<td width="8">&nbsp; </td>
							<td width="420" align="center" valign="top"></td>
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
							<td height="30" colspan="3" align=right><jsp:include page="/Sales/common/include/updatenote04.jsp" /></td>
						</tr>
					</table>
           
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