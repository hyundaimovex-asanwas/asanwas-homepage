<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 관광증출력
 * 프로그램ID 	: CQ030S
 * J  S  P		: cq030s
 * 서 블 릿		: Cq030S
 * 작 성 자		: 구자헌
 * 작 성 일		: 2006-06-28
 * 기능정의		: 관광증 조회,출력
 * [수  정   일  자][수정자] 내용
 * [2006-10-31][심동현] 위치 및 디테일 수정,외국인용 관광증 추가
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2007-12-11][심동현] 이름 폰트 볼드 적용, 사이즈 크게
 * [2008-08-18][심동현] 취소자의 경우도 필요시 출력가능할 수 있게.
 * [2010-10-26][심동현] 2010 이산가족 대비 관광증 위치 수정.
 * [2013-08-26][심동현] 2013 이산가족 준비 행사관련 관광증 사진 위치 수정. 
 *					cq030s_20130826 버전이 백업
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
   date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
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
        var v_job = "H";
        var div='';
	/*
	 * Description 	:  페이지 로딩 
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

		txt_depart_date.text='<%=firstday%>';
		fnInit();
	}

	/*
	 * Description : 초기화
	 * 고객정보를 얻어온다
	 */
	function fnInit(){
		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";   
        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds2.Reset(); //지역코드
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS5=ds5,O:COUNTRY=ds8)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);

	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  메인조회
