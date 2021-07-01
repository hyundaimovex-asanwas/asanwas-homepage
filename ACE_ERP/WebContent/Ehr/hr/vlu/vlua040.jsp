<!--
    ************************************************************************************
    * @Source         : vlua040.jsp                                                    *
    * @Description    : 등급별 배분율 설정.                                            *
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

<html>

    <head>
    <title>등급별배분율설정(vlua040)</title>
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
        var btnList = 'TFTFFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //데이터셋 전송
            dsT_EV_GRDRATE.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua040.cmd.VLUA040CMD&S_MODE=SHR&GUBUN="+document.form1.txtGUBUN.value+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value;
            dsT_EV_GRDRATE.Reset();

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

            //년도 입력 텍스트 박스
            var tempYear = document.getElementById("cmbEVL_YY_SHR").value;

            if( dsT_EV_GRDRATE.NameValue(1,"EVL_YY") == '' ) {

                //구분
                dsT_EV_GRDRATE.NameValue(1,"GUBUN") = document.form1.txtGUBUN.value;
                dsT_EV_GRDRATE.NameValue(2,"GUBUN") = document.form1.txtGUBUN.value;
                dsT_EV_GRDRATE.NameValue(3,"GUBUN") = document.form1.txtGUBUN.value;
                dsT_EV_GRDRATE.NameValue(4,"GUBUN") = document.form1.txtGUBUN.value;

                // 해당년도
                dsT_EV_GRDRATE.NameValue(1,"EVL_YY") = tempYear.trim();
                dsT_EV_GRDRATE.NameValue(2,"EVL_YY") = tempYear.trim();
                dsT_EV_GRDRATE.NameValue(3,"EVL_YY") = tempYear.trim();
                dsT_EV_GRDRATE.NameValue(4,"EVL_YY") = tempYear.trim();

            }

            if( !fnc_SaveItemCheck() )     return;

            //트랜잭션 전송
            trT_EV_GRDRATE.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua040.cmd.VLUA040CMD&S_MODE=SAV";
            trT_EV_GRDRATE.Post();

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

            //이곳에 해당 코딩을 입력 하세요

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_GRDRATE.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

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

            // DataSet의 변경 여부 확인
            if ( dsT_EV_GRDRATE.IsUpdated ) {

                //비율의 합이 100%가 될 경우에만 저장한다.
                if((dsT_EV_GRDRATE.NameValue(1,"S_RATE")+dsT_EV_GRDRATE.NameValue(1,"A_RATE")+dsT_EV_GRDRATE.NameValue(1,"B_RATE")+dsT_EV_GRDRATE.NameValue(1,"C_RATE")+dsT_EV_GRDRATE.NameValue(1,"D_RATE")) != 100){
                    alert("비율(%)의 합은 '100'이 되어야 합니다.\n확인 후 다시 저장하세요!");
                     form1.grdT_EV_GRDRATE.SetColumn("S_RATE");//set focus
                    return false;
                }

            } else {

                fnc_Message(document.getElementById("resultMessage"),"MSG_04");
                return false;

            }

            return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid(form1.grdT_EV_GRDRATE, 15, "true", "false");
            form1.grdT_EV_GRDRATE.RowHeight = 26;

            // 업무구분
            if (frameid == "vlua040") {
                // 인사평가
                GUBUN = "01";
                document.getElementById("loctitle").innerText = "HOME/인사평가/평가기준정보/";
            }
            else {
                // 직무평가
                GUBUN = "02";
                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/평가기준정보/";
            }

            document.form1.txtGUBUN.value = GUBUN;

            getSelYy2('cmbEVL_YY_SHR');                 //SelectBox년도 Setting
            fnc_SearchList();                           //기본으로 조회
            document.form1.cmbEVL_YY_SHR.focus();       //검색 1조건에 Focus

        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

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

            //등급별 배분율 데이터 유무 조회
            dsT_EV_GRDRATE_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua040.cmd.VLUA040CMD&S_MODE=SHR&GUBUN="+document.form1.txtGUBUN.value+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value;
            dsT_EV_GRDRATE_01.reset();

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
    <Object ID="dsT_EV_GRDRATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_GRDRATE)   |
    | 3. 사용되는 Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_GRDRATE_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_GRDRATE)   |
    | 3. 사용되는 Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID ="trT_EV_GRDRATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_GRDRATE)">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_EV_GRDRATE_01                   |
    | 3. Table List : T_EV_GRDRATE                  |
    +----------------------------------------------->
    <Object ID ="trT_EV_GRDRATE_01" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_GRDRATE Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            var tempYear = document.getElementById("cmbEVL_YY_SHR").value;

            // 데이터셋의 헤더 정보를 설정하고 데이터셋에 검색년도와 SEQ를 셋팅한다.
            dsT_EV_GRDRATE.setDataHeader("GUBUN:STRING, EVL_YY:STRING, GBN_CD:STRING, S_RATE:INT, A_RATE:INT, B_RATE:INT, C_RATE:INT, D_RATE:INT");

            dsT_EV_GRDRATE.ImportData(GUBUN+",'"+tempYear+"','1'");
            dsT_EV_GRDRATE.ImportData(GUBUN+",'"+tempYear+"','2'");
            dsT_EV_GRDRATE.ImportData(GUBUN+",'"+tempYear+"','3'");
            dsT_EV_GRDRATE.ImportData(GUBUN+",'"+tempYear+"','4'");

            fnc_Message(document.getElementById("resultMessage"),"MSG_02");

        } else {

            document.getElementById("resultMessage").innerText = '* 자료가 조회 되었습니다!';

        }

        grdT_EV_GRDRATE.SetColumn("S_RATE");//set focus

    </Script>

    <Script For=dsT_EV_GRDRATE_01 Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

			if( ! confirm("기존데이터가 존재합니다. 계속 하시겠습니까?") ){
				return false;
			}

        }

		//트랜잭션 체크를 위해 임시생성
        dsT_EV_GRDRATE_01.AddRow();

		//트랜잭션 전송
		trT_EV_GRDRATE_01.KeyValue = "SVL(I:dsT_EV_GRDRATE_01=dsT_EV_GRDRATE_01)";
		trT_EV_GRDRATE_01.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua040.cmd.VLUA040CMD&S_MODE=SAV_01&GUBUN="+document.form1.txtGUBUN.value+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value;
		trT_EV_GRDRATE_01.Post();

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_GRDRATE Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_GRDRATE_01 Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_GRDRATE Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_GRDRATE_01 Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_GRDRATE event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <script for=trT_EV_GRDRATE_01 event="OnSuccess()">

        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_GRDRATE event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);

    </script>

    <script for=trT_EV_GRDRATE_01 event="OnFail()">

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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">등급별배분율설정</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">등급별배분율설정</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

    <!-- 조건 입력 테이블 시작 -->
    <!-- 조건 입력 테이블 끝 -->

    <!-- power Search테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="greenTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <input type="hidden" name="txtGUBUN" id="txtGUBUN">
                                    <td align="center" class="searchBold">해당년도</td>
                                    <td>
                                        <select id="cmbEVL_YY_SHR" name="cmbEVL_YY_SHR" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                        </select>
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
                            <object    id="grdT_EV_GRDRATE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                                <param name="DataID"            value="dsT_EV_GRDRATE">
                                <param name="LineColor"         value="Silver">
                                <param name="IndWidth"          value="0">
                                <param Name="Editable"          value="true">
                                <param name="RowHeight"         value="30">
                                <param name=HiddenHScroll       value="true">
                                <param name=HiddenVScroll       value="true">
                                <param name="AutoReSizing"      value="true">
                                <param name=ColSizing           value="true">
                                <param name="Format"            value='
                                    <C> id=EVL_YY    width=100  name=연도              align=center   Show=false </C>
                                    <C> id=GBN_CD    width=269  name="구        분"    align=center   Value={Decode(GBN_CD,1,"비율(%)                (역량)",2,"상여금 지급율(%)       (성과)",3,"승진(점수)      (성과 + 역량)",4,"성과급(%)       (성과 + 역량)")} </C>
                                    <C> id=S_RATE    width=99   name="S 등급"          align=right    EditLimit=3        edit=numeric </C>
                                    <C> id=A_RATE    width=99   name="A 등급"          align=right    EditLimit=3        edit=numeric </C>
                                    <C> id=B_RATE    width=99   name="B 등급"          align=right    EditLimit=3        edit=numeric </C>
                                    <C> id=C_RATE    width=99   name="C 등급"          align=right    EditLimit=3        edit=numeric </C>
                                    <C> id=D_RATE    width=99   name="D 등급"          align=right    EditLimit=3        edit=numeric </C>
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

    <!-- Validation Init  -->
    <jsp:include page="/common/CommonValid.jsp" flush="true">
       <jsp:param name="INIT"    value="false"/>
    </jsp:include>

</body>
</html>