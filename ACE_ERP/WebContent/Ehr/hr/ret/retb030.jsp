<!--*************************************************************************
* @source      : retb030.jsp                                                *
* @description : 개인별지급소득내역 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/11            조정호             최초작성                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>개인별지급소득내역(retb030)</title>
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

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ret.b.retb030.cmd.RETB030CMD";
        var params = null;

        var gridFormat = "<FC> id={CUROW}           width=29    align=center    name=NO         value={String(Currow)}</FC>"
                       + "<FC> id=TAG               width=55    align=center    name=구분       value={Decode(CurLevel,9999,'총 계',TAG)}  </FC>"
                       + "<FC> id=OCC_NM            width=50    align=center    name=근로구분       value={Decode(CurLevel,9999,'',2,'소 계',OCC_NM)}  </FC>"
                       + "<FC> id=DPT_NM            width=90    align=center    name=소속        value={Decode(CurLevel,9999,'',2,'',1,'계',DPT_NM)} </FC>"
                       + "<FC> id=JOB_NM            width=55    align=center    name=직위         </FC>"
                       + "<FC> id=ENO_NO            width=60    align=center    name=사번         </FC>"
                       + "<FC> id=ENO_NM            width=60    align=center    name=성명         </FC>"
                       + "<C> id=CET_NO             width=90    align=center    name=주민번호     </C>"
                       + "<C> id=HIR_YMD            width=90    align=center    name=입사일       </C>"
                       + "<C> id=RET_YMD            width=90    align=center    name=퇴직일       </C>"
                       + "<C> id=PAY_AMT            width=100   align=right     name=급여합계        rightmargin=10 </C>"
                       + "<C> id=BON_AMT            width=100   align=right     name=상여합계        rightmargin=10 </C>"
                       + "<C> id=YMA_AMT            width=100   align=right     name=연월차합계      rightmargin=10 </C>"
                       + "<C> id=SCH_AMT            width=100   align=right     name=학자금합계      rightmargin=10 </C>"
                       + "<C> id=WEL_POINT          width=100   align=right     name=복지포인트합계  rightmargin=10 </C>";
        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            //검색유효성 검사
            if(document.getElementById("txtPIS_YM").value == "") {
                alert("기준년도를 입력해 주세요.");
                return;
            }

            var PIS_YM  = document.getElementById("txtPIS_YM").value;
            var DPT_CD  = document.getElementById("txtDPT_CD_SHR").value;
            var ENO_NO  = document.getElementById("txtENO_NO_SHR").value;

            //날짜 가져오기
            var dayArray = PIS_YM.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);

            params = "&S_MODE=SHR"
                   + "&PIS_YMD="+dayArray[0] + dayArray[1] + dayArray[2]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&DPT_CD="+DPT_CD
                   + "&ENO_NO="+ENO_NO;



            document.getElementById("grdT_CP_PAYMASTER").Format = gridFormat;
            cfStyleGrid(form1.grdT_CP_PAYMASTER,0,"false","false");      // Grid Style 적용

            dsT_CP_PAYMASTER.dataid = dataClassName+params;
            dsT_CP_PAYMASTER.reset();
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
            if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_CP_PAYMASTER.GridToExcel("개인별지급소득내역", '', 225);
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

          //  fnc_ClearInputElement(oElementList);

            document.getElementById("txtPIS_YM").value      = "";
            document.getElementById("txtDPT_CD_SHR").value  = "";
            document.getElementById("txtDPT_NM_SHR").value  = "";
            document.getElementById("txtENO_NO_SHR").value  = "";
            document.getElementById("txtENO_NM_SHR").value  = "";

            //년도 초기화
            document.getElementById("txtPIS_YM").value = getTodayArray()[0]+"-"+getTodayArray()[1];

            document.getElementById("grdT_CP_PAYMASTER").Format = gridFormat;
            cfStyleGrid(form1.grdT_CP_PAYMASTER,0,"false","false");      // Grid Style 적용
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
            document.getElementById("grdT_CP_PAYMASTER").Format = gridFormat;

            //첫번째 인수 : 그리드명
            //두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
            //세번째 인수 : 그리드모드(false:읽기, true:쓰기)
            //네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
            cfStyleGrid(form1.grdT_CP_PAYMASTER,0,"false","false");      // Grid Style 적용

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
        <param name=TimeOut             value="360000">
        <param name=SubSumExpr          value="total, 2:TAG, 1:OCC_NM">


    </Object>

    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_CP_PAYMASTER)                |
    | 3. 사용되는 Table List(T_CP_PAYMASTER)                      |
    +------------------------------------------------------>
    <Object ID="trT_CP_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("검색하신 조건의 자료가 없습니다!");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CP_PAYMASTER.CountRow);

            var oPIS_YM = document.getElementById("txtPIS_YM");

            //날짜 가져오기
            var dayArray = oPIS_YM.value.split("-");
            var pis_mm = fnc_covNumber(dayArray[1]);

            //지정 월수 만큼 그리드 포멧을 변경 시킴
            for(var i=1; i<=pis_mm; i++) {
                grdT_CP_PAYMASTER.Format += "<C> id=PAY_"+i+"      width=100   align=right     name="+i+"월급여   rightmargin=10</C>";
                grdT_CP_PAYMASTER.Format += "<C> id=BON_"+i+"      width=100   align=right     name="+i+"월상여   rightmargin=10</C>";
            }

            // Grid Style 적용
            cfStyleGrid(form1.grdT_CP_PAYMASTER,0,"false","false");
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
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("작업을 완료 하였습니다!");
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_CP_PAYMASTER event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Grid Head Check event 처리                                   |
    +------------------------------------------------------>
    <script language="javascript" for=grdT_CP_PAYMASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
        for(var i=1; i<=dsT_CP_PAYMASTER.CountRow; i++) {
            dsT_CP_PAYMASTER.NameValue(i, "STATUS") = bCheck;
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인별지급소득내역</td>
                    <td align="right" class="navigator">HOME/정산세무/퇴직충당금관리/<font color="#000000">개인별지급소득내역</font></td>
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
					<col width="90"></col>
					<col width="120"></col>
					<col width="60"></col>
					<col width="200"></col>
					<col width="60"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">기준년도&nbsp;</td>
					<td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM" name="txtPIS_YM" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD_SHR" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype2','txtPIS_YM','','134','108');"></a>
					</td>
					<td class="searchState" align="right">소속&nbsp;</td>
					<td class="padding2423" align="left">
                        <input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="6" maxlength= "6"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                        <input name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
					</td>
                    <td align="right" class="searchState">사번&nbsp;</td>
                    <td class="padding2423">
                        <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                        <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
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
					<object id="grdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_CP_PAYMASTER">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='

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
