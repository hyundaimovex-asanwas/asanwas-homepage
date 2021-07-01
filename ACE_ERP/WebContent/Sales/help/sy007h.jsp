<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 	: 영업담당자 Help 
 * 프로그램ID 	: SY005H (코드는 대문자)
 * J  S  P		: sy005h (jsp파일명은 소문자로 한다 )
 * 서 블 릿		: Sy005H
 * 작 성 자		: 구자헌
 * 작 성 일		: 2006-06-05
 * 기능정의		: 영업담당자 조회 
 * 수정내용		: 2006-05-09 : XXXXX 발주 XXXXX 수정요청 (완료/미완료)
 * 수 정 자		: 구자헌
 * [수정  일자][수정자] 내용
 * [2008-04-03][심동현] 로딩바/스타일
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
		<title>사용자 조회　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>

<%
	/***************************************************************************
	 *                            사용자 정의 Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">		
			// 페이지 로딩
			function fnOnLoad(){
		        cfStyleGrid(getObjectFirst("gr1"), "comn");
		        			
				var strParam = new Array();
				strParam=window.dialogArguments;

				if(strParam[0]!=null) { //사번
					txt_empno.value=strParam[0];
				}else {
				}
				if(strParam[1]!=null) { //이름
					txt_empnm.value=strParam[1];
				}else {
				}
			}

			// 메인 조회
			function fnSelect() {
				ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy007H?proType=S&dsType=1"
							+ "&s_empnm=" + txt_empnm.value;
				ds1.Reset();
			}
			
			function fnAdd() {
				var row = ds1.rowposition;
			
				window.returnValue = ds1.namevalue(row, "uID") + ";" +
								 	ds1.namevalue(row, "uName");			 	fnClose();
			}
			
			function fnClose() {
				window.close();
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
			fnShowLoading(410,180);
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			ft_cnt1.innerText="Cnt : " + row;
			fnHideLoading();
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 오류 
%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			fnHideLoading();
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  그리드 더블클릭 이벤트 발생
//
%>			
		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			var row = ds1.rowposition;			
			
				window.returnValue = ds1.namevalue(row, "uID") + ";" +
								 	ds1.namevalue(row, "uName");
			window.close();
		</script>
		
		<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
  			
            if (keycode == 13) {
            	fnAdd();
            }
		</script>
		
<!-----------------------------------------------------------------------------
                                DataSet Components 선언 
# 조회를 할 경우 사용한다. 
------------------------------------------------------------------------------->
		<%=HDConstant.COMMENT_START%>
		<object id="ds1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
			<param name="SyncLoad" value="false">
		</object>
		<%=HDConstant.COMMENT_END%>

	</head>	
	
<!--  BODY START -->
<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">


	<!--  loading file 상태바 플레쉬  -->
	<iframe id="loadingBar" 
			name="loadingBar" 
			style="display:none; position:absolute;z-index:9;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/include/loadingSales.jsp">
	</iframe>
		<table>
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:219px;">
						<tr>
							<td colspan=2 height=25>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:70;height:15;">사용자</font>
								<input type="hidden" id="txt_empno" style="width:50;position:relative;top:2px;border:0;" readonly>
							</td>
						</tr>
						<tr>
							<td class="text" width="80px" height="30" style="border:1 solid #708090">사용자명</td>
							<td width="110px" style="border:1 solid #708090;border-left-width:0px">
								<input type="text" id="txt_empnm" name="txt_empnm" class="textbox" style="position:relative;left:8px;width:100px;" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
							</td>
						</tr>
					</table>
				</td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px">
						<tr>
							<td align=right><img src="<%=dirPath%>/Sales/images/p_find.gif" alt="코드/명을 검색합니다" style="position:relative;left:8px;top:0px;cursor:hand;" onclick="fnSelect();">
							    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnAdd()">                            
							    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnClose()">                          
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>


		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
			<tr>
				<td>
<%
/*---------------------------------------------------------------------------->
	Object ID 	: 그리드 , gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>
					<comment id="__NSID__"><object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=479px; height:248px;border:1 solid #777777;">
						<param name="DataID"		value="ds1">
						<param name="BorderStyle" 	value="0"> 
						<param name="AllShowEdit" 	value="false"> <!-- Edit가능  -->
						<param name="ColSizing"     value="true">
						<param name="Fillarea"		value="true">
						<param name="AutoResizing" 	value=true> 
						<param name="Editable"  	value="false">
						<param name="AddSelectRows" value=true>
						<param name="IndWidth"      value="0">
						<param name="LineColor" 	value="#dddddd">
						<param name="Format" 		value="
							<c> Name='아   이   디'		ID='uID'	HeadAlign=Center Width=100  align=center </c>
							<c> Name='사 용 자  명' 	ID='uName'	HeadAlign=Center Width=349  LeftMargin=50 </c>
							
						">
					</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
				</td>
			</tr>
			<tr>
				<td>
					<fieldset id=ft_div1 style="width:480;height:15px;border:0 solid #708090;text-align:left;">
					&nbsp;<font id=ft_cnt1 style="position:relative;top:0px;">Cnt : </font>
					</fieldset>
				</td>
			</tr>
		</table>
	</body>
	<!-- BODY END -->
</html>