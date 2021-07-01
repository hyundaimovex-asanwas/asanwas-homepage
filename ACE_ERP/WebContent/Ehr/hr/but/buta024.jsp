<!--
***********************************************************************
* @source      : buta024.jsp
* @description : 자가용 단가 계산 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/09/17      한학현        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html;charset=euc-kr"%>

<html>
<head>
<title>자가용단가계산</title>
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

        //버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
        var btnList = 'FFTTFTFT';

        var dataSet = window.dialogArguments;
        var row  = "<%=request.getParameter("row")%>";
        var flag = "<%=request.getParameter("flag")%>";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //이곳에 해당 코딩을 입력 하세요

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

            //이곳에 해당 코딩을 입력 하세요

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

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

            // 아무것도 없는 상태에서 추가 하게 되면 처음은 AddNew하고 나중 부터 InsertRow합

            // Pow Append 후 Grid에 Append된 Row의 특정 Column으로 이동하는거

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

            // 삭제 할 자료가 있는지 체크하고

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)

            // 삭제 후 해당 그리드로 Focus 이동

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
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

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

	        //버튼 표시 유무
	        if(flag == "N"){
	            document.getElementById("imgSave").style.display = "none";//처리버튼 않보이게
	            fnc_InputDisabled();
	        }else{
	            document.getElementById("imgSave").style.display = "";//처리버튼 않보이게
	            fnc_InputEnable();
	        }

	        cfCopyDataSet(dataSet, dsT_DI_BUSINESSTRIP_ACCOUNT);

	        form1.medCAR_TOLL.Text = dsT_DI_BUSINESSTRIP_ACCOUNT.NameValue(row,"CAR_TOLL");
	        form1.medCAR_OIL.Text = dsT_DI_BUSINESSTRIP_ACCOUNT.NameValue(row,"CAR_OIL");
	        form1.medCAR_DISTANCE.Text = dsT_DI_BUSINESSTRIP_ACCOUNT.NameValue(row,"CAR_DISTANCE");
	        form1.medCAR_EFFICIENCY.Text = dsT_DI_BUSINESSTRIP_ACCOUNT.NameValue(row,"CAR_EFFICIENCY");

	        if(isNaN(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)) || !isFinite(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text))){
	           form1.medPRICE_AMT.Text = 0;
            }else{

               form1.medPRICE_AMT.Text = Number(form1.medCAR_TOLL.Text) + (Number(form1.medCAR_OIL.Text) * (Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)));
            }


        }

        function fnc_Confirm() {

            if(Number(form1.medCAR_DISTANCE.Text) != 0 && (isNaN(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)) || !isFinite(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)))){
                alert("거리를 0으로 나눌수 없습니다.");
                return false;
            }

            dsT_DI_BUSINESSTRIP_ACCOUNT.NameValue(row,"CAR_TOLL") = form1.medCAR_TOLL.Text;
            dsT_DI_BUSINESSTRIP_ACCOUNT.NameValue(row,"CAR_OIL") = form1.medCAR_OIL.Text;
            dsT_DI_BUSINESSTRIP_ACCOUNT.NameValue(row,"CAR_DISTANCE") = form1.medCAR_DISTANCE.Text;
            dsT_DI_BUSINESSTRIP_ACCOUNT.NameValue(row,"CAR_EFFICIENCY") = form1.medCAR_EFFICIENCY.Text;

            cfCopyDataSet(dsT_DI_BUSINESSTRIP_ACCOUNT, dataSet);

            window.close();

        }

        function fnc_InputDisabled() {

            document.form1.medCAR_TOLL.Enable = "false";
            document.form1.medCAR_OIL.Enable = "false";
            document.form1.medCAR_DISTANCE.Enable = "false";
            document.form1.medCAR_EFFICIENCY.Enable = "false";

        }

        function fnc_InputEnable() {

            document.form1.medCAR_TOLL.Enable = "true";
            document.form1.medCAR_OIL.Enable = "true";
            document.form1.medCAR_DISTANCE.Enable = "true";
            document.form1.medCAR_EFFICIENCY.Enable = "true";

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
    | 2. 이름은 ds_ + 주요 테이블명()      |
    | 3. 사용되는 Table List()             |
    +----------------------------------------------->
    <Object ID="dsT_DI_BUSINESSTRIP_ACCOUNT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_BUSINESSTRIP_ACCOUNT Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP_ACCOUNT Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP_ACCOUNT Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <script language=JavaScript for=medCAR_TOLL event=onKillFocus()>

        if(isNaN(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)) || !isFinite(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text))){
            form1.medPRICE_AMT.Text = Number(form1.medCAR_TOLL.Text) + 0;
        }else{
            form1.medPRICE_AMT.Text = Number(form1.medCAR_TOLL.Text) + (Number(form1.medCAR_OIL.Text) * (Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)));
        }

    </script>
    <script language=JavaScript for=medCAR_OIL event=onKillFocus()>

        if(isNaN(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)) || !isFinite(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text))){
            form1.medPRICE_AMT.Text = Number(form1.medCAR_TOLL.Text) + 0;
        }else{
            form1.medPRICE_AMT.Text = Number(form1.medCAR_TOLL.Text) + (Number(form1.medCAR_OIL.Text) * (Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)));
        }

    </script>
    <script language=JavaScript for=medCAR_DISTANCE event=onKillFocus()>

        if(isNaN(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)) || !isFinite(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text))){
            form1.medPRICE_AMT.Text = Number(form1.medCAR_TOLL.Text) + 0;
        }else{
            form1.medPRICE_AMT.Text = Number(form1.medCAR_TOLL.Text) + (Number(form1.medCAR_OIL.Text) * (Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)));
        }

    </script>
    <script language=JavaScript for=medCAR_EFFICIENCY event=onKillFocus()>

        if(isNaN(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)) || !isFinite(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text))){
            form1.medPRICE_AMT.Text = Number(form1.medCAR_TOLL.Text) + 0;
        }else{
            form1.medPRICE_AMT.Text = Number(form1.medCAR_TOLL.Text) + (Number(form1.medCAR_OIL.Text) * (Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)));
        }

    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onload="fnc_OnLoadProcess();">

    <!-- form 시작 -->
    <form name="form1">

    <!-- 타이틀 바 테이블 시작 -->
    <table width="570" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                        <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">자가용 단가 계산</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 타이틀 바 테이블 끝 -->

    <!-- 버튼 테이블 시작 -->
    <table width="570" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_ConductOver.gif',1)"><img src="../../images/button/btn_ConductOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Confirm()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

    <!-- 조건 입력 테이블 시작 -->
    <table width="570" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                <strong>고속도로 통행료</strong>
            </td>
        </tr>
        <tr>
            <td>
                <table border="0">
	                <colgroup>
	                    <col width="80"></col>
	                    <col width=""></col>
	                </colgroup>
                    <tr>
                        <td class="padding2423" align="left">
                            &nbsp;
	                        <comment id="__NSID__"><object id="medCAR_TOLL" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80">
	                            <param name=Alignment               value=2>
	                            <param name=Border                  value=true>
	                            <param name=ClipMode                value=true>
	                            <param name=DisabledBackColor       value="#EEEEEE">
	                            <param name=Enable                  value=true>
	                            <param name=IsComma                 value=true>
	                            <param name=Language                value=0>
	                            <param name=MaxLength               value=9>
	                            <param name=Numeric                 value=true>
	                            <param name=ShowLiteral             value="false">
	                            <param name=Visible                 value="true">
	                            <param name=SelectAll               value="true">
	                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td align="left">원</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <table width="570" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop15"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                <strong>차량 주유비</strong>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <table border="0">
                        <col width="80"></col>
                        <col width="90"></col>
                        <col width="80"></col>
                        <col width="80"></col>
                        <col width="80"></col>
                        <col width=""></col>
                    </colgroup>
                    <tr>
                        <td class="padding2423" align="left">
                            &nbsp;
                            <comment id="__NSID__"><object id="medCAR_OIL" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=ShowLiteral             value="false">
                                <param name=Visible                 value="true">
                                <param name=SelectAll               value="true">
                            </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td align="left">원(단가)&nbsp;&nbsp;×&nbsp;&nbsp;(</td>
                        <td class="padding2423" align="left">
                            <comment id="__NSID__"><object id="medCAR_DISTANCE" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=ShowLiteral             value="false">
                                <param name=Visible                 value="true">
                                <param name=SelectAll               value="true">
                            </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td align="left"><font style="font-size:15px;">㎞</font>(거리)&nbsp;&nbsp;/</td>
                        <td class="padding2423" align="left">
                            <comment id="__NSID__"><object id="medCAR_EFFICIENCY" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=ShowLiteral             value="false">
                                <param name=Visible                 value="true">
                                <param name=SelectAll               value="true">
                            </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td align="left"><font style="font-size:15px;">㎞</font>/<font style="font-size:15px;">ℓ</font>(연비)&nbsp;)</td>
                    </tr>
                    <tr height="50" valign="bottom">
                        <td class="padding2423" align="right" colspan="5">
                            <font style="font-size:12px;font-weight:bold;">합계&nbsp;:</font>
                        </td>
                        <td class="padding2423" align="left" colspan="1">
                           <comment id="__NSID__"><object id="medPRICE_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=ShowLiteral             value="false">
                                <param name=Visible                 value="true">
                                <param name=SelectAll               value="true">
                            </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

	</form>
	<!-- form 끝 -->

</body>
</html>