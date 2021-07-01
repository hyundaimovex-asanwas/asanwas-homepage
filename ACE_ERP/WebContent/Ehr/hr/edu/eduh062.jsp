<!--
    ************************************************************************************
    * @Source         : eduh062.jsp                                                    *
    * @Description    : 사내강사강의실적등록 PAGE                                      *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/20  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>

    <head>
    <title>사내강사강의실적등록(eduh062)</title>
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
    
        var btnList = 'FFTFFFFT';
        
        var opener = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ED_LCTRHIST.ClearData();
            
            dsT_ED_LCTRHIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh062.cmd.EDUH062CMD&S_MODE=SHR&CET_NO="+opener.cet_no;
            dsT_ED_LCTRHIST.Reset();
            
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

            if (!fnc_SaveItemCheck()) {
                return;
            }
            
            dsT_ED_LCTRHIST.UseChangeInfo = false;
            
            trT_ED_LCTRHIST.KeyValue = "tr01(I:SAV=dsT_ED_LCTRHIST)";
            trT_ED_LCTRHIST.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh062.cmd.EDUH062CMD&S_MODE=SAV";
            trT_ED_LCTRHIST.post();
            
            dsT_ED_LCTRHIST.UseChangeInfo = true;
        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            //이곳에 해당 코딩을 입력 하세요
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
            if (form1.grdT_ED_LCTRHIST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_ED_LCTRHIST.GridToExcel("사내강사강의실적등록", '', 225);
        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

           //이곳에 해당 코딩을 입력 하세요

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
            
            dsT_ED_LCTRHIST.ClearData();
            
            fnc_ColEnabled('D');

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
            
            if (!dsT_ED_LCTRHIST.IsUpdated) {

                // DataSet의 변경 여부 확인
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }
            
            if ( dsT_ED_LCTRHIST.isUpdated) {
                for( i = 1; i <= dsT_ED_LCTRHIST.CountRow; i++ ) {
                    if( dsT_ED_LCTRHIST.RowStatus(i) == 1 || 
                        dsT_ED_LCTRHIST.RowStatus(i) == 3 ) {
                        /*
                        // 강의명
                        if (dsT_ED_LCTRHIST.NameValue(i, "LCT_TAG") == '') {
                            alert("강의명은 필수입력항목입니다.");
                            dsT_ED_LCTRHIST.RowPosition = i;
                            return false;
                        }
                        
                        // 강사료
                        
                        if (dsT_ED_LCTRHIST.NameValue(i, "LCT_AMT") == '' ||
                            dsT_ED_LCTRHIST.NameValue(i, "LCT_AMT") == 0) {
                            alert("강사료는 필수입력항목입니다.");
                            dsT_ED_LCTRHIST.RowPosition = i;
                            document.getElementById("medLCT_AMT").focus();
                            return false;
                        }*/
                        
                        // 이수점수
                        /*
                        if (dsT_ED_LCTRHIST.NameValue(i, "CPT_PNT") == '') {
                            alert("이수점수는 필수입력항목입니다.");
                            dsT_ED_LCTRHIST.RowPosition = i;
                            document.getElementById("txtCPT_PNT").focus();
                            return false;
                        }*/
                    }
                }
            }            

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            var oOption = null;
            
            //Grid Style 적용
            cfStyleGrid(form1.grdT_ED_LCTRHIST,0,"false","false");
            
            // 공지사항 데이터 조회
            fnc_SearchList();
           
        }
        
        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {
            
            if (dsT_ED_LCTRHIST.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }
            
            window.close();
        }
        
        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }
        
        
        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {

                form1.medLCT_AMT.enable                            = true;
                document.getElementById("txtCPT_PNT").disabled     = false;
                document.getElementById("txtREMARK").disabled      = false;
                
            }
            else if (prop == 'D') {

                form1.medLCT_AMT.enable                            = false;
                document.getElementById("txtCPT_PNT").disabled     = true;
                document.getElementById("txtREMARK").disabled      = true;
                
            }
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
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_LCTRHIST)|
    | 3. 사용되는 Table List(T_ED_LCTRHIST)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_LCTRHIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
   
    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_ED_LCTRHIST)|
    | 3. 사용되는 Table List(T_ED_LCTRHIST)       |
    +----------------------------------------------->
    <Object ID ="trT_ED_LCTRHIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_LCTRHIST)">
    </Object>
    
    
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->
    

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_LCTRHIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
            fnc_ColEnabled('D');

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_LCTRHIST.CountRow );
            
            fnc_ColEnabled('E');
            
        }
            
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_LCTRHIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>
    
    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_LCTRHIST Event="OnDataError()">

        cfErrorMsg(this);
        
    </Script>
    
    
   
    <!-- 트랜젝션 성공. -->
    <script for=trT_ED_LCTRHIST event="OnSuccess()">
    
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        
        opener.fnc_SearchList();
        
    </script>
    
    <!--트랜젝션 실패 -->
    <script for=trT_ED_LCTRHIST event="OnFail()">
    
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">사내강사강의실적등록</td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>        
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

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

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="300"></col>
                    <col width="100"></col>
                    <col width="300"></col>
                </colgroup>
                <tr>
                    <input type="hidden" id="txtSEQ_NO">
                    <input type="hidden" id="txtCET_NO">
                    <td align="center" class="creamBold">강사구분</td>
                    <td class="padding2423" >
                        <input id="txtLCT_CD" name="txtLCT_CD" style="width:20%"  class="input_ReadOnly"  readOnly> <input id="txtLCT_NM" name="txtLCT_NM" style="width:77%" class="input_ReadOnly"  readOnly>
                    </td>
                    <td align="center" class="creamBold">강의분야</td>
                    <td class="padding2423" >
                        <input id="txtLCT_Q5_GBN" name="txtLCT_Q5_GBN" style="width:20%"  class="input_ReadOnly"  readOnly> <input id="txtLCT_Q5_NM" name="txtLCT_Q5_NM" style="width:77%" class="input_ReadOnly"  readOnly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">과정코드</td>
                    <td class="padding2423">
                        <input id="txtEDU_CD" name="txtEDU_CD" style="width:20%"  class="input_ReadOnly"  readOnly> <input id="txtEDU_NM" name="txtEDU_NM" style="width:77%" class="input_ReadOnly"  readOnly>
                    </td>
                    <td align="center" class="creamBold">차 수 명</td>
                    <td class="padding2423" >
                        <input id="txtSEQ_NO"  name="txtSEQ_NO" style="width:100%"  class="input_ReadOnly"  readOnly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">강 사 명</td>
                    <td class="padding2423" >
                        <input id="txtENO_NM" name="txtENO_NM" style="width:100%"  class="input_ReadOnly"  readOnly>
                    </td>
                    <td align="center" class="creamBold">강 의 명</td>
                    <td class="padding2423" >
                        <input id="txtLCT_TAG"  name="txtLCT_TAG" style="width:100%" maxlength="20" class="input_ReadOnly"  readOnly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">강의시간</td>
                    <td class="padding2423" >
                        <input id="txtLCT_TIME"  name="txtLCT_TIME" style="width:85%;ime-mode:disabled;text-align:right;"  class="input_ReadOnly"  readOnly> 시간
                    </td>
                    <td align="center" class="creamBold">강 의 료</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medLCT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">강의일정</td>
                    <td class="padding2423" >
                        <input id="txtLCT_STR_YMD"  name="txtLCT_STR_YMD" style="ime-mode:disabled" size="10" class="input_ReadOnly"  readOnly> ~
                        <input id="txtLCT_END_YMD"  name="txtLCT_END_YMD" style="ime-mode:disabled" size="10" class="input_ReadOnly"  readOnly>
                    </td>
                    <td align="center" class="creamBold">이수점수</td>
                    <td class="padding2423" >
                        <input id="txtCPT_PNT"  name="txtCPT_PNT" style="width:90%;ime-mode:disabled;text-align:right;" maxlength="1" onkeypress="cfCheckNumber();"> 점
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">특이사항</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtREMARK"  name="txtREMARK" cols="112" rows="4" maxlength="600" ></textarea>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_ED_LCTRHIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:230px;">
                            <param name="DataID"                  value="dsT_ED_LCTRHIST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=40    name='순번'           align=center </C>
                                <C> id='LCT_NM'       width=60    name='강사구분'       align=center </C>
                                <C> id='LCT_Q5_NM'    width=98    name='강의분야'       align=center </C>
                                <C> id='EDU_NM'       width=120   name='과정명'         align=center </C>
                                <C> id='SEQ_NO'       width=60    name='차수'           align=center </C>
                                <C> id='ENO_NM'       width=60    name='강사명'         align=center </C>
                                <C> id='LCT_TAG'      width=120   name='강의명'         align=center </C>
                                <C> id='LCT_TERM'     width=160   name='강의일정'       align=center </C>
                                <C> id='LCT_TIME'     width=60    name='강의시간'       align=center </C>
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
<!-- 평가대상자설정 테이블 -->
<object id="bndT_ED_LCTRHIST"" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ED_LCTRHIST">
    <Param Name="BindInfo", Value='
        <C>Col=LCT_CD       Ctrl=txtLCT_CD       Param=value </C>
        <C>Col=LCT_NM       Ctrl=txtLCT_NM       Param=value </C>
        <C>Col=LCT_Q5_GBN   Ctrl=txtLCT_Q5_GBN   Param=value </C>
        <C>Col=LCT_Q5_NM    Ctrl=txtLCT_Q5_NM    Param=value </C>
        <C>Col=EDU_CD       Ctrl=txtEDU_CD       Param=value </C>
        <C>Col=EDU_NM       Ctrl=txtEDU_NM       Param=value </C>
        <C>Col=SEQ_NO       Ctrl=txtSEQ_NO       Param=value </C>
        <C>Col=ENO_NM       Ctrl=txtENO_NM       Param=value </C>
        <C>Col=LCT_TAG      Ctrl=txtLCT_TAG      Param=value </C>
        <C>Col=LCT_TIME     Ctrl=txtLCT_TIME     Param=value </C>
        <C>Col=LCT_AMT      Ctrl=medLCT_AMT      Param=text  </C>
        <C>Col=LCT_STR_YMD  Ctrl=txtLCT_STR_YMD  Param=value </C>
        <C>Col=LCT_END_YMD  Ctrl=txtLCT_END_YMD  Param=value </C>
        <C>Col=CPT_PNT      Ctrl=txtCPT_PNT      Param=value </C>
        <C>Col=REMARK       Ctrl=txtREMARK       Param=value </C>
        <C>Col=SEQ_NO       Ctrl=txtSEQ_NO       Param=value </C>
        <C>Col=CET_NO       Ctrl=txtCET_NO       Param=value </C>
    '>                                         
</object>