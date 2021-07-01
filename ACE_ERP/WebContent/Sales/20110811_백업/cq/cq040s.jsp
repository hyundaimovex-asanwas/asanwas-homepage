<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 사진명단(최초)
 * 프로그램ID 	: CQ040S
 * J  S  P			: cq040s
 * 서 블 릿		: Cq040S
 * 작 성 자		: 구자헌
 * 작 성 일		: 2006-06-28
 * 기능정의		: 출입증(사업자증,관광증)발급신청서 출력
 * [수  정   일  자][수정자] 내용
 * [2010-04-15][박경국] 신규.출입증(사업자증,관광증)발급신청서
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
        cfStyleGrid(getObjectFirst("gr1"), "comn1");
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
	            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq040S",
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
// Description 	:  적용 
// Parameter 	: 
%>
	function fnApply() {
	 v_job = "S";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq040S",
	            "JSP(I:DS1=ds1,O:RESULT=ds_result)",
	            param);
	        tr_post(tr1);
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
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq040S",
            "JSP(O:DEFAULT=ds9)",
            param);
		tr_post(tr1);
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description : 엑셀
%>
	function fnExcelDs1() {
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
	<script language=javascript for="gr1" event="OnClick(Row, Colid)">
	// 제목 선택할 때.. 전체 변경 가능한 이벤트
        if(Row==0){
            if(ds1.CountRow==0) return;

            if(Colid=="CHOICE"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
                }
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
	pr1.PreView();
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
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 메세지 -->
    <param name="SyncLoad"  value="false">
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

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
		            						<td align=center class="text">출력선택</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
			                                	<input type=checkbox name="check_status_cd" id="check_status_cd">체크
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
                                            <C> name='No.'           	ID='{CURROW}'   Width=40  align=center edit=none SumText='총계'</C>
                                            <C> name='선택\\√'   	ID='CHOICE'  		width=30 	align=center editlimit=16 show=true EditStyle=CheckBox SumText=@count</C>
                                            <C> name='반'           		ID='class'            Width=60  align=center edit=none </C>
									        <C> name='조'           		ID='teams'          	Width=60  align=center edit=none</C>
									        <C> name='관광증'         	ID='tour_no'         Width=40  align=center edit=none</C>
									        <C> name='성명'         		ID='cust_nm'       Width=100  align=left edit=none</C>
									        <C> name='성별'      		ID='sex'            	Width=60  align=center edit=none</C>
									        <C> name='생년월일'     	ID='birthday'       	Width=75  align=center edit=none mask=XXXX.XX.XX</C>
									        <C> name='직장/직위'    	ID='company_nm'     Width=100  align=left edit=none</C>
                                            <C> name='사는곳'       	ID='address1'           Width=145  align=Left edit=none</C>
									        <C> name='국적/민족'    	ID='COUNTRY_NM'    Width=80  align=left edit=none</C>
									        <C> name='여권번호'     	ID='pass_no'        	Width=100  align=left edit=none show=false</C>
									        <C> name='nk'    			 	ID='tag_nk'        		Width=100  align=left edit=none show=false</C>
											<C> name='예약상태' 		ID='STATUS_CD'		Width=100  align=center edit=none</C>
											<C> name='RSV_SID' 		ID='RSV_SID'			Width=100  align=center edit=none show=false</C>
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
		<td>
		1.조회<BR>
		2.출력할 인원만 선택그리드에서 체크=>저장<BR>
		3.조회(조회조건에서 출력선택_체크)  =>2번에서 체크하고 저장했던 인원만 조회됨.<BR>
		4.출력
		</td>
	</tr>
</table>
<%
/*=============================================================================
			레포트 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
	<object id=pr1 classid=<%=HDConstant.CT_REPORT_CLSID%>> 
		<PARAM NAME="MasterDataID"          VALUE="ds9">
		<PARAM NAME="DetailDataID"			VALUE="ds9">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="false">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">
 		<param NAME="SuppressColumns" 	    VALUE="1:pageskip,page_skip">
		<PARAM NAME="Format"                value="
		
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=313 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='조선민주주의인민공화국 금강산관광지구 출입국사업부 앞' ,left=283 ,top=93 ,right=1140 ,bottom=159 ,align='left' ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='출입증(사업자증, 관광증) 발급신청서' ,left=407 ,top=180 ,right=1619 ,bottom=304 ,face='Tahoma' ,size=18 ,bold=true ,underline=true ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=387 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=151 ,top=349 ,right=1820 ,bottom=349 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=511 ,top=169 ,right=1820 ,bottom=169 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=511 ,top=259 ,right=1820 ,bottom=259 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=511 ,top=79 ,right=1820 ,bottom=79 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=151 ,top=5 ,right=1820 ,bottom=5 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=151 ,top=5 ,right=151 ,bottom=349 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=209 ,top=5 ,right=209 ,bottom=349 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1820 ,top=5 ,right=1820 ,bottom=349 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=691 ,top=5 ,right=691 ,bottom=349 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=910 ,top=5 ,right=910 ,bottom=169 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=511 ,top=5 ,right=511 ,bottom=349 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1069 ,top=5 ,right=1069 ,bottom=349 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1421 ,top=5 ,right=1421 ,bottom=169 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1281 ,top=5 ,right=1281 ,bottom=349 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='남녀별' ,left=929 ,top=26 ,right=1066 ,bottom=79 ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='민족별' ,left=926 ,top=111 ,right=1064 ,bottom=164 ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='체류기간' ,left=534 ,top=283 ,right=672 ,bottom=336 ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직장직위' ,left=532 ,top=196 ,right=669 ,bottom=249 ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국적' ,left=532 ,top=108 ,right=669 ,bottom=161 ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이름' ,left=532 ,top=21 ,right=669 ,bottom=74 ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주지' ,left=1077 ,top=196 ,right=1267 ,bottom=249 ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출입목적' ,left=1283 ,top=106 ,right=1413 ,bottom=159 ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='난날' ,left=1286 ,top=24 ,right=1416 ,bottom=77 ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='체류지(숙소)' ,left=1077 ,top=283 ,right=1275 ,bottom=336 ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='picture_info' ,left=222 ,top=26 ,right=495 ,bottom=336</I>
	<C>id='{CURROW}', left=159, top=135, right=204, bottom=220</C>
	<C>id='cust_nm', left=701, top=21, right=900, bottom=74, face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COUNTRY_NM', left=701, top=106, right=900, bottom=161, face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='company_nm', left=701, top=193, right=1061, bottom=249, face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='fr_to_date1', left=701, top=280, right=1061, bottom=336, face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='sex', left=1090, top=21, right=1251, bottom=77, face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NATION_NM', left=1070, top=101, right=1271, bottom=156, face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADDRESS1', left=1291, top=193, right=1820, bottom=249, face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='upjang_eng_nm', left=1299, top=283, right=1818, bottom=339, face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='north_purpose', left=1421, top=101, right=1831, bottom=156, face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=1421, top=19, right=1828, bottom=74, face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=2412 ,right=2000 ,bottom=2870 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='(기관,공인)' ,left=984 ,top=286 ,right=1257 ,bottom=352 ,align='left' ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='신청날자' ,left=984 ,top=140 ,right=1259 ,bottom=206 ,align='left' ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='신청자이름 수표' ,left=984 ,top=45 ,right=1262 ,bottom=111 ,align='left' ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
</B>

	">
	</object> 
<%=HDConstant.COMMENT_END%>  
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

