<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 동정보등록
 * 프로그램ID 	: RM020I
 * J  S  P		: rm020i
 * 서 블 릿		: Rm020I
 * 작 성 자		: 구자헌
 * 작 성 일		: 2006-06-08
 * 기능정의		: 동정보등록(조회 등록 삭제 수정)
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

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>

<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>		
		<script language="javascript">
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  페이지 로딩 
// Parameter 	: 
%>
	function fnOnLoad(tree_idx){
//		fnInit_tree(tree_idx);	//트리초기화 호출
//		fnInit();
	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: 선조회 
// Parameter 	: 
%>
	function fnInit(){
	        cfStyleGrid(getObjectFirst("gr1"), "comn");
	}
</script>

</head>                                                                                 
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>                              
                                                                                        
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
							
<table border="0" cellpadding="0" cellspacing="0" width="100%" bordercolor=orange> 
  <tr>
  	<td>
		<table width="400px" cellpadding="0" cellspacing="0" border="0">
		  <tr> 
			<td style="width:70px;height:30px;border:1 solid #708090;" bgcolor="#eeeeee" align=center class="txtbox">동코드</td>
			<td style="border:1 solid #708090;border-left-width:0px">&nbsp;
				<input id="txt_dong_cd" type="text" class="textbox"  style= "position:relative;left:0px;top:0px;width:100px; height:18px;" maxlength="2">
			</td>
			<td style="width:70px;height:30px;border:1 solid #708090;border-left-width:0px" bgcolor="#eeeeee" align=center class="txtbox">동이름</td>
			<td style="border:1 solid #708090;border-left-width:0px">&nbsp;
				<input id="txt_dong_nm" type="text" class="textbox"  style= "position:relative;left:0px;top:0px;width:100px; height:18px;" maxlength="30">
			</td>
		  </tr>
		</table>
  	</td>
  </tr>
</table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	
                                                                                    
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		                    
                                                                                    