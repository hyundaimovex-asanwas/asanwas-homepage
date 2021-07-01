<!--
    ************************************************************************************
    * @Source         : vlua050.jsp                                                    *
    * @Description    : 역량평가 항목설정.                                             *
    * @Font           : 굴림체, 9Font 사용하시고 Tab은 Space 4Byte로 처리 해 주세요!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/20  |  안준성   | 최초작성                                               *
    * 2007/03/15  |  박인이   | 수정. (직무평가업무내용 추가)                          *
    ************************************************************************************
-->

<%@ page contentType="text/html;charset=euc-kr"%>
<%@ include file="/common/sessionCheck.jsp"%>

<!-- Potential의 기능을 사용하기 위해서는 반드시 페이지의 상단 부분에 정의가 되어져 있어야 한다. -->
<script>var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame 초기화 실패");}</script>

<html>

    <head>
    <title>역량평가항목설정(vlua050)</title>
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

        var year = getToday().substring(0,4);
        var btnList = 'TTTTFFTT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            if( !fnc_SearchItemCheck() ) return;

            //데이터셋 전송
            dsT_EV_ESTITEM.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua050.cmd.VLUA050CMD&S_MODE=SHR&GUBUN="+document.getElementById("txtGUBUN").value+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value+"&EVL_FRQ="+document.getElementById("cmbEVL_FRQ_SHR").value+"&GROUP_CD="+document.getElementById("cmbGROUP_CD_SHR").value+"&EST_CD="+document.getElementById("cmbEST_CD_SHR").value;
            dsT_EV_ESTITEM.Reset();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //데이터셋 전송(평가구조설정정보 조회)
            dsT_EV_TYPE.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua060.cmd.VLUA060CMD&S_MODE=SHR_01&GUBUN="+document.getElementById("txtGUBUN").value+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value;
            dsT_EV_TYPE.Reset();

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

            if( !fnc_SaveItemCheck() )     return;

            //트랜잭션 전송
            trT_EV_ESTITEM.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua050.cmd.VLUA050CMD&S_MODE=SAV";
            trT_EV_ESTITEM.Post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            fnc_Remove();

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

            if (document.form1.cmbEVL_YY_SHR.value != year) {

                alert("해당년도 이외의 자료는 신규 생성 할 수 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_07');
                document.form1.cmbEVL_YY_SHR.focus();
                return;

            }

            if( !fnc_SearchItemCheck() ) return;

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_EV_ESTITEM.CountColumn == 0) {
                dsT_EV_ESTITEM.setDataHeader("GUBUN:STRING, EVL_YY:STRING, EVL_FRQ:INT, COMM_CD1:STRING, GROUP_CD:STRING, COMM_CD2:STRING, EST_CD:STRING, ABL_CD:STRING, ABL_NM:STRING, WEIGHT:INT, SUBITEM_01:STRING, SUBITEM_02:STRING, SUBITEM_03:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_EV_ESTITEM.AddRow();

            dsT_EV_ESTITEM.NameValue(dsT_EV_ESTITEM.RowPosition,"GUBUN")    = form1.txtGUBUN.value;
            dsT_EV_ESTITEM.NameValue(dsT_EV_ESTITEM.RowPosition,"EVL_YY")   = form1.cmbEVL_YY_SHR.value;
            dsT_EV_ESTITEM.NameValue(dsT_EV_ESTITEM.RowPosition,"EVL_FRQ")  = form1.cmbEVL_FRQ_SHR.value;

            // 인사평가
            if (GUBUN == "01") {
                dsT_EV_ESTITEM.NameValue(dsT_EV_ESTITEM.RowPosition,"COMM_CD1") = "EG";
            }
            // 직무평가
            else if (GUBUN == "02") {
                dsT_EV_ESTITEM.NameValue(dsT_EV_ESTITEM.RowPosition,"COMM_CD1") = "4";
            }

            dsT_EV_ESTITEM.NameValue(dsT_EV_ESTITEM.RowPosition,"GROUP_CD") = form1.cmbGROUP_CD_SHR.value;
            dsT_EV_ESTITEM.NameValue(dsT_EV_ESTITEM.RowPosition,"COMM_CD2") = "EA";
            dsT_EV_ESTITEM.NameValue(dsT_EV_ESTITEM.RowPosition,"EST_CD")   = form1.cmbEST_CD_SHR.value;

            form1.grdT_EV_ESTITEM.Draw = false;
            form1.grdT_EV_ESTITEM.RowPosition    = dsT_EV_ESTITEM.RowPosition;
            form1.grdT_EV_ESTITEM.ColumnPosition = "ABL_CD";
            form1.grdT_EV_ESTITEM.Draw = true;

            form1.grdT_EV_ESTITEM.Focus();

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

            //Row상태값
            var status = 0;

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_EV_ESTITEM.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }

            if (document.form1.cmbEVL_YY_SHR.value != year) {
                alert("해당년도 이외의 자료는 삭제 할 수 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_08');
                document.form1.cmbEVL_YY_SHR.focus();
                return;
            }

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("코드[" + dsT_EV_ESTITEM.NameValue(dsT_EV_ESTITEM.RowPosition,'ABL_CD') + "]를 삭제하시겠습니까?") == false) return;

            status = dsT_EV_ESTITEM.RowStatus(dsT_EV_ESTITEM.RowPosition);
            dsT_EV_ESTITEM.DeleteRow(dsT_EV_ESTITEM.RowPosition);

            if( status != 1 ) {
                //트랜잭션 전송
                trT_EV_ESTITEM.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua050.cmd.VLUA050CMD&S_MODE=DEL";
                trT_EV_ESTITEM.Post();
            }

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_EV_ESTITEM.Focus();

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            document.getElementById("cmbEVL_YY_SHR")[4].selected = true;
            fnc_SearchItem();

            document.getElementById("cmbGROUP_CD_SHR")[0].selected = true;
            document.getElementById("cmbEST_CD_SHR")[0].selected = true;

            document.getElementById("resultMessage").innerText = '';
            dsT_EV_ESTITEM.ClearAll();

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_ESTITEM.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            if( document.getElementById("cmbEVL_YY_SHR").value == '' ) {
                alert("해당년도는 필수 입력사항입니다.");
                document.getElementById("cmbEVL_YY_SHR").focus();
                return false;
            }

            if( document.getElementById("cmbEVL_FRQ_SHR").value == '' ) {
                alert(document.getElementById("cmbEVL_YY_SHR").value + "년도 평가 구조 설정 후 작업 하세요!");
                document.getElementById("cmbEVL_FRQ_SHR").focus();
                return false;
            }

            if( document.getElementById("cmbGROUP_CD_SHR").value == '' ) {
                alert("평가그룹은 필수 입력사항입니다.");
                document.getElementById("cmbGROUP_CD_SHR").focus();
                return false;
            }

            if( document.getElementById("cmbEST_CD_SHR").value == '' ) {
                alert("역량평가지표는 필수 입력사항입니다.");
                document.getElementById("cmbEST_CD_SHR").focus();
                return false;
            }

            return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            if (document.form1.cmbEVL_YY_SHR.value != year) {
                alert("현재년도 이외의 자료는 저장 및 수정할 수 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_06');
                document.form1.cmbEVL_YY_SHR.focus();
                return false;
            }

            if ( dsT_EV_ESTITEM.isUpdated ) {
                for( i=1; i<=dsT_EV_ESTITEM.CountRow; i++ ) {
                    if( dsT_EV_ESTITEM.RowStatus(i) == 1 || dsT_EV_ESTITEM.RowStatus(i) == 2 || dsT_EV_ESTITEM.RowStatus(i) == 3 ) {
                        if( dsT_EV_ESTITEM.NameValue(i, "ABL_CD") == '' ) {
                            alert("코드는 필수 입력사항입니다.");
                            form1.grdT_EV_ESTITEM.Draw = false;
                            form1.grdT_EV_ESTITEM.RowPosition    = i;
                            form1.grdT_EV_ESTITEM.ColumnPosition = "ABL_CD";
                            form1.grdT_EV_ESTITEM.Draw = true;
                            form1.grdT_EV_ESTITEM.Focus();
                            return false;
                        }
                        if( dsT_EV_ESTITEM.NameValue(i, "ABL_NM") == '' ) {
                            alert("명칭은 필수 입력사항입니다.");
                            form1.grdT_EV_ESTITEM.Draw = false;
                            form1.grdT_EV_ESTITEM.RowPosition    = i;
                            form1.grdT_EV_ESTITEM.ColumnPosition = "ABL_NM";
                            form1.grdT_EV_ESTITEM.Draw = true;
                            form1.grdT_EV_ESTITEM.Focus();
                            return false;
                        }
                    }
                }
            } else {
                fnc_Message(document.getElementById("resultMessage"),"MSG_04");
                alert("저장 할 자료가 없습니다!");
                return false;
            }
            return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            getSelYy2('cmbEVL_YY_SHR');                         //해당 년도 AddItem
            document.getElementById("cmbEVL_YY_SHR").focus();   //set focus

            // 업무구분
            if (frameid == "vlua050") {
                // 인사평가
                GUBUN = "01";

                //평가그룹
                var oOption;
                for( i=1; i<=dsCOMMON_EG.CountRow; i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = dsCOMMON_EG.NameValue(i,"CODE");
                    oOption.text = dsCOMMON_EG.NameValue(i,"CODE_NAME");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);
                }

                document.getElementById("loctitle").innerText = "HOME/인사평가/평가기준정보/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                var tempDS = fnc_GetDutyCd('DUTY2', '4');
                var oOption;

                for( i=1; i<=tempDS.CountRow; i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = tempDS.NameValue(i,"COMM_CD");
                    oOption.text = tempDS.NameValue(i,"COMM_NM");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);
                }

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/평가기준정보/";
            }

            document.form1.txtGUBUN.value = GUBUN;

            //역량평가지표
            for( i=1; i<=dsCOMMON_EA.CountRow; i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = dsCOMMON_EA.NameValue(i,"CODE");
                oOption.text = dsCOMMON_EA.NameValue(i,"CODE_NAME");
                document.getElementById("cmbEST_CD_SHR").add(oOption);
            }

            fnc_SearchItem();

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

		//전년도 기준 복사
        function fnc_Yearcopy(){

   			if( ! confirm("전년도 기준을 복사하시겠습니까?") ){
				return false;
			}

            //역량평가항목 데이터 유무 조회
            dsT_EV_ESTITEM_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua050.cmd.VLUA050CMD&S_MODE=SHR_01&GUBUN="+document.getElementById("txtGUBUN").value+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value;
            dsT_EV_ESTITEM_01.reset();

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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_GRDRATE)   |
    | 3. 사용되는 Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_ESTITEM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ESTITEM_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_TYPE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_GRDRATE)   |
    | 3. 사용되는 Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID ="trT_EV_ESTITEM" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_ESTITEM)">
    </Object>

    <Object ID ="trT_EV_ESTITEM_01" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EG"/>
       <jsp:param name="CODE_GUBUN"  value="EG"/>
       <jsp:param name="SYNCLOAD"    value="false"/>
       <jsp:param name="USEFILTER"    value="false"/>
    </jsp:include>

    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EA"/>
       <jsp:param name="CODE_GUBUN"    value="EA"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-----------------------------------------------------+
    | 코드(키값)는 수정불가하게 해주기                     |
    +------------------------------------------------------>
    <script language=JavaScript for=grdT_EV_ESTITEM event="OnLButtonDown(type,index, colid, x, y)">

        if( dsT_EV_ESTITEM.RowStatus(dsT_EV_ESTITEM.RowPosition)==0 ) {
            grdT_EV_ESTITEM.LayoutInfo("ColumnInfo", "ABL_CD::<CHILD>::type")='None';
        } else {
            grdT_EV_ESTITEM.LayoutInfo("ColumnInfo", "ABL_CD::<CHILD>::type")='Edit';
        }

    </script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ESTITEM Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            //alert("검색하신 조건의 자료가 없습니다!");

        } else {

            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_ESTITEM.CountRow);

        }

            form1.grdT_EV_ESTITEM.Draw = false;
            form1.grdT_EV_ESTITEM.RowPosition    = 1;
            form1.grdT_EV_ESTITEM.ColumnPosition = "ABL_CD";
            form1.grdT_EV_ESTITEM.Draw = true;

            form1.grdT_EV_ESTITEM.Focus();

    </Script>

    <Script For=dsT_EV_ESTITEM_01 Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

			if( ! confirm("기존데이터가 존재합니다. 계속 하시겠습니까?") ){
				return false;
			}

        }

		//트랜잭션 체크를 위해 임시생성
        dsT_EV_ESTITEM_01.AddRow();

		//트랜잭션 전송
		trT_EV_ESTITEM_01.KeyValue = "SVL(I:dsT_EV_ESTITEM_01=dsT_EV_ESTITEM_01)";
		trT_EV_ESTITEM_01.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua050.cmd.VLUA050CMD&S_MODE=SAV_01&GUBUN="+document.getElementById("txtGUBUN").value+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value;
		trT_EV_ESTITEM_01.Post();

    </Script>

    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //회차콤보 모두삭제
            for( i=0; i<=document.getElementById("cmbEVL_FRQ_SHR").length; i++ ) {
                document.getElementById("cmbEVL_FRQ_SHR").remove(0);
            }

            document.getElementById("resultMessage").innerText = ' ';
            dsT_EV_ESTITEM.ClearAll();
            alert( document.getElementById("cmbEVL_YY_SHR").value + "년도 평가 구조 설정 후 작업 하세요!");

        } else {

            //회차
            var oOption;

            //회차콤보 모두삭제
            for( j=0; j<=document.getElementById("cmbEVL_FRQ_SHR").length; j++ ) {
                document.getElementById("cmbEVL_FRQ_SHR").remove(0);
                document.getElementById("cmbEVL_FRQ_SHR").remove(1);
            }

            for( k=1; k<=Number(dsT_EV_TYPE.NameValue(1,"ABL_CNT")); k++ ) {        //역량평가회수
                oOption = document.createElement("OPTION");
                oOption.value = k;
                oOption.text = k;
                document.getElementById("cmbEVL_FRQ_SHR").add(oOption);
            }

            fnc_SearchList();
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ESTITEM Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_ESTITEM_01 Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <Script For=dsCOMMON_EG Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ESTITEM Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
            alert("해당 필수입력항목[코드/명칭/가중치] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
            alert("코드/명칭/가중치에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <Script For=dsCOMMON_EG Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_ESTITEM event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <script for=trT_EV_ESTITEM_01 event="OnSuccess()">

		//저장후 해당자료 재조회
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_ESTITEM event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);

    </script>

    <script for=trT_EV_ESTITEM_01 event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">역량평가항목설정</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">역량평가항목설정</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgYearcopy','','/images/button/btn_YearcopyOver.gif',1)"><img src="/images/button/btn_YearcopyOn.gif" name="imgYearcopy"    width="110" height="20" border="0" align="absmiddle" onClick="fnc_Yearcopy();"></a>
	            &nbsp;&nbsp;
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image0','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image0" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                    <col width="130"></col>
                                    <col width="70"></col>
                                    <col width="50"></col>
                                    <col width="50"></col>
                                    <col width="40"></col>
                                    <col width="80"></col>
                                    <col width="100"></col>
                                    <col width="100"></col>
                                    <col width="*"></col>
                                </colgroup>
                                <tr>
                                    <input type="hidden" name="txtGUBUN" id="txtGUBUN">
                                    <td align="right" width="1"></td>
                                    <td align="right" class="searchState">해당년도</td>
                                    <td class="padding2423"><select id=cmbEVL_YY_SHR name=cmbEVL_YY_SHR onChange="fnc_SearchItem();"><select></td>
                                    <td align="right" class="searchState">회차</td>
                                    <td class="padding2423">
                                        <select id="cmbEVL_FRQ_SHR" name="cmbEVL_FRQ_SHR" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                        </select> </td>
                                    <td align="right" class="searchState">평가그룹</td>
                                    <td class="padding2423">
                                        <select id="cmbGROUP_CD_SHR" name="cmbGROUP_CD_SHR" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                        </select>
                                    </td>
                                    <td align="right" class="searchState">역량평가지표</td>
                                    <td class="padding2423">
                                        <select id="cmbEST_CD_SHR" name="cmbEST_CD_SHR" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                        </select>
                                    </td>
                                    <td align="left" width="200"></td>
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
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                        <td align="right">&nbsp;</td>
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
                              <object id="grdT_EV_ESTITEM" classid="clsid:8B6E903C-6297-44FB-B6C5-4F9D7FCA2A08" width=800 height=340>
                                <Param Name="DataID"         value="dsT_EV_ESTITEM">
                                <Param Name="IndicatorInfo"     value='<INDICATORINFO width="0"></INDICATORINFO>'>
                                <param name="Sort"           value="false">
                                <Param Name="ColumnInfo"     value='
                                  <COLUMNINFO>
                                    <COLUMN id="ABL_CD" refcolid="ABL_CD">
                                        <HEADER left="0" top="0" right="40" bottom="30" bgcolor="#F7DCBB" text="코드"/>
                                        <VIEW bordercolor="silver" left="0" top="0" right="40" bottom="60" align="centercenter" />
                                        <CHILD type="edit" inputtype="num" limitlength="3" />
                                    </COLUMN>
                                    <COLUMN id="ABL_NM" refcolid="ABL_NM">
                                        <HEADER left="40" top="0" right="120" bottom="30" bgcolor="#F7DCBB" text="명  칭"/>
                                        <VIEW bordercolor="silver" left="40" top="0" right="120" bottom="60" align="leftcenter" />
                                        <CHILD type="edit" inputtype="" limitlength="50" />
                                    </COLUMN>
                                    <COLUMN id="WEIGHT" refcolid="WEIGHT">
                                        <HEADER left="120" top="0" right="170" bottom="30" bgcolor="#F7DCBB" text="가중치"/>
                                        <VIEW bordercolor="silver" left="120" top="0" right="170" bottom="60" align="rightcenter" />
                                        <CHILD type="edit" inputtype="num" limitlength="3" />
                                    </COLUMN>
                                    <COLUMN id="SUBITEM_01" refcolid="SUBITEM_01">
                                        <HEADER left="170" top="0" right="796" bottom="30" bgcolor="#F7DCBB" text="행        동        지        표"/>
                                        <VIEW bordercolor="silver" left="170" top="0" right="796" bottom="20" align="leftcenter" />
                                        <CHILD type="edit" inputtype="" limitlength="300" />
                                    </COLUMN>
                                    <COLUMN id="SUBITEM_02" refcolid="SUBITEM_02">
                                        <HEADER left="170" top="0" right="796" bottom="30" bgcolor="#F7DCBB" text="행        동        지        표"/>
                                        <VIEW bordercolor="silver" left="170" top="20" right="796" bottom="40" align="leftcenter"/>
                                        <CHILD type="edit" inputtype="" limitlength="300" />
                                    </COLUMN>
                                    <COLUMN id="SUBITEM_03" refcolid="SUBITEM_03">
                                        <HEADER left="170" top="0" right="796" bottom="30" bgcolor="#F7DCBB" text="행        동        지        표"/>
                                        <VIEW bordercolor="silver" left="170" top="40" right="796" bottom="60" align="leftcenter"/>
                                        <CHILD type="edit" inputtype="" limitlength="300" />
                                    </COLUMN>
                                 </COLUMNINFO>'>
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
       <jsp:param name="INIT"    value="false"/>
    </jsp:include>


</body>
</html>