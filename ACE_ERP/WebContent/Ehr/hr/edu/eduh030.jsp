<!--
    ************************************************************************************
    * @Source         : eduh030.jsp                                                    *
    * @Description    : 교육과정관리 PAGE                                              *
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
    <title>교육과정개설(eduh030)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >


        var year = getToday().substring(0,4);
        var btnList = 'TTFTFFFT';

        var gbn;
        var edu_cd;
        //var edu_yy;
        var edu_nm;

        var mnger_cd;       //교육주관
        var edu_gbn_cd;     //교육구분


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            //var MNGER_CD    = document.getElementById("cmbMNGER_CD_SHR").value;
            //var FIELD_CD    = document.getElementById("cmbFIELD_CD_SHR").value;
            //var SHAPE_CD    = document.getElementById("cmbSHAPE_CD_SHR").value;
            var MNGER_CD    = "";
            var FIELD_CD    = "";
            var SHAPE_CD    = "";
            var EDU_CD      = document.getElementById("txtEDU_CD_SHR").value;
            var EDU_NM      = document.getElementById("txtEDU_NM_SHR").value;
            //var EDU_YY      = document.getElementById("txtEDU_YY_SHR").value;
            var STR_YMD     = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD     = document.getElementById("txtEND_YMD_SHR").value;


            //조회조건이 주어졌을경우
            //시작일자가 없으면 조회못함.
			if(STR_YMD.trim().length == 0 && END_YMD.trim().length != 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작일자를 입력하세요.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}
			//종료일자가 없으면 조회못함.
			if(STR_YMD.trim().length!=0 && END_YMD.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료일자를 입력하세요.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}
			//종료일자가 시작일자보다 크면 않된다.
			if(parseInt(END_YMD.replaceStr("-","")) < parseInt(STR_YMD.replaceStr("-",""))){
					alert("종료일자가 시작일자보다 빠릅니다.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
			}

            dsT_ED_COURSELIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh030.cmd.EDUH030CMD"
                                     + "&S_MODE=SHR"
                                     + "&MNGER_CD="+MNGER_CD
                                     + "&FIELD_CD="+FIELD_CD
                                     + "&SHAPE_CD="+SHAPE_CD
                                     + "&EDU_CD="+EDU_CD
                                     + "&EDU_NM="+EDU_NM
                                     //+ "&EDU_YY="+EDU_YY
                                     + "&STR_YMD="+STR_YMD
                                     + "&END_YMD="+END_YMD
                                     ;
            dsT_ED_COURSELIST.Reset();
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

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_ED_COURSELIST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("과정코드[" + dsT_ED_COURSELIST.NameValue(dsT_ED_COURSELIST.RowPosition,"EDU_CD") + "] 과정명[" + dsT_ED_COURSELIST.NameValue(dsT_ED_COURSELIST.RowPosition,"EDU_NM") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_ED_COURSELIST.DeleteRow(dsT_ED_COURSELIST.RowPosition);

            trT_ED_COURSELIST.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh030.cmd.EDUH030CMD&S_MODE=DEL";
            trT_ED_COURSELIST.post();


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

            if (dsT_ED_COURSELIST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_ED_COURSELIST.GridToExcel("교육과정", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            gbn     = "1";        // 1: 신규, 2: 수정
            edu_cd  = "";
            //edu_yy  = "";
            edu_nm  = "";


            url = "/hr/edu/eduh031.jsp";
            window.showModalDialog(url, self, "dialogHeight:500px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
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

            document.getElementById("txtEDU_CD_SHR").value   = "";
            document.getElementById("txtEDU_NM_SHR").value   = "";
            document.getElementById("txtSTR_YMD_SHR").value  = "";
            document.getElementById("txtEND_YMD_SHR").value  = "";

            document.getElementById("resultMessage").innerText = ' ';

            dsT_ED_COURSELIST.ClearData();

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

            //Grid Style 적용
            cfStyleGrid(form1.grdT_ED_COURSELIST,0,"false","false");

            //교육주관
            /*
            for( var i = 1; i <= dsCOMMON_Q7.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q7.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q7.NameValue(i,"CODE_NAME");
                document.getElementById("cmbMNGER_CD_SHR").add(oOption);

            }*/

            //교육분야
            /*
            for( var i = 1; i <= dsCOMMON_Q5.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q5.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q5.NameValue(i,"CODE_NAME");
                document.getElementById("cmbFIELD_CD_SHR").add(oOption);

            }*/

            //교육형태
            /*
            for( var i = 1; i <= dsCOMMON_Q8.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q8.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q8.NameValue(i,"CODE_NAME");
                document.getElementById("cmbSHAPE_CD_SHR").add(oOption);

            }*/

             //document.getElementById("txtEDU_YY_SHR").value = getTodayArray()[0];

            //document.getElementById("txtSTR_YMD_SHR").value = getStrDate();
            //document.getElementById("txtEND_YMD_SHR").value = getToday();
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

    <!-- 교육주관 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q7"/>
       <jsp:param name="CODE_GUBUN"    value="Q7"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 교육분야 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q5"/>
       <jsp:param name="CODE_GUBUN"    value="Q5"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 교육형태 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q8"/>
       <jsp:param name="CODE_GUBUN"    value="Q8"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <Script For=grdT_ED_COURSELIST Event="OnDblClick(row, col)">

        gbn     = "2";        // 1: 신규, 2: 수정
        edu_cd  = dsT_ED_COURSELIST.NameValue(row, "EDU_CD");
        edu_nm  = dsT_ED_COURSELIST.NameValue(row, "EDU_NM");
        eno_no  = dsT_ED_COURSELIST.NameValue(row, "ENO_NO");
        eno_nm  = dsT_ED_COURSELIST.NameValue(row, "ENO_NM");
        str_ymd = dsT_ED_COURSELIST.NameValue(row, "STR_YMD");

        window.showModalDialog("/hr/edu/eduh031.jsp", self, "dialogHeight:500px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");


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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">교육과정관리</td>
                    <td align="right" class="navigator">HOME/교육관리/과정운영자/<font color="#000000">교육과정관리</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="90"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">교육과정&nbsp;</td>
                                <td class="padding2423">
                                	<input id="txtEDU_CD_SHR" size="10" maxlength= "10" onkeypress="if(event.keyCode==13) fnc_SearchList();"  >
                                    <input id="txtEDU_NM_SHR" size="30" maxlength= "200" class="input_ReadOnly" >
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduCd" name="ImgEduCd" width="21" height="20" border="0" align="absmiddle" onclick="fnc_eduCodeSearchPopup('txtEDU_CD_SHR','txtEDU_NM_SHR');"></a>
                                </td>
                                <td align="right" class="searchState">교육기간&nbsp;</td>
                                <td class="padding2423" colspan="7" align="left">
                                    <input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD_SHR','','103','110');"></a>
                                    ~
                                    <input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD_SHR','','218','110');"></a>
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
                        <object    id="grdT_ED_COURSELIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                            <param name="DataID"                  value="dsT_ED_COURSELIST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='EDU_CD'      width=70    name='과정코드'           align=left   </C>
                                <C> id='EDU_NM'      width=300    name='과정명'           align=left   </C>
                                <C> id='STR_YMD'      width=100    name='등록일자'          align=center   </C>
                                <C> id='TOT_CNT'      width=100    name='개설된 교육과정'   align=center   </C>
                                <C> id='ING_CNT'      width=110    name='진행중인 교육과정' align=center   </C>
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

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState">* 해당 항목을 더블클릭 하시면 과목을 수정 할 수 있습니다.</td>
                </tr>
            </table>
        </td>
    </tr>
</table>

</form>
<!-- form 끝 -->

</body>
</html>