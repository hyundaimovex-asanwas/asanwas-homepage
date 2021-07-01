<!--*************************************************************************
* @source      : reta050.jsp                                                *
* @description : 퇴직금예상금액조회 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/03/23      조정호        최초작성                                    *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>퇴직금예상금액조회(reta050)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language="javascript" src="/common/dateformat.js"></script>
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
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ret.a.reta050.cmd.RETA050CMD";
        var params = null;

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            //검색유효성 검사
            if(!fnc_SearchItemCheck()) return;

            //검색조건
            var oENO_NO = document.getElementById("txtENO_NO_SHR");
            var oYMD = document.getElementById("txtYMD_SHR");
            var oHIRG_YMD = document.getElementById("txtHIRG_YMD");
            var oRET_YMD = document.getElementById("txtRET_YMD");

            //선택한 계산기간의 마지막을 넣음
            oRET_YMD.value = oYMD.value;

            params = "&S_MODE=SHR"
                   + "&ENO_NO="     +oENO_NO.value
                   + "&HIRG_YMD="   +oHIRG_YMD.value
                   + "&RET_YMD="    +oRET_YMD.value
                   + "&YMD="        +oRET_YMD.value;

            //리턴받을 DataSet 설정
            trT_AC_RETINFO.KeyValue = "tr02"
                                    + "(O:dsT_AC_RETINFO=dsT_AC_RETINFO"
                                    + ",O:dsT_AC_RETMASTER=dsT_AC_RETMASTER"
                                    + ")";

			trT_AC_RETINFO.action = dataClassName+params;
			trT_AC_RETINFO.post();
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
            if (dsT_AC_RETINFO.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_RETINFO.GridToExcel("퇴직금예상금액조회", '', 225);
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
            dsT_AC_RETINFO.ClearData();
            dsT_AC_RETMASTER.ClearData();
            fnc_ClearInputFieldAll(new Array("txtENO_NO_SHR")); //모든 입력창들 초기화
//            document.getElementById("txtENO_NO_SHR").value = "";
			fnc_OnLoadProcess();//초기화작업 진행
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_RETINFO.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. 검색 조건 유효성 검사                     *
         ********************************************/
        function fnc_SearchItemCheck() {
	        //cfCheckDateTerm('txtYMD_SHR','txtHIRG_YMD','txtYMD_SHR');
            return fnc_CheckElement(oElementList, oElementMsgList);
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

			var oToday = getToday()
            document.getElementById('txtENO_NO_SHR').value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById('txtENO_NM_SHR').value = '<%=box.get("SESSION_ENONM")%>';

            fnc_SearchEmpNo();
<%
    if(box.getString("SESSION_ROLE_CD").equals("1001")
            || box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
    	    document.getElementById("txtENO_NO_SHR").disabled = false;
    	    document.getElementById("txtENO_NM_SHR").disabled = false;
    	    document.getElementById("ImgEnoNo").disabled = false;
<%
    } else  {
%>
    	    document.getElementById('txtENO_NO_SHR').readOnly = true;
            document.getElementById('txtENO_NO_SHR').className = "input_ReadOnly";
    	    document.getElementById("txtENO_NM_SHR").readOnly = true;
            document.getElementById('txtENO_NM_SHR').className = "input_ReadOnly";
    	    document.getElementById("ImgEnoNo").disabled = true;
<%
    }
%>

            //첫번째 인수 : 그리드명
            //두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
            //세번째 인수 : 그리드모드(false:읽기, true:쓰기)
            //네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
            cfStyleGrid(form1.grdT_AC_RETMASTER,0,"false","false");      // Grid Style 적용
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
        var oElementList = new Array(    "txtENO_NO_SHR"
                                        ,"txtENO_NM_SHR"
                                        ,"txtYMD_SHR");

        //항목들의 메세지
        var oElementMsgList = new Array( "사번"
                                        ,"성명"
                                        ,"정산일자");
        //예외 항목들
        var oExceptionList = new Array(  );


        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmpNo();
            }
        }

        /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */
        function fnc_SearchEmpNm() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");
            fnc_SearchEmpNo();
        }

        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

            fnc_ClearInputFieldAll(new Array("txtENO_NO_SHR"));
            if(document.getElementById("txtENO_NO_SHR").value != "") {

                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
                document.getElementById("txtHIRG_YMD_SHR").value    = obj.hirg_ymd;
                document.getElementById("txtOCC_NM_SHR").value      = obj.occ_cd+" "+obj.occ_nm;
                document.getElementById("txtOCC_CD_SHR").value      = obj.occ_cd;
                document.getElementById("txtDPT_NM_SHR").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM_SHR").value      = obj.job_nm;
                document.getElementById("txtRET_YMD_SHR").value     = obj.ret_ymd;
                document.getElementById("txtRAM_YMD_SHR").value     = obj.ram_ymd;
                document.getElementById("txtRAM_YMD2_SHR").value    = obj.ram_ymd2;
                document.getElementById("txtRAM_YMD3_SHR").value    = obj.ram_ymd3;
                document.getElementById("txtHIRR_YMD_SHR").value    = obj.hirr_ymd;

                var prev = prev_month(getTodayArray()[0]+"-"+getTodayArray()[1]).split("-");
                document.getElementById("txtDSP_YMD").value = prev[0]+"-"+prev[1];
                document.getElementById("txtYMD_SHR").value = prev[0]+"-"+prev[1]+"-"+fnc_Lastday(prev[0], prev[1]);
            } else {
                document.getElementById("txtENO_NM_SHR").value      = "";
                document.getElementById("txtHIRG_YMD_SHR").value    = "";
                document.getElementById("txtOCC_NM_SHR").value      = "";
                document.getElementById("txtOCC_CD_SHR").value      = "";
                document.getElementById("txtDPT_NM_SHR").value      = "";
                document.getElementById("txtJOB_NM_SHR").value      = "";
                document.getElementById("txtRET_YMD_SHR").value     = "";
                document.getElementById("txtRAM_YMD_SHR").value     = "";
                document.getElementById("txtRAM_YMD2_SHR").value    = "";
                document.getElementById("txtRAM_YMD3_SHR").value    = "";
                document.getElementById("txtDSP_YMD").value         = "";
                document.getElementById("txtYMD_SHR").value         = "";
                document.getElementById("txtHIRR_YMD_SHR").value    = "";
            }


            //계산기간의 시작일을 바인딩
            bindingTenure();
        }



        /**
         * 재직 기간을 설정한다.
         * (계산기간의 시작은 마지막 정산일을 기준으로 한다.)
         */
        function bindingTenure() {
            var oHIRG_YMD = document.getElementById("txtHIRG_YMD");
            var elementName = new Array(    "txtHIRR_YMD_SHR"   //입사일
                                           ,"txtRAM_YMD_SHR"   //중간정산일1
                                           ,"txtRAM_YMD2_SHR"   //중간정산일2
                                           ,"txtRAM_YMD3_SHR"   //중간정산일3
                                           ,"txtRET_YMD_SHR");  //퇴사일
            var element;
            var oDate;
            var vYMD;

            //입사일 계산
            for(i=0; i<4; i++) {
                element = document.getElementById(elementName[i]);
                if(element.value != "" && element.value != "undefined") {

                    if(i != 0) {
                        vYMD = element.value.split("-");
                        oDate = new Date(vYMD[0], vYMD[1]-1, vYMD[2]);
                        oDate.setDate(oDate.getDate()+1);
                        oHIRG_YMD.value = oDate.format("yyyy-mm-dd");
                    } else
                        oHIRG_YMD.value = element.value;

                } else {
                    break;
                }
            }

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
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_RETINFO)                |
    | 3. 사용되는 Table List(T_AC_RETINFO)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_AC_RETMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_RETINFO)                |
    | 3. 사용되는 Table List(T_AC_RETINFO)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETINFO" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_AC_RETMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            //alert("검색하신 조건의 자료가 없습니다!");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_RETINFO.CountRow);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETINFO Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>
    <Script For=dsT_AC_RETMASTER Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETINFO Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>
    <Script For=dsT_AC_RETMASTER Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETINFO event="OnSuccess()">
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETINFO event="OnFail()">
        alert(trT_AC_RETINFO.ErrorMsg);
    </script>

    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |
    +--------------------------->
    <script for=grdT_AC_RETINFO event=OnClick(Row,Colid)>

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">퇴직금예상금액조회</td>
                    <td align="right" class="navigator">HOME/정산세무/퇴직금관리/<font color="#000000">퇴직금예상금액조회</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
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
                                    <col width="110"></col>
                                    <col width="140"></col>
                                    <col width="100"></col>
                                    <col width="140"></col>
                                    <col width="100"></col>
                                    <col width="*"></col>
                                </colgroup>
                                <tr>

                                    <td align="center" class="searchState">사&nbsp;&nbsp;&nbsp;번</td>
                                    <td class="padding2423">
                                        <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="10" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                                        <input type="hidden" id="hidEMPL_DPT_CD">
                                    </td>
                                    <td align="center" class="searchState">성&nbsp;&nbsp;&nbsp;명</td>
                                    <td class="padding2423">
                                        <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="14" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                                    </td>


                                    <td align="center" class="searchState">입&nbsp;사&nbsp;일</td>
                                    <td class="padding2423">
                                        <input id="txtHIRG_YMD_SHR" name="txtHIRG_YMD_SHR" size="14" class="input_ReadOnly" readonly>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" class="searchState">직&nbsp;&nbsp;&nbsp;종</td>
                                    <td class="padding2423">
                                        <input id="txtOCC_NM_SHR" name="txtOCC_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                        <input id="txtOCC_CD_SHR" name="txtOCC_CD_SHR" type="hidden">
                                    </td>
                                    <td align="center" class="searchState">소&nbsp;&nbsp;&nbsp;속</td>
                                    <td class="padding2423">
                                        <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="center" class="searchState">직&nbsp;&nbsp;&nbsp;위</td>
                                    <td class="padding2423">
                                        <input id="txtJOB_NM_SHR" name="txtJOB_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" class="searchState">정산일자</td>
                                    <td class="padding2423" colspan="5">
                                        <input type="text"   id="txtDSP_YMD" size="7" class="input_ReadOnly" readonly>
                                        <input type="hidden" id="txtYMD_SHR" name="txtYMD_SHR">
                                        <input id="txtRET_YMD_SHR" name="txtRET_YMD_SHR" type="hidden">
                                        <input id="txtRAM_YMD_SHR" name="txtRAM_YMD_SHR" type="hidden">
                                        <input id="txtRAM_YMD2_SHR" name="txtRAM_YMD2_SHR" type="hidden">
                                        <input id="txtRAM_YMD3_SHR" name="txtRAM_YMD3_SHR" type="hidden">
                                        <input id="txtHIRR_YMD_SHR" name="txtHIRR_YMD_SHR" type="hidden">
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

    <!-- 검색 내역 테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
        <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
            <colgroup>
                <col width="90"></col>
                <col width="170"></col>
                <col width="90"></col>
                <col width="170"></col>
                <col width="90"></col>
                <col width="*"></col>
            </colgroup>
            <tr>
                <td align="center" class="creamBold">산정기간</td>
                <td class="padding2423">
                    <input type="text" id="txtHIRG_YMD" name="txtHIRG_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
                    ~
                    <input type="text" id="txtRET_YMD" name="txtRET_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
                </td>
                <td align="center" class="creamBold">근속년수</td>
                <td class="padding2423">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="10"></td>
                            <td><input id="txtRET_LSE_YY" name="txtRET_LSE_YY" type="text" size="3" class="input_ReadOnly" readonly> 년</td>
                            <td><input id="txtRET_LSE_MM" name="txtRET_LSE_MM" type="text" size="3" class="input_ReadOnly" readonly> 월</td>
                            <td><input id="txtRET_LSE_DD" name="txtRET_LSE_DD" type="text" size="3" class="input_ReadOnly" readonly> 일</td>
                            <td width="10"></td>
                        </tr>
                    </table>
                </td>
                <td align="center" class="creamBold">근속비율</td>
                <td class="padding2423">
                    <input id="txtRET_LSE_PER" name="txtRET_LSE_PER" type="text" size="8" class="input_ReadOnly" readonly>
                </td>
            </tr>
            <tr>
                <td align="center" class="creamBold">평균임금</td>
                <td class="padding2423">
                    <input id="txtAVG_PAY" name="txtAVG_PAY" type="text" size="14" class="input_ReadOnly" readonly style="text-align:right;">
                </td>
                <td align="center" class="creamBold">국민연금퇴직전환금</td>
                <td class="padding2423">
                    <input id="txtRTPL_AMT" name="txtRTPL_AMT" type="text" size="14" class="input_ReadOnly" readonly style="text-align:right;">
                </td>
                <td align="center" class="creamBold">정산예상금액</td>
                <td class="padding2423" colspan="5">
                    <input id="txtRET_PAY" name="txtRET_PAY" type="text" size="14" class="input_ReadOnly" readonly style="text-align:right;">
                </td>
            </tr>
        </table>
        </td>
    </tr>
    </table>
    <!-- 검색 내역 테이블 끝 -->

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
                    <object id="grdT_AC_RETMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:170px;">
                        <param name="DataID" value="dsT_AC_RETMASTER">
                        <param name="Editable" value="false">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id="{CUROW}"    width=40        align=center        name="NO"         value={String(Currow)}</C>
                            <C> id=SEQ_NM       width=150       align=center        name="구  분"               </C>
                            <C> id=RET_YMD      width=110       align=center        name="기준일"               </C>
                            <C> id=RAM_YMD      width=110       align=center        name="정산일"               </C>
                            <C> id=AVG_AMT      width=110       align=center        name="평균임금"             </C>
                            <C> id=LSE_PER      width=110       align=center        name="근속비율"             </C>
                            <C> id=RTR_AMT      width=150       align=center        name="퇴직금(중도정산금)"   </C>
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
<object id="bndT_AC_RETINFO" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_AC_RETINFO">
    <Param Name="BindInfo", Value='
        <C>Col=AVG_PAY          Ctrl=txtAVG_PAY             Param=value     </C>
        <C>Col=SUB_BON          Ctrl=txtSUB_BON             Param=value     </C>
        <C>Col=LSE_YY           Ctrl=txtRET_LSE_YY          Param=value     </C>
        <C>Col=LSE_MM           Ctrl=txtRET_LSE_MM          Param=value     </C>
        <C>Col=LSE_DD           Ctrl=txtRET_LSE_DD          Param=value     </C>
        <C>Col=LSE_PER          Ctrl=txtRET_LSE_PER         Param=value     </C>
        <C>Col=RET_PAY          Ctrl=txtRET_PAY             Param=value     </C>
        <C>Col=RTPL_AMT         Ctrl=txtRTPL_AMT            Param=value     </C>
    '>
</object>