<!--
    ************************************************************************************
    * @Source         : pira031.jsp                                                    *
    * @Description    : 급여변경 PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            이동훈            	ERP 이사											*
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>급여변경</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<%
    String ENO_NO = request.getParameter("ENO_NO");         //사번
%>

    <!--
    ******************************************************
    * 자바스크립트 함수 선언부분
    ******************************************************
    -->
    <script language="javascript" >

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_CAREER.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira031.cmd.PIRA031CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_CAREER.Reset();

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

            if(fnc_SaveItemCheck()) {

                trT_CM_CAREER.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira031.cmd.PIRA031CMD&S_MODE=SAV";
                trT_CM_CAREER.post();

            } else {

                return;

            }

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            var status = 0;

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_CM_CAREER.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_CAREER.RowStatus(dsT_CM_CAREER.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_CM_CAREER.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("행사일자[" + dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"STR_YMD") + "] 참여사업명[" + dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"PJT_NM") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_CM_CAREER.DeleteRow(dsT_CM_CAREER.RowPosition);

            if (status != 1) {
                trT_CM_CAREER.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira031.cmd.PIRA031CMD&S_MODE=DEL";
                trT_CM_CAREER.post();
            }

            bnd.ActiveBind = false;

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_CM_CAREER.SetColumn(form1.grdT_CM_CAREER.GetColumnID(0));
            form1.grdT_CM_CAREER.Focus();

            bnd.ActiveBind = true;

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

        	var eno_nm = document.getElementById("txtENO_NM").value;
        	var job_cd = document.getElementById("txtJOB_CD").value;
        	var job_nm = document.getElementById("txtJOB_NM").value;
        	var hob_cd = document.getElementById("txtHOB_CD").value;
        	var hinu_amt = document.getElementById("txtHINU_AMT").value;
        	var old_amt = document.getElementById("txtOLD_AMT").value;
        	var npen_amt = document.getElementById("txtNPEN_AMT").value;

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_CM_CAREER.CountColumn == 0) {
                dsT_CM_CAREER.setDataHeader("ENO_NO:STRING,  ENO_NM:STRING, STR_YMD:STRING, END_YMD:STRING,  JOB_NM:STRING, REMARK:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_CM_CAREER.AddRow();

			dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"ENO_NM") = eno_nm;
			dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"JOB_CD") = job_cd;
			dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"JOB_NM") = job_nm;
			dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"HOB_CD") = hob_cd;
			dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"NPEN_AMT") = npen_amt;
			dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"HINU_AMT") = hinu_amt;
			dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"OLD_AMT") = old_amt;



            fnc_ColEnabled('E');

            form1.grdT_CM_CAREER.setColumn(form1.grdT_CM_CAREER.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            // KEY 필드는 신규시 입력 가능
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

        	//사번임시저장
			var ENO_NO = document.getElementById("ENO_NO").value;

			dsT_CM_CAREER.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';

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

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("ENO_NO").value = "<%=ENO_NO%>";

            //Grid Style 적용
            cfStyleGrid_New(form1.grdT_CM_CAREER, 0,"false","false");

            fnc_SearchList();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
        	window.close();
            
        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/
         /**
         * T_CM_COMMON(공통코드) 조회용 팝업 (부서 및 본부는 제외)
         * @param - ctrl_01 : 리턴받을 코드명
         * @param - ctrl_02 : 리턴받을 코드네임명
         * @param - ctrl_03 : 타이틀명
         * @param - ctrl_04 : cd_gbn 코드명
         * @param - ctrl_05 : 기준코드 gbn2_tag 사용 유무(Y/N)(20070313추가)
         * @param - ctrl_06 : 근로구분에 따른 코드구분(20070704추가)
         */
        function fnc_careerCodePopup(ctrl_01,ctrl_02,ctrl_03,ctrl_04,ctrl_05,ctrl_06) {

            var obj = new String();

            obj.comm_cd = document.getElementById(ctrl_01).value;
            obj.comm_nm = document.getElementById(ctrl_02).value;
            obj.title   = ctrl_03;
            obj.cd_gbn  = ctrl_04;

            //값이 없으면 N으로 셋팅
            if(ctrl_05 == undefined || ctrl_05.trim() == ""){
                obj.gbn2_tag = "N";
            }else{
                obj.gbn2_tag = document.getElementById(ctrl_05).value;
            }

            //값이 없거나 공백이면 전체
            if(ctrl_06 == undefined){
                obj.occ_cd = "";
            }else{
                obj.occ_cd = ctrl_06;
            }

            window.showModalDialog("/common/popup/career.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(obj.comm_cd != '' && obj.comm_nm != ''){
                document.getElementById(ctrl_01).value = obj.comm_cd;
                document.getElementById(ctrl_02).value = obj.comm_nm;
            }

        }



        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

        }

    </script>
