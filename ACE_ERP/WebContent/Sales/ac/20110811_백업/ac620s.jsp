<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 관광예약현황
 * 프로그램ID   : RV200S
 * J  S  P      : rv200s
 * 서 블 릿        : Rv200S
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-07-14
 * 기능정의     :
 * 수정내용         :  대리점 주중/주말 수수료 분리..
 *               기존 현황표 + 상세표..
 * 수 정 자           :  심동현
 * 최종수정일자   : 2007-06-04 
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

    //대리점 구분
    HDCookieManager cookie = new HDCookieManager(request, response);
    String v_ut = cookie.getCookieValue("ut", request);
    String c_sid = cookie.getCookieValue("c_sid",request);
    String c_cd = cookie.getCookieValue("c_cd",request);
    String c_nm = cookie.getCookieValue("c_nm",request);
    String c_title = cookie.getCookieValue("c_title", request);
    String user_id = cookie.getCookieValue("user_id",request);
    String user_name = cookie.getCookieValue("user_name", request);
    String user_isfrom = cookie.getCookieValue("user_from", request);

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
/****************************************************************************
                사용자 스크립트
******************************************************************************/
%>      
    <script language="javascript">
        var v_default_row = 1;
        /*
         * 페이지로딩
         */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit(); 
	} 
        
        /*
         * 초기작업
         * Header 설정 
         * 지역
         */
        function fnInit() {
            cfStyleGrid(getObjectFirst("gr_default"), "comn");
            cfStyleGrid(getObjectFirst("gr_detail"), "comn");

		    //지역코드
			ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds2.Reset();
	        
	 		//영업담당자
	        ds_saldam.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy005H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
	        ds_saldam.Reset();  
	        
	        //대리점
	        ds_client.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
	        ds_client.Reset(); 

			//수수료 코드
            codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC020";
            codeDs1.Reset();

			getObjectFirst("v_job_yymm").focus();
        }
        
        function fnSelect(){
            if(getObjectFirst("v_job_yymm").Text.trim()=="" 
                || getObjectFirst("v_job_yymm").Text.trim().length!=6){
                alert("작업년월<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_job_yymm").Focus();
                return;
            }
            
            gr_default.ReDraw = "False";
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ", dsType=1"
                        + ", v_job_yymm="+getObjectFirst("v_job_yymm").Text
           	            + ", sClientSid=" + sClientSid.value
                        + ", sSalDamSid=" + sSalDamSid.value
						+ ", sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index);	// 지역추가
            

            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac620S",
                "JSP(O:DEFAULT=ds_default,O:DETAIL=ds_detail)",
                v_param);
            tr_post(tr1);
        }
        
        function fnExcel() {
            if(ds_default.CountRow==0){
                alert("데이터를 먼저 조회하시길 바랍니다.");
                return;
            }
            getObjectFirst("gr_detail").SetExcelTitle(0, "");
            getObjectFirst("gr_detail").SetExcelTitle(1, "value:대리점별 수수료 상세; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr_detail").GridToExcel("대리점별 수수료 상세", "대리점별수수료상세.xls", 32);

            getObjectFirst("gr_default").SetExcelTitle(0, "");
            getObjectFirst("gr_default").SetExcelTitle(1, "value:대리점별 수수료 현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr_default").GridToExcel("대리점별 수수료 현황", "대리점별수수료현황.xls", 32);
        }

	/*
	 * 대리점 자동셋팅(조건)
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnSetting(dataSet) {
		var exit=false;	
		if ( dataSet == 'ds_saldam' ) {	//영업담당자
			for ( i=1; i<=ds_saldam.CountRow; i++ ) {
				if ( ds_saldam.namevalue(i,"sal_dam_cd") == sSalDamCd.value ) {
					sSalDamSid.value = ds_saldam.namevalue(i,"sal_dam_sid");
					sSalDamNm.value = ds_saldam.namevalue(i,"sal_dam_nm");
					exit=true;					
					return;
				}
			}
			if ( exit != true ) {
					sSalDamSid.value = '';
					sSalDamNm.value = '';
			}		
		}

		if ( dataSet == 'ds_client' ) {	//대리점
			for ( i=1; i<=ds_client.CountRow; i++ ) {
				if ( ds_client.namevalue(i,"client_cd") == sClientCd.value ) {
					sClientSid.value = ds_client.namevalue(i,"client_sid");
					sClientNm.value = ds_client.namevalue(i,"client_nm");
					exit=true;					
					return;
				}
			}
			if ( exit != true ) {
				sClientSid.value = 0;
				sClientNm.value = '';
			}			
		}
	}    
	     
	/*
	 * 영업담당자 팝업
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnPopup4() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/sy005h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);	

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sSalDamSid.value = arrParam[0];
				sSalDamCd.value = arrParam[1];
				sSalDamNm.value = arrParam[2];					
			} else {
		    	sSalDamSid.value = 0;
				sSalDamCd.value = '';
				sSalDamNm.value = '';					
			}
	} 		

	/*
	 * 대리점팝업
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnPopup() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/cu001h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);	

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sClientSid.value = arrParam[0];
				sClientCd.value = arrParam[2];
				sClientNm.value = arrParam[1];					
			} else {
		    	sClientSid.value = 0;
				sClientCd.value = '';
				sClientNm.value = '';
			}
	}	
	
    </script>

<script language="javascript" for="tr1" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr1" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
    var error_cnt = tr1.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>

<script language=javascript for=ds_default event="OnLoadCompleted(Row)">
    if(Row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }
</script>


<%
/*******************************************************************************
            가우스 오브젝트  Dataset , TR 선언
****************************************************************************** */
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/

