<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 전체 메뉴 조회 및 권한 요청!
 * 프로그램ID  	: SY140I
 * J  S  P   	: Sy140i
 * 서 블 릿     : Sy120I
 * 작 성 자     : 차태주
 * 작 성 일     : 2006-09-10
 * 기능정의     : 메뉴조회 권한 요청
 * [ 수정일자 ][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
        <script language=javascript src="<%=dirPath%>/Sales/common/js/cu010i.js"></script>
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>	

<style type="text/css">
<!--
	td
	{
		font:9pt 굴림;
		line-height: 160%;
	}
	th
	{
		font:9pt 굴림;
		line-height: 160%;
	}
	A:link     {font: bold 9pt "굴림 new"; color:#5A8AAD; text-decoration:none}
	A:active   {font: bold 9pt "굴림 new"; color:#36618A; text-decoration:none}
	A:visited  {font: bold 9pt "굴림 new"; color:#36618A; text-decoration:none}
	A:hover    {font: bold 9pt "굴림 new"; color:#36618A; text-decoration:none}
	.input
	{
		BACKGROUND-COLOR: #ffffff;
		BORDER-BOTTOM: #999999 1px solid;
		BORDER-LEFT: #999999 1px solid;
		BORDER-RIGHT: #999999 1px solid;
		BORDER-TOP: #999999 1px solid;
		COLOR: #999999;
		FONT-SIZE: 9pt
	}
//-->
</style>
<script language=javascript>
	function fnOnLoad(tree_idx)
	{
		fnInit_tree(tree_idx);	//트리초기화 호출
	}

	function popup(url)
	{
		var nWidth= 1024;
		var nHeight = 680;
		var sw = screen.availWidth;
		var sh = screen.availHeight;
		var px = (sw - nWidth) / 2;
		var py = (sh - nHeight) / 2;
		window.open(url,'','width='+nWidth+',height='+nHeight+',scrollbars=no,toolbars=no,menubars=0,top = ' + py + ', left = ' + px);
	}
	
	function devMsg()
	{
	  alert("개발 진행중인 차시입니다.");
	}
	
</script>

</head>
<jsp:include page="/Common/sys/body_s03.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<table width="620"  border="0" align="center" cellpadding="3" cellspacing="5">
  
  <tr> 
    <td colSpan="2" height="30" align="center"><FONT SIZE="2" COLOR="#0099cc">&nbsp; 
      </font></td>
  </tr>
  <tr> 
    <td colSpan="2" height="30" align="center" bgcolor="#F7FAFD"><FONT SIZE="2" COLOR="#0099cc"> 
      <b><font color="#333333">김책임과 함께하는 개인정보보호 따라하기</font></b></FONT></td>
  </tr>
  <tr> 
    <td bgColor="#69AFDA" colSpan="2" height="2"></td>
  </tr>
  <tr align="center" valign="middle"> 
    <td height="10"></td>
    <td></td>
  </tr>
  <tr>
  <td height="30" bgcolor="#F7FAFD" align="center" colSpan="2" >
		<table cellpadding="4" cellspacing="1" border="0"  bgcolor="#D8D8D8" width="100%">
			<tr  align="center" class="css3">
				<Td  height=25 colspan=3 bgcolor="#E8F3FF"   class="table"><b>Topic</b></td>
			</TR>
			<tr align="center" class="css3">	
				<TD width=10% height=23 align=center bgcolor="#F2F2F2">1</TD>
				<TD align="left" bgcolor="white"><b><A href="javascript:popup('01/0101.htm');">&#160;아하!, 개인정보보호가 이런 거구나</a></b></TD>
			</TR>
			<tr align="center" bgcolor="#F2F2F2" class="css3">
						<TD width=10% height=23 align=center bgcolor="#F2F2F2">2</TD>
						<TD align="left" bgcolor="white"><b><A href="javascript:popup('02/0201.htm');">&#160;이젠, 담당자의 역할과 주요업무를 바로 알자</a></b></TD>	
			</TR>
			<tr align="center" bgcolor="#F2F2F2" class="css3">
						<TD width=10% height=23 align=center bgcolor="#F2F2F2">3</TD>
						<TD align="left" bgcolor="white"><b><A href="javascript:popup('03/0301.htm');">&#160;올바른 개인정보를 수집할 수 있는 7가지 DNA를 찾자!</a></b></TD>	
			</TR>
			<tr align="center" bgcolor="#F2F2F2" class="css3">
						<TD width=10% height=23 align=center bgcolor="#F2F2F2">4</TD>
						<TD align="left" bgcolor="white"><b><A href="javascript:popup('04/0401.htm');">&#160;효과적인 개인정보 이용 방법을 알아보자!</a></b></TD>	
			</TR>
			<tr align="center" bgcolor="#F2F2F2" class="css3">
						<TD width=10% height=23 align=center bgcolor="#F2F2F2">5</TD>
						<TD align="left" bgcolor="white"><b><A href="javascript:popup('05/0501.htm');">&#160;개인정보 업무제휴와 아웃소싱의 핵심을 꿰뚫자!</a></b></TD>	
			</TR>
			<tr align="center" bgcolor="#F2F2F2" class="css3">
						<TD width=10% height=23 align=center bgcolor="#F2F2F2">6</TD>
						<TD align="left" bgcolor="white"><b><A href="javascript:popup('06/0601.htm');">&#160;사용한 개인정보 깨끗이 파기하자!</a></b></TD>	
			</TR>
			<tr align="center" bgcolor="#F2F2F2" class="css3">
						<TD width=10% height=23 align=center bgcolor="#F2F2F2">7</TD>
						<TD align="left" bgcolor="white"><b><A href="javascript:popup('07/0701.htm');">&#160;고객의 개인정보 소중하게 보호하자!</a></b></TD>	
			</TR>
			<tr align="center" bgcolor="#F2F2F2" class="css3">
						<TD width=10% height=23 align=center bgcolor="#F2F2F2">8</TD>
						<TD align="left" bgcolor="white"><b><A href="javascript:popup('08/0801.htm');">&#160;고객의 요구, 신속하게 대응하자!</a></b></TD>	
			</TR>

		</TABLE>
	</td>
  </tr>
  <tr align="center" valign="middle"> 
    <td height="15"></td>
    <td></td>
  </tr>
  <tr align="center" valign="middle">
  <td height="55" valign="top" colSpan="2" >  각 차시명을 클릭하시면 해당 차시의 과정이 실행됩니다.</td>

  </tr>
  <tr align="center" valign="middle">
    <td height="51"></td>
    <td></td>
  </tr>
</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		








