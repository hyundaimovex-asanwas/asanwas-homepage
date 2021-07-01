<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 포케스팅 생성
 * 프로그램ID 	: RM310B (코드는 대문자)
 * J  S  P		: rm310b (jsp파일명은 소문자로 한다 )
 * 서 블 릿		: Rm310b
 * 작 성 자		: 안준성
 * 작 성 일		: 2006-06-01
 * 기능정의		: 포케스팅 생성,조회,저장,취소 
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
			var div='';
		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  페이지 로딩 
// Parameter 	: 
%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit();
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  선조회
// Parameter 	: 
%>
			function fnInit(){ 
		        cfStyleGrid(getObjectFirst("gr1"), "comn");			
				div='init';
				fnSelectDs2();
			}
			
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head 설정 
// Parameter	:
%>	
			function fnSetHeaderDs1(){
				if (ds1.countrow<1){
				var s_temp = "atclscd:STRING,atclsnm:STRING,desc:STRING";
					ds1.SetDataHeader(s_temp);
				}
			}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  [조회]
%>
			function fnSelect() {
				fnSelectDs1();
			}
									
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  분개코드 조회
// Parameter 	: 
%>
			function fnSelectDs1() {
				if (ds1.IsUpdated ) {
					alert("수정중인 행이 있습니다!");
				} else {
					//alert(ds2.namevalue(ds2.RowPosition, "saup_sid"));
					//alert(ds3.namevalue(ds3.RowPosition, "upjang_sid"));
					ds1.ClearAll();
					ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_RM%>Rm310B?dsType=1&proType=S&sSaupSid="+ds2.namevalue(ds2.RowPosition, "saup_sid")+"&sUpjangSid="+ds3.namevalue(ds3.RowPosition, "upjang_sid");
					ds1.Reset();
				}
			}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  지역 조회
// Parameter 	: 
%>
			function fnSelectDs2() {
		        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		        ds2.Reset(); //지역코드			
			}
						
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  영업장 조회
// Parameter 	: 
%>
			function fnSelectDs3() {
				ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_RM%>Rm310B?dsType=2&proType=INIT&sSaupSid="+ds2.namevalue(ds2.RowPosition, "saup_sid");
				ds3.Reset();
			}			
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  [적용 ]
%>

			function fnApply() {
				fnApplyDs1();
			}
		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  [적용 ] 
// 					: 마스터  
%>
			function fnApplyDs1() {
				var checkDiv='';			
				if(ds1.IsUpdated) {
					for( i=1;i<=ds1.CountRow;i++ ) {
						if ( ds1.namevalue(i,"use_yn") == 'T' ) {
							checkDiv='true';
							break;
						}
					}		
					if ( checkDiv != 'true' ) { alert("적어도 하나의 생성체크를 선택하셔야 합니다."); return; } 				
			         window.status="저장 중입니다. 잠시만 기다려 주십시오...";							
					tr1.KeyValue = "Rm210I(I:INPUT_DATA=ds1)";
					tr1.Action = "<%=dirPath%><%=HDConstant.PATH_RM%>Rm310B?proType=A&dsNum=1&sSaupSid="+ds2.namevalue(ds2.RowPosition, "saup_sid");
					tr1.post();
				}
			}		
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  취소
%>
		function fnCancel(){
			if(ds1.IsUpdated ) {
				ds1.undoall();
			}
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";							
			return;
		}
						
		</script>
		
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>		
<%
////////////////////////////////////////////////////////////////////////////////
//// 포케스팅 정보를 조회한다 
%>	
		<script language="javascript"  for=gr1 event=OnClick(row,colid)>
			if ( colid == 'use_yn' ) {
				if ( ds1.namevalue(row,"bgn_date") == '' ||  ds1.namevalue(row,"end_date") == '' )  {
					ds1.namevalue(row,"use_yn") = 'F';		
					alert("시작일자와 종료일자를 입력하셔야 합니다.");
				}
			}
		</script>

		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			if ( colid == 'use_yn' ) {		
				if ( ds1.namevalue(row,"bgn_date") == '' ||  ds1.namevalue(row,"end_date") == '' )  {
					ds1.namevalue(row,"use_yn") = 'F';		
					alert("시작일자와 종료일자를 입력하셔야 합니다.");
				}				
			}
		</script>
		
		<script language=JavaScript for= lc1 event=OnSelChange()>
			if ( div!='init')
				fnSelectDs3();
		</script>		
		
<%
////////////////////////////////////////////////////////////////////////////////
//// 포케스팅 정보 조회
%>		
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		</script>
		<script language=JavaScript  for=ds2 event="OnLoadStarted()" >
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		</script>
		<script language=JavaScript  for=ds3 event="OnLoadStarted()" >
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			
		</script>		
		
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
			
			if( row < 1){
				alert("검색된 데이타가 없습니다."); 
			}
		</script>
		<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
			div='';	
			fnSelectDs3(); 
		</script>
		
		<script language=JavaScript  for=ds3 event="OnLoadCompleted(row,colid)">
			ds3.insertRow(1);
			ds3.namevalue(1,"upjang_nm") = "전체";
			lc2.index = 0;		
					
			window.status="조회가 완료 되었습니다.";
		</script>		
		
		<script language=JavaScript for=gr1 event=OnExit(row,colid,olddata)>
			if ( colid == 'end_date' ) 	//시작일자와 종료일자의 차이 체크
				if ( ds1.namevalue(row,"bgn_date") != '' ) {			
					if ( ds1.namevalue(row,"bgn_date") > ds1.namevalue(row,"end_date") ) {
						alert("종료일자가 시작일자보다 작습니다. 다시 입력해 주세요.");
						ds1.namevalue(row,"end_date") = '';
					}
				}
			if ( colid == 'bgn_date' ) 	//시작일자와 종료일자의 차이 체크
				if ( ds1.namevalue(row,"end_date") != '' ) {
					if ( ds1.namevalue(row,"bgn_date") > ds1.namevalue(row,"end_date") ) {
						alert("종료일자가 시작일자보다 작습니다. 다시 입력해 주세요.");
						ds1.namevalue(row,"bgn_date") = '';
					}				
				}			
		</script>	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr1" event="onsuccess()">
     	window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);          
	</script>			
			
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>			
<comment id="__NSID__"><object id="ds1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__"><object id="ds2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__"><object id="ds3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
		