</head>


    <!--********************************************************************
    * 가우스 컴포넌트 선언 및 이벤트 (트랜젝션, 데이터셋) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_CM_CAREER                       |
    | 3. Table List : T_CM_CAREER                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_CAREER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_CAREER                       |
    | 3. Table List : T_CM_CAREER                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_CAREER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_CAREER)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_CAREER Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_CAREER.CountRow);
            document.getElementById("txtJOB_CD").disabled   = true;
            document.getElementById("txtJOB_NM").disabled   = true;
            document.getElementById("txtTOTAL_AMT").disabled   = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_CAREER Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_CAREER Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            alert("해당 필수입력항목[ ] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50020) {
            alert("행사일자/참여사업명에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_CAREER event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_CAREER event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_CAREER Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_CAREER.SysStatus(row);

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>급여정보</strong>
        </td>
        <td height="25" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <!--   <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','../../images/button/btn_AddnewOver.gif',1)">  <img src="../../images/button/btn_AddnewOn.gif"  name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>-->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">   <img src="../../images/button/btn_SaveOn.gif"    name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a> 
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                 <colgroup>
                    <col width="100 "></col>
                    <col width="150"></col>
                    <col width="100 "></col>
                    <col width="150 "></col>
                    <col width="100 "></col>
                    <col width="150 "></col>
                    <col width="100 "></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">사번</td>
                    <td class="padding2423" >
                        <input id="txtENO_NO" maxlength="10" style="width:45%">
                        <input id="txtENO_NM" maxlength="10" style="width:45%">
                    </td>
                    <td align="center" class="blueBold">직위</td>
                    <td class="padding2423" >
                        <input id="txtJOB_CD" style="width:15%;ime-mode:inactive" maxlength="3" onChange="fnc_ChkJobCd();">
                        <input id="txtJOB_NM" style="width:50%" class="input_ReadOnly"  readonly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgJOB_CD_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgJOB_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_CD','txtJOB_NM','직위','A2');return false;"></a>
                    </td>
                    <input type=hidden id="ENO_NO" size="10">
                    <input type=hidden id="ENO_NM" size="10">
                    <td align="center" class="blueBold"></td>
                    <td class="padding2423" >
                    </td>
                    <td align="center" class="blueBold"></td>
                    <td class="padding2423" >

                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                 <colgroup>
                    <col width="100 "></col>
                    <col width="150"></col>
                    <col width="100 "></col>
                    <col width="150 "></col>
                    <col width="100 "></col>
                    <col width="150 "></col>
                    <col width="100 "></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">국민연금</td>
                    <td class="padding2423" >
                        <input id="txtNPEN_AMT" maxlength="10" style="width:100%;text-align:right">
                    </td>
                    <td align="center" class="blueBold">의료보험</td>
                    <td class="padding2423" >
                        <input id="txtHINU_AMT" maxlength="20" style="width:100%;text-align:right">
                    </td>
                    <td align="center" class="blueBold">요양보험</td>
                    <td class="padding2423" >
                    	<input id="txtOLD_AMT" maxlength="20" style="width:100%;text-align:right">
                    </td>
                    <td align="center" class="blueBold">고용보험</td>
                    <td class="padding2423" >
                    	<input id="txtHINS_AMT" maxlength="20" style="width:100%;text-align:right">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
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
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_CM_CAREER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:990px;height:300px;">
                            <param name="DataID"                  value="dsT_CM_CAREER">
                            <param name="Format"                  value="
                                <C> id=ENO_NO        width=120        name=사번          		align=center    Edit=none  </C>
								<C> id=ENO_NM        width=150       name=성명          	align=center    Edit=none  </C>
								<C> id=JOB_NM        width=150       name=직위명         	align=center    Edit=none  </C>
								<C> id=NPEN_AMT      width=140       name=국민연금       align=right                </C>
								<C> id=HINU_AMT      width=140       name=의료보험        align=right                </C>
								<C> id=OLD_AMT       width=140       name=요양보험        align=right                </C>
								<C> id=HINS_AMT      width=140       name=고용보험        align=right                </C>
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

<!--
**************************************************************
* 바인딩 컴포넌트
"ENO_NO:STRING:KEYVALUETYPE, STR_YMD:STRING:KEYVALUETYPE, ODR_NM:STRING, ATT_SBJ:STRING:KEYVALUETYPE,  CMP_NM:STRING"
**************************************************************
-->
<!-- 기술경력관리 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_CAREER">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=ENO_NM       Ctrl=txtENO_NM       Param=value Disable=disabled </C>
		<C> Col=SEQ_NO        Ctrl=txtSEQ_NO       Param=value </C>
		<C> Col=OCC_CD        Ctrl=txtOCC_CD       Param=value </C>
		<C> Col=JOB_CD        Ctrl=txtJOB_CD       Param=value Disable=disabled</C>
		<C> Col=JOB_NM        Ctrl=txtJOB_NM       Param=value Disable=disabled</C>
		<C> Col=HINU_AMT       Ctrl=txtHINU_AMT      Param=value  </C>
		<C> Col=OLD_AMT       Ctrl=txtOLD_AMT      Param=value  </C>
		<C> Col=HINS_AMT       Ctrl=txtHINS_AMT      Param=value  </C>
		<C> Col=NPEN_AMT       Ctrl=txtNPEN_AMT      Param=value  </C>
    '>
</object>