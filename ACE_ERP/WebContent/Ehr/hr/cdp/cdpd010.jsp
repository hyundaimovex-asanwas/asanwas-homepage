<!--
    ************************************************************************************
    * @Source         : cdpd010.jsp                                                    *
    * @Description    : OJT등록 PAGE                                                *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/21 |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    String ROLE_CD = box.getString("SESSION_ROLE_CD");
    String EDU_AUTHO = box.getString("SESSION_EDU_AUTHO");

    boolean isMaster = false;
    boolean isSubMaster = false;

    if(ROLE_CD.equals("1001")
            || ROLE_CD.equals("1002")
            || EDU_AUTHO.equals("A")) {
        isMaster = true;
    } else if (EDU_AUTHO.equals("S")) {
        isSubMaster = true;
    }
%>

<html>

    <head>
    <title>OJT등록(cdpd010)</title>
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

        var btnList = 'TTTTTTFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var MNT_GBN = document.getElementById("cmbMNT_GBN").value;
            var ENO_NO  = document.getElementById("txtENO_NO_SHR").value;

<%
    if(!isMaster) {
%>
            alert("권한이 없습니다.");
            return;
<%
    }
%>

            dsT_CD_OJT.DataId = "/servlet/GauceChannelSVL?cmd=hr.cdp.d.cdpd010.cmd.CDPD010CMD"
                                + "&S_MODE=SHR"
                                + "&ENO_NO="+ENO_NO
                                + "&MNT_GBN="+MNT_GBN;
            dsT_CD_OJT.Reset();

            form1.grdT_CD_OJT.Focus();

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

                trT_CD_OJT.KeyValue = "tr01(I:SAV=dsT_CD_OJT)";
                trT_CD_OJT.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.d.cdpd010.cmd.CDPD010CMD&S_MODE=SAV";
                trT_CD_OJT.post();

            }
        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            var status = 0;

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_CD_OJT.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CD_OJT.RowStatus(dsT_CD_OJT.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_CD_OJT.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("대상자 [" + dsT_CD_OJT.NameValue(dsT_CD_OJT.RowPosition,"ENO_NO") + "][" + dsT_CD_OJT.NameValue(dsT_CD_OJT.RowPosition,"ENO_NM") + "], 책임지도사원 [" + dsT_CD_OJT.NameValue(dsT_CD_OJT.RowPosition,"TRA_ENO_NO") + "][" + dsT_CD_OJT.NameValue(dsT_CD_OJT.RowPosition,"TRA_ENO_NM") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_CD_OJT.DeleteRow(dsT_CD_OJT.RowPosition);

            if (status != 1) {
                trT_CD_OJT.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.d.cdpd010.cmd.CDPD010CMD&S_MODE=DEL";
                trT_CD_OJT.post();
            }

            bnd.ActiveBind = false;

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_CD_OJT.SetColumn(form1.grdT_CD_OJT.GetColumnID(0));
            form1.grdT_CD_OJT.Focus();

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

            if (dsT_CD_OJT.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CD_OJT.GridToExcel("OJT대상자", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

<%
    if(!isMaster) {
%>
            alert("권한이 없습니다.");
            return;
<%
    }
%>
            // 해당 Dataset의 Header가 없으면 Header 선언
//            if (dsT_CD_OJT.CountColumn == 0) {
//            	// 데이터셋의 헤더 정보 설정.
//                dsT_CD_OJT.setDataHeader("ENO_NO:STRING, ENO_NM:STRING, DPT_CD:STRING, DPT_NM:STRING, JOB_CD:STRING, JOB_NM:STRING, HIR_YMD:STRING, TRA_ENO_NO:STRING, TRA_ENO_NM:STRING, " +
//                                           "MDPT_CD:STRING, MDPT_NM:STRING, MJOB_CD:STRING, MJOB_NM:STRING, STR_YMD:STRING, END_YMD:STRING");
//            }
			
			if (dsT_CD_OJT.CountColumn == 0) {
            	alert("조회를 먼저 하셔야합니다.");
                return;
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_CD_OJT.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_CD_OJT.setColumn(form1.grdT_CD_OJT.getColumnID(0));

            document.getElementById("txtENO_NO").disabled  = false;
            document.getElementById("ImgEnoNo").disabled   = false;

            document.getElementById("txtENO_NO").focus();

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

            document.getElementById("txtENO_NO_SHR").value  = '';
            document.getElementById("txtENO_NM_SHR").value  = '';

            document.getElementById("txtDPT_CD").value = '';
            document.getElementById("txtDPT_NM").value = '';
            document.getElementById("txtJOB_CD").value = '';
            document.getElementById("txtJOB_NM").value = '';
            document.getElementById("txtENO_NO").value = '';
            document.getElementById("txtENO_NM").value = '';
            document.getElementById("txtMDPT_CD").value = '';
            document.getElementById("txtMDPT_NM").value = '';
            document.getElementById("txtMJOB_CD").value = '';
            document.getElementById("txtMJOB_NM").value = '';
            document.getElementById("txtTRA_ENO_NO").value = '';
            document.getElementById("txtTRA_ENO_NM").value = '';
            document.getElementById("txtSTR_YMD").value = '';
            document.getElementById("txtEND_YMD").value = '';
            document.getElementById("txtTRA_DPT_CD").value = '';
            document.getElementById("txtTRA_DPT_NM").value = '';
            document.getElementById("txtHIR_YMD").value = '';

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_CD_OJT.ClearData();

            fnc_ColEnabled('D');

            document.getElementById("txtENO_NO_SHR").focus();

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
            if (!dsT_CD_OJT.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_CD_OJT.CountRow; i++ ) {
                if ( dsT_CD_OJT.RowStatus(i) == 1 ||
                     dsT_CD_OJT.RowStatus(i) == 3 ) {

                    // OJT대상자
                    if( dsT_CD_OJT.NameValue(i, "ENO_NO") == '' ) {
                        alert("대상자사번은 필수 입력사항입니다.");
                        dsT_CD_OJT.RowPosition = i;
                        document.getElementById("txtENO_NO").focus();
                        return false;
                    } else if(dsT_CD_OJT.NameValue(i, "ENO_NM") == ""){
                    	alert("대상자사번에 입력하신 값은 존재하지 않는 사번입니다. 확인바랍니다.");
                        dsT_CD_OJT.RowPosition = i;
                        document.getElementById("txtENO_NO").focus();
                        return;
                    }

                    // 책임지도사원
//                    if( dsT_CD_OJT.NameValue(i, "TRA_ENO_NO") == '' ) {
//                        alert("책임지도사원사번은 필수 입력사항입니다.");
//                        dsT_CD_OJT.RowPosition = i;
//                        document.getElementById("txtTRA_ENO_NO").focus();
//                        return false;
//                    }

                    // 책임지도사원
//                    if (dsT_CD_OJT.NameValue(i, "TRA_ENO_NO") != "" &&
//                        dsT_CD_OJT.NameValue(i, "TRA_ENO_NM") == "") {
//                        alert("책임지도사원사번에 입력하신 값은 존재하지 않는 사번입니다. 확인바랍니다.");
//                        dsT_CD_OJT.RowPosition = i;
//                        document.getElementById("txtTRA_ENO_NO").focus();
//                        return;
//                    }

//                    if (dsT_CD_OJT.NameValue(i, "ENO_NO") == dsT_CD_OJT.NameValue(i, "TRA_ENO_NO")) {
//                        alert("대상자사번과 책임지도사원사번이 동일합니다. 확인바랍니다.");
//                        dsT_CD_OJT.RowPosition = i;
//                        document.getElementById("txtENO_NO").focus();
//                        return false;
//                    }


                    // 시작일자
                    if( dsT_CD_OJT.NameValue(i, "STR_YMD") == '' ) {
                        alert("시작일자는 필수 입력사항입니다.");
                        dsT_CD_OJT.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // 시작일자 CHECK
                    if (!fnc_CheckDate2(dsT_CD_OJT.NameValue(i, "STR_YMD"), "시작일자") && dsT_CD_OJT.NameValue(i, "STR_YMD") != "") {
                        dsT_CD_OJT.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // 종료일자
                    if( dsT_CD_OJT.NameValue(i, "END_YMD") == '' ) {
                        alert("종료일자는 필수 입력사항입니다.");
                        dsT_CD_OJT.RowPosition = i;
                        document.getElementById("txtEND_YMD").focus();
                        return false;
                    }

                    // 종료일자 CHECK
                    if (!fnc_CheckDate2(dsT_CD_OJT.NameValue(i, "END_YMD"), "종료일자") && dsT_CD_OJT.NameValue(i, "END_YMD") != "") {
                        dsT_CD_OJT.RowPosition = i;
                        document.getElementById("txtEND_YMD").focus();
                        return false;
                    }

                    // 기간 FROM일자와 TO일자 비교
                    if(dsT_CD_OJT.NameValue(i, "STR_YMD") != '' && dsT_CD_OJT.NameValue(i, "END_YMD") != '') {
                        if(removeChar(dsT_CD_OJT.NameValue(i, "STR_YMD"),'-') > removeChar(dsT_CD_OJT.NameValue(i, "END_YMD"),'-')) {
                            alert("시작일자는 반드시 종료일자보다 작아야합니다.");
                            dsT_CD_OJT.RowPosition = i;
                            document.getElementById("txtSTR_YMD").focus();
                            return false;
                        }
                    }
                    
                    // OJT부서
                    if( dsT_CD_OJT.NameValue(i, "TRA_DPT_CD") == '' ) {
                        alert("OJT부서는 필수 입력사항입니다.");
                        dsT_CD_OJT.RowPosition = i;
                        document.getElementById("txtTRA_DPT_CD").focus();
                        return false;
                    }

                    if ( dsT_CD_OJT.RowStatus(i) == 1) {
                       document.getElementById("txtENO_NO").disabled  = true;
                       document.getElementById("ImgEnoNo").disabled   = true;
                    }

                }
            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid(form1.grdT_CD_OJT,0,"false","false");

            fnc_ColEnabled('D');

            document.getElementById("txtENO_NO_SHR").focus();
        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_CD_OJT.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

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

        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {

                document.getElementById("txtENO_NO").disabled  = false;
                document.getElementById("txtENO_NM").disabled  = false;
                document.getElementById("txtDPT_CD").disabled  = false;
                document.getElementById("txtDPT_NM").disabled  = false;
                document.getElementById("txtJOB_CD").disabled  = false;
                document.getElementById("txtJOB_NM").disabled  = false;
                document.getElementById("txtTRA_ENO_NO").disabled = false;
                document.getElementById("txtTRA_ENO_NM").disabled = false;
                document.getElementById("txtMDPT_CD").disabled = false;
                document.getElementById("txtMDPT_NM").disabled = false;
                document.getElementById("txtMJOB_CD").disabled = false;
                document.getElementById("txtMJOB_NM").disabled = false;
                document.getElementById("txtSTR_YMD").disabled = false;
                document.getElementById("txtEND_YMD").disabled = false;
                document.getElementById("txtTRA_DPT_CD").disabled = false;
                document.getElementById("txtHIR_YMD").disabled = false;

                document.getElementById("ImgEnoNo").disabled   = false;
                document.getElementById("ImgMenoNo").disabled  = false;
                document.getElementById("ImgStrYmd").disabled  = false;
                document.getElementById("ImgEndYmd").disabled  = false;
                document.getElementById("ImgTraDptCd").disabled  = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtENO_NO").disabled  = true;
                document.getElementById("txtENO_NM").disabled  = true;
                document.getElementById("txtDPT_CD").disabled  = true;
                document.getElementById("txtDPT_NM").disabled  = true;
                document.getElementById("txtJOB_CD").disabled  = true;
                document.getElementById("txtJOB_NM").disabled  = true;
                document.getElementById("txtTRA_ENO_NO").disabled = true;
                document.getElementById("txtTRA_ENO_NM").disabled = true;
                document.getElementById("txtMDPT_CD").disabled = true;
                document.getElementById("txtMDPT_NM").disabled = true;
                document.getElementById("txtMJOB_CD").disabled = true;
                document.getElementById("txtMJOB_NM").disabled = true;
                document.getElementById("txtSTR_YMD").disabled = true;
                document.getElementById("txtEND_YMD").disabled = true;
                document.getElementById("txtTRA_DPT_CD").disabled = true;
                document.getElementById("txtHIR_YMD").disabled = true;

                document.getElementById("ImgEnoNo").disabled   = true;
                document.getElementById("ImgMenoNo").disabled  = true;
                document.getElementById("ImgStrYmd").disabled  = true;
                document.getElementById("ImgEndYmd").disabled  = true;
                document.getElementById("ImgTraDptCd").disabled  = true;

            }

        }

        function fnc_UsrGetEnoNm(gbn) {

            var obj = new String();

            if (gbn == 'ENO_NO') {

                obj = fnc_GetEnoNm("txtENO_NO");

                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtENO_NM").value = obj.eno_nm;
                document.getElementById("txtDPT_CD").value = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value = obj.dpt_nm;
                document.getElementById("txtJOB_CD").value = obj.job_cd;
                document.getElementById("txtJOB_NM").value = obj.job_nm;
                document.getElementById("txtHIR_YMD").value = obj.hir_ymd;
                document.getElementById("txtSTR_YMD").value = obj.hir_ymd;
                document.getElementById("txtEND_YMD").value = shiftTime(obj.hir_ymd);
                

            }
            else if (gbn == 'TRA_ENO_NO') {

                obj = fnc_GetEnoNm("txtTRA_ENO_NO");

                document.getElementById("txtTRA_ENO_NO").value = obj.eno_no;
                document.getElementById("txtTRA_ENO_NM").value = obj.eno_nm;
                document.getElementById("txtMDPT_CD").value = obj.dpt_cd;
                document.getElementById("txtMDPT_NM").value = obj.dpt_nm;
                document.getElementById("txtMJOB_CD").value = obj.job_cd;
                document.getElementById("txtMJOB_NM").value = obj.job_nm;
            }
        }

        function fnc_UsrGetEnoNo(gbn) {
        	if (gbn == 'ENO_NO') {
        		fnc_GetEnoNo('txtENO_NM', 'txtENO_NO');
        	}

        	else if (gbn == 'TRA_ENO_NO') {
        		fnc_GetEnoNo('txtTRA_ENO_NM', 'txtTRA_ENO_NO');
        	}

        	fnc_UsrGetEnoNm(gbn);

        }

        function fnc_Popup(gbn) {
            var obj = new String();

            if (gbn == 'ENO_NO') {
                // 정규직 재직자만
                obj = fnc_emplPopup('txtENO_NO','txtENO_NM');

                if (obj.eno_no == "") {
                    return;
                }

                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtENO_NM").value = obj.eno_nm;
                document.getElementById("txtDPT_CD").value = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value = obj.dpt_nm;
                document.getElementById("txtJOB_CD").value = obj.job_cd;
                document.getElementById("txtJOB_NM").value = obj.job_nm;
                document.getElementById("txtHIR_YMD").value = obj.hir_ymd;
                document.getElementById("txtSTR_YMD").value = obj.hir_ymd;
                document.getElementById("txtEND_YMD").value = shiftTime(obj.hir_ymd);
            }
            else {
                // 정규직 재직자만
                obj = fnc_emplPopup('txtTRA_ENO_NO','txtTRA_ENO_NM');

                if (obj.eno_no == "") {
                    return;
                }

                document.getElementById("txtTRA_ENO_NO").value = obj.eno_no;
                document.getElementById("txtTRA_ENO_NM").value = obj.eno_nm;
                document.getElementById("txtMDPT_CD").value = obj.dpt_cd;
                document.getElementById("txtMDPT_NM").value = obj.dpt_nm;
                document.getElementById("txtMJOB_CD").value = obj.job_cd;
                document.getElementById("txtMJOB_NM").value = obj.job_nm;
            }

        }
        
        //OJT시작일,종료일 계산
        function setStrEndDate(p_value) {
        	if (p_value.length == 10){
	        	document.getElementById("txtSTR_YMD").value = p_value;
	        	document.getElementById("txtEND_YMD").value = shiftTime(p_value);
        	}
        }
        
        //시작일에서 3개월 더해줌
		function shiftTime(p_value) {
			var gs_DateStr = p_value.replaceStr("-","");
			var go_Date = null;
			if (gs_DateStr.length == 8) {	//년월일
				go_Date = new Date(gs_DateStr.substring(0,4), gs_DateStr.substring(4,6) -1, gs_DateStr.substring(6,8));
				go_Date.setDate(go_Date.getDate()+(7*12)-1);	//12주로 고정
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
		        
        
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

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
    | 2. 이름 : trT_CD_OJT                        |
    | 3. Table List : T_CD_MENTO                    |
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
    <Script For=dsT_CD_OJT Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CD_OJT.CountRow );

            fnc_ColEnabled('E');

            document.getElementById("txtENO_NO").disabled  = true;
            document.getElementById("ImgEnoNo").disabled   = true;

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CD_OJT Event="OnLoadError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_OJT Event="OnDataError()">
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
            alert("해당 필수입력항목[책임지도사원] 입력 후 다음 작업이 가능합니다.");
        }
        /*
        else if (this.ErrorCode == 50019) {
            alert("직책코드에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        */
        else {
            cfErrorMsg(this);
        }
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CD_OJT event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CD_OJT event="OnFail()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">OJT등록</td>
                    <td align="right" class="navigator">HOME/교육관리/CDP/OJT관리/<font color="#000000">OJT등록</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
			                	<col width="90"></col>
			                    <col width="100"></col>
			                	<col width="90"></col>
			                    <col width="*"></col>
			                </colgroup>
                            <tr>
                                <td align="right" class="searchState">구&nbsp;&nbsp;분&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbMNT_GBN">
                                        <option value="">전체</option>
                                        <option value="P">신입사원</option>
                                        <option value="M">책임지도사원</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState" width="70">사원번호&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');"></a>
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

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
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
                        <input id="txtENO_NO" size="8" maxlength="8" style="ime-mode:disabled" onkeypress="if(event.keyCode==13) fnc_UsrGetEnoNm('ENO_NO');" onChange="fnc_UsrGetEnoNm('ENO_NO');">
                        <input id="txtENO_NM" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_UsrGetEnoNo('ENO_NO');" onchange="fnc_UsrGetEnoNo('ENO_NO');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_Popup('ENO_NO')"></a>
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
                    <td align="center" class="creamBold">책임지도사원</td>
                    <td align="center" class="creamBold">사번</td>
                    <td class="padding2423">
                        <input id="txtTRA_ENO_NO" size="8" maxlength="8" style="ime-mode:disabled" onkeypress="if(event.keyCode==13) fnc_UsrGetEnoNm('TRA_ENO_NO');" onChange="fnc_UsrGetEnoNm('TRA_ENO_NO');">
                        <input id="txtTRA_ENO_NM" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_UsrGetEnoNo('TRA_ENO_NO');" onchange="fnc_UsrGetEnoNo('TRA_ENO_NO');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMenoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgMenoNo" name="ImgMenoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_Popup('TRA_ENO_NO')"></a>
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
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60"></col>
                    <col width="145"></col>
                    <col width="60"></col>
                    <col width="215"></col>
                    <col width="60"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">입사일</td>
                    <td class="padding2423">
                        <input id="txtHIR_YMD" name="txtHIR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '입사일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();setStrEndDate(this.value);">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgHirYmd" name="ImgHirYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtHIR_YMD','','36','227');"></a>
                    </td>
                    <td align="center" class="creamBold">기간</td>
                    <td class="padding2423">
                        <input id="txtSTR_YMD" name="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '시작일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','36','227');"></a>
                        ~
                        <input id="txtEND_YMD" name="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '종료일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEndYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEndYmd" name="ImgEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','152','227');"></a>
                    </td>
                    <td align="center" class="creamBold">부서</td>
                    <td class="padding2423">
                        <input id="txtTRA_DPT_CD" size="3" maxlength="2" onkeypress="javascript:if(event.keyCode==13){fnc_GetCommNm('A4', 'txtTRA_DPT_CD','txtTRA_DPT_NM');}"  onChange="fnc_GetCommNm('A4', 'txtTRA_DPT_CD','txtTRA_DPT_NM');">
						<input id="txtTRA_DPT_NM" size="12" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)">
                        	<img src="/images/button/btn_HelpOn.gif" id="ImgTraDptCd" name="ImgTraDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtTRA_DPT_CD','txtTRA_DPT_NM','소속','DEPT')">
                       	</a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->

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
                        <object    id="grdT_CD_OJT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:250px;">
                            <param name="DataID"             value="dsT_CD_OJT">
                            <param name="EdiTABLE"           value="false">
                            <param name="DragDropEnable"     value="true">
                            <param name="SortView"           value="Left">
                            <param name="VIEWSUMMARY"        value=0>
                            <param name="Format"             value="
                                <C> id='{currow}'            width=29    name='순번'       align=center </C>
                                <G> name='신입사원' HeadBgColor='#F7DCBB'
                                    <C> id='ENO_NO'          width=70    name='사번'       align=center  Gte_ColumnType='Number:0:False'</C>
                                    <C> id='ENO_NM'          width=70    name='성명'       align=center </C>
                                    <C> id='DPT_NM'          width=90    name='소속'       align=left   </C>
                                    <C> id='JOB_NM'          width=60    name='직위'       align=center </C>
                                    <C> id='HIR_YMD'        width=70    name='입사일'     align=center </C>
                                </G>
                                <C> id='TRA_DPT_NM'            width=90    name='OJT부서'       align=center </C>
                                <G> name='책임지도사원' HeadBgColor='#F7DCBB'
                                    <C> id='TRA_ENO_NO'         width=70    name='사번'       align=center Gte_ColumnType='Number:0:False'</C>
                                    <C> id='TRA_ENO_NM'         width=70    name='성명'       align=center </C>
                                    <C> id='MDPT_NM'         width=90    name='소속'       align=left   </C>
                                    <C> id='MJOB_NM'         width=60    name='직위'       align=center </C>
                                </G>
                                <G> name='OJT기간' HeadBgColor='#F7DCBB'
                                    <C> id='STR_YMD'         width=70    name='시작일자'   align=center </C>
                                    <C> id='END_YMD'         width=70    name='종료일자'   align=center </C>
                                </G>
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
<!-- 내용보기 테이블 -->
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
    '>
</object>