<%
/*=============================================================================
			Transaction Components(TR) 선언
=============================================================================*/
%>			
<comment id="__NSID__"><object id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<param name="KeyName" value="toinb_dataid4">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		



											<table border="0" width="845px"  cellpadding="0" cellspacing="0">
												<%
												/*---------------------------------------------------------------------------->
													HTML Desc	: 검색 부분 
																: 담당자명, 담당자코드
												-----------------------------------------------------------------------------*/
												%>											
												<tr height="50px">
													<td align="left" >
														<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
															<tr> 
																<td align="right">
																	<table border="0"  cellpadding="0" cellspacing="0" width="100%">
																		<tr>
																			<td align="right" height="30px">		
																				<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:pointer" onclick="fnSelect()">
																				<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" onClick="fnApply();">
																				<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:pointer"  onclick="fnCancel()">
																 			</td>
																		</tr>
																	</table>
																</td>
															</tr>
														</table>	
													</td>											
												</tr>
												
												<tr height="30px">
													<td align="left" >
														<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
															<tr> 
																<td  width="845px">
																	<table  bgcolor="#666666"  border="0" cellpadding="0" cellspacing="1">
																		<tr  bgcolor="#6f7f8d" height="30px" >
																			<td width="70px" class="text"> 지역 </td>
																			<td bgcolor="#ffffff">
																				<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff">
																					<tr>
																						<td width="150px" align="center"  bgcolor="#FFFFFF">
																					        <comment id="__NSID__"><object id=lc1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=120 width=120>
																									<param name=ComboDataID		value=ds2>
																									<param name=EditExprFormat	value="%,%;saup_nm,saup_sid">
																									<param name=ListExprFormat  value="saup_nm^0^120">
																							</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT> 		
																						</td>	
																					</tr>
																				</table>
																			</td>
																			<td width="70px" class="text"> 영업장 </td>
																			<td bgcolor="#ffffff" width="550px" colspan="3">
																				<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff">
																					<tr>
																						<td width="150px" align="center"  bgcolor="#FFFFFF">
																					        <comment id="__NSID__"><object id=lc2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=120 width=120>
																									<param name=ComboDataID		value=ds3>
																									<param name=EditExprFormat	value="%;upjang_nm">
																									<param name=ListExprFormat  value="upjang_nm^0^120">
																							</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT> 		
																						</td>	
																					</tr>
																				</table>
																			</td>																			
																		</tr>
																	</table>
																</td>
															</tr>
														</table>	
													</td>											
												</tr>
												<tr height="10">
													<td></td>
												</tr>		
												<tr>
													<td width="845px">
														<table  border="0" cellpadding="0" cellspacing="0">
															<tr valign="top"">
																<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
																<%
																/*---------------------------------------------------------------------------->
																	HTML Desc	: 검색 종류 - 지역,영업장:  
																	Object ID 	: 그리드 , gr1
																	Data ID		: ds1
																-----------------------------------------------------------------------------*/
																%>							
																	<%=HDConstant.COMMENT_START%>
																	<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:400" border="1" >
								                            			<param name="DataID"		VALUE="ds1">
								                            			<param name="BorderStyle"   VALUE="0">
								                            			<param name=ColSizing       value="true">
								                            			<param name="editable"      value="true">
								                            			<param name=UsingOneClick  	value="1">
								                                        <Param Name="AllShowEdit"   value="True">
								                                        <param name="SortView"      value="Right">
																		<param name="Format" 			value="
																			<C> name='사업SID' 		ID='saup_sid' 				 	HeadAlign=Center Width=100  align=left editlimit=10 show=false</C>																																																									
																			<C> name='영업장SID' 		ID='upjang_sid' 				 	HeadAlign=Center Width=100  align=left editlimit=10 show=false</C>																																																									
																			<C> name='영업장명' 		ID='upjang_nm' 				 	HeadAlign=Center Width=120  align=left editlimit=30 BgColor=#fefec0 edit=none</C>																					
																			<C> name='생성'  		ID='use_yn'   	HeadAlign=Center Width=30 align=center editlimit=1 editstyle=checkbox</C>																														
																			<C> name='시작일자' 	ID='bgn_date' 				 	HeadAlign=Center Width=80  align=center editlimit=26 mask='XXXX-XX-XX'</C>
																			<C> name='종료일자' 	ID='end_date' 				 	HeadAlign=Center Width=80  align=center editlimit=26 mask='XXXX-XX-XX'</C>
																		">
																	</object>
																	<%=HDConstant.COMMENT_END%>
																</td>		
																<td width="25px">
																</td>					
															</tr>
														</table>
													</td>
												</tr>											
<input type="hidden" name="row" value="">

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

