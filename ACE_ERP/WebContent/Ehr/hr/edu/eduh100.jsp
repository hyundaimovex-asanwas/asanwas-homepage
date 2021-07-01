<!--
    ************************************************************************************
    * @Source         : eduh100.jsp                                                    *
    * @Description    : 실적현황관리 PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/05/02  |  김학수   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>실적현황관리(eduh100)</title>
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
    
        var btnList = 'TTFTFFFT';
        
        var edu_cd    = '';
        var edu_nm    = '';
        var seq_no    = '';
        var eno_no    = '';
        var eno_nm    = '';
        var mnger_cd  = '';
        var chasu_tag = '';
        var edu_str_ymd = '';
        var edu_end_ymd = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var f = document.form1;
            var STR_YMD = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD = document.getElementById("txtEND_YMD_SHR").value;
            var EDU_CD  = document.getElementById("txtEDU_CD_SHR").value;
            var PLACE_NM1 = "";
            var PLACE_NM2 = "";
            var PLACE_NM3 = "";
            
            if ( STR_YMD == "" || STR_YMD == null )
            {
                alert("시작일을 입력해 주십시오!");
                f.txtSTR_YMD_SHR.focus();
                return false;
            }
            if ( END_YMD == "" || END_YMD == null )
            {
                alert("종료일을 입력해 주십시오!");
                f.txtEND_YMD_SHR.focus();
                return false;
            }

            if ( f.chkPLACE_NM[0].checked == true && f.chkPLACE_NM[1].checked == true && f.chkPLACE_NM[2].checked == true ) {
                PLACE_NM1 = "1";
                PLACE_NM2 = "2";
                PLACE_NM3 = "3";
            } else if ( f.chkPLACE_NM[0].checked == true && f.chkPLACE_NM[1].checked == true ) {
                PLACE_NM1 = "1";
                PLACE_NM2 = "2";
            } else if ( f.chkPLACE_NM[0].checked == true && f.chkPLACE_NM[2].checked == true ) {
                PLACE_NM1 = "1";
                PLACE_NM3 = "3";
            } else if ( f.chkPLACE_NM[1].checked == true && f.chkPLACE_NM[2].checked == true ) {
                PLACE_NM2 = "2";
                PLACE_NM3 = "3";
            } else if ( f.chkPLACE_NM[0].checked == true ) {
                PLACE_NM1 = "1";
            } else if ( f.chkPLACE_NM[1].checked == true ) {
                PLACE_NM2 = "2";
            } else if ( f.chkPLACE_NM[2].checked == true ) {
                PLACE_NM3 = "3";
            } else {
                PLACE_NM1 = "1";
                PLACE_NM2 = "2";
                PLACE_NM3 = "3";
            }

            dsT_ED_COURSELIST.ClearData();
            
            dsT_ED_COURSELIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh100.cmd.EDUH100CMD&S_MODE=SHR&STR_YMD="+STR_YMD+"&END_YMD="+END_YMD+"&EDU_CD="+EDU_CD+"&PLACE_NM1="+PLACE_NM1+"&PLACE_NM2="+PLACE_NM2+"&PLACE_NM3="+PLACE_NM3;
            dsT_ED_COURSELIST.Reset();
            
            form1.grdT_ED_COURSELIST.Focus();

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

            //이곳에 해당 코딩을 입력 하세요
            
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

            //이곳에 해당 코딩을 입력 하세요

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
/*
            document.getElementById("cmbMNGER_CD_SHR").value = "";
            document.getElementById("cmbFIELD_CD_SHR").value = "";
            document.getElementById("cmbSHAPE_CD_SHR").value = "";
            document.getElementById("txtEDU_CD_SHR").value   = "";
            document.getElementById("txtEDU_NM_SHR").value   = "";
            
            document.getElementById("resultMessage").innerText = ' ';
            
            dsT_ED_COURSELIST.ClearData();
            
            document.getElementById("cmbMNGER_CD_SHR").focus();
*/
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

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            var today = getToday();
            //Grid Style 적용
            cfStyleGrid(form1.grdT_ED_COURSELIST,0,"false","false");
  
