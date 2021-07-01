<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 고객관리
 * 프로그램ID 	: CU010S
 * J  S  P		: cu010i
 * 서 블 릿		: Cu010i
 * 작 성 자		: 남기표
 * 작 성 일		: 2006-06-05
 * 기능정의		: 고객조회
 * [수  정   일  자][수정자] 내용
 * [2007-09-17][심동현] 새 메뉴트리 적용
 *****************************************************************************/
%>
<% 
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
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
	<script language="javascript">
		
	/* 페이지로딩 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		cfStyleGrid(getObjectFirst("gr1"), "comn");
		fnInit();
//		lc3.Index = 1;
	}


	/* 데이타셋 헤더 설정 */
	function fnSetHeaderDsInit(){
		
		if (searchds1.countrow<1){
			var s_temp4 = "head:STRING,detail:STRING,detail_nm:STRING";
			searchds1.SetDataHeader(s_temp4);
		}		
		if (searchds2.countrow<1){
			var s_temp5 = "head:STRING,detail:STRING,detail_nm:STRING";
			searchds2.SetDataHeader(s_temp5);
		}
		if (searchds3.countrow<1){
			var s_temp6 = "head:STRING,detail:STRING,detail_nm:STRING";
			searchds3.SetDataHeader(s_temp6);
		}		
		
		if (searchds4.countrow<1){
			var s_temp6 = "head:STRING,detail:STRING,detail_nm:STRING";
			searchds4.SetDataHeader(s_temp6);
		}
	}	
			
	/* 초기작업 */
	function fnInit(){
	    initds.DataId = "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010S?proType=INIT&dsType=1";
			initds.Reset();
		}

			
		/* 메인 조회 */
		function fnSelect() {
			fnSelectDs1();
		}
			
		/* 데이터셋 첫번째 조회 */
		function fnSelectDs1() {
			ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010S?proType=S&dsType=1&sClientSid="+client_sid.value
																				+"&sCustNm=" + sCustNm.value
																				+"&sManageNo=" + sManageNo.value
																				+"&sCustGu=" + lc3.ValueOfIndex("detail",lc3.Index)
																				+"&sCountryGu=" + lc1.ValueOfIndex("detail",lc1.Index)
																				+"&sRegiYn=" + lc2.ValueOfIndex("detail",lc2.Index)
																				+"&sGroupCd=" + sAccpt_no.value
																				+"&sSaupCd=" + lc4.ValueOfIndex("detail",lc4.Index)
																			
		ds1.Reset();
		ds1.ResetStatus();
	}
		
	/* 행추가 , 신규  */
	function fnAddRowDs1() {
		ds1.addrow();
	}
		
	/* 행삭제, 삭제 */
	function fnDeleteRow() {
		ds1.deleterow(ds1.rowposition);
	}
		
	/* 저장 */
	function fnApply() {
		var row1=ds1.countrow;
			
		if (ds1.IsUpdated) {
			tr1.KeyValue = "Cu010I(I:INPUT_DATA=ds1)";
			tr1.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Cu010I?proType=A&dsNum=1";
																
			tr1.post();
			fnSelect(); // 입력후 조회 
		}		
	}
		
	/* 취소  */
	function fnCancelDs1() {
		ds1.Reset();
		ds1.undoall();
		window. status="데이터 변경이 취소되었습니다.";
		return;		
	}
		
		
	/* 프린트 */
	function fnPrintDs1() {
	}
			
	/* 엑셀 */
	function fnExcelDs1() {
		
		if(ds1.RowCount==0){
			alert("데이터를 먼저 조회하시길 바랍니다.");
			return;
		}
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:고객조회 조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("고객조회", "고객조회.xls", 8);		 
	}
		
	/* 팝업 */
	function fnPopup() {
		
	}
		
	/* 입력 체크 */
	function fnCheck() {
	};

		
	
	/* 대리점 검색 팝업 */
	function fnClientPopup() {
		
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		
		strURL = "<%=dirPath%>/Sales/help/cu001h.jsp";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		if (arrResult != null) {
			arrParam = arrResult.split(";");
	   		client_nm.value = arrParam[1];
	   		client_sid.value = arrParam[0];
	   		
		} else {
		  client_nm.value = "";
		  client_sid.value = "";
		}				
	}
	
	/* 영업담당자 팝업 */
	function fnSalDamPopup() {
		
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		
		strURL = "<%=dirPath%>/Sales/help/sy005h.jsp";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			sal_dam_cd.value = arrParam[0];
	   		sal_dam_nm.value = arrParam[2];
		} else {
		  sal_dam_cd.value = "";
		  sal_dam_nm.value = "";
		}				
	}
	</script>
			

