<!--
    ************************************************************************************
    * @Source              : codb010.jsp                                                                                             *
    * @Description        : 급여계정/부서 맵핑                                                                                            *
    * @Font                   :                                                                                                                 *
    * @Developer Desc :                                                                                                                 *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/06  |  한학현   | 최초작성                                                                                           *
    * 2006/09/21  |  한학현   | 개발완료                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>급여계정/부서 맵핑</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >

		var btnList = 'TTTTFFTT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
			//if (!valid(form1)) return;//Validation 수행
			  dsT_CM_COMMON.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saco020.cmd.SACO020CMD&S_MODE=SHR";
	          dsT_CM_COMMON.Reset();

	          dsT_CM_COMMON2.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saco020.cmd.SACO020CMD&S_MODE=SHR_02";
	          dsT_CM_COMMON2.Reset();
        }

		/***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {
			var f = document.form1;
			if(fnc_SaveItemCheck()) {
				tr01T_CM_COMMON.KeyValue = "SVL(I:ds01T_CM_COMMON=ds01T_CM_COMMON)";
				tr01T_CM_COMMON.action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saco020.cmd.SACO020CMD&S_MODE=SAV";
				tr01T_CM_COMMON.post();

	            //dsT_CM_COMMON.Reset();

	            dsT_CM_COMMON2.Reset();
	            ds01T_CM_COMMON.Reset();
			} else {
				return;
			}
        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {
            // 삭제 할 자료가 있는지 체크하고
            if (ds01T_CM_COMMON.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");//메세지가 제거인데 삭제로 출력햇음
                return;
            }
            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + ds01T_CM_COMMON.ColumnString(ds01T_CM_COMMON.RowPosition,2) +  " : "  + ds01T_CM_COMMON.ColumnString(ds01T_CM_COMMON.RowPosition,4) + "] 자료를 제거하시겠습니까?") == false) return;
            ds01T_CM_COMMON.DeleteRow(ds01T_CM_COMMON.RowPosition);
			tr01T_CM_COMMON.KeyValue = "SVL(I:ds01T_CM_COMMON=ds01T_CM_COMMON)";
			tr01T_CM_COMMON.action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saco020.cmd.SACO020CMD&S_MODE=DEL";
			tr01T_CM_COMMON.post();

			dsT_CM_COMMON2.Reset();
        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {
            // 해당 Dataset의 Header가 없으면 Header 선언
            if (ds01T_CM_COMMON.CountColumn == 0) {
                ds01T_CM_COMMON.setDataHeader("CD_GBN:STRING, COMM_CD:STRING, COMM_NM:STRING, COMM_NM2:STRING, STR_YMD:STRING, END_YMD:STRING, SORT_NO:DECIMAL, GBN2_TAG:STRING, EXT_01:STRING, EXT_02:STRING, EXT_03:STRING, EXT_04:STRING, REMARK:STRING, REMARK2:STRING, REMARK3:STRING, OTH_DEC:STRING");
            }

            // AddNew 후 입력 테이블로 포커스
            ds01T_CM_COMMON.AddRow();

            enableInput();// 입력필드 활성화

            var oCD_GBN = dsT_CM_COMMON.NameValue(dsT_CM_COMMON.RowPosition,"COMM_CD");
            if(oCD_GBN == undefined){
	            oCD_GBN = "**";
            }
            ds01T_CM_COMMON.NameValue(dsT_CM_COMMON.RowPosition, "STR_YMD") = getToday();

            document.getElementById("txtCD_GBN").value = oCD_GBN;
			document.getElementById("txtCOMM_CD").focus();
        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {
			dsT_CM_COMMON.ClearData();
			ds01T_CM_COMMON.ClearData();
			fnc_OnLoadProcess();
			document.getElementById("resultMessage").innerText = ' ';
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {
	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_CM_COMMON.IsUpdated)  {
	            if (!fnc_ExitQuestion()) return;
	        }

	        frame = window.external.GetFrame(window);
	        frame.CloseFrame();
        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {
   			var f = document.form1;

			//DataSet의 변경 여부 확인
			if (!ds01T_CM_COMMON.IsUpdated ) {
				alert("수정된 값이 없습니다.");
		    	return false;
			}

			var i = 0;
			var oACC_CD, oACC_NM, oDPT_CD, oDPT_NM;
			var RowCnt = ds01T_CM_COMMON.CountRow;
			for(i=1; i<=RowCnt; i++){

				oACC_CD = ds01T_CM_COMMON.NameValue(i,"ACC_CD");
				if(oACC_CD.trim() == ""){
					alert(i+"번째의 계정코드가 잘못되었습니다." );
					ds01T_CM_COMMON.RowPosition = i;
					return false;
				}

				oDPT_CD = ds01T_CM_COMMON.NameValue(i,"DPT_CD");
				if(oDPT_CD.trim() == ""){
					alert(i+"번째의 부서코드가 잘못되었습니다." );
					ds01T_CM_COMMON.RowPosition = i;
					return false;
				}

				/*
				oSORT_NO = ds01T_CM_COMMON.NameValue(i,"SORT_NO");
				if(oSORT_NO.toString().trim().length == 0 || oSORT_NO == 0){
					alert(i+"번째의 정렬순서가  잘못되었습니다." );
					ds01T_CM_COMMON.RowPosition = i;
					document.medSORT_NO.Focus();
					return false;
				}
				*/
			}

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //Grid Style 적용
			cfStyleGrid(form1.grdT_CM_COMMON,15,"false","right");
			cfStyleGrid(form1.grdT_CM_COMMON2,15,"false","right");

			cfStyleGrid(form1.grd01T_CM_COMMON,15,"false","right");

			fnc_SearchList();

			ds01T_CM_COMMON.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saco020.cmd.SACO020CMD&S_MODE=SHR_01&COMM_CD=01";
			ds01T_CM_COMMON.Reset();
        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/********************************************
         * 입력필드 사용 가능하게(Enable)          		 *
         ********************************************/
  		function enableInput(){

  		}

        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput(){

  		}

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                                                      |
    | 2. 이름 : dsT_CM_COMMON                                      |
    | 3. Table List : T_CM_COMMON                                 |
    +----------------------------------------------->
    <Object ID="dsT_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_COMMON2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : ds01T_CM_COMMON                                  |
    | 3. Table List : T_CM_COMMON                                 |
    +----------------------------------------------->
    <Object ID="ds01T_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : tr01T_CM_COMMON                                    |
    | 3. Table List : T_CM_COMMON                                 |
    +----------------------------------------------->
    <Object ID ="tr01T_CM_COMMON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CM_COMMON Event="OnLoadCompleted(iCount)">

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_CM_COMMON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=ds01T_CM_COMMON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_CM_COMMON Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=ds01T_CM_COMMON Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=tr01T_CM_COMMON event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=tr01T_CM_COMMON event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--------------------------+
    | grid에서 row를 클릭했을때      |
    +------ -------------------->
	<script for=grdT_CM_COMMON event=OnClick(Row,Colid)>
		//alert("Occur OnClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" );
		var overId = "COMM_CD";
		var overValue = dsT_CM_COMMON.NameValue(Row,overId);
		try {
			ds01T_CM_COMMON.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saco020.cmd.SACO020CMD&S_MODE=SHR_01&"+overId+"="+overValue;
			ds01T_CM_COMMON.Reset();
		} catch ( exception ) {
			fcWindowsXpSp2Notice(false);
			return;
		}
	</script>

	<script for=grdT_CM_COMMON2 event=OnClick(Row,Colid)>
		//alert("Occur OnClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" );
		var overId = "NO_DPT_CD";
		var overId2 = "NO_DPT_NM";
		var overId3 = "ACC_CD";
		var overId4 = "ACC_NM";
		var overValue = dsT_CM_COMMON2.NameValue(Row,overId);
		var overValue2 = dsT_CM_COMMON2.NameValue(Row,overId2);
		var overValue3 = document.getElementById("txtACC_CD").value;
		var overValue4 = document.getElementById("txtACC_NM").value;

		try {
			// AddNew 후 입력 테이블로 포커스
            ds01T_CM_COMMON.AddRow();

            ds01T_CM_COMMON.NameValue(ds01T_CM_COMMON.RowPosition,"DPT_CD")=overValue;
            ds01T_CM_COMMON.NameValue(ds01T_CM_COMMON.RowPosition,"DPT_NM")=overValue2;
            ds01T_CM_COMMON.NameValue(ds01T_CM_COMMON.RowPosition,"ACC_CD")=overValue3;
            ds01T_CM_COMMON.NameValue(ds01T_CM_COMMON.RowPosition,"ACC_NM")=overValue4;

		} catch ( exception ) {
			fcWindowsXpSp2Notice(false);
			return;
		}
	</script>


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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">급여계정/부서 맵핑</td>
                    <td align="right" class="navigator">HOME/기초정보/기타정보/<font color="#000000">급여계정/부서 맵핑</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<!-- 왼쪽 화면 시작-->
			<table width="300" border="0" cellspacing="0" cellpadding="0">
				<tr align="center"  valign="top">
					<td  valign="top">
						<!-- 조회 상태 테이블 끝 -->
						<!-- 내용 조회 그리드 테이블 시작-->
						<table width="300" border="0" cellspacing="0" cellpadding="0">
						    <tr>
								<td class="paddingTop8">
						            <table border="0" cellspacing="0" cellpadding="0">
						                <tr align="left">
						                   <td align="left">
						                   		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
													<colgroup>
														<col width="90"></col>
														<col width=""></col>
													</colgroup>
													<tr>
														<td align="center" class="creamBold">계정코드(급여)</td>
													</tr>
												</table>
						                   </td>
						                </tr>
						                <tr align="center">
						                    <td>
						                        <comment id="__NSID__">
						                        <object id="grdT_CM_COMMON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:300px;height:80px;">
						                            <param name="DataID"						value="dsT_CM_COMMON">
						                            <param name="EdiTABLE"				value="false">
						                            <param name="DragDropEnable"		value="true">
						                            <param name="SortView"					value="Left">
						                            <param name="VIEWSUMMARY"		value=0>
						                            <param name="Format"						value="
						                                <C>    id='ACC_CD'     name='계정코드'    width='90'    align=left                </C>
						                                <C>    id='ACC_NM'   name='계정과목'    width='150'    align=left   edit=true             </C>
						                            ">
						                        </object>
						                        </comment><script> __ShowEmbedObject(__NSID__); </script>
						                    </td>
						                </tr>
										<tr align="left">
						                   <td align="left">
						                   		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
													<colgroup>
														<col width="90"></col>
														<col width=""></col>
													</colgroup>
													<tr>
														<td align="center" class="creamBold">맵핑되지 않은 부서</td>
													</tr>
												</table>
						                   </td>
						                </tr>
						                <tr align="center">
						                    <td>
						                        <comment id="__NSID__">
						                        <object id="grdT_CM_COMMON2" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:300px;height:230px;">
						                            <param name="DataID"						value="dsT_CM_COMMON2">
						                            <param name="EdiTABLE"				value="false">
						                            <param name="DragDropEnable"		value="true">
						                            <param name="SortView"					value="Left">
						                            <param name="VIEWSUMMARY"		value=0>
						                            <param name="Format"						value="
						                                <C>    id='NO_DPT_CD'     name='부서코드'    width='90'    align=left                </C>
						                                <C>    id='NO_DPT_NM'   name='부서'    width='150'    align=left   edit=true             </C>
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

					</td>
				</tr>
			</table>
			<!-- 왼쪽 화면 끝-->
		</td>
		<td>
			<!-- 오른쪽 화면 시작-->
			<table width="495" border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<!-- 조건 입력 테이블 시작 -->
						<table width="495" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
										<colgroup>
											<col width="90"></col>
											<col width="145"></col>
											<col width="90"></col>
											<col width=""></col>
										</colgroup>
										<tr>
										 <td valign="bottom" class="searchState" colspan="4"><input id="txtACC_CD" name="txtACC_CD" size="8" type="hidden">
										 <input id="txtACC_NM" name="txtACC_NM" size="8" type="hidden"><span id="resultMessage">&nbsp;</span></td>
										 </tr>
									</table>
								</td>
							</tr>
						</table>
						<!-- 조건 입력 테이블 끝 -->

						<!-- 내용 조회 그리드 테이블 시작-->
						<table width="495" border="0" cellspacing="0" cellpadding="0">
							<tr align="left">
			                   <td align="left">
			                   		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
										<colgroup>
											<col width="90"></col>
											<col width=""></col>
										</colgroup>
										<tr>
											<td align="center" class="creamBold">맵핑된 부서</td>
										</tr>
									</table>
			                   </td>
			                </tr>
						    <tr>
								<td class="paddingTop8">
						            <table border="0" cellspacing="0" cellpadding="0">
						                <tr align="center">
						                    <td>
						                        <comment id="__NSID__">
						                        <object id="grd01T_CM_COMMON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:495px;height:335px;">
						                            <param name="DataID"						value="ds01T_CM_COMMON">
						                            <param name="EdiTABLE"				value="false">
						                            <param name="DragDropEnable"		value="true">
						                            <param name="SortView"					value="Left">
						                            <param name="VIEWSUMMARY"		value=0>
						                            <param name="Format"						value="
						                                <C> id='CURROW'		width=40		name='NO'							align=center		value={String(Currow)}		</C>
						                                <C> id='ACC_CD'	width=70		name='계정코드'			sort=true	align=center 										</C>
						                                <C> id='ACC_NM'	width=125		name='계정과목'		sort=true	align=left				                    		</C>
						                                <C> id='DPT_CD'	width=73		name='부서코드'	sort=true	align=left				 	</C>
						                                <C> id='DPT_NM'	width=100		name='부서'	sort=true	align=center										 	</C>
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

					</td>
				</tr>
			</table>
			<!-- 오른쪽 화면 끝-->
		</td>
	</tr>
</table>

</form>
<!-- form 끝 -->

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(Bind Component)                                                                            *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 저장 및 조회용 Bind                                               |
    | 2. 이름 : bndT_CM_COMMON                                   |
    | 3. Table List : T_CM_COMMON                                 |
    +----------------------------------------------->
	<object id="bndT_CM_COMMON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_CM_COMMON">
		<Param Name="BindInfo", Value="
			<C>Col='ACC_CD'			Ctrl='txtACC_CD'			Param=value</C>
			<C>Col='ACC_NM'			Ctrl='txtACC_NM'			Param=value</C>
	    ">
	</object>
