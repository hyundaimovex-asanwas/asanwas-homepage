<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		:	상품등록 
 * 프로그램ID 	:	RM410I (코드는 대문자)
 * J  S  P		:	rm410i (jsp파일명은 소문자로 한다 )
 * 서 블 릿		:	Rm410i
 * 작 성 자		:	안준성
 * 작 성 일		:	2006-06-08
 * 기능정의		:	상품등록 조회, 저장, 취소 
 * 수정내용		:   상품 속성 추가 : 테마코드
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2009-05-12][박경국] sales.trm200테이블의 display_seq를 grid에(순서) 표시 및 수정/저장가능 하도록 수정.
 * [2009-05-13][박경국] 검색조건에 [사용유무]추가 & grid의 순서 컬럼에서 sort 기능 추가.
 * [2009-11-24][박경국] 검색조건에 [지역]추가 
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
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
		<script language="javascript">
					
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
				var s_temp1 = "goods_sid:INT,goods_cd:STRING,goods_nm:STRING,eng_nm:STRING,short_nm:STRING,course:STRING,nights:INT,days:INT,saup_sid:INT,use_yn:STRING,theme_cd:STRING";
				ds1.SetDataHeader(s_temp1);
			}		
		}	
		/*
		 * 초기작업
		 */
		function fnInit(){
	        cfStyleGrid(getObjectFirst("gr1"), "comn");										
	        fnSetHeaderDsInit();	

			ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
	        ds2.Reset(); //지역코드
			
			ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm040S",
	            "JSP(O:DS4=ds5)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
		    tr_post(tr1); 		
	
	        //상품정보
	        ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
	        ds3.Reset();       				
	        
	        //공통코드: 테마코드 정보
	        ds4.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM018&s_Item1=Y";
	        ds4.Reset();       					        
		}
		
		/*
		 * 메인 조회.
		 */
		function fnSelect() {
			fnSelectDs1();
		}
		/*
		 * 데이터셋 첫번째 조회
		 */
		function fnSelectDs1() {
			sUseYn = lc3.ValueOfIndex("detail", lc3.Index);		
			if (ds1.IsUpdated ) {
				alert("수정중인 행이 있습니다!");
			} else {
				ds1.ClearAll();
				ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_RM%>Rm410I?dsType=1&proType=S&sGoodsSid="+sGoodsSid.value+"&sGoodsCd="+sGoodsCd.value
																  +"&sUseYn="+lc3.ValueOfIndex("detail", lc3.Index)    +"&sSaupSid="+lc1.ValueOfIndex("saup_sid", lc1.Index) 
																  +"&sGoodsNm="+sGoodsNm.value;
				ds1.Reset();
			}		
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
		function fnDeleteRowDs1() {
			ds1.deleterow(ds1.rowposition);
		}
		/*
		 * 저장
		 */
		function fnApply() {
			var row1=ds1.countrow;
			if (ds1.IsUpdated) {
				for ( i=1; i<=ds1.countrow; i++ ) {
					if ( ds1.namevalue(i,"goods_cd") == '' ) { alert("상품코드는 필수 입력 사항입니다."); return; }
					if ( ds1.namevalue(i,"goods_nm") == '' ) { alert("상품명은 필수 입력 사항입니다."); return; }					
					if ( ds1.namevalue(i,"saup_sid") == '' ) { alert("지역명은 필수 입력 사항입니다."); return; }					
				}
		         window.status="저장 중입니다. 잠시만 기다려 주십시오...";				
				tr1.KeyValue = "Rm410I(I:INPUT_DATA=ds1)";
				tr1.Action = "<%=dirPath%><%=HDConstant.PATH_RM%>Rm410I?proType=A&dsNum=1";
				tr1.post();
			}
		}
					
		/*
		 * 취소 
		 */
		function fnCancel(){
				ds1.undoall();
				window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";											
		}	
		/*
		 *  팝업 
		 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
		function fnPopup() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/rm002h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);	

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sGoodsSid.value = arrParam[0];
				sGoodsCd.value = arrParam[1];
				sGoodsNm.value = arrParam[2];					
			} else {
		    	sGoodsSid.value = '';
				sGoodsCd.value = '';
				sGoodsNm.value = '';					
			}
		} 	
		/*
		 * 상품정보 자동셋팅(조건)
		 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
		function fnSetting(dataSet) {   
			var exit=false;
			if ( dataSet == 'ds3' ) {	//상품정보
				for ( i=1; i<=ds3.CountRow; i++ ) {
					if ( ds3.namevalue(i,"goods_cd") == sGoodsCd.value ) {
						sGoodsSid.value = ds3.namevalue(i,"goods_sid");
						sGoodsNm.value = ds3.namevalue(i,"goods_nm");
						exit=true;
						return;
					}
				}
				if ( exit != true ) {
					sGoodsSid.value = '';
					sGoodsNm.value = '';				
				}
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
				
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";			
		</script>
		
		<script language=JavaScript  for=ds3 event="OnLoadCompleted(row,colid)">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";			
		</script>

		<script language=JavaScript  for=ds4 event="OnLoadCompleted(row,colid)">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";			
		</script>
		
		<script language="javascript"  for=gr1 event=OnClick(row,colid)>
		   if (row < 1 && colid=='use_yn' ) {
			   	for(i=1;i<=ds1.CountRow;i++)
		     		ds1.namevalue(i,colid) = ds1.namevalue(1,colid);
		   }		
		</script>
	
		<script language=JavaScript for=ds1 event=OnDataError(row,colid)>
	         window.status="유효하지 못한 값이 입력되었습니다. 다시 입력해주세요.";				
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
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
		<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value=false>
		</object>
		<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value=false>
		</object>
		<!--  상품정보 -->
		<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value=false>
		</object>
		<!--  공통코드 : 상품정보의 테마 -->
		<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value=false>
		</object>
		<object id=ds_use classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="False">
		</object>
		<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="False">
		</object>
		<object id=display_seq classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="False">
		</object>
		<comment id="__NSID__"><object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
			<param name="KeyName"  value="toinb_dataid4">
		</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
		<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
									
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" width="845px"  cellpadding="0" cellspacing="0">
				<tr height="0px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td align="right">
									<table border="0"  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="right" height="10px">		
												<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
												<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="fnAddRowDs1()" >
												<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="fnDeleteRowDs1()" >																						
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
				<tr height="0px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="845px">
									<table  bgcolor="#666666"  border="0" cellpadding="0" cellspacing="1">
										<tr  bgcolor="#6f7f8d" height="10px" >
			            					<td align=left width=70 class="text">&nbsp; 지 역</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds2>
													<param name=BindColumn      value="saup_sid">
                                                    <param name=BindColVal      value="saup_sid">
													<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
													<param name=ListExprFormat  value="saup_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>
			            					<td align=left width=70 class="text">&nbsp;상품코드</td>
			                                <td align=left bgcolor="#ffffff" colspan=7 width="300">&nbsp;																										
												<input id="sGoodsSid" type="hidden">                                
												<input id="sGoodsCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:60px; height:20px;" maxlength=7 onBlur="fnSetting('ds3')">
												<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="상품정보를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup();">
												<input id="sGoodsNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;" readOnly>																						
											</td>
											<td align=left width=70 class="text">&nbsp;사용유무</td>                                                                                                                                                                                                                                                                                                                                         
			                                <td align=left width=205 bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>                                                                                                                                                                                                   
					                            <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>                                                                                                                                          
													<param name=ComboDataID		value=ds5>                                                                                                                                                                      
													<param name=BindColumn      value="head">                                                                                                                                                              
                                                    <param name=BindColVal      value="head">                                                                                                                                                                                                                      
													<param name=EditExprFormat	value="%,%;head,detail_nm">                                                                                                                                         
													<param name=ListExprFormat  value="detail_nm^0^120">
												</object>                                                                                                                                                
												<%=HDConstant.COMMENT_END%>
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
								<td align="left" width="400px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:400" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name="Format" 			value="
							                <C> name='상품SID'    ID='goods_sid'  HeadAlign=Center Width=100  align=left   editlimit=12 show=false</C>
							                <C> name='상품코드'   ID='goods_cd'   HeadAlign=Center Width=50   align=center editlimit=7  show=true</C>
							                <C> name='상품명'     ID='goods_nm'   HeadAlign=Center Width=100  align=left   editlimit=40 show=true</C>
							                <C> name='영문명'     ID='eng_nm'     HeadAlign=Center Width=60   align=left   editlimit=40 show=true</C>
							                <C> name='단축명'     ID='short_nm'   HeadAlign=Center Width=60   align=left   editlimit=40 show=true</C>															                															                
							                <C> name='경로'       ID='course'     HeadAlign=Center Width=250  align=left   editlimit=100show=true</C>
							                <C> name='박수'       ID='nights'     HeadAlign=Center Width=30   align=right  editlimit=5  show=true</C>
							                <C> name='일수'       ID='days'       HeadAlign=Center Width=30   align=right  editlimit=5  show=true</C>
							                <C> name='지역'       ID='saup_sid'   HeadAlign=Center Width=70   align=center editlimit=5  editstyle=lookup data='ds2:saup_sid:saup_nm' show=true </C>
							                <C> name='테마'       ID='theme_cd'   HeadAlign=Center Width=70   align=center editlimit=5  editstyle=lookup data='ds4:detail:detail_nm' show=true </C>
							                <C> name='사용√'      ID='use_yn'     HeadAlign=Center Width=35   align=center editstyle=checkbox editlimit=1 show=true</C>
							                <C> name='DATA존재여부' ID='data_yn'  HeadAlign=Center Width=40   align=center editlimit=1  show=false</C>
							                <C> name='순서' 		ID='display_seq'  HeadAlign=Center Width=50  align=center editlimit=10 show=true Sort=True</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>		
							</tr>
						</table>
					</td>
				</tr>
			</table>				
		</td>
	</tr>
</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

