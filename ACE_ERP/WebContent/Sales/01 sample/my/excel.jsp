<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 엑셀 테스트
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import

%>
<%@ page import="sales.common.*"%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  자바코드


	// ContextPath
	String dirPath = request.getContextPath(); //HDASan
	 
%>

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
		function fnOnLoad(){
			fnInit(); 
		}
		
		function fnInit() {
			fnSetHeaderDs1();
		//	ds1.addrow();
			fnSelectDs1();
			
			
			
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head 설정 
// Parameter	:
%>	
		function fnSetHeaderDs1(){
			if (ds1.countrow<1){
				var s_temp = "key_seq:STRING,name:STRING";
				ds1.SetDataHeader(s_temp);
			}
		}

		function fnSelectDs1() {
			ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_SAMPLE%>Excel?flag=r";
			ds1.Reset();	
		}
		</script>
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
			alert(ds1.CountRow);
			document.all.LowerFrame.style.visibility="hidden";
			if( row < 1){
				alert("검색된 데이타가 없습니다."); 
			}
		</script>	
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			alert(" 조회중 에러가 발생했습니다 : " + ds1.ErrorMsg );
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  전체 프로그램 목록 
%>
<%=HDConstant.COMMENT_START%>
<object  id=ds1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
	<param name="SyncLoad" 	value="true">
</object>
<%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			Transaction Components(TR) 선언
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  전체 프로그램 목록 
%>
<object  id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F">
	<param name="KeyName"  value="toinb_dataid4">
</object>	
	</head>
	
<!--------------------------------- BODY Start ------------------------------->		
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	onLoad="javascript:fnOnLoad();">
		
								<table width="845px">
									<tr>
										<td>
<!--------------------------------- 코딩 부분 시작 ------------------------------->	
								<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gr1  style="width=300px; height:383px" border="1">
								        <param name="DataID"            value="ds1">
								        <param name="BorderStyle"       value="0">
								        <param name="Fillarea"          value="true">
								        <param name="ColSizing"         value="true">
								        <param name="IndWidth"          value="0">
								        <param name="editable"          value="false">
								        <param name="LineColor"         value="#dddddd">
								        <param name="Format"            value="
								
								                <C> name='KEY_SEQ'     	ID='key_seq'    HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=12 show=true</C>
								                <C> name='NAME' 		ID='name'       HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=10 show=true</C>
								        ">
								</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
											
<!--------------------------------- 코딩 부분 끝 -------------------------------->		
										</td>
									</tr>
								</table>
								
						
							</td>
						</tr>
					</table>
				</td>
			</tr>
<!-- 프로그램 들어가는 BODY END -->			
		</table>

<%
/*=============================================================================
			Status Bar Falsh
=============================================================================*/
%>	
	<iframe id="LowerFrame" 
			name="work" 
			style="visibility:hidden; position:absolute; left:280px; top:220px;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.swf" 
			width="320px" 
			height="42px">
	</iframe>		
<!---------------------------------- BODY End -------------------------------->	
	</body>
</html>