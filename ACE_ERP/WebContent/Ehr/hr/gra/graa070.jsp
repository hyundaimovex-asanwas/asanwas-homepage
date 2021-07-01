<!--
***********************************************************************
* @source      : graa070.jsp
* @description : 급상여소급처리 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/01/15      오대성        최초작성.
* 2007/04/25      김학수        인쇄부분추가.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>급상여소급처리(graa070)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TFTTTTFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var f = document.form1;
            var pis_yymm = f.txtPIS_YYMM_SHR.value;
            var occ_cd = f.cmbOCC_CD_SHR.value;
            var dpt_cd1 = f.cmbDPT_CD_SHR1.value;
            var dpt_cd2 = f.cmbDPT_CD_SHR2.value;
            var job_cd1 = f.cmbJOB_CD_SHR1.value;
            var job_cd2 = f.cmbJOB_CD_SHR2.value;
            var cd_gbn = "";
            if(f.rdoSEL_SHR[0].checked){
                cd_gbn = "A4";  //소속
            } else {
                cd_gbn = "A2";  //직위
            }

            if(!fnc_SearchItemCheck()) return;

			dsT_CP_CHANGE.dataid = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa070.cmd.GRAA070CMD&S_MODE=SHR&PIS_YYMM="+pis_yymm+"&OCC_CD="+occ_cd+"&DPT_CD1="+dpt_cd1+"&DPT_CD2="+dpt_cd2+"&JOB_CD1="+job_cd1+"&JOB_CD2="+job_cd2+"&CD_GBN="+cd_gbn;
    		dsT_CP_CHANGE.reset();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {
            var f = document.form1;
            var PIS_YYMM_SHR = f.txtPIS_YYMM_SHR.value;
            var RET_YYMM_SHR = f.txtRET_YYMM_SHR.value;
            var APY_YMD_SHR = f.txtAPY_YMD_SHR.value;

			//투입년월이 없으면 조회못함.
			if(PIS_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("투입년월을 입력하세요.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
				}
			}

			//투입년월이 잘못되었으면 조회못함.
			if(PIS_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("투입년월이 잘못되었습니다.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
				}
			}

			//소급년월이 없으면 조회못함.
			if(RET_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("소급년월을 입력하세요.");
					document.getElementById("txtRET_YYMM_SHR").focus();
					return false;
				}
			}

			//소급년월이 잘못되었으면 조회못함.
			if(RET_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("소급년월이 잘못되었습니다.");
					document.getElementById("txtRET_YYMM_SHR").focus();
					return false;
				}
			}

			//호봉표일자이 없으면 조회못함.
			if(APY_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("호봉표일자를 입력하세요.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}

			//호봉표일자이 잘못되었으면 조회못함.
			if(APY_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("호봉표일자가 잘못되었습니다.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}

            if (confirm("급상여 소급처리를 하시겠습니까? ") == false) return;


			dsT_CP_WORKLOG.dataid = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa070.cmd.GRAA070CMD&S_MODE=SAV&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&RET_YYMM_SHR="+RET_YYMM_SHR+"&APY_YMD_SHR="+APY_YMD_SHR;
			dsT_CP_WORKLOG.reset();
        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {
            var f = document.form1;
            var pis_yymm = f.txtPIS_YYMM_SHR.value;
            var occ_cd   = f.cmbOCC_CD_SHR.value;
            var dpt_cd1  = f.cmbDPT_CD_SHR1.value;
            var dpt_cd2  = f.cmbDPT_CD_SHR2.value;
            var job_cd1  = f.cmbJOB_CD_SHR1.value;
            var job_cd2  = f.cmbJOB_CD_SHR2.value;

            var cd_gbn = "";
            if(f.rdoSEL_SHR[0].checked){
                cd_gbn = "A4";
            } else {
                cd_gbn = "A2";  //상여
            }

            if(!fnc_SearchItemCheck()) return;

            var url = "graa070_PV.jsp?pis_yymm="+pis_yymm+"&occ_cd="+occ_cd+"&dpt_cd1="+dpt_cd1+"&dpt_cd2="+dpt_cd2+"&job_cd1="+job_cd1+"&dpt_cd2="+dpt_cd2+"&cd_gbn="+cd_gbn;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_CHANGE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            
            form1.grdT_CP_CHANGE.GridToExcel("급상여소급처리", '', 225)

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            //document.getElementById('txtPIS_YYMM_SHR').value = '';
            //document.getElementById('txtRET_YYMM_SHR').value = '';
            //document.getElementById('txtAPY_YMD_SHR').value = '';
            document.getElementById('cmbOCC_CD_SHR').value = 'A';
            document.getElementById('cmbDPT_CD_SHR1').value = ' ';
            document.getElementById('cmbDPT_CD_SHR2').value = ' ';
            document.getElementById('cmbJOB_CD_SHR1').value = ' ';
            document.getElementById('cmbJOB_CD_SHR2').value = ' ';
            document.form1.rdoSEL_SHR[0].checked = true;
			document.getElementById("resultMessage").innerText = ' ';

            changeInput();
            
			dsT_CP_CHANGE.ClearData();
			dsT_CP_WORKLOG.ClearData();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

			var pis_yymm = document.getElementById("txtPIS_YYMM_SHR");

            if(pis_yymm.value == ""){
                alert("투입년월은 반드시 입력하셔야합니다!");
                pis_yymm.focus();
                return false;
            }
            return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
        
			//근로구분
            for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
                document.getElementById("cmbOCC_CD_SHR").add(oOption);

            }
            
            //직위
            for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbJOB_CD_SHR1").add(oOption);
                
            }
            for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbJOB_CD_SHR2").add(oOption);
                
            }
            
            //소속
            for( var i = 1; i <= dsT_CM_COMMON_A4.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A4.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A4.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A4.NameValue(i,"CODE_NAME");
                document.getElementById("cmbDPT_CD_SHR1").add(oOption);
                
            }            
            for( var i = 1; i <= dsT_CM_COMMON_A4.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A4.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A4.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A4.NameValue(i,"CODE_NAME");
                document.getElementById("cmbDPT_CD_SHR2").add(oOption);
                
            }            

			cfStyleGrid(form1.grdT_CP_CHANGE,0,"false","false");      // Grid Style 적용
			
			changeInput();
			
			document.getElementById('txtPIS_YYMM_SHR').value = getToday().substring(0,4)+"-04";
			document.getElementById('txtRET_YYMM_SHR').value = getToday().substring(0,4)+"-03";
			
			//호봉표일자 자동으로 가져오기
            ds01T_CP_PAYTABLE.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga010.cmd.SAGA010CMD&S_MODE=SHR_01";
            ds01T_CP_PAYTABLE.Reset();

            document.getElementById('txtPIS_YYMM_SHR').focus();
            
            

        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************
         * 직위/소속 선택에 따른 입력 구분          *
         ********************************************/
        function changeInput() {

            if( document.form1.rdoSEL_SHR[0].checked ){
                document.form1.cmbDPT_CD_SHR1.disabled = false;
                document.form1.cmbDPT_CD_SHR2.disabled = false;
                document.form1.cmbJOB_CD_SHR1.disabled = true;
                document.form1.cmbJOB_CD_SHR2.disabled = true;

                document.form1.cmbDPT_CD_SHR1.value = " ";
                document.form1.cmbDPT_CD_SHR2.value = " ";
                document.form1.cmbJOB_CD_SHR1.value = " ";
                document.form1.cmbJOB_CD_SHR2.value = " ";

            }else{
                document.form1.cmbDPT_CD_SHR1.disabled = true;
                document.form1.cmbDPT_CD_SHR2.disabled = true;
                document.form1.cmbJOB_CD_SHR1.disabled = false;
                document.form1.cmbJOB_CD_SHR2.disabled = false;            

                document.form1.cmbDPT_CD_SHR1.value = " ";
                document.form1.cmbDPT_CD_SHR2.value = " ";
                document.form1.cmbJOB_CD_SHR1.value = " ";
                document.form1.cmbJOB_CD_SHR2.value = " ";
               
            }

        }


	</script>


 </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CP_CHANGE)   |
    | 3. 사용되는 Table List(T_CP_CHANGE)		     |
    +------------------------------------------------>
    <Object ID="dsT_CP_CHANGE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name="SubSumExpr"      value="total">
    </Object>

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CP_WORKLOG)   |
    | 3. 사용되는 Table List(T_CP_WORKLOG)		     |
    +------------------------------------------------>
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name="SubSumExpr"      value="total">
        <param name=TimeOut           value=200000>
    </Object>
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : ds01T_CP_PAYTABLE                   |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="ds01T_CP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>    

	<!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 직위 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="A2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 소속 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A4"/>
       <jsp:param name="CODE_GUBUN"    value="A4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>
    
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CP_CHANGE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount-1);//합계 제외(-1)

            //그리드에 합계 내역 표시
