<!--
    ************************************************************************************
    * @Source              : joba010.jsp                                                                                              *
    * @Description        : 직무이동대상자설정                                                                                  *
    * @Font                   :                                                                                                                 *
    * @Developer Desc :                                                                                                                 *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/11  |  박인이   | 최초작성                                                                                           *
    * 2006/10/20  |  한학현   | 개발완료                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>직무이동대상자설정</title>
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

		var btnList = 'TTTTFFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var f = document.form1;
			//if (!valid(form1)) return;//Validation 수행
			try {
	            dsT_EV_JOBHEAD.DataID = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba010.cmd.JOBA010CMD&S_MODE=SHR";
	            dsT_EV_JOBHEAD.Reset();
				//마지막 row로 이동
				dsT_EV_JOBHEAD.RowPosition=dsT_EV_JOBHEAD.CountRow;

				//기준일자를 현재일자로 셋팅
	            //document.getElementById("txtBASIC_YMD").value = getToday();
			} catch ( exception ) {
				fcWindowsXpSp2Notice(false);
				return;
			}
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
			if(fnc_SaveItemCheck()) {
				document.getElementById("viewflag").value = "1";
				trT_EV_JOBHEAD.KeyValue = "SVL(I:dsT_EV_JOBHEAD=dsT_EV_JOBHEAD)";
				trT_EV_JOBHEAD.action = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba010.cmd.JOBA010CMD&S_MODE=SAV";
				trT_EV_JOBHEAD.post();

				//신규저장이면 저장후 대상자 선정이 가능하다.
				if(dsT_EV_JOBHEAD.NameValue(dsT_EV_JOBHEAD.RowPosition,"STATUS_JOB") == ""){
					dsT_EV_JOBHEAD.NameValue(dsT_EV_JOBHEAD.RowPosition,"STATUS_JOB") = "0";
					dsT_EV_JOBHEAD.ResetStatus();
					posChanged(dsT_EV_JOBHEAD.RowPosition);
				}
			} else {
				return;
			}
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
            if (dsT_EV_JOBHEAD.CountColumn == 0) {
                dsT_EV_JOBHEAD.setDataHeader("PIS_YYMM:STRING:KEYVALUETYPE, RSH_DEC:INT, RSHOBJ_01:STRING, RSHOBJ_02:STRING, EXCEPT_MON:INT, TOTAL_CNT:INT, OBJECT_CNT:INT, STATUS_JOB:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_EV_JOBHEAD.AddRow();

            fnc_ColEnabled('E');

			dsT_EV_JOBHEAD.NameValue(dsT_EV_JOBHEAD.RowPosition,"RSH_DEC") = "1";
			document.getElementById("txtPIS_YYMM").focus();
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
            // 삭제 할 자료가 있는지 체크하고
            if (dsT_EV_JOBHEAD.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

			// 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + dsT_EV_JOBHEAD.ColumnString(dsT_EV_JOBHEAD.RowPosition,2) + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_EV_JOBHEAD.DeleteRow(dsT_EV_JOBHEAD.RowPosition);

            // 삭제 후 해당 그리드로 Focus 이동
            grdT_EV_JOBHEAD.SetColumn(grdT_EV_JOBHEAD.GetColumnID(0));
            grdT_EV_JOBHEAD.Focus();
        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {
			dsT_EV_JOBHEAD.ClearData();
			dsT_EV_JOBHEAD.Reset();
			//마지막 row로 이동
			dsT_EV_JOBHEAD.RowPosition=dsT_EV_JOBHEAD.CountRow;

			fnc_ColEnabled('D');
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

        //이곳에 해당 코딩을 입력 하세요
        if (dsT_EV_JOBHEAD.IsUpdated)  {

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
			if (!dsT_EV_JOBHEAD.IsUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
		    	return false;
			}

			var i = 0;
			var oPIS_YYMM, oBASIC_YMD, oRSH_DEC, oRSHOBJ_01, oRSHOBJ_02, oEXCEPT_MON, oRSHOBJ_01, oRSHOBJ_02;
			var RowCnt = dsT_EV_JOBHEAD.CountRow;

			for(i=1; i<=RowCnt; i++){

				oPIS_YYMM = dsT_EV_JOBHEAD.NameValue(i,"PIS_YYMM");
				if(oPIS_YYMM.trim().length == 0){
					alert("조사년월을 입력하세요.");
					dsT_EV_JOBHEAD.RowPosition = i;
					document.getElementById("txtPIS_YYMM").focus();
					return false;
				}

				if(!cfDateExpr(oPIS_YYMM) || oPIS_YYMM.trim().length != 7){
					alert("조사년월이  잘못되었습니다.");
					dsT_EV_JOBHEAD.RowPosition = i;
					document.getElementById("txtPIS_YYMM").focus();
					return false;
				}

				oBASIC_YMD = dsT_EV_JOBHEAD.NameValue(i,"BASIC_YMD");
				if(oBASIC_YMD.trim().length == 0){
					alert("기준일자를 입력하세요.");
					dsT_EV_JOBHEAD.RowPosition = i;
					document.getElementById("txtBASIC_YMD").focus();
					return false;
				}

				if(!cfDateExpr(oBASIC_YMD) || oBASIC_YMD.trim().length != 10){
					alert("기준일자가  잘못되었습니다.");
					dsT_EV_JOBHEAD.RowPosition = i;
					document.getElementById("txtBASIC_YMD").focus();
					return false;
				}

				oRSH_DEC = dsT_EV_JOBHEAD.NameValue(i,"RSH_DEC");
				if(oRSH_DEC.toString().trim() == "0"){
					alert("조사내용이  잘못되었습니다." );
					dsT_EV_JOBHEAD.RowPosition = i;
					document.getElementById("cmbRSH_DEC").focus();
					return false;
				}

				oRSHOBJ_01 = dsT_EV_JOBHEAD.NameValue(i,"RSHOBJ_01");
				oRSHOBJ_02 = dsT_EV_JOBHEAD.NameValue(i,"RSHOBJ_02");
				if((oRSHOBJ_01.trim() == "F" || oRSHOBJ_01.trim() == "") &&
					(oRSHOBJ_02.trim() == "F" || oRSHOBJ_02.trim() == "")){
					alert("조사대상을  하나이상 체크하세요." );
					dsT_EV_JOBHEAD.RowPosition = i;
					document.getElementById("chkRSHOBJ_01").focus();
					return false;
				}

				/*
				oEXCEPT_MON = dsT_EV_JOBHEAD.NameValue(i,"EXCEPT_MON");
				if(oEXCEPT_MON.toString().trim() == "0"){
					alert("제외대상이 잘못되었습니다." );
					dsT_EV_JOBHEAD.RowPosition = i;
					document.getElementById("txtEXCEPT_MON").focus();
					return false;
				}
				*/

				oRSHOBJ_01 = dsT_EV_JOBHEAD.NameValue(i,"RSHOBJ_01");
				oRSHOBJ_02 = dsT_EV_JOBHEAD.NameValue(i,"RSHOBJ_02");

				if(oRSHOBJ_01.toString().trim() == "F" && oRSHOBJ_02.toString().trim() == "F"){//아무 근로구분도 선택되지 않으면 않된다.
					alert("하나이상의 근로구분이 선택되어야 합니다." );
					dsT_EV_JOBHEAD.RowPosition = i;
					document.getElementById("txtEXCEPT_MON").focus();
					return false;
				}

			}

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //Grid Style 적용
            cfStyleGrid(form1.grdT_EV_JOBHEAD,0,"false","false");

            fnc_ColEnabled('D');

			//form load시 무조건 조사년월 조회
            var f = document.form1;
			//if (!valid(form1)) return;//Validation 수행
			try {
	            dsT_EV_JOBHEAD.DataID = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba010.cmd.JOBA010CMD&S_MODE=SHR";
	            dsT_EV_JOBHEAD.Reset();
				//마지막 row로 이동
				//dsT_EV_JOBHEAD.RowPosition=dsT_EV_JOBHEAD.CountRow;

				//기준일자를 현재일자로 셋팅
	            //document.getElementById("txtBASIC_YMD").value = getToday();
			} catch ( exception ) {
				fcWindowsXpSp2Notice(false);
				return;
			}
        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        // 체크박스 클릭시 바인딩 데이터 변경
		function checkRSHOBJ() {
			var oRSHOBJ_01 = document.getElementById("chkRSHOBJ_01").checked;

			if(oRSHOBJ_01 == true){//true이면
				document.getElementById("txtRSHOBJ_01").value = "T";
			}else{//false이면
				document.getElementById("txtRSHOBJ_01").value = "F";
			}

			var oRSHOBJ_02 = document.getElementById("chkRSHOBJ_02").checked;

			if(oRSHOBJ_02 == true){//true이면
				document.getElementById("txtRSHOBJ_02").value = "T";
			}else{//false이면
				document.getElementById("txtRSHOBJ_02").value = "F";
			}
		}

		//대상자 선정
		function object_set() {
			//DataSet의 변경 여부 확인
			if (dsT_EV_JOBHEAD.IsUpdated ) {
				alert("먼저 직무이동대상정보를 저장해 주세요.");
		    	return false;
			}

            document.getElementById("viewflag").value = "2";
			document.getElementById("txtSTATUS_JOB").value = "1";
			trT_EV_JOBHEAD.KeyValue = "SVL(I:dsT_EV_JOBHEAD=dsT_EV_JOBHEAD)";
			trT_EV_JOBHEAD.action = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba010.cmd.JOBA010CMD&S_MODE=SAV_01";
			trT_EV_JOBHEAD.post();
            dsT_EV_JOBHEAD.Reset();
			//마지막 row로 이동
			dsT_EV_JOBHEAD.RowPosition=dsT_EV_JOBHEAD.CountRow;

		}

		//대상자 재선정
		function object_reset() {
			//DataSet의 변경 여부 확인
			/*
			if (dsT_EV_JOBHEAD.IsUpdated ) {
				alert("먼저 직무이동대상정보를 저장해 주세요.");
		    	return false;
			}
			*/

            document.getElementById("viewflag").value = "3";
   			document.getElementById("txtSTATUS_JOB").value = "0";
			dsT_EV_JOBHEAD.UserStatus(dsT_EV_JOBHEAD.RowPosition) = "1";//임의로 삽입으로
			trT_EV_JOBHEAD.KeyValue = "SVL(I:dsT_EV_JOBHEAD=dsT_EV_JOBHEAD)";
			trT_EV_JOBHEAD.action = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba010.cmd.JOBA010CMD&S_MODE=SAV_02";
			trT_EV_JOBHEAD.post();
			dsT_EV_JOBHEAD.ResetUserStatus();
			dsT_EV_JOBHEAD.Reset();
			//마지막 row로 이동
			dsT_EV_JOBHEAD.RowPosition=dsT_EV_JOBHEAD.CountRow;
		}

		function object_open() {
			//DataSet의 변경 여부 확인
			if (dsT_EV_JOBHEAD.IsUpdated ) {
				alert("먼저 직무이동대상정보를 저장해 주세요.");
		    	return false;
			}

			if (!confirm("설문open를 하시겠습니까?"))  return;

			document.getElementById("viewflag").value = "";
			document.getElementById("txtSTATUS_JOB").value = "2";
			trT_EV_JOBHEAD.KeyValue = "SVL(I:dsT_EV_JOBHEAD=dsT_EV_JOBHEAD)";
			trT_EV_JOBHEAD.action = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba010.cmd.JOBA010CMD&S_MODE=SAV_03";
			trT_EV_JOBHEAD.post();
            dsT_EV_JOBHEAD.Reset();
			//마지막 row로 이동
			dsT_EV_JOBHEAD.RowPosition=dsT_EV_JOBHEAD.CountRow;
		}

		function object_close() {
			//DataSet의 변경 여부 확인
			if (dsT_EV_JOBHEAD.IsUpdated ) {
				alert("먼저 직무이동대상정보를 저장해 주세요.");
		    	return false;
			}

			if (!confirm("설문close를 하시겠습니까?"))  return;

			document.getElementById("viewflag").value = "";
			document.getElementById("txtSTATUS_JOB").value = "3";
			trT_EV_JOBHEAD.KeyValue = "SVL(I:dsT_EV_JOBHEAD=dsT_EV_JOBHEAD)";
			trT_EV_JOBHEAD.action = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba010.cmd.JOBA010CMD&S_MODE=SAV_04";
			trT_EV_JOBHEAD.post();
            dsT_EV_JOBHEAD.Reset();
			//마지막 row로 이동
			dsT_EV_JOBHEAD.RowPosition=dsT_EV_JOBHEAD.CountRow;
		}


		/***************************************
		 * 입력부의 컬럼의 Disabled 속성 바꿈  *
		 ***************************************/
		function fnc_ColEnabled(prop) {
			// 해당 컬럼의 속성을 Enabled로 변경
			if (prop == 'E') {
				form1.txtPIS_YYMM.disabled   = false;
				form1.txtBASIC_YMD.disabled  = false;
				form1.cmbRSH_DEC.disabled    = false;
				form1.chkRSHOBJ_01.disabled  = false;
				form1.chkRSHOBJ_02.disabled  = false;
				form1.txtEXCEPT_MON.disabled = false;

				document.getElementById("img_HelpOn1").disabled = false;
				document.getElementById("img_HelpOn2").disabled = false;
			}
			// 해당 컬럼의 속성을 Disabled로 변경
			else if (prop == 'D') {
				form1.txtPIS_YYMM.disabled   = true;
				form1.txtBASIC_YMD.disabled  = true;
				form1.cmbRSH_DEC.disabled    = true;
				form1.chkRSHOBJ_01.disabled  = true;
				form1.chkRSHOBJ_02.disabled  = true;
				form1.txtEXCEPT_MON.disabled = true;

				document.getElementById("img_HelpOn1").disabled = true;
                document.getElementById("img_HelpOn2").disabled = true;
			}
		}

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_EV_JOBHEAD                                       |
    | 3. Table List : T_EV_JOBHEAD                                  |
    +----------------------------------------------->
    <Object ID="dsT_EV_JOBHEAD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_EV_JOBHEAD                                         |
    | 3. Table List : T_EV_JOBHEAD                                   |
    +----------------------------------------------->
    <Object ID ="trT_EV_JOBHEAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_EV_JOBHEAD Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			fnc_ColEnabled('D');
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
            fnc_ColEnabled('E');
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_EV_JOBHEAD Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_EV_JOBHEAD Event="OnDataError()">
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[조사년월] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("조사년월에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_EV_JOBHEAD event="OnSuccess()">
	    if(document.getElementById("viewflag").value == "1"){
   			fnc_Message(document.getElementById("resultMessage"), "MSG_01");
	    }else if(document.getElementById("viewflag").value == "2"){
	        alert("대상자 선정이 완료되었습니다.");
	    }else if(document.getElementById("viewflag").value == "3"){
	        alert("대상자 재선정이 완료되었습니다.");
	    }
    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_EV_JOBHEAD event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!---------------------------------+
    | 그리드 조회시 화면설정 변경                |
    +---------------------------------->
    <script language=JavaScript for=dsT_EV_JOBHEAD event=OnRowPosChanged(row)>
	    posChanged(row);
	</script>
	<script language="javascript" >
	function posChanged(row) {
        if(row != 0){
			var oRSHOBJ_01, oRSHOBJ_02, oSTATUS_JOB;

			oRSHOBJ_01 = dsT_EV_JOBHEAD.NameValue(row,"RSHOBJ_01");
			if(oRSHOBJ_01 == "T"){//true이면
				document.getElementById("chkRSHOBJ_01").checked = true;
			}else{//false이면
				document.getElementById("chkRSHOBJ_01").checked = false;
			}

			oRSHOBJ_02 = dsT_EV_JOBHEAD.NameValue(row,"RSHOBJ_02");
			if(oRSHOBJ_02 == "T"){//true이면
				document.getElementById("chkRSHOBJ_02").checked = true;
			}else{//false이면
				document.getElementById("chkRSHOBJ_02").checked = false;
			}

			//작업선택 버튼 활성화 유무
			oSTATUS_JOB = dsT_EV_JOBHEAD.NameValue(row,"STATUS_JOB");
			if(oSTATUS_JOB == "0"){//시작
				document.getElementById("btnSTATUS_JOB1").disabled = false;
				document.getElementById("btnSTATUS_JOB1").className="";
				document.getElementById("btnSTATUS_JOB2").disabled = true;
				document.getElementById("btnSTATUS_JOB2").className="inputDisabled";
				document.getElementById("btnSTATUS_JOB3").disabled = true;
				document.getElementById("btnSTATUS_JOB3").className="inputDisabled";
				document.getElementById("btnSTATUS_JOB4").disabled = true;
				document.getElementById("btnSTATUS_JOB4").className="inputDisabled";
				document.getElementById("txtSTATUS_PRESENT").value="대상자선정을 할 수 있습니다.";
			}else if(oSTATUS_JOB == "1"){//대상자선정 완료
				document.getElementById("btnSTATUS_JOB1").disabled = true;
				document.getElementById("btnSTATUS_JOB1").className="inputDisabled";
				document.getElementById("btnSTATUS_JOB2").disabled = false;
				document.getElementById("btnSTATUS_JOB2").className="";
				document.getElementById("btnSTATUS_JOB3").disabled = false;
				document.getElementById("btnSTATUS_JOB3").className="";
				document.getElementById("btnSTATUS_JOB4").disabled = true;
				document.getElementById("btnSTATUS_JOB4").className="inputDisabled";
				document.getElementById("txtSTATUS_PRESENT").value="대상자선정을 완료하였습니다. 설문 open이 가능합니다.";
			}else if(oSTATUS_JOB == "2"){//설문open 완료
				document.getElementById("btnSTATUS_JOB1").disabled = true;
				document.getElementById("btnSTATUS_JOB1").className="inputDisabled";
				document.getElementById("btnSTATUS_JOB2").disabled = true;
				document.getElementById("btnSTATUS_JOB2").className="inputDisabled";
				document.getElementById("btnSTATUS_JOB3").disabled = true;
				document.getElementById("btnSTATUS_JOB3").className="inputDisabled";
				document.getElementById("btnSTATUS_JOB4").disabled = false;
				document.getElementById("btnSTATUS_JOB4").className="";
				document.getElementById("txtSTATUS_PRESENT").value="설문 open을 하였습니다. 대상자는 설문작성이 가능합니다.";
			}else{//설문close 완료
				document.getElementById("btnSTATUS_JOB1").disabled = true;
				document.getElementById("btnSTATUS_JOB1").className="inputDisabled";
				document.getElementById("btnSTATUS_JOB2").disabled = true;
				document.getElementById("btnSTATUS_JOB2").className="inputDisabled";
				document.getElementById("btnSTATUS_JOB3").disabled = true;
				document.getElementById("btnSTATUS_JOB3").className="inputDisabled";
				document.getElementById("btnSTATUS_JOB4").disabled = true;
				document.getElementById("btnSTATUS_JOB4").className="inputDisabled";

				if(oSTATUS_JOB == ""){
					document.getElementById("txtSTATUS_PRESENT").value="";
				}else{
					document.getElementById("txtSTATUS_PRESENT").value="설문작성을 완료하였습니다.";
				}
			}

			var RowStatus = dsT_EV_JOBHEAD.RowStatus(row);

			if(RowStatus != "1" && oSTATUS_JOB != "0"){
				document.getElementById("txtBASIC_YMD").readOnly = true;
				document.getElementById("txtBASIC_YMD").className="input_ReadOnly";
				document.getElementById("img_HelpOn2").style.display = "none";
				document.getElementById("cmbRSH_DEC").disabled = true;
				document.getElementById("cmbRSH_DEC").className="input_ReadOnly";
				document.getElementById("chkRSHOBJ_01").disabled = true;
				document.getElementById("chkRSHOBJ_01").className="input_ReadOnly";
				document.getElementById("chkRSHOBJ_02").disabled = true;
				document.getElementById("chkRSHOBJ_02").className="input_ReadOnly";
				document.getElementById("txtEXCEPT_MON").readOnly = true;
				document.getElementById("txtEXCEPT_MON").className="input_ReadOnly";
			}else{
				document.getElementById("txtBASIC_YMD").readOnly = false;
				document.getElementById("txtBASIC_YMD").className="";
				document.getElementById("img_HelpOn2").style.display = "";
				document.getElementById("cmbRSH_DEC").disabled = false;
				document.getElementById("cmbRSH_DEC").className="";
				document.getElementById("chkRSHOBJ_01").disabled = false;
				document.getElementById("chkRSHOBJ_01").className="";
				document.getElementById("chkRSHOBJ_02").disabled = false;
				document.getElementById("chkRSHOBJ_02").className="";
				document.getElementById("txtEXCEPT_MON").readOnly = false;
				document.getElementById("txtEXCEPT_MON").className="";
			}

			//신규이면 조사년월 입력 활성화
			if(RowStatus == "1"){
				document.getElementById("txtPIS_YYMM").readOnly = false;
				document.getElementById("txtPIS_YYMM").className="";
				document.getElementById("img_HelpOn1").style.display = "";
			}else{
				document.getElementById("txtPIS_YYMM").readOnly = true;
				document.getElementById("txtPIS_YYMM").className="input_ReadOnly";
				document.getElementById("img_HelpOn1").style.display = "none";
			}

			//제외인원 표시
			var oTOTAL_CNT = document.getElementById("txtTOTAL_CNT").value;
			var oOBJECT_CNT = document.getElementById("txtOBJECT_CNT").value;
			document.getElementById("txtEXCEPT_CNT").value = oTOTAL_CNT - oOBJECT_CNT;

		}
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
<input type="hidden" id="txtRSHOBJ_01">
<input type="hidden" id="txtRSHOBJ_02">
<input type="hidden" id="txtSTATUS_JOB">
<input type="hidden" id="viewflag">

<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">직무이동대상자설정</td>
					<td align="right" class="navigator">HOME/직무이동/직무이동작업/<font color="#000000">직무이동대상자설정</font></td>
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
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()"></a>  -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
            <table width="800" border="0" cellspacing="0" cellpadding="0">
	            <tr>
	                <td>
			            <!-- 조건 입력 테이블 시작 -->
				        <table width="800" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				        	<colgroup>
				        		<col width="90"></col>
				        		<col width="100"></col>
				        		<col width="90"></col>
				        		<col width="120"></col>
				        		<col width="90"></col>
				        		<col width=""></col>
				        	</colgroup>
				        	<tr>
				        		<td align="center" class="creamBold">조사년월</td>
				        		<td class="padding2423">
			                        <input id="txtPIS_YYMM" size="7" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
			                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM','','150','138');"></a>
				        		</td>
				        		<td align="center" class="creamBold">기준일자</td>
				        		<td class="padding2423">
					        		<input id="txtBASIC_YMD" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
			                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtBASIC_YMD','','315','138');"></a>
				        		</td>
				        		<td align="center" class="creamBold">조사내용</td>
	                            <td class="padding2423">
	                                <select id="cmbRSH_DEC" style="width:100%">
										<option value="1" >직무이동+자기신고</option>
	                                    <option value="2" >직무이동</option>
	                                    <option value="3" >자기신고</option>
	                                </select>
	                            </td>
				        	</tr>
	                        <tr>
				        		<td align="center" class="creamBold">조사대상</td>
				        		<td class="padding2423" colspan="3">
				        		    <input type="checkbox" id="chkRSHOBJ_01" value="yes" style="border:0" align="absmiddle" onclick="checkRSHOBJ();">사무직
				        		    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				        		    <input type="checkbox" id="chkRSHOBJ_02" value="yes" style="border:0" align="absmiddle" onclick="checkRSHOBJ();">택배직
				        		</td>
				        		<td align="center" class="creamBold">제외대상</td>
				        		<td class="padding2423"><input id="txtEXCEPT_MON" size="2" maxlength="2" style="text-align:right" onkeypress="cfNumberCheck();"> 개월이내 입사자</td>
				        	</tr>
							<tr>
				        		<td align="center" class="creamBold">대상인원</td>
				        		<td colspan="5">
	                                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	                                    <colgroup>
	                                        <col width="80"></col>
	                                        <col width="150"></col>
	                                        <col width="50"></col>
	                                        <col width="150"></col>
	                                        <col width="50"></col>
	                                        <col width=""></col>
	                                    </colgroup>
	                                    <tr>
				        		            <td align="right">총 원&nbsp;</td>
				        		            <td ><input id="txtTOTAL_CNT" size="4"  maxlength="4"  class="input_ReadOnly" readonly> 명</td>
				        		            <td align="right">대 상&nbsp;</td>
				        		            <td ><input id="txtOBJECT_CNT" size="4"  maxlength="4"  class="input_ReadOnly" readonly> 명</td>
				        		            <td align="right">제 외&nbsp;</td>
				        		            <td ><input id="txtEXCEPT_CNT" size="4"  maxlength="4"  class="input_ReadOnly" readonly> 명</td>
				        		        <tr>
				        		    </table>
				        		</td>
	                        </tr>
	                        <tr>
				        		<td align="center" class="creamBold">현재상태</td>
				        		<td  class="padding2423" colspan="5"><input id="txtSTATUS_PRESENT" style="width:100%"  class="input_ReadOnly" readonly></td>
				            </tr>
				        </table>
				        <!-- 조건 입력 테이블 끝 -->
				    </td>
				</tr>
			</table>
		</td>
    <tr>
        <td>
            <table width="800" border="0" cellspacing="0" cellpadding="0">
	            <tr>
	                <td class="paddingTop8">
	                    <table width="800" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	                        <colgroup>
	                            <col width="200"></col>
	                            <col width="200"></col>
	                            <col width="200"></col>
	                            <col width=""></col>
	                        </colgroup>
	                        <tr>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnSTATUS_JOB1"  style="cursor:hand" value=" 대상자선정 " onclick="object_set();">
	                            </td>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnSTATUS_JOB2"  style="cursor:hand" value=" 재작업 " onclick="object_reset();">
	                            </td>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnSTATUS_JOB3" style="cursor:hand" value=" 설문OPEN " onclick="object_open();">
	                            </td>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnSTATUS_JOB4" style="cursor:hand" value="설문CLOSE"onclick="object_close();">
	                            </td>
	                        </tr>
	                    </table>
	                <td>
	            </tr>
            </table>
        </td>
	</tr>
</table>

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

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		    <!-- 내용 조회 그리드 테이블 시작-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_EV_JOBHEAD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:200px;">
                            <param name="DataID"						value="dsT_EV_JOBHEAD">
                            <param name="EdiTABLE"				value="false">
                            <param name="DragDropEnable"		value="true">
                            <param name="SortView"					value="Left">
                            <param name="VIEWSUMMARY"		value=0>
							<param name="IndWidth"                  value=0>
                            <param name="Format"						value="
								<C> id='{CUROW}'			width=49		name='순번'				align=center		value={String(Currow)}																												</C>
								<C> id='PIS_YYMM'			width=95		name='조사년월'		align=center																																							</C>
								<C> id='BASIC_YMD'			width=95		name='기준일자'		align=center																																							</C>
								<C> id='RSH_DEC'			width=180		name='조사내용'		align=center		value={Decode(RSH_DEC,1,'직무이동+자기신고',2,'직무이동',3,'자기신고')}									</C>
								<C> id='OBJECT'				width=180		name='조사대상'		align=center		value={Decode(RSHOBJ_01&RSHOBJ_02,'TT','사무직+택배직','TF','사무직','FT','택배직','FF','')}	</C>
								<C> id='EXCEPT_MON'		width=180		name='제외대상'		align=center		value={EXCEPT_MON&'개월이내 입사자'}																						</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			<!-- 내용 조회 그리드 테이블 끝 -->
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
    | 2. 이름 : bndT_EV_JOBHEAD                                   |
    | 3. Table List : T_EV_JOBHEAD                                 |
    +----------------------------------------------->
	<object id="bndT_EV_JOBHEAD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_EV_JOBHEAD">
		<Param Name="BindInfo", Value="
			<C>Col='PIS_YYMM'				Ctrl='txtPIS_YYMM'				Param=value</C>
			<C>Col='BASIC_YMD'			Ctrl='txtBASIC_YMD'				Param=value</C>
			<C>Col='RSH_DEC'				Ctrl='cmbRSH_DEC'				Param=value</C>
			<C>Col='RSHOBJ_01'			Ctrl='txtRSHOBJ_01'				Param=value</C>
			<C>Col='RSHOBJ_02'			Ctrl='txtRSHOBJ_02'				Param=value</C>
			<C>Col='EXCEPT_MON'		Ctrl='txtEXCEPT_MON'			Param=value</C>
			<C>Col='TOTAL_CNT'			Ctrl='txtTOTAL_CNT'				Param=value</C>
			<C>Col='OBJECT_CNT'			Ctrl='txtOBJECT_CNT'			Param=value</C>
			<C>Col='STATUS_JOB'			Ctrl='txtSTATUS_JOB'			Param=value</C>
	    ">
	</object>
