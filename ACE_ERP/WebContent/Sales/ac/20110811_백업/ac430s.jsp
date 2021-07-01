<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 환불내역조회
 * 프로그램ID 	: AC430S
 * J  S  P		: ac430s
 * 서 블 릿		: Ac430S
 * 작 성 자		: 남기표
 * 작 성 일		: 2006-08-03
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2008-11-18][심동현] REFUND_DATE = 환불결재일 (정산팀 이슬기)
 *						REFUND_DATE_TR = 환불입금일 (회계팀 박효경)
 * [2008-11-20][심동현] rv512s.jsp 환불내역과 동일:)
 * [2008-11-20][심동현] 1. 환불결재일자	完
 *						2. 작업상태 : 환불완료	完
 *						3. 작업유형 : 선택		
 *						4. 지역 : 전체...
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
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMddHHmm");
   String firstday = m_today.format(date.getTime()).substring(0,8);
   String firsttime = m_today.format(date.getTime()).substring(8,12);
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
		if (selectImgDs.countrow < 1){
			var s_temp1 = "PICTURE_INFO:STRING";
			selectImgDs.SetDataHeader(s_temp1);
		}
	}
	/*
	 * 선조회
	 */
	function fnInit(){
		sRfBgnDate.text='<%=firstday%>';
		sRfEndDate.text='<%=firstday%>';

        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		fnSetHeader();

        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";

		ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //지역코드
		/*
		ln_TRSetting(tr1, 
		    "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
		    "JSP(O:S_SAUP_DS_ALL=ds_saup)",
		    "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
		tr_post(tr1);//지역 전체
		*/
        
        //영업담당자
        ds_saldam.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy005H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_saldam.Reset();
        //대리점
        ds_client.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_client.Reset();
        //작업상태1
        ds_status1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_Item1=Y";
        ds_status1.Reset();
        //공제율
        ds_charge.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV027&s_Item1=Y";
        ds_charge.Reset();
        //송금은행
        ds_bancod.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC002&s_Item1=Y";
        ds_bancod.Reset();
        //공제코드
        codeDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV027&s_Item1=Y";
        codeDs1.Reset();
        //작업유형(검색)
        codeDsSrch.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV030&s_Item1=Y";
        codeDsSrch.Reset();

	}
	/*
	 * 메인조회
	 */
    function fnSelect() {
		if (ds1.isUpdated ) {
			alert("수정중인 행이 있습니다.");
			return;
		}
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sSaup_sid="	+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index) + ","
		    + "sGoods_sid="	+ lc_goods.ValueOfIndex("goods_sid", lc_goods.Index) + ","
            + "sSalDamSid=" + sSalDamSid.value + ","
            + "sClientSid=" + sClientSid.value + ","
            + "sStatusCd=" + ds_status1.namevalue(ds_status1.rowposition,"detail") + ","
            + "sBgnDate=" + sBgnDate.text + ","
            + "sEndDate=" + sEndDate.text + ","
            + "sAcceptNo=" + sAcceptNo.text + ","
            + "sCustNm=" + sCustNm.value +","
            + "sDpBgnDate=" + sDpBgnDate.text + ","
            + "sDpEndDate=" + sDpEndDate.text + ","
            + "sRfBgnDate=" + sRfBgnDate.text + ","
            + "sRfEndDate=" + sRfEndDate.text + ","            
            + "sJobType=" + codeDsSrch.namevalue(codeDsSrch.rowposition,"detail") ;


		//imgDs.ClearAll();
        ln_TRSetting(tr1,
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac430S",
            "JSP(O:DS1=ds1,O:IMAGE=imgDs)",
            param);
        tr_post(tr1);
    }


	// Description  :  엑셀 파일 출력 
    function fnExcel() {
        if(ds1.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:요청내역-취소/환불; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("요청내역-취소/환불", "요청내역-취소/환불.xls", 32);
    }	
	
	

	//상품조회
	function fnSelectGoodsLC() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
            + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			+ ",sDepartDate=";
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_GOODS_DS=ds_goods)",
            param);
        tr_post(tr2);
	};
	
	// 대리점팝업
	function fnPopup1() {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/cu001h.jsp?gubun=1";
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
		if ( dataSet == 'ds6' ) {	//대리점
			for ( i=1; i<=ds6.CountRow; i++ ) {
				if ( ds6.namevalue(i,"client_cd") == sClientCd.value ) {
					sClientSid.value = ds6.namevalue(i,"client_sid");
					sClientNm.value = ds6.namevalue(i,"client_nm");
					exit=true;
					return;
				}
			}
			if ( exit != true ) {
				sClientSid.value = '';
				sClientNm.value = '';
			}
		}
	}

	