<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>


	<%
	/****************************************************************************
	 Description	:  선조회시 공통코드 관련한 콤보박스에 데이터를 채운다 
	*****************************************************************************/
	%>		
	<script language=JavaScript  for=initds event="OnLoadCompleted(row,colid)">
		fnSetHeaderDsInit();
		 
		var row=initds.countrow;
		
		for(i=1;i<=row;i++) {
			
			if (initds.namevalue(i,"head") == 'CU009'){// 국적구분
				searchds1.insertRow(1);
				searchds1.namevalue(1,"head") = initds.namevalue(i,"head");	
				searchds1.namevalue(1,"detail") = initds.namevalue(i,"detail");
				searchds1.namevalue(1,"detail_nm") = initds.namevalue(i,"detail_nm");	
			} else if  (initds.namevalue(i,"head") == 'CU002') { // 인증여부
				searchds2.insertRow(1);
				searchds2.namevalue(1,"head") = initds.namevalue(i,"head");	
				searchds2.namevalue(1,"detail") = initds.namevalue(i,"detail");
				searchds2.namevalue(1,"detail_nm") = initds.namevalue(i,"detail_nm");	
			} else if  (initds.namevalue(i,"head") == 'CU001') { // 고객구분
				searchds3.insertRow(1);
				searchds3.namevalue(1,"head") = initds.namevalue(i,"head");	
				searchds3.namevalue(1,"detail") = initds.namevalue(i,"detail");
				searchds3.namevalue(1,"detail_nm") = initds.namevalue(i,"detail_nm");
					
			} else if  (initds.namevalue(i,"head") == 'CU004') { // 사업구분
				searchds4.insertRow(1);
				searchds4.namevalue(1,"head") = initds.namevalue(i,"head");	
				searchds4.namevalue(1,"detail") = initds.namevalue(i,"detail");
				searchds4.namevalue(1,"detail_nm") = initds.namevalue(i,"detail_nm");
			}
		}		
		
		searchds3.insertRow(1);
		searchds3.namevalue(1,"head") = 'CU001';	
		searchds3.namevalue(1,"detail") = '';
		searchds3.namevalue(1,"detail_nm") = '전체';
			
		searchds2.insertRow(1);
		searchds2.namevalue(1,"head") = 'CU001';	
		searchds2.namevalue(1,"detail") = '';
		searchds2.namevalue(1,"detail_nm") = '전체';
			
		searchds1.insertRow(1);
		searchds1.namevalue(1,"head") = 'CU009'
		searchds1.namevalue(1,"detail") = '';
		searchds1.namevalue(1,"detail_nm") = '전체';
		
		
		searchds4.insertRow(1);
		searchds4.namevalue(1,"head") = 'CU004'
		searchds4.namevalue(1,"detail") = '';
		searchds4.namevalue(1,"detail_nm") = '전체';
		
		lc1.index = 5;
		lc2.index = 0;
		lc3.index = 1;
		lc4.index = 0;
		
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
			
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
		<script language="javascript" for="tr1" event="onfail()">
		</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="gcds_data00" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 
%>
<script language="javascript" for="initds" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 
%>
<script language="javascript" for="ds1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
</script>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 에러 
%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 에러 
%>				
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
		 if (ds1.countrow == 1000) {
		alert("데이터는 1000건 이상 조회 할 수 없습니다!");
		}
			window.status="조회가 완료 되었습니다.";
			
			if( row < 1){
				alert("검색된 데이타가 없습니다."); 
				
			} else {
				lc1.index = lc1.IndexOfColumn("detail", ds1.namevalue(ds1.rowpostion, "country_gu"));
				lc2.index = lc2.IndexOfColumn("detail", ds1.namevalue(ds1.rowpostion, "regi_yn"));
				lc3.index = lc3.IndexOfColumn("detail", ds1.namevalue(ds1.rowpostion, "cust_gu"));
			}
			
							
		</script>	
		
