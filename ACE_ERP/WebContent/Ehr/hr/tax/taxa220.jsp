<!--*************************************************************************
* @source      : taxa220.jsp                                                *
* @description : 원천징수정산내역 PAGE                                         *
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
    <title>원천징수정산내역(taxa220)</title>
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
                    + "F"   //저장(처리)
                    + "T"   //취소
                    + "T"   //엑셀
                    + "F"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기          

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa220.cmd.TAXA220CMD";
        var params = null;


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
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1]
                   + "&DPT_CD="+oDPT_CD.value;

            trT_AC_ETCPAY.KeyValue = "SAV(O:dsT_AC_ETCPAY=dsT_AC_ETCPAY)";
            trT_AC_ETCPAY.action = dataClassName+params;
            trT_AC_ETCPAY.post();     
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
        
            //소속 코드를 가져온다.
            dsT_CM_COMMON_DPT.dataid = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa210.cmd.TAXA210CMD"+params;
            dsT_CM_COMMON_DPT.reset();   
        }

        /********************************************
         * 03. 저장 함수                                *
         ********************************************/
        function fnc_Save() {
            
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
            var PIS_YYMM = document.getElementById("txtPIS_YM_SHR").value;
            var DPT_CD = document.getElementById("txtDPT_CD_SHR").value;

            var url = "taxa220_PV.jsp?PIS_YYMM="+PIS_YYMM + "&DPT_CD=" + DPT_CD;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
        }

        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_ETCPAY.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_ETCPAY.GridToExcel("원천징수정산내역", '', 225);  
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

            dsT_AC_ETCPAY.ClearData();
            
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
            
            //코드 조회
            fnc_SearchItem();
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

    <Object ID="dsT_CM_COMMON_DPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

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

    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_ETCPAY event="OnFail()">
        cfErrorMsg(this);
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">원천징수정산내역</td>
                    <td align="right" class="navigator">HOME/정산세무/정산세무/<font color="#000000">원천징수정산내역</font></td>
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
                    <td class="searchState" align="right">해당년월&nbsp;</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM_SHR" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_SearchItem()">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','134','108');"></a>
                    </td>
                    <td class="searchState" align="right">소속&nbsp;</td>
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
                    <comment id="__NSID4__">
                    <object id="grdT_AC_ETCPAY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
                        <param name="DataID" value="dsT_AC_ETCPAY">
                        <param name="Editable" value="true">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <FC> id="{CUROW}"            width=30        align=center        name="NO"         value={String(Currow)}    HeadBgColor="#F7DCBB"</FC>
                            <FC> id=DPT_NM               width=90        align=center        name="구분"        HeadBgColor="#F7DCBB"</FC>
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

    </form>
    <!-- form 끝 -->

</body>
</html>


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->