</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language=JavaScript for=sBgnDate event=OnKillFocus()>
			if ( sBgnDate.Modified ) {
				sEndDate.text = sBgnDate.text;
			}
		</script>
		<script language=JavaScript for=sDpBgnDate event=OnKillFocus()>
			if ( sDpBgnDate.Modified ) {
				sDpEndDate.text = sDpBgnDate.text;
			}
		</script>		

	<script language=JavaScript for=codeDs1 event="OnLoadCompleted(row)">
		sJobType1.Index = 0;	//검색조건부분		
	</script>
	<script language=JavaScript for=ds_status1 event="OnLoadCompleted(row)">
		lc_status1.Index = 6;	//검색조건부분		
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
        var msg='';

        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";

            //메시지 처리
	        for ( j=1; j<=msgDS.CountRow; j++ )
	          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
	         if ( msgDS.CountRow > 0 )
	          	alert(msg);
        }  else if(v_job == "H" || v_job=="S") {
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
       	}
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

        //메시지 처리
		var msg='';
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 )
          	alert(msg);
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S") {
       	}
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr2" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";

        var alertMsg = '';
       	var nErrCnt = tr2.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++)
			alertMsg = "ErrorCode : " + tr2.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr2.SrvErrMsg("ERROR", i) + "\n";
        if ( nErrCnt > 0 )
		    alert(alertMsg);
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript	for=ds_saup event="OnLoadCompleted(row)">
		fnSelectGoodsLC();
	</script>
	<script language=JavaScript for=lc_saup event=OnSelChange()>
		fnSelectGoodsLC();//상품 재검색
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>

	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">

	</script>


	<script language=JavaScript  for=ds1 event="OnRowPosChanged(Row, Colid)">
	    if(Row<1) return;
	    imgDs.RowPosition = Row;
	</script>
	
	<script language=JavaScript  for=imgDs event="OnRowPosChanged(Row, Colid)">
	    if(Row<1) return;
	    if(imgDs.NameValue(Row, "PICTURE_INFO")!="")
	        photo.src = imgDs.NameValue(Row, "PICTURE_INFO");
	    else
	        photo.src = "<%=dirPath%>/Sales/images/00000.gif";

		selectImgDs.clearData();
	    selectImgDs.addrow();
	    selectImgDs.namevalue(1,"picture_info") = imgDs.namevalue(Row,"picture_info");
		selectImgDs.ResetStatus();

	</script>

<script language="javascript"  for=gr1 event=OnClick(row,colid)>
        if(row==0){
            if(ds1.CountRow==0) return;

            if(colid=="status_cd"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, "status_cd") = ds1.NameValue(1, "status_cd");
                }
            }
            return;
        }
 </script>

<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%><!-- 검색:지역  -->
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> 	<%//검색 : 지역%>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> 	<%//검색 : 상품%>
	<param name="SyncLoad" 	value="false">
</object>

<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_client classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_saldam classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_charge classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_bancod classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=imgDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=selectImgDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_client_info classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDsSrch classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
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

