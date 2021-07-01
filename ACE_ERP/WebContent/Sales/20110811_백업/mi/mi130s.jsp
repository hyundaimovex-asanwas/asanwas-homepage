<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 연령별 인원현황
 * 프로그램ID 	 : MI130S
 * J  S  P		 : mi130s
 * 서 블 릿		 : MI130S
 * 작 성 자		 : 안준성
 * 작 성 일		 : 2006-08-21 
 * 기능정의		 : 연령별 인원현황 (조회)
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

   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMM");
   String firstday = m_today.format(date.getTime());		   
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
        var v_job = "H";
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
	function fnSetHeader(){
	}
	/*
	 * 선조회
	 */
	function fnInit(){
        v_job = "H";
		div='init';	        
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		fnSetHeader();

		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
		sBgnDate.text='<%=firstday%>';
		
		ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //지역코드		
        
        //고객구분
        ds_cust_gu.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CU001&s_item=Y";
        ds_cust_gu.Reset();         
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {
    	if ( sBgnDate.text.trim() == '' ) {
			alert("작업년월을 입력해주세요.");
			return;
		}    
        v_job = "S";
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sSaupSid=" + ds_saup.namevalue(ds_saup.rowposition,"saup_sid") + ","        
            + "sBgnDate=" + sBgnDate.text + ","
            + "sCustGu=" + ds_cust_gu.namevalue(ds_cust_gu.rowposition,"detail");  
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_MI%>Mi130S",
            "JSP(O:DS1=ds1)",
            param);
        tr_post(tr1);

    }
	/*
	 * 엑셀
	 */
	function fnExcelDs1() {
		gr1.runexcelsheet("연령별 인원현황");
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
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr1" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
			fnSelect();                                    
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
            
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);            
	</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>

	<script language=JavaScript  for=ds_cust_gu event="OnLoadCompleted(row)">
    	window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>	

<%
/*	============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<!--  지역 -->
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<!--  고객구분 -->
<object id=ds_cust_gu classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

									
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tr>
										<td>
											<table border="0" width="845px"  cellpadding="0" cellspacing="0">
												<tr height="50px">
													<td align="left" >
														<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
															<tr> 
																<td align="right">
																	<table border="0"  cellpadding="0" cellspacing="0" width="100%">
																		<tr>
																			<td align="right" height="30px">	
																			<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" align=absmiddle onclick="fnSelect()">
																				<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onclick="fnExcelDs1()">  																				
																				
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
											                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
											                            <tr bgcolor="#6f7f8d">
											            					<td align=left width=70 class="text">&nbsp;사업소</td>
											                                <td align=left bgcolor="#ffffff">&nbsp;																										
							      												<%=HDConstant.COMMENT_START%>
													                            <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
																					<param name=ComboDataID		value=ds_saup>
																					<param name=BindColumn      value="saup_sid">
							                                                        <param name=BindColVal      value="saup_sid">
																					<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
																					<param name=ListExprFormat  value="saup_nm^0^120"></object>
																				<%=HDConstant.COMMENT_END%>
																			</td>	
											            					<td align=left width=70 class="text">&nbsp;작업년월</td>
											                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
																		     	<%=HDConstant.COMMENT_START%>
																		     	<object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																					<param name=Text 		value="">
																					<param name=Alignment 	value=1>
																					<param name=Format 		value="0000-00">
																					<param name=Cursor	 	value="iBeam">
																					<param name=Border	 	value="0">		
																					<param name=InheritColor      value="true">																																																				
																					<param name=ReadOnly  	value="false">
																					<param name=SelectAll   value="true">																				
																					<param name=SelectAllOnClick   value="true">
																					<param name=SelectAllOnClickAny  	value="false">																				
																				</object>
																				<%=HDConstant.COMMENT_END%>&nbsp;
																			</td>	
											            					<td align=left width=70 class="text">&nbsp;고객구분</td>
											                                <td align=left bgcolor="#ffffff" width="400">&nbsp;																										
							      												<%=HDConstant.COMMENT_START%>
													                            <object id=lc_cust_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
																					<param name=ComboDataID		value=ds_cust_gu>
																					<param name=BindColumn      value="detail">
							                                                        <param name=BindColVal      value="detail">
																					<param name=EditExprFormat	value="%,%;detail,detail_nm">
																					<param name=ListExprFormat  value="detail_nm^0^120"></object>
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
																<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
																	<%=HDConstant.COMMENT_START%>
																	<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:390" border="1" >
								                            			<param name="DataID"		VALUE="ds1">
								                            			<param name="BorderStyle"   VALUE="0">
								                            			<param name=ColSizing       value="true">
								                            			<param name="editable"      value="false">
								                            			<param name=UsingOneClick  	value="1">
								                                        <Param Name="AllShowEdit"   value="True">
								                                        <param name="SortView"      value="Right">
								                                        <param name="ViewSummary"       value="1">
																		<param name=SuppressOption value=1>
																		<param name="Format" 			value="
															                <C> name='구분'      ID='depart_date'  width=80   align=center show=true  sumText='합계'</C>
															                <X> name='성별'
															                <G> name='계'
															                <C> name='남'   ID='qty_m' width=50  align=right  show=true sumText=@sum</C>
															                <C> name='여'        ID='qty_f'   width=50   align=right show=true sumText=@sum</C>
															                </G>
															                <G> name='내국인'
															                <C> name='남'   ID='qty_m10' width=50  align=right  show=true sumText=@sum</C>
															                <C> name='여'        ID='qty_f10'   width=50   align=right show=true sumText=@sum</C>
															                </G>
															                <G> name='외국인/교포'
															                <C> name='남'   ID='qty_m20' width=50  align=right  show=true sumText=@sum</C>
															                <C> name='여'        ID='qty_f20'   width=50   align=right  show=true sumText=@sum</C>
															                </G>															                															               
															                </X>
															                <G> name='연령별'															                
															                <C> name='계'        ID='qty_tt'   width=50    align=right   show=true sumText=@sum</C>
															                <C> name='10세미만'        ID='qty_00'   width=60    align=right  show=true sumText=@sum</C>
															                <C> name='10대'        ID='qty_10'   width=50    align=right  show=true sumText=@sum</C>
															                <C> name='20대'        ID='qty_20'   width=50    align=right   show=true sumText=@sum</C>
															                <C> name='30대'        ID='qty_30'   width=50    align=right  show=true sumText=@sum</C>
															                <C> name='40대'        ID='qty_40'   width=50    align=right   show=true sumText=@sum </C>
															                <C> name='50대'        ID='qty_50'   width=50    align=right  show=true sumText=@sum</C>
															                <C> name='60대'        ID='qty_60'   width=50    align=right  show=true sumText=@sum</C>
															                <C> name='70대이상'        ID='qty_70'   width=60    align=right   show=true  sumText=@sum</C>															                															                															                															                
															                </G>
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

