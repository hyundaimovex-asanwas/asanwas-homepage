<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 		: 리서치 공지사항 
 * 프로그램ID 	: SY710(코드는 대문자)
 * J  S  P		: sy710h (jsp파일명은 소문자로 한다 )
 * 서 블 릿		: 
 * 작 성 자		: 정하나
 * 작 성 일		: 2011-03-07
 * 기능정의		: 
 * 수정내용		: 
 * 수 정 자		:
 * 최종수정일자 	: 
 *
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>공지사항 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;</title>
		<link href="<%=dirPath%>/Sales/common/include/common.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="<%=dirPath%>/Sales/common/include/embedControl.js"></script>
<%
	/***************************************************************************
	 *                            사용자 정의 Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  선조회
%>
			function fnSelect() {
				if (sKeyWord.value==""){
				alert("동(읍/면/리)으로 검색하세요!");
				}
				else{fnSubSelect1();}
			}
			// 각각 다른것을 조회힌다 
			function fnSubSelect1() {
			
				ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy002H?dsType=1&proType=S&sKeyWord="+sKeyWord.value;
				ds1.Reset();
			}
		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  팝업창 닫기
// Parameter 	: A - 선택
%>
			function fnClose(p){
				if (p=="A") {
					var row = ds1.rowposition;
					window.returnValue = ds1.namevalue(row, "zip_cd") + ";" +
								 ds1.namevalue(row, "ADDRESS") + ";" + 
								 ds1.namevalue(row, "ZIP_SID")  ;
				window.close();
				} else {
					window.close();
				}
			}
		</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회중 
%>	
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			ft_cnt1.innerText="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			ft_cnt1.innerText="Cnt : " + row;
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 오류 
%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  그리드 더블클릭 이벤트 발생
//              :  우편번호 Opener에 선택된 우편번호 등록 
%>			
		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			var row = ds1.rowposition;
			
			
			window.returnValue = ds1.namevalue(row, "zip_cd") + ";" +
								 ds1.namevalue(row, "ADDRESS") + ";" +
								 ds1.namevalue(row, "ZIP_SID") ;
			window.close();
		</script>
		<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
  			
            if (keycode == 13) {
            	window.returnValue = ds1.namevalue(ds1.rowposition, "zip_cd") + ";" +
								 ds1.namevalue(ds1.rowposition, "ADDRESS") + ";" +
								 ds1.namevalue(ds1.rowposition, "ZIP_SID") ;
				window.close();
            }
		</script>
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>	
		<object id="ds1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
			<param name="SyncLoad" value="false">
		</object>
<%
/*=============================================================================
			Transaction Components(TR) 선언
=============================================================================*/
%>
		<object id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
			<param name="KeyName" value="toinb_dataid4">
		</object>
	</head>
<!--------------------------------- BODY START ------------------------------->
	<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<table>
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:219px;">
						<tr>
							<td colspan=2 height=25>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">안내</font>
							</td>
						</tr>
					</table>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:495px;">
						<tr>
							<td>
										임직원 여러분들의 성원에 힘입어 지난 2.28 마감된 주택사업 브랜드 공모에 총 204건 <br> (중복 제외)이 취합되었습니다. 
										아래와 같이 임직원 온라인 투표를 통해 주택사업 브랜드를 선정할 예정이오니 많은 참여 바랍니다.<br><br>
							</td>
						</tr>			
						<tr>
						    <td align=center>- 아    래 - <br><br> </td>
						 </tr>
						 <tr>
							<td >			
										         1. 1차 임직원 온라인 투표 (예선)  <br>
										          - 기  간 : 3.9~11 (3일간) <br>
										          - 204개의 공모작을 65개 내외 3개 항목으로 분류 <br>
										          - 항목당 개인별 3표씩 투표 가능 <br>
										          - 항목별 다득표 순에 따라 후보군 선정<br><br><br>
										
										         2. 2차 임직원 온라인 투표 (본선) <br>
										          - 기  간 : 3.15~17 (3일간) <br>
										          - 예선을 통과한 본선 진출 후보군 <br>
										          - 개인별 1표씩 투표 가능 <br>
										          - 다득표 순에 따라 상위 3개 선정<br>
							</td>
						</tr>
					</table>					
				</td>
			</tr>
		</table>
			</tr>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
			<tr>
				<td>
				</td>
			</tr>
			<tr>
				<td>
				<!--  상태바 플레쉬  -->
			<iframe id="LowerFrame" 
				name="work" 
				style="visibility:hidden; position:absolute; left:100px; top:150px;" 
				Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.swf" 
				width="320px" 
				height="42px">
			</iframe>	
			</td>
			</tr>
		</table>
	</body>
<!--------------------------------- BODY E N D ------------------------------->
</html>