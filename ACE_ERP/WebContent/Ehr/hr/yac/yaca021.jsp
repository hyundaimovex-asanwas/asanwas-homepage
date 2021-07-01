<!--*************************************************************************
* @source      : yaca021.jsp                                                *
* @description : 부양가족사항 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/18            조정호             최초작성                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%

     String ROLE_CD = box.getString("SESSION_ROLE_CD");
     String YAC_AUTHO    = box.getString("SESSION_YAC_AUTHO");
     //String ENO_NO       = box.getString("SESSION_ENONO");


     //ROLE_CD가 IT인지 여부
     boolean itMaster = false;

     if(ROLE_CD.equals("1001")) {
	 itMaster = true;
     }

     //관리자인지 아닌지 여부
     //boolean isMaster = false;

     //if(YAC_AUTHO.equals("M")) {
     // isMaster = true;
     // }

     // 강제 권한
     //boolean open_yn = false;

     //if(ENO_NO.equals("19511030")) {
     //   open_yn = true;
     //  }

%>


<html>
<head>
    <title>부양가족사항(yaca021)</title>
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
                    + "T"   //신규
                    + "T"   //저장
                    + "T"   //취소
                    + "F"   //엑셀
                    + "F"   //인쇄
                    + "T"   //삭제
                    + "T";  //닫기

        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca021.cmd.YACA021CMD";
        var params = null;

        var PIS_YY = "<%=request.getParameter("PIS_YY") %>";
        var ENO_NO = "<%=request.getParameter("ENO_NO") %>";

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            var oPIS_YY = document.getElementById("txtPIS_YY");
            var oBNK_CD = document.getElementById("cmbBNK_CD");

            params = "&S_MODE=SHR"
                   + "&PIS_YY="+PIS_YY
                   + "&ENO_NO="+ENO_NO;

            dsT_AC_FAMILY.dataid = dataClassName+params;
            dsT_AC_FAMILY.reset();
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
            // 삭제 할 자료가 있는지 체크하고
            if (dsT_AC_FAMILY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                alert("* 삭제 할 자료가 없습니다!");
                return;
            }

            if(dsT_AC_FAMILY.NameValue(dsT_AC_FAMILY.RowPosition, "REL_NM") == "본인"){
                alert("본인 자료는 삭제할 수 없습니다.");
                return false;

            }

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm(dsT_AC_FAMILY.NameValue(dsT_AC_FAMILY.RowPosition, "NAM_KOR")+" [" + dsT_AC_FAMILY.NameValue(dsT_AC_FAMILY.RowPosition, "CET_NO") + "] 자료를 제거하시겠습니까?") == false) return;

            //DataSet을 입력상태로 변경
            dsT_AC_FAMILY.UseChangeInfo = false;

            params = "&S_MODE=DEL"
                   + "&PIS_YY="+PIS_YY
                   + "&ENO_NO="+ENO_NO
                   + "&ROW_ID="+dsT_AC_FAMILY.RowPosition;

            trT_AC_FAMILY.KeyValue = "TR_SAV(I:dsT_AC_FAMILY=dsT_AC_FAMILY)";
            trT_AC_FAMILY.Action = dataClassName+params;
            trT_AC_FAMILY.post();
            fnc_SearchList();
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
            if (dsT_AC_FAMILY.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_FAMILY.GridToExcel("부양가족사항", '', 225);
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

            dsT_AC_FAMILY.ClearData();
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            window.close();
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
            cfStyleGrid(form1.grdT_AC_FAMILY,0,"false","false");      // Grid Style 적용

            //내역 조회
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
        var oElementList = new Array(    "txtPIS_YY"
                                        ,"cmbBNK_CD");

        //항목들의 메세지
        var oElementMsgList = new Array( "기준연도"
                                        ,"보험회사구분");

        //예외 항목들
        var oExceptionList = new Array(  );

        /**
         * 부양가족사항등록
         */
        function fnc_RegFamily() {
            var href_page = "/hr/yac/yaca022.jsp"
                          + "?TYPE=INS"
                          + "&PIS_YY="+PIS_YY
                          + "&ENO_NO="+ENO_NO;

            window.showModalDialog(href_page, "", "dialogWidth:480px; dialogHeight:678px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
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
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_FAMILY)                |
    | 3. 사용되는 Table List(T_AC_FAMILY)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_AC_FAMILY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_FAMILY)                |
    | 3. 사용되는 Table List(T_AC_FAMILY)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_FAMILY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
        document.getElementById("txtPIS_YY_SHR").value      = getTodayArray()[0];
        document.getElementById("txtENO_NO_SHR").value      = dsT_CM_PERSON.NameValue(1, "ENO_NO"   );
        document.getElementById("txtENO_NM_SHR").value      = dsT_CM_PERSON.NameValue(1, "ENO_NM"   );
        document.getElementById("txtOCC_NM_SHR").value      = dsT_CM_PERSON.NameValue(1, "OCC_NM"   );
        document.getElementById("txtDPT_NM_SHR").value      = dsT_CM_PERSON.NameValue(1, "DPT_NM"   );
        document.getElementById("txtJOB_NM_SHR").value      = dsT_CM_PERSON.NameValue(1, "JOB_NM"   );
        document.getElementById("txtCET_NO_SHR").value      = dsT_CM_PERSON.NameValue(1, "CET_NO"   );
        document.getElementById("txtADDRESS_SHR").value     = dsT_CM_PERSON.NameValue(1, "ADDRESS"  );
    </Script>

    <Script For=dsT_AC_FAMILY Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("검색하신 조건의 자료가 없습니다!");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_01");
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_AC_FAMILY Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_AC_FAMILY Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_AC_FAMILY event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("작업을 완료 하였습니다!");

        fnc_SearchList();
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_FAMILY event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Grid OnDblClick event 처리                                   |
    +------------------------------------------------------>
    <script language="javascript" for=grdT_AC_FAMILY event=OnDblClick(row,colid)>
        var href_page = "/hr/yac/yaca022.jsp"
                      + "?TYPE=UPT"
                      + "&PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&CET_NO="+dsT_AC_FAMILY.NameValue(row, "CET_NO");

        window.showModalDialog(href_page, "", "dialogWidth:480px; dialogHeight:678px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
        fnc_SearchList();
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
    <table width="660" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">부양가족사항</td>
                    <td align="right" class="navigator">HOME/정산세무/연말정산/<font color="#000000">부양가족사항</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- 타이틀 바 테이블 끝 -->

    <!-- 버튼 테이블 시작 -->
    <table width="660" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="left">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgFamilyRegistration','','/images/common/btnFamilyRegistration.gif',1)"><img src="/images/common/btnFamilyRegistration.gif" name="imgFamilyRegistration" width="130" height="25" border="0" align="absmiddle" onClick="fnc_RegFamily()"></a>
            </td>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
<%
    if(itMaster){    //  ||(open_yn)) 강제권한
%>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
<%  }
%>

                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

    <!-- 조회 상태 테이블 시작 -->
    <table width="660" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop5">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                        <td align="right" valign="bottom" class="searchState">※상세내역를 원하시면 해당내역을 더블클릭 하세요.</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->


    <!-- 내용 조회 그리드 테이블 시작-->
	<table width="660" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_AC_FAMILY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:660px;height:315px;">
						<param name="DataID" value="dsT_AC_FAMILY">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='

                            <FC> id=NO          width=24        align=center       name=NO                suppress=2  </FC>
                            <FC> id=REL_NM      width=106       align=center       name=관계              suppress=2  </FC>
                            <FC> id=NAM_KOR     width=55        align=center       name=성명              suppress=2  </FC>
                            <C> id=CET_NO       width=95        align=center       name=주민번호          suppress=2  </C>
                            <C> id=BAS_MAN      width=53        align=center       name=기본공제          suppress=2  </C>
                            <C> id=GOL_65       width=50        align=center       name="경로;(65~69)"    suppress=2  </C>
                            <C> id=GOL_70       width=53        align=center       name="경로;(70이상)"   suppress=2  </C>
                            <C> id=TRB_MAN      width=50        align=center       name=장애인            suppress=2  </C>
                            <C> id=WCT_MAN      width=50        align=center       name=부녀자            suppress=2  </C>
                            <C> id=RCH_MAN      width=53        align=center       name=자녀양육          suppress=2  </C>
                            <C> id=CHI_MAN      width=50        align=center       name=다자녀            suppress=2  </C>
                            <C> id=GBN_NM       width=70        align=center       name=구분                </C>
                            <C> id=LIN_AMT      width=70        align=right        name=보험료              </C>
                            <C> id=MED_AMT      width=70        align=right        name=의료비              </C>
                            <C> id=EDU_AMT      width=70        align=right        name=교육비              </C>
                            <C> id=CARD_AMT     width=70        align=right        name=신용카드            </C>
                            <C> id=CASH_AMT     width=70        align=right        name=현금영수증          </C>
                            <C> id=SCH_AMT      width=70        align=right        name="학원비;지로납부액" </C>
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