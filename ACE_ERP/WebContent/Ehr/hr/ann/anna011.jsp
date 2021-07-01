<!--
*****************************************************
* @source      : anna011.jsp
* @description : 복리후생/개인연금/개인연금관리(팝업)
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/07      조정호                   최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ page import="common.util.JSPUtil" %>

<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>개인연금관리</title>
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
        //params
        var ENO_NO = "<%=JSPUtil.rns(request.getParameter("ENO_NO")) %>";
        var ACC_NO = "<%=JSPUtil.rns(request.getParameter("ACC_NO")) %>";
        var SAV_CD = "<%=JSPUtil.rns(request.getParameter("SAV_CD")) %>";
        var BNK_CD = "<%=JSPUtil.rns(request.getParameter("BNK_CD")) %>";

        //단축키 순서
        var btnList = "T"   //조회
                    + "F"   //신규
                    + "F"   //저장
                    + "T"   //취소
                    + "T"   //엑셀
                    + "F"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ann.a.anna011.cmd.ANNA011CMD";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            if(ENO_NO == null) {
                alert("사번이 없습니다.");
                return;
            }
            if(ACC_NO == null) {
                alert("계좌번호가 없습니다.");
                return;
            }

            dsT_SV_SAVELIST.dataid = dataClassName+"&S_MODE=SHR&ENO_NO="+ENO_NO+"&ACC_NO="+ACC_NO+"&SAV_CD="+SAV_CD+"&BNK_CD="+BNK_CD;
            dsT_SV_SAVELIST.reset();
        }

        /**
         * 사원정보를 조회 한다.
         */
        function fnc_SearchEmp() {
            dsT_CM_PERSON.dataid = dataClassName+"&S_MODE=SHR_EMP&ENO_NO="+ENO_NO+"&ACC_NO="+ACC_NO+"&SAV_CD="+SAV_CD+"&BNK_CD="+BNK_CD;
            dsT_CM_PERSON.reset();

        }


        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_SV_SAVELIST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_SV_SAVELIST.GridToExcel("개인연금관리", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {
            window.close();
        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck(year) {

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_SV_SAVELIST,15,"false","false")      // Grid Style 적용

            fnc_SearchList();
            fnc_SearchEmp()
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                         |
    | 2. 이름 : dsT_SV_SAVELIST                       |
    | 3. Table List : T_SV_SAVELIST                 |
    +----------------------------------------------->
    <Object ID="dsT_SV_SAVELIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)                |
    | 3. 사용되는 Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>



    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_SV_SAVELIST Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_SV_SAVELIST Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>



<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 타이틀 바 테이블 시작 -->
<table width="630" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인연금관리</td>
					<td align="right" class="navigator">HOME/복리후생/개인연금/<font color="#000000">개인연금관리</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="630" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="630" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">

            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="90"></col>
                    <col width="110"></col>
                    <col width="90"></col>
                    <col width="110"></col>
                    <col width="90"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td class="creamBold" align="center">사원번호</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td class="creamBold" align="center">성&nbsp;&nbsp;&nbsp;명</td>
                    <td class="padding2423">
                        <input id="txtENO_NM" name="txtENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td class="creamBold" align="center">소&nbsp;&nbsp;&nbsp;속</td>
                    <td class="padding2423">
                        <input id="txtDPT_NM" name="txtDPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td class="creamBold" align="center">직&nbsp;&nbsp;&nbsp;위</td>
                    <td class="padding2423">
                        <input id="txtJOB_NM" name="txtJOB_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td class="creamBold" align="center">주민등록번호</td>
                    <td class="padding2423">
                        <input id="txtCET_NO" name="txtCET_NO" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td class="creamBold" align="center">입사일</td>
                    <td class="padding2423">
                        <input id="txtHIRG_YMD" name="txtHIRG_YMD" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td class="creamBold" align="center">직&nbsp;&nbsp;&nbsp;종</td>
                    <td class="padding2423">
                        <input id="txtOCC_NM" name="txtOCC_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td class="creamBold" align="center">계좌번호</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtACC_NO" name="txtACC_NO" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td class="creamBold" align="center">금융기관</td>
                    <td class="padding2423">
                        <input id="txtBNK_NM" name="txtBNK_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td class="creamBold" align="center">저축구분</td>
                    <td class="padding2423">
                        <input id="txtSAV_NM" name="txtSAV_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td class="creamBold" align="center">예금종류</td>
                    <td class="padding2423">
                        <input id="txtSAV_NM2" name="txtSAV_NM2" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>

        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="520" border="0" cellspacing="0" cellpadding="0">
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
<table width="630" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_SV_SAVELIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:630px;height:260px;">
							<param name="DataID"				value="dsT_SV_SAVELIST">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
                                <C> id=DED_YM       width=95       align=center        name=공제년월      </C>
                                <C> id=PIN_MTH      width=95       align=center        name=불입방법      </C>
                                <C> id=PIN_CNT      width=95       align=center        name=불입횟수      </C>
                                <C> id=TOTAL_SAV    width=95       align=center        name=불입누계액    </C>
                                <C> id=PYM_AMT      width=95       align=center        name=월불입액      </C>
                                <C> id=DED_TAG      width=95       align=center        name=공제여부      </C>
							">
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
<!-- T_CM_PERSON 조회해온 사원 정보를 창에 뿌려줌 -->
<object id="bndT_CM_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CM_PERSON">
	<Param Name="BindInfo", Value='
        <C>Col=ENO_NO               Ctrl=txtENO_NO              Param=value     </C>
        <C>Col=ENO_NM               Ctrl=txtENO_NM              Param=value     </C>
        <C>Col=DPT_NM               Ctrl=txtDPT_NM              Param=value     </C>
        <C>Col=JOB_NM               Ctrl=txtJOB_NM              Param=value     </C>
        <C>Col=CET_NO               Ctrl=txtCET_NO              Param=value     </C>
        <C>Col=HIRG_YMD             Ctrl=txtHIRG_YMD            Param=value     </C>
        <C>Col=OCC_NM               Ctrl=txtOCC_NM              Param=value     </C>
        <C>Col=ACC_NO               Ctrl=txtACC_NO              Param=value     </C>
        <C>Col=BNK_NM               Ctrl=txtBNK_NM              Param=value     </C>
        <C>Col=SAV_NM               Ctrl=txtSAV_NM              Param=value     </C>
        <C>Col=SAV_NM2              Ctrl=txtSAV_NM2             Param=value     </C>
    '>
</object>

