<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 통신문관리 메세지 발송.
 * 프로그램ID 	: cu110b
 * J  S  P		: cu110b.jsp
 * 서 블 릿		: 
 * 작 성 자		: 심동현
 * 작 성 일		: 2006-07-27
 * 기능정의		 : 관광객에 메세지 발송
 * 				      메세지를 발송하는 페이지는 외부SMS 모듈 처리를 위해 windwos서버에 ASP로 되어 있음.
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
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
		/* 페이지로딩 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출
		}
		 
		function fnInit() {
		}
		
		</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td>
				<iframe src="http://com.hdasan.com/cSMS_f1.asp" 
						frameborder="0" marginWidth=0 marginHeight=0 width="845" height="450" scrolling="no" name="myEditor">
				</iframe>
			</td>
		</tr>
	</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

