<!--*************************************************************************
* @source      : insb030.jsp                                                *
* @description : 건강보험전산매체 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/02/28            조정호             최초작성                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>건강보험전산매체(insb030)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
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
                    + "F"   //저장
                    + "T"   //취소
                    + "T"   //엑셀
                    + "T"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ins.b.insb030.cmd.INSB030CMD";
        var params = null;

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            var oFIXED_DATE = document.getElementById("txtFIXED_DATE_SHR");

            if(!fnc_SearchItemCheck()) {
                return;
            }

            params = "&S_MODE=SHR"
                   + "&FIXED_DATE="+oFIXED_DATE.value;

            //상태값을 변경
            dsFILE_UPLOAD.UserStatus(1) = "1";

            trT_CP_PAYMASTER.KeyValue = "insb030"
                                      + "(I:dsFILE_UPLOAD=dsFILE_UPLOAD"
                                      + ",O:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER)";
            trT_CP_PAYMASTER.action   = dataClassName+params;
            trT_CP_PAYMASTER.post();
        }

        /********************************************
         * 02. 조회 함수_Item 형태의 조회                *
         ********************************************/
        function fnc_SearchItem() {

        }

        /********************************************
         * 03. 저장 함수                                *
         ********************************************/
        function fnc_Save() {
            if(!fnc_SaveItemCheck()) return;

            var oFIXED_DATE = document.getElementById("txtFIXED_DATE_SHR");
            params = "&S_MODE=SAV"
                   + "&FIXED_DATE="+oFIXED_DATE.value;

            //상태값을 변경 (모두 insert 처리)
            dsT_CP_PAYMASTER.UseChangeInfo = false;

            trT_CP_PAYMASTER_SAV.KeyValue = "SAV(I:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER)";
            trT_CP_PAYMASTER_SAV.action   = dataClassName+params;
            trT_CP_PAYMASTER_SAV.post();
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
            if(!fnc_SaveItemCheck()) return;
            form1.grdT_CP_PAYMASTER.GridToExcel("건강보험전산매체", '', 225);
        }

        /********************************************
         * 07. 신규 함수                                *
         ********************************************/
        function fnc_AddNew() {

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

            dsT_CP_PAYMASTER.ClearData();
            dsFILE_UPLOAD.ClearData();

            document.getElementById("txtFILE_NAME").value       = "";
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_CP_PAYMASTER.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. 검색 조건 유효성 검사                     *
         ********************************************/
        function fnc_SearchItemCheck() {
            //검색조건
            var oFIXED_DATE = document.getElementById("txtFIXED_DATE_SHR");

            if(oFIXED_DATE.value.trim() == "") {
                alert("기준일을 선택해 주세요.");
                oFIXED_DATE.focus();
                return false;
            }
            if(dsFILE_UPLOAD.CountRow < 1) {
                alert("첨부파일을 선택해 주세요.");
                return false;
            }
            if(dsFILE_UPLOAD.NameValue(1, "FILE_URL") == "") {
                alert("첨부파일을 선택해 주세요.");
                return false;
            }

            return true;
        }

        /********************************************
         * 13. 저장 유효성 체크                        *
         ********************************************/
        function fnc_SaveItemCheck() {
            if (dsT_CP_PAYMASTER.CountColumn == 0) {
                alert("리스트를 조회하지 않았습니다.");
                return false;
            }
            if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("저장할 데이타가 없습니다.");
                return false;
            }

            return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분         *
         ********************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_CP_PAYMASTER,0,"true","false");      // Grid Style 적용

            // 파일 첨부용 데이터셋의 헤더 정보 설정.
            dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");

            document.getElementById("txtFIXED_DATE_SHR").value  = (getTodayArray()[0]-1)+"-12-01";
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

        /**
         * 첨부파일 처리
         */
        function fnc_FileUpload() {
            var txtFILE_NAME = document.getElementById("txtFILE_NAME");
            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();
            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

            txtFILE_NAME.value = fcFILE_UPLOAD.Value;
        }

        /**
         * 파일로 저장
         */
        function fnc_ToFile() {
            var isFirst = true;
            var keys = "";
            var Noname = "";

            var oFIXED_DATE = document.getElementById("txtFIXED_DATE_SHR");

            if(!fnc_SearchItemCheck()) {
                return;
            }
            if(!fnc_SaveItemCheck()) {
                return;
            }
            //검색된 리스트 만큼 돌면서 선택되지 않은 key 값을 찾아 온다.
            for(i=1; i<=dsT_CP_PAYMASTER.CountRow; i++) {
                if(dsT_CP_PAYMASTER.NameString(i, "STATUS") == "0") {
                    if(isFirst) {
                     //   keys = i;
                        Noname = "'"+dsT_CP_PAYMASTER.NameString(i, "ENO_NO")+"'";
                        isFirst = false;
                    } else {
                     //   keys += ","+i;
                        Noname += ","+"'"+dsT_CP_PAYMASTER.NameString(i, "ENO_NO")+"'";
                    }
                }
            }

            params = "&S_MODE=FILE"
                   + "&FILE_NAME=현대UandI(건강보험).txt"
                   + "&FIXED_DATE="+oFIXED_DATE.value
                   + "&KEYS="+keys
                   + "&NONAME="+Noname;

            var form = document.form1;
            form.method = "post";
            form.target = "file_down";
            form.action = "/servlet/JspChannelSVL?cmd=hr.ins.b.insb030.cmd.INSB030CMD_FILE"+params;
            form.submit();
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
    | 2. 이름은 ds_ + 주요 테이블명(T_CP_PAYMASTER)                |
    | 3. 사용되는 Table List(T_CP_PAYMASTER)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_CP_PAYMASTER)                |
    | 3. 사용되는 Table List(T_CP_PAYMASTER)                      |
    +------------------------------------------------------>
    <Object ID="trT_CP_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <!-- 저장용 -->
    <Object ID="trT_CP_PAYMASTER_SAV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <!-- 데이터셋 컴포넌트 선언 [파일 첨부용] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

    <!-- 가우스 파일 오브젝트 -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='첨부파일'>
        <param name="Enable"    value="true">
    </object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("검색하신 조건의 자료가 없습니다!");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CP_PAYMASTER.CountRow);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_CP_PAYMASTER event="OnSuccess()">
    </script>

    <script for=trT_CP_PAYMASTER_SAV event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("작업을 완료 하였습니다!");
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_CP_PAYMASTER event="OnFail()">
        alert(trT_CP_PAYMASTER.ErrorMsg);
    </script>

    <script for=trT_CP_PAYMASTER_SAV event="OnFail()">
        alert(trT_CP_PAYMASTER_SAV.ErrorMsg);
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">건강보험전산매체</td>
                    <td align="right" class="navigator">HOME/복리후생/건강보험/<font color="#000000">건강보험전산매체</font></td>
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
           <!--      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)"><img src="/images/button/btn_ConductOn.gif" name="imgConduct" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>   -->
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
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
                    <td class="searchState" align="right">기준일</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtFIXED_DATE_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtFIXED_DATE_SHR','','94','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                    </td>
                    <td class="searchState" align="right">파일경로</td>
                    <td class="padding2423" align="left">
                        <input id=txtFILE_NAME name=txtFILE_NAME size="58" valid='maxlength=255' readonly>&nbsp;
                        <a  href="#"
                            onMouseOut="MM_swapImgRestore()"
                            onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',3)"
                        ><img
                            src="/images/button/FileAddOn.gif"
                            id="btnUPLOAD"
                            name="btnUPLOAD"
                            width="80"
                            height="20"
                            border="0"
                            align="absmiddle"
                            onClick="fnc_FileUpload()"
                        ></a>
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
                    </tr>
                </table>
            </td>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="3" cellpadding="0">
                    <tr>
                        <td valign="top" align="right">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnCREATE','','/images/button/btn_FilecreateOver.gif',1)"><img src="/images/button/btn_FilecreateOn.gif" name="btnCREATE" width="80" height="20" border="0" align="absmiddle" onclick="fnc_ToFile()"></a>
                        </td>
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
                    <object id="grdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
                        <param name="DataID" value="dsT_CP_PAYMASTER">
                        <param name="Editable" value="true">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id=STATUS       width=60        align=center        name=연번               EditStyle=CheckBox  CheckBoxText=NUM    Pointer=Hand</C>
                            <C> id=PLA_NO       width=80        align=center        name=사업장기호             Edit=none</C>
                            <C> id=DIS_NO       width=60        align=center        name=차수                   Edit=none</C>
                            <C> id=ACCOUNT      width=60        align=center        name=회계                   Edit=none</C>
                            <C> id=PLA_NM       width=80        align=center        name=단위사업장             Edit=none</C>
                            <C> id=HIU_NO       width=80        align=center        name=증번호                 Edit=none</C>
                            <C> id=ENO_NM       width=80        align=center        name=성명                   Edit=none</C>
                            <C> id=CET_NO       width=140       align=center        name=주민등록번호           Edit=none</C>
                            <C> id=HIRG_YMD     width=80        align=center        name=자격취득일             Edit=none</C>
                         <G> name="전년도보험료납부월수"  HeadBgColor=#F7DCBB
                            <C> id=PST_MM       width=80        align=center        name=건강보험               Edit=none</C>
                            <C> id=PST_OLD_MM   width=80        align=center        name=장기요양               Edit=none</C>
                         </G>
                         <G> name="전년도보험료납부총액"  HeadBgColor=#F7DCBB
                            <C> id=PST_TOT_AMT  width=80        align=right         name=합계                   Edit=none RightMargin="10"</C>
                            <C> id=PST_AMT      width=80        align=right         name=건강보험               Edit=none RightMargin="10"</C>
                            <C> id=PST_OLD_AMT  width=80        align=right         name=장기요양               Edit=none RightMargin="10"</C>
                         </G>
                            <C> id=TMP_SUM_AMT  width=120       align=right         name=전년도보수총액         Edit=none RightMargin="10"</C>
                            <C> id=PIS_MM_CNT   width=80        align=center        name=근무월수               Edit=none</C>
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

