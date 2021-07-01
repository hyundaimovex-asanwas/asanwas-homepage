<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		:	호텔별 시즌관리 
 * 프로그램ID 	:	RM210I (코드는 대문자)
 * J  S  P		:	rm210i (jsp파일명은 소문자로 한다 )
 * 서 블 릿		:	Rm210i
 * 작 성 자		:	안준성
 * 작 성 일		:	2006-06-05
 * 기능정의		:	호텔별 시즌관리 조회, 저장, 취소 
 * 				      메세지를 발송하는 페이지는 외부SMS 모듈 처리를 위해 windwos서버에 ASP로 되어 있음.
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2009-04-08][심동현] 학단 시즌 추가해야죠..
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
   java.util.Date mydate = new java.util.Date();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyy");
   String today = m_today.format(mydate);	

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
			var div='';
		/*
		 * 페이지로딩
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출
			fnInit(); 
		}
		/*
		 * 데이타셋 헤더 설정
		 */
		function fnSetHeaderDsInit(){
			
			if (ds1.countrow < 1){
				var s_temp1 = "head:STRING,detail:STRING,detail_nm:STRING";
				ds.SetDataHeader(s_temp1);
			}
							
		}	
		/*
		 * 초기작업
		 */
		function fnInit(){
			bgn_date.text='<%=today%>0101';
			end_date.text='<%=today%>1231';			
	        cfStyleGrid(getObjectFirst("gr1"), "comn");								
			div='init';
			fnSelectDs2();
			fnSelectDs4();			
		}
		/*
		 * 메인 조횐
		 */
		function fnSelect() {
			fnSelectDs1();
		}
		/*
		 * 데이터셋 첫번째 조회
		 */
		function fnSelectDs1() {
			if (ds1.IsUpdated ) {
				alert("수정중인 행이 있습니다!");
			} else {
				if ( bgn_date.text == '' || end_date.text == '' ) { alert("관리일자를 입력해주세요."); return; }
				ds1.ClearAll();
				ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_RM%>Rm210I?dsType=1&proType=S&sSaupSid="+ds2.namevalue(ds2.RowPosition, "saup_sid")+"&sUpjangSid="+ds3.namevalue(ds3.RowPosition, "upjang_sid")+"&sBgnUseDate="+bgn_date.text+"&sEndUseDate="+end_date.text;
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
				ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_RM%>Rm210I?dsType=2&proType=INIT&sSaupSid="+ds2.namevalue(ds2.RowPosition, "saup_sid");
				ds3.Reset();
			}
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  시즌명 조회
// Parameter 	: 
%>
			function fnSelectDs4() {
				ds4.Dataid  = "<%=dirPath%><%=HDConstant.PATH_RM%>Rm210I?dsType=3&proType=INIT&sHead=RM006";
				ds4.Reset(); //시즌				
			}			
						
		/*
		 * 행추가 , 신규 
		 */
		function fnAddRowDs1() {
			ds1.addrow();
		}
			
		/*
		 * 행삭제, 삭제
		 */
		function fnDeleteRow() {
			ds1.deleterow(ds1.rowposition);
		}
		/*
		 * 저장
		 */
		function fnApply() {
			var row1=ds1.countrow;
			if (ds1.IsUpdated) {
		         window.status="저장 중입니다. 잠시만 기다려 주십시오...";			
				tr1.KeyValue = "Rm210I(I:INPUT_DATA=ds1)";
				tr1.Action = "<%=dirPath%><%=HDConstant.PATH_RM%>Rm210I?proType=A&dsNum=1";
				tr1.post();
			}		
		}
		/*
		 * 취소 
		 */
		function fnCancel(){
			if(ds1.IsUpdated ) {
				ds1.undoall();
				window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";							
			}
		}		 
			
		</script>
		

<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
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
		<script language=JavaScript  for=ds4 event="OnLoadStarted()" >
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		</script>		
				
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
		</script>
		
		<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
			div='';	
			fnSelectDs3(); 
		</script>
		
		<script language=JavaScript  for=ds3 event="OnLoadCompleted(row,colid)">
			ds3.insertRow(1);
			ds3.namevalue(1,"upjang_nm") = "전체";
			lc2.index = 0;		
					
	        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
		</script>	
		
		<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
			if(colid=="season_cd") {
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;
				//arrParam[0] : head
				//arrParam[1] : detail
				//arrParam[2] : detail_nm
				//arrParam[3] : item1				
				arrParam[0] = "RM006";
				arrParam[1] = "시즌코드"; //공통코드의 마스터값
				strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
				strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
				arrResult = showModalDialog(strURL,arrParam,strPos);
				if (arrResult != undefined) {
					arrParam = arrResult.split(";");
					gr1.SetColumn("season_nm"); 										
		    		ds1.namevalue(ds1.rowposition,"season_cd")=arrParam[1];
					ds1.namevalue(ds1.rowposition,"season_nm")=arrParam[2];
				} else {

				}
			}
		</script>	
		
		<script language=JavaScript for= lc1 event=OnSelChange()>
			if ( div!='init')
				fnSelectDs3();
		</script>					

		<script language="javascript"  for=gr1 event=OnClick(row,colid)>
		   if (row < 1 && colid=='season_cd' ) {
		   	for(i=1;i<=ds1.CountRow;i++){
		     	ds1.namevalue(i,colid) = ds1.namevalue(1, colid);
		     	ds1.namevalue(i,"season_nm") = ds1.namevalue(1, "season_nm");		     	
		    }
		   }
		</script>
		
		<script language=JavaScript for=ds1 event=OnColumnChanged(row,colid)>
	        var flag = false;
	        if(colid=="season_cd"){
	            for(var i=1; i<=ds4.CountRow; i++){
	                if(ds4.NameValue(i, "detail")==ds1.NameValue(row, colid)){
	                    ds1.NameValue(row, "season_nm") = ds4.NameValue(i, "detail_nm");
	                    flag = true;
	                    return;
	                }
	            }
	            if(!flag)
	                ds1.NameValue(row, "season_nm") = "";
	        }		
		</script>		
		
	    <script language=JavaScript for=bgn_date event=OnKillFocus()>
	        if( bgn_date.Modified == true )
				end_date.text = bgn_date.text;
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
	</script>
			
<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<comment id="__NSID__">
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
</comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__">
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
</comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__">
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
</comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__">
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
</comment><SCRIPT>__WS__(__NSID__);</SCRIPT>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

									
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
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
												<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
												<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
												<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
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
											<td bgcolor="#ffffff">
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
											<td width="70px" class="boardt02">관리일자</td>
											<td bgcolor="#ffffff" width="350px" colspan="3" align=left>
												<table width="100%" border="0" cellpadding="0" cellspacing="0" align="left" bgcolor="#ffffff">
													<tr>
														<td width="100px" align="left"  bgcolor="#FFFFFF">&nbsp;
															<comment id="__NSID__"><object id=bgn_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="0000-00-00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">																																																				
																<param name=ReadOnly  	value="false">
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">	
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																						
															</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>&nbsp;-		
														</td>	
														<td width="100px" align="left"  bgcolor="#FFFFFF">	
															<comment id="__NSID__"><object id=end_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=left class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="0000-00-00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">																																																				
																<param name=ReadOnly  	value="false">
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">	
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																						
															</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:380" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name=ColSelect       value="true">								                            			
                            			<param name="editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name="Format" 			value="
											<C> name='사업SID' 		ID='saup_sid' 				 	HeadAlign=Center Width=100  align=left editlimit=10 show=false</C>																																																									
											<C> name='영업장SID' 		ID='upjang_sid' 				 	HeadAlign=Center Width=100  align=left editlimit=10 show=false</C>																																							
											<C> name='영업장명' 		ID='upjang_nm' 				 	HeadAlign=Center Width=100  align=left editlimit=50 BgColor=#fefec0 edit=none</C>																					
											<C> name='관리일자' 		ID='use_date' 				 	HeadAlign=Center Width=80  align=center editlimit=8 BgColor=#fefec0 edit=none mask='XXXX-XX-XX'</C>																					
											<C> name='요일' 		ID='day_nm' 				 	HeadAlign=Center Width=50  align=left editlimit=3 BgColor=#fefec0 edit=none</C>																																																											
											<C> name='시즌 √'  		ID='season_cd'   	HeadAlign=Center Width=50 align=center editlimit=2 editstyle=popup HeadCheckShow=true</C>																														
											<C> name='시즌명' 	ID='season_nm' 				 	HeadAlign=Center Width=100  align=left BgColor=#fefec0 edit=none editlimit=50</C>
											
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

		</td>
	</tr>
</table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

