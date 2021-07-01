<!--*************************************************************************
* @source      : bona060.jsp                                                *
* @description : 상여전표처리 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/11            조정호             최초작성                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>상여전표처리(bona060)</title>
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
                    + "F"   //저장
                    + "T"   //취소
                    + "F"   //엑셀
                    + "F"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기
                    
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona060.cmd.BONA060CMD";
        var params = null;
    

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            //검색유효성 검사                   
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList)) return;
        
            var oPIS_YM     = document.getElementById("txtPIS_YM");   
            var oOCC_CD     = document.getElementById("cmbOCC_CD");
            var oSEQ_NO     = document.getElementById("cmbSEQ_NO");
            
            //날짜 가져오기
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);
            
            params = "&S_MODE=SHR"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&OCC_CD="+oOCC_CD.value
                   + "&SEQ_NO="+oSEQ_NO.value;     
                   
                   

            fnc_DisableElementAll(procBtnList);
            fnc_ClearInputElement(oRsList, new Array(), "");
            
            dsT_CP_WORKLOG.ClearData();
            
            dsT_CP_WORKLOG.dataid = dataClassName+params;
            dsT_CP_WORKLOG.reset();
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
            if (dsT_CP_WORKLOG.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_CP_WORKLOG.GridToExcel("상여전표처리", '', 225);
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
            dsT_CP_WORKLOG.ClearData();
            dsRESULT.ClearData();
            fnc_ClearInputElement(oRsList, new Array(), "");
            
            
            document.getElementById("cmbOCC_CD").selectedIndex = 0;
            document.getElementById("cmbSEQ_NO").selectedIndex = 0;
            
            //버튼들 초기화
            fnc_DisableElementAll(procBtnList);
            
            //입력창 닫기
            fnc_DisableElementAll(inputElementList);
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_CP_WORKLOG.IsUpdated)  {
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
            
            //년도 초기화
            document.getElementById("txtPIS_YM").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            
            //버튼들 초기화
            fnc_DisableElementAll(procBtnList);
            
            //입력창 닫기
            fnc_DisableElementAll(inputElementList);
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
        var oElementList = new Array(    "txtPIS_YM"
                                        ,"cmbOCC_CD"
                                        ,"txtPAY_YMD"
                                        ,"txtAPY_YMD");        

        //항목들의 메세지                                        
        var oElementMsgList = new Array( "해당년월"
                                        ,"근로구분"
                                        ,"지급일자"
                                        ,"전표처리");     
                                        
        //예외 항목들
        var oExceptionList = new Array(  "txtPAY_YMD", "txtAPY_YMD");    
        var oExceptionList2= new Array(  "txtRE_PIS_YM");    
        
        //입력할때 사용되는 element들 (기본을 사용 못하게 닫아 놓음)
        var inputElementList = new Array("txtPAY_YMD"
                                        ,"txtAPY_YMD"
                                        ,"imgPAY_YMD"
                                        ,"imgAPY_YMD");

        
        //작업 사항 항목들
        var oRsList = new Array(         "txtPAY_YMD"
                                        ,"txtAPY_YMD"
                                        ,"txtWRK_NO1"
                                        ,"txtWRK_NO2"
                                        ,"txtPRO_STS"
                                        ,"txtPRO_STS_MSG");
        
        //버튼들                                
        var procBtnList = new Array(     "btnPROC1"                                        
                                        ,"btnPROC2"
                                        ,"btnPROC3"
                                        ,"btnPROC4"
                                        ,"btnPROC5");
        
        /**
         * DataSet을 초기화 시킴
         */
        function clearDS() {
            dsT_CP_WORKLOG.ClearData();
        }  
        
        /**
         * 1:작업 OPEN
         */
        function fnc_proc1() {
            //검색유효성 검사                   
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList2)) return;
            if(dsT_CP_WORKLOG.CountRow != 0) {
                alert("조회를 먼저 해주세요.");
                return;
            }
        
            var oPIS_YM     = document.getElementById("txtPIS_YM");   
            var oOCC_CD     = document.getElementById("cmbOCC_CD");
            var oPAY_YMD    = document.getElementById("txtPAY_YMD");
            var oAPY_YMD    = document.getElementById("txtAPY_YMD");
            var oSEQ_NO     = document.getElementById("cmbSEQ_NO");
            
            if (confirm("작업 OPEN을 하시겠습니까? ") == false) return;
            
            //날짜 가져오기
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);
            
            params = "&S_MODE=PROC1"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&OCC_CD="+oOCC_CD.value
                   + "&PAY_YMD="+oPAY_YMD.value.replace(/-/g, '')
                   + "&APY_YMD="+oAPY_YMD.value.replace(/-/g, '')
                   + "&SEQ_NO="+oSEQ_NO.value;   

            dsRESULT.ClearData();
            
            
            trT_CP_WORKLOG.KeyValue = "SVL(O:dsRESULT=dsRESULT)";
            trT_CP_WORKLOG.action = dataClassName+params;
            trT_CP_WORKLOG.post();                      
        }           
        
        /**
         * 2:일반관리비(상여)
         */
        function fnc_proc2() {
            //검색유효성 검사                   
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList2)) return;
            if(dsT_CP_WORKLOG.CountRow != 1) {
                alert("조회를 먼저 해주세요.");
                return;
            }                        
        
            var oPIS_YM     = document.getElementById("txtPIS_YM");   
            var oOCC_CD     = document.getElementById("cmbOCC_CD");
            var oSEQ_NO     = document.getElementById("cmbSEQ_NO");
            
            if (confirm("일반관리비 (상여) 전표발행을 하시겠습니까? ") == false) return;
            
            //날짜 가져오기
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);
            
            params = "&S_MODE=PROC2"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&OCC_CD="+oOCC_CD.value
                   + "&SEQ_NO="+oSEQ_NO.value;     

            dsRESULT.ClearData();
            
            trT_CP_WORKLOG.KeyValue = "SVL(O:dsRESULT=dsRESULT)";
            trT_CP_WORKLOG.action = dataClassName+params;
            trT_CP_WORKLOG.post();         
        }        
        
        /**
         * 3:소득세/기타
         */
        function fnc_proc3() {
            //검색유효성 검사                   
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList2)) return;
            if(dsT_CP_WORKLOG.CountRow != 1) {
                alert("조회를 먼저 해주세요.");
                return;
            }
        
            var oPIS_YM     = document.getElementById("txtPIS_YM");   
            var oOCC_CD     = document.getElementById("cmbOCC_CD");
            var oSEQ_NO     = document.getElementById("cmbSEQ_NO");
            
            if (confirm("소득세/기타 전표발행을 하시겠습니까? ") == false) return;
            
            //날짜 가져오기
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);
            
            params = "&S_MODE=PROC3"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&OCC_CD="+oOCC_CD.value
                   + "&SEQ_NO="+oSEQ_NO.value;          

            dsRESULT.ClearData();
            
            trT_CP_WORKLOG.KeyValue = "SVL(O:dsRESULT=dsRESULT)";
            trT_CP_WORKLOG.action = dataClassName+params;
            trT_CP_WORKLOG.post();        
        }
        
        /**
         * 4:작업 CLOSE
         */
        function fnc_proc4() {
            //검색유효성 검사                   
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList2)) return;
            if(dsT_CP_WORKLOG.CountRow != 1) {
                alert("조회를 먼저 해주세요.");
                return;
            }
        
            var oPIS_YM     = document.getElementById("txtPIS_YM");   
            var oOCC_CD     = document.getElementById("cmbOCC_CD");
            var oSEQ_NO     = document.getElementById("cmbSEQ_NO");
            
            if (confirm("전표발행 작업을 CLOSE 하시겠습니까? ") == false) return;
            
            //날짜 가져오기
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);
            
            params = "&S_MODE=PROC4"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&OCC_CD="+oOCC_CD.value
                   + "&SEQ_NO="+oSEQ_NO.value;     
                   
            dsRESULT.ClearData();
            
            trT_CP_WORKLOG.KeyValue = "SVL(O:dsRESULT=dsRESULT)";
            trT_CP_WORKLOG.action = dataClassName+params;
            trT_CP_WORKLOG.post();                
        }
        
        /**
         * 5:재작업
         */
        function fnc_proc5() {
            //검색유효성 검사                   
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList2)) return;
            if(dsT_CP_WORKLOG.CountRow != 1) {
                alert("조회를 먼저 해주세요.");
                return;
            }
        
            var oPRO_STS    = document.getElementById("txtPRO_STS");
            var oPIS_YM     = document.getElementById("txtPIS_YM");   
            var oOCC_CD     = document.getElementById("cmbOCC_CD");
            var oSEQ_NO     = document.getElementById("cmbSEQ_NO");
            
            if (confirm("재처리 작업을 하시겠습니까? ") == false) return;
            
            //날짜 가져오기
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);
            
            params = "&S_MODE=PROC5"
                   + "&PRO_STS="+oPRO_STS.value
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&OCC_CD="+oOCC_CD.value
                   + "&SEQ_NO="+oSEQ_NO.value;          

            dsRESULT.ClearData();
            
            trT_CP_WORKLOG.KeyValue = "SVL(O:dsRESULT=dsRESULT)";
            trT_CP_WORKLOG.action = dataClassName+params;
            trT_CP_WORKLOG.post();         
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
    | 2. 이름은 ds_ + 주요 테이블명(T_CP_WORKLOG)                |
    | 3. 사용되는 Table List(T_CP_WORKLOG)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>  
    
    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>      
     
    
    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_CP_WORKLOG)                |
    | 3. 사용되는 Table List(T_CP_WORKLOG)                      |
    +------------------------------------------------------>
    <Object ID="trT_CP_WORKLOG" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">
        var oPRO_STS        = document.getElementById("txtPRO_STS");
        var oPRO_STS_MSG    = document.getElementById("txtPRO_STS_MSG");
    
        if(iCount == 0) {
            //alert("해당 자료가 존재하지 않습니다.");
            fnc_EnableElementAll(inputElementList);
            fnc_ChangeStateElement(true, "btnPROC1");
        } else if(iCount == 1) {
            oPRO_STS.value      = dsT_CP_WORKLOG.NameString(1, "PRO_STS");                               //작업상황
            oPRO_STS_MSG.value  = dsT_CP_WORKLOG.NameString(1, "PRO_STS_MSG");

            document.getElementById("txtPAY_YMD").value = dsT_CP_WORKLOG.NameString(1, "PAY_YMD");  //지급일자
            document.getElementById("txtAPY_YMD").value = dsT_CP_WORKLOG.NameString(1, "APY_YMD");  //전표작성일자
            
            document.getElementById("txtWRK_NO1").value = dsT_CP_WORKLOG.NameString(1, "WRK_NO1");  //일반관리비(상여)
            document.getElementById("txtWRK_NO2").value = dsT_CP_WORKLOG.NameString(1, "WRK_NO2");  //소득세/기타
            
            //버튼들 초기화
            fnc_DisableElementAll(procBtnList);
            if(oPRO_STS.value != 4) {
                fnc_ChangeStateElement(true, procBtnList[oPRO_STS.value]);
            }
            if(oPRO_STS.value != 1 && oPRO_STS.value != 4) {
                fnc_ChangeStateElement(true, procBtnList[4]);
            }        
        }
    </Script>
    
    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        var oPRO_STS        = document.getElementById("txtPRO_STS");
        var oPRO_STS_MSG    = document.getElementById("txtPRO_STS_MSG");
    
        if(iCount == 0) {
            //alert("해당 자료가 존재하지 않습니다.");
        } else {
            //결과 메세지 보여주기
            alert(dsRESULT.NameString(1, "RTN_MSG")+"\n현재 임시전표테이블 사용 차후 변경 필요(HDAC_USER)");
            
            if(dsRESULT.NameString(1, "RTN_CD") == "0") {
                //조회가 성공적으로 이루어 졌을때 다시 worklog를 조회시킴
                fnc_SearchList();
            }        
        }    
    </Script>    

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>
    
    <Script For=dsRESULT Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>    

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>  
    
    <Script For=dsRESULT Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>      

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_CP_WORKLOG event="OnSuccess()">

    </script> 

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_CP_WORKLOG event="OnFail()">
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">상여전표처리</td>
                    <td align="right" class="navigator">HOME/보상관리/상여관리/<font color="#000000">상여전표처리</font></td>
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
                    <col width="70"></col>
                    <col width="110"></col>
                    <col width="70"></col>
                    <col width="130"></col>
                    <col width="150"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>    
                    <td class="searchState" align="right">직&nbsp;&nbsp;&nbsp;종</td>
                    <td class="padding2423" align="left">
                        <select name="cmbOCC_CD" id="cmbOCC_CD" onchange="clearDS()">
                            <option value="A">사무직</option>
                            <option value="M">택배직</option>
                        </select>
                    </td>      
                    <td class="searchState" align="right">해당년월</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM" name="txtPIS_YM" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="clearDS()">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD_SHR" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype2','txtPIS_YM','','134','108');"></a>                        
                    </td>      
                    <td class="padding2423" align="left">
                        <select id="cmbSEQ_NO" name="cmbSEQ_NO">
                            <option value="1" selected>1차상여</option>
                            <option value="2">2차상여</option>
                        </select>
                    </td>        
                    <td class="padding2423" align="left"></td>                                                    
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
                        <col width="170"></col>
                        <col width="80"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="creamBold">지급일자</td>
                        <td class="padding2423">
                            <input id="txtPAY_YMD" name="txtPAY_YMD" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPAY_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPAY_YMD" id="imgPAY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPAY_YMD','','75','112');"></a>
                        </td>
                        <td align="center" class="creamBold">전표일자</td>
                        <td class="padding2423">
                            <input id="txtAPY_YMD" name="txtAPY_YMD" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPAY_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgAPY_YMD" id="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPY_YMD','','75','112');"></a>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">전표번호</td>
                        <td class="padding2423" colspan="3">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tr>
                                    <td rowspan="2" width="20">
                                    <td><b>일반관리비 (상여)</b></td>
                                    <td><b>소득세/기타</b></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>관리번호&nbsp;<input id="txtWRK_NO1" name="txtWRK_NO1" type="text" class="input_ReadOnly" readonly></td>
                                    <td>관리번호&nbsp;<input id="txtWRK_NO2" name="txtWRK_NO2" type="text" class="input_ReadOnly" readonly></td>
                                    <td></td>
                                </tr>
                            </table>
                        </td>
                    </tr>                    
                    <tr>
                        <td align="center" class="creamBold">작업상황</td>
                        <td  class="padding2423" colspan="3">
                            <input id="txtPRO_STS" name="txtPRO_STS" style="width:5%"  class="input_ReadOnly" readonly>
                            <input id="txtPRO_STS_MSG" name="txtPRO_STS_MSG" style="width:94%"  class="input_ReadOnly" readonly>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">작업선택</td>
                        <td  class="padding2423" colspan="3">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                                <tr height="50">
                                    <td align="center" class="padding2423">
                                        <input type="button" id="btnPROC1" style="cursor:hand;width:140pt;height:25pt;" value=" 작업 OPEN " onclick="fnc_proc1()">
                                        <input type="button" id="btnPROC2" style="cursor:hand;width:140pt;height:25pt;" value=" 일반관리비 (상여) " onclick="fnc_proc2()">
                                        <input type="button" id="btnPROC3" style="cursor:hand;width:140pt;height:25pt;" value=" 소득세/기타 " onclick="fnc_proc3()">
                                    </td>
                                </tr>
                                <tr height="50">
                                    <td align="center" class="padding2423">
                                        <input type="button" id="btnPROC4" style="cursor:hand;width:140pt;height:25pt;" value=" 작업 COLSE " onclick="fnc_proc4()">
                                        <input type="button" id="btnPROC5" style="cursor:hand;width:285pt;height:25pt;" value=" 재작업" onclick="fnc_proc5()">                              
                                    </td>
                                </tr>
                            </table>                    
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 조건 입력 테이블 끝 -->
    

    </form>
    <!-- form 끝 -->

</body>
</html>


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