/*
            for( var i = 1; i <= dsCOMMON_Q9.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q9.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q9.NameValue(i,"CODE_NAME");
                document.getElementById("chkPLACE_NM").add(oOption);
                
            }
*/
            document.form1.txtSTR_YMD_SHR.value = today.substr(0,8)+"01";
        	document.form1.txtEND_YMD_SHR.value = today;
            document.getElementById("txtSTR_YMD_SHR").focus();   
        }
        
        
        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {
            
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
            
        }
        
        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/
         
        
        
    </script>

    </head>

    
    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_COURSELIST)|
    | 3. 사용되는 Table List(T_ED_COURSELIST)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_COURSELIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_ED_COURSELIST)|
    | 3. 사용되는 Table List(T_ED_COURSELIST)       |
    +----------------------------------------------->
    <Object ID ="trT_ED_COURSELIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:DEL=dsT_ED_COURSELIST)">
    </Object>
    
    <!-- 교육구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q9"/>
       <jsp:param name="CODE_GUBUN"    value="Q9"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->
    
    <Script For=grdT_ED_COURSELIST Event="OnDblClick(row, col)">
    
        edu_cd      = dsT_ED_COURSELIST.NameValue(row, "EDU_CD");
        edu_nm      = dsT_ED_COURSELIST.NameValue(row, "EDU_NM");
        seq_no      = dsT_ED_COURSELIST.NameValue(row, "SEQ_NO");
        eno_no      = dsT_ED_COURSELIST.NameValue(row, "ENO_NO");
        eno_nm      = dsT_ED_COURSELIST.NameValue(row, "ENO_NM");
        mnger_cd    = dsT_ED_COURSELIST.NameValue(row, "MNGER_CD");
        chasu_tag   = dsT_ED_COURSELIST.NameValue(row, "CHASU_TAG");
        edu_str_ymd = dsT_ED_COURSELIST.NameValue(row, "EDU_STR_YMD");
        edu_end_ymd = dsT_ED_COURSELIST.NameValue(row, "EDU_END_YMD");

//        if (dsT_ED_COURSELIST.NameValue(row, "REQ_CNT") > 0) {
            var url = "eduh100_PV.jsp?edu_cd="+edu_cd+"&seq_no="+seq_no;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
//        } else {
//            alert("실적등록대상이 존재하지 않습니다.");
//            return;
//        }
        
    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_COURSELIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_COURSELIST.CountRow );
            
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_COURSELIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_COURSELIST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>
    
    
    <!-- 트랜젝션 성공. -->
    <script for=trT_ED_COURSELIST event="OnSuccess()">
    
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        
    </script>
    
    <!--트랜젝션 실패 -->
    <script for=trT_ED_COURSELIST event="OnFail()">
    
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">실적현황관리</td>
                    <td align="right" class="navigator">HOME/교육관리/과정운영자/<font color="#000000">실적현황관리</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="center" class="greenTable">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="searchState" align="right">교육일자&nbsp;</td>
                        <td class="padding2423" align="left">
                            <input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','225','113');"></a> ~
                            <input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','340','113');"></a>
                        </td>
                        <td class="searchState" align="right">교육구분&nbsp;</td>
                        <td class="padding2423" align="left">
                            <input type="checkbox" id="chkPLACE_NM" name="chkPLACE_NM" value="" checked>사내
                            <input type="checkbox" id="chkPLACE_NM" name="chkPLACE_NM" value="">사외
                            <input type="checkbox" id="chkPLACE_NM" name="chkPLACE_NM" value="">인터넷
                        </td>
                        <td align="right" class="searchState">과정명 </td>
                        <td class="padding2423">
                            <input name="txtEDU_CD_SHR" size="5"  maxlength="5" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" onChange="fnc_GetCommNm('Q1', 'txtEDU_CD_SHR','txtEDU_NM_SHR');"> 
                            <input id="txtEDU_NM_SHR" name="txtEDU_NM_SHR" size="20" class="input_ReadOnly"  readOnly>
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduCd','','/images/button/btn_HelpOver.gif',1)">
                                <img src="/images/button/btn_HelpOn.gif" id="ImgEduCd" name="ImgEduCd" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtEDU_CD_SHR','txtEDU_NM_SHR','교육과정','Q1')">
                            </a>
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
                        <object    id="grdT_ED_COURSELIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:400px;">
                            <param name="DataID"                  value="dsT_ED_COURSELIST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <FC> id='{currow}'     width=30    name='순번'              align=center </FC>
                                <FC> id='EDU_CD'       width=60    name='과정코드'          align=center </FC>
                                <FC> id='EDU_NM'       width=150   name='과정명'            align=left   </FC>
                                <FC> id='CHASU_TAG'    width=50    name='차수'              align=center </FC>
                                <C>  id='ENT_TERM'     width=160   name='신청기간'          align=center </C>
                                <C>  id='EDU_TERM'     width=160   name='교육기간'          align=center </C>
                                <C>  id='SHAPE_NM'     width=70    name='형태'              align=center </C>
                                <C>  id='REQ_CNT'      width=30    name='신청'              align=right  </C>
                                <C>  id='OBJ_CNT'      width=30    name='대상'              align=right  </C>
                                <C>  id='PAS_CNT'      width=30    name='수료'              align=right  </C>
                                <C>  id='ENO_NO'       width=80    name='담당자사번'        align=center </C>
                                <C>  id='ENO_NM'       width=80    name='담당자'            align=center </C>
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