<table border="0" width="845px"  cellpadding="0" cellspacing="0">
	<tr height="30px">
		<td align="left" >
			<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
				<tr>
					<td width=700>
						<table border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
					  		<tr bgcolor="#6f7f8d"  >
		                  		<td align=center class="text" width="66">지역</td>
                  				<td align=left bgcolor="#ffffff" width=189>&nbsp;<%=HDConstant.COMMENT_START%>
			            	        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
										<param name=ComboDataID		value=ds_saup>
										<param name=BindColumn      value="saup_sid">
		    	                        <param name=BindColVal      value="saup_sid">
										<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
										<param name=ListExprFormat  value="saup_nm^0^60">
									</object>
									<%=HDConstant.COMMENT_END%>
							    </td>
							    <td align=center class="text" width="65">상품</td>
								<td align=left width="118" bgcolor="#ffffff" valign="middle">&nbsp;<%=HDConstant.COMMENT_START%>
			        	            <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=105 border="0" align=absmiddle>
										<param name=ComboDataID		value=ds_goods>
										<param name=BindColumn      value="goods_sid">
			                            <param name=BindColVal      value="goods_sid">
										<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
										<param name=ListExprFormat  value="goods_nm^0^100"></object>
									<%=HDConstant.COMMENT_END%>
							  	</td>	
            					<td align=center width=60 class="text"><b>환불결재</b></td>
                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
								     <object id=sRfBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
									<%=HDConstant.COMMENT_END%>&nbsp;-&nbsp;<%=HDConstant.COMMENT_START%>
								     <object id=sRfEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
									<%=HDConstant.COMMENT_END%>
								</td>							  	
						    </tr>
						</table>
					</td>
					<td align="right" width=145>							
						<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand;" onclick="fnSelect()">
                        <img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand" onClick="fnExcel()">
					</td>
				</tr>
			</table>
		</td>
	</tr>

	<tr height="30px">
		<td>
			<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
				<tr>
					<td  width="845px">
                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                            <tr bgcolor="#6f7f8d">
            					<td align=center width=65 class="text">영업담당자</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<input id="sSalDamCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="7" onBlur="fnSetting('ds_saldam')">
									<input id="sSalDamSid" type="hidden" value="0">
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="영업담당자를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup4();">
									<input id="sSalDamNm" type="text" class="textbox_d"  style= "position:relative;left:-0px;top:2px;width:80px; height:20px;" maxlength="50" onBlur="" readOnly>
								</td>
								<td align=center width=65 class="text">신청서번호</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
								     <object id=sAcceptNo classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=100 align=center class="textbox">
										<param name=Text 		value="">
										<param name=Alignment 	value=1>
										<param name=Format 		value="00000-000000000">
										<param name=Cursor	 	value="iBeam">
										<param name=Border	 	value="0">
										<param name=InheritColor      value="true">
										<param name=ReadOnly  	value="false">
										<param name=SelectAll   value="true">
										<param name=SelectAllOnClick   value="true">
										<param name=SelectAllOnClickAny  	value="false">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>
            					<td align=center width=60 class="text">출발일자</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
								     <object id=sDpBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
									<%=HDConstant.COMMENT_END%>&nbsp;-&nbsp;<%=HDConstant.COMMENT_START%>
								     <object id=sDpEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
									<%=HDConstant.COMMENT_END%>
								</td>
								<td align=center width=60 class="text">성명</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<input type="text" name="sCustNm" value="" size=10 class="textbox">
								</td>
            				</tr>
                            <tr bgcolor="#6f7f8d">
            					<td align=center class="text">대리점</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<input id="sClientCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="5" onBlur="fnSetting('ds_client')">
									<input id="sClientSid" type="hidden" value="0">
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="대리점를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup1();">
									<input id="sClientNm" type="text" class="textbox_d"  style= "position:relative;left:-0px;top:2px;width:80px; height:20px;" maxlength="50" onBlur="" readOnly>
								</td>
			            		<td align=center class="text"><B>작업상태</B></td>
			                    <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
		                            <object id=lc_status1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
										<param name=ComboDataID		value=ds_status1>
										<param name=BindColumn      value="detail">
                                        <param name=BindColVal      value="detail">
										<param name=EditExprFormat	value="%,%;detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^80"></object>
									<%=HDConstant.COMMENT_END%>
								</td>
            					<td align=center class="text">신청일자</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
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
									<%=HDConstant.COMMENT_END%>&nbsp;-&nbsp;<%=HDConstant.COMMENT_START%>
								     <object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
									<%=HDConstant.COMMENT_END%>
								</td>
								<td align=center class="text"><B>작업유형</B></td>
                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
		                            <object id=sJobType1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
										<param name=ComboDataID		value=codeDsSrch>
										<param name=BindColumn      value="detail">
                                        <param name=BindColVal      value="detail">
										<param name=EditExprFormat	value="%,%;detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^80">
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
	<tr>
		<td height="10"></td>
	</tr>
	<tr>
		<td width="845px">
		    <%=HDConstant.COMMENT_START%>
		    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:350" border="1" >
				<param name="DataID"		VALUE="ds1">
                <param name="BorderStyle"   VALUE="0">
                <param name=ColSizing       value="true">
                <param name="editable"      value="False">
                <param name=UsingOneClick  	value="1">
                <Param Name="AllShowEdit"   value="True">
                <param name="SortView"      value="Right">
                <param name="ViewSummary" 	value="1">
                <param name=SuppressOption  value="1">
				<param name="Format" 		value="
				<G> name='요청정보'
	                <C> name='요청관리번호'		ID='req_no'  width=90  Align=center Edit=None show=False Suppress=1 </C>
	                <C> name='작업상태'   		ID='status_cd' width=60  align=center editstyle=lookup edit=none Data='ds_status1:detail:detail_nm' show=False Suppress=1 </C>
	                <C> name='작업유형'   		ID='job_type' width=60  align=center editstyle=lookup edit=none Data='codeDsSrch:detail:detail_nm' show=true Suppress=1 Sumtext='총 입금'</C>
	                <C> name='공제코드'			ID='refund_charge_cd'	align=center	Width=60	Show=True	editstyle=lookup Data='codeDs1:detail:detail_nm' Suppress=1 Sumtext='@cnt'</C>
	                <C> name='공제율'    		ID='charge_rate' align=Right 	Width=50	show=True decao=1 Suppress=1 Sumtext='건'</C>
	                <C> name='수수료부담'  		ID='charge_pos' align=Center 	Width=70	show=True Suppress=1</C>
   	                <C> name='환불요청액'		ID='rq_amt'		align=Right  Width=80 show=True decao=0 Suppress=1</C>
				</G>
				<G> name='예약정보'
	                <C> name='출발일'  			ID='depart_date'	Width=70 Align=Center Show=True Suppress=1</C>
					<C> name='상품명'   	  	ID='GOODS_NM'       width=100       align=center     editlimit=50 show=true Suppress=1</C>
	                <C> name='신청서번호'		ID='accept_no'  	width=100 align=center editlimit=15 edit=none show=true sort=true Suppress=1</C>
	                <C> name='이름'      		ID='cust_nm'   		width=60  align=left editlimit=30 edit=none show=true sort=true Suppress=1</C>
	                <C> name='주민/여권번호'    ID='manage_no'   	width=30 align=left editlimit=20 show=false Suppress=1</C>
	                <C> name='직장명'   		ID='company_nm'  	width=30 align=left editlimit=30 show=false Suppress=1</C>
	                <C> name='직위'    			ID='positions'   	width=30 align=left editlimit=30 show=false Suppress=1</C>
	                <C> name='판매가'			ID='tour_amt'    	width=70 Align=Right Show=True decao=0 Suppress=1</C>
				</G>
				<G> name='입금정보'
	                <C> name='입금액'			ID='pay_amt'		width=70 Align=Right Show=True decao=0 Sumtext='@sum'</C>
					<C> name='결제관리번호'		ID='PAY_MANAGE_NO'  width=80 align=center   editlimit=50 show=true </C>
					<C> name='결제수단'       	ID='PAY_CD'         width=60 align=left     editlimit=50 show=true</C>
					<C> name='입금일'           ID='PAY_DATE'       width=70 align=center   editlimit=50 show=true mask='XXXX-XX-XX'</C>
					<C> name='입금자'           ID='U_EMPNO'        width=60 align=center   editlimit=50 show=true </C>
	                <C> name='환불액'			ID='REFUND_AMT'		width=70 align=Right show=True decao=0 Sumtext='@sum'</C>
					<C> name='환입액'       	ID='FUND_AMT'       width=70 align=right   show=true decao=0 Sumtext='@sum'</C>
				</G>
				<G> name='환불정보'
	                <C> name='은행'       		ID='bannm'  	    width=90 align=left editlimit=20 show=True Suppress=2</C>
	                <C> name='계좌번호'  		ID='bank_acc_no'    width=90 align=left editlimit=20 show=True Suppress=2</C>
	                <C> name='예금주' 			ID='bank_acct_nm'   width=90 align=left editlimit=32 show=True Suppress=2</C>
				</G>
					<C> name='영업\\담당자'     ID='SAL_DAM_NM'     width=60 align=center   editlimit=50 show=true Suppress=2</C>
	                <C> name='요청\\신청자'		ID='rq_empno'		width=70 align=center edit=none show=False Suppress=2</C>
	                <C> name='요청\\신청일자'	ID='accept_date'	width=70 align=left edit=none show=true mask='XXXX-XX-XX' Suppress=2</C>
	                <C> name='영업\\접수자'		ID='re_empno'		width=70 align=center edit=none show=False Suppress=2</C>
	                <C> name='영업\\접수일시'	ID='re_date'		width=70 align=left edit=none show=False Suppress=2</C>
	                <C> name='정산\\접수자'		ID='ac_empno'		width=70 align=center edit=none show=true Suppress=2</C>	                
	                <C> name='정산\\접수일시'	ID='ac_date'		width=70 align=left edit=none show=False Suppress=2</C>
	                <C> name='환불일\\(결재)'	ID='refund_date'	width=70 align=center edit=none show=true mask='XXXX-XX-XX' Suppress=2</C>
	                <C> name='환불일\\(입금)'	ID='refund_date_tr'	width=70 align=center edit=none show=true mask='XXXX-XX-XX' Suppress=2</C>
					<C> name='수정일'			ID='U_DATE'			width=80 align=center   editlimit=50 show=False mask='XXXX-XX-XX' Suppress=2</C>
	               ">
			</object>
			<%=HDConstant.COMMENT_END%>
		</td>
	</tr>
	<tr>
		<td>※ 요청관리번호의 가운데 6자리가 신청일자입니다.
		</td>
	</tr>		
</table>

<input type="hidden" name="row" value="">
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

