<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	     : 프로그램 정보
 * 프로그램ID 	 : 
 * J  S  P		 : body_s.jsp 페이지 시작용
 * 서 블 릿		 : -
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2007-07-24
 * 기능정의		 : 전체 페이지 시작 부분 (헤더와 메뉴 포함)
 * [수  정   일  자][수정자] 내용
 * [2007-09-11][심동현] 타이틀 바에  메뉴명, 경로명 스크립트 완료
 * [2008-01-17][심동현] 로딩 표시용 iFrame 삽입
 *****************************************************************************/
%>
<!--------------------------------- BODY Start ------------------------------->		
<%
	String dirPath = request.getContextPath();
%>
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	onLoad="fnOnLoad();">

	<!--  loading file 상태바 플레쉬  -->
	<iframe id="loadingBar" 
			name="loadingBar" 
			style="display:none; position:absolute;left: expression((document.body.clientWidth - 402)/2);top: expression((document.body.clientHeight - 148)/2);z-index:9" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/include/loadingSales.jsp" 
			width="402px" 
			height="148px">
	</iframe>
	
		<table width="1000" height="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="123" valign="top"><!--// ?????-->
				<jsp:include page="/Sales/common/include/left_mn1.jsp" flush="true"/>
				<%//@include file="/Sales/common/include/left_mn1.jsp"%></td>  <!--//이건 오류인듯-->
				<td valign="top"><!--// ????? --> 
				<jsp:include page="/Sales/common/include/top_mn.jsp" flush="true"/>
				<%//@include file="/Sales/common/include/top_mn.jsp"%></td>
			</tr>
			<tr>
			    <td height="10"></td>
			</tr>    
			
<!-- 컨텐츠 BODY START --> 			
			<tr>
				<td align="center" valign="top">
					<table width="845" border="0" cellspacing="0" cellpadding="0">
                       <tr> 
                         <td>
                         	<table width="845px">
                         		<tr>
                         			<td>
                         			<jsp:include page="/Sales/common/include/title.jsp" flush="true"/>
                         				<%//@include file="/Sales/common/include/title.jsp"%> 
                         			</td>
                         		</tr>
                         	</table>
                         </td>
                       </tr>
						<tr>
							<td height="10px"></td>
						</tr>
						<tr> 
							<td>