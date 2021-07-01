<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 관광객 명단
 * 프로그램ID 	 : CQ520S
 * J  S  P		 : cq520s
 * 서 블 릿		 : CQ520S
 * 작 성 자		 : 안준성
 * 작 성 일		 : 2006-07-26 
 * 기능정의		 : 관광객 명단 (조회)
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
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
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
        cfStyleGrid(getObjectFirst("gr2"), "comn");
        cfStyleGrid(getObjectFirst("gr3"), "comn");                
		fnSetHeader();

		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
		sBgnDate.text='<%=firstday%>';
				
		 //지역코드
		ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //지역코드
        //상품정보
        ds_goods.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_goods.Reset();
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {
    	if ( sBgnDate.text.trim() == '' ) {
			alert("출발일자를 입력해주세요.");
			return;
		}    
        v_job = "S";
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sSaupSid=" + ds_saup.namevalue(ds_saup.rowposition,"saup_sid") + ","        
            + "sBgnDate=" + sBgnDate.text + ","
            + "sDepartTime=" + ds_depart_time.namevalue(ds_depart_time.rowposition,"depart_time") + ","            
            + "sGoodsSid=" + sGoodsSid.value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq520S",
            "JSP(O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)",
            param);
        tr_post(tr1);

    }
	/*
	 * 상품정보 팝업
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
	    	sGoodsSid.value = 0;
			sGoodsCd.value = '';
			sGoodsNm.value = '';					
		}
	} 
	/*
	 * 엑셀
	 */
	function fnExcelDs1() {
		gr1.runexcelsheet("총괄");
		gr2.runexcelsheet("탑승자 명단");
		gr3.runexcelsheet("미탑승자 명단");				
	}	
	/*
	 * 출경시간
	 */		
	function fnSelectDsDepartTime() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds_saup.namevalue(ds_saup.rowposition,"saup_sid") + ","
			+ "sDepartDate=" + sBgnDate.text;
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_DEPART_TIME_DS=ds_depart_time)",
            param);
        tr_post(tr2);
	}		
	/*
	 * 상품정보 자동셋팅(조건)
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnSetting(dataSet) {
		var exit=false;		   
		if ( dataSet == 'ds_goods' ) {	//상품정보
			for ( i=1; i<=ds_goods.CountRow; i++ ) {
				if ( ds_goods.namevalue(i,"goods_cd") == sGoodsCd.value ) {
					sGoodsSid.value = ds_goods.namevalue(i,"goods_sid");
					sGoodsNm.value = ds_goods.namevalue(i,"goods_nm");
					exit=true;					
					return;
				}
			}
			if ( exit != true ) {
				sGoodsSid.value = 0;
				sGoodsNm.value = '';			
			}			
		}		
	} 		
    </script>	
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript for= lc_saup event=OnSelChange()>
		if ( div != 'init' ) {	//지역
			div = 'init';			
			fnSelectDsDepartTime();
		}
	</script>
	
	<script language=JavaScript for=sBgnDate event=OnKillFocus()>
		if ( div != 'init' ) {	//출발일자
			if ( sBgnDate.Modified ) {
				div = 'init';
				fnSelectDsDepartTime();			
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
    	window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr2" event="onsuccess()">
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
	<script language="javascript" for="tr2" event="onfail()">
    	window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>	
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds_saup event="OnLoadCompleted(row)">
		fnSelectDsDepartTime();
	</script>
	
	<script language=JavaScript  for=ds_depart_time event="OnLoadCompleted(row)">
		div='';
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
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<!--  지역 -->
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<!-- 상품정보 -->
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<!-- 출경시간 -->
<object id=ds_depart_time classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
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
																				<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onclick="fnExcelDs1()">  																				
																				<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" align=absmiddle onclick="fnSelect()">
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
											            					<td align=left width=70 class="text">&nbsp;지역</td>
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
											            					<td align=left width=70 class="text">&nbsp;출발일자</td>
											                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
																		     	<%=HDConstant.COMMENT_START%>
																		     	<object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
																				</object>
																				<%=HDConstant.COMMENT_END%>&nbsp;
							      												<%=HDConstant.COMMENT_START%>
													                            <object id=lc_depart_time classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=50 border="0" align=absmiddle>
																					<param name=ComboDataID		value=ds_depart_time>
																					<param name=BindColumn      value="depart_time">
							                                                        <param name=BindColVal      value="depart_time">
																					<param name=EditExprFormat	value="%,%;depart_time,depart_time_nm">
																					<param name=ListExprFormat  value="depart_time_nm^0^50">
																				</object>
																				<%=HDConstant.COMMENT_END%>																				
																			</td>																				
											            					<td align=left width=70 class="text">상품</td>
											                                <td align=left bgcolor="#ffffff" colspan="3" width="350">&nbsp;																										
																				<input id="sGoodsSid" type="hidden" value="0">                                
																				<input id="sGoodsCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="7" onBlur="fnSetting('ds_goods')">
																				<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="상품을 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup();">
																				<input id="sGoodsNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;" readOnly>																						
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
																<object id=mxTab classid=CLSID:ED382953-E907-11D3-B694-006097AD7252
																		style="position:absolute; left:170; top:170; width:845; height:20">
																	<param name="BackColor"			value="#00ffff">
																	<param name="DisableBackColor"	value="#ffffee">
																	<param name="Format"			value='
																		<T>divid="mxTab_page1"	title="총괄"</T>
																		<T>divid="mxTab_page2"	title="탑승자 명단"</T>
																		<T>divid="mxTab_page3"	title="미탑승자 명단"</T>'>																		
																</object>
																<%=HDConstant.COMMENT_END%>
																<div class=page id="mxTab_page1" style="position:absolute; left:170; top:190; width:845; height:300">
																<%=HDConstant.COMMENT_START%>
																	<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:360" border="1" >
								                            			<param name="DataID"		VALUE="ds1">
								                            			<param name="BorderStyle"   VALUE="0">
								                            			<param name=ColSizing       value="true">
								                            			<param name="editable"      value="false">
								                            			<param name=UsingOneClick  	value="1">
								                                        <Param Name="AllShowEdit"   value="True">
								                                        <param name="SortView"      value="Right">
																		<param name=SuppressOption value=1>
																		<param name="Format" 			value="
															                <C> name='고객구분'      ID='cust_gu'  width=60   align=left editlimit=50 show=true</C>
															                <C> name='국적구분'   ID='country_gu' width=60  align=left editlimit=50 show=true</C>
															                <C> name='인원'        ID='i_cnt'   width=40  value={IF(LastRow=CurRow,String(''),i_cnt)}   align=right editlimit=11 show=true</C>
															                <C> name='총계'        ID='t_cnt'   width=40  value={IF(t_cnt=0,String(''),t_cnt)}   align=right editlimit=11 show=true</C>
																		">
																	</object>
																	<%=HDConstant.COMMENT_END%>
																</div>
																<div class=page id="mxTab_page2" style="position:absolute; left:170; top:190; width:845; height:300">
																	<%=HDConstant.COMMENT_START%>
																	<object id=gr2 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:360" border="1" >
								                            			<param name="DataID"		VALUE="ds2">
								                            			<param name="BorderStyle"   VALUE="0">
								                            			<param name=ColSizing       value="true">
								                            			<param name="editable"      value="false">
								                            			<param name=UsingOneClick  	value="1">
								                                        <Param Name="AllShowEdit"   value="True">
								                                        <param name="SortView"      value="Right">
																		<param name=SuppressOption value=1>
																		<param name=ViewSummary     value=1>
																		<param name="Format" 			value="
															                <C> name='호차'    ID='ho_car_nm' width=40  align=left editlimit=50 show=true SumText='계'</C>
															                <C> name='순번'      ID='tour_no'  width=40    align=right editlimit=20 show=true SumText=@count</C>
															                <C> name='반'        ID='class'     width=40   align=left editlimit=50 show=true</C>
															                <C> name='조'        ID='teams'     width=40   align=right editlimit=3 show=true</C>
															                <C> name='성명'      ID='cust_nm'   width=60   align=left editlimit=30 show=true</C>
															                <C> name='성명(영문)'     ID='cust_enm'  width=130   align=left editlimit=61 show=true</C>
															                <C> name='성별'  ID='sex'      width=40    align=center editlimit=50 show=true</C>
															                <C> name='생년월일'     ID='birthday'  width=70   align=left editlimit=8 show=true mask=XXXX-XX-XX</C>
															                <C> name='직장/직위'      ID='comp_nm'  width=140   align=left editlimit=61 show=true</C>
															                <C> name='직장/직위(영문)'     ID='comp_enm'  width=160   align=left editlimit=61 show=true</C>
															                <C> name='사는곳'     ID='address1'  width=90   align=left editlimit=60 show=true</C>
															                <C> name='국적/민족'   ID='country_cd' width=70  align=left editlimit=101 show=true</C>
															                <C> name='여권종류'    ID='pass_type'  width=80  align=left editlimit=50 show=true</C>
															                <C> name='여권번호'      ID='pass_no'   width=80   align=left editlimit=20 show=true</C>
															                <C> name='상태'    ID='status_cd' width=50   align=left editlimit=50 show=true</C>															                
																		">
																	</object>
																	<%=HDConstant.COMMENT_END%>
																</div>
																<div class=page id="mxTab_page3" style="position:absolute; left:170; top:190; width:845; height:300">
																	<%=HDConstant.COMMENT_START%>
																	<object id=gr3 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:360" border="1" >
								                            			<param name="DataID"		VALUE="ds3">
								                            			<param name="BorderStyle"   VALUE="0">
								                            			<param name=ColSizing       value="true">
								                            			<param name="editable"      value="false">
								                            			<param name=UsingOneClick  	value="1">
								                                        <Param Name="AllShowEdit"   value="True">
								                                        <param name="SortView"      value="Right">
																		<param name=SuppressOption value=1>
																		<param name=ViewSummary     value=1>
																		<param name="Format" 			value="
															                <C> name='순번'      ID='tour_no'  width=40   align=right editlimit=20 show=true SumText='계'</C>
															                <C> name='반'        ID='class'    width=40   align=left editlimit=50 show=true SumText=@count</C>
															                <C> name='조'        ID='teams'   width=40    align=right editlimit=3 show=true</C>
															                <C> name='성명'      ID='cust_nm'  width=60    align=left editlimit=30 show=true</C>
															                <C> name='성명(영문)'     ID='cust_enm'  width=130  align=left editlimit=61 show=true</C>
															                <C> name='성별'  ID='sex'     width=40    align=center editlimit=50 show=true</C>
															                <C> name='생년월일'     ID='birthday'  width=70   align=center editlimit=8 show=true mask=XXXX-XX-XX</C>
															                <C> name='직장/직위'      ID='comp_nm'  width=140   align=left editlimit=61 show=true</C>
															                <C> name='직장/직위(영문)'     ID='comp_enm'  width=160  align=left editlimit=61 show=true</C>
															               <C> name='사는곳'     ID='address1' width=120   align=left editlimit=60 show=true</C>
															               <C> name='국적/민족'   ID='country_cd' width=70 align=left editlimit=101 show=true</C>
															               <C> name='여권종류'    ID='pass_type'  width=80 align=left editlimit=50 show=true</C>
															               <C> name='여권번호'      ID='pass_no'   width=80  align=left editlimit=20 show=true</C>                
																		">
																	</object>
																	<%=HDConstant.COMMENT_END%>
																</div>
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
					</table>


<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

