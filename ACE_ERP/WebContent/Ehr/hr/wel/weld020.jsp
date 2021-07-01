<!--
***********************************************************************
* @source      : weld020.jsp
* @description : 콘도이용신청 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/12/07      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    String CON_AUTHO    = box.getString("SESSION_CON_AUTHO");

    //관리자인지 아닌지 여부
    boolean isMaster = false;

    if(CON_AUTHO.equals("M")) {
        isMaster = true;
    }
%>

<html>
<head>
<title>콘도이용신청(weld020)</title>
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

		var btnList = 'TTTTFFTT';
		var cn_cd = '';
		var rst_temp = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var str_ymd = document.getElementById('txtSTR_YMD_SHR').value;
			var end_ymd = document.getElementById('txtEND_YMD_SHR').value;
			var rsv_gbn = document.getElementById("cmbRSV_GBN_SHR").value;
			var eno_no  = document.getElementById("txtENO_NO_SHR").value;

			dsT_WL_CONDOUSE.dataid  = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld020.cmd.WELD020CMD"
                                    + "&S_MODE=SHR"
                                    + "&STR_YMD="+str_ymd
                                    + "&END_YMD="+end_ymd
                                    + "&RSV_GBN="+rsv_gbn
                                    + "&ENO_NO="+eno_no;
    		dsT_WL_CONDOUSE.reset();

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

			if(!fnc_SaveItemCheck()) return;	//유효성 체크

			for(i=1;i<dsT_WL_CONDOUSE.CountRow+1;i++){
				if(rst_temp == '2' && dsT_WL_CONDOUSE.NameValue(i,'RST_GBN') == '3'){
					dsT_WL_CONDOUSE.NameValue(i,'RST_GBN') = '4';
				}
			}
			trT_WL_CONDOUSE.KeyValue = "tr01(I:dsT_WL_CONDOUSE=dsT_WL_CONDOUSE)";
			trT_WL_CONDOUSE.action = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld020.cmd.WELD020CMD&S_MODE=SAV";
			trT_WL_CONDOUSE.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

			if(dsT_WL_CONDOUSE.CountRow < 1) {
				alert("삭제할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}

            if(dsT_WL_CONDOUSE.NameValue(dsT_WL_CONDOUSE.RowPosition,'RST_GBN') == '7'){
                alert("담당자가 접수하여 처리중인 자료이므로 삭제가 불가능합니다.");
                return;
            }

			if(dsT_WL_CONDOUSE.NameValue(dsT_WL_CONDOUSE.RowPosition,'RSV_GBN') != '1' && dsT_WL_CONDOUSE.NameValue(dsT_WL_CONDOUSE.RowPosition,'RSV_GBN') != '2'){
				alert("예약상황이 신청, 취소일때만 삭제가 가능합니다.");
				return;
			}

			if(confirm("[지역:"+dsT_WL_CONDOUSE.NameValue(dsT_WL_CONDOUSE.RowPosition,'CO_NM')+"/이용시작일:"+dsT_WL_CONDOUSE.NameValue(dsT_WL_CONDOUSE.RowPosition,'STR_YMD')+"]의 정보를 삭제하시겠습니까?")){
				dsT_WL_CONDOUSE.DeleteRow(dsT_WL_CONDOUSE.RowPosition);
				trT_WL_CONDOUSE.KeyValue = "tr01(I:dsT_WL_CONDOUSE=dsT_WL_CONDOUSE)";
				trT_WL_CONDOUSE.action = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld020.cmd.WELD020CMD&S_MODE=DEL";
				trT_WL_CONDOUSE.post();
			}

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

			//DataSet에 Header가 정의되어 있지 않는 경우
			if(dsT_WL_CONDOUSE.CountColumn < 1){
				// 데이터셋의 헤더 정보 설정.
				dsT_WL_CONDOUSE.setDataHeader("ENO_NO:STRING, ENO_NM:STRING, STR_YMD:STRING:KEYVALUE, CN_CD:STRING, CO_CD:STRING, STAY_CNT:STRING, ROOM_CNT:STRING, RSV_GBN:STRING, RSV_NO:STRING, RST_GBN:STRING, SEASON_GBN:STRING, EXT_01:STRING, EXT_02:STRING, EXT_03:STRING, ENO_TEL:STRING");
			}
			document.getElementById('cmbCN_CD').disabled = false;
			document.getElementById('cmbCO_CD').disabled = false;
			document.getElementById('cmbSTAY_CNT').disabled = false;
        	document.getElementById('txtROOM_CNT').className = "";
			document.getElementById('txtROOM_CNT').readOnly = false;
			document.getElementById('txtENO_TEL').className = "";
			document.getElementById('txtENO_TEL').readOnly = false;

			dsT_WL_CONDOUSE.AddRow();
			dsT_WL_CONDOUSE.NameValue(dsT_WL_CONDOUSE.RowPosition, 'RSV_GBN') = '1';
			document.rdoRSV_GBN.Enable = "false";
			document.getElementById('cmbRST_GBN').value = "";
			document.getElementById('cmbRST_GBN').disabled = true;

            document.getElementById("txtENO_NO").value = "<%=box.get("SESSION_ENONO") %>";
            document.getElementById("txtENO_NM").value = "<%=box.get("SESSION_ENONM") %>";
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
			document.getElementById("resultMessage").innerText = ' ';

			document.rdoRSV_GBN.CodeValue = "";
			document.rdoRSV_GBN.Enable = "false";

			dsT_WL_CONDOUSE.ClearData();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_WL_CONDOUSE.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

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

			if (!dsT_WL_CONDOUSE.IsUpdated ) {
				alert("저장할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}

            var oSTR_YMD;

			var str;
			var end;
			var str_ymd;
			var end_ymd;
			var term;

			//입력한 콘도 이용일이 성수기에 포함되는지 확인
			for(i=1;i<dsT_WL_CONDOUSE.CountRow+1;i++){
				if(dsT_WL_CONDOUSE.RowStatus(i) == 1){
                    oSTR_YMD    = document.getElementById("txtSTR_YMD");

                    str = removeChar(dsT_WL_CONDOUSE.NameValue(i,'STR_YMD'), '-');
                    end = cfGetDate(str, dsT_WL_CONDOUSE.NameValue(i,'STAY_CNT'), '0');

					str_ymd = dsT_WL_CONDOSSN.NameValue(0,'STR_YMD');
					end_ymd = dsT_WL_CONDOSSN.NameValue(0,'END_YMD');
					if((str>=str_ymd && str<=end_ymd)
                            || (end>=str_ymd && end<=end_ymd)){
						alert("성수기 기간("+str_ymd+"~"+end_ymd+")이라 콘도이용신청을 하실 수 없습니다.\n성수기콘도신청을 이용해 주세요.");

						dsT_WL_CONDOUSE.RowPosition = i;
                        oSTR_YMD.value = "";
                        oSTR_YMD.focus();
						return false;
					}
				}
			}

			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//콘도
            for( var i = 1; i <= dsCOMMON_CN.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_CN.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_CN.NameValue(i,"CODE_NAME");
                document.getElementById("cmbCN_CD").add(oOption);

            }

            cfStyleGrid(form1.grdT_WL_CONDOUSE,15,"false","false");      // Grid Style 적용

            document.rdoRSV_GBN.CodeValue = "";
            document.rdoRSV_GBN.Enable = "false";

            document.getElementById('txtSTR_YMD_SHR').value = getStrDate();
            document.getElementById('txtEND_YMD_SHR').value = getEndDate();
            document.getElementById('txtSTR_YMD_SHR').focus();

            document.getElementById("txtENO_NO_SHR").value = "<%=box.get("SESSION_ENONO") %>";
            document.getElementById("txtENO_NM_SHR").value = "<%=box.get("SESSION_ENONM") %>";
<%
    //관리자가 아닐 경우 타인은 조회가 되지 않게
    if(!isMaster) {
%>
                fnc_ChangeStateElement(false, "txtENO_NO_SHR");
                fnc_ChangeStateElement(false, "txtENO_NM_SHR");
                fnc_ChangeStateElement(false, "ImgEnoNoShr");
<%
    }
%>


            //입력창 사용 못하게 막기
            fnc_DisableElementAll(elementList);

            //성수기 기간 조회
			dsT_WL_CONDOSSN.DataID = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld020.cmd.WELD020CMD&S_MODE=SHR_02";
			dsT_WL_CONDOSSN.Reset();

            //콘도 리스트 전체 조회
            dsT_CM_COMMON_CP.DataID = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld020.cmd.WELD020CMD&S_MODE=SHR_01";
            dsT_CM_COMMON_CP.Reset();
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/*********************************
         * 16. cmbCN_CD onChange시 처리  *
         ********************************/
		function fnc_changeCN_CD() {

			var cn_cd = document.getElementById('cmbCN_CD').value;

			dsT_CM_COMMON.DataID = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld020.cmd.WELD020CMD&S_MODE=SHR_01&COMM_CD="+cn_cd;
			dsT_CM_COMMON.Reset();

		}

		/*********************************
         * 17. cmbCO_CD onChange시 처리  *
         ********************************/
		function fnc_changeCO_CD() {

			var row = document.getElementById('cmbCO_CD').selectedIndex + 1;
			var position = dsT_WL_CONDOUSE.RowPosition;

		}

        //입력창 리스트
        var elementList = new Array(     "txtSTR_YMD"
                                        ,"imgSTR_YMD"
                                        ,"cmbCN_CD"
                                        ,"cmbCO_CD"
                                        ,"cmbSTAY_CNT"
                                        ,"txtROOM_CNT"
                                        ,"rdoRSV_GBN"
                                        ,"cmbRST_GBN"
                                        ,"txtENO_TEL"
                                        ,"txtSTR_YMD"
                                        ,"txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo"     );

        var exceptionList = new Array(   "txtSTR_YMD"
                                        ,"imgSTR_YMD"
                                        ,"txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo"     );

        var keyList = new Array(         "txtENO_NO"
                                        ,"txtSTR_YMD"
                                        ,"cmbCN_CD"
                                        ,"cmbCO_CD"
                                        ,"cmbSTAY_CNT"  );

        /**
         * 콘도 이용 날짜 비교
         */
        function checkCondoDate() {
            var oSTR_YMD    = document.getElementById("txtSTR_YMD");
            var oSTAY_CNT   = document.getElementById("cmbSTAY_CNT");

            var rsv_gbn = document.getElementById("rdoRSV_GBN").value;
            var str = removeChar(oSTR_YMD.value, "-");
            var end = cfGetDate(str,oSTAY_CNT.value,'0');

            //상태가 신청 상태이고
            if(rsv_gbn == "1"
                    && str != ""
                    && dsT_WL_CONDOSSN.CountRow == 1) {
                var str_ymd = dsT_WL_CONDOSSN.NameString(0, "STR_YMD");
                var end_ymd = dsT_WL_CONDOSSN.NameString(0, "END_YMD");

                if((str >= str_ymd && str <= end_ymd)
                        || (end >= str_ymd && end <= end_ymd)) {
                    alert(str_ymd+"~"+end_ymd+" 까지는 콘도 성수기 기간입니다.\n이 기간중 콘도 이용자는 성수기 콘도 신청 메뉴를 이용하시기 바랍니다.");
                    oSTR_YMD.value = "";
                    oSTR_YMD.focus();
                    return false;
                }
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

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_WL_CONDOUSE) |
    | 3. 사용되는 Table List(T_WL_CONDOUSE)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_CONDOUSE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CM_COMMON)   |
    | 3. 사용되는 Table List(T_CM_COMMON)		     |
    +------------------------------------------------>
    <Object ID="dsT_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------+
    | 1. 카피용 DataSet                                 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CM_COMMON_CP)|
    +------------------------------------------------>
    <Object ID="dsT_CM_COMMON_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_WL_CONDOSSN) |
    | 3. 사용되는 Table List(T_WL_CONDOSSN)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_CONDOSSN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_WL_CONDOUSE)	|
    | 3. 사용되는 Table List(T_WL_CONDOUSE)	            |
    +--------------------------------------------------->
    <Object ID ="trT_WL_CONDOUSE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 콘도 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_CN"/>
       <jsp:param name="CODE_GUBUN"    value="CN"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_WL_CONDOUSE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_WL_CONDOUSE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_CONDOUSE Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[이용시작일] 입력 후 다음 작업이 가능합니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_WL_CONDOSSN Event="OnLoadCompleted(iCount)">
        if(iCount == 1) {
            var today   = getToday().replace(/-/g, "");
            var str_ymd = dsT_WL_CONDOSSN.NameString(0, "STR_YMD");
            var end_ymd = dsT_WL_CONDOSSN.NameString(0, "END_YMD");

            //성수기 기간인지 아닌지 알림
            if(today >= str_ymd && today <= end_ymd) {
                alert(str_ymd+"~"+end_ymd+" 까지는 콘도 성수기 기간입니다.\n이 기간중 콘도 이용자는 성수기 콘도 신청 메뉴를 이용하시기 바랍니다.");
            }
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_WL_CONDOSSN Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_COMMON Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("해당 콘도에 등록된 지역이 없습니다!");

        } else {

			var obj = document.getElementById("cmbCO_CD");
			//기존의 목록 clear
             for (i=0; i<obj.options.length; i++ ) {
                obj.options[i] = null;
             }
             obj.options.length = 0 ;

			//지역
            for( i = 1; i <= dsT_CM_COMMON.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON.NameValue(i,"COMM_CD");
                oOption.text  = dsT_CM_COMMON.NameValue(i,"COMM_NM");
                document.getElementById("cmbCO_CD").add(oOption);

            }

			fnc_changeCO_CD();
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_COMMON Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_WL_CONDOUSE event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_WL_CONDOUSE event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_WL_CONDOUSE event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        if(row > 0) {

            //신규일 경우
            if(dsT_WL_CONDOUSE.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);

                //예약결과는 차후 수정가능
                fnc_ChangeStateElement(false, "cmbRST_GBN");

<%
    //관리자가 아닐 경우 타인 등록이 되지 않게
    if(!isMaster) {
%>
                fnc_ChangeStateElement(false, "txtENO_NO");
                fnc_ChangeStateElement(false, "txtENO_NM");
                fnc_ChangeStateElement(false, "ImgEnoNo");
<%
    }
%>
            }
            //결과값이 미회신일때만 수정 가능
            else if(dsT_WL_CONDOUSE.NameString(row, "RST_GBN") == "1"
                    && dsT_WL_CONDOUSE.NameString(row, "RSV_GBN") == "1") {
                fnc_EnableElementAll(elementList, exceptionList);

                //예약결과는 차후 수정가능
                fnc_ChangeStateElement(false, "cmbRST_GBN");
            }
            //신청상태가 예약이 확정 되면 예약결과의 확인, 취소 선택이 가능하게 된다.
            else if(dsT_WL_CONDOUSE.NameString(row, "RST_GBN") == "1"
                    && dsT_WL_CONDOUSE.NameString(row, "RSV_GBN") == "3") {
                fnc_ChangeStateElement(true, "cmbRST_GBN");
            }

            //콘도에 해당하는 지역코드를 설정한다.
            bndT_WL_CONDOUSE.ActiveBind = false;
            fnc_changeCN_CD();
            document.getElementById("cmbCO_CD").value = dsT_WL_CONDOUSE.NameString(row, "CO_CD");
            bndT_WL_CONDOUSE.ActiveBind = true;
        }
    </script>

    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_WL_CONDOUSE event=CanRowPosChange(row)>
        var keyName;
        var colName;

        if(row > 0) {
            for(var i=0; i<keyList.length; i++) {
                keyName = keyList[i];
                colName = keyName.substring(3, keyName.length);

                if (dsT_WL_CONDOUSE.NameString(row, colName) == "" ) {
                    alert("[ " + grdT_WL_CONDOUSE.GetHdrDispName('-3', colName) + " ]은(는) 필수 입력사항입니다");
                    document.getElementById(keyName).focus();
                    return false;
                }
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

<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">콘도이용신청</td>
					<td align="right" class="navigator">HOME/복리후생/콘도/<font color="#000000">콘도이용신청</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="70"></col>
									<col width="220"></col>
									<col width="70"></col>
									<col width="120"></col>
                                    <col width="70"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">신청일&nbsp;</td>
								<td class="padding2423">
									<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','55','110');"></a> ~
									<input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','170','110');"></a>
								</td>
								<td align="right" class="searchState">예약상황&nbsp;</td>
								<td class="padding2423">
									<select id="cmbRSV_GBN_SHR" style="width:80" onChange="fnc_SearchList();">
										<option value="" >전체</option>
										<option value="1" >신청</option>
	                                    <option value="2" >취소</option>
	                                    <option value="3" >예약</option>
									</select>
								</td>
                                <td align="right" class="searchState">사원번호&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');"onchange= "fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" style="ime-mode:disabled">
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

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="125"></col>
					<col width="80"></col>
					<col width="125"></col>
					<col width="100"></col>
					<col width="*"></col>
				</colgroup>
                <tr>
                    <td align="center" class="creamBold">신청자</td>
                    <td class="padding2423" colspan="5">
                        <input id="txtENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNm('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD');"onchange= "fnc_GetCommonEnoNm('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD');" style="ime-mode:disabled">
                        <input id="txtENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNo('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD');"></a>
                    </td>
                </tr>
				<tr>
                    <td align="center" class="creamBold">이용시작일</td>
                    <td class="padding2423">
                        <input id="txtSTR_YMD" size="10" maxLength="10" onblur="fnc_CheckDate(this);checkCondoDate();" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="if(txtSTR_YMD.disabled == true) return; calendarBtn('datetype1','txtSTR_YMD','','540','152');"></a>
                    </td>
					<td align="center" class="creamBold">콘&nbsp;&nbsp;도</td>
					<td class="padding2423">
						<select id="cmbCN_CD" style="WIDTH:100" onChange="fnc_changeCN_CD();">
						</select>
					</td>
					<td align="center" class="creamBold">지&nbsp;&nbsp;역</td>
					<td class="padding2423">
						<select id="cmbCO_CD" style="WIDTH:220" onChange="fnc_changeCO_CD();">
						</select>
					</td>
				</tr>
                <tr>
                    <td align="center" class="creamBold">이용박수</td>
                    <td class="padding2423">
                        <select id="cmbSTAY_CNT" style="WIDTH:40">
                            <option value="1" >1</option>
                            <option value="2" >2</option>

                        </select>
                    </td>

					<td align="center" class="creamBold">객실수</td>
					<td class="padding2423">
						<input id="txtROOM_CNT" size="5" maxLength="2" onkeypress="cfCheckNumber2();" style="ime-mode:disabled">
					</td>
                    <td align="center" class="creamBold">연락처</td>
                    <td class="padding2423">
                        <input id="txtENO_TEL" size="20" maxLength="20">
                    </td>
                </tr>
                <tr>
					<td align="center" class="creamBold">콘도신청</td>
					<td class="padding2423" colspan="3">
                        <comment id="__NSID__">
						<object id=rdoRSV_GBN classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0
									style="height:20; width:100">
							<param name=AutoMargin	value="false">
							<param name=DataID      value="dsT_WL_CONDOUSE">
							<param name=CodeColumn  value="RSV_GBN">
							<param name=Cols		value="2">
							<param name=Format		value="1^신청,2^취소">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>

					</td>
					<td align="center" class="creamBold">예약결과확인</td>
					<td class="padding2423">
                        <table>
                            <tr>
                                <td>
            						<select id="cmbRST_GBN" style="WIDTH:70">
            							<option value="1"></option>
            							<option value="2">확정</option>
            							<option value="3">취소</option>
            						</select>
                                </td>
								<td>
									&nbsp;<input id="txtRSV_NO" size="23" class="input_ReadOnly" readonly>
								</td>
							</tr>
						</table>
					</td>

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
						<object	id="grdT_WL_CONDOUSE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"					value="dsT_WL_CONDOUSE">
							<param name="Format"					value="
								<C> id={currow}		width=30    name='NO'			align=center </C>
                                <C> id='ENO_NO'     width=65    name='사번'             align=center        Edit=None       </C>
                                <C> id='ENO_NM'     width=65    name='성명'             align=center        Edit=None       </C>
								<C> id='CN_CD'		width=70	name='콘도'			align=center EditStyle=Lookup  Data='dsCOMMON_CN:CODE:CODE_NAME'</C>
								<C> id='CO_CD'		width=200	name='지역'			align=left EditStyle=Lookup  Data='dsT_CM_COMMON_CP:COMM_CD:COMM_NM'</C>
								<C> id='STR_YMD'	width=75	name='이용시작일'	align=center </C>
								<C> id='STAY_CNT'	width=55	name='이용박수'		align=right </C>
								<C> id='ROOM_CNT'	width=45	name='객실수'		align=right </C>
								<C> id='RSV_GBN'	width=60	name='신청상태'		align=center Value={Decode(RSV_GBN, '1', '신청', '2', '취소', '3', '예약')}</C>
								<C> id='RST_GBN'	width=60	name='예약결과'		align=center Value={Decode(RST_GBN, '1', '', '2', '확정', '3', '취소', '6', '미당첨', '7','처리중','')} </C>
								<C> id='ENO_TEL'	width=90	name='연락처'   	align=left </C>
								<C> id='SEASON_GBN'	width=70	name='성수기구분'	align=center value={DECODE(SEASON_GBN, '1', '비성수기', '2', '성수기')}</C>
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
**************************************************************
-->
<!-- KPI Pool 설정 테이블 -->
<object id="bndT_WL_CONDOUSE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_WL_CONDOUSE">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NO 		Ctrl=txtENO_NO	      	Param=value		</C>
		<C>Col=ENO_NM 		Ctrl=txtENO_NM	      	Param=value		</C>
		<C>Col=STR_YMD		Ctrl=txtSTR_YMD	      	Param=value		</C>
		<C>Col=CN_CD    	Ctrl=cmbCN_CD	     	Param=value		</C>
		<C>Col=CO_CD		Ctrl=cmbCO_CD	      	Param=value		</C>
		<C>Col=STAY_CNT		Ctrl=cmbSTAY_CNT      	Param=value		</C>
		<C>Col=ROOM_CNT		Ctrl=txtROOM_CNT     	Param=value		</C>
		<C>Col=RSV_GBN		Ctrl=rdoRSV_GBN	     	Param=value		</C>
		<C>Col=RSV_NO		Ctrl=txtRSV_NO	     	Param=value		</C>
		<C>Col=RST_GBN		Ctrl=cmbRST_GBN     	Param=value		</C>
		<C>Col=ENO_TEL		Ctrl=txtENO_TEL     	Param=value		</C>

    '>
</object>