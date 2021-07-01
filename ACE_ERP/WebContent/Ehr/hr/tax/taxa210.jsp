<!--*************************************************************************
* @source      : taxa130.jsp                                                *
* @description : 기타소득/조정납부액관리 PAGE                                         *
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
    <title>기타소득/조정납부액관리(taxa210)</title>
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
        var btnList = "T"   //조회
                    + "F"   //신규
                    + "T"   //저장(처리)
                    + "T"   //취소
                    + "T"   //엑셀
                    + "F"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa210.cmd.TAXA210CMD";
        var params;

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR");
            var pis_ym      = document.getElementById("txtPIS_YM_SHR").value.split("-");
            var oDPT_CD     = document.getElementById("cmbDPT_CD_SHR");

            if(oPIS_YM.value == "") {
                alert("해당년월이 비어있습니다.");
                oPIS_YM.focus();
                return;
            }

            params = "&S_MODE=SHR"
                   + "&PIS_YM="+pis_ym[0]+pis_ym[1]
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1]
                   + "&DPT_CD="+oDPT_CD.value;

            dsT_AC_ETCPAY.dataid = dataClassName+params;
            dsT_AC_ETCPAY.reset();
        }


        /********************************************
         * 02. 조회 함수_Item 형태의 조회                *
         ********************************************/
        function fnc_SearchItem() {
            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR");
            if(oPIS_YM.value == "")
                return;

            var pis_ym      = oPIS_YM.value.split("-");

            params = "&S_MODE=SHR_DPT"
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1];

            //부서 코드를 가져온다.
            dsT_CM_COMMON_DPT.dataid = dataClassName+params;
            dsT_CM_COMMON_DPT.reset();
        }

        /********************************************
         * 03. 저장 함수                                *
         ********************************************/
        function fnc_Save() {
            if (!dsT_AC_ETCPAY_SAV.IsUpdated) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }

            trT_AC_ETCPAY.KeyValue = "SAV(I:dsSAVE=dsT_AC_ETCPAY_SAV)";
            trT_AC_ETCPAY.action = dataClassName+"&S_MODE=SAV";
            trT_AC_ETCPAY.post();
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

        }


        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_ETCPAY.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_ETCPAY.GridToExcel("기타소득/조정납부액관리", '', 225);
        }

        /********************************************
         * 07. 신규 함수                                *
         ********************************************/
        function fnc_AddNew() {
            if(dsT_AC_ETCPAY_SAV.CountRow > 0) {
                if(!confirm("입력하던 자료가 있습니다.\n저장하지 않으면 삭제됩니다.\n계속하시겠습니까?")) {
                    return;
                }
            }
            dsT_AC_ETCPAY_SAV.ClearData();
            dsT_AC_ETCPAY_SAV.AddRow();

            var pis_ym = document.getElementById("txtPIS_YM_SHR").value.split("-");
            dsT_AC_ETCPAY_SAV.NameString(dsT_AC_ETCPAY_SAV.RowPosition, "PIS_YY") = pis_ym[0];
            dsT_AC_ETCPAY_SAV.NameString(dsT_AC_ETCPAY_SAV.RowPosition, "PIS_MM") = pis_ym[1];

            fnc_EnableElementAll(elementList);
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
            document.getElementById("resultMessage").innerText = ' ';

            dsT_AC_ETCPAY.ClearData();
            dsT_AC_ETCPAY_SAV.ClearData();

            //모든 입력창들 초기화
            fnc_ClearInputElement(elementList);
            fnc_DisableElementAll(elementList);

            document.getElementById("cmbDPT_CD_SHR").selectedIndex = 0;
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_ETCPAY.IsUpdated)  {
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
            cfStyleGrid(form1.grdT_AC_ETCPAY,0,"false","false");      // Grid Style 적용

            document.getElementById("txtPIS_YM_SHR").value = "<%=DateUtil.getConvertDateFormat(DateUtil.getAfterDate(0, -1, 0),"yyyy-MM") %>";

            //저장용 데이타셋 헤더설정
            dsT_AC_ETCPAY_SAV.setDataHeader ( " PIS_YY  :STRING  "
                                            + ",PIS_MM  :STRING  "
                                            + ",DPT_CD  :STRING  "
                                            + ",SAL_CD  :STRING  "
                                            + ",ADD_TAG :STRING  "
                                            + ",AMOUNT  :DECIMAL "
                                            + ",OCC_CD  :STRING  " );


            //공통 코드 설정
            fnc_ConstructCommonCode("dsT_CM_COMMON_H2", "cmbSAL_CD");

            //코드 조회
            fnc_SearchItem();

            fnc_DisableElementAll(elementList);
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

        var elementList = new Array( "cmbSAL_CD"
                                    ,"rdoADD_TAG"
                                    ,"cmbDPT_CD"
                                    ,"txtAMOUNT");

        var msgList = new Array(     "항 목"
                                    ,"구 분"
                                    ,"부 서"
                                    ,"금 액" );

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
    <Object ID="dsT_AC_ETCPAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_AC_ETCPAY_SAV" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Object ID="trT_AC_ETCPAY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_AC_ETCPAY Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>
    <Script For=dsT_CM_COMMON_DPT Event="OnLoadCompleted(iCount)">
        if (iCount > 0)    {
            fnc_ConstructCommonCode("dsT_CM_COMMON_DPT", "cmbDPT_CD_SHR", "", "전 체");
            fnc_ConstructCommonCode("dsT_CM_COMMON_DPT", "cmbDPT_CD");
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_AC_ETCPAY Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_AC_ETCPAY Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_AC_ETCPAY event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("* 작업을 완료 하였습니다!");
        dsT_AC_ETCPAY_SAV.ClearData();
        fnc_DisableElementAll(elementList);

        fnc_SearchList();
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_ETCPAY event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!------------------------------+
    | 그리드의 ROW를 더블클릭 할때  |
    +------------------------------->
    <script for=grdT_AC_ETCPAY event=OnDblClick(Row,Colid)>
        if(Row < 1) {
            return;
        } else {
            var href_page = "/hr/tax/taxa211.jsp"
                          + "?PIS_YY="+dsT_AC_ETCPAY.NameValue(Row, "PIS_YY")
                          + "&PIS_MM="+dsT_AC_ETCPAY.NameValue(Row, "PIS_MM")
                          + "&DPT_CD="+dsT_AC_ETCPAY.NameValue(Row, "DPT_CD");

            window.showModalDialog(href_page, "", "dialogWidth:610px; dialogHeight:530px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList();
        }
    </script>


    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_AC_ETCPAY_SAV event=CanRowPosChange(row)>
        var keyName;
        var colName;
        var colMsg;

        if(row > 0) {
            for(var i=0; i<elementList.length; i++) {
                keyName = elementList[i];
                colName = keyName.substring(3, keyName.length);
                colMsg  = msgList[i];

                if (dsT_AC_ETCPAY_SAV.NameString(row, colName) == "" ) {
                    alert("[ " + colMsg + " ]은(는) 필수 입력사항입니다");
                    document.getElementById(keyName).focus();
                    return false;
                }
            }
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">기타소득/조정납부액관리</td>
                    <td align="right" class="navigator">HOME/정산세무/정산세무/<font color="#000000">기타소득/조정납부액관리</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
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
                        <input type="text" id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" onchange="fnc_SearchItem()">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','134','108');"></a>
                    </td>
                    <td class="searchState" align="right">부&nbsp;&nbsp;&nbsp;서</td>
                    <td class="padding2423" align="left">
                        <select id="cmbDPT_CD_SHR">
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
                            <comment id="__NSID__">
                                <object id=rdoADD_TAG classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:14;width:180;">
                                    <param name=AutoMargin  value="true">
                                    <param name=Cols        value="2">
                                    <param name=Format      value="0^미환급금,1^미납부금">
                                </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="creamBold" align="center">부&nbsp;&nbsp;&nbsp;서</td>
                        <td class="padding2423">
                            <select id="cmbDPT_CD">
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
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
                    <object id="grdT_AC_ETCPAY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                        <param name="DataID" value="dsT_AC_ETCPAY">
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


    </form>
    <!-- form 끝 -->

</body>
</html>


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<object id="bndT_AC_ETCPAY_SAV" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_AC_ETCPAY_SAV">
    <Param Name="BindInfo", Value='
        <C>Col=DPT_CD           Ctrl=cmbDPT_CD          Param=value     </C>
        <C>Col=SAL_CD           Ctrl=cmbSAL_CD          Param=value     </C>
        <C>Col=ADD_TAG          Ctrl=rdoADD_TAG         Param=CodeValue </C>
        <C>Col=AMOUNT           Ctrl=txtAMOUNT          Param=Text      </C>
    '>
</object>