<!--*************************************************************************
* @source      : taxa040.jsp                                                *
* @description : 근로소득정산현황 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/11            조정호             최초작성
* 2007/04/30            김학수             최초작성
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>근로소득정산현황(taxa040)</title>
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

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa040.cmd.TAXA040CMD";
        var params = null;


        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            //검색유효성 검사
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList)) return;

            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR");
            var oOCC_CD     = document.getElementById("cmbOCC_CD_SHR");
            var oSAL_GBN    = document.getElementById("cmbSAL_GBN_SHR");
            var oENO_NO     = document.getElementById("txtENO_NO_SHR");
            var oDTP_CD     = document.getElementById("txtDPT_CD_SHR");

            //날짜 가져오기
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);

            params = "&S_MODE=SHR"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&SAL_GBN="+oSAL_GBN.value
                   + "&ENO_NO="+oENO_NO.value
                   + "&DTP_CD="+oDTP_CD.value;

            dsT_AC_RETACC.dataid = dataClassName+params;
            dsT_AC_RETACC.reset();
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
            //검색유효성 검사
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList)) return;

            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR");
            var oSAL_GBN    = document.getElementById("cmbSAL_GBN_SHR");
            var oENO_NO     = document.getElementById("txtENO_NO_SHR");
            var oDTP_CD     = document.getElementById("txtDPT_CD_SHR");

            //날짜 가져오기
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);

            params = "PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&SAL_GBN="+oSAL_GBN.value
                   + "&ENO_NO="+oENO_NO.value
                   + "&DTP_CD="+oDTP_CD.value;

			var url = "taxa040_PV.jsp?"+params;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        }

        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_RETACC.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_RETACC.GridToExcel("근로소득정산현황", '', 225);
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

            dsT_AC_RETACC.ClearData();

            fnc_ClearInputFieldAll(oExceptionList);
            document.getElementById("txtENO_NO_SHR").value = "";

            document.getElementById("txtPIS_YM_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            document.getElementById("cmbSAL_GBN_SHR").selectedIndex = 1;
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_RETACC.IsUpdated)  {
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
            cfStyleGrid(form1.grdT_AC_RETACC,0,"false","true");      // Grid Style 적용

			form1.grdT_AC_RETACC.TitleHeight = 45;
            
            document.getElementById("txtPIS_YM_SHR").value = '2013-12';
            document.getElementById("cmbSAL_GBN_SHR").selectedIndex = 1;

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
        var oElementList = new Array(    "txtPIS_YM_SHR"
                                        ,"cmbOCC_CD_SHR"
                                        ,"cmbSAL_GBN_SHR");

        //항목들의 메세지
        var oElementMsgList = new Array( "정산년월"
                                        ,"근로구분"
                                        ,"정산구분");

        //예외 항목들
        var oExceptionList = new Array(  "cmbOCC_CD_SHR");




    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_RETACC)                |
    | 3. 사용되는 Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETACC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=SubsumExpr          value="total">
    </Object>


    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_RETACC)                |
    | 3. 사용되는 Table List(T_AC_RETACC)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETACC" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_AC_RETACC Event="OnLoadCompleted(iCount)">
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
    <Script For=dsT_AC_RETACC Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnSuccess()">

    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnFail()">
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">근로소득정산현황</td>
                    <td align="right" class="navigator">HOME/정산세무/정산세무/<font color="#000000">근로소득정산현황</font></td>
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
                    <col width="100"></col>
                    <col width="180"></col>
                    <col width="90"></col>
                    <col width="140"></col>
                    <col width="90"></col>
                    <col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">정산년월</td>
					<td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','134','108');"></a>
					</td>
                    <td class="searchState" align="right">정산구분</td>
                    <td class="padding2423" align="left">
                        <select name="cmbSAL_GBN_SHR" id="cmbSAL_GBN_SHR">
                            <option value=""></option>
                            <option value="8">연말정산</option>
                            <option value="9">퇴직자정산</option>
                        </select>
                    </td>
				</tr>
                <tr>
                    <td class="searchState" align="right">부서</td>
                    <td class="padding2423" align="left">
                        <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                        <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
                            <img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')">
                        </a>
                    </td>
                    <td align="right" class="searchState">사번</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength="9" onkeypress="if(event.keyCode==13) cfNumberCheck(); fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled">
                        <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength="9" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
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
                    <object id="grdT_AC_RETACC" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:450px;">
                        <param name="DataID" value="dsT_AC_RETACC">
                        <param name="Editable" value="true">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <FC> id="{CUROW}"        width=40    height =150 align=center    name="NO"         value={String(Currow)}    SubSumText=""</FC>
                            <FC> id=RET_YN           width=60   align=center    name=재직     SubSumText="" Value={Decode(RET_YN,"","재직","퇴직")}</FC>
                            <FC> id=RET_YMD         width=70   align=center    name=퇴직일     SubSumText="" </FC>                       
                            <FC> id=DPT_NM           width=100   align=left    name=소속                          SubSumText=""</FC>
                            <FC> id=ENO_NO           width=55   align=center    name=사번                          SubSumText=""</C>
                            <FC> id=ENO_NM           width=55   align=center    name=성명                          SubSumText=""</FC>
                            <C> id=CET_NO           width=100   align=center    name=주민번호                          SubSumText=""</C>
                            <C> id=JOB_NM           width=75   align=center    name=직위                          SubSumText=" 합 계 "</FC>
                            <C> id=PAYD_AMTS        width=100   align=right     rightmargin=10    name=주현급여총액                  show=false</C>
                            <C> id=PAYD_AMTB        width=100   align=right     rightmargin=10    name=주현상여총액                  show=false</C>
                            <C> id=PAYD_TOT         width=100   align=right     rightmargin=10    name=주현급여총액                value={PAYD_AMTS+PAYD_AMTB} show=false</C>
                            <C> id=OUTT_AMTS        width=100   align=right     rightmargin=10    name=주현해외급여총액              show=false</C>
                            <C> id=OUTT_AMTB        width=100   align=right     rightmargin=10    name=주현해외상여총액              show=false</C>
                            <C> id=OUTT_TOT         width=100   align=right     rightmargin=10    name=주현해외급상여총액            show=false value={OUTT_AMTS+OUTT_AMTB} </C>
                            <C> id=JAA_AMT          width=100   align=right     rightmargin=10    name=종전급여총액                  show=false</C>
                            <C> id=JAC_AMT          width=100   align=right     rightmargin=10    name=종전상여총액                  show=false</C>
                            <C> id=JA1_AMT          width=100   align=right     rightmargin=10    name="종전급상여;총액"          show=false      value={JAA_AMT+JAC_AMT} </C>
                            <C> id=JAB_AMT          width=100   align=right     rightmargin=10    name=종전해외급여총액              show=false</C>
                            <C> id=JAD_AMT          width=100   align=right     rightmargin=10    name=종전해외상여총액              show=false</C>
                            <C> id=JA2_AMT          width=100   align=right     rightmargin=10    name=종전해외급상여총액           show=false value={JAB_AMT+JAD_AMT} </C>
                            <C> id=FREE_INCOME      width=100   align=right     rightmargin=10    name="주현비과세;소득"          show=false      </C>
                            <C> id=JAG_AMT          width=100   align=right     rightmargin=10    name="종전비과세;소득"            show=false    </C>
                            <C> id=FREE_IN1         width=100   align=right     rightmargin=10    name=비과세소득계                 show=false value={JAG_AMT+FREE_INCOME} </C>
                            <C> id=TAX_INCOME       width=100   align=right     rightmargin=10    name=과세대상급여                 BgColor=#FAFAD2 </C>
                            <C> id=MGR_AMT          width=100   align=right     rightmargin=10    name="근로소득;공제액"                </C>
                            <C> id=MNI_AMT          width=100   align=right     rightmargin=10    name=근로소득금액                  BgColor=#FABBCC </C>
                            <C> id=BADD_AMT         width=100   align=right     rightmargin=10    name=본인공제액                    </C>
                            <C> id=SPSB_AMT         width=100   align=right     rightmargin=10    name=배우자공제액                  </C>
                            <C> id=DFM_CNT          width=100   align=right     rightmargin=10    name="부양가족;공제수"                </C>
                            <C> id=GDED_AMT         width=100   align=right     rightmargin=10    name="부양가족;공제액"                </C>
                            <C> id=GOL_CNT          width=100   align=right     rightmargin=10    name="경로우대;공제수"                </C>
                            <C> id=GOL_AMT          width=100   align=right     rightmargin=10    name="경로우대;공제액"                </C>
                            <C> id=TRB_CNT          width=100   align=right     rightmargin=10    name=장애자공제수                  </C>
                            <C> id=TBL_DED          width=100   align=right     rightmargin=10    name=장애자공제액                  </C>
                            <C> id=WDD_AMT          width=100   align=right     rightmargin=10    name=부녀자공제액                  </C>
                            <C> id=RCH_CNT          width=100   align=right     rightmargin=10    name="6세이하;공제수"                </C>
                            <C> id=RCH_AMT          width=100   align=right     rightmargin=10    name="6세이하;공제액"                </C>
                            <C> id=INP_CNT          width=100   align=right     rightmargin=10    name="출산입양;공제수"                </C>
                            <C> id=INP_AMT          width=100   align=right     rightmargin=10    name="출산입양;공제액"                </C>                            

                            <C> id=CHI_CNT          width=100   align=right     rightmargin=10    name=다자녀공제수               </C>                                         
                            <C> id=SMD_AMT          width=100   align=right     rightmargin=10    name=다자녀공제액                      </C>
 
                            <C> id=PER_TOT          width=100   align=right     rightmargin=10    name=인적공제계                    BgColor=#FAFA11</C>

                            <C> id=PER_TOT1          width=100   align=right     rightmargin=10    name=인적공제계2    show=false value={BADD_AMT+SPSB_AMT+GDED_AMT+GOL_AMT+TBL_DED+WDD_AMT+RCH_AMT+INP_AMT+SMD_AMT}          BgColor=#FAFAD2</C>
                            
                            
                            <C> id=NPEN_AMT         width=100   align=right     rightmargin=10    name=국민연금료                    </C>
                            <C> id=NPEN_DED         width=100   align=right     rightmargin=10    name="연금보험료;공제계"              BgColor=#1188D2</C>
                            <C> id=HINU_AMT         width=100   align=right     rightmargin=10    name=건강보험료                    </C>
                            <C> id=OLD_AMT         width=100   align=right     rightmargin=10    name=노인장기요양                    </C>
                            
                            <C> id=HINS_AMT         width=100   align=right     rightmargin=10    name=고용보험료                    </C>
                            <C> id=LIN_AMT          width=100   align=right     rightmargin=10    name=보장성보험료                  </C>
                            <C> id=LIN_DED          width=100   align=right     rightmargin=10    name="보장성보험료;공제액"            </C>
                            <C> id=LIH_AMT          width=100   align=right     rightmargin=10    name="장애인전용;보험료"              </C>
                            <C> id=LIH_DED          width=100   align=right     rightmargin=10    name="장애인보험료;공제액"            </C>
                            <C> id=MIN_DED          width=100   align=right     rightmargin=10    name=보험료공제액                  BgColor=#FAFAD2</C>
                            
                            <C> id=LMA_AMT          width=100   align=right     rightmargin=10    name=일반의료비                    show=false</C>
                            <C> id=LF2_AMT          width=100   align=right     rightmargin=10    name="본인;장애경로;의료비"  show=false</C>

                            <C> id=MHEA_AMT          width=100   align=right     rightmargin=10    name="본인;65세이상;의료비"   </C>

                            <C> id=LF2_AMT          width=100   align=right     rightmargin=10    name="장애의료비"   </C>

                            <C> id=OHEA_AMT          width=100   align=right     rightmargin=10    name=그밖의의료비                    </C>
                                                        
                            <C> id=MMA_DED          width=100   align=right     rightmargin=10    name=의료비공제액                  BgColor=#FAFAD2</C>
                            
                            <C> id=LED_AMT          width=100   align=right     rightmargin=10    name=본인교육비                    </C>
                            
                            <C> id=LEF_AMT          width=100   align=right     rightmargin=10    name=가족교육비                    </C>
                            
                            <C> id=EDU_DED          width=100   align=right     rightmargin=10    name=교육비공제액                  BgColor=#FAFAD2</C>
                            <C> id=LHO_AMT          width=100   align=right     rightmargin=10    name=주택자금저축                  </C>
                            <C> id=LH1_AMT          width=100   align=right     rightmargin=10    name="주택원리금;상환액"              </C>
                            <C> id=LH2_AMT          width=100   align=right     rightmargin=10    name="장기주택저당;차입금;이자지급액"  </C>
                            <C> id=HOS_DED          width=100   align=right     rightmargin=10    name="주택자금;공제액"                BgColor=#FAFAD2</C>
                            <C> id=GOV_AMT          width=100   align=right     rightmargin=10    name=정치자금                      </C>
                            <C> id=LC3_AMT          width=100   align=right     rightmargin=10    name=법정기부금                    </C>
                            <C> id=LC2_AMT          width=100   align=right     rightmargin=10    name=지정기부금                    </C>

                            <C> id=CPC_DED          width=100   align=right     rightmargin=10    name=기부금공제액                  BgColor=#FAFAD2</C>
                            <C> id=NSE_TOT          width=100   align=right     rightmargin=10    name=특별공제계                    BgColor=#99FF22</C>
                            <C> id=LF1_AMT          width=100   align=right     rightmargin=10    name="개인연금;저축액"                </C>
                            <C> id=PER_SAV          width=100   align=right     rightmargin=10    name="개인연금;저축공제액"            BgColor=#FAFAD2</C>
                            <C> id=ANN_AMT          width=100   align=right     rightmargin=10    name=연금저축액                    </C>
                            <C> id=ANN_DED          width=100   align=right     rightmargin=10    name="연금저축;공제액"                BgColor=#FAFAD2</C>
                            <C> id=VEN_AMT          width=100   align=right     rightmargin=10    name=투자조합출자액               show=false </C>
                            <C> id=VEN_DED          width=100   align=right     rightmargin=10    name=투자조합출자공제액          show=false  BgColor=#FAFAD2</C>
                            <C> id=CARD_AMT         width=100   align=right     rightmargin=10    name="신용카드;사용액"                </C>
                            <C> id=CARD_DED         width=100   align=right     rightmargin=10    name="신용카드;공제액"                BgColor=#FAFAD2</C>

                            <C> id=GOV_DED          width=100   align=right     rightmargin=10    name="정치자금;공제액"        show=false          BgColor=#FAFAD2</C>
                            <C> id=SPC_TOT          width=100   align=right     rightmargin=10    name=조특법공제합                  BgColor=#FAFAD2 show=false </C>
                            <C> id=TTAX_STD         width=100   align=right     rightmargin=10    name=종합과세표준                  </C>
                            <C> id=TAX_AMT          width=100   align=right     rightmargin=10    name=산출세액                        BgColor=#AAFAD2</C>
                            
                           <G> name=세액공제 BgColor="#F7DCBB"
                            <C> id=HGR_DED          width=100   align=right     rightmargin=10    name="근로소득;세액공제"              </C>
                            <C> id=GOV_DED          width=100   align=right     rightmargin=10    name="정치자금;세액공제"              </C>                            
                            <C> id=STX_DED          width=100   align=right     rightmargin=10    name=재형저축세액공제             show=false </C>   
                            <C> id=HTX_DED          width=100   align=right     rightmargin=10    name=주택자금이자세액공제       show=false   </C>
                            <C> id=OTX_DED          width=100   align=right     rightmargin=10    name=외국납부세액공제              show=false</C>
                            <C> id=HSX_DED          width=100   align=right     rightmargin=10    name=근로자주식저축세액공제     show=false   </C>
                            <C> id=LSX_DED          width=100   align=right     rightmargin=10    name=장기주식저축세액공제         show=false </C>
                            <C> id=TDED_TOT         width=100   align=right     rightmargin=10    name=세액공제합                    BgColor=#FAFAD2</C>
                            <C> id=TAX_DED          width=100   align=right     rightmargin=10    name=세액감면합                    show=false</C>
                           </G> 

                           <G> name=결정세액 BgColor="#F7DCBB"                            
                            <C> id=DGG_TAX          width=100   align=right     rightmargin=10    name=결정소득세                   </C>
                            <C> id=DJM_TAX          width=100   align=right     rightmargin=10    name=결정주민세                   </C>
                            <C> id=AAA_TOT          width=100   align=right     rightmargin=10    name=결정세액계                    value={DGG_TAX+DJM_TAX+DBW_TAX}   BgColor=#FAFAD2</C>
                            
                           <G> name=납부세액 BgColor="#F7DCBB"                            
                            <C> id=JAL_AMT          width=100   align=right     rightmargin=10    name=종전납소득세                  </C>
                            <C> id=JAN_AMT          width=100   align=right     rightmargin=10    name=종전납주민세                  </C>
                            <C> id=BBB_TOT          width=100   align=right     rightmargin=10    name=종전계                        value={JAL_AMT+JAM_AMT+JAN_AMT} BgColor=#FAFAD2</C>
                            <C> id=INCM_TAX         width=100   align=right     rightmargin=10    name=주현소득세                    </C>
                            <C> id=CITI_TAX         width=100   align=right     rightmargin=10    name=주현주민세                    </C>
                            <C> id=CCC_TOT          width=100   align=right     rightmargin=10    name=주현계                        value={INCM_TAX+CONT_TAX+CITI_TAX} BgColor=#FAFAD2</C>
                            </G>                            

                           <G> name=환급세액 BgColor="#F7DCBB"                             
                            <C> id=DRE_INTX1        width=100   align=right     rightmargin=10    name=징수소득세                    value={if(DRE_INTX>0, DRE_INTX, 0)} show=false</C>
                            <C> id=DRE_CTTX1        width=100   align=right     rightmargin=10    name=징수주민세                    value={if(DRE_CTTX>0, DRE_CTTX, 0)} show=false</C>
                            <C> id=DDD_TOT          width=100   align=right     rightmargin=10    name=징수세액계                    value={DRE_INTX+DRE_DFTX+DRE_CTTX} show=false</C>                           
                            
                            <C> id=DRE_INTX        width=100   align=right     rightmargin=10    name=환급소득세                    </C>
                            <C> id=DRE_CTTX        width=100   align=right     rightmargin=10    name=환급주민세                    </C>
                            <C> id=EEE_TOT          width=100   align=right     rightmargin=10    name=환급세액계                    value={DRE_INTX+DRE_CTTX} BgColor=#FFAADD</C>
                            </G>                         
                        
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
