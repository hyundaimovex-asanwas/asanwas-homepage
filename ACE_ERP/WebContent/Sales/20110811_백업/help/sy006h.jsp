<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 		: 우편번호 
 * 프로그램ID 	: SY110 (코드는 대문자)
 * J  S  P		: sy002h (jsp파일명은 소문자로 한다 )
 * 서 블 릿		: Sy110
 * 작 성 자		: 남기표
 * 작 성 일		: 2006-05-04
 * 기능정의		: 우편번호 조회, 등록, 삭제, 팝업조회 , 검색 
 * 수정내용		: 2006-05-02 : XXXXX 발주 XXXXX 수정요청 (완료/미완료)
 * 수 정 자		:
 * 최종수정일자 	: 2006-05-04 
 * TODO			: 1. xxxxxx 미처리
 * TODO			: 2. yyyyyy 미처리
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
		<title>우편번호 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;</title>
		<link href="<%=dirPath%>/Sales/common/include/common.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="<%=dirPath%>/Sales/common/include/embedControl.js"></script>
<%
	/***************************************************************************
	 *                            사용자 정의 Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
		
			function fnOnLoad(){
				var strParam = new Array();
	        	strParam=window.dialogArguments;
	        	
	        	if(strParam.length>0){
	        		sKeyWord.value = strParam[0];
	        		fnSubSelect1();
	        	}
			}
			
			function fnSelect() {
				if (sKeyWord.value==""){
				alert("우편번호로 검색하세요!");
				}
				else{fnSubSelect1();}
			}
			// 각각 다른것을 조회힌다 
			function fnSubSelect1() {
			
				ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy006H?dsType=1&proType=S&sKeyWord="+sKeyWord.value;
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
	<body border="0" OnLoad="fnOnLoad()" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<table>
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:219px;">
						<tr>
							<td colspan=2 height=25>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">우편번호</font>
							</td>
						</tr>
						<tr>
							<td class="text" width="80px" height="30" style="border:1 solid #708090">우편번호</td>
							<td width="110px" style="border:1 solid #708090;border-left-width:0px">
								<input type="text" name="sKeyWord" class="textbox" style="position:relative;left:8px;width:100px;" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
							</td>
						</tr>
					</table>
				</td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px">
						<tr>
							<td align=right><img src="<%=dirPath%>/Sales/images/p_find.gif" alt="주소를 검색합니다" style="position:relative;left:8px;top:0px;cursor:hand;" onclick="fnSelect();">
							    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnClose('A')">                            
							    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnClose('C')">                          
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
<%
/*---------------------------------------------------------------------------->
	Object ID 	: 그리드 , gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>
					<comment id="__NSID__"><object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=479px; height:256px;border:1 solid #777777;">
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
							<c> Name='우 편 번 호'	ID='zip_cd'		  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90  align=center mask='XXX-XXX'</c>
							<c> Name='주       소' 	ID='ADDRESS'	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=250  leftmargin=10 align=left </c>
							<c> Name='번       지' 	ID='POST_BOX'	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=139  leftmargin=10 align=left </c>
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