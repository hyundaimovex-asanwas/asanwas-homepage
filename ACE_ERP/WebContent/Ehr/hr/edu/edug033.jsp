<!--
    ************************************************************************************
    * @Source         : edug033.jsp                                                           *
    * @Description    : 팀장이 보는 일지 PAGE                                             *
    * @Developer Desc :                                                                        *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                               *
    *-------------+-----------+--------------------------------------------------------+
    * 2017/04/28      이동훈        최초작성
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="Ehr.common.*" %>

<html>

<head>
<title>OJT 일지</title>
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

    <!-- 첨부 파일을 위해 -->
    <jsp:include page="../../common/fileupload.jsp" flush="true" />
    <!-- 첨부 파일을 위해 -->

    <script language="javascript" >


        var opener = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var REQ_NO    = opener.req_no;
            var ENO_NO = REQ_NO.substr(0,7);
            var TRA_YMD = "2017"+REQ_NO.substr(7,4);

            
            dsT_CD_OJT.ClearData();

            dsT_CD_OJT.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.g.edug030.cmd.EDUG030CMD&S_MODE=SHR_34&ENO_NO="+ENO_NO+"&TRA_YMD="+TRA_YMD;
            dsT_CD_OJT.Reset();

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
        function fnc_Delete(gubun) {

            //이곳에 해당 코딩을 입력 하세요

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew(gubun) {

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************************
         * 11. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 12. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {


        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            // 후견인상담일지 데이터 조회
            fnc_SearchList();

        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {



            window.close();

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /*******************
         * 16. 승인처리   *
         *******************/
        function fnc_Yes() {

            var REQ_NO    = opener.req_no;
            var ENO_NO = REQ_NO.substr(0,7);
            var TRA_YMD = "2017"+REQ_NO.substr(7,4);        	
        	
            dsT_CD_OJTREPORT.UseChangeInfo = "false";              
            
            trT_CD_OJTREPORT.KeyValue = "tr01(I:SAV=dsT_CD_OJTREPORT)";        
            trT_CD_OJTREPORT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.g.edug030.cmd.EDUG030CMD&S_MODE=SAV_33&ENO_NO="+ENO_NO+"&TRA_YMD="+TRA_YMD+"&REQ_NO="+opener.req_no;
            trT_CD_OJTREPORT.post();

            window.close();

        }
        
        
        //입력 상태창
        var elementList = new Array(     "txtPLACE_TXT"
                                        ,"txtTRA_YMD"
                                        ,"btnImgYmd"
                                        ,"txtSBJ_TXT"
                                        ,"txtEDU_TXT"
                                        ,"txtPPS_TXT"
                                        ,"txtIDEA_TXT" );




        function fnc_UsrGetEnoNm(gbn) {

            var obj = new String();

            if (gbn == 'DAYTRA_ENO_NO') {

                obj = fnc_GetEnoNm("txtDAYTRA_ENO_NO");

                document.getElementById("txtDAYTRA_ENO_NO").value = obj.eno_no;
                document.getElementById("txtDAYTRA_ENO_NM").value = obj.eno_nm;
            }
        }

        function fnc_UsrGetEnoNo(gbn) {
        	if (gbn == 'DAYTRA_ENO_NO') {
        		fnc_GetEnoNo('txtDAYTRA_ENO_NM', 'txtDAYTRA_ENO_NO');
        	}

        	fnc_UsrGetEnoNm(gbn);

        }

        function fnc_Popup(gbn) {
            var obj = new String();

            if (gbn == 'DAYTRA_ENO_NO') {
                // 정규직 재직자만
                obj = fnc_emplPopup('txtDAYTRA_ENO_NO','txtDAYTRA_ENO_NM');

                if (obj.eno_no == "") {
                    return;
                }

                document.getElementById("txtDAYTRA_ENO_NO").value = obj.eno_no;
                document.getElementById("txtDAYTRA_ENO_NM").value = obj.eno_nm;
            }

        }

        function verifyOjtDate(p_value){

        	var obj = document.getElementById(p_value);
        	if( removeChar(opener.dsT_CD_OJTPLAN.NameValue(opener.dsT_CD_OJTPLAN.RowPosition, "PLAN_STR_YMD"),'-') > removeChar(obj.value,'-')
        		|| removeChar(obj.value,'-') > removeChar(opener.dsT_CD_OJTPLAN.NameValue(opener.dsT_CD_OJTPLAN.RowPosition, "PLAN_END_YMD"),'-') )
        	{
        		alert("교육날자를 확인하십시오.");
        		document.getElementById(obj.id).value="";
        		document.getElementById(obj.id).focus();
        		return false;
        	}

        	return true;

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
    | 2. 이름은 ds_ + 주요 테이블명(T_CD_MENTORESULT) |
    | 3. 사용되는 Table List(T_CD_MENTORESULT)        |
    +----------------------------------------------->
    <Object ID="dsT_CD_OJTREPORT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- Reload용 데이터셋 -->
    <Object ID="dsT_CD_OJTREPORT2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CD_MENTO)     |
    | 3. 사용되는 Table List(T_CD_MENTO)            |
    +----------------------------------------------->
    <Object ID="dsT_CD_OJT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CD_MENTO                    |
    | 3. Table List : T_CD_MENTO                |
    +----------------------------------------------->
    <Object ID ="trT_CD_OJTREPORT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CD_OJTREPORT)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CD_OJTREPORT Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CD_OJTREPORT.CountRow );
            dsT_CD_OJTREPORT.RowPosition = 1;

        }


    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CD_OJTREPORT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_OJTREPORT Event="OnDataError()">

        cfErrorMsg(this);

    </Script>


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CD_OJT Event="OnLoadCompleted(iCount)">


	            var REQ_NO    = opener.req_no;
	            var ENO_NO = REQ_NO.substr(0,7);
	            var TRA_YMD = "2017"+REQ_NO.substr(7,4);

                dsT_CD_OJTREPORT.ClearData();

                dsT_CD_OJTREPORT.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.g.edug030.cmd.EDUG030CMD&S_MODE=SHR_35&ENO_NO="+ENO_NO+"&TRA_YMD="+TRA_YMD;
                dsT_CD_OJTREPORT.Reset();


    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CD_OJT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_OJT Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <script for=dsT_CD_OJTREPORT2 event="OnLoadCompleted(iCount)">
        if (iCount == 0){
            alert("조회된 데이터가 없습니다.");
            return;
        }

    </script>



    <!-- 트랜젝션 성공. -->
    <script for=trT_CD_OJTREPORT event="OnSuccess()">

    	alert("정상적으로 승인되었습니다.");
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CD_OJTREPORT event="OnFail()">

        cfErrorMsg(this);

    </script>




<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">


<!-- 버튼 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ConsentOver.gif',1)">   <img src="../../images/button/btn_ConsentOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Yes()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                	<col width="150"></col>
                    <col width="150"></col>
                    <col width="150"></col>
                    <col width="150"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                	<td align="center" class="blueBold">신입사원</td>

                    <td class="padding2423">
                        <input id="txtENO_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                	<td align="center" class="blueBold">책임지도사원</td>

                    <td class="padding2423">
                        <input id="txtTRA_ENO_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtTRA_ENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->



<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="300"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">교육장소</td>
                    <td class="padding2423" >
                        <input id="txtTRA_PLACE"  name="txtTRA_PLACE" style="width:100%" maxlength="50" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">교육일자</td>
                    <td class="padding2423" >
                        <input name="txtTRA_YMD" id="txtTRA_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">지도항목</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtTRA_SUBJECT" name="txtTRA_SUBJECT" style="width:100%" maxlength="4000" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">지도사원</td>
                    <td class="padding2423" colspan="3">
                    	<input id="txtDAYTRA_ENO_NO" size="8" maxlength="8" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtDAYTRA_ENO_NM" size="12" maxlength="12" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육내용</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtTRA_CONTENT"  name="txtTRA_CONTENT" cols="112" rows="20" maxlength="4000" class="input_ReadOnly" readonly></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육생건의</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtTRA_REMARK"  name="txtTRA_REMARK" cols="112" rows="5" maxlength="2000" class="input_ReadOnly" readonly></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">지도사원의견</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtTRA_MENTO"  name="txtTRA_REMARK" cols="112" rows="5" maxlength="2000" class="input_ReadOnly" readonly></textarea>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

</form>
<!-- form 끝 -->




</body>
</html>


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 멘토(Mentor)등록 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CD_OJT">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO        Param=value </C>
        <C> Col=ENO_NM        Ctrl=txtENO_NM        Param=value </C>
        <C> Col=DPT_CD        Ctrl=txtDPT_CD        Param=value </C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM        Param=value </C>
        <C> Col=JOB_CD        Ctrl=txtJOB_CD        Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM        Param=value </C>
        <C> Col=TRA_ENO_NO       Ctrl=txtTRA_ENO_NO       Param=value </C>
        <C> Col=TRA_ENO_NM       Ctrl=txtTRA_ENO_NM       Param=value </C>
        <C> Col=MDPT_CD       Ctrl=txtMDPT_CD       Param=value </C>
        <C> Col=MDPT_NM       Ctrl=txtMDPT_NM       Param=value </C>
        <C> Col=MJOB_CD       Ctrl=txtMJOB_CD       Param=value </C>
        <C> Col=MJOB_NM       Ctrl=txtMJOB_NM       Param=value </C>
        <C> Col=STR_YMD       Ctrl=txtSTR_YMD       Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD       Param=value </C>
        <C> Col=TRA_DPT_CD        Ctrl=txtTRA_DPT_CD        Param=value </C>
        <C> Col=TRA_DPT_NM        Ctrl=txtTRA_DPT_NM        Param=value </C>
        <C> Col=HIR_YMD       		Ctrl=txtHIR_YMD       Param=value </C>
        <C> Col=TRA_DUTY        	Ctrl=txtTRA_DUTY        Param=value </C>
        <C> Col=HEAD_EMP_NO        Ctrl=txtHEAD_EMP_NO        Param=value </C>
        <C> Col=HEAD_EMP_NM        Ctrl=txtHEAD_EMP_NM        Param=value </C>
    '>
</object>

<!-- 멘토(Mentor)상담일지 테이블 -->
<object id="bndT_CD_MENTORESULT"" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",      Value="dsT_CD_OJTREPORT">
    <Param Name="BindInfo",    Value='
        <C>Col=TRA_YMD        		Ctrl=txtTRA_YMD       		Param=value </C>
        <C>Col=TRA_PLACE       	Ctrl=txtTRA_PLACE      		Param=value </C>
        <C>Col=TRA_SUBJECT         Ctrl=txtTRA_SUBJECT        	Param=value </C>
        <C>Col=TRA_ENO_NO    		Ctrl=txtDAYTRA_ENO_NO     Param=value </C>
        <C>Col=TRA_ENO_NM    	Ctrl=txtDAYTRA_ENO_NM     Param=value </C>
        <C>Col=TRA_CONTENT       Ctrl=txtTRA_CONTENT         Param=value </C>
        <C>Col=TRA_REMARK        Ctrl=txtTRA_REMARK       	 Param=value </C>
        <C>Col=TRA_MENTO         Ctrl=txtTRA_MENTO       		 Param=value </C>        
    '>
</object>


