<!--
    ************************************************************************************
    * @Source         : vluf030.jsp 					                                                                                 *
    * @Description    : 조사대상설정.                                                                                               *
    * @Font           : 굴림체, 9Font 사용하시고 Tab은 Space 4Byte로 처리 해 주세요!                         *
    * @Developer Desc :                                                                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/29  |  안준성   | 최초작성                                                                                           *
    * 2006/10/12  |  한학현   | 입력단 추가, 검색단 수정                                                                    *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

	<head>
	<title>조사대상설정(vluf030)</title>
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

		var btnList = 'TTTTFFTT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //데이터셋 전송
            //부서조회 미구현
            dsT_EV_DUTYLST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf030.cmd.VLUF030CMD&S_MODE=SHR&cmbDUTY_NO_SHR="+document.getElementById("cmbDUTY_NO_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&txtDPT_CD_SHR="+document.getElementById("txtDPT_CD_SHR").value;
            dsT_EV_DUTYLST.Reset();

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

			if( !fnc_SaveItemCheck() )	return;

			//트랜잭션 전송
			trT_EV_DUTYLST.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf030.cmd.VLUF030CMD&S_MODE=SAV";
			trT_EV_DUTYLST.Post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

			 // 삭제 할 자료가 있는지 체크하고
            if (dsT_EV_DUTYLST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + dsT_EV_DUTYLST.NameValue(dsT_EV_DUTYLST.RowPosition,'DUTY_NO') + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_EV_DUTYLST.DeleteRow(dsT_EV_DUTYLST.RowPosition);
			//트랜잭션 전송
			trT_EV_DUTYLST.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf030.cmd.VLUF030CMD&S_MODE=DEL";
			trT_EV_DUTYLST.Post();

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

			//직무기초가 없으면 등록을 못한다.
        	if(ds01T_EV_DUTYBAS.CountRow == 0){
        		alert("직무기초가 없습니다.");
        	}

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_EV_DUTYLST.CountColumn == 0) {
                dsT_EV_DUTYLST.setDataHeader("DUTY_NO:INT, ENO_NO:STRING:KEYVALUETYPE, ENO_NM:STRING, DPT_CD:STRING, DPT_NM:STRING, JOB_NM:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_EV_DUTYLST.AddRow();

            fnc_ColEnabled('E');

			document.dsT_EV_DUTYLST.NameValue(document.dsT_EV_DUTYLST.RowPosition,"DUTY_NO") = document.ds01T_EV_DUTYBAS.NameValue(1,"DUTY_NO");
            document.getElementById("cmbDUTY_NO").focus();

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

            dsT_EV_DUTYLST.ClearData();

            fnc_ColEnabled('D');

			document.form1.cmbDUTY_NO_SHR.focus();

			document.getElementById("txtENO_NO_SHR").value = '';
			document.getElementById("txtENO_NM_SHR").value = '';
			document.getElementById("txtDPT_CD_SHR").value = '';
			document.getElementById("txtDPT_NM_SHR").value = '';

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_EV_DUTYLST.IsUpdated)  {

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

        	if ( dsT_EV_DUTYLST.isUpdated ) {

			} else {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //Grid Style 적용
            cfStyleGrid(form1.grdT_EV_DUTYLST,15,"false","right");

            fnc_ColEnabled('D');

            //시작시 조사회차를 가져온다.
            ds01T_EV_DUTYBAS.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf020.cmd.VLUF020CMD&S_MODE=SHR_01";
            ds01T_EV_DUTYBAS.Reset();
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************************
         * 사원정보검색                                            *
         *******************************************************/
        function fnc_UsrGetEnoNm(gbn) {

            var obj = new String();

            if (gbn == 'ENO_NO') {

                obj = fnc_GetEnoNm("txtENO_NO");

                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtENO_NM").value = obj.eno_nm;
                document.getElementById("txtDPT_CD").value = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            }
        }

        function fnc_UsrGetEnoNo(gbn) {

          	if (gbn == 'ENO_NO') {
        		fnc_GetEnoNo('txtENO_NM', 'txtENO_NO');
        	}

        	fnc_UsrGetEnoNm(gbn);
        }


        /***************************************
		 * 입력부의 컬럼의 Disabled 속성 바꿈  *
		 ***************************************/
		function fnc_ColEnabled(prop) {
			// 해당 컬럼의 속성을 Enabled로 변경
			if (prop == 'E') {
				form1.cmbDUTY_NO.disabled = false;
				form1.txtENO_NO.disabled  = false;
				form1.txtENO_NM.disabled  = false;
			}
			// 해당 컬럼의 속성을 Disabled로 변경
			else if (prop == 'D') {
				form1.cmbDUTY_NO.disabled = true;
				form1.txtENO_NO.disabled  = true;
				form1.txtENO_NM.disabled  = true;
			}
		}

    </script>

    </head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_GRDRATE)      |
    | 3. 사용되는 Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_DUTYLST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_GRDRATE)      |
    | 3. 사용되는 Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID ="trT_EV_DUTYLST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_DUTYLST)">
    </Object>

    <!----------------------------------------------+
    | 1. 조회용 DataSet                                                      |
    | 2. 이름 : ds01T_EV_DUTYBAS                                    |
    | 3. Table List : T_EV_DUTYBAS                                  |
    +----------------------------------------------->
    <Object ID="ds01T_EV_DUTYBAS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_DUTYLST Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {
            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

            fnc_ColEnabled('E');
        }
  	 	grdT_EV_DUTYLST.SetColumn("ENO_NO");//set focus
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_DUTYLST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=ds01T_EV_DUTYBAS Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
			var i;
			var oOption;

			//입력단과 검색단의 콤보박스에 조사회차를 생성
			for(i=1; i <= iCount; i++){
	        	oOption = document.createElement("OPTION");
				oOption.text = ds01T_EV_DUTYBAS.NameValue(i,"DUTY_NO");
				oOption.value = ds01T_EV_DUTYBAS.NameValue(i,"DUTY_NO");
       			document.getElementById("cmbDUTY_NO_SHR").add(oOption);

	        	oOption = document.createElement("OPTION");
				oOption.text = ds01T_EV_DUTYBAS.NameValue(i,"DUTY_NO");
				oOption.value = ds01T_EV_DUTYBAS.NameValue(i,"DUTY_NO");
       			document.getElementById("cmbDUTY_NO").add(oOption);
        	}
        }
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_DUTYLST Event="OnDataError()">
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("사번에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <Script For=ds01T_EV_DUTYBAS Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_DUTYLST event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");
		fnc_SearchList();
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_DUTYLST event="OnFail()">
        cfErrorMsg(this);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">조사대상설정</td>
					<td align="right" class="navigator">HOME/인사평가/직무관리/직무조사/<font color="#000000">조사대상설정</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
				                <colgroup>
				                	<col width="80"></col>
				                	<col width="50"></col>
				                	<col width="80"></col>
				                	<col width="210"></col>
				                	<col width="80"></col>
				                	<col width="*"></col>
				                </colgroup>
							<tr>
								<td align="right" class="searchState">조사회차</td>
								<td class="padding2423">
									<select id="cmbDUTY_NO_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();">
										<option selected>전체</option>
									</select>
								</td>
                                <td align="right" class="searchState">부서</td>
                                <td class="padding2423"><input name="txtDPT_CD_SHR" size="9"  maxlength="6" onKeypress="javascript:if(event.keyCode==13)fnc_SearchList()">
	                                <input name="txtDPT_NM_SHR" size="16" class="input_ReadOnly" readOnly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn3','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn3" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">사번</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9"  maxlength="10" style="ime-mode:disabled" onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','');">
	                                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength="9" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
	                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
                                </td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<td>&nbsp;</td>