<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>

<object id=gcds_data00 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
	<PARAM NAME="SyncLoad" VALUE="false">                    
</object>                                                        
<object id=initds classid=<%=HDConstant.CT_DATASET_CLSID%>>      
	<PARAM NAME="SyncLoad" VALUE="false">                    
</object>                                                        
<object id=searchds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>   
	<PARAM NAME="SyncLoad" VALUE="false">                    
</object>                                                        
<object id=searchds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>   
	<PARAM NAME="SyncLoad" VALUE="false">                    
</object>                                                        
<object id=searchds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>   
	<PARAM NAME="SyncLoad" VALUE="true">                    
</object>    
<object id=searchds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>   
	<PARAM NAME="SyncLoad" VALUE="false">                    
</object>                                                      

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		


								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tr height="60px">
										<td >
											<table width=845 >
												<tr>
													<td colspan=2>
														<table align=right>
															<tr>
																<td align="right"> 
																	<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">                                                                                    
																	<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onclick="fnExcelDs1()">  
																</td>                                                                                                                
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td>
														<table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="245x">
															<tr>                
																<td align="center" width="85px" height="30px" class="text" >신청서번호</td>                                                          
																<td align="left"  bgcolor="#ffffff" colspan="3">
																	&nbsp;<input type="text" name="sAccpt_no" value="" size="14" maxlength="14">
																	<img src="<%=dirPath%>/Sales/images/help.gif" border="0" 		ALT="신청서번호를  검색합니다"  style="cursor:hand"  onclick="javascript:fnAcceptNoPopup('<%=dirPath%>');" align='absmiddle'>                                                                            
																</td>                               
																                                                                                                               
															</tr>
															<tr>	                                                                                                                      
																<td align="center" width="85px" height="30px" class="text">대리점코드</td>                                                              
																<td align="left"  bgcolor="#ffffff" colspan="3">                                                                           
																	&nbsp;<input type="text" id=client_nm name="sClientSid" value="" size="14" maxlength="10"  readOnly="true">
																<img src="<%=dirPath%>/Sales/images/help.gif" border="0" align=absmiddle onClick = fnClientPopup();>     
																 <input type='hidden' id='client_sid' name='client_sid' value=''>                                              
																</td>                                                                                                                      
															</tr>												                                   
														</table>
													</td>
													<td align=right>                                                                                                                                    
														<table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="600x">                                                          
															<tr>                                                                                                                                
																<td align="center" width="85px" height="30px" class="text" >고객구분</td>                                                  
																<td align="center"  bgcolor="#ffffff" colspan="3">                                                                            
																	<%=HDConstant.COMMENT_START%>
																	<object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
																		<param name=ComboDataID		value=searchds3>
																		<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
																		<param name=ListExprFormat  value="detail_nm^0^100">
																	</object>
																	<%=HDConstant.COMMENT_END%>	
																</td>                                                                                                                       
																<td align="center" width="80px" height="30px" class="text" >인증구분</td>                                                  
																<td align="center"  bgcolor="#ffffff" colspan="3">                                                                            
																	<%=HDConstant.COMMENT_START%>
																	<object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
																		<param name=ComboDataID		value=searchds2>
																		<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
																		<param name=ListExprFormat  value="detail_nm^0^100">
																	</object>
																	<%=HDConstant.COMMENT_END%>
																</td>                                                                                                                       
																<td align="center" width="85px" height="30px" class="text" >고객명</td>                                                    
																<td align="left"  bgcolor="#ffffff" colspan="3">                                                                            
																	&nbsp;&nbsp;<input type="text" name="sCustNm" value="" size="12" maxlength="10" >  
																</td>                                                                                                                       
															</tr>                                                                                                                               
															<tr>                                                                                                                  
																<td align="center" width="85px" height="30px" class="text">국적구분</td>                                                                 
																<td align="center"  bgcolor="#ffffff" colspan="3">                                                                            
																	<%=HDConstant.COMMENT_START%>
																	<object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
																		<param name=ComboDataID		value=searchds1>
																		<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
																		<param name=ListExprFormat  value="detail_nm^0^100">
																	</object>
																	<%=HDConstant.COMMENT_END%>
																</td>                
																<td align="center" width="80px" height="30px" class="text" >사업구분</td>                                                  
																<td align="center"  bgcolor="#ffffff" colspan="3">                                                                            
																	<%=HDConstant.COMMENT_START%>
																	<object id=lc4 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
																		<param name=ComboDataID		value=searchds4>
																		<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
																		<param name=ListExprFormat  value="detail_nm^0^100">
																	</object>
																	<%=HDConstant.COMMENT_END%>	
																</td>        
																
																                                                                                                       
															                                                                                        
																<td align="center" width="85px" height="30px" class="text" >주민/여권번호</td>                                             
																<td align="left"  bgcolor="#ffffff" colspan="3">                                                                            
																	&nbsp;&nbsp;<input type="text" name="sManageNo" value="" size="12" maxlength="13">  
																</td>                                                                                                                       
															</tr>
														</table>                                                                                                                                    
													</td>
												</tr>
												<tr>
												<td height="5"></td>
												</tr>
												<tr>
													<td colspan=2>
														<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gr1  style="width=845px; height:383px" border="1">
													        <param name="DataID"            value="ds1">
													        <param name="BorderStyle"       value="0">
													        <param name="Fillarea"          value="true">
													        <param name="ColSizing"         value="true">
													        <param name="IndWidth"          value="0">
													        <param name="editable"          value="false">
													        <param name="LineColor"         value="#dddddd">
													        <param name="SortView"         		value="Right">
													        <param name="Format"            value="
													
													                <C> name='영업담당자'   	ID='sal_dam_nm' 		 Width=80  align=left editlimit=22</C>
													                <C> name='대리점'    		ID='client_nm'  		 Width=150  align=left editlimit=20</C>
													                <C> name='성명'      	ID='cust_nm'    		 Width=100  align=left editlimit=20</C>
													                <C> name='주민/여권번호'	ID='manage_no'  		 Width=100  align=left editlimit=13</C>
													                <C> name='인증여부' 		ID='regi_yn_name'   	 Width=60  align=left editlimit=50</C>
													                <C> name='고객구분' 		ID='cust_gu_name'        Width=60  align=left editlimit=50</C>
													                <C> name='국적구분'		ID='country_gu_name'     Width=60  align=left editlimit=50</C>
													                <C> name='사업구분' 		ID='saup_gu_name'        Width=60  align=left editlimit=50</C>
													                <C> name='고객유형'		ID='cust_type_name'      Width=60  align=left editlimit=50</C>
													                <C> name='국적'   		ID='country_cd' 		 Width=50  align=left editlimit=3</C>
													                <C> name='민족'       	ID='nation_cd'		      Width=100  align=left editlimit=50</C>
													                <C> name='자택전화'		ID='tel_no'     		 Width=100  align=left editlimit=20</C>
													                <C> name='비상연락처'    	ID='mobile_no'  		 Width=100  align=left editlimit=15</C>
													                <C> name='직장명'   		ID='company_nm' 		 Width=150  align=left editlimit=30</C>
													                <C> name='직위'    		ID='positions'  		 Width=150  align=left editlimit=30</C>
													                <C> name='주소'     		ID='address1'   		 Width=200  align=left editlimit=60</C>
													                <C> name='관광횟수'    	ID='north_cnt'  		 Width=60  align=left editlimit=7</C>
													                <C> name='그룹코드'    	ID='group_cd'  			 Width=100  align=left editlimit=7</C>
													                <C> name='신장'    		ID='height'  			 Width=50  align=left editlimit=7 show=false</C>
													                <C> name='입력일시'    	ID='u_date'  			 Width=170  align=center  sort=true</C>
													        ">
													</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
													</td>
												</tr>
											</table>	                                                                                                                       
										</td>                                                                                                                                              
									</tr>
								</table>						


<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

