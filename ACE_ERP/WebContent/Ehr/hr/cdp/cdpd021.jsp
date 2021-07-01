<!--
    ************************************************************************************
    * @Source         : cdpd021.jsp                                                    *
    * @Description    : 후견인양성계획등록 PAGE                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/22  |  박인이   | 최초작성                                               *
    * 2007/04/17  |  김학수   | 인쇄추가                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>OJT계획등록(cdpd021)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'TFFTFTFT';

        var opener = window.dialogArguments;
        var flag   = '';                       // 0: 조회, 1: 저장/삭제

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var ENO_NO  = opener.eno_no;

            flag = '0';

            dsT_CD_OJT.ClearData();

            dsT_CD_OJT.DataId = "/servlet/GauceChannelSVL?cmd=hr.cdp.d.cdpd021.cmd.CDPD021CMD&S_MODE=SHR&ENO_NO="+ENO_NO;
            dsT_CD_OJT.Reset();

            form1.grdT_CD_OJTPLAN.Focus();

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

                flag = '1';

                trT_CD_OJT.KeyValue = "SVL(I:SAV=dsT_CD_OJTPLAN)";
                trT_CD_OJT.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.d.cdpd021.cmd.CDPD021CMD&S_MODE=SAV";
                trT_CD_OJT.post();

            } else {

                return;

            }

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {
            var status = "";

            // 목표
            if(dsT_CD_OJTPLAN.CountRow < 1) {
                alert("삭제할 데이터가 존재하지 않습니다.");
                return;
            }

            status = dsT_CD_OJTPLAN.RowStatus(dsT_CD_OJTPLAN.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_CD_OJTPLAN.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            if(confirm("목표순번 ["+dsT_CD_OJTPLAN.RowPosition +"]의 데이터를 삭제하시겠습니까?")){
                dsT_CD_OJTPLAN.DeleteRow(dsT_CD_OJTPLAN.RowPosition);
            }

            if (status != "1")    {

                flag = '2';

                trT_CD_OJT.KeyValue = "SVL(I:DEL=dsT_CD_OJTPLAN)";
                trT_CD_OJT.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.d.cdpd021.cmd.CDPD021CMD&S_MODE=DEL";
                trT_CD_OJT.post();
            }

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {
            var ENO_NO  = opener.eno_no;

            //이곳에 해당 코딩을 입력 하세요
            var url = "cdpd021_PV.jsp?ENO_NO="+ENO_NO;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
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

            var f = document.form1;

            //DataSet의 변경 여부 확인
            if (!dsT_CD_OJTPLAN.IsUpdated) {
                //document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                alert("* 저장할 내용이 없습니다.");
                return false;
            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid(form1.grdT_CD_OJTPLAN,0,"true","false");

            //후견인일 경우에만 등록가능하게
            if("<%=box.getString("SESSION_ENONO") %>" != opener.eno_no) {
                form1.grdT_CD_OJTPLAN.Enabled = false;

              //  fnc_HiddenElement("imgSave");
              //  fnc_HiddenElement("ImgAddNew");
              //  fnc_HiddenElement("ImgDelete");

            }

            fnc_SearchList();

        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_CD_OJTPLAN.IsUpdated )
            {
                if (!fnc_ExitQuestion()) return;
            }

            opener.fnc_SearchList();

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

         function fnc_BuildOJTPLAN() {

			var tmpStrYmd;
			var tmpEndYmd;
			for(var i=0; i<3; i++){
				tmpStrYmd = shiftTime(document.getElementById("txtSTR_YMD").value, i*7);
				tmpEndYmd = shiftTime(document.getElementById("txtSTR_YMD").value, ((i+1)*7)-1);

	            dsT_CD_OJTPLAN.AddRow();
	            dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition,'ENO_NO') = opener.eno_no;
            	dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition,"TRA_WEEK") = dsT_CD_OJTPLAN.CountRow;
	            dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition,'TRA_ENO_NO') = document.getElementById("txtTRA_ENO_NO").value;
	            dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition,'TRA_ENO_NM') = document.getElementById("txtTRA_ENO_NM").value;
            	dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition,"STR_YMD") = tmpStrYmd;
            	dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition,"END_YMD") = tmpEndYmd;

	            document.form1.grdT_CD_OJTPLAN.SetColumn(form1.grdT_CD_OJTPLAN.getColumnID(0));

			}

        }

        //시작일에서 iday만큼 더해줌
		function shiftTime(p_value, iday) {
			var gs_DateStr = p_value.replaceStr("-","");
			var go_Date = null;
			if (gs_DateStr.length == 8) {	//년월일
				go_Date = new Date(gs_DateStr.substring(0,4), gs_DateStr.substring(4,6) -1, gs_DateStr.substring(6,8));
				go_Date.setDate(go_Date.getDate()+iday);
				var tmpYear = go_Date.getYear();
				if (tmpYear < 2000)
				{
					tmpYear = "19" + go_Date.getYear();
				}

				var ls_DateStr = tmpYear + "";
				ls_DateStr += "-";

				if (go_Date.getMonth()+1 < 10) {
					ls_DateStr += "0" + (go_Date.getMonth()+1);
				} else {
					ls_DateStr += "" + (go_Date.getMonth()+1);
				}
				ls_DateStr += "-";

				if (go_Date.getDate() < 10) {
					ls_DateStr += "0" + go_Date.getDate();
				} else {
					ls_DateStr += "" + go_Date.getDate();
				}
			}

			return ls_DateStr;
		}

		function fnc_UsrGetEnoNm() {

            var obj = new String();

            obj = fnc_GetEnoNm("txtPlanTRA_ENO_NO");

            document.getElementById("txtPlanTRA_ENO_NO").value = obj.eno_no;
            document.getElementById("txtPlanTRA_ENO_NM").value = obj.eno_nm;
        }

        function fnc_UsrGetEnoNo() {

        	fnc_GetEnoNo('txtPlanTRA_ENO_NM', 'txtPlanTRA_ENO_NO');
        	fnc_UsrGetEnoNm();

        }

        function fnc_Popup() {
            var obj = new String();

                // 정규직 재직자만
                obj = fnc_emplPopup('txtPlanTRA_ENO_NO','txtPlanTRA_ENO_NM');

                if (obj.eno_no == "") {
                    return;
                }

                document.getElementById("txtPlanTRA_ENO_NO").value = obj.eno_no;
                document.getElementById("txtPlanTRA_ENO_NM").value = obj.eno_nm;

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
    | 2. 이름은 ds_ + 주요 테이블명(T_CD_MENTOPLAN) |
    | 3. 사용되는 Table List(T_CD_MENTOPLAN)        |
    +----------------------------------------------->
    <Object ID="dsT_CD_OJTPLAN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
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
    | 2. 이름 : trT_CD_OJT                    |
    | 3. Table List : T_CD_MENTO                |
    +----------------------------------------------->
    <Object ID ="trT_CD_OJT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CD_OJT)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CD_OJTPLAN Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

        	fnc_BuildOJTPLAN();

            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CD_OJTPLAN.CountRow );



        }


    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CD_OJTPLAN Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_OJTPLAN Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {

            alert("해당 필수입력항목[내용] 입력 후 다음 작업이 가능합니다.");

        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CD_OJT Event="OnLoadCompleted(iCount)">

        var ENO_NO  = opener.eno_no;

        if (iCount > 0) {
        	var today = getToday().replace("-","").replace("-","");
        	var STR_YMD = dsT_CD_OJT.NameValue(1, "STR_YMD").replace("-","").replace("-","");
        	var END_YMD = dsT_CD_OJT.NameValue(1, "END_YMD").replace("-","").replace("-","");

            if (STR_YMD > today || END_YMD < today) {

                form1.grdT_CD_OJTPLAN.Enabled = false;

             //   document.getElementById("imgSave").disabled = true;
             //   document.getElementById("imgSave").style.display = "none";

              //  document.getElementById("ImgAddNew").disabled = true;
              //  document.getElementById("ImgAddNew").style.display = "none";
              //  document.getElementById("ImgDelete").disabled = true;
              //  document.getElementById("ImgDelete").style.display = "none";
            }

            trT_CD_OJT.KeyValue = "tr01(O:SHR_01=dsT_CD_OJTPLAN)";
            trT_CD_OJT.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.d.cdpd021.cmd.CDPD021CMD&S_MODE=SHR_01&ENO_NO="+ENO_NO;
            trT_CD_OJT.post();

        }
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

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CD_OJT event="OnSuccess()">

        // 저장인 경우 재조회
        if (flag == '1') {

            fnc_SearchList();

        }

        flag = '';

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CD_OJT event="OnFail()">

        cfErrorMsg(this);
        flag = '';

    </script>

<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">OJT 계획등록</td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">   <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
       <!--      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>  -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">   <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                    <col width="90"></col>
                    <col width="60"></col>
                    <col width="215"></col>
                    <col width="60"></col>
                    <col width="145"></col>
                    <col width="60"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">대상자</td>
                    <td align="center" class="creamBold">사번</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">소속</td>
                    <td class="padding2423">
                        <input id="txtDPT_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtDPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">직위</td>
                    <td class="padding2423">
                        <input id="txtJOB_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtJOB_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold"></td>
                    <td align="center" class="creamBold">입사일</td>
                    <td class="padding2423" colspan="5">
                    	<input id="txtHIR_YMD" name="txtHIR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">책임지도사원</td>
                    <td align="center" class="creamBold">사번</td>
                    <td class="padding2423">
                        <input id="txtTRA_ENO_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtTRA_ENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">소속</td>
                    <td class="padding2423">
                        <input id="txtMDPT_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtMDPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">직위</td>
                    <td class="padding2423">
                        <input id="txtMJOB_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtMJOB_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">OJT</td>
                    <td align="center" class="creamBold">기간</td>
                    <td class="padding2423">
                    	<input id="txtSTR_YMD" name="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" class="input_ReadOnly" readonly> ~
                        <input id="txtEND_YMD" name="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">부서</td>
                    <td class="padding2423" colspan="3">
                    	<input id="txtTRA_DPT_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtTRA_DPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                	<td align="center" class="creamBold"></td>
                    <td align="center" class="creamBold">담당팀장</td>
                    <td class="padding2423">
                    	<input id="txtHEAD_EMP_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtHEAD_EMP_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">담당업무</td>
                    <td class="padding2423" colspan="3">
						<input id="txtTRA_DUTY" size="53" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                	<td align="center" class="creamBold"></td>
                    <td align="center" class="creamBold">교육목표</td>
                    <td class="padding2423" colspan="5">
                    	<input id="txtEDU_GOAL1" size="100" class="input_ReadOnly" readonly>
                    	<input id="txtEDU_GOAL2" size="100" class="input_ReadOnly" readonly>
                    	<input id="txtEDU_GOAL3" size="100" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>교육계획표</strong>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3">
        	<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60"></col>
                    <col width="120"></col>
                    <col width="70"></col>
                    <col width="215"></col>
                    <col width="90"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">주차</td>
                    <td class="padding2423">
                        <input id="txtPlanTRA_WEEK" size="2" maxlength="2" style="ime-mode:disabled" class="input_ReadOnly" readOnly> 주
                    </td>
                    <td align="center" class="creamBold">일자</td>
                    <td class="padding2423">
                        <input id="txtPlanSTR_YMD" name="txtPlanSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '시작일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPlanStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgPlanStrYmd" name="ImgPlanStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPlanSTR_YMD','','36','227');"></a>
                        ~
                        <input id="txtPlanEND_YMD" name="txtPlanEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '종료일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPlanEndYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgPlanEndYmd" name="ImgPlanEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPlanEND_YMD','','152','227');"></a>
                    </td>
                    <td align="center" class="creamBold">교육담당</td>
                    <td class="padding2423">
                        <input id="txtPlanTRA_ENO_NO" size="8" maxlength="8" style="ime-mode:disabled" onkeypress="if(event.keyCode==13) fnc_UsrGetEnoNm();" onChange="fnc_UsrGetEnoNm();">
                        <input id="txtPlanTRA_ENO_NM" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_UsrGetEnoNo();" onchange="fnc_UsrGetEnoNo();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPlanEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgPlanEnoNo" name="ImgPlanEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_Popup()"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">지도항목</td>
                    <td class="padding2423" colspan="5">
                    	<input id="txtPlanTRA_SUBITEM" size="100">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<!--
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
-->
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3" colspan="2">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CD_OJTPLAN" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:277px;">
                            <param name="DataID"                  value="dsT_CD_OJTPLAN">
                            <param name="Editable"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
	                            <G> name='교육일정' HeadBgColor='#F7DCBB'
	                                <C> id='TRA_WEEK'     width=40    name='주차'         align=center edit='none'</C>
	                                <C> id='STR_YMD'     width=80   name='시작일'         align=center edit='none'</C>
	                                <C> id='END_YMD'     width=80   name='종료일'         align=center edit='none'</C>
	                            </G>
	                                <C> id='TRA_ENO_NM'     width=70   name='교육담당'         align=center edit='none'</C>
	                                <C> id='TRA_SUBITEM'     width=500   name='지도항목'         align=left   EditLimit=2000 edit='none'</C>
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
        <C> Col=HIR_YMD       Ctrl=txtHIR_YMD       Param=value </C>
        <C> Col=TRA_DUTY        Ctrl=txtTRA_DUTY        Param=value </C>
        <C> Col=HEAD_EMP_NO        Ctrl=txtHEAD_EMP_NO        Param=value </C>
        <C> Col=HEAD_EMP_NM        Ctrl=txtHEAD_EMP_NM        Param=value </C>
        <C> Col=EDU_GOAL1        Ctrl=txtEDU_GOAL1        Param=value </C>
        <C> Col=EDU_GOAL2        Ctrl=txtEDU_GOAL2        Param=value </C>
        <C> Col=EDU_GOAL3        Ctrl=txtEDU_GOAL3        Param=value </C>
    '>
</object>
<object id="mxBind" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CD_OJTPLAN">
    <Param Name="BindInfo", Value='
        <C> Col=TRA_WEEK        Ctrl=txtPlanTRA_WEEK        Param=value </C>
        <C> Col=TRA_SUBITEM        Ctrl=txtPlanTRA_SUBITEM        Param=value </C>
        <C> Col=STR_YMD        Ctrl=txtPlanSTR_YMD        Param=value </C>
        <C> Col=END_YMD        Ctrl=txtPlanEND_YMD        Param=value </C>
        <C> Col=TRA_ENO_NO        Ctrl=txtPlanTRA_ENO_NO        Param=value </C>
        <C> Col=TRA_ENO_NM        Ctrl=txtPlanTRA_ENO_NM        Param=value </C>
    '>
</object>