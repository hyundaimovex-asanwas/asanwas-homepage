<!--
    ************************************************************************************
    * @Source         : vlud070.jsp                                                    *
    * @Description    : 평정결과(그룹별) PAGE                                          *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/11/21  |  박인이   | 최초작성                                               *
    * 2007/03/19  |  박인이   | 수정. (직무평가업무내용 추가)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>평정결과(그룹별)(vlud070)</title>
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

        var btnList = 'TFFTFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var EVL_YY  = form1.cmbEVL_YY_SHR.value;
            var EVL_GBN = form1.cmbEVL_GBN_SHR.value;
            var EVL_FRQ = form1.cmbEVL_FRQ_SHR.value;
            var HEAD_CD  = form1.cmbHEAD_CD_SHR.value;

            dsT_EV_ABLRST.ClearData();

            dsT_EV_ABLRST.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud070.cmd.VLUD070CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&HEAD_CD="+HEAD_CD;
            dsT_EV_ABLRST.Reset();

            form1.grdT_EV_ABLRST.Focus();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            var EVL_YY  = form1.cmbEVL_YY_SHR.value;

            // 그리드 데이터 조회 시
            form1.txtFLAG.value = "1";

            dsT_EV_TYPE.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud070.cmd.VLUD070CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY;
            dsT_EV_TYPE.Reset();

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

           var EVL_YY  = form1.cmbEVL_YY_SHR.value;
            var EVL_GBN = form1.cmbEVL_GBN_SHR.value;
            var EVL_FRQ = form1.cmbEVL_FRQ_SHR.value;
           var HEAD_CD = form1.cmbHEAD_CD_SHR.value;

			params = "GUBUN=" + GUBUN + "&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&HEAD_CD="+HEAD_CD;

			var url = "vlud070_PV.jsp?"+params;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_EV_ABLRST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("평정결과(그룹별)", '', 225)

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

            document.form1.cmbHEAD_CD_SHR.value = '';
            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_EV_ABLRST.ClearData();

            document.form1.cmbEVL_YY_SHR.focus();

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

            var EVL_YY  = null;

            //Grid Style 적용
            cfStyleGrid(form1.grdT_EV_ABLRST,0,"false","false");

            getSelYy2('cmbEVL_YY_SHR');

            EVL_YY = form1.cmbEVL_YY_SHR.value;

			//콤보박스 변경(인사평가)
			fnc_ChangeHEAD_CD_SHR();

            // Form Load 시
            form1.txtFLAG.value = "0";

            // 업무구분
            if (frameid == "vlud070") {
                // 인사평가
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/인사평가/평가정보/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/평가정보/";
            }

            dsT_EV_TYPE.ClearData();

            dsT_EV_TYPE.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud070.cmd.VLUD070CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY;
            dsT_EV_TYPE.Reset();

            form1.cmbEVL_YY_SHR.focus();

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

        //콤보박스 변경(인사평가)
        function fnc_ChangeHEAD_CD_SHR(){
			var EVL_YY = form1.cmbEVL_YY_SHR.value;

            dsT_CM_DEPT.DataId = "/servlet/GauceChannelSVL?cmd=common.commnm.cmd.COMMNMCMD&S_MODE=SHR_06&CD_GBN="+"B2"+"&EVL_YY="+EVL_YY;
            dsT_CM_DEPT.Reset();

			var oOption;

			//콤보삭제
			//del_index=document.from2.select2.selectedIndex;
			//document.getElementById("cmbHEAD_CD_SHR").remove(del_index);     //선택한 것만 지움
			//document.getElementById("cmbHEAD_CD_SHR").options.length = 3;    //3개 남기고 다지움
			document.getElementById("cmbHEAD_CD_SHR").options.length = 0;    //모두다 지움

			//콤보에 전체 생성
            oOption = document.createElement("OPTION");
            oOption.value = "";
            oOption.text  = "전체"
            document.getElementById("cmbHEAD_CD_SHR").add(oOption);

            //콤보에 코드 생성
            for( i = 1; i<= dsT_CM_DEPT.countrow; i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = dsT_CM_DEPT.NameValue(i,"HEAD_CD");
                oOption.text  = dsT_CM_DEPT.NameValue(i,"HEAD_NM");
                document.getElementById("cmbHEAD_CD_SHR").add(oOption);
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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ABLRST)    |
    | 3. 사용되는 Table List(T_EV_ABLRST)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_TYPE)      |
    | 3. 사용되는 Table List(T_EV_TYPE)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_TYPE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- 본부코드 생성용 -->
    <Object ID="dsT_CM_DEPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_ABLRST.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">
        var EVL_YY  = '';
        var EVL_GBN = '';
        var EVL_FRQ = '';
        var HEAD_CD = '';

        var oOption;
        var Index = document.getElementById("cmbEVL_FRQ_SHR").length;

        if (iCount == 0)    {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            //회차
            //기존의 회차콤보 데이터 모두삭제
            for( var i = Index; i >= 0; i--){

                form1.cmbEVL_FRQ_SHR.options.remove(i);

            }

            oOption = document.createElement("OPTION");
            oOption.value = 1;
            oOption.text  = '1회';
            document.getElementById("cmbEVL_FRQ_SHR").add(oOption);

        }
        else {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            //회차
            //기존의 회차콤보 데이터 모두삭제
            for( var i = Index; i >= 0; i--){

                form1.cmbEVL_FRQ_SHR.options.remove(i);

            }

            //역량
            if( document.getElementById("cmbEVL_GBN_SHR").value == '1' ) {

                //역량평가회수
                for( i = 1; i<= Number(dsT_EV_TYPE.NameValue(1,"ABL_CNT")); i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = i;
                    oOption.text  = i+'회';
                    document.getElementById("cmbEVL_FRQ_SHR").add(oOption);
                }

            }

            //성과
            if( document.getElementById("cmbEVL_GBN_SHR").value == '2' ) {

                //역량평가회수
                for( i=1; i<=dsT_EV_TYPE.NameValue(1,"ACH_CNT"); i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = i;
                    oOption.text  = i+'회';
                    document.getElementById("cmbEVL_FRQ_SHR").add(oOption);
                }

            }
            //종합
            if( document.getElementById("cmbEVL_GBN_SHR").value == '3' ) {

                //종합평가회수

                    oOption = document.createElement("OPTION");
                    oOption.value = 1;
                    oOption.text  = '1 회';
                    document.getElementById("cmbEVL_FRQ_SHR").add(oOption);


            }
        }

        if (form1.txtFLAG.value == "1") {

            EVL_YY  = form1.cmbEVL_YY_SHR.value;
            EVL_GBN = form1.cmbEVL_GBN_SHR.value;
            EVL_FRQ = form1.cmbEVL_FRQ_SHR.value;
            HEAD_CD  = form1.cmbHEAD_CD_SHR.value;

            dsT_EV_ABLRST.ClearData();

            dsT_EV_ABLRST.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud070.cmd.VLUD070CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&HEAD_CD="+HEAD_CD;
            dsT_EV_ABLRST.Reset();

            form1.grdT_EV_ABLRST.Focus();
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_TYPE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>



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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">평정결과(그룹별)</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">평정결과(그룹별)</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="100"></col>
                                <col width="80"></col>
                                <col width="70"></col>
                                <col width="80"></col>
                                <col width="70"></col>
                                <col width="80"></col>
                                <col width="70"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">해당년도&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbEVL_YY_SHR" name="cmbEVL_YY_SHR" onChange="JavaScript:fnc_SearchItem();fnc_ChangeHEAD_CD_SHR();" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                                </td>
                                <td align="right" class="searchState">구분&nbsp;</td>
                                <td class="padding2423">
                                    <select id=cmbEVL_GBN_SHR onChange="JavaScript: fnc_SearchItem();" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                        <option value="1">역량</option>
                                        <option value="2">성과</option>
                                        <option value="3">종합</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">회차&nbsp;</td>
                                <td class="padding2423">
                                    <select id=cmbEVL_FRQ_SHR onChange="fnc_SearchList()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                        <option value="1">1회</option>
                                        <option value="2">2회</option>
                                        <option value="3">3회</option>
                                        <option value="4">4회</option>
                                    </select> </td>
                                </td>
                                <td align="right" class="searchState">본부&nbsp;</td>
                                <td class="padding2423">
                                    <select name="cmbHEAD_CD_SHR" onChange="fnc_SearchList()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                                </td>
                                <input type=hidden name=txtFLAG>
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
                        <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_EV_ABLRST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <X> name='구    분' HeadBgColor='#F7DCBB'
                                    <C> id='OCC_NM'       width=79    name='근로구분'        align=left  suppress=3 </C>
                                    <C> id='GROUP_NM'     width=80    name='평가그룹'    align=left  suppress=2 </C>
                                    <C> id='GRD_NM'       width=70    name='평가구분'    align=left  suppress=1 </C>
                                    <C> id='TOT_CNT'      width=50    name='피평가;인원' align=right  </C>
                                </X>
                                <X> name='평 가 등 급 별    인 원' HeadBgColor='#F7DCBB'
                                    <G> name='S;(5%)' HeadBgColor='#F7DCBB'
                                        <C> id='S_CNT'    width=50    name='인원'        align=right  </C>
                                        <C> id='S_PERS'   width=50    name='%'           align=right  </C>
                                    </G>
                                    <G> name='A;(10%)' HeadBgColor='#F7DCBB'
                                        <C> id='A_CNT'    width=50    name='인원'        align=right  </C>
                                        <C> id='A_PERS'   width=50    name='%'           align=right  </C>
                                    </G>
                                    <G> name='B;(70%)' HeadBgColor='#F7DCBB'
                                        <C> id='B_CNT'    width=50    name='인원'        align=right  </C>
                                        <C> id='B_PERS'   width=50    name='%'           align=right  </C>
                                    </G>
                                    <G> name='C;(10%)' HeadBgColor='#F7DCBB'
                                        <C> id='C_CNT'    width=50    name='인원'        align=right  </C>
                                        <C> id='C_PERS'   width=50    name='%'           align=right  </C>
                                    </G>
                                    <G> name='D;(5%)' HeadBgColor='#F7DCBB'
                                        <C> id='D_CNT'    width=50    name='인원'        align=right  </C>
                                        <C> id='D_PERS'   width=50    name='%'           align=right  </C>
                                    </G>
                                </X>
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