%>
<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>

<object id=ds_saldam classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_client classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 지역 -->
    <param name="SyncLoad"  value=false>
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
      
	<table border='0' cellpadding="0" cellspacing="0" width="845"> 
		<tr>
			<td align=right>
				<table width='845'>
					<tr>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
							<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcel()">		<!-- 엑셀 -->
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="5px">
			<td></td>
		</tr>
		
		<tr height="30px">
			<td width='845px'>
				<table border='0' cellpadding='0' cellspacing='1' width='200' bgcolor="#666666">
					<tr height='30px'>
						<td align=left class="text" width="70px">지역</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							<%=HDConstant.COMMENT_START%>
	                        <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds2>
								<param name=BindColumn      value="saup_sid">
	                            <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^120">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>	
					</TR>
				</TABLE>
			</TD>
		</TR>
		<tr height="5px">
			<td></td>
		</tr>
		<tr height="30px">
			<td width=845>
                <table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    <tr height='25px'>
                        <td class="text"  width="70">출발일자</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_job_yymm classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                <param name=Text        value="<%=firstday%>">
                                <param name=Alignment   value=1>
                                <param name=Format      value="YYYY-MM">
                                <param name=InputFormat value="YYYYMMDD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">
                                <param name=InheritColor      value="true">
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                            <%=HDConstant.COMMENT_END%>                                                                             
                        </td>
                    	<td align=left width=70 class="text">&nbsp;영업담당자</td>
                        <td align=left bgcolor="#ffffff" colspan="2">&nbsp;																										
							<input id="sSalDamSid" type="hidden" value="0">                                
							<input id="sSalDamCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="7" onBlur="fnSetting('ds_saldam')">
							<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="영업담당자를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup4();">
							<input id="sSalDamNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;" maxlength="50" onBlur="" readOnly>																						
						</td>
    					<td align=left width=70 class="text">&nbsp;매출처</td>
                        <td align=left bgcolor="#ffffff">&nbsp;																										
							<input id="sClientSid" type="hidden" value="0">                                
							<input id="sClientCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:40px; height:20px;" maxlength="5" onBlur="fnSetting('ds_client')">
							<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="대리점를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup();">
							<input id="sClientNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;" maxlength="50" onBlur="" readOnly>																						
						</td>																				
						
                    </tr>
                </table>
            </td>
        </tr> 
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td width="845" valign=top>
                <table border=0 cellspacing=0 cellpadding=0 width="100%">
                    <tr>
                        <td width=845>
							<%=HDConstant.COMMENT_START%>
							<object id=mxTab classid=CLSID:ED382953-E907-11D3-B694-006097AD7252 style="position:absolute; left:170; top:200; width:845; height:20">
								<param name="BackColor"			value="#00ffff">
								<param name="DisableBackColor"	value="#ffffee">
								<param name="Format"			value='
									<T>divid="mxTab_page1"	title="수수료 현황"</T>
									<T>divid="mxTab_page2"	title="대리점별 수수료 상세"</T>'>
							</object>
							<%=HDConstant.COMMENT_END%>	

							<div class=page id="mxTab_page1" style="position:absolute; left:170; top:220; width:845; height:400">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='400px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="true">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name="Format"            value="
                                  <G> name='구분'
                                     <C> name='대리점코드'       ID='CLIENT_CD'      width=80  align=center Edit=None suppress=1 SumText='합계'</C>
                                     <C> name='대리점명'        ID='CLIENT_NM'      width=105 align=left   Edit=None suppress=2 SumText=@count</C>
                                  </G>
                                     <C> name='인원'			  ID='PERSON_CNT'	  width=70 align=right Edit=None</C>
                                     <C> name='매출액'         ID='TOUR_AMT'       width=100  align=right  Edit=None SumText=@sum dec=0</C>
                                     <C> name='수수료율'        ID='COMM_RATE'      width=100 align=right  Edit=None dec=2 show=false</C>
                                     <C> name='수수료'         ID='COMM_AMT'       width=100  align=right  Edit=None SumText=@sum dec=0</C>
                                     <C> name='조정수수료'        ID='CONT_AMT'       width=80  align=right  Edit=None SumText=@sum dec=0</C>
                                  <G> name='수수료내역'
                                     <C> name='공급가액'        ID='SALE_AMT'       width=80  align=right  Edit=None SumText=@sum dec=0</C>
                                     <C> name='부가세'         ID='TAX_AMT'        width=80  align=right  Edit=None SumText=@sum dec=0</C>
                                     <C> name='합계'          ID='TOT_AMT'        width=100  align=right  Edit=None SumText=@sum dec=0</C>
                                  </G>
                             ">                             
                            </object>   
                            <%=HDConstant.COMMENT_END%>
							</div>
							<div class=page id="mxTab_page2" style="position:absolute; left:170; top:220; width:845; height:400">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_detail classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='400px' border='1'>
                                <param name="DataID"            value="ds_detail">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="true">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name="Format"            value="
                                  <G> name='구분'
                                     <C> name='코드'       ID='CLIENT_CD'      width=50  align=center Edit=None suppress=1</C>
                                     <C> name='대리점명'    ID='CLIENT_NM'      width=105 align=left   Edit=None suppress=2</C>
                                     <C> name='수수료'    ID='COMM_CD'     width=40 align=CENTER  Edit=None editstyle=lookup data='codeDs1:detail:detail_nm'</C>
                                     <C> name='%'    ID='COMM_RATE'     width=40 align=right  Edit=None dec=2</C>
                                  </G>
                                     <C> name='인원'		   ID='PERSON_CNT'	  width=50 align=right Edit=None SumText=@sum dec=0</C>
                                     <C> name='매출액'      ID='TOUR_AMT'       width=100  align=right  Edit=None dec=0 SumText=@sum</C>
                                     <C> name='수수료'         ID='COMM_AMT'       width=100  align=right  Edit=None SumText=@sum dec=0</C>
                                     <C> name='조정수수료'        ID='CONT_AMT'       width=80  align=right  Edit=None SumText=@sum dec=0</C>
                                     
                                  <G> name='수수료내역'
                                     <C> name='공급가액'        ID='SALE_AMT'       width=80  align=right  Edit=None dec=0 SumText=@sum</C>
                                     <C> name='부가세'         ID='TAX_AMT'        width=80  align=right  Edit=None dec=0 SumText=@sum</C>
                                     <C> name='합계'          ID='TOT_AMT'        width=100  align=right  Edit=None dec=0 SumText=@sum</C>
                                  </G>
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

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

