<!--
*****************************************************
* @source       : gunf010.jsp
* @description : 개인별 근무 현황 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2019/12/11      이동훈        최초 작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>개인별 근무 현황</title>
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

			//검색조건
        	var PIS_YM = document.getElementById("txtPIS_YM_SHR").value;  	
			
			var eno_no = document.form1.txtENO_NO_SHR.value;	//사번

			dsT_DI_OVERTIMEWORK.ClearData();
			
			//사번이 없으면 조회못함.
			if(eno_no == ""){
				
				alert("사번을 입력하세요.");
				
	            document.form1.txtENO_NO_SHR.focus();

				return;
        	}
			
			
			dsT_DI_OVERTIMEWORK.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf010.cmd.GUNF010CMD&S_MODE=SHR&ENO_NO="+eno_no+"&PIS_YM="+PIS_YM.replace("-","");
			//prompt(this,dsT_DI_OVERTIMEWORK.dataid );
			dsT_DI_OVERTIMEWORK.reset();

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



        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

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
            if (dsT_DI_OVERTIMEWORK.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_DI_OVERTIMEWORK.GridToExcel("개인별 근무 현황", '', 225);

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



        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {


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


        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

        	
			document.getElementById("txtENO_NO_SHR").value=gusrid;
			document.getElementById("txtENO_NM_SHR").value=gusrnm;        	
        	
			cfStyleGrid_New(form1.grdT_DI_OVERTIMEWORK,15,"false","false");      // Grid Style 적용

            document.getElementById("txtPIS_YM_SHR").value = gcurdate.substring(0,7);			
			
			if(gusrid == "6060002" || gusrid == "6070001" || gusrid == "6180001" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "2070019"){ 
				
			    fnc_ChangeStateElement(true, "ImgEnoNoSHR");
		    	fnc_ChangeStateElement(true, "txtENO_NO_SHR");
		    	fnc_ChangeStateElement(true, "txtENO_NM_SHR");

	    	}else{

	            fnc_ChangeStateElement(false, "ImgEnoNoSHR");
	            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	            fnc_ChangeStateElement(false, "txtENO_NM_SHR");

			}			
			
			
			fnc_SearchList();
			
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		
	    function fnc_GetNm() {
               fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');
               //fnc_SearchList();
        }

        function fnc_Getcd() {
               fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
               //fnc_SearchList();
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
    | 2. 이름 : dsT_DI_OVERTIMEWORK                 |
    | 3. Table List : T_DI_OVERTIMEWORK             |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERTIMEWORK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
		<PARAM NAME="SubsumExpr"	  VALUE="total,1:WEEK_NO">        
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>




    <Object ID="dsT_DI_WEEKNO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_OVERTIMEWORK)|
    | 3. 사용되는 Table List(T_DI_OVERTIMEWORK)	        |
    +--------------------------------------------------->
    <Object ID ="trT_DI_OVERTIMEWORK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <param name=TimeOut     value=2000000>
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_OVERTIMEWORK Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.form1.txtPIS_YY_SHR.focus();

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
			document.form1.grdT_DI_OVERTIMEWORK.focus();
        }

    </Script>


    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_OVERTIMEWORK Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


    <!------------------------------+
    | 그리드의 ROW를 더블클릭 할때  |
    +------------------------------->
	<script language=JavaScript for=grdT_DI_OVERTIMEWORK event="OnDblClick(row,colid)">


	</script>


    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_OVERTIMEWORK Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_OVERTIMEWORK event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_OVERTIMEWORK event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


<!-- 캘린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
   	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">



<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="50"></col>
                                <col width="250"></col>
                                <col width="150"></col>                                
                                <col width="*"></col>
                            </colgroup>
                            <tr>

			                    <td align="center" class="blueBold">해당월</td>
								<td class="padding2423" align="left">
									<input type="text" id="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								</td>  

                                <td align="right" class="searchState">사번&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8" onkeypress="if(event.keyCode==13){fnc_GetNm();fnc_SearchList();}" onchange="fnc_GetNm();">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9" onkeypress="if(event.keyCode==13){fnc_Getcd();fnc_SearchList();}" onchange="fnc_Getcd();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)">
                                    <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','3', '1', document.getElementById('txtPIS_YM_SHR').value, document.getElementById('txtPIS_YM_SHR').value);"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="bottom" class="searchState" width="66%" height="20"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_OVERTIMEWORK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:450px;">
							<param name="DataID"				value="dsT_DI_OVERTIMEWORK">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="							
								<C> id='WEEK_NO'		width=50			name='주차'					align=center			suppress=1 Value={Decode(CurLevel,1,'소계',WEEK_NO)}</C> 								
								<C> id='DPT_NM'			width=120			name='소속'					align=center			show=false BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
								<C> id='ENO_NM'			width=80			name='성명'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
								<C> id='HOL_YN'			width=50			name='휴일'					align=center			show=false</C>
								<C> id='REG_YMD'		width=100			name='일자'					align=center			MASK='XXXX-XX-XX' BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C> 
								<C> id='YOIL'			width=50			name='요일'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C> 
								<C> id='GUBUN'			width=80			name='구분'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
								<C> id='STR_TIME'		width=100			name='근무시작'				align=center			</C>
								<C> id='END_TIME'		width=100			name='근무종료'				align=center			</C>		
								<C> id='WRK_TIME'		width=100			name='근무시간'				align=center			DEC=1</C>			
								<C> id='WEEK_TOT_TIME'	width=100			name='연장\\근로시간'			align=center			show=false BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
								<C> id='REMARK'			width=300			name='사유'					align=left			</C>
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


<!-- 조회 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop15">
        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>근무 시간 정보</strong></td>
    </tr>
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100 "></col>
                    <col width="200"></col>
                    <col width="100 "></col>
                    <col width="200"></col>
                    <col width="100 "></col>
                    <col width="200"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" >해당 주 일자</td>
                    <td class="padding2423" align="left">
                        <input id="txtSTR_YMD" name="txtSTR_YMD" style="ime-mode:disabled" size="12" maxlength="10" class="input_ReadOnly" readonly > ~
                        <input id="txtEND_YMD" name="txtEND_YMD" style="ime-mode:disabled" size="12" maxlength="10" class="input_ReadOnly" readonly >
                    </td>
                    <td align="center" class="blueBold">월 누적 시간</td>
                    <td class="padding2423" >
                        <input id="txtWEEK_TOTAL_TIME" name="txtWEEK_TOTAL_TIME" maxlength="60" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">신청가능 시간</td>
                    <td class="padding2423" >
                        <input id="txtPOSIBLE_TIME" name="txtPOSIBLE_TIME" maxlength="60" style="width:100%" class="input_ReadOnly" readonly>
                    </td>                    
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->


</form>
<!-- form 끝 -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

