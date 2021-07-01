<!--
*****************************************************
* @source       : buta070.jsp
* @description : 여비지급기준 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2016/06/01      이동훈        ERP 이사
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>여비지급기준</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			dsT_DI_BUSINESSTRIP_BASIS.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta070.cmd.BUTA070CMD&S_MODE=SHR&BASIC_YMD";
			dsT_DI_BUSINESSTRIP_BASIS.reset();

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

			if(!fnc_SaveItemCheck()) return;

			trT_DI_BUSINESSTRIP_BASIS.KeyValue = "tr01(I:dsT_DI_BUSINESSTRIP_BASIS=dsT_DI_BUSINESSTRIP_BASIS)";
			trT_DI_BUSINESSTRIP_BASIS.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta070.cmd.BUTA070CMD&S_MODE=SAV";
			trT_DI_BUSINESSTRIP_BASIS.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_DI_BUSINESSTRIP_BASIS.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + dsT_DI_BUSINESSTRIP_BASIS.ColumnString(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,2) + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_DI_BUSINESSTRIP_BASIS.DeleteRow(dsT_DI_BUSINESSTRIP_BASIS.RowPosition);

			trT_DI_BUSINESSTRIP_BASIS.KeyValue = "SVL(I:dsT_DI_BUSINESSTRIP_BASIS=dsT_DI_BUSINESSTRIP_BASIS)";
			trT_DI_BUSINESSTRIP_BASIS.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta070.cmd.BUTA070CMD&S_MODE=DEL";
			trT_DI_BUSINESSTRIP_BASIS.post();

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

			// 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_DI_BUSINESSTRIP_BASIS.CountColumn == 0) {
                dsT_DI_BUSINESSTRIP_BASIS.setDataHeader("GBN_CD:STRING:KEYVALUETYPE,GBN_NAME:STRING,EXP_AMT1:DECIMAL,EXP_AMT2:DECIMAL,EXP_AMT3:DECIMAL,EXP_AMT4:DECIMAL,EXP_AMT5:DECIMAL,EXP_AMT6:DECIMAL");
            }

			enableInput();// 입력필드 활성화
            dsT_DI_BUSINESSTRIP_BASIS.AddRow();
            document.form1.txtGBN_CD.focus();

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

	        fnc_OnLoadProcess();
			dsT_DI_BUSINESSTRIP_BASIS.ClearData();
			document.getElementById("resultMessage").innerText = ' ';

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_DI_BUSINESSTRIP_BASIS.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

            window.close();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck(year) {

			//이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_DI_BUSINESSTRIP_BASIS.IsUpdated) {
				
                alert("저장할 자료가 없습니다.");
                
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                
                return false;
                
			}
			
			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid_New(form1.grdT_DI_BUSINESSTRIP_BASIS,15,"false","false")      // Grid Style 적용

			disableInput();//입력필드 비활성화

        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/********************************************
         * 입력필드 사용 가능하게(Enable)          		 *
         ********************************************/
  		function enableInput(){

			document.form1.txtGBN_NAME.readOnly = false;
  			document.form1.txtGBN_NAME.className = "";

  			form1.medEXP_AMT1.Enable = "true";
  			form1.medEXP_AMT2.Enable = "true";
  			form1.medEXP_AMT3.Enable = "true";
  			form1.medEXP_AMT4.Enable = "true";
  			form1.medEXP_AMT5.Enable = "true";
  			form1.medEXP_AMT6.Enable = "true";

  		}

        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput(){

			document.form1.txtGBN_NAME.readOnly = true;
  			document.form1.txtGBN_NAME.className = "input_ReadOnly";

  			form1.medEXP_AMT1.Enable = "false";
  			form1.medEXP_AMT2.Enable = "false";
  			form1.medEXP_AMT3.Enable = "false";
  			form1.medEXP_AMT4.Enable = "false";
  			form1.medEXP_AMT5.Enable = "false";
  			form1.medEXP_AMT6.Enable = "false";
  		}

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_DI_BUSINESSTRIP_BASIS                      |
    | 3. Table List : T_DI_BUSINESSTRIP_BASIS                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_BUSINESSTRIP_BASIS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_BUSINESSTRIP_BASIS)		|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_BASIS)	            |
    +--------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP_BASIS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_BUSINESSTRIP_BASIS Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
            alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
	        enableInput();//입력필드 활성화
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP_BASIS Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP_BASIS Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[기준일/근속년수] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("기준일/근속년수에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_BUSINESSTRIP_BASIS event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP_BASIS event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--------------------------+
    | row위치 변경시            |
    +--------------------------->
	<script language=JavaScript for=dsT_DI_BUSINESSTRIP_BASIS event=OnRowPosChanged(row)>
		var SysStatus = dsT_DI_BUSINESSTRIP_BASIS.SysStatus(row);

		if(SysStatus == "1"){
			document.form1.txtGBN_CD.readOnly = false;
  			document.form1.txtGBN_CD.className = "";
		}else{
			document.form1.txtGBN_CD.readOnly = true;
  			document.form1.txtGBN_CD.className = "input_ReadOnly";
		}

	</script>



<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">


<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)"><img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="100"></col>
					<col width="130"></col>
					<col width="100"></col>
					<col width="130"></col>
					<col width="100"></col>
					<col width="130"></col>
					<col width="100"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="blueBold">코&nbsp;&nbsp;&nbsp;드</td>
					<td class="padding2423">
						<input id="txtGBN_CD" style="width:100%" maxLength="2">
					</td>
					<td align="center" class="blueBold">코&nbsp;드&nbsp;명</td>
					<td class="padding2423">
						<input id="txtGBN_NAME" style="width:100%" maxLength="12">
					</td>
					<td align="center" class="blueBold">임원급금액</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medEXP_AMT1" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="blueBold">부장급금액</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medEXP_AMT2" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
				<tr>
					<td align="center" class="blueBold">차장급금액</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medEXP_AMT3" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="blueBold">과장급금액</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medEXP_AMT4" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="blueBold">대리급금액</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medEXP_AMT5" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="blueBold">사원급금액</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medEXP_AMT6" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_BUSINESSTRIP_BASIS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"				value="dsT_DI_BUSINESSTRIP_BASIS">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'			width=50			name='순번'						align=center			value={String(Currow)}					</C>
								<C> id='GBN_CD'				width=90			name='코드'						align=center													</C>
								<C> id='GBN_NAME'			width=150			name='코드명'					align=center													</C>
								<C> id='EXP_AMT1'			width=110			name='임원급금액'				align=right														</C>
								<C> id='EXP_AMT2'			width=110			name='부장급금액'				align=right														</C>
								<C> id='EXP_AMT3'			width=110			name='차장급금액'				align=right														</C>
								<C> id='EXP_AMT4'			width=110			name='과장급금액'				align=right														</C>
								<C> id='EXP_AMT5'			width=110			name='대리급금액'				align=right														</C>
								<C> id='EXP_AMT6'			width=110			name='사원급금액'				align=right														</C>
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

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- -->
<object id="bndT_DI_BUSINESSTRIP_BASIS" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_DI_BUSINESSTRIP_BASIS">
	<Param Name="BindInfo", Value='
		<C>Col=GBN_CD		   		Ctrl=txtGBN_CD      				Param=value 		</C>
		<C>Col=GBN_NAME			Ctrl=txtGBN_NAME	  	  		Param=value			</C>
		<C>Col=EXP_AMT1   	 		Ctrl=medEXP_AMT1		 		Param=text			</C>
		<C>Col=EXP_AMT2			Ctrl=medEXP_AMT2		 		Param=text			</C>
		<C>Col=EXP_AMT3			Ctrl=medEXP_AMT3				Param=text			</C>
		<C>Col=EXP_AMT4			Ctrl=medEXP_AMT4				Param=text			</C>
		<C>Col=EXP_AMT5			Ctrl=medEXP_AMT5				Param=text			</C>
		<C>Col=EXP_AMT6			Ctrl=medEXP_AMT6				Param=text			</C>
    '>
</object>