// Parameter 	: 
%>
	function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("수정중인 행이 있습니다."); 
		} else {        
			if ( txt_depart_date.text.trim() == '' ) {
				alert("출발일자를 입력해주세요.");
				return;
			}			

	        v_job = "S";
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        document.all.LowerFrame.style.visibility="visible";	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
				+ "sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index) + ","
				+ "sDepartDate=" + txt_depart_date.text + ","
				+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time",drp_depart_time.Index) + ","
				+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","
				+ "sClass=" + drp_class.ValueOfIndex("class",drp_class.Index) + ","
				+ "sTeams=" + drp_teams.ValueOfIndex("teams",drp_teams.Index) + ","
				+ "sCountryGu=" + drp_country_cd.ValueOfIndex("detail",drp_country_cd.Index) + ","
				+ "sManageNo=" + txt_manage_no.value + ","
				+ "sStatusCd=" + check_status_cd.checked;
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq030S",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
        }
	}

	/*
	 * 출경시간, 상품조회
	 */		
	function fnSelectDs3() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
			+ "sDepartDate=" + txt_depart_date.text;
		//alert(param);
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_DEPART_TIME_DS=ds3,O:S_GOODS_DS=ds4)",
            param);
        tr_post(tr2);
    }	
	/*
	 * 반조회
	 */		
	function fnSelectDs6() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
			+ "sDepartDate=" + txt_depart_date.text + ","	            
			+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","
            + "sDepartTime=" + ds3.namevalue(ds3.rowposition,"depart_time");			
        ln_TRSetting(tr3, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS6=ds6)",
            param);
        tr_post(tr3);
	}	  

	/*
	 * 조 조회
	 */		
	function fnSelectDs7() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
        	+ "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
            + "sDepartDate=" + txt_depart_date.text + ","	
           	+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time", drp_depart_time.Index) + "," 
            + "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","     
            + "sClass=" + ds6.namevalue(ds6.rowposition,"class");
        ln_TRSetting(tr4, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS7=ds7)",
            param);
        tr_post(tr4);
	}		

	function fnExcel() {
		if(ds1.RowCount==0){
	            alert("데이터를 먼저 조회하시길 바랍니다.");
	            return;
	        } 
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:관광증 출력명단; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("관광증 출력명단","관광증 출력명단.xls", 8);
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  행추가 (그리드별)
// Parameter 	: 
%>
	function fnAddRow() {

	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  행삭제 (그리드별)
// Parameter 	: 
%>
	function fnDeleteRow() {

	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  적용 
// Parameter 	: 
%>
	function fnApply() {

	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  취소
%>
	function fnCancel() {

	}		
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  인쇄
%>
	function fnPrint() {
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2,"
			+ "sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index) + ","
			+ "sDepartDate=" + txt_depart_date.text + ","
			+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time",drp_depart_time.Index) + ","
			+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","
			+ "sClass=" + drp_class.ValueOfIndex("class",drp_class.Index) + ","
			+ "sTeams=" + drp_teams.ValueOfIndex("teams",drp_teams.Index) + ","
			+ "sCountryGu=" + drp_country_cd.ValueOfIndex("detail",drp_country_cd.Index) + ","
			+ "sManageNo=" + txt_manage_no.value + ","
			+ "sStatusCd=" + check_status_cd.checked;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq030S",
            "JSP(O:DEFAULT=ds9)",
            param);
		 fnOnProgressStart();
        tr_post(tr1);
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description : 엑셀 (사용안함)
%>
	function fnExcelDs1() {

	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  분류명 팝업 (사용안함)
%>
	function fnPopup() {
		
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  입력값 체크 
%>
	function fnCheck() {
	
	}	
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  화일명 체크
%>
	function fnDivide(str, delim){

	}

<%
//////////////////////////////////////////////////////////////////////////////
//	Description : Dataset Head 설정
%>
	function fnSetDataHeader() {

	}

	</script>
	
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript for=txt_depart_date event=OnKillFocus()>
		fnSelectDs3();			
	</script>

	<script language=JavaScript for=drp_saup_sid event=OnSelChange()>
			fnSelectDs3();
	</script>	
<script language=JavaScript for=drp_goods_sid event=OnSelChange()>
		if ( div != 'init' ) {	//상품 
			div = 'init';
			fnSelectDs6();		
		}
	</script>	
	<script language=JavaScript for=drp_depart_time event=OnSelChange()>
	//	if ( div != 'init' ) {	//출경시간
	//		div = 'init';
	//		fnSelectDs6();		
	//	}
	</script>	

	<script language=JavaScript for=drp_class event=OnSelChange()>
		if ( div != 'init' ) {	//반
			div = 'init';					
			fnSelectDs7();		
		}
	</script>		
	
	<script language=JavaScript  for=ds8 event="OnLoadCompleted(row)"> <!-- 국적 -->
			div.value = '';
			ds8.deleteRow(1);
			ds8.deleteRow(1);
			drp_country_cd.Index = 0;
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
         document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
         document.all.LowerFrame.style.visibility="hidden";	                	
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr2" event="onsuccess()">
         document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr2" event="onfail()">
         document.all.LowerFrame.style.visibility="hidden";	                	
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr3" event="onsuccess()">
         document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr3" event="onfail()">
         document.all.LowerFrame.style.visibility="hidden";	                	
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr4" event="onsuccess()">
		div='';
        document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr4" event="onfail()">
		div='';	
        document.all.LowerFrame.style.visibility="hidden";	                	
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>		

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 
%>
<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
</script>

<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
	//fnSelectDs6();
</script>
<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)"> 
	fnSelectDs6();
</script>
<script language=JavaScript  for=ds6 event="OnLoadCompleted(row)">
	fnSelectDs7();
</script>

<script language=JavaScript  for=ds7 event="OnLoadCompleted(row)">
	div='';
</script>

<script language=JavaScript  for=ds9 event="OnLoadCompleted(row)">
	//관광증 구분 출력 - 2008-05-07 심동현
	//pr + 지역sid + 내국(1)/그외(2) + 관광객(1)/사업자(2)

	var sCountryGu	= drp_country_cd.ValueOfIndex("detail",drp_country_cd.Index);	 
	var sSaupSid	= drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index);
	if(sSaupSid=="1"){
		if(sCountryGu=='10'){
			if(radio_cust_gu[0].checked==true){
				pr111.preview();	//[금강산] 내국인용 관광객
			};
			if(radio_cust_gu[1].checked==true){
				pr112.preview();	//[금강산] 내국인용	사업자
			};
		} else if(sCountryGu=='20'||sCountryGu=='30'||sCountryGu=='40'||sCountryGu=='50'){
			if(radio_cust_gu[0].checked==true){
				pr121.preview();	//[금강산] 영주권/시민권/외국인용/조선  관광객
			};
			if(radio_cust_gu[1].checked==true){
				pr122.preview();	//[금강산] 영주권/시민권/외국인용/조선	사업자
			};			
		};
	} else if (sSaupSid=="2"){
		if(sCountryGu=='10'){
			pr211.preview();	//[개성] 내국인용
		} else if(sCountryGu=='20'||sCountryGu=='30'||sCountryGu=='40'||sCountryGu=='50'){
			pr221.preview();	//[개성] 영주권/시민권/외국인용/조선
		};
	};
	
	
</script>

<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--국적구분--%>
<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--레포트--%>
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
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr4" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>


</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" width="840px"  cellpadding="0" cellspacing="0">
				<tr>
					<td align="right" colspan="2">
						<table border="0"  cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="right" height="30px">		
									<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
									<img src="<%=dirPath%>/Sales/images/print.gif"  style="cursor:hand" align=absmiddle onclick="fnPrint()">
									<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
                                    <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onClick="fnExcel();">&nbsp;&nbsp;
									
					 			</td>
							</tr>	
						</table>
					</td>											
				</tr>
				<tr>
					<td align="left"  colspan='2' width="845px">
						<table width="840px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="840px">
			                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
			                            <tr bgcolor="#6f7f8d">
											<td align="center" width="80px" class="text">지역</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
		                             			<%=HDConstant.COMMENT_START%>
												<object id=drp_saup_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds2>
		                                        	<param name=SearchColumn    value="saup_nm">
													<param name=ListExprFormat  value="saup_nm^0^80">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>
											<td align="center" width="80px" class="text">출발일자</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
					                 			<%=HDConstant.COMMENT_START%>
					             				<object id=txt_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='70px' align='absmiddle' class='textbox'>            
						               				<param name=Format      value="YYYY-MM-DD">
					                   				<PARAM NAME=InputFormat value="YYYYMMDD">
					                 				<param name=Alignment   value=1>
				                    				<param name=ClipMode    value=true>
						               				<param name=Border      value=false>
						              			</object>&nbsp;
												<object id=drp_depart_time classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds3>
   							                     	<param name=SearchColumn    value="depart_time_nm">
													<param name=ListExprFormat  value="depart_time_nm^0^60">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>
											<td align="center" width="80px" class="text" >상품정보</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
												<%=HDConstant.COMMENT_START%>
												<object id=drp_goods_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds4>
          							              	<param name=SearchColumn    value="goods_nm">
													<param name=ListExprFormat  value="goods_nm^0^100">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>
											<td align="center" width="80px" class="text">반/조</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
												<%=HDConstant.COMMENT_START%>
												<object id=drp_class classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds6>
                						        	<param name=SearchColumn    value="class_nm">
													<param name=ListExprFormat  value="class_nm^0^60">
												</object>
												<object id=drp_teams classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds7>
          							              	<param name=SearchColumn    value="teams_nm">
													<param name=ListExprFormat  value="teams_nm^0^60">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>																				
			            				</tr>
			                            <tr bgcolor="#6f7f8d">
											<td align="center" width="80px" class="text">국적구분</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
		                             			<%=HDConstant.COMMENT_START%>
												<object id=drp_country_cd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds8>
		                                        	<param name=SearchColumn    value="detail_nm">
													<param name=ListExprFormat  value="detail_nm^0^80">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>
											<td align="center" width="80px" class="text">주민/여권번호</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
												<input type="text" name="txt_manage_no" size="11" maxlength="20" class="textbox">
												&nbsp;</nobr>
											</td>
		            						<td align=center class="text">취소자포함</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
			                                	<input type=checkbox name="check_status_cd" id="check_status_cd">포함
			                                </td>	
											
		            						<td align=center class="text">출력 Form</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
			                                	<input type=radio name=radio_cust_gu id=radio_cust_gu checked>관광객
			                                	<input type=radio name=radio_cust_gu id=radio_cust_gu>사업자
			                                </td>	
											
			            				</tr>
			            			</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>
				<tr> 
					<td height='5px'></td>
				</tr>												
				<tr>
					<td width="840px" colspan='2'>
						<table  border="0" cellpadding="0" cellspacing="0">
							<tr valign="top"">
								<td align="left" width="840px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
									<%=HDConstant.COMMENT_START%>
									<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=840px; height:410px" border="1">
									    <param name="DataID"            value="ds1">
									    <param name="BorderStyle"       value="0">
									    <!-- param name="Fillarea"          value="true"-->
									    <param name="ColSizing"         value="true">
									    <param name="editable"          value="true">
										<param name=ViewSummary     value=1>
                                        <param name="Format"            value="
                                            <C> name='No.'           ID='{CURROW}'              Width=40  align=center edit=none SumText='총계'</C>
                                            <C> name='반'           ID='class'              Width=60  align=center edit=none SumText=@count</C>
									        <C> name='조'           ID='teams'          	Width=60  align=center edit=none</C>
									         <C> name='관광증'         ID='tour_no'            Width=40  align=center edit=none</C>
									        <C> name='성명'         ID='cust_nm'        	Width=100  align=left edit=none</C>
									        <C> name='성별'      	ID='sex'            	Width=60  align=center edit=none</C>
									        <C> name='생년월일'     ID='birthday'       	Width=75  align=center edit=none mask=XXXX.XX.XX</C>
									        <C> name='직장/직위'    ID='company_nm'            Width=100  align=left edit=none</C>
                                            <C> name='사는곳'       ID='address1'           Width=145  align=Left edit=none</C>
									        <C> name='국적/민족'    ID='country_cd'       	Width=80  align=left edit=none</C>
									        <C> name='여권번호'     ID='pass_no'        	Width=100  align=left edit=none</C>
									        <C> name='nk'     ID='tag_nk'        	Width=100  align=left edit=none</C>
											<C> name='예약상태' 	ID='STATUS_CD'			Width=100  align=center edit=none</C>
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
	<tr>
		<td>※ 초청(96)반의 경우 관광객form을 선택하면 [외금-초청-01-1] 처럼 출력되고,
		　사업자form을 선택하면 [실무번호]로 출력됩니다.<br>
		※ [취소자포함]을 체크하면 취소자도 출력할 수 있습니다.
		</td>
	</tr>

</table>

<!-----------------------------------------------------------------------------
출력물 정의부분 - 금강산+내국인용+관광객 : pr111
※ 이미지 삽입할 때, jpg 아니면 안보인다!!!
	컬럼명 수정- 2008-06-11 by 심동현
		관광객스타일 → work_no1, fr_to_date1
		사업자스타일 → work_no2, fr_to_date2
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
	<object  id="pr111" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
		<param NAME="MasterDataID"			VALUE="ds9">
		<param NAME="DetailDataID"			VALUE="ds9">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="true">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">	
		<PARAM NAME="Format"                VALUE="

<B>id=default ,left=0,top=0 ,right=2970 ,bottom=1974 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='work_no1', left=2098, top=1334, right=2404, bottom=1376, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='picture_info' ,left=2098 ,top=925 ,right=2422 ,bottom=1329</I>
	<C>id='unity_no', left=2098, top=1917, right=2420, bottom=1962, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1940, top=1830, right=2551, bottom=1864, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1940, top=1864, right=2551, bottom=1893, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1940, top=1798, right=2551, bottom=1830, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='성별' ,left=2435 ,top=1403 ,right=2514 ,bottom=1445 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='sex', left=2535, top=1403, right=2635, bottom=1445, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2077 ,top=1455 ,right=2425 ,bottom=1455 </L>
	<L> left=2522 ,top=1455 ,right=2601 ,bottom=1455 </L>
	<C>id='comment2', left=1951, top=1759, right=2599, bottom=1798, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='comment1', left=1909, top=1722, right=2599, bottom=1761, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2077 ,top=1719 ,right=2601 ,bottom=1719 </L>
	<L> left=2077 ,top=1521 ,right=2601 ,bottom=1521 </L>
	<L> left=2077 ,top=1587 ,right=2601 ,bottom=1587 </L>
	<L> left=2077 ,top=1653 ,right=2601 ,bottom=1653 </L>
	<C>id='birthday', left=2080, top=1469, right=2635, bottom=1511, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=2080, top=1600, right=2635, bottom=1643, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='fr_to_date1', left=2080, top=1666, right=2635, bottom=1709, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='생년월일' ,left=1901 ,top=1469 ,right=2059 ,bottom=1511 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직장직위' ,left=1901 ,top=1535 ,right=2059 ,bottom=1577 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사 는 곳' ,left=1901 ,top=1600 ,right=2059 ,bottom=1643 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기      간' ,left=1901 ,top=1666 ,right=2059 ,bottom=1709 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이      름' ,left=1901 ,top=1403 ,right=2059 ,bottom=1445 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SECRET_MARK', left=2438, top=925, right=2635, bottom=1076, align='left', face='굴림', size=38, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='company_nm', left=2080, top=1535, right=2722, bottom=1577, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='TAG_NK' ,left=1914 ,top=925 ,right=2093 ,bottom=1105</I>
	<C>id='cust_nm', left=2080, top=1390, right=2425, bottom=1445, align='left', face='굴림', size=13, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=219, top=1550, right=640, bottom=1603, align='left', face='굴림', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='TAG_NK' ,left=13 ,top=1031 ,right=195 ,bottom=1210</I>
	<C>id='company_nm', left=219, top=1719, right=1156, bottom=1761, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SECRET_MARK', left=648, top=1031, right=858, bottom=1181, align='left', face='굴림', size=38, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=203 ,top=912 ,right=640 ,bottom=912 </L>
	<L> left=203 ,top=1864 ,right=864 ,bottom=1864 </L>
	<L> left=203 ,top=1946 ,right=864 ,bottom=1946 </L>
	<L> left=203 ,top=1772 ,right=861 ,bottom=1772 </L>
	<L> left=203 ,top=1693 ,right=861 ,bottom=1693 </L>
	<L> left=771 ,top=1614 ,right=861 ,bottom=1614 </L>
	<T>id='성별' ,left=663 ,top=1561 ,right=745 ,bottom=1603 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=203 ,top=1614 ,right=635 ,bottom=1614 </L>
	<C>id='address1', left=219, top=1811, right=864, bottom=1856, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='fr_to_date1', left=219, top=1893, right=864, bottom=1935, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=219, top=1640, right=864, bottom=1682, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='sex', left=787, top=1561, right=864, bottom=1606, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='picture_info' ,left=282 ,top=1031 ,right=603 ,bottom=1448</I>
	<C>id='work_no1', left=219, top=860, right=640, bottom=902, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=300, top=472, right=474, bottom=514, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=211, top=472, right=384, bottom=514, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=0, top=472, right=276, bottom=514, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=748, top=612, right=1174, bottom=641, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=748, top=583, right=1174, bottom=612, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=0, top=588, right=427, bottom=617, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=0, top=617, right=427, bottom=646, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='이      름' ,left=18 ,top=1561 ,right=182 ,bottom=1603 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='생년월일' ,left=18 ,top=1640 ,right=182 ,bottom=1682 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직장직위' ,left=18 ,top=1719 ,right=182 ,bottom=1761 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사 는 곳' ,left=18 ,top=1811 ,right=182 ,bottom=1856 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기      간' ,left=18 ,top=1893 ,right=182 ,bottom=1935 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='upjang_eng_nm', left=503, top=480, right=819, bottom=522, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=1245, top=480, right=1419, bottom=522, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=1058, top=480, right=1235, bottom=522, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_type', left=811, top=480, right=985, bottom=522, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=2040, top=554, right=2241, bottom=596, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=1911, top=554, right=2114, bottom=596, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_type', left=1735, top=554, right=1935, bottom=596, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=1493, top=554, right=1796, bottom=596, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='arrive_date', left=1988, top=192, right=2333, bottom=237, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=1638, top=248, right=1983, bottom=290, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=1638, top=287, right=1983, bottom=316, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=1988, top=92, right=2333, bottom=134, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=1638, top=132, right=1983, bottom=174, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=1638, top=92, right=1983, bottom=134, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=1638, top=171, right=1985, bottom=216, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthdayN', left=1638, top=327, right=1983, bottom=372, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=627, top=409, right=1272, bottom=454, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='arrive_date', left=1087, top=200, right=1432, bottom=245, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=627, top=95, right=972, bottom=137, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=627, top=134, right=972, bottom=177, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=1087, top=100, right=1432, bottom=142, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=627, top=243, right=972, bottom=287, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=627, top=282, right=972, bottom=311, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=627, top=174, right=972, bottom=219, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=627, top=308, right=972, bottom=351, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=111, top=311, right=458, bottom=356, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=111, top=351, right=458, bottom=380, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=111, top=258, right=458, bottom=298, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=111, top=92, right=458, bottom=134, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=111, top=132, right=458, bottom=174, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=111, top=185, right=458, bottom=229, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=111, top=385, right=458, bottom=427, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=1638, top=490, right=2283, bottom=535, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='번      호' ,left=13 ,top=860 ,right=176 ,bottom=902 ,align='left' ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='unity_no1', left=2367, top=662, right=2793, bottom=691, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2367, top=691, right=2793, bottom=720, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no', left=1677, top=672, right=1998, bottom=717, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>

</B>


	">
	</object> 

<%=HDConstant.COMMENT_END%>  

<!-----------------------------------------------------------------------------
출력물 정의부분 - 금강산+내국인용+사업자 : pr112		by 심동현 2008-05-07
	컬럼명 수정- 2008-06-11 by 심동현
		관광객스타일 → work_no1, fr_to_date1
		사업자스타일 → work_no2, fr_to_date2
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
	<object  id="pr112" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
		<param NAME="MasterDataID"			VALUE="ds9">
		<param NAME="DetailDataID"			VALUE="ds9">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="true">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">	
		<PARAM NAME="Format"                VALUE="


<B>id=default ,left=0,top=0 ,right=2971 ,bottom=1974 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='번      호' ,left=24 ,top=820 ,right=191 ,bottom=863 ,align='left' ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='unity_no', left=2098, top=1918, right=2421, bottom=1963, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1939, top=1831, right=2551, bottom=1863, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1939, top=1863, right=2551, bottom=1894, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1939, top=1799, right=2551, bottom=1831, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='성별' ,left=2434 ,top=1405 ,right=2516 ,bottom=1447 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='sex', left=2535, top=1405, right=2635, bottom=1447, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2077 ,top=1455 ,right=2426 ,bottom=1455 </L>
	<L> left=2524 ,top=1455 ,right=2601 ,bottom=1455 </L>
	<C>id='comment2', left=1950, top=1759, right=2601, bottom=1799, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='comment1', left=1910, top=1722, right=2601, bottom=1759, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2077 ,top=1717 ,right=2601 ,bottom=1717 </L>
	<L> left=2077 ,top=1521 ,right=2601 ,bottom=1521 </L>
	<L> left=2077 ,top=1588 ,right=2601 ,bottom=1588 </L>
	<L> left=2077 ,top=1651 ,right=2601 ,bottom=1651 </L>
	<C>id='birthday', left=2080, top=1471, right=2635, bottom=1511, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=2080, top=1601, right=2635, bottom=1643, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='fr_to_date2', left=2080, top=1667, right=2635, bottom=1709, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='생년월일' ,left=1900 ,top=1471 ,right=2061 ,bottom=1511 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직장직위' ,left=1900 ,top=1535 ,right=2061 ,bottom=1577 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사 는 곳' ,left=1900 ,top=1601 ,right=2061 ,bottom=1643 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기      간' ,left=1900 ,top=1667 ,right=2061 ,bottom=1709 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이      름' ,left=1900 ,top=1405 ,right=2061 ,bottom=1447 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='company_nm', left=2080, top=1535, right=2723, bottom=1577, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=2080, top=1389, right=2426, bottom=1447, align='left', face='굴림', size=13, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=749, top=611, right=1175, bottom=640, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=749, top=585, right=1175, bottom=611, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=0, top=587, right=429, bottom=616, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=0, top=616, right=429, bottom=648, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='기      간' ,left=32 ,top=1905 ,right=196 ,bottom=1950 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사 는 곳' ,left=32 ,top=1826 ,right=196 ,bottom=1868 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직장직위' ,left=32 ,top=1733 ,right=196 ,bottom=1773 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='생년월일' ,left=32 ,top=1651 ,right=196 ,bottom=1696 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이      름' ,left=32 ,top=1574 ,right=196 ,bottom=1614 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='sex', left=799, top=1574, right=878, bottom=1619, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=233, top=1651, right=878, bottom=1696, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='fr_to_date2', left=233, top=1905, right=878, bottom=1950, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=233, top=1826, right=878, bottom=1868, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=214 ,top=1627 ,right=648 ,bottom=1627 </L>
	<T>id='성별' ,left=677 ,top=1574 ,right=757 ,bottom=1614 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=786 ,top=1627 ,right=876 ,bottom=1627 </L>
	<L> left=214 ,top=1707 ,right=876 ,bottom=1707 </L>
	<L> left=214 ,top=1786 ,right=876 ,bottom=1786 </L>
	<L> left=214 ,top=1958 ,right=878 ,bottom=1958 </L>
	<L> left=214 ,top=1876 ,right=878 ,bottom=1876 </L>
	<C>id='company_nm', left=233, top=1733, right=1169, bottom=1773, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=233, top=1564, right=654, bottom=1614, align='left', face='굴림', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=598, top=82, right=942, bottom=124, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=598, top=122, right=942, bottom=164, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=1704, top=82, right=2048, bottom=124, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=1704, top=122, right=2048, bottom=164, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthdayN', left=1704, top=328, right=2048, bottom=373, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=1704, top=489, right=2347, bottom=534, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_type', left=1818, top=553, right=2019, bottom=595, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=1992, top=553, right=2196, bottom=595, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=2122, top=553, right=2323, bottom=595, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=1582, top=553, right=1884, bottom=595, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=140, top=90, right=487, bottom=135, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=140, top=132, right=487, bottom=172, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=140, top=185, right=487, bottom=230, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=140, top=259, right=487, bottom=299, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=140, top=312, right=487, bottom=357, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=140, top=352, right=487, bottom=381, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=140, top=384, right=487, bottom=426, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=307, top=471, right=484, bottom=513, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=220, top=471, right=394, bottom=513, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=8, top=471, right=286, bottom=513, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=627, top=410, right=1273, bottom=455, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=503, top=479, right=820, bottom=524, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_type', left=810, top=479, right=984, bottom=524, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=1058, top=479, right=1236, bottom=524, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=1246, top=479, right=1421, bottom=524, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=1704, top=286, right=2048, bottom=315, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=1704, top=246, right=2048, bottom=286, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=1704, top=169, right=2051, bottom=214, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='arrive_date', left=2064, top=191, right=2410, bottom=233, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=2064, top=90, right=2410, bottom=135, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='arrive_date', left=966, top=191, right=1310, bottom=233, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=966, top=90, right=1310, bottom=135, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2368, top=661, right=2794, bottom=691, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2368, top=691, right=2794, bottom=720, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no', left=1677, top=672, right=1998, bottom=717, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=598, top=167, right=942, bottom=212, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=598, top=299, right=942, bottom=341, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=598, top=270, right=942, bottom=299, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=598, top=228, right=942, bottom=273, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='picture_info' ,left=2135 ,top=910 ,right=2458 ,bottom=1315</I>
	<C>id='REMARKS', left=2490, top=921, right=2688, bottom=1072, align='left', face='굴림', size=38, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='TAG_NK' ,left=1916 ,top=921 ,right=2093 ,bottom=1098</I>
	<C>id='work_no2', left=233, top=820, right=654, bottom=863, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=214 ,top=873 ,right=654 ,bottom=873 </L>
	<I>id='TAG_NK' ,left=24 ,top=926 ,right=209 ,bottom=1106</I>
	<I>id='picture_info' ,left=310 ,top=1050 ,right=630 ,bottom=1468</I>
	<C>id='REMARKS', left=659, top=926, right=870, bottom=1077, align='left', face='굴림', size=38, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='work_no2', left=2106, top=1339, right=2410, bottom=1381, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>




	">
	</object> 

<%=HDConstant.COMMENT_END%>  

<!-----------------------------------------------------------------------------
출력물 정의부분 - 금강산+영주권/시민권/외국인용+관광객 pr121
	컬럼명 수정- 2008-06-11 by 심동현
		관광객스타일 → work_no1, fr_to_date1
		사업자스타일 → work_no2, fr_to_date2
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
	<object  id="pr121" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
		<param NAME="MasterDataID"			VALUE="ds9">
		<param NAME="DetailDataID"			VALUE="ds9">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="true">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">	
		<PARAM NAME="Format"                VALUE="

<B>id=default ,left=0,top=0 ,right=2862 ,bottom=1961 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='unity_no1', left=2096, top=1917, right=2417, bottom=1962, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=203 ,top=1920 ,right=864 ,bottom=1920 </L>
	<T>id='이      름' ,left=13 ,top=1371 ,right=176 ,bottom=1413 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='sex', left=787, top=1371, right=864, bottom=1416, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=858 ,top=1672 ,right=648 ,bottom=1672 </L>
	<L> left=429 ,top=1669 ,right=200 ,bottom=1669 </L>
	<T>id='국적/민족' ,left=13 ,top=1540 ,right=200 ,bottom=1582 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='COUNTRY_NM', left=219, top=1540, right=1151, bottom=1579, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Nationality/Ethnic Background' ,left=13 ,top=1590 ,right=395 ,bottom=1619 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=200 ,top=1585 ,right=861 ,bottom=1585 </L>
	<C>id='COUNTRY_EFNM', left=403, top=1590, right=1211, bottom=1622, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='기      간' ,left=13 ,top=1867 ,right=176 ,bottom=1917 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='fr_to_date1', left=219, top=1875, right=864, bottom=1917, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=219, top=1793, right=864, bottom=1838, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='사 는 곳' ,left=13 ,top=1793 ,right=176 ,bottom=1838 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성별' ,left=663 ,top=1371 ,right=748 ,bottom=1413 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직장직위' ,left=13 ,top=1711 ,right=176 ,bottom=1753 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='company_nm', left=219, top=1711, right=1372, bottom=1753, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Type of Passport' ,left=13 ,top=1674 ,right=229 ,bottom=1703 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Passport No.' ,left=455 ,top=1674 ,right=619 ,bottom=1703 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=200 ,top=1759 ,right=861 ,bottom=1759 </L>
	<L> left=771 ,top=1421 ,right=861 ,bottom=1421 </L>
	<L> left=200 ,top=1419 ,right=635 ,bottom=1419 </L>
	<T>id='Name' ,left=13 ,top=1426 ,right=176 ,bottom=1453 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='cust_enm', left=219, top=1426, right=640, bottom=1453, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Sex' ,left=663 ,top=1426 ,right=745 ,bottom=1453 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='sex_ENM', left=790, top=1426, right=869, bottom=1453, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=200 ,top=1508 ,right=861 ,bottom=1508 </L>
	<C>id='birthday', left=219, top=1461, right=864, bottom=1503, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='생년월일' ,left=13 ,top=1461 ,right=176 ,bottom=1503 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Date of Birth' ,left=13 ,top=1508 ,right=176 ,bottom=1537 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Occupation' ,left=13 ,top=1759 ,right=176 ,bottom=1788 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Address' ,left=13 ,top=1840 ,right=176 ,bottom=1869 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Duration of Stay' ,left=13 ,top=1927 ,right=234 ,bottom=1956 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       YY   MM   DD                 YY   MM   DD' ,left=237 ,top=1927 ,right=940 ,bottom=1956 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='여권번호' ,left=448 ,top=1627 ,right=635 ,bottom=1669 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='여권 종류' ,left=13 ,top=1627 ,right=200 ,bottom=1669 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PASS_TYPE', left=219, top=1627, right=445, bottom=1666, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='company_enm', left=219, top=1761, right=1372, bottom=1790, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1enm', left=219, top=1840, right=1372, bottom=1869, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=203 ,top=1838 ,right=864 ,bottom=1838 </L>
	<C>id='company_enm', left=2088, top=1606, right=2688, bottom=1635, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='직장직위' ,left=1890 ,top=1558 ,right=2054 ,bottom=1600 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Occupation' ,left=1890 ,top=1603 ,right=2054 ,bottom=1632 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='company_nm', left=2088, top=1558, right=2578, bottom=1600, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2591 ,top=1606 ,right=2072 ,bottom=1606 </L>
	<T>id='Nationality/Ethnic Background' ,left=1890 ,top=1440 ,right=2222 ,bottom=1469 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PASS_TYPE', left=2085, top=1477, right=2243, bottom=1516, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=2088, top=1271, right=2433, bottom=1297, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2601 ,top=1358 ,right=2072 ,bottom=1358 </L>
	<T>id='Date of Birth' ,left=1890 ,top=1350 ,right=2054 ,bottom=1379 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='생년월일' ,left=1890 ,top=1305 ,right=2054 ,bottom=1347 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='sex_ENM', left=2533, top=1271, right=2609, bottom=1303, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Sex' ,left=2435 ,top=1271 ,right=2514 ,bottom=1300 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Name' ,left=1890 ,top=1271 ,right=2054 ,bottom=1300 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2530 ,top=1266 ,right=2620 ,bottom=1266 </L>
	<C>id='sex', left=2533, top=1218, right=2609, bottom=1263, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='성별' ,left=2435 ,top=1218 ,right=2517 ,bottom=1260 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2072 ,top=1266 ,right=2427 ,bottom=1266 </L>
	<T>id='이      름' ,left=1890 ,top=1218 ,right=2054 ,bottom=1260 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국적/민족' ,left=1890 ,top=1387 ,right=2077 ,bottom=1429 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='COUNTRY_NM', left=2088, top=1387, right=2609, bottom=1429, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2059 ,top=1432 ,right=2617 ,bottom=1432 </L>
	<C>id='COUNTRY_EFNM', left=2230, top=1440, right=2625, bottom=1471, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2238 ,top=1521 ,right=2090 ,bottom=1521 </L>
	<L> left=2625 ,top=1521 ,right=2420 ,bottom=1521 </L>
	<T>id='Type of Passport' ,left=1890 ,top=1521 ,right=2075 ,bottom=1550 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Passport No.' ,left=2246 ,top=1521 ,right=2409 ,bottom=1550 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='여권번호' ,left=2246 ,top=1474 ,right=2409 ,bottom=1516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='여권 종류' ,left=1890 ,top=1474 ,right=2077 ,bottom=1516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='address1', left=2085, top=1640, right=2585, bottom=1685, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Address' ,left=1890 ,top=1687 ,right=2054 ,bottom=1717 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사 는 곳' ,left=1890 ,top=1640 ,right=2054 ,bottom=1685 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2075 ,top=1687 ,right=2599 ,bottom=1687 </L>
	<C>id='address1enm', left=2085, top=1690, right=2685, bottom=1719, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Duration of Stay' ,left=1890 ,top=1775 ,right=2075 ,bottom=1804 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2075 ,top=1767 ,right=2601 ,bottom=1767 </L>
	<T>id='       YY   MM   DD                 YY   MM   DD' ,left=2085 ,top=1775 ,right=2599 ,bottom=1804 ,align='left' ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기      간' ,left=1890 ,top=1722 ,right=2054 ,bottom=1764 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='fr_to_date1', left=2085, top=1722, right=2591, bottom=1764, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1938, top=1877, right=2549, bottom=1906, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1938, top=1848, right=2549, bottom=1883, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1938, top=1817, right=2549, bottom=1848, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=2088, top=1310, right=2599, bottom=1353, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='picture_info' ,left=2138 ,top=910 ,right=2377 ,bottom=1213</I>
	<T>id='번      호' ,left=14 ,top=786 ,right=176 ,bottom=841 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='work_no1', left=219, top=799, right=640, bottom=841, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=200 ,top=844 ,right=640 ,bottom=844 </L>
	<C>id='WORK_ENO', left=219, top=849, right=877, bottom=883, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(No.)' ,left=13 ,top=849 ,right=176 ,bottom=883 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='picture_info' ,left=279 ,top=920 ,right=603 ,bottom=1337</I>
	<C>id='cust_nm', left=219, top=1358, right=640, bottom=1416, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=2088, top=1210, right=2433, bottom=1266, align='left', face='굴림', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=0, top=588, right=427, bottom=617, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=300, top=472, right=474, bottom=514, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=211, top=472, right=384, bottom=514, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=0, top=472, right=276, bottom=514, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=748, top=612, right=1174, bottom=641, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=748, top=583, right=1174, bottom=612, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=0, top=617, right=427, bottom=646, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=503, top=480, right=819, bottom=522, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=1245, top=480, right=1419, bottom=522, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=1058, top=480, right=1235, bottom=522, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_type', left=811, top=480, right=985, bottom=522, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=2040, top=554, right=2241, bottom=596, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=1911, top=554, right=2114, bottom=596, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_type', left=1735, top=554, right=1935, bottom=596, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=1493, top=554, right=1796, bottom=596, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SECRET_MARK', left=2438, top=910, right=2635, bottom=1060, align='left', face='굴림', size=38, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='TAG_NK' ,left=1914 ,top=910 ,right=2093 ,bottom=1089</I>
	<C>id='SECRET_MARK', left=648, top=920, right=858, bottom=1071, align='left', face='굴림', size=38, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='TAG_NK' ,left=13 ,top=920 ,right=195 ,bottom=1100</I>
	<C>id='address1', left=1638, top=490, right=2283, bottom=535, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='arrive_date', left=1988, top=192, right=2333, bottom=237, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=1638, top=248, right=1983, bottom=290, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=1638, top=287, right=1983, bottom=316, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=1988, top=92, right=2333, bottom=134, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=1638, top=132, right=1983, bottom=174, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=1638, top=92, right=1983, bottom=134, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=1638, top=171, right=1985, bottom=216, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthdayN', left=1638, top=327, right=1983, bottom=372, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=627, top=409, right=1272, bottom=454, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='arrive_date', left=1087, top=200, right=1432, bottom=245, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=627, top=95, right=972, bottom=137, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=627, top=134, right=972, bottom=177, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=1087, top=100, right=1432, bottom=142, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=627, top=243, right=972, bottom=287, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=627, top=282, right=972, bottom=311, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=627, top=174, right=972, bottom=219, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=627, top=308, right=972, bottom=351, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=111, top=311, right=458, bottom=356, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=111, top=351, right=458, bottom=380, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=111, top=258, right=458, bottom=298, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=111, top=92, right=458, bottom=134, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=111, top=132, right=458, bottom=174, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=111, top=185, right=458, bottom=229, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=111, top=385, right=458, bottom=427, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PASS_NO', left=653, top=1627, right=1190, bottom=1669, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PASS_NO', left=2425, top=1474, right=2762, bottom=1516, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2367, top=662, right=2793, bottom=691, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2367, top=691, right=2793, bottom=720, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no', left=1677, top=672, right=1998, bottom=717, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>

</B>
	">
	</object> 

<%=HDConstant.COMMENT_END%>



<!-----------------------------------------------------------------------------
출력물 정의부분 - 금강산+영주권/시민권/외국인용+ 사업자 pr122
	컬럼명 수정- 2008-06-11 by 심동현
		관광객스타일 → work_no1, fr_to_date1
		사업자스타일 → work_no2, fr_to_date2
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
	<object  id="pr122" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
		<param NAME="MasterDataID"			VALUE="ds9">
		<param NAME="DetailDataID"			VALUE="ds9">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="true">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">	
		<PARAM NAME="Format"                VALUE="

<B>id=default ,left=0,top=0 ,right=2870 ,bottom=1961 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='unity_no1', left=2104, top=1917, right=2425, bottom=1962, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=203 ,top=1920 ,right=864 ,bottom=1920 </L>
	<T>id='이      름' ,left=13 ,top=1371 ,right=176 ,bottom=1413 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='sex', left=787, top=1371, right=864, bottom=1416, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=858 ,top=1672 ,right=648 ,bottom=1672 </L>
	<L> left=429 ,top=1669 ,right=200 ,bottom=1669 </L>
	<T>id='국적/민족' ,left=13 ,top=1540 ,right=200 ,bottom=1582 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='COUNTRY_NM', left=219, top=1540, right=1151, bottom=1579, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Nationality/Ethnic Background' ,left=13 ,top=1590 ,right=395 ,bottom=1619 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=200 ,top=1585 ,right=861 ,bottom=1585 </L>
	<C>id='COUNTRY_EFNM', left=403, top=1590, right=1211, bottom=1622, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='기      간' ,left=13 ,top=1867 ,right=176 ,bottom=1917 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='fr_to_date2', left=219, top=1875, right=864, bottom=1917, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=219, top=1793, right=864, bottom=1838, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='사 는 곳' ,left=13 ,top=1793 ,right=176 ,bottom=1838 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성별' ,left=663 ,top=1371 ,right=748 ,bottom=1413 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직장직위' ,left=13 ,top=1711 ,right=176 ,bottom=1753 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='company_nm', left=219, top=1711, right=1372, bottom=1753, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Type of Passport' ,left=13 ,top=1674 ,right=229 ,bottom=1703 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Passport No.' ,left=455 ,top=1674 ,right=619 ,bottom=1703 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=200 ,top=1759 ,right=861 ,bottom=1759 </L>
	<L> left=771 ,top=1421 ,right=861 ,bottom=1421 </L>
	<L> left=200 ,top=1419 ,right=635 ,bottom=1419 </L>
	<T>id='Name' ,left=13 ,top=1426 ,right=176 ,bottom=1453 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='cust_enm', left=219, top=1426, right=640, bottom=1453, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Sex' ,left=663 ,top=1426 ,right=745 ,bottom=1453 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='sex_ENM', left=790, top=1426, right=869, bottom=1453, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=200 ,top=1508 ,right=861 ,bottom=1508 </L>
	<C>id='birthday', left=219, top=1461, right=864, bottom=1503, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='생년월일' ,left=13 ,top=1461 ,right=176 ,bottom=1503 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Date of Birth' ,left=13 ,top=1508 ,right=176 ,bottom=1537 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Occupation' ,left=13 ,top=1759 ,right=176 ,bottom=1788 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Address' ,left=13 ,top=1840 ,right=176 ,bottom=1869 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Duration of Stay' ,left=13 ,top=1927 ,right=234 ,bottom=1956 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       YY   MM   DD                 YY   MM   DD' ,left=237 ,top=1927 ,right=940 ,bottom=1956 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='여권번호' ,left=448 ,top=1627 ,right=635 ,bottom=1669 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='여권 종류' ,left=13 ,top=1627 ,right=200 ,bottom=1669 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PASS_TYPE', left=219, top=1627, right=445, bottom=1666, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='company_enm', left=219, top=1761, right=1372, bottom=1790, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1enm', left=219, top=1840, right=1372, bottom=1869, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=203 ,top=1838 ,right=864 ,bottom=1838 </L>
	<C>id='company_enm', left=2096, top=1606, right=2696, bottom=1635, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='직장직위' ,left=1898 ,top=1558 ,right=2061 ,bottom=1600 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Occupation' ,left=1898 ,top=1603 ,right=2061 ,bottom=1632 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='company_nm', left=2096, top=1558, right=2585, bottom=1600, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2599 ,top=1606 ,right=2080 ,bottom=1606 </L>
	<T>id='Nationality/Ethnic Background' ,left=1898 ,top=1440 ,right=2230 ,bottom=1469 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PASS_TYPE', left=2093, top=1477, right=2251, bottom=1516, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=2096, top=1271, right=2441, bottom=1297, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2609 ,top=1358 ,right=2080 ,bottom=1358 </L>
	<T>id='Date of Birth' ,left=1898 ,top=1350 ,right=2061 ,bottom=1379 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='생년월일' ,left=1898 ,top=1305 ,right=2061 ,bottom=1347 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='sex_ENM', left=2541, top=1271, right=2617, bottom=1303, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Sex' ,left=2443 ,top=1271 ,right=2522 ,bottom=1300 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Name' ,left=1898 ,top=1271 ,right=2061 ,bottom=1300 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2538 ,top=1266 ,right=2628 ,bottom=1266 </L>
	<C>id='sex', left=2541, top=1218, right=2617, bottom=1263, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='성별' ,left=2443 ,top=1218 ,right=2525 ,bottom=1260 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2080 ,top=1266 ,right=2435 ,bottom=1266 </L>
	<T>id='이      름' ,left=1898 ,top=1218 ,right=2061 ,bottom=1260 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국적/민족' ,left=1898 ,top=1387 ,right=2085 ,bottom=1429 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='COUNTRY_NM', left=2096, top=1387, right=2617, bottom=1429, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2067 ,top=1432 ,right=2625 ,bottom=1432 </L>
	<C>id='COUNTRY_EFNM', left=2238, top=1440, right=2633, bottom=1471, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2246 ,top=1521 ,right=2098 ,bottom=1521 </L>
	<L> left=2633 ,top=1521 ,right=2427 ,bottom=1521 </L>
	<T>id='Type of Passport' ,left=1898 ,top=1521 ,right=2083 ,bottom=1550 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Passport No.' ,left=2254 ,top=1521 ,right=2417 ,bottom=1550 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='여권번호' ,left=2254 ,top=1474 ,right=2417 ,bottom=1516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='여권 종류' ,left=1898 ,top=1474 ,right=2085 ,bottom=1516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='address1', left=2093, top=1640, right=2593, bottom=1685, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Address' ,left=1898 ,top=1687 ,right=2061 ,bottom=1717 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사 는 곳' ,left=1898 ,top=1640 ,right=2061 ,bottom=1685 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2083 ,top=1687 ,right=2606 ,bottom=1687 </L>
	<C>id='address1enm', left=2093, top=1690, right=2693, bottom=1719, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Duration of Stay' ,left=1898 ,top=1775 ,right=2083 ,bottom=1804 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2083 ,top=1767 ,right=2609 ,bottom=1767 </L>
	<T>id='       YY   MM   DD                 YY   MM   DD' ,left=2093 ,top=1775 ,right=2606 ,bottom=1804 ,align='left' ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기      간' ,left=1898 ,top=1722 ,right=2061 ,bottom=1764 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='fr_to_date2', left=2093, top=1722, right=2599, bottom=1764, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1946, top=1877, right=2556, bottom=1906, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1946, top=1848, right=2556, bottom=1883, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1946, top=1817, right=2556, bottom=1848, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=2096, top=1310, right=2606, bottom=1353, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='picture_info' ,left=2146 ,top=910 ,right=2385 ,bottom=1213</I>
	<T>id='번      호' ,left=13 ,top=786 ,right=176 ,bottom=841 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='work_no2', left=219, top=799, right=640, bottom=841, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=200 ,top=844 ,right=640 ,bottom=844 </L>
	<C>id='WORK_ENO', left=219, top=849, right=877, bottom=883, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(No.)' ,left=13 ,top=849 ,right=176 ,bottom=883 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='picture_info' ,left=279 ,top=920 ,right=603 ,bottom=1337</I>
	<C>id='cust_nm', left=219, top=1358, right=640, bottom=1416, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=2096, top=1210, right=2441, bottom=1266, align='left', face='굴림', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=0, top=588, right=427, bottom=617, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=748, top=612, right=1174, bottom=641, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=748, top=583, right=1174, bottom=612, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=0, top=617, right=427, bottom=646, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SECRET_MARK', left=2446, top=910, right=2643, bottom=1060, align='left', face='굴림', size=38, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='TAG_NK' ,left=1922 ,top=910 ,right=2101 ,bottom=1089</I>
	<C>id='SECRET_MARK', left=648, top=920, right=858, bottom=1071, align='left', face='굴림', size=38, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='TAG_NK' ,left=13 ,top=920 ,right=195 ,bottom=1100</I>
	<C>id='address1', left=1682, top=490, right=2327, bottom=535, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PASS_NO', left=653, top=1627, right=1190, bottom=1669, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PASS_NO', left=2433, top=1474, right=2770, bottom=1516, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=118, top=401, right=466, bottom=443, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=118, top=200, right=466, bottom=245, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=118, top=148, right=466, bottom=190, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=118, top=108, right=466, bottom=150, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=118, top=274, right=466, bottom=314, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=118, top=367, right=466, bottom=396, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=118, top=327, right=466, bottom=372, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=600, top=425, right=1245, bottom=469, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=300, top=490, right=474, bottom=533, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=213, top=488, right=387, bottom=530, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=3, top=488, right=279, bottom=530, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=1245, top=490, right=1419, bottom=533, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=1058, top=490, right=1235, bottom=533, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_type', left=811, top=490, right=985, bottom=533, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=503, top=490, right=819, bottom=533, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=1561, top=559, right=1864, bottom=601, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_type', left=1796, top=559, right=1996, bottom=601, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=1972, top=559, right=2175, bottom=601, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=2101, top=559, right=2301, bottom=601, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='arrive_date', left=2033, top=192, right=2377, bottom=237, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=1682, top=248, right=2027, bottom=290, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=1682, top=287, right=2027, bottom=316, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=2033, top=92, right=2377, bottom=134, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=1682, top=132, right=2027, bottom=174, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=1682, top=92, right=2027, bottom=134, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=1682, top=171, right=2030, bottom=216, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthdayN', left=1682, top=327, right=2027, bottom=372, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=948, top=95, right=1293, bottom=137, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='arrive_date', left=948, top=195, right=1293, bottom=240, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=600, top=95, right=945, bottom=137, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=600, top=134, right=945, bottom=177, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=600, top=243, right=945, bottom=287, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=600, top=282, right=945, bottom=311, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=600, top=174, right=945, bottom=219, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=600, top=308, right=945, bottom=351, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2367, top=662, right=2793, bottom=691, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2367, top=691, right=2793, bottom=720, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no', left=1677, top=672, right=1998, bottom=717, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>

</B>


	">
	</object> 

<%=HDConstant.COMMENT_END%>



<!-----------------------------------------------------------------------------
출력물 정의부분 - 개성 - 내국인용+관광 : pr211
				※ 이미지 삽입할 때, jpg 아니면 안보인다!!!
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
	<object  id="pr211" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
		<param NAME="MasterDataID"			VALUE="ds9">
		<param NAME="DetailDataID"			VALUE="ds9">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="true">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">	
		<PARAM NAME="Format"                VALUE="

<B>id=default ,left=0,top=0 ,right=2870 ,bottom=1961 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='nights_days1', left=1959, top=92, right=2304, bottom=134, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=1959, top=132, right=2304, bottom=174, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=940, top=343, right=1285, bottom=372, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=2567, top=438, right=2767, bottom=480, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=2354, top=438, right=2556, bottom=480, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_type', left=2143, top=438, right=2343, bottom=480, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=1959, top=337, right=2304, bottom=348, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=940, top=132, right=1285, bottom=174, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=940, top=92, right=1285, bottom=134, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='work_no1', left=337, top=860, right=758, bottom=902, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='picture_info' ,left=400 ,top=1031 ,right=721 ,bottom=1448</I>
	<C>id='sex', left=906, top=1561, right=982, bottom=1606, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=337, top=1640, right=982, bottom=1682, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='fr_to_date1', left=337, top=1893, right=982, bottom=1935, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=337, top=1811, right=982, bottom=1856, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='work_no1', left=2235, top=1334, right=2541, bottom=1376, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='picture_info' ,left=2235 ,top=925 ,right=2559 ,bottom=1329</I>
	<C>id='unity_no', left=2235, top=1917, right=2556, bottom=1962, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2077, top=1830, right=2688, bottom=1864, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2077, top=1864, right=2688, bottom=1893, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2077, top=1798, right=2688, bottom=1830, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2314, top=343, right=2741, bottom=372, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2314, top=372, right=2741, bottom=401, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1282, top=385, right=1709, bottom=414, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1282, top=356, right=1709, bottom=385, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=250, top=266, right=598, bottom=306, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=250, top=303, right=598, bottom=348, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=250, top=343, right=598, bottom=372, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=250, top=385, right=598, bottom=427, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=940, top=303, right=1285, bottom=348, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=940, top=385, right=1285, bottom=427, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=411, top=451, right=584, bottom=493, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=595, top=451, right=769, bottom=493, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=1959, top=277, right=2304, bottom=319, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=1959, top=356, right=2304, bottom=401, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_type', left=1137, top=451, right=1311, bottom=493, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=1348, top=451, right=1524, bottom=493, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=1561, top=451, right=1735, bottom=493, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='accept_no', left=2064, top=609, right=2438, bottom=651, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='bal_no', left=2064, top=570, right=2438, bottom=612, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='accept_no', left=1045, top=609, right=1443, bottom=651, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='bal_no', left=1045, top=570, right=1443, bottom=612, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='bal_no', left=371, top=570, right=769, bottom=612, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='accept_no', left=371, top=609, right=769, bottom=651, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=1956, top=185, right=2304, bottom=229, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=940, top=185, right=1285, bottom=229, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=250, top=185, right=598, bottom=229, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=250, top=132, right=598, bottom=174, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=250, top=92, right=598, bottom=134, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='arrive_date', left=1390, top=185, right=1735, bottom=229, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=1390, top=92, right=1735, bottom=134, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='이      름' ,left=132 ,top=1561 ,right=295 ,bottom=1603 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=321 ,top=1614 ,right=753 ,bottom=1614 </L>
	<T>id='성별' ,left=782 ,top=1561 ,right=864 ,bottom=1603 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=890 ,top=1614 ,right=979 ,bottom=1614 </L>
	<L> left=321 ,top=1693 ,right=979 ,bottom=1693 </L>
	<L> left=321 ,top=1772 ,right=979 ,bottom=1772 </L>
	<L> left=321 ,top=1946 ,right=982 ,bottom=1946 </L>
	<L> left=321 ,top=1864 ,right=982 ,bottom=1864 </L>
	<T>id='생년월일' ,left=132 ,top=1640 ,right=295 ,bottom=1682 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직장직위' ,left=132 ,top=1719 ,right=295 ,bottom=1761 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사 는 곳' ,left=132 ,top=1811 ,right=295 ,bottom=1856 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기      간' ,left=132 ,top=1893 ,right=295 ,bottom=1935 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성별' ,left=2572 ,top=1403 ,right=2651 ,bottom=1445 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='sex', left=2672, top=1403, right=2772, bottom=1445, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2214 ,top=1455 ,right=2562 ,bottom=1455 </L>
	<L> left=2659 ,top=1455 ,right=2738 ,bottom=1455 </L>
	<T>id='번      호' ,left=132 ,top=860 ,right=295 ,bottom=902 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=321 ,top=912 ,right=758 ,bottom=912 </L>
	<C>id='arrive_date', left=2422, top=185, right=2767, bottom=229, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=2422, top=92, right=2767, bottom=134, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='comment2', left=2088, top=1759, right=2735, bottom=1798, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='comment1', left=2046, top=1722, right=2735, bottom=1761, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2214 ,top=1719 ,right=2738 ,bottom=1719 </L>
	<L> left=2214 ,top=1521 ,right=2738 ,bottom=1521 </L>
	<L> left=2214 ,top=1587 ,right=2738 ,bottom=1587 </L>
	<L> left=2214 ,top=1653 ,right=2738 ,bottom=1653 </L>
	<C>id='birthday', left=2217, top=1469, right=2772, bottom=1511, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=2217, top=1600, right=2772, bottom=1643, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='fr_to_date1', left=2217, top=1666, right=2772, bottom=1709, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='생년월일' ,left=2038 ,top=1469 ,right=2196 ,bottom=1511 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직장직위' ,left=2038 ,top=1535 ,right=2196 ,bottom=1577 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사 는 곳' ,left=2038 ,top=1600 ,right=2196 ,bottom=1643 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기      간' ,left=2038 ,top=1666 ,right=2196 ,bottom=1709 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이      름' ,left=2038 ,top=1403 ,right=2196 ,bottom=1445 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='upjang_eng_nm', left=132, top=451, right=408, bottom=493, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=819, top=451, right=1135, bottom=493, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=1840, top=438, right=2143, bottom=480, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SECRET_MARK', left=2575, top=925, right=2772, bottom=1076, align='left', face='굴림', size=38, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SECRET_MARK', left=766, top=1031, right=977, bottom=1181, align='left', face='굴림', size=38, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='company_nm', left=337, top=1719, right=1274, bottom=1761, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='company_nm', left=2217, top=1535, right=2859, bottom=1577, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='TAG_NK' ,left=132 ,top=1031 ,right=313 ,bottom=1210</I>
	<I>id='TAG_NK' ,left=2051 ,top=925 ,right=2230 ,bottom=1105</I>
	<C>id='cust_nm', left=337, top=1550, right=758, bottom=1603, align='left', face='굴림', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=2217, top=1390, right=2562, bottom=1445, align='left', face='굴림', size=13, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='GROUP_NM', left=134, top=928, right=974, bottom=986, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

	">
	</object> 

<%=HDConstant.COMMENT_END%>  

<!-----------------------------------------------------------------------------
출력물 정의부분 - 개성 - 영주권/시민권/외국인용+관광객
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
	<object  id="pr221" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
		<param NAME="MasterDataID"			VALUE="ds9">
		<param NAME="DetailDataID"			VALUE="ds9">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="true">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">	
		<PARAM NAME="Format"                VALUE="

<B>id=default ,left=0,top=0 ,right=2870 ,bottom=1961 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='nights_days1', left=1964, top=92, right=2314, bottom=134, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=1964, top=132, right=2314, bottom=174, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=943, top=343, right=1290, bottom=372, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=2575, top=438, right=2775, bottom=480, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=2364, top=438, right=2564, bottom=480, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_type', left=2148, top=438, right=2351, bottom=480, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=943, top=132, right=1290, bottom=174, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=943, top=92, right=1290, bottom=134, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no', left=2243, top=1917, right=2564, bottom=1962, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2322, top=343, right=2749, bottom=372, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2322, top=372, right=2749, bottom=401, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1285, top=385, right=1714, bottom=414, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1285, top=356, right=1714, bottom=385, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=250, top=266, right=600, bottom=306, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=250, top=303, right=600, bottom=348, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=250, top=343, right=600, bottom=372, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=250, top=385, right=600, bottom=427, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=943, top=303, right=1290, bottom=348, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=943, top=385, right=1290, bottom=427, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=411, top=451, right=587, bottom=493, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=598, top=451, right=771, bottom=493, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=1964, top=277, right=2314, bottom=319, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_type', left=1140, top=451, right=1314, bottom=493, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='dong_nm', left=1353, top=451, right=1530, bottom=493, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='room_no', left=1567, top=451, right=1740, bottom=493, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='accept_no', left=2069, top=609, right=2446, bottom=651, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='bal_no', left=2069, top=570, right=2446, bottom=612, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='bal_no', left=1048, top=570, right=1451, bottom=612, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='bal_no', left=371, top=570, right=771, bottom=612, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='accept_no', left=371, top=609, right=771, bottom=651, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=1961, top=185, right=2314, bottom=229, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=943, top=185, right=1290, bottom=229, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='class_teams', left=250, top=185, right=600, bottom=229, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days2', left=250, top=132, right=600, bottom=174, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='nights_days1', left=250, top=92, right=600, bottom=134, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='arrive_date', left=1393, top=185, right=1740, bottom=229, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=1393, top=92, right=1740, bottom=134, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='arrive_date', left=2430, top=185, right=2775, bottom=229, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=2430, top=92, right=2775, bottom=134, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=132, top=451, right=408, bottom=493, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=821, top=451, right=1137, bottom=493, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=1846, top=438, right=2148, bottom=480, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=1967, top=343, right=2314, bottom=372, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=321 ,top=1920 ,right=985 ,bottom=1920 </L>
	<C>id='accept_no', left=1048, top=609, right=1451, bottom=651, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='이      름' ,left=132 ,top=1371 ,right=295 ,bottom=1413 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='sex', left=908, top=1371, right=985, bottom=1416, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=979 ,top=1672 ,right=769 ,bottom=1672 </L>
	<L> left=550 ,top=1669 ,right=321 ,bottom=1669 </L>
	<C>id='PASS_NO', left=774, top=1627, right=1000, bottom=1669, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='국적/민족' ,left=132 ,top=1540 ,right=321 ,bottom=1582 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='COUNTRY_NM', left=337, top=1540, right=1274, bottom=1579, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Nationality/Ethnic Background' ,left=132 ,top=1590 ,right=516 ,bottom=1619 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=321 ,top=1585 ,right=982 ,bottom=1585 </L>
	<C>id='COUNTRY_EFNM', left=524, top=1590, right=1335, bottom=1622, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='기      간' ,left=132 ,top=1867 ,right=295 ,bottom=1917 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='fr_to_date1', left=337, top=1875, right=985, bottom=1917, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=337, top=1793, right=985, bottom=1838, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='사 는 곳' ,left=132 ,top=1793 ,right=295 ,bottom=1838 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성별' ,left=785 ,top=1371 ,right=869 ,bottom=1413 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직장직위' ,left=132 ,top=1711 ,right=295 ,bottom=1753 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='company_nm', left=337, top=1711, right=1495, bottom=1753, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Type of Passport' ,left=132 ,top=1674 ,right=350 ,bottom=1703 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Passport No.' ,left=577 ,top=1674 ,right=740 ,bottom=1703 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=321 ,top=1759 ,right=982 ,bottom=1759 </L>
	<L> left=893 ,top=1421 ,right=982 ,bottom=1421 </L>
	<L> left=321 ,top=1419 ,right=756 ,bottom=1419 </L>
	<T>id='Name' ,left=132 ,top=1426 ,right=295 ,bottom=1453 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='cust_enm', left=337, top=1426, right=761, bottom=1453, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Sex' ,left=785 ,top=1426 ,right=866 ,bottom=1453 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='sex_ENM', left=911, top=1426, right=990, bottom=1453, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=321 ,top=1508 ,right=982 ,bottom=1508 </L>
	<C>id='birthday', left=337, top=1461, right=985, bottom=1503, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='생년월일' ,left=132 ,top=1461 ,right=295 ,bottom=1503 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Date of Birth' ,left=132 ,top=1508 ,right=295 ,bottom=1537 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Occupation' ,left=132 ,top=1759 ,right=295 ,bottom=1788 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Address' ,left=132 ,top=1840 ,right=295 ,bottom=1869 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Duration of Stay' ,left=132 ,top=1927 ,right=353 ,bottom=1956 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       YY   MM   DD                 YY   MM   DD' ,left=355 ,top=1927 ,right=1061 ,bottom=1956 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='여권번호' ,left=569 ,top=1627 ,right=756 ,bottom=1669 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='여권 종류' ,left=132 ,top=1627 ,right=321 ,bottom=1669 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PASS_TYPE', left=337, top=1627, right=566, bottom=1666, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=1964, top=385, right=2314, bottom=430, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='company_enm', left=337, top=1761, right=1495, bottom=1790, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1enm', left=337, top=1840, right=1495, bottom=1869, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=321 ,top=1838 ,right=985 ,bottom=1838 </L>
	<C>id='company_enm', left=2235, top=1606, right=2836, bottom=1635, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='직장직위' ,left=2035 ,top=1558 ,right=2201 ,bottom=1600 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Occupation' ,left=2035 ,top=1603 ,right=2201 ,bottom=1632 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='company_nm', left=2235, top=1558, right=2725, bottom=1600, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2738 ,top=1606 ,right=2217 ,bottom=1606 </L>
	<T>id='Nationality/Ethnic Background' ,left=2035 ,top=1440 ,right=2370 ,bottom=1469 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PASS_TYPE', left=2230, top=1477, right=2391, bottom=1516, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_enm', left=2235, top=1271, right=2580, bottom=1297, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2749 ,top=1358 ,right=2217 ,bottom=1358 </L>
	<T>id='Date of Birth' ,left=2035 ,top=1350 ,right=2201 ,bottom=1379 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='생년월일' ,left=2035 ,top=1305 ,right=2201 ,bottom=1347 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='sex_ENM', left=2680, top=1271, right=2757, bottom=1303, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Sex' ,left=2583 ,top=1271 ,right=2662 ,bottom=1300 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Name' ,left=2035 ,top=1271 ,right=2201 ,bottom=1300 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2678 ,top=1266 ,right=2767 ,bottom=1266 </L>
	<C>id='sex', left=2680, top=1218, right=2757, bottom=1263, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='성별' ,left=2583 ,top=1218 ,right=2664 ,bottom=1260 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2217 ,top=1266 ,right=2575 ,bottom=1266 </L>
	<T>id='이      름' ,left=2035 ,top=1218 ,right=2201 ,bottom=1260 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국적/민족' ,left=2035 ,top=1387 ,right=2222 ,bottom=1429 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='COUNTRY_NM', left=2235, top=1387, right=2757, bottom=1429, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2206 ,top=1432 ,right=2764 ,bottom=1432 </L>
	<C>id='COUNTRY_EFNM', left=2377, top=1440, right=2772, bottom=1471, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2383 ,top=1521 ,right=2238 ,bottom=1521 </L>
	<L> left=2772 ,top=1521 ,right=2567 ,bottom=1521 </L>
	<T>id='Type of Passport' ,left=2035 ,top=1521 ,right=2222 ,bottom=1550 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Passport No.' ,left=2393 ,top=1521 ,right=2556 ,bottom=1550 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='여권번호' ,left=2393 ,top=1474 ,right=2556 ,bottom=1516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PASS_NO', left=2572, top=1474, right=2799, bottom=1516, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='여권 종류' ,left=2035 ,top=1474 ,right=2222 ,bottom=1516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='address1', left=2230, top=1640, right=2733, bottom=1685, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Address' ,left=2035 ,top=1687 ,right=2201 ,bottom=1717 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사 는 곳' ,left=2035 ,top=1640 ,right=2201 ,bottom=1685 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2222 ,top=1687 ,right=2746 ,bottom=1687 </L>
	<C>id='address1enm', left=2230, top=1690, right=2833, bottom=1719, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Duration of Stay' ,left=2035 ,top=1775 ,right=2222 ,bottom=1804 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2222 ,top=1767 ,right=2749 ,bottom=1767 </L>
	<T>id='       YY   MM   DD                 YY   MM   DD' ,left=2230 ,top=1775 ,right=2746 ,bottom=1804 ,align='left' ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기      간' ,left=2035 ,top=1722 ,right=2201 ,bottom=1764 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='fr_to_date1', left=2230, top=1722, right=2738, bottom=1764, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2083, top=1877, right=2696, bottom=1906, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2083, top=1848, right=2696, bottom=1883, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=2083, top=1817, right=2696, bottom=1848, face='3 of 9 Barcode', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=2235, top=1310, right=2746, bottom=1353, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='picture_info' ,left=2285 ,top=910 ,right=2525 ,bottom=1213</I>
	<T>id='번      호' ,left=132 ,top=786 ,right=295 ,bottom=841 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='work_no1', left=337, top=799, right=761, bottom=841, align='left', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=321 ,top=844 ,right=761 ,bottom=844 </L>
	<C>id='WORK_ENO', left=337, top=849, right=998, bottom=883, align='left', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(No.)' ,left=132 ,top=849 ,right=295 ,bottom=883 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='picture_info' ,left=400 ,top=920 ,right=724 ,bottom=1337</I>
	<C>id='SECRET_MARK', left=2575, top=925, right=2772, bottom=1076, align='left', face='굴림', size=38, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SECRET_MARK', left=766, top=1031, right=977, bottom=1181, align='left', face='굴림', size=38, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='TAG_NK' ,left=132 ,top=1031 ,right=313 ,bottom=1210</I>
	<I>id='TAG_NK' ,left=2051 ,top=925 ,right=2230 ,bottom=1105</I>
	<C>id='cust_nm', left=337, top=1358, right=761, bottom=1416, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=2235, top=1210, right=2580, bottom=1266, align='left', face='굴림', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='GROUP_NM', left=240, top=886, right=900, bottom=920, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
	">
	</object> 

<%=HDConstant.COMMENT_END%>     

     

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

