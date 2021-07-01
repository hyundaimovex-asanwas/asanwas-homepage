<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 미출경자 출력
 * 프로그램ID 	 : CQ510S
 * J  S  P		 : cq510s
 * 서 블 릿		 : CQ510S
 * 작 성 자		 : 안준성
 * 작 성 일		 : 2006-07-24
 * 기능정의		 : 미출경자 출력 (조회)
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
   date.set(java.util.Calendar.HOUR_OF_DAY, 1440);      
   String lastday = m_today.format(date.getTime());

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
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		fnSetHeader();

		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
		ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //지역코드
		
        ds_goods.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_goods.Reset();//상품정보
        
		sBgnDate.text='<%=firstday%>';
		sEndDate.text='<%=lastday%>';        
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {
    	if ( sBgnDate.text.trim() == '' ||  sEndDate.text.trim() == '' ) {
			alert("출발일자를 입력해주세요.");
			return;
		}    
        v_job = "S";
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sSaupSid=" + ds_saup.namevalue(ds_saup.rowposition,"saup_sid") + ","        
            + "sBgnDate=" + sBgnDate.text + ","
            + "sEndDate=" + sEndDate.text +","
            + "sGoodsSid=" + sGoodsSid.value + ","
            + "v_out_gubn=" + v_out_gubn.value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq510S",
            "JSP(O:DS1=ds1)",
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
		gr1.runexcelsheet("미출경자 출력");
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
	<script language=JavaScript  for=ds_goods event="OnLoadCompleted(row)">
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
<!-- 상품정보 -->
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
			            					<td align=left width=50 class="text">&nbsp;지역</td>
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
			            					<td align=left width=50 class="text">&nbsp;출경일</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
										     <comment id="__NSID__"><object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
										     <comment id="__NSID__"><object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
											</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
											</td>																				
			            					<td align=left width=50 class="text">상품</td>
			                                <td align=left bgcolor="#ffffff" colspan="3" width="200">&nbsp;																										
												<input id="sGoodsSid" type="hidden" value="0">                                
												<input id="sGoodsCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="7" onBlur="fnSetting('ds_goods')">
												<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="상품을 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup();">
												<input id="sGoodsNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;" readOnly>																						
											</td>
											<td align=left class="text">출경구분</td>
		                                    <td align=left bgcolor="#ffffff" valign="middle" colspan=5>&nbsp;
		                                        <select name="v_out_gubn" id="v_out_gubn" class="textbox">
		                                            <option value="">전체
		                                            <option value="Y">출경
		                                            <option value="N">미출경
		                                        </select>
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
							                <c> name='순번'            ID='{CURROW}'      	Width=30    align=right</c>
							                <C> name='출발일자'  ID='depart_date'         width=70 align=center editlimit=10 show=true</C>
							                <C> name='출경시간'  ID='depart_time'         width=55 align=center editlimit=5 show=true</C>
							                <C> name='상품'     ID='goods_nm'    width=100 align=left editlimit=40 show=true</C>
							                <C> name='성명'      ID='cust_nm'     width=60 align=left editlimit=30 show=true sort=true</C>
							                <C> name='주민등록번호'    ID='manage_no'   width=100 align=center editlimit=20 show=false</C>
							                <C> name='생년월일'    ID='birthday'   width=100 align=center show=true</C>
							                <C> name='국가명'    ID='country_nm'   width=80 align=center show=true</C>
							                <C> name='국가코드'    ID='country_cd2'   width=80 align=center editlimit=20 show=true</C>
							                <C> name='반'        ID='class'       width=50 align=left editlimit=50 show=true</C>
							                <C> name='조'        ID='teams'       width=30 align=right editlimit=3 show=true</C>
							                <C> name='직장직위'   ID='company_nm'  width=110 align=left editlimit=30 show=true</C>
							                <C> name='주소'     ID='address1'    width=120 align=left editlimit=60 show=true</C>
							                <C> name='여권번호'     ID='pass_no'    width=100 align=left editlimit=60 show=true</C>
							                <C> name='성별'  ID='sex'         width=30 align=center editlimit=50 show=true</C>
							                <C> name='성별영문'     ID='sex_cd2'    width=70 align=right editlimit=60 show=true</C>
							                <C> name='출발지'     ID='start_end'    width=60 align=right editlimit=60 show=true</C>
							                <C> name='도착지'     ID='end_start'    width=60 align=right editlimit=60 show=true</C>
							                <C> name='상태'    ID='status_cd'   width=30 align=left editlimit=50 show=true</C>
											<C> name='관광증 No'     ID='tour_no'    width=80 align=right editlimit=60 show=true</C>
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

