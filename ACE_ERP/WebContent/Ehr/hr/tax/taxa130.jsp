<!--*************************************************************************
* @source      : taxa130.jsp                                                *
* @description : 지방세납부현황관리 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/26            조정호             최초작성                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.DateUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>지방세납부현황관리(taxa130)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   자바스크립트 함수 선언부분                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">
        //단축키 순서
        var btnList = "F"   //조회
                    + "F"   //신규
                    + "F"   //저장(처리)
                    + "F"   //취소
                    + "F"   //엑셀
                    + "T"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기
        var selectLayer = "layer_1";

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa130.cmd.TAXA130CMD";
        var params = null;


        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            if(selectLayer == "layer_3") {
                fnc_SearchList3();
            } else if(selectLayer == "layer_4") {
                fnc_SearchList4();
            }        
        }        
         
        /**
         * 기타소득/조정납부액관리 내역을 가져온다.
         */
        function fnc_SearchList3() {
            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR3");
            var pis_ym      = document.getElementById("txtPIS_YM_SHR3").value.split("-");
            var oDPT_CD     = document.getElementById("cmbDPT_CD_SHR3");
            
            if(oPIS_YM.value == "") {
                alert("해당년월이 비어있습니다.");
                oPIS_YM.focus();
                return;
            }

            params = "&S_MODE=SHR3"
                   + "&PIS_YM="+pis_ym[0]+pis_ym[1]
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1]
                   + "&DPT_CD="+oDPT_CD.value;

            dsT_AC_ETCPAY3.dataid = dataClassName+params;
            dsT_AC_ETCPAY3.reset();
        }

        /**
         * 원천징수정산 내역 조회
         */
        function fnc_SearchList4() {
            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR4");
            var pis_ym      = document.getElementById("txtPIS_YM_SHR4").value.split("-");
            var oDPT_CD     = document.getElementById("cmbDPT_CD_SHR4");
            
            if(oPIS_YM.value == "") {
                alert("해당년월이 비어있습니다.");
                oPIS_YM.focus();
                return;
            }            

            params = "&S_MODE=SHR4"
                   + "&PIS_YM="+pis_ym[0]+pis_ym[1]
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1]
                   + "&DPT_CD="+oDPT_CD.value;

            trT_AC_ETCPAY4.KeyValue = "SAV(O:dsT_AC_ETCPAY4=dsT_AC_ETCPAY4)";
            trT_AC_ETCPAY4.action = dataClassName+params;
            trT_AC_ETCPAY4.post();
        }

        /********************************************
         * 02. 조회 함수_Item 형태의 조회                *
         ********************************************/
        function fnc_SearchItem() {
            var pis_ym      = document.getElementById("txtPIS_YM_SHR4").value.split("-");
            
            dsT_CM_COMMON_DPT.ClearData();

            params = "&S_MODE=SHR_DPT"
                   + "&PIS_YM="+pis_ym[0]+pis_ym[1]
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1];

            dsT_CM_COMMON_DPT.dataid = dataClassName+params;
            dsT_CM_COMMON_DPT.reset();
        }

        /********************************************
         * 03. 저장 함수                                *
         ********************************************/
        function fnc_Save() {
            //저장유효성 검사
            if(dsT_AC_ETCPAY3.CountColumn == 0) {
                alert("조회를 먼저 하시기 바랍니다");
                return;
            }
            if(!fnc_CheckElement(oInputFieldList, oElementMsgList, new Array("rdoADD_TAG"))) return;
            
            isAdd = false;

            var pis_ym      = document.getElementById("txtPIS_YM_SHR3").value.split("-");
            var oDPT_CD     = document.getElementById("cmbDPT_CD");
            var oSAL_CD     = document.getElementById("cmbSAL_CD");
            var add_tag     = fnc_GetCheckedValue("rdoADD_TAG");
            var oAMOUNT     = document.getElementById("txtAMOUNT");

            params = "&S_MODE=SAV"
                   + "&PIS_YM="+pis_ym[0]+pis_ym[1]
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1]
                   + "&DPT_CD="+oDPT_CD.value
                   + "&SAL_CD="+oSAL_CD.value
                   + "&ADD_TAG="+add_tag
                   + "&AMOUNT="+oAMOUNT.text;
                   
            alert(params);

            cfCopyDataSetHeader(dsT_AC_ETCPAY3, dsT_AC_ETCPAY3_SAV);
            dsT_AC_ETCPAY3_SAV.AddRow();

            trT_AC_ETCPAY3.KeyValue = "SAV(I:dsT_AC_ETCPAY3_SAV=dsT_AC_ETCPAY3_SAV)";
            trT_AC_ETCPAY3.action = dataClassName+params;
            trT_AC_ETCPAY3.post();
        }

        /********************************************
         * 04. 삭제 함수                                *
         ********************************************/
        function fnc_Delete() {

        }

        /********************************************
         * 05. 인쇄 함수                                *
         ********************************************/
        function fnc_Print() {
            if(selectLayer == "layer_1") {
                fnc_Print1();
            } else if(selectLayer == "layer_2") {
                fnc_Print2();
            }
        }
        
        function fnc_Print1() {

            var PIS_YYMM = document.getElementById("txtPIS_YM_SHR1").value;
            var DPT_CD = document.getElementById("txtDPT_CD_SHR1").value;
            var PIS_GBN = document.getElementById("cmbGBN").value;

            if (DPT_CD == null || DPT_CD == "" )
            {
                alert("부서를 선택하여 주십시오.");
                return;
            }

            var url = "taxa131_PV.jsp?PIS_YYMM="+PIS_YYMM + "&DPT_CD=" + DPT_CD + "&PIS_GBN=" + PIS_GBN;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
        }        
         
        function fnc_Print2() {
		    var PIS_YYMM = document.getElementById("txtPIS_YM_SHR2").value;
		    var DPT_CD = document.getElementById("txtDPT_CD_SHR").value;

			var url = "taxa130_PV.jsp?PIS_YYMM="+PIS_YYMM + "&DPT_CD=" + DPT_CD;
			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;

        }


        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {
            if(selectLayer == "layer_3") {
                fnc_ToExcel3();
            } else if(selectLayer == "layer_4") {
                fnc_ToExcel4();
            }        
        }
         
        function fnc_ToExcel3() {
            if (dsT_AC_ETCPAY3.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_ETCPAY3.GridToExcel("지방세납부현황관리", '', 225);
        }

        function fnc_ToExcel4() {
            if (dsT_AC_ETCPAY4.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_ETCPAY4.GridToExcel("지방세납부현황관리", '', 225);
        }

        /********************************************
         * 07. 신규 함수                                *
         ********************************************/
        var isAdd = false;
        function fnc_AddNew() {
            if(dsT_AC_ETCPAY3.CountColumn == 0) {
                alert("조회를 먼저 하시기 바랍니다");
                return;
            }            
        
            if(isAdd) {
                if(!confirm("입력하던 자료가 있습니다.\n저장하지 않으면 삭제됩니다.\n계속하시겠습니까?")) {
                    return;
                }
            }
        
            isAdd = true;
            fnc_EnableElementAll(oInputFieldList);
            
            document.getElementById("cmbSAL_CD").selectedIndex = 0;
            document.getElementsByName("rdoADD_TAG")[0].checked = true;
            document.getElementById("cmbDPT_CD").selectedIndex = 0;     
            document.getElementById("txtAMOUNT").text = 0;
        }

        /********************************************
         * 08. 추가 함수                                *
         ********************************************/
        function fnc_Append() {

        }

        /********************************************
         * 09. 제거 함수                                *
         ********************************************/
        function fnc_Remove() {

        }

        /********************************************
         * 10. 초기화 함수                           *
         ********************************************/
        function fnc_Clear() {
            document.getElementById("resultMessage3").innerText = ' ';
            document.getElementById("resultMessage4").innerText = ' ';

            dsT_AC_ETCPAY3.ClearData();
            dsT_AC_ETCPAY4.ClearData();

            //모든 입력창들 초기화
            fnc_ClearInputElement(oInputFieldList);
            fnc_DisableElementAll(oInputFieldList);
            
            document.getElementById("cmbDPT_CD_SHR3").selectedIndex = 0;
            document.getElementById("cmbDPT_CD").selectedIndex = 0;
            document.getElementById("cmbSAL_CD").selectedIndex = 0;
            
            document.getElementById("txtDPT_CD_SHR" ).value = "";
            document.getElementById("txtDPT_NM_SHR" ).value = "";
            document.getElementById("txtDPT_CD_SHR1").value = "";
            document.getElementById("txtDPT_NM_SHR1").value = "";
            document.getElementById("cmbDPT_CD_SHR3").value = "";
            document.getElementById("cmbDPT_CD_SHR4").value = "";
            
            isAdd = false;

            //날자값들 바인딩
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_ETCPAY3.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. 검색 조건 유효성 검사                     *
         ********************************************/
        function fnc_SearchItemCheck() {

        }

        /********************************************
         * 13. 저장 유효성 체크                        *
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분         *
         ********************************************/
        function fnc_OnLoadProcess() {
            //첫번째 인수 : 그리드명
            //두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
            //세번째 인수 : 그리드모드(false:읽기, true:쓰기)
            //네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
            cfStyleGrid(form1.grdT_AC_ETCPAY3,0,"false","false");      // Grid Style 적용
            cfStyleGrid(form1.grdT_AC_ETCPAY4,0,"false","false");      // Grid Style 적용

            document.getElementById("txtPIS_YM_SHR1").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            document.getElementById("txtPIS_YM_SHR2").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            document.getElementById("txtPIS_YM_SHR3").value = "<%=DateUtil.getConvertDateFormat(DateUtil.getAfterDate(0, -1, 0),"yyyy-MM") %>";
            document.getElementById("txtPIS_YM_SHR4").value = "<%=DateUtil.getConvertDateFormat(DateUtil.getAfterDate(0, -1, 0),"yyyy-MM") %>";

            fnc_DisableElementAll(oInputFieldList);

            //공통 코드 설정
            fnc_BindingCommonCode(dsT_CM_COMMON_A4, "cmbDPT_CD_SHR3");
            fnc_BindingCommonCode(dsT_CM_COMMON_A4, "cmbDPT_CD");
            fnc_BindingCommonCode(dsT_CM_COMMON_H2, "cmbSAL_CD");

            //부서코드 설정시킴
            fnc_BindDpt();

            fnc_ShowHiddenLayer(oLayerList, "layer_1");
        }

        /********************************************
         * 15. 단축키 처리                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 16. Form이 Active 될 때 처리 할 일          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {

        }

        /********************************************
         * 기타 함수              *
         ********************************************/
         
        var oInputFieldList = new Array( "cmbSAL_CD"
                                        ,"rdoADD_TAG"
                                        ,"cmbDPT_CD"
                                        ,"txtAMOUNT");

        //항목들의 메세지
        var oElementMsgList = new Array( "항목"
                                        ,"구분"
                                        ,"부서"
                                        ,"금액");

        //현재 보여지는 Layer 항목들
        var oLayerList      = new Array( "layer_1"
                                        ,"layer_2"
                                        ,"layer_3"
                                        ,"layer_4");

        /**
         * 선택한 창들을 보여주고 닫는 역활
         * @param selectLayerName - 보여질 Layer 이름
         */
        function fnc_ClickBtn(selectLayerName) {
            selectLayer = selectLayerName;
        
            //레이어를 선택할때마다 핫키를 변경시킨다.
            if(selectLayerName == "layer_1" 
                    || selectLayerName == "layer_2") {
                btnList = "F"   //조회
                        + "F"   //신규
                        + "F"   //저장(처리)
                        + "F"   //취소
                        + "F"   //엑셀
                        + "T"   //인쇄
                        + "F"   //삭제
                        + "T";  //닫기                  
            } else if(selectLayerName == "layer_3") {
                btnList = "T"   //조회
                        + "F"   //신규
                        + "T"   //저장(처리)
                        + "T"   //취소
                        + "T"   //엑셀
                        + "F"   //인쇄
                        + "F"   //삭제
                        + "T";  //닫기              
            } else if(selectLayerName == "layer_4") {
                btnList = "T"   //조회
                        + "F"   //신규
                        + "F"   //저장(처리)
                        + "T"   //취소
                        + "T"   //엑셀
                        + "F"   //인쇄
                        + "F"   //삭제
                        + "T";  //닫기              
            }
        
            fnc_ShowHiddenLayer(oLayerList, selectLayerName);
        }

        /**
         * 해당년원일이 변경될때마다 부서 리스트를 변경시킴
         */
        function fnc_BindDpt() {
            if(document.getElementById("txtPIS_YM_SHR4").value == "") {
                return;
            }        
        
            document.getElementById("cmbDPT_CD_SHR4").value = "";
            fnc_SearchItem();
            fnc_BindingCommonCode(dsT_CM_COMMON_DPT, "cmbDPT_CD_SHR4");
        }
    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_ETCPAY)                |
    | 3. 사용되는 Table List(T_AC_ETCPAY)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_ETCPAY3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_AC_ETCPAY3_SAV" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_AC_ETCPAY4" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_CM_COMMON_DPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. 공통 콤보를 위한 DataSet                               |
    +------------------------------------------------------>
    <!-- 부서 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A4"/>
       <jsp:param name="CODE_GUBUN"    value="A4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 항목 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_H2"/>
       <jsp:param name="CODE_GUBUN"    value="H2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_ETCPAY)                |
    | 3. 사용되는 Table List(T_AC_ETCPAY)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_ETCPAY3" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <Object ID="trT_AC_ETCPAY4" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_ETCPAY3 Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage3"),"MSG_02");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage3"),"MSG_03",iCount);
        }
    </Script>

    <Script For=dsT_AC_ETCPAY4 Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage4"),"MSG_02");
            alert("검색하신 조건의 자료가 없습니다!");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage4"),"MSG_03",iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_AC_ETCPAY3 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_AC_ETCPAY4 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_AC_ETCPAY3 Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_AC_ETCPAY4 Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_AC_ETCPAY3 event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage3"), 'MSG_01');
        alert("* 작업을 완료 하였습니다!");
        
        fnc_ClearInputElement(oInputFieldList);
        fnc_DisableElementAll(oInputFieldList);
        
        document.getElementsByName("rdoADD_TAG")[0].checked = true;
        fnc_SearchList3();
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_ETCPAY3 event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_AC_ETCPAY4 event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!------------------------------+
    | 그리드의 ROW를 더블클릭 할때  |
    +------------------------------->
    <script for=grdT_AC_ETCPAY3 event=OnDblClick(Row,Colid)>
        if(Row < 1) {
            return;
        } else {
            var href_page = "/hr/tax/taxa131.jsp"
                          + "?PIS_YY="+dsT_AC_ETCPAY3.NameValue(Row, "PIS_YY")
                          + "&PIS_MM="+dsT_AC_ETCPAY3.NameValue(Row, "PIS_MM")
                          + "&DPT_CD="+dsT_AC_ETCPAY3.NameValue(Row, "DPT_CD");

            window.showModalDialog(href_page, "", "dialogWidth:600px; dialogHeight:510px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList3();
        }
    </script>

    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
    <!-- 파일 전송을 위해 -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

    <!-- 캘린더 프레임-->
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">지방세납부현황관리</td>
                    <td align="right" class="navigator">HOME/정산세무/정산세무/<font color="#000000">지방세납부현황관리</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- 타이틀 바 테이블 끝 -->

    <!-- Layer 용 버튼들 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td colspan="4" height="15"></td>
        </tr>
        <tr>
            <td width="25%" align="center"><input type="button" id="btnPROC1"  style="cursor:hand;width:120pt;height:20pt;" value=" 주민세특별징수명세서 "             onclick="fnc_ClickBtn('layer_1')"></td>
            <td width="25%" align="center"><input type="button" id="btnPROC2"  style="cursor:hand;width:120pt;height:20pt;" value=" 주민세특별징수계산서 "             onclick="fnc_ClickBtn('layer_2')"></td>
            <td width="25%" align="center"><input type="button" id="btnPROC3"  style="cursor:hand;width:120pt;height:20pt;" value=" 기타소득/조정납부액관리 "             onclick="fnc_ClickBtn('layer_3')"></td>
            <td width="25%" align="center"><input type="button" id="btnPROC4"  style="cursor:hand;width:120pt;height:20pt;" value=" 원천징수정산내역 "             onclick="fnc_ClickBtn('layer_4')"></td>
        </tr>
        <tr>
            <td colspan="4" height="5"></td>
        </tr>
    </table>
    <!-- Layer 용 버튼들 -->

<!-- 주민세특별징수명세서 Layer 시작 -->
    <div id="layer_1" style="position:absolute; visibility:hidden; display:none; width:640px; z-index:1;">
    <!-- 버튼 테이블 시작 -->
        <table width="800" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print1()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
                </td>
            </tr>
        </table>
        <!-- 버튼 테이블 끝 -->

        <!-- power Search테이블 시작 -->
    	<table width="800" border="0" cellspacing="0" cellpadding="0">
    		<tr>
    			<td align="center" class="greenTable">
    			<table width="100%" border="0" cellspacing="0" cellpadding="0">
    				<colgroup>
    					<col width="80"></col>
    					<col width="100"></col>
    					<col width="80"></col>
    					<col width="200"></col>
    					<col width="80"></col>
    					<col width="*"></col>
    				</colgroup>
    				<tr>
    					<td class="searchState" align="right">해당년월</td>
    					<td class="padding2423" align="left">
                            <input type="text" id="txtPIS_YM_SHR1" name="txtPIS_YM_SHR1" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR1','','134','108');"></a>
    					</td>
                       <td class="searchState" align="right">부서</td>
                      <td class="padding2423" align="left">
                        <input id="txtDPT_CD_SHR1" name="txtDPT_CD_SHR1" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                        <input id="txtDPT_NM_SHR1" name="txtDPT_NM_SHR1" size="14" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
                            <img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR1','txtDPT_NM_SHR1','부서','DEPT')">
                        </a>
                   		 </td>
                    	<td class="searchState" align="right">구분</td>
    					<td class="padding2423" align="left">
							<select id="cmbGBN" name="cmbGBN">
                                <option value="1">급여</option>
                                <option value="2">상여</option>
                                <option value="3">연월차</option>
                                <option value="4">연말정산</option>
                            </select>
                        </td>

    				</tr>
    			</table>
    			</td>
    		</tr>
    	</table>
    	<!-- power Search테이블 끝 -->
    </div>
<!-- 주민세특별징수명세서 Layer 끝 -->

<!-- 주민세특별징수계산서 Layer 시작 -->
    <div id="layer_2" style="position:absolute; visibility:hidden; display:none; width:640px; z-index:2;">
     <!-- 버튼 테이블 시작 -->
        <table width="800" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print2()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
                </td>
            </tr>
        </table>
        <!-- 버튼 테이블 끝 -->

        <!-- power Search테이블 시작 -->
    	<table width="800" border="0" cellspacing="0" cellpadding="0">
    		<tr>
    			<td align="center" class="greenTable">
    			<table width="100%" border="0" cellspacing="0" cellpadding="0">
    				<colgroup>
    					<col width="80"></col>
    					<col width="100"></col>
    					<col width="80"></col>
    					<col width="*"></col>
    				</colgroup>
    				<tr>
    					<td class="searchState" align="right">해당년월</td>
    					<td class="padding2423" align="left">
                            <input type="text" id="txtPIS_YM_SHR2" name="txtPIS_YM_SHR2" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR2','','134','108');"></a>
    					</td>
                       <td class="searchState" align="right">부서</td>
                      <td class="padding2423" align="left">
                        <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                        <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
                            <img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')">
                        </a>
                    </td>
    				</tr>
    			</table>
    			</td>
    		</tr>
    	</table>
    	<!-- power Search테이블 끝 -->

    </div>
<!-- 주민세특별징수계산서 Layer 끝 -->

<!-- 기타소득/조정납부액 관리 Layer 시작 -->
    <div id="layer_3" style="position:absolute; visibility:hidden; display:none; width:640px; z-index:3;">

        <!-- 버튼 테이블 시작 -->
        <table width="800" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td height="35" class="paddingTop5" align="right">
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList3()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel3()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
                </td>
            </tr>
        </table>
        <!-- 버튼 테이블 끝 -->

        <!-- power Search테이블 시작 -->
    	<table width="800" border="0" cellspacing="0" cellpadding="0">
    		<tr>
    			<td align="center" class="greenTable">
    			<table width="100%" border="0" cellspacing="0" cellpadding="0">
    				<colgroup>
    					<col width="80"></col>
    					<col width="100"></col>
    					<col width="80"></col>
    					<col width="*"></col>
    				</colgroup>
    				<tr>
    					<td class="searchState" align="right">해당년월</td>
    					<td class="padding2423" align="left">
                            <input type="text" id="txtPIS_YM_SHR3" name="txtPIS_YM_SHR3" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR3','','134','108');"></a>
    					</td>
                        <td class="searchState" align="right">부&nbsp;&nbsp;&nbsp;서</td>
                        <td class="padding2423" align="left">
                            <select id="cmbDPT_CD_SHR3" name="cmbDPT_CD_SHR3">
                                <option value=""></option>
                            </select>
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
                            <col width="90"></col>
                            <col width="140"></col>
                            <col width="90"></col>
                            <col width="180"></col>
                            <col width="90"></col>
                            <col width="*"></col>
                        </colgroup>
                        <tr>
                            <td class="creamBold" align="center">항&nbsp;&nbsp;&nbsp;목</td>
                            <td class="padding2423">
                                <select name="cmbSAL_CD" id="cmbSAL_CD">
                                    <option value=""></option>
                                </select>
                            </td>
                            <td class="creamBold" align="center">구&nbsp;&nbsp;&nbsp;분</td>
                            <td class="padding2423">
                                <input type="radio" id="rdoADD_TAG" name="rdoADD_TAG" value="0" style="border:none" checked> 미환급금
                                <input type="radio" id="rdoADD_TAG" name="rdoADD_TAG" value="1" style="border:none" > 미납부금
                            </td>
                            <td class="creamBold" align="center">부&nbsp;&nbsp;&nbsp;서</td>
                            <td class="padding2423">
                            <select id="cmbDPT_CD" name="cmbDPT_CD">
                                <option value=""></option>
                            </select>
                            </td>                            
                        </tr>
                        <tr>
                            <td class="creamBold" align="center">금&nbsp;&nbsp;&nbsp;액</td>
                            <td class="padding2423" colspan="5">
                                <comment id="__NSID__">
                                <object id="txtAMOUNT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                                    <param name=Alignment               value=2>
                                    <param name=Border                  value=true>
                                    <param name=ClipMode                value=true>
                                    <param name=DisabledBackColor       value="#EEEEEE">
                                    <param name=Enable                  value=true>
                                    <param name=IsComma                 value=true>
                                    <param name=Language                value=0>
                                    <param name=MaxLength               value=8>
                                    <param name=Numeric                 value=true>
                                    <param name=NumericRange            value=0~+:0>
                                    <param name=ShowLiteral             value=false>
                                    <param name=Visible                 value=true>
                                </object>
                                </comment>
                                <script> __ShowEmbedObject(__NSID__); </script>
                            </td>
                        </tr>
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
                            <td valign="bottom" class="searchState"><span id="resultMessage3">&nbsp;</span></td>
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
                        <object id="grdT_AC_ETCPAY3" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                            <param name="DataID" value="dsT_AC_ETCPAY3">
                            <param name="Editable" value="true">
                            <param name="DragDropEnable" value="true">
                            <param name="SortView" value="Left">
                            <param name="Format" value='
                                <C> id="{CUROW}"     width=60         align=center   name="NO"         value={String(Currow)}    SubSumText=""</C>
                                <C> id=DPT_NM        width=145        align=center   name=" 부  서 "     </C>
                                <C> id=LAB_AMT       width=115        align=right    rightmargin=10        name="근로소득"        </C>
                                <C> id=SO_AMT        width=115        align=right    rightmargin=10        name="기타소득"        </C>
                                <C> id=MIS_CAL       width=115        align=right    rightmargin=10        name="납부계산실수"    </C>
                                <C> id=MIS_AMT       width=115        align=right    rightmargin=10        name="납부금액실수"    </C>
                                <C> id=MIS_PRO       width=115        align=right    rightmargin=10        name="전산오류"        </C>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        <!-- 내용 조회 그리드 데이블 끝-->

    </div>
<!-- 기타소득/조정납부액 관리 Layer 끝 -->

<!-- 원천징수정산내역 Layer 시작 -->
    <div id="layer_4" style="position:absolute; visibility:hidden; display:none; width:640px; z-index:4;">

        <!-- 버튼 테이블 시작 -->
        <table width="800" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td height="35" class="paddingTop5" align="right">
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList4()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel4()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
                </td>
            </tr>
        </table>
        <!-- 버튼 테이블 끝 -->

        <!-- power Search테이블 시작 -->
        <table width="800" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="center" class="greenTable">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <colgroup>
                        <col width="80"></col>
                        <col width="100"></col>
                        <col width="80"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td class="searchState" align="right">해당년월</td>
                        <td class="padding2423" align="left">
                            <input type="text" id="txtPIS_YM_SHR4" name="txtPIS_YM_SHR4" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" onchange="fnc_BindDpt()">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR4','','134','108');"></a>
                        </td>
                        <td class="searchState" align="right">부&nbsp;&nbsp;&nbsp;서</td>
                        <td class="padding2423" align="left">
                            <select id="cmbDPT_CD_SHR4" name="cmbDPT_CD_SHR4">
                                <option value=""></option>
                            </select>
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
                            <td valign="bottom" class="searchState"><span id="resultMessage4">&nbsp;</span></td>
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
                        <comment id="__NSID4__">
                        <object id="grdT_AC_ETCPAY4" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID" value="dsT_AC_ETCPAY4">
                            <param name="Editable" value="true">
                            <param name="DragDropEnable" value="true">
                            <param name="SortView" value="Left">
                            <param name="Format" value='
                                <C> id="{CUROW}"            width=60        align=center        name="NO"         value={String(Currow)}    HeadBgColor="#F7DCBB"</C>
                                <C> id=DPT_NM               width=90        align=center        name="구분"        HeadBgColor="#F7DCBB"</C>
                                <G> name="전월조정분"    HeadBgColor="#F7DCBB"
                                    <C> id=NO_RTN           width=90        align=right    rightmargin=10        name="미환급 (A)"        HeadBgColor="#F7DCBB"</C>
                                    <C> id=NO_PAY           width=90        align=right    rightmargin=10        name="미납부 (B)"        HeadBgColor="#F7DCBB"</C>
                                </G>
                                <X> name="금월원천징수액"      HeadBgColor="#F7DCBB"
                                    <R>
                                        <G> name="납부소득분(C) = (D+E+F)"           HeadBgColor="#F7DCBB"
                                            <C> id=LAB_AMT      width=90        align=right    rightmargin=10        name="근로소득 (D)"        HeadBgColor="#F7DCBB"</C>
                                            <C> id=RET_AMT      width=90        align=right    rightmargin=10        name="퇴직소득 (E)"        HeadBgColor="#F7DCBB"</C>
                                            <C> id=SO_AMT       width=90        align=right    rightmargin=10        name="기타소득 (F)"        HeadBgColor="#F7DCBB"</C>
                                        </G>
                                        <C> id=YAC_AMT       width=140       align=right    rightmargin=10        name="퇴직자정산환급분 (G)"        HeadBgColor="#F7DCBB"</C>
                                    </R>
                                </X>
                                <G> name="연말정산"                 HeadBgColor="#F7DCBB"
                                    <C> id=NO_YAC           width=140       align=right    rightmargin=10        name="연말정산 미환급분(H)"        HeadBgColor="#F7DCBB"</C>
                                    <C> id=MON_RTN          width=140       align=right    rightmargin=10        name="당월환급(I) (A+B+C+G)"        HeadBgColor="#F7DCBB"</C>
                                    <C> id=NO_MON           width=130       align=right    rightmargin=10        name="미환급금 (J)=(H+I)"        HeadBgColor="#F7DCBB"</C>
                                </G>
                                <X> name="금월 원천징수 납부세액"     HeadBgColor="#F7DCBB"
                                    <R>
                                        <G> name="전 산 금 액"      HeadBgColor="#F7DCBB"
                                            <C> id=RETURN       width=90        align=right    rightmargin=10        name="미 환 급"        HeadBgColor="#F7DCBB"</C>
                                            <C> id=PAY          width=90        align=right    rightmargin=10        name="납  부"        HeadBgColor="#F7DCBB"</C>
                                        </G>
                                    </R>
                                </X>
                                <X> name="당월 조정내역"          HeadBgColor="#F7DCBB"
                                    <R>
                                        <G> name="납부실수(계산)" HeadBgColor="#F7DCBB"
                                            <C> id=CAL_RTN      width=90        align=right    rightmargin=10        name="미 환 급"        HeadBgColor="#F7DCBB"</C>
                                            <C> id=CAL_PAY      width=90        align=right    rightmargin=10        name="추가납부"        HeadBgColor="#F7DCBB"</C>
                                        </G>
                                        <G> name="납부실수(금액)" HeadBgColor="#F7DCBB"
                                            <C> id=AMT_RTN      width=90        align=right    rightmargin=10        name="미 환 급"        HeadBgColor="#F7DCBB"</C>
                                            <C> id=AMT_PAY      width=90        align=right    rightmargin=10        name="추가납부"        HeadBgColor="#F7DCBB"</C>
                                        </G>
                                        <G> name="전산오류"     HeadBgColor="#F7DCBB"
                                            <C> id=PGM_RTN      width=90        align=right    rightmargin=10        name="미 환 급"        HeadBgColor="#F7DCBB"</C>
                                            <C> id=PGM_PAY      width=90        align=right    rightmargin=10        name="추가납부"        HeadBgColor="#F7DCBB"</C>
                                        </G>
                                    </R>
                                </X>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID4__); </script>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        <!-- 내용 조회 그리드 데이블 끝-->

    </div>
<!-- 원천징수정산내역 Layer 끝 -->

    </form>
    <!-- form 끝 -->

</body>
</html>


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->