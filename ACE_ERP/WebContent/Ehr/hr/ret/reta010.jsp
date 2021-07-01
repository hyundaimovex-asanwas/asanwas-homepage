<!--*************************************************************************
* @source      : reta010.jsp                                                *
* @description : 퇴직금중간정산신청 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/03/23            조정호             최초작성
* 2007/05/04            김학수             최초작성                         *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>퇴직연금가입자명단(reta010)</title>
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

        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ret.a.reta010.cmd.RETA010CMD";
        var params = null;

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            //검색조건
            var oENO_NO = document.getElementById("txtENO_NO_SHR");

            params = "&S_MODE=SHR"
                   + "&ENO_NO="+oENO_NO.value;

            dsT_AC_RETTABLE.dataid = dataClassName+params;
            dsT_AC_RETTABLE.reset();
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


            trT_AC_RETTABLE.KeyValue = "reta(I:dsT_AC_RETTABLE=dsT_AC_RETTABLE)";
            trT_AC_RETTABLE.action = dataClassName+"&S_MODE=SAV";
            trT_AC_RETTABLE.post();

        }

        /********************************************
         * 04. 삭제 함수                                *
         ********************************************/
        function fnc_Delete() {
            // 삭제 할 자료가 있는지 체크하고
            if (dsT_AC_RETTABLE.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[성명:"+dsT_AC_RETTABLE.NameString(dsT_AC_RETTABLE.RowPosition, "ENO_NM")+"]의 자료를 제거하시겠습니까?") == false) return;
            dsT_AC_RETTABLE.DeleteRow(dsT_AC_RETTABLE.RowPosition);

            trT_AC_RETTABLE.KeyValue = "SVL(I:dsT_AC_RETTABLE=dsT_AC_RETTABLE)";
            trT_AC_RETTABLE.Action = dataClassName+"&S_MODE=DEL";
            trT_AC_RETTABLE.post();
        }

        /********************************************
         * 05. 인쇄 함수                                *
         ********************************************/
        function fnc_Print() {

            //검색조건
            var oENO_NO = document.getElementById("txtENO_NO_SHR");
            var rownum = document.getElementById("cmbSEQ_NO").value;
            var param = "ENO_NO="+oENO_NO.value+"&rownum="+rownum;

            var url = "reta010_PV.jsp?"+param;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

        }

        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_RETTABLE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_RETTABLE.GridToExcel("퇴직연금가입자명단", '', 225);
        }

        /********************************************
         * 07. 신규 함수                                *
         ********************************************/
        function fnc_AddNew() {
            // 해당 Dataset의 Header가 없으면 검색이 되지 않았다는 것으로 간주하고 종료
            if (dsT_AC_RETTABLE.CountColumn == 0) {
                alert("리스트를 조회하지 않았습니다.");
                return;
            }


            dsT_AC_RETTABLE.AddRow();

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
            dsT_AC_RETTABLE.ClearData();
            //fnc_DisableElementAll(oElementList);
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_RETTABLE.IsUpdated)  {
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
            cfStyleGrid(form1.grdT_AC_RETTABLE,0,"false","false");      // Grid Style 적용




<%
    //관리자가 아니면 사번 검색을 사용할 수 없다.
    if(!box.getString("SESSION_ROLE_CD").equals("1001")
            && !box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            fnc_ChangeStateElement(false, "ImgEnoNo");
<%
    }
%>

            //사번을 로그인한 사번으로 설정한 다음 기본정보를 가져온다.
            var oENO_NO = document.getElementById("txtENO_NO_SHR");
            //oENO_NO.value = "<%=ls_UserId %>";

            //사원정보를 가져오고 등록한 중간정산 리스트를 가져온다.
            fnc_SearchEmpNo();
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


        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup("txtENO_NO_SHR");

            fnc_SearchEmpNo();
        }

        /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */
        function fnc_SearchEmpNm() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetEnoNo('txtENO_NM_SHR', 'txtENO_NO_SHR');

            fnc_SearchEmpNo();
        }


        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            //검색조건
            var oENO_NO = document.getElementById("txtENO_NO_SHR").value;

            dsT_CM_PERSON.dataid = dataClassName+"&S_MODE=SHR_EMP&ENO_NO="+oENO_NO;
            dsT_CM_PERSON.reset();

            fnc_SearchList();
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
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)                |
    | 3. 사용되는 Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_AC_RETTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_RD"/>
       <jsp:param name="CODE_GUBUN"    value="RD"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_RETTABLE)                |
    | 3. 사용되는 Table List(T_AC_RETTABLE)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETTABLE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

    </Script>

    <Script For=dsT_AC_RETTABLE Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            //alert("검색하신 조건의 자료가 없습니다!");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_RETTABLE.CountRow);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETTABLE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETTABLE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETTABLE event="OnSuccess()">
        fnc_SearchList();
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETTABLE event="OnFail()">
        alert(trT_AC_RETTABLE.ErrorMsg);
    </script>

    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_AC_RETTABLE event=OnRowPosChanged(row)>


    </script>

    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_AC_RETTABLE event=CanRowPosChange(row)>
        var keyName;
        var colName;
    </script>

    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">퇴직연금 가입자명단</td>
                    <td align="right" class="navigator">HOME/정산세무/퇴직금관리/<font color="#000000">퇴직연금 가입자명단</font></td>
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
                <img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)" style="cursor:hand;">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                    <col width="240"></col>
                                    <col width="*"></col>
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchState">사&nbsp;&nbsp;번&nbsp;</td>
                                    <td class="padding2423">
                                        <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="10" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR');" onChange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                                        <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="14" maxlength= "14"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR', 'txtENO_NM_SHR');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR');">
                                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
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
<table border="0"><tr><td height="10"></td></tr></table>
	<!-- 조건 입력 테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <tr>
                        <td align="center" class="table_cream">
                            <table width="100%" border="1" cellspacing="0" cellpadding="0">
                                <colgroup>
                                    <col width="100"></col>
                                    <col width="140"></col>
                                    <col width="100"></col>
                                    <col width="140"></col>
                                    <col width="100"></col>
                                    <col width="*"></col>
                                </colgroup>
                                <tr>
                                    <td align="center" class="creamBold"">사&nbsp;&nbsp;번</td>
                                    <td class="padding2423">
                                        <input id="txtENO_NO" name="txtENO_NO" style="width:70%" onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO', 'txtENO_NM');" onChange="fnc_GetCommonEnoNm('txtENO_NO','txtENO_NM');">
                                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo1" name="ImgEnoNo1" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                                    </td>
                                    <td align="center" class="creamBold">성&nbsp;&nbsp;명</td>
                                    <td class="padding2423">
                                        <input id="txtENO_NM" name="txtENO_NM" style="width:100%" onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO', 'txtENO_NM');" onchange="fnc_GetCommonEnoNo('txtENO_NO','txtENO_NM');">
                                    </td>
                                    <td align="center" class="creamBold">직&nbsp;&nbsp;&nbsp;위</td>
                                    <td class="padding2423" colspan="3">
                                        <input id="txtJOB_NM_SHR" name="txtJOB_NM_SHR" style="width:100%" class="input_ReadOnly" readonly>
                                    </td>
                                </tr>
                                <tr>
                                	<td align="center" class="creamBold">연금구분</td>
                                    <td class="padding2423">
										<select id="cmbRET_GBN" name="cmbRET_GBN" style="width:85">
				                            <option value="DB">DB</option>
				                            <option value="NW">미가입</option>
				                        </select>
                                    </td>
                                	<td align="center" class="creamBold">신규구분</td>
                                    <td class="padding2423">
                                        <input id="txtNEW_GBN" name="txtNEW_GBN" style="width:100%" >
                                    </td>
                                	<td align="center" class="creamBold">변경사항</td>
                                    <td class="padding2423">
                                        <input id="txtPRV_GBN" name="txtPRV_GBN" style="width:100%" >
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
	<!-- 조건 입력 테이블 시작 -->
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
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_AC_RETTABLE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_AC_RETTABLE">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"    width=30		align=center	    name="NO"         value={String(Currow)}</C>
                            <C> id=ENO_NO       width=70        align=center        name=사번               </C>
                            <C> id=ENO_NM       width=70        align=center        name=성명               </C>
                            <C> id=JOB_NM       width=70        align=center        name=직위               </C>
                            <C> id=RET_GBN      width=100       align=center        name=연금구분     value={DECODE(RET_GBN,"DB","DB","DC","DC","NW", "미가입")}</C>
                            <C> id=NEW_GBN      width=90        align=center        name=신규구분               </C>
                            <C> id=PRV_GBN      width=70        align=center        name=변경자             </C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
    <input type="hidden" name="rownum" value="1">
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


<!-- T_SV_SAVELIST 개인연금관리의 바인딩을 위해 -->
<object id="bndT_AC_RETTABLE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_AC_RETTABLE">
    <Param Name="BindInfo", Value='
        <C>Col=ENO_NO               Ctrl=txtENO_NO              Param=value     </C>
        <C>Col=ENO_NM               Ctrl=txtENO_NM              Param=value     </C>
        <C>Col=JOB_NM               Ctrl=txtJOB_NM_SHR              Param=value     </C>
        <C>Col=RET_GBN        	 Ctrl="cmbRET_GBN"        Param=value   </C>
        <C>Col=NEW_GBN           Ctrl=txtNEW_GBN        Param=value   </C>
        <C>Col=PRV_GBN           Ctrl=txtPRV_GBN        Param=value   </C>
    '>
</object>
