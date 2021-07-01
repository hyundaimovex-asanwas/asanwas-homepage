<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 방북신청현황
 * 프로그램ID   : RV230S
 * J  S  P      : rv230s
 * 서 블 릿        : Rv230S
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-07-14
 * 기능정의     :
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2007-09-28][심동현] 그리드 현재 사용하는 폼으로 수정
 * [2011-06-22][박경국] 통통에 방북승인신청 할 인원 일괄등록으로 엑셀 업로드 할 수 있게 
 								   조회 탭 추가.
 * [2015-08-20][심동현] 북측 표준시 변경 반영
 *						리포트 출력 검토 필요~
 * [2015-09-18][심동현] 방문신청 대상 일괄등록
 * [2015-09-30][심동현] 주소부분 수정 
 * 						차량 신청현황 시트 추가
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
            var div = "";
            var jobFlag = "";
        /*
         * 페이지로딩
         */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

		cfStyleGrid(getObjectFirst("gr_cust"), "comn");
		cfStyleGrid(getObjectFirst("gr2"), "comn1");
		cfStyleGrid(getObjectFirst("gr_car"), "comn");
		cfStyleGrid(getObjectFirst("gr_car2"), "comn1");
		fnInit(); 
	} 
        
        /*
         * 초기작업
         * Header 설정 
         * 지역
         */
        function fnInit() {
            div = 'init';
            ds_business.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_business.Reset(); //지역코드
	        ds_dp_time.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM014&s_item1=Y";
	        ds_dp_time.Reset();	//출경시각
	        ds_ar_time.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM015&s_item1=Y";
	        ds_ar_time.Reset();	//입경시각
			
            v_fr_depart_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
            v_to_depart_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
        }
        //상품조회
		function fnSelectLcGoods() {
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
			var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
			    + ",sSaupSid=" + v_business.ValueOfIndex("saup_sid", v_business.Index)
					+ ",sDepartDate=";
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			    "JSP(O:S_GOODS_DS=ds_goods)",
			    param);
			tr_post(tr1);
		};
        /*
         * 메인 조회
         */
        function fnSelect() {
            var fr_date = v_fr_depart_date.Text.trim();
            var to_date = v_to_depart_date.Text.trim();
            if(fr_date.length!=8) {
                alert("출발일자(From)를 입력하시길 바랍니다.");
                return;
            }
            if(to_date.length!=8) {
                alert("출발일자(To)를 입력하시길 바랍니다.");
                return;
            }
        
            var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid="+ v_business.ValueOfIndex("saup_sid", v_business.Index)
                      + ",v_goods_sid=" + v_goods_sid.ValueOfIndex("goods_sid", v_goods_sid.Index)
                      + ",v_client_sid=" + v_client_sid.value
                      + ",v_fr_depart_date=" + v_fr_depart_date.Text
                      + ",v_to_depart_date=" + v_to_depart_date.Text
                      + ",v_accept_no=" + v_accept_no.Text;
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv230S",
                "JSP(O:DS_CUST=ds_cust,O:DS2=ds2,O:DS_CAR=ds_car,O:DS_CAR2=ds_car2)",
                param);
               
            tr_post(tr1);
        }
         
        function fnExcelDs1() {
            if(ds_cust.CountRow==0 && ds_tour.CountRow==0){
                alert("데이터를 먼저 조회하시길 바랍니다.");
                return;
            }
            getObjectFirst("gr_cust").SetExcelTitle(0, "");
            getObjectFirst("gr_cust").SetExcelTitle(1, "value:방북 신청현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr_cust").GridToExcel("방북 신청현황", "방북 신청현황.xls", 8);        
            
            if(ds2.RowCount==0){
	            return;
	        }else{
		        getObjectFirst("gr2").SetExcelTitle(0, "");
		        getObjectFirst("gr2").SetExcelTitle(1, "value:방문신청 대상 일괄등록; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        getObjectFirst("gr2").GridToExcel("방문신청 대상 일괄등록","방문신청 대상 일괄등록.xls", 8);
	        }
            if(ds_car.RowCount==0){
	            return;
	        }else{
		        getObjectFirst("gr_car").SetExcelTitle(0, "");
		        getObjectFirst("gr_car").SetExcelTitle(1, "value:차량 신청현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        getObjectFirst("gr_car").GridToExcel("차량 신청현황","차량 신청현황.xls", 8);
	        }
            if(ds_car2.RowCount==0){
	            return;
	        }else{
		        getObjectFirst("gr_car2").SetExcelTitle(0, "");
		        getObjectFirst("gr_car2").SetExcelTitle(1, "value:차량 신고 일괄등록; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        getObjectFirst("gr_car2").GridToExcel("차량 신고 일괄등록","차량 신고 일괄등록.xls", 8);
	        }
            
            
        }

        /**
         * 검색조건 대리점  팝업 
         */
        function fnSelClientPopup(dirPath, servletPath) {
            v_cust_row = 0;
            var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL; 
            var strPos;
            
            arrResult = fnClientPop(dirPath,'2');
        
            if (arrResult != null) {
                arrParam = arrResult.split(";");
                v_client_sid.value = arrParam[0];
                v_client_nm.value = arrParam[1];
                v_client_cd.value = arrParam[2];
            } else {
                v_client_sid.value = "";
                v_client_nm.value  = "";
                v_client_cd.value = "";
            }               
        }

        /**
         * 신청서 번호 조회
         */
        function fnAcceptNoPopup(dirPath, servletPath){
            v_cust_row = 0;
            var arrResult   = new Array();
            arrResult = fnAcceptNoPop(dirPath);
            if (arrResult != null) {
                arrParam = arrResult.split(";");
                getObjectFirst("v_accept_sid").value = arrParam[0];
                getObjectFirst("v_accept_no").Text   = arrParam[1];
            }
        }

        </script>
        

<%
/****************************************************************************
            가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language=JavaScript	for=ds_business event="OnLoadCompleted(row)">
		fnSelectLcGoods();
	</script>
	<script language=JavaScript for=v_business event=OnSelChange()>
		fnSelectLcGoods();//상품 재검색
	</script>
	<script language=JavaScript  for=ds_cust event="OnLoadStarted()" >
        msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
        document.all.LowerFrame.style.visibility="visible"; 
    </script>
 
    <script language=JavaScript  for=ds_cust event="OnLoadCompleted(row)">
        msgTxt.innerHTML="조회가 완료 되었습니다.";
        document.all.LowerFrame.style.visibility="hidden";
        
        if(row==0){
            alert("<%=HDConstant.S_MSG_NO_DATA%>");
        }
    </script>
    
    <script language="javascript" for="tr1" event="onsuccess()">
        msgTxt.innerHTML="작업이 성공적으로 완료되었습니다.";
    </script>   
    
    
    <script language="javascript" for="tr1" event="OnFail()">
        document.all.LowerFrame.style.visibility="hidden";
        msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    
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

	<script language=JavaScript for=v_fr_depart_date event=OnKillFocus()>
		if( v_fr_depart_date.Modified == true )
			v_to_depart_date.text = v_fr_depart_date.text;
	</script>
<%
/*******************************************************************************
            가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>

<object id=ds_cust classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--방북승인신청-->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds_car classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_car2 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_business classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  지역 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_dp_time classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 출경시각 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_ar_time classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 입경시각 -->
    <param name="SyncLoad"  value="True">
</object>


<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품코드 -->
    <param name="SyncLoad"  value="True">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<table border='0' cellpadding='0' cellspacing='0'>	
  <tr>
	<td align='right'>
		<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:pointer"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
		<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:pointer"	align=absmiddle onClick="fnExcelDs1()">		<!-- 엑셀 -->
	</td>
  </tr>
  <tr height="5px">
	<td></td>
  </tr>
  <tr height="30px">
	<td>
		<table border='0' cellpadding='0' cellspacing='1' width='1002px' bgcolor="#666666">
		  <tr height='25px'>
			<td height="20" class="text">협력사</td>
		                    <td bgcolor="#FFFFFF" colspan="3">&nbsp;<input type="text" name='v_client_cd' id='v_client_cd' style="width:60px;" class='input01' readOnly>
		           <input type="hidden" name='v_client_sid' id='v_client_sid'><img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelClientPopup('<%=dirPath%>', '<%=HDConstant.PATH_RV%>');">
		           <input type="text" name='v_client_nm' id='v_client_nm' style="width:120px;" class='input01' readOnly>
		       </td>
		       <td height="25" class="text">신청서번호</td>
		       <td bgcolor="#FFFFFF">&nbsp;
		           <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='110px' align='absmiddle' class='textbox'>            
		               <param name=Format      value="00000-000000000">
		               <param name=Alignment   value=1>
		               <param name=ClipMode    value=true>
		               <param name=Border      value=false>
		               <param name=Enable      value=true>
		               <param name=SelectAll   value=true>
		               <param name=SelectAllOnClick      value=true>
		               <param name=SelectAllOnClickAny   value=false>
		           </object>
		           <input type="hidden" name='v_accept_sid' id='v_accept_sid'>
		           <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onClick="fnAcceptNoPopup('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')" id="v_accept_btn">
		       </td>
		   </tr>
		   <tr height='20px'>
		       <td align=left class="text" width="70">지역</td>
		       <td align=left bgcolor="#ffffff">&nbsp;
		           <object id=v_business classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
		               <param name=ComboDataID     value=ds_business>
		               <param name=BindColumn      value="saup_sid">
		               <param name=BindColVal      value="saup_sid">
		               <param name=EditExprFormat  value="%,%;saup_sid,saup_nm">
		               <param name=ListExprFormat  value="saup_nm^0^120">
		           </object>
		           
		       </td>   
		       <td align=left class="text"  width="70">출발일자</td>
		       <td align=left bgcolor="#ffffff">&nbsp;
		           <object id=v_fr_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">
		                        <param name=Text        value="">
		                        <param name=Alignment   value=1>
		<param name=Format      value="YYYY-MM-DD">
		                        <PARAM NAME=InputFormat value="YYYYMMDD">
		                        <param name=Cursor      value="iBeam">
		                        <param name=Border      value="false">      
		                        <param name=InheritColor      value="true">                                                                                                                                                                                                             
		                        <param name=ReadOnly    value="false">
		                        <param name=SelectAll   value="true">
		                        <param name=SelectAllOnClick    value="true">
		                        <param name=SelectAllOnClickAny   value=false>
		                    </object> ~ 
		                    <object id=v_to_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
		                        <param name=Text        value="">
		                        <param name=Alignment   value=1>
		<param name=Format      value="YYYY-MM-DD">                                
		                        <PARAM NAME=InputFormat value="YYYYMMDD">
		                        <param name=Cursor      value="iBeam">
		                        <param name=Border      value="false">      
		                        <param name=InheritColor      value="true">                                                                                                                                                                                                             
		                        <param name=ReadOnly    value="false">
		                        <param name=SelectAll   value="true">
		                        <param name=SelectAllOnClick    value="true">
		                        <param name=SelectAllOnClickAny   value=false>
		                    </object>
		                                                                                                 
		                </td>                                                                                           
		                <td align=left class="text" width="70">상품정보</td>
		                <td align=left bgcolor="#ffffff">&nbsp;
		                    <object id=v_goods_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=120 border="0" align=absmiddle>
		                <param name=ComboDataID     value=ds_goods>
		                <param name=ListExprFormat  value="goods_nm^0^150"></object>
		            &nbsp;   
		        </td>
		    </tr>
		</table>
    </td>
  </tr> 
  <tr height='30px'>
	<td>&nbsp;</td>
  </tr>
  <tr>
	<td valign="top" height='360px'>
		<table  border='0' cellpadding='0' cellspacing='0' id="tb_cust_id">
		  <tr>
			<td valign='top'>
                           
			<object id=mxTab classid=CLSID:ED382953-E907-11D3-B694-006097AD7252 style="position:absolute; left:12; top:180; width:1002; height:20">
				<param name="BackColor"			value="#00ffff">
				<param name="DisableBackColor"	value="#ffffee">
				<param name="Format"			value='
					<T>divid="mxTab_page1"	title="방북 신청현황"</T>
					<T>divid="mxTab_page2"	title="방문신청 대상 일괄등록"</T>
					<T>divid="mxTab_page3"	title="차량 신청현황"</T>
					<T>divid="mxTab_page4"	title="자동차운행 신고대상 일괄등록"</T>
					'>
			</object>
	
			<div class=page id="mxTab_page1" style="position:absolute; left:12; top:200; width:1002; height:300">
				<object id=gr_cust classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='350px' border='1'>
					<param name="DataID"            value="ds_cust">
					<param name="ColSizing"         value="true">
					<param name="Editable"          value="true">
					<param name="SuppressOption"    value="1">
					<param name="BorderStyle"       value="0">
					<param name=ViewSummary  value="1">
					<param name=SortView  value="right">
					<param name="Format"        value="
						<C> name='순'			ID='{CURROW}'			width=40 align=center Edit=None</C>
						<C> name='직장'		ID='COMPANY_NM'		width=100 align=left Edit=None suppress=1 sumtext=계 sort = true</C>
						<C> name='직위'		ID='POSITIONS'			width=60 align=left Edit=None </C>
						<C> name='성명'		ID='CUST_NM'				width=60 align=center Edit=None sumtext=@count sort = true</C>
						<C> name='생년월일'		ID='BIRTH_DATE'	width=70 align=left Edit=None sumtext=명 sort = true</C>
						<C> name='사는 곳'			ID='ADDRESS1'	width=80 align=left Edit=None </C>
						<C> name='방문목적'		ID='VISIT_AIM'		width=100 align=left Edit=None sort = true</C>
						
						<C> name='방문기간'		ID='VISIT_DATES'	width=130 align=center Edit=None</C>
						 <G> name='출국예정'
						<C> name='일자'				ID='DEPART_DATE'	width=50 align=center Edit=None</C>
						<C> name='시각'				ID='DEPART_TIME'	width=80 align=center Edit=None editstyle=lookup data='ds_dp_time:detail:detail_nm' </C>
						 </G>
						 <G> name='입국예정'
						<C> name='일자'				ID='ARRIVE_DATE'	width=50 align=center Edit=None</C>
						<C> name='시각'				ID='ARRIVE_TIME'	width=80 align=center Edit=None editstyle=lookup data='ds_ar_time:detail:detail_nm' </C>
						 </G>	
						<C> name='사진명단\\제출여부'	ID='VISIT_K_LIST'	width=60 align=center Edit=None bgColor={IF(VISIT_K_LIST='최초','#ffcccc','#FFFFFF') }</C>
						<C> name='실무번호'		ID='WORK_NO'			width=100 align=center Edit=None</C>
						<C> name='성별'				ID='GENDER'			width=40 align=center Edit=None</C>
						<C> name='입력자'			ID='I_EMPNM'			width=60 align=center Edit=None</C>
						<C> name='주민/여권'		ID='MANAGE_NO'		width=100 align=center Edit=None</C>
						<C> name='상품명'			ID='GOODS_NM'		width=100 align=left Edit=None </C>
						<C> name='객실등급'		ID='ROOM_TYPE_CD'	width=60 align=center Edit=None</C>
						<C> name='객실번호'		ID='ROOM_NO'			width=60 align=center Edit=None</C>
						<C> name='입력일시'		ID='I_DATE'					width=80 align=left Edit=None</C>
						<C> name='수정일시'		ID='U_DATE'					width=80 align=left Edit=None</C>
						<C> name='예약번호'		ID='RSV_SID'				width=80 align=left Edit=None</C>
						<C> name='방북증\\소재'	ID='n_card_gu'		width=60 align=left Edit=None</C>
					">                             
				</object>   
			</div>
			<div class=page id="mxTab_page2" style="position:absolute; left:12; top:200; width:845; height:300">
				<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='350px' border='1'>
					<param name="DataID"            value="ds2">
					<param name="ColSizing"         value="true">
					<param name="Editable"          value="FALSE">
					<param name="SuppressOption"    value="1">
					<param name="BorderStyle"       value="0">
					<param name=ViewSummary  value="1">
					<param name=SortView  value="right">
					<param name="Format"        value="
						<C> name='재외국민\\여부(*)'  	ID='LIVE_OUT_YN'  	width=70 align=center editlimit=30 show=true  SumText=@count SumTextAlign=right</C>
						<C> name='주민등록번호'			ID='REGI_NO'		width=100 align=center Edit=None SumText='명' SumTextAlign=left</C>
						<C> name='여권번호'				ID='PASS_NO'		width=100 align=center Edit=None</C>
						<C> name='성명(*)'				ID='CUST_NM'		width=70 align=center Edit=None  sort = true</C>
						<C> name='성명\\(한자)'			ID='NAME_CHINESE'	width=60 align=center Edit=None  </C>
						<C> name='성명\\(영문)'			ID='NAME_ENG'		width=60 align=center Edit=None  </C>
						<C> name='집전화(*)'			ID='TEL_NO'			width=100 align=center Edit=None</C>
						<C> name='휴대전화'				ID='MOBILE_NO'		width=100 align=center Edit=None</C>
						<C> name='직장명(*)'			ID='COMPANY_NM'		width=100 align=center Edit=None sort = true</C>
						<C> name='직위(*)'				ID='POSITIONS'		width=60 align=center Edit=None </C>
						<C> name='직장전화'				ID='TEL_CM'			width=100 align=center Edit=None</C>
						<C> name='집우편번호(*)'		ID='ZIP_CD'			width=80 align=center Edit=None</C>
						<C> name='집주소1(*)'    		ID='ADDRESS1'   	width=150 align=center editlimit=50 show=true</C>
						<C> name='집주소2(*)'    		ID='ADDRESS2'   	width=150 align=center editlimit=50 show=true</C>
						<C> name='방문경험'				ID='NORTH_CNT'		width=60 align=center Edit=None</C>
						<C> name='신장(cm)'				ID='HEIGHT'			width=60 align=center Edit=None </C>
						<C> name='가입단체명'			ID='FAX_NO'			width=70 align=center Edit=None</C>
						<C> name='단체직책'				ID='FAX_NO'			width=60 align=center Edit=None</C>
						<C> name='생년월일'    			ID='BIRTH_DATE'   	width=60 	align=center editlimit=50 show=true</C>
						<C> name='성별'					ID='GENDER'			width=40 align=center Edit=None</C>
						<C> name='국적'     			ID='NATION_NM'    	width=50 	align=center editlimit=60 show=true </C>
						<C> name='여권유효기간\\시작일'	ID='PASS_ISSUE_DATE'		width=90 align=center Edit=None</C>
						<C> name='여권유효기간\\종료일'	ID='PASS_EXPIRE_DATE'		width=90 align=center Edit=None</C>
						<C> name='개인정보제공\\동의여부(*)'	ID='PRVC_AGREE'		width=80 align=left Edit=None</C>
					">                             
				</object>
			</div>   

			<div class=page id="mxTab_page3" style="position:absolute; left:12; top:200; width:1002; height:300">
				<object id=gr_car classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='350px' border='1'>
					<param name="DataID"            value="ds_car">
					<param name="ColSizing"         value="true">
					<param name="Editable"          value="false">
					<param name="SuppressOption"    value="1">
					<param name="BorderStyle"       value="0">
					<param name=ViewSummary  value="1">
					<param name=SortView  value="right">
					<param name="Format"        value="
						<C> name='순'			ID='{CURROW}'			width=40 align=center Edit=None sumtext=계 </C>
					  <G> name='협력사'
						<C> name='코드'		ID='CLIENT_CD'		width=50 align=center Edit=None suppress=1 sumtext=@CNT </C>
						<C> name='이름'		ID='CLIENT_NM'		width=80 align=left Edit=None suppress=1 sumtext='대' SumTextAlign=left sort=true</C>
					  </G>
					  <G> name='출국예정'
						<C> name='일자'				ID='DEPART_DATE'	width=60 align=center Edit=None </C>
						<C> name='시각'				ID='DEPART_TIME'	width=80 align=center Edit=None editstyle=lookup data='ds_dp_time:detail:detail_nm'  sort=true</C>
						<C> name='운전자'			ID='DP_DRIVER'		width=60 align=center Edit=None </C>
					  </G>
					  <G> name='입국예정'
						<C> name='일자'				ID='ARRIVE_DATE'	width=60 align=center Edit=None</C>
						<C> name='시각'				ID='ARRIVE_TIME'	width=80 align=center Edit=None editstyle=lookup data='ds_ar_time:detail:detail_nm'  sort=true</C>
						<C> name='운전자'			ID='AR_DRIVER'		width=60 align=center Edit=None </C>
					  </G>
					    <C> name='소속'       		ID='tt_client_nm'   align=left	width=80 	show=true   sort=true </C>
		                <C> name='차량SID'      	ID='car_sid'    	align=left width=100 	show=false</C>
						<C> name='차명'       		ID='car_nm'      	align=center width=80 	show=true  	</C>
						<C> name='차량\\등록번호'	ID='CAR_NO'	  		align=center Width=60   Edit=None 	sort=false</C>
						<C> name='차종' 			ID='CAR_TYPE' 	  	align=left Width=70   	Edit=None</C>
						<C> name='참고사항' 		ID='car_desc'       align=left width=110 	editlimit=100 	show=true  </C>
					">                             
				</object>   
			</div>

			<div class=page id="mxTab_page4" style="position:absolute; left:12; top:200; width:1002; height:300">
				<object id=gr_car2 classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='350px' border='1'>
					<param name="DataID"            value="ds_car2">
					<param name="ColSizing"         value="true">
					<param name="Editable"          value="false">
					<param name="SuppressOption"    value="1">
					<param name="BorderStyle"       value="0">
					<param name=ViewSummary  value="1">
					<param name=SortView  value="right">
					<param name="Format"        value="
						<C> name='차량등록번호\\(*)'	 ID='CAR_NO'		width=80 align=center Edit=None suppress=1 sumtext='총' </C>
						<C> name='차량명칭'				 ID='CAR_NM'		width=80 align=left Edit=None suppress=1 sumtext=@cnt SumTextAlign=center sort=true</C>
						<C> name='차량\\종류'			 ID='TT_CAR_TYPE'	width=40 align=center Edit=None sumtext='대' SumTextAlign=left </C>
						<C> name='적재중량\\(톤)(*)'	 ID='TT_CAR_KG'		width=60 align=center Edit=None </C>
						<C> name='승차정원\\(명)'		 ID='TT_CAR_PERSONS'	width=60 align=center Edit=None </C>
						<C> name='운행기간\\시작일(*)'	 ID='TT_BGNDATE'	width=70 align=center Edit=None</C>
						<C> name='운행기간\\종료일'		 ID='TT_ENDDATE'	width=70 align=center Edit=None</C>
						<C> name='차량소속'				 ID='TT_CLIENT_NM'	width=100 align=left Edit=None </C>
						<C> name='운행\\구분'			 ID='TT_GUBN'		width=40 align=center Edit=None </C>
					    <C> name='운행\\횟수'     		 ID='TT_COUNT'   	align=center	width=40 	show=true </C>
		                <C> name='운행\\용도(*)'       ID='TT_USE'    	align=center width=50 	show=true</C>
						<C> name='운행경로\\출발지(*)'   ID='TT_START'     	align=center width=70 	show=true</C>
						<C> name='운행경로\\운행지역(*)' ID='TT_SITE'	 	align=center Width=70   Edit=None</C>
						<C> name='차량운행증\\교부처(*)' ID='TT_ISSUE' 	  	align=center Width=70   	Edit=None</C>
						
					">                             
				</object>   
			</div>


		</td>
	  </tr>
	</table>
	</td>
  </tr>
  <tr>
	<td>※ 해당 일자에 방문 신청되어 있는 인원, 차량의 정보를 표시합니다.<br>
		　 운전자 지정, 차량 배정은 출입>출입계획>차량 탑승(출경), 차량 탑승(입경) 메뉴에서 처리합니다.<br>
		※ 방북 신청현황 : 일반 사업자<br>
		　 방문신청 대상 일괄등록 : 일반 사업자 + 조장 + 초청 사업자

	</td>
  </tr>
</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>