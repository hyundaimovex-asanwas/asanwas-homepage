<!--*************************************************************************
* @source      : retb010.jsp                                                *
* @description : 퇴직급여충당금 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/11            조정호             최초작성                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>퇴직급여충당금(retb010)</title>
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
                    + "T"   //엑셀
                    + "T"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ret.b.retb010.cmd.RETB010CMD";
        var params = null;
        var isProc = false;     //처리를 했는지 여부 검증
        var isShr  = false;     //검색을 했는지 여부 검증

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            //검색유효성 검사
            if(!fnc_SearchItemCheck()) return;

            var oPIS_YM = document.getElementById("txtPIS_YM");
            var oOCC_CC = document.getElementById("cmbOCC_CD");
            var oDPT_CD = document.getElementById("txtDPT_CD");
            var oJOB_CD = document.getElementById("txtJOB_CD");

            //처리 유무
            isProc = false;
            isShr  = true;

            //날짜 가져오기
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);

            params = "&S_MODE=SHR"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&OCC_CD="+oOCC_CC.value
                   + "&DPT_CD="+oDPT_CD.value
                   + "&JOB_CD="+oJOB_CD.value;

            dsT_AC_RESERVE.dataid = dataClassName+params;
            dsT_AC_RESERVE.reset();
        }

        /**
         * 처리 리스트 가져오기
         */
        function fnc_ProcessList() {
            //검색유효성 검사
            if(!fnc_SearchItemCheck()) return;

            var oPIS_YM = document.getElementById("txtPIS_YM");
            var oOCC_CC = document.getElementById("cmbOCC_CD");
            var oDPT_CD = document.getElementById("txtDPT_CD");
            var oJOB_CD = document.getElementById("txtJOB_CD");

        //    alert(addDate("M", getToday(), -1).replace("-","").substr(0,6));

            //검색을 했을때 값이 없거나, 이번달일 경우 충당금 처리가 가능하다.
            if(oPIS_YM.value.replace("-","") != addDate("M", getToday(), -1).replace("-","").substr(0,6)) {
                alert("전월 퇴직충당금 자료만 생성 가능합니다.");
           //     return;
            }

            //처리 유무
            isProc = true;

            //날짜 가져오기
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);

            params = "&S_MODE=PROC"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&OCC_CD="+oOCC_CC.value
                   + "&DPT_CD="+oDPT_CD.value
                   + "&JOB_CD="+oJOB_CD.value;
            dsT_AC_RESERVE.dataid = dataClassName+params;
            dsT_AC_RESERVE.reset();
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
            var oPIS_YM = document.getElementById("txtPIS_YM");

            //날짜 가져오기
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);

            params = "&S_MODE=SAV"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1];

            //처리를 했을 경우 전체 입력 아니면 수정된것만 수정
            if(isProc)
                dsT_AC_RESERVE.UseChangeInfo = "false";

            //ds에서 파일 업로드
            trT_AC_RESERVE.KeyValue = "TR"
                                    + "(I:dsT_AC_RESERVE=dsT_AC_RESERVE)";

            trT_AC_RESERVE.action = dataClassName+params;
            trT_AC_RESERVE.post();
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
            if (dsT_AC_RESERVE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_RESERVE.GridToExcel("퇴직급여충당금", '', 225);
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

            dsT_AC_RESERVE.ClearData();

            fnc_ClearInputElement(oElementList);

            isProc = false;
            isShr  = false;

            //년도 초기화
            document.getElementById("txtPIS_YM").value = getTodayArray()[0]+"-"+getTodayArray()[1];
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_RESERVE.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. 검색 조건 유효성 검사                     *
         ********************************************/
        function fnc_SearchItemCheck() {
            return fnc_CheckElement(oElementList, oElementMsgList, oExceptionList);
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

            // 근로구분 구분 검색 콤보박스 생성
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD").add(oOption);
			}

            //첫번째 인수 : 그리드명
            //두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
            //세번째 인수 : 그리드모드(false:읽기, true:쓰기)
            //네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
            cfStyleGrid(form1.grdT_AC_RESERVE,0,"true","false");      // Grid Style 적용

            //년도 초기화
            document.getElementById("txtPIS_YM").value = getTodayArray()[0]+"-"+getTodayArray()[1];
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
                                        ,"txtDPT_CD"
                                        ,"txtJOB_CD");

        //항목들의 메세지
        var oElementMsgList = new Array( "기준년월"
                                        ,"근로구분"
                                        ,"소속"
                                        ,"직위");

        //예외 항목들
        var oExceptionList = new Array(  "cmbOCC_CD"
                                        ,"txtDPT_CD"
                                        ,"txtJOB_CD");

    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_RESERVE)                |
    | 3. 사용되는 Table List(T_AC_RESERVE)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RESERVE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <param name=UseChangeInfo	value=true>
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=TimeOut             value="360000000">
    </Object>


    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_RESERVE)                |
    | 3. 사용되는 Table List(T_AC_RESERVE)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RESERVE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
        <param name=TimeOut             value="360000000">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>
    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_RESERVE Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_RESERVE.CountRow);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_AC_RESERVE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RESERVE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_AC_RESERVE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("작업을 완료 하였습니다!");
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RESERVE event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Grid Head Check event 처리                                   |
    +------------------------------------------------------>
    <script language="javascript" for=grdT_AC_RESERVE event=OnHeadCheckClick(Col,Colid,bCheck)>
        for(var i=1; i<=dsT_AC_RESERVE.CountRow; i++) {
            dsT_AC_RESERVE.NameValue(i, "STATUS") = bCheck;
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">퇴직급여충당금</td>
                    <td align="right" class="navigator">HOME/정산세무/퇴직충당금관리/<font color="#000000">퇴직급여충당금</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)"><img src="/images/button/btn_ConductOn.gif" name="imgConduct" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ProcessList()"></a>
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
					<col width="60"></col>
                    <col width="100"></col>
                    <col width="60"></col>
                    <col width="130"></col>
                    <col width="30"></col>
                    <col width="150"></col>
                    <col width="60"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">기준년월</td>
					<td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM" name="txtPIS_YM" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD_SHR" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype2','txtPIS_YM','','134','108');"></a>
					</td>
                    <td class="searchState" align="right"  >근로구분</td>
                    <td class="padding2423" align="left" width="100">
                        <select name="cmbOCC_CD" id="cmbOCC_CD">
                            <option value="">전체</option>
                        </select>
                    </td>
                    <td class="searchState" align="right">소속</td>
                    <td class="padding2423" align="left">
                        <input id="txtDPT_CD" size="4" maxlength="6"> <input id="txtDPT_NM" size="10" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD','txtDPT_NM','소속','DEPT')"></a>
                    </td>
                    <td class="searchState" align="right">직위</td>
                    <td class="padding2423" align="left">
                        <input id="txtJOB_CD" size="4" maxlength="6"> <input id="txtJOB_NM" size="10" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJobCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgJobCd" name="ImgJobCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_CD','txtJOB_NM','직위','A2')"></a>
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
					<comment id="__NSID__">
					<object id="grdT_AC_RESERVE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_AC_RESERVE">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<FC> id="{CUROW}"       width=30        align=center    name="NO"               value={String(Currow)}</FC>
                            <FC> id=OCC_NM          width=50        align=center    name=근로구분               Edit=None</FC>
                            <FC> id=DPT_NM          width=100       align=center    name=소속               Edit=None</FC>
                            <FC> id=JOB_NM          width=50        align=center    name=직위               Edit=None</FC>
                            <FC> id=ENO_NO          width=70        align=center    name=사번               Edit=None</FC>
                            <FC> id=ENO_NM          width=70        align=center    name=성명               Edit=None</FC>
                            <C>  id=CET_NO          width=100       align=center    name=주민등록번호       Edit=None </C>
                            <C>  id=HIRR_YMD        width=80        align=center    name=퇴직기준일         Edit=None</C>
                            <C>  id=RET_GBN_NM        width=80        align=center    name=연금구분         Edit=None</C>
                            <C>  id=LSE_DD          width=50        align=right     name=근속일수           Edit=None rightmargin=10  Mask=""</C>
                            <C>  id=PAY_AMT         width=100       align=right     name=당해년도급여       rightmargin=10</C>
                            <C>  id=SCH_AMT         width=100       align=right     name=당해학자금         rightmargin=10</C>
                            <C>  id=TOT_PAY_AMT     width=100       align=right     name=최근3개월급여      rightmargin=10</C>
                            <C>  id=AVG_AMT         width=100       align=right     name=평균임금           rightmargin=10</C>
                            <C>  id=TOT_RES_AMT     width=100       align=right     name=전월충당누계액     Edit=None  rightmargin=10</C>
                            <C>  id=RES_AMT         width=100       align=right     name=퇴직금추계액       rightmargin=10</C>
                            <C>  id=MON_RES_AMT     width=100       align=right     name=당월충당금         Edit=None rightmargin=10</C>
                            <C>  id=REASON          width=100       align=center    name=비고     </C>
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