//            var sum = 0;
//
//            for(i=1;i<=iCount;i++){
//                sum = sum + dsT_CP_CHANGE.NameValue(i,"AMOUNT");
//            }
//            dsT_CP_CHANGE.AddRow();
//
//            dsT_CP_CHANGE.NameValue(iCount+1,"DPT_NM") = "      합   계";
//            dsT_CP_CHANGE.NameValue(iCount+1,"ENO_NO") = iCount+" 명";
//            dsT_CP_CHANGE.NameValue(iCount+1,"AMOUNT") = sum;

        }

    </Script>

    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">

		fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </Script>
    
    <Script For=ds01T_CP_PAYTABLE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
            var oAPY_YMD = ds01T_CP_PAYTABLE.NameValue(1,"APY_YMD").trim();
            document.getElementById("txtAPY_YMD_SHR").value = oAPY_YMD.substring(0,4)+"-"+oAPY_YMD.substring(4,6)+"-"+oAPY_YMD.substring(6,8);
            document.getElementById("txtAPY_YMD_SHR").focus();
        }
    </Script>    

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CP_CHANGE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>
    
    <Script For=ds01T_CP_PAYTABLE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>
    

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">급상여소급처리</td>
					<td align="right" class="navigator">HOME/인사관리/승급/<font color="#000000">급상여소급처리</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_ConductOver.gif',1)">    <img src="/images/button/btn_ConductOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>			
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
                                    <col width="65"></col>
                                    <col width="80"></col>
                                    <col width="80"></col>
                                    <col width="70"></col>
                                    <col width="230"></col>
                                    <col width=""></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">투입년월&nbsp;</td>
								<td class="padding2423"><input id="txtPIS_YYMM_SHR" size="7" maxlength="7" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfCheckNumber();" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; this.focus();} cfCheckDate(this);" onkeyup="cfDateHyphen(this);" style="ime-mode:disabled">
                                   <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','10','120');"></a>
                                </td>
								<td align="right" class="searchState">근로구분&nbsp;</td>
								<td class="padding2423">
									<select id="cmbOCC_CD_SHR" style="WIDTH:60" onChange="fnc_SearchList();">
									</select>
								</td>
								<td class="padding2423">
									<input type="radio" id="radio11" name="rdoSEL_SHR" style="border:none" value="0" onClick="changeInput()" checked>
									<b>소속</b>
                                    <select id="cmbDPT_CD_SHR1" name="cmbDPT_CD_SHR1" style="WIDTH:75">
                                        <option value=" "> </option>
                                    </select>
                                    ~
                                    <select id="cmbDPT_CD_SHR2" name="cmbDPT_CD_SHR2" style="WIDTH:75">
                                        <option value=" "> </option>
                                    </select>
                                </td>
								<td>
								    <input type="radio" id="radio12" name="rdoSEL_SHR" style="border:none" value="0" onClick="changeInput()">
								    <b>직위</b>
                                    <select id="cmbJOB_CD_SHR1" name="cmbJOB_CD_SHR1" style="WIDTH:75">
                                        <option value=" "> </option>
                                    </select>
                                    ~
                                    <select id="cmbJOB_CD_SHR2" name="cmbJOB_CD_SHR2" style="WIDTH:75">
                                        <option value=" "> </option>
                                    </select>
								</td>
							</tr>
							<tr>
								<td align="right" class="searchState">소급년월&nbsp;</td>
								<td class="padding2423"><input id="txtRET_YYMM_SHR" size="7" maxlength="7" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfCheckNumber();" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; this.focus();} cfCheckDate(this);" onkeyup="cfDateHyphen(this);" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtRET_YYMM_SHR','','10','150');"></a>
                                </td>
								<td align="right" class="searchState">호봉표일자&nbsp;</td>
								<td class="padding2423" colspan="3">
									<input id="txtAPY_YMD_SHR" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPY_YMD_SHR','','220','150');"></a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- power Search테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CP_CHANGE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"					value="dsT_CP_CHANGE">
							<param name="Format"					value="
								<C> id={currow}		width=40    name='NO'		align=center    BgColor={decode(ENO_NO, '', '#99FFCC')} </C>
								<C> id='DPT_NM'		width=120	name='소속'		align=center    BgColor={decode(ENO_NO, '', '#99FFCC')} SubSumText='합계'</C>
								<C> id='JOB_NM'		width=74	name='직위'		align=center    BgColor={decode(ENO_NO, '', '#99FFCC')} </C>
								<C> id='ENO_NO'		width=90	name='사번'		align=center    BgColor={decode(ENO_NO, '', '#99FFCC')} </C>
								<C> id='ENO_NM'		width=90	name='성명'		align=center    BgColor={decode(ENO_NO, '', '#99FFCC')} </C>
								<C> id='PAY_CNT'	width=70	name='횟수'		align=center    BgColor={decode(ENO_NO, '', '#99FFCC')} </C>
								<C> id='AMOUNT'		width=110	name='소급액'	align=right     BgColor={decode(ENO_NO, '', '#99FFCC')} </C>
								<C> id='REMARK'		width=185	name='비고'		align=left      BgColor={decode(ENO_NO, '', '#99FFCC')} </C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 내용 조회 그리드 데이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>
