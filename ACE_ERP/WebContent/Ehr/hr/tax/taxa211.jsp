<!--*************************************************************************
* @source      : taxa211.jsp                                                *
* @description : 지방세납부현황관리 상세 PAGE                                         *
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
    <title>지방세납부현황관리 상세(taxa211)</title>
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
                    + "T"   //저장(처리)
                    + "F"   //취소
                    + "F"   //엑셀
                    + "F"   //인쇄
                    + "T"   //삭제
                    + "T";  //닫기
                    
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa210.cmd.TAXA210CMD";
        var params = null;
        
        //넘어온 변수 처리
        var PIS_YY = "<%=request.getParameter("PIS_YY") %>";
        var PIS_MM = "<%=request.getParameter("PIS_MM") %>";
        var DPT_CD = "<%=request.getParameter("DPT_CD") %>";
    

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            
            params = "&S_MODE=SHR_DTL"
                   + "&PIS_YY="+PIS_YY
                   + "&PIS_MM="+PIS_MM
                   + "&DPT_CD="+DPT_CD;     
            
            dsT_AC_ETCPAY.dataid = dataClassName+params;
            dsT_AC_ETCPAY.reset();
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
            //저장유효성 검사                   
            if(dsT_AC_ETCPAY.CountColumn == 0) {
                alert("조회를 먼저 하시기 바랍니다");
                return;
            }
            if(!fnc_SaveItemCheck()) return;
            
            params = "&S_MODE=SAV_DTL"
                   + "&PIS_YY="+PIS_YY
                   + "&PIS_MM="+PIS_MM
                   + "&DPT_CD="+DPT_CD;
        
            trT_AC_ETCPAY.KeyValue = "SAV(I:dsSAVE=dsT_AC_ETCPAY)";
            trT_AC_ETCPAY.action = dataClassName+params;
            trT_AC_ETCPAY.post();
        }

        /********************************************
         * 04. 삭제 함수                                *
         ********************************************/
        function fnc_Delete() {
            // 삭제 할 자료가 있는지 체크하고
            if (dsT_AC_ETCPAY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                alert("* 삭제 할 자료가 없습니다!");
                return;
            }
            
            var RowPosition = dsT_AC_ETCPAY.RowPosition;
            
 
             
            params = "&S_MODE=DEL_DTL"
                   + "&PIS_YY="+PIS_YY
                   + "&PIS_MM="+PIS_MM
                   + "&DPT_CD="+DPT_CD;
                   
            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + RowPosition + ":" + dsT_AC_ETCPAY.ColumnString(RowPosition,2) + ":" + dsT_AC_ETCPAY.ColumnString(RowPosition,4) + "]의 자료를 제거하시겠습니까?") == false) return;
            dsT_AC_ETCPAY.DeleteRow(RowPosition);                 
        
            trT_AC_ETCPAY.KeyValue = "SAV(I:dsDEL=dsT_AC_ETCPAY)";
            trT_AC_ETCPAY.action = dataClassName+params;
            trT_AC_ETCPAY.post();     
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
            form1.grdT_AC_ETCPAY.GridToExcel("지방세납부현황관리 상세", '', 225);
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

            //날자값들 바인딩
            var toDays = getTodayArray();
            document.getElementById("txtSTR_YMD_SHR").value = toDays[0]+"-"+toDays[1];
            document.getElementById("txtEND_YMD_SHR").value = toDays[0]+"-"+toDays[1];
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            window.close();       
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
            var oDataSet        = document.getElementById("dsT_AC_ETCPAY");
            var oGrid           = document.getElementById("grdT_AC_ETCPAY");
            var oElementValue   = null;
            var saveStatus      = null;
        
            //ds에 포함된 row 갯수를 가져옴
            for(i=1; i<=oDataSet.CountRow; i++){
                //ds 입력 타입이 insert 인지 update인지를 구분함
                //1:Insert
                //3:Update
                saveStatus = oDataSet.RowStatus(i);
        
                //입력상태가 insert, update 일때 그외 항목들 검증
                if(saveStatus == 1 || saveStatus == 3) {
                    oElementValue = oDataSet.NameString(i, "ADD_TAG");   //항목 값 가져오기
                    if(!(oElementValue == "0" || oElementValue == "1")) {
                        alert(i+": 구분 값은 0이거나 1이여야 합니다.");
                        oDataSet.RowPosition = i;
                        oGrid.SetColumn("ADD_TAG");
                        return false;
                    }
                    
                    oElementValue = oDataSet.NameString(i, "AMOUNT");
                    if(parseInt(oElementValue) <1 || parseInt(oElementValue) == 0) {
                        alert(i+": 금액은 음수나 0을 넣으실 수 없습니다.");
                        oDataSet.RowPosition = i;
                        oGrid.SetColumn("AMOUNT");
                        return false;                        
                    }
                }
            }
            
            return true;            
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분         *
         ********************************************/
        function fnc_OnLoadProcess() {   
            //첫번째 인수 : 그리드명                                        
            //두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
            //세번째 인수 : 그리드모드(false:읽기, true:쓰기)    
            //네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)                
            cfStyleGrid(form1.grdT_AC_ETCPAY,0,"true","false");      // Grid Style 적용

            fnc_SearchList();
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
        //지금 정의되어 있는 항목들
        var oElementList = new Array(    "ADD_TAG"
                                        ,"AMOUNT");                                               

        //항목들의 메세지                                        
        var oElementMsgList = new Array( "구분"
                                        ,"금액");     
                                        
        //예외 항목들
        var oExceptionList = new Array();    
                    
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
            alert("검색하신 조건의 자료가 없습니다!");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
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
    <table width="540" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">지방세납부현황관리 상세</td>
                    <td align="right" class="navigator">HOME/정산세무/정산세무/<font color="#000000">지방세납부현황관리 상세</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- 타이틀 바 테이블 끝 -->

    <!-- 버튼 테이블 시작 -->
    <table width="540" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->    
    
    <!-- 조회 상태 테이블 시작 -->
    <table width="540" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    </tr>
                </table>
            </td>
            <td class="paddingTop8" align="right"> 구분 (0:미환급분&nbsp;&nbsp;&nbsp;1:미납부금)</td>
        </tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->    
    
    <!-- 내용 조회 그리드 테이블 시작-->
    <table width="540" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                    <comment id="__NSID__">
                    <object id="grdT_AC_ETCPAY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:540px;height:350px;">
                        <param name="DataID" value="dsT_AC_ETCPAY">
                        <param name="Editable" value="true">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id="{CUROW}"        width=60    align=center    name="NO"         value={String(Currow)}    SubSumText=""</C>
                            <C> id=DPT_NM        width=150        align=center        name=" 부  서 "        Edit=none    Suppress=2</C>
                            <C> id=SAL_NM        width=110        align=center        name=" 항  목 "        Edit=none    Suppress=1</C>
                            <C> id=ADD_TAG       width=90         align=center        name="구분"        </C>
                            <C> id=AMOUNT        width=110        align=right    rightmargin=10        name=" 금  액 "        </C>
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