<!-- power Search테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="90"></col>
					<col width="80"></col>
					<col width="230"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">조사회차</td>
					<td class="padding2423">
						<select id="cmbDUTY_NO" style="WIDTH:50px">
						</select>
					</td>
					<td align="center" class="creamBold">부서</td>
					<td class="padding2423">
						<input id="txtDPT_CD" size="9"  class="input_ReadOnly" readOnly>
						<input id="txtDPT_NM" size="16" class="input_ReadOnly" readOnly>
					</td>
					<td align="center" class="creamBold">사번</td>
					<td class="padding2423">
					    <input id="txtENO_NO" size="9"  maxlength="10" style="ime-mode:disabled" onkeypress="if(event.keyCode==13) fnc_UsrGetEnoNm('ENO_NO');" onChange="fnc_UsrGetEnoNm('ENO_NO');">
						<input id="txtENO_NM" size="16" maxlength="12" onkeypress="if(event.keyCode==13) fnc_UsrGetEnoNo('ENO_NO');" onchange="fnc_UsrGetEnoNo('ENO_NO');">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO','txtENO_NM','txtDPT_CD','txtDPT_NM')"></a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 -->

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
						<object	id="grdT_EV_DUTYLST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:250px;">
							<param name="DataID"					value="dsT_EV_DUTYLST">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"					value="
								<C> id='{CUROW}'				width=60		name='순번'									align=center		value={String(Currow)}	</C>
								<C> id='DUTY_NO'				width=80		name='조사회차'		sort=true		align=center												</C>
								<C> id='DPT_NM'					width=160		name='부서'				sort=true		align=center												</C>
								<C> id='JOB_NM'					width=160		name='직위'				sort=true		align=center												</C>
								<C> id='ENO_NO'					width=145		name='사번'				sort=true		align=center												</C>
								<C> id='ENO_NM'					width=160		name='성명'				sort=true		align=center												</C>
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
    | 2. 이름 : bndT_EV_DUTYLST                                   |
    | 3. Table List : T_EV_DUTYLST                                 |
    +----------------------------------------------->
	<object id="bndT_EV_DUTYLST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_EV_DUTYLST">
		<Param Name="BindInfo", Value="
			<C>Col='DUTY_NO'		Ctrl='cmbDUTY_NO'		Param=value</C>
			<C>Col='ENO_NO'			Ctrl='txtENO_NO'			Param=value</C>
			<C>Col='ENO_NM'		Ctrl='txtENO_NM'			Param=value</C>
			<C>Col='DPT_CD'			Ctrl='txtDPT_CD'			Param=value</C>
			<C>Col='DPT_NM'			Ctrl='txtDPT_NM'			Param=value</C>
	    ">
	</object>
