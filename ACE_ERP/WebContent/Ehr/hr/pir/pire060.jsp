<!--*************************************************************************
* @source      : pire060.jsp												*
* @description : 근무 기간 검색                      					    *
* @source      : pire060.jsp												*
* @description : 근무 기간 검색												*
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION									*
*----------------------------------------------------------------------------
* 2011/08/01            이동훈            	최초작성                        *

***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>근무 기간 검색(pire060)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TFFTTTFT';
		var today = getToday();


		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

            var FIELD_CD_SHR = document.getElementById("cmbFIELD_CD_SHR").value;
            var FIELD2_CD_SHR = document.getElementById("cmbFIELD2_CD_SHR").value;

            var HIR_YMD_SHR = document.getElementById("txtHIR_YMD_SHR").value;
            var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;


            dsT_CM_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.pir.e.pire060.cmd.PIRE060CMD&S_MODE=SHR"
            						+"&FIELD_CD_SHR="+FIELD_CD_SHR
            						+"&FIELD2_CD_SHR="+FIELD2_CD_SHR
            						+"&HIR_YMD_SHR="+HIR_YMD_SHR
            						+"&END_YMD_SHR="+END_YMD_SHR;

			//prompt(this, dsT_CM_PERSON.dataid);

            dsT_CM_PERSON.reset();


        }


		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 03. 저장 함수								*
         ********************************************/
        function fnc_Save() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {

        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_CM_PERSON.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CM_PERSON.GridToExcel("인원현황", '', 225);
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {

           	document.form1.cmbFIELD_CD_SHR.selectedIndex      = 0;
           	//document.form1.cmbFIELD2_CD_SHR.selectedIndex      = 0;

        	document.getElementById("resultMessage").innerText = ' ';

            dsT_CM_PERSON.ClearData();

        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {

			if (dsT_CM_PERSON.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {
  			//이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

			document.getElementById('txtHIR_YMD_SHR').value = getToday().substring(0,8)+'01';
			document.getElementById('txtEND_YMD_SHR').value = getToday();

            //Grid Style 적용
            cfStyleGrid(form1.grdT_CM_PERSON,0,"false","true");

			//소속
			gcds_FIELD2_CD_SHR.DataID="/servlet/GauceChannelSVL?cmd=hr.pir.e.pire060.cmd.PIRE060CMD&S_MODE=SHR_DPT";
           					//	+"&DPT="+document.getElementById('cmbFIELD_CD_SHR').value;

			gcds_FIELD2_CD_SHR.Reset();


            // 근무지구분  검색 콤보박스 생성
			//for( var i = 1; i <= dsT_CM_COMMON_B7.CountRow; i++ ) {
			//	oOption       = document.createElement("OPTION");
            //    oOption.value = dsT_CM_COMMON_B7.NameValue(i,"CODE");
            //    oOption.text  = dsT_CM_COMMON_B7.NameValue(i,"CODE_NAME");
			//	document.getElementById("cmbFIELD_CD_SHR").add(oOption);
			//}

            //소속
            for( var i = 1; i <= dsCOMMON_DPT2.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_DPT2.NameValue(i,"DPT_CD");
                oOption.text  = dsCOMMON_DPT2.NameValue(i,"DPT_NM");
                document.getElementById("cmbFIELD2_CD_SHR").add(oOption);
            }

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form이 Active 될 때 처리 할 일 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form이 Active 될 때 마다 재조회 처리
		}

		/********************************************
         * 날짜 형식 유효성 체크                           			*
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
            }
        }

		/********************************************
         * onselchange일 경우             			*
         ********************************************/
		function fnc_match() {






			 if(document.getElementById('cmbFIELD_CD_SHR').value=="1"){ 	//본사


			 }else if(document.getElementById('cmbFIELD_CD_SHR').value=="2"){ //해외


			 }else if(document.getElementById('cmbFIELD_CD_SHR').value=="3"){ //국내현장


			 }else if(document.getElementById('cmbFIELD_CD_SHR').value=="4"){ //금강산


			 }else if(document.getElementById('cmbFIELD_CD_SHR').value=="5"){ //개성


			 }else if(document.getElementById('cmbFIELD_CD_SHR').value=="6"){ //고성


			 }else if(document.getElementById('cmbFIELD_CD_SHR').value=="8"){ //도라산

			 //	gcds_FIELD2_CD_SHR.DataID="/servlet/GauceChannelSVL?cmd=hr.pir.e.pire060.cmd.PIRE060CMD&S_MODE=SHR_DPT"
	         //   						+"&DPT="+document.getElementById('cmbFIELD_CD_SHR').value;

			 //	gcds_FIELD2_CD_SHR.Reset();

	         //   for( var i = 1; i <= gcds_FIELD2_CD_SHR.CountRow; i++ ) {
	         //       oOption       = document.createElement("OPTION");
	         //       oOption.value = gcds_FIELD2_CD_SHR.NameValue(i,"DPT_CD");
	         //       oOption.text  = gcds_FIELD2_CD_SHR.NameValue(i,"DPT_NM");
	         //       document.getElementById("cmbFIELD2_CD_SHR").add(oOption);

			 //	}

		     }

		}

    </script>
</head>




	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)		   |
    | 3. 사용되는 Table List(T_CM_PERSON) 			   	   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>


	<OBJECT id=gcds_FIELD2_CD_SHR classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
		<PARAM NAME="SyncLoad" VALUE="True">
	</OBJECT>

    <!-- 공통 콤보를 위한 DataSet -->

    <!-- 근무지 구분 -->
    <jsp:include page="/common/gauceDataSet_DPT.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_DPT"/>
       <jsp:param name="CODE_GUBUN"    value="SHR_DPT"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 소속 구분 -->
    <jsp:include page="/common/gauceDataSet_DPT.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_DPT2"/>
       <jsp:param name="CODE_GUBUN"    value="SHR_DPT2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 근무지 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_B7"/>
       <jsp:param name="CODE_GUBUN"    value="B7"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!------------------------------+
    | 그리드의 ROW를 더블클릭 할때  |
    +------------------------------->
	<script language=JavaScript for=grdT_CM_PERSON event="OnDblClick(row,colid)">
        if(row < 1) {
            return;
        } else {
            var url = "";
            var data = new String();

            data.eno_no     = dsT_CM_PERSON.NameValue(row, "ENO_NO");
            data.mode       = "read";
            url = "/hr/pir/pirc010.jsp";

            window.showModalDialog(url, data, "dialogWidth:870px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
        }
	</script>



	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->
    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_PERSON.CountRow);
        }

    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_CM_PERSON Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trT_CM_PERSON event="OnSuccess()">
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   					   |
    +------------------------------------------------------>
	<script for=trT_CM_PERSON event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 캘린더 프레임-->
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
				<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">근무 기간 검색</td>
				<td align="right" class="navigator">HOME/인사관리/인사현황데이터/<font color="#000000">근무 기간 검색</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" class="greenTable">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr>
                <td align="right" class="searchState">근무지</td>
                <td class="padding2423" align="left">

					<select id="cmbFIELD_CD_SHR" style="width:100" >
                        <option value="">전체</option>
						<option value="1">본사</option>
						<option value="2">해외</option>
						<option value="3">국내현장</option>
						<option value="4">금강산</option>
						<option value="5">개성</option>
						<option value="6">고성</option>
						<option value="8">도라산</option>
					</select>
                </td>

                <td align="right" class="searchState">소속</td>
                <td class="padding2423" align="left">
                    <select id=cmbFIELD2_CD_SHR style="WIDTH:100" >
                        <option value="">전체</option>
                    </select>
                </td>

				<td class="searchState" align="right">근무일자</td>
				<td class="padding2423" align="left" >
					<input type="text" id="txtHIR_YMD_SHR" name="txtHIR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgHIR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgHIR_YMD_SHR" name="imgHIR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtHIR_YMD_SHR','','134','108');"></a>
				    -
					<input type="text" id="txtEND_YMD_SHR" name="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgEND_YMD_SHR" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD_SHR','','134','108');"></a>
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
                        <object    id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
                            <param name="DataID"                  value="dsT_CM_PERSON">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="right">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <FC> id={currow}      	width='35'  name='No'       			align=center value={String(Currow)} </FC>
								<FC> id='APP_YMD'		width='70'	name='발령일'				align='center' mask='XXXX-XX-XX'</FC>


								<FC> id='APP_CD'		width='70'	name='발령'					align='center' </FC>

								<FC> id='STR_YMD'		width='70'	name='시작일'				align='center' mask='XXXX-XX-XX'</FC>
								<FC> id='END_YMD'		width='70'	name='종료일'				align='center' mask='XXXX-XX-XX'</FC>
								<FC> id='WRK_DAY'		width='70'	name='근무일'				align='center' </FC>
								<FC> id='ENO_NM'		width='70'	name='성명'					align='center' </FC>
								<C> id='GBN_NM'			width='100'	name='근무지'				align='center' show=false</C>
								<C> id='ENO_NO'			width='60'	name='사번'					align='center' </C>
								<C> id='HEAD_NM'		width='100'	name='본부'					align='left' show=false </C>
								<C> id='DPT_NM'			width='100'	name='소속'					align='center' </C>
								<C> id='TEAM_NM'		width='120'	name='팀'					align='left' show=false </C>
								<C> id='JOB_NM'			width='80'	name='직위'					align='center' </C>
								<C> id='HOB_CD'			width='50'	name='호봉'					align='center' show=false </C>
								<C> id='MF_TAG'			width='70'	name='남녀'					align='center' value={if(MF_TAG='M','남자',IF(MF_TAG='F','여자',''))}</C>
								<C> id='OCC_NM'			width='80'	name='근로구분'				align='center' </C>
								<C> id='DPA_YMD'		width='80'	name='소속발령일'			align='center' </C>
								<C> id='JPR_YMD'		width='90'	name='승진일'				align='center' </C>
								<C> id='HIRG_YMD'		width='90'	name='그룹 입사일'			align='center' </C>
								<C> id='HIR_YMD'		width='90'	name='입사일'				align='center' </C>
								<C> id='BIR_YMD'		width='90'	name='생년월일'				align='center' </C>
								<C> id='CET_NO'			width='120'	name='주민번호'				align='center' </C>
								<C> id='LSE_YY'			width='80'	name='근속년수'				align='center' show=false </C>
								<C> id='EDGR_NM'		width='80'	name='학력 구분'			align='center' </C>
								<C> id='SCH_NM'			width='80'	name='학교'					align='center' </C>
								<C> id='MAJ_NM'			width='80'	name='전공'					align='center' </C>
								<C> id='GRD_NM'			width='80'	name='졸업 구분'			align='center' </C>
								<C> id='GUR_YMD'		width='90'	name='졸업 일자'			align='center' </C>
								<C> id='RADR_CT'		width='220'	name='주소1'				align='left' </C>
								<C> id='RADR'			width='220'	name='주소2'				align='left' </C>
								<C> id='PHN_NO'			width='100'	name='전화번호'				align='center' </C>
								<C> id='EM_PHN_NO'		width='100'	name='휴대폰'				align='center' </C>
								<C> id='DUTY_NM'		width='80'	name='직책'					align='center' show=false</C>
								<C> id='REL_NM'			width='80'	name='종교 구분'			align='center' </C>
								<C> id='RET_YMD'		width='80'	name='퇴사 일자'			align='center' </C>
								<C> id='E_MAIL'			width='120'	name='E-Mail'				align='center' </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 테이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>