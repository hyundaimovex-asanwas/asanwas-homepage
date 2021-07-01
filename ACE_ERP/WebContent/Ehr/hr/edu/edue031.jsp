<!--
    ************************************************************************************
    * @Source         : edue031.jsp                                                    *
    * @Description    : 사내강좌신청서 PAGE                                            *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/22  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/sessionCheck.jsp"%>

<%
	String ROLE_CD = box.getString("SESSION_ROLE_CD");
	String EDU_AUTHO = box.getString("SESSION_EDU_AUTHO");

	boolean isMaster = false;
	boolean isSubMaster = false;

	if (ROLE_CD.equals("1001") || ROLE_CD.equals("1002")
			|| EDU_AUTHO.equals("A")) {
		isMaster = true;
	} else if (EDU_AUTHO.equals("S")) {
		isSubMaster = true;
	}
%>

<html>

<head>
<title>수강신청서(edue031)</title>
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
<script language="javascript">

        var btnList = 'TFFTFTFT';

        var opener = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ED_CHASULIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.e.edue031.cmd.EDUE031CMD"
                                    + "&S_MODE=SHR"
                                    + "&ENO_NO="+document.getElementById("txtENO_NO").value
                                    + "&EDU_CD="+opener.edu_cd
                                    + "&SEQ_NO="+opener.seq_no;
            dsT_ED_CHASULIST.Reset();

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
            var isChk;

            // 확인 CHECK
            if( document.getElementById("chkCHECK").checked == false ) {
                isChk = "N";

                //신청했는지 여부
                if (dsT_ED_CHASULIST.NameValue(1, "CHK_YN") == "N")    {

                    alert("신청하시기 전에 공지사항을 숙지하시고, 확인란을 체크하여 주십시오.");
                    document.getElementById("chkCHECK").focus();
                    return false;

                } else {

                    var msg = "신청자 [" + dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"ENO_NM") + "]\n"
                            + "해당과정 [" + dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"EDU_CD") + "]"
                            + "[" + dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"EDU_NM") + "]\n"
                            + "신청을 취소하시겠습니까?";
                    if (!confirm(msg)) return;
                }

            } else {
                isChk = "Y";
                alert(dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"EDU_NM") + " 과정이 신청되었습니다.");
            }


            //체크한 값으로 저장
            dsT_ED_CHASULIST.NameString(1, "CHK_YN") = isChk;

            trT_ED_CHASULIST.KeyValue = "SVL(I:dsT_ED_CHASULIST=dsT_ED_CHASULIST)";
            trT_ED_CHASULIST.action = "/servlet/GauceChannelSVL?cmd=hr.edu.e.edue031.cmd.EDUE031CMD"
                                    + "&S_MODE=SAV";
            trT_ED_CHASULIST.post();

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {


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

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            fnc_DisableElementAll(elementList);

            document.getElementById("txtENO_NO").value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById("txtENO_NM").value = '<%=box.get("SESSION_ENONM")%>';
            document.getElementById("txtDPT_NM").value = '<%=box.get("SESSION_DPTNM")%>';
            document.getElementById("txtJOB_NM").value = '<%=box.get("SESSION_JOBNM")%>';

<%
    //관리자가 아니면 다른 사번으로 조회가 되지 않게
    if(!isMaster && !isSubMaster) {
%>
            fnc_ChangeStateElement(false, "txtENO_NO");
            fnc_ChangeStateElement(false, "txtENO_NM");
            fnc_ChangeStateElement(false, "ImgEnoNo");
<%
    }
    //소속부서담당자이거나 일반사용자의 경우 자신의 부서에서만 검색이 가능
    if(!isMaster) {
%>
            document.getElementById("hidEMPL_DPT_CD").value = "<%=box.get("SESSION_DPTCD") %>";
<%
    }
%>

            fnc_SearchList();

        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_ED_CHASULIST.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

            opener.fnc_SearchList();

            window.close();

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


        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");

            if (document.getElementById("txtENO_NO").value  != "") {
                fnc_SearchEmpNo();
            }
        }

        /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */
        function fnc_SearchEmpNm() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");
            fnc_SearchEmpNo();
        }

        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
                document.getElementById("txtCET_NO").value      = obj.cet_no;

                //신청자 정보만 조회
                fnc_SearchList();

            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
                document.getElementById("txtCET_NO").value      = "";
            }
        }

        var elementList = new Array(     "txtEDU_CD"
                                        ,"txtEDU_NM"
                                        ,"txtSEQ_NO"
                                        ,"txtCHASU_TAG"
                                        ,"txtEDU_STR_YMD"
                                        ,"txtEDU_END_YMD"
                                        ,"txtSTR_YMD"
                                        ,"txtMAN_ENO_NM"
                                        ,"txtEDU_GBN_NM"
                                        ,"txtMNGER_NM"
                                        ,"txtFIELD_NM"
                                        ,"txtSHAPE_NM"
                                        ,"txtCOST_NM"
                                        ,"txtPLACE_NM"
                                        ,"txtGOAL_TAG"
                                        ,"txtCONTENT_TXT"
                                        ,"txtEFFECT_TAG"
                                        ,"txtOBJ_TAG"
                                        ,"txtCPT_TAG"
                                        ,"txtINT_NAM"
                                        ,"txtFIX_NO"
                                        ,"txtDAY_NO"
                                        ,"txtTIME_NO"
                                        ,"medCOST_AMT"
                                        ,"medRTN_AMT"
                                        ,"txtCPT_PNT"
                                        ,"txtSITE_TAG");
    </script>

</head>


<!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

<!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_EDUCATION) |
    | 3. 사용되는 Table List(T_CM_EDUCATION)        |
    +----------------------------------------------->
<Object ID="dsT_ED_CHASULIST"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_ED_CHASULIST                    |
    | 3. Table List : T_ED_CHASULIST                |
    +----------------------------------------------->
<Object ID="trT_ED_CHASULIST"
	ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>


<!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

<!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
<Script For=dsT_ED_CHASULIST Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            alert("신청자 정보가 없습니다.");
            window.close();

        } else {

            if (dsT_ED_CHASULIST.NameValue(1, "CHK_YN") == "N")    {

                if(dsT_ED_CHASULIST.NameValue(1, "IS_EXP") == "Y") {
                    alert("예외자로 등록되어 있어 신청하실 수 없습니다.");
                    document.getElementById("Message").innerText = '* 예외자로 등록되어 있어 신청하실 수 없습니다.';
                    fnc_ChangeStateElement(false, "chkCHECK");
                    fnc_HiddenElement("imgSave");
                    fnc_HiddenElement("imgSave2");

                    return;
                } else if (dsT_ED_CHASULIST.NameValue(1, "FIX_NO") <= dsT_ED_CHASULIST.NameValue(1, "REQ_CNT")) {
                    alert("이미 신청마감된 교육과정이므로 신청하실 수 없습니다.");
                    document.getElementById("Message").innerText = '* 이미 신청마감된 교육과정이므로 신청하실 수 없습니다.';
                    fnc_ChangeStateElement(false, "chkCHECK");
                    fnc_HiddenElement("imgSave");
                    fnc_HiddenElement("imgSave2");

                    return;
                } else {
                    document.getElementById("Message").innerText = '* 해당 교육과정을 신청하실 수 있습니다.';
                    document.getElementById("chkCHECK").checked = false;
                }
            } else {
                document.getElementById("Message").innerText = '* 해당 교육과정은 신청되었습니다.';
                document.getElementById("chkCHECK").checked = true;
            }

        }

    </Script>

<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
<Script For=dsT_ED_CHASULIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

<!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
<Script For=dsT_ED_CHASULIST Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

<!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
<script for=trT_ED_CHASULIST event="OnSuccess()">
        //fnc_SearchList();
        opener.fnc_SearchList();
        self.close();
    </script>

<!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
<script for=trT_ED_CHASULIST event="OnFail()">
        cfErrorMsg(this);
    </script>
<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15"
	marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();"
	onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none"><iframe
	name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0"
	src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%"
	scrolling="no"></iframe></div>

<!-- form 시작 -->
<form name="form1"><!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="23"><img src="/images/common/barHead.gif" width="23"
					height="25"></td>
				<td valign="top" background="/images/common/barGreenBg.gif"
					class="barTitle">사내강좌신청서</td>
				<td align="right" class="navigator">HOME/인사관리/파견사원/<font
					color="#000000">사내강좌신청서</font></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 --> <!-- 버튼 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right"><img
			src="/images/button/btn_SaveOn.gif" name="imgSave" width="60"
			height="20" border="0" align="absmiddle" onClick="fnc_Save()"
			onMouseOut="MM_swapImgRestore()"
			onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"
			style="cursor:hand;"> <img src="/images/button/btn_ExitOn.gif"
			name="imgExit" width="60" height="20" border="0" align="absmiddle"
			onClick="fnc_Exit()" onMouseOut="MM_swapImgRestore()"
			onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"
			style="cursor:hand;"></td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
		<table width="100%" border="1" cellspacing="0" cellpadding="0"
			style="border-collapse: collapse" bordercolor="#999999"
			class="table_cream">
			<colgroup>
				<col width="100"></col>
				<col width="300"></col>
				<col width="100"></col>
				<col width="300"></col>
			</colgroup>
			<tr>
				<td align="center" class="creamBold">과정명</td>
				<td class="padding2423" colspan="3"><input id="txtEDU_NM"
					style="width:100%" maxlength="100"></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">교육구분</td>
				<td class="padding2423"><input id="txtEDU_GBN_NM"
					style="width:100%" maxlength="100"></td>
				<td align="center" class="creamBold">교육주관</td>
				<td class="padding2423"><input id="txtMNGER_NM"
					style="width:100%" maxlength="100"></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">교육분야</td>
				<td class="padding2423"><input id="txtFIELD_NM"
					style="width:100%" maxlength="100"></td>
				<td align="center" class="creamBold">교육형태</td>
				<td class="padding2423"><input id="txtSHAPE_NM"
					style="width:100%" maxlength="100"></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">교육목표</td>
				<td class="padding2423" colspan="3"><input id="txtGOAL_TAG"
					name="txtGOAL_TAG" style="width:100%" maxlength="100"></td>
			</tr>
			<tr>

			<td align="center" class="creamBold">교육내용</td>
				<td class="padding2423" colspan="3"><textarea
					id="txtCONTENT_TXT" name="txtCONTENT_TXT" cols="112" rows="5"
					onkeyup="fc_chk_byte(this,300);" class="input_ReadOnly" readonly></textarea></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">수료기준</td>
				<td class="padding2423" colspan="3"><textarea id="txtCPT_TAG"
					name="txtCPT_TAG" cols="112" rows="3"
					onkeyup="fc_chk_byte(this,150);" class="input_ReadOnly" readonly></textarea></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">기대효과</td>
				<td class="padding2423" colspan="3"><input id="txtEFFECT_TAG"
					name="txtEFFECT_TAG" style="width:100%" maxlength="100"></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">교육대상</td>
				<td class="padding2423" colspan="3"><input id="txtOBJ_TAG"
					name="txtOBJ_TAG" style="width:100%" maxlength="50"></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">교육기관</td>
				<td class="padding2423" colspan="3"><input id="txtINT_NAM"
					name="txtINT_NAM" style="width:100%" maxlength="22"></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">교육정원</td>
				<td class="padding2423"><input id="txtFIX_NO" name="txtFIX_NO"
					style="width:80%;ime-mode:disabled;text-align:right;" maxlength="3">
				명</td>
				<td align="center" class="creamBold">교육시간</td>
				<td class="padding2423"><input id="txtTIME_NO"
					name="txtTIME_NO"
					style="width:80%;ime-mode:disabled;text-align:right;" maxlength="3">
				시간</td>
			</tr>
			<tr>
				<td align="center" class="creamBold">교육일수</td>
				<td class="padding2423" colspan="3"><input id="txtDAY_NO"
					name="txtDAY_NO"
					style="width:34%;ime-mode:disabled;text-align:right;" maxlength="3">
				일</td>
			</tr>
			<tr>
				<td align="center" class="creamBold">비용부담</td>
				<td class="padding2423"><input id="txtCOST_NM"
					style="width:100%" maxlength="100"></td>
				<td align="center" class="creamBold">교육장소</td>
				<td class="padding2423"><input id="txtPLACE_NM"
					style="width:100%" maxlength="100"></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">교육비용</td>
				<td class="padding2423"><comment id="__NSID__"><object
					id="medCOST_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
					style="width:80%">
					<param name=Alignment value=2>
					<param name=Border value=true>
					<param name=ClipMode value=true>
					<param name=DisabledBackColor value="#EEEEEE">
					<param name=Enable value=true>
					<param name=IsComma value=true>
					<param name=Language value=0>
					<param name=MaxLength value=9>
					<param name=Numeric value=true>
					<param name=ShowLiteral value="false">
					<param name=Visible value="true">
				</object></comment><script> __ShowEmbedObject(__NSID__); </script> 원</td>
				<td align="center" class="creamBold">환급금액</td>
				<td class="padding2423"><comment id="__NSID__"><object
					id="medRTN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F
					style="width:80%">
					<param name=Alignment value=2>
					<param name=Border value=true>
					<param name=ClipMode value=true>
					<param name=DisabledBackColor value="#EEEEEE">
					<param name=Enable value=true>
					<param name=IsComma value=true>
					<param name=Language value=0>
					<param name=MaxLength value=9>
					<param name=Numeric value=true>
					<param name=ShowLiteral value="false">
					<param name=Visible value="true">
				</object></comment><script> __ShowEmbedObject(__NSID__); </script> 원</td>
			</tr>
			<tr>
				<td align="center" class="creamBold">이수점수</td>
				<td class="padding2423"><input id="txtCPT_PNT"
					name="txtCPT_PNT"
					style="width:80%;ime-mode:disabled;text-align:right;" maxlength="2">
				점</td>
				<td align="center" class="creamBold">참고사이트</td>
				<td class="padding2423">http://<input id="txtSITE_TAG"
					name="txtSITE_TAG" style="width:80%" maxlength="30"></td>
			</tr>
			<tr>
				<td align="center" class="creamBold">등록일자</td>
				<td class="padding2423" colspan="3"><input id="txtSTR_YMD"
					style="width:100%" maxlength="100"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" class="searchState"><span id="Message">&nbsp;</span></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 --> <!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
		<table width="100%" border="1" cellspacing="0" cellpadding="0"
			style="border-collapse: collapse" bordercolor="#999999"
			class="table_cream">
			<colgroup>
				<col width="100"></col>
				<col width="*"></col>
			</colgroup>
			<tr>
				<td align="center" class="creamBold">신 청 자</td>
				<td class="padding2423" colspan="5"><input id="txtENO_NO"
					name="txtENO_NO" size="9" maxlength="8"
					onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()"
					onchange="fnc_SearchEmpNo()"> <input id="txtENO_NM"
					name="txtENO_NM" size="9" maxlength="9"
					onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()"
					onchange="fnc_SearchEmpNm()"> <img
					src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo"
					width="21" height="20" border="0" align="absmiddle"
					onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()"
					onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"
					style="cursor:hand;"> <input type="hidden"
					id="hidEMPL_DPT_CD"> <b> &nbsp;&nbsp;부서 <input
					id="txtDPT_NM" size="20" class="input_ReadOnly" readonly>
				&nbsp;&nbsp;직위 <input id="txtJOB_NM" size="16"
					class="input_ReadOnly" readonly> &nbsp;&nbsp;주민번호 <input
					id="txtCET_NO" size="20" class="input_ReadOnly" readonly> </b>
				</td>
			</tr>
			<tr>
				<td align="center" class="creamBold">공지사항</td>
				<td class="padding2423" colspan="5"><textarea id="txtTEXT"
					name="txtTEXT" cols="117" rows="5" maxlength="4000" readonly>
&nbsp;1) 무단결석 월5회 이상일 경우 수강포기로 간주하고 교육비는 본인이 부담한다.
&nbsp;2) 종합출석율 75% 미만일 경우 미수료처리하고 타 교육기회에 제한을 둔다.
&nbsp;3) 고급과정은 매월 학원강의 출석 및 평가 결과에 따라 차월지원여부를 결정한다.
                        </textarea></td>
			</tr>
			<tr>
				<td align="right" class="padding2423" colspan="6">상기 공지사항을
				숙지하였으며, 사내강좌를 신청합니다. <input type="checkbox" id="chkCHECK"
					name="chkCHECK">확인&nbsp;&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="paddingTop8" align="right"><img
			src="/images/button/btn_SaveOn.gif" name="imgSave2" width="60"
			height="20" border="0" align="absmiddle" onClick="fnc_Save()"
			onMouseOut="MM_swapImgRestore()"
			onMouseOver="MM_swapImage('imgSave2','','/images/button/btn_SaveOver.gif',1)"
			style="cursor:hand;"> <img src="/images/button/btn_ExitOn.gif"
			name="imgExit2" width="60" height="20" border="0" align="absmiddle"
			onClick="fnc_Exit()" onMouseOut="MM_swapImgRestore()"
			onMouseOver="MM_swapImage('imgExit2','','/images/button/btn_ExitOver.gif',1)"
			style="cursor:hand;"></td>
	</tr>
</table>
<!-- 조회 테이블 끝 --></form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 평가대상자설정 테이블 -->
<object id="bndT_ED_CHASULIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID" ,   Value="dsT_ED_CHASULIST">
	<Param Name="BindInfo",  Value="
        <C>Col=ENO_NO           Ctrl=txtENO_NO          Param=value </C>
        <C>Col=ENO_NM           Ctrl=txtENO_NM          Param=value </C>
        <C>Col=DPT_NM           Ctrl=txtDPT_NM          Param=value </C>
        <C>Col=JOB_NM           Ctrl=txtJOB_NM          Param=value </C>
        <C>Col=CET_NO           Ctrl=txtCET_NO          Param=value </C>
        <C>Col=EDU_CD           Ctrl=txtEDU_CD          Param=value </C>
        <C>Col=EDU_NM           Ctrl=txtEDU_NM          Param=value </C>
        <C>Col=SEQ_NO           Ctrl=txtSEQ_NO          Param=value </C>
        <C>Col=CHASU_TAG        Ctrl=txtCHASU_TAG       Param=value </C>
        <C>Col=EDU_STR_YMD      Ctrl=txtEDU_STR_YMD     Param=value </C>
        <C>Col=EDU_END_YMD      Ctrl=txtEDU_END_YMD     Param=value </C>
        <C>Col=STR_YMD          Ctrl=txtSTR_YMD         Param=value </C>
        <C>Col=MAN_ENO_NM       Ctrl=txtMAN_ENO_NM      Param=value </C>
        <C>Col=EDU_GBN_NM       Ctrl=txtEDU_GBN_NM      Param=value </C>
        <C>Col=MNGER_NM         Ctrl=txtMNGER_NM        Param=value </C>
        <C>Col=FIELD_NM         Ctrl=txtFIELD_NM        Param=value </C>
        <C>Col=SHAPE_NM         Ctrl=txtSHAPE_NM        Param=value </C>
        <C>Col=COST_NM          Ctrl=txtCOST_NM         Param=value </C>
        <C>Col=PLACE_NM         Ctrl=txtPLACE_NM        Param=value </C>
        <C>Col=GOAL_TAG         Ctrl=txtGOAL_TAG        Param=value </C>
        <C>Col=CONTENT_TXT      Ctrl=txtCONTENT_TXT     Param=value </C>
        <C>Col=EFFECT_TAG       Ctrl=txtEFFECT_TAG      Param=value </C>
        <C>Col=OBJ_TAG          Ctrl=txtOBJ_TAG         Param=value </C>
        <C>Col=CPT_TAG          Ctrl=txtCPT_TAG         Param=value </C>
        <C>Col=INT_NAM          Ctrl=txtINT_NAM         Param=value </C>
        <C>Col=FIX_NO           Ctrl=txtFIX_NO          Param=value </C>
        <C>Col=DAY_NO           Ctrl=txtDAY_NO          Param=value </C>
        <C>Col=TIME_NO          Ctrl=txtTIME_NO         Param=value </C>
        <C>Col=COST_AMT         Ctrl=medCOST_AMT        Param=Text  </C>
        <C>Col=RTN_AMT          Ctrl=medRTN_AMT         Param=Text  </C>
        <C>Col=CPT_PNT          Ctrl=txtCPT_PNT         Param=value </C>
        <C>Col=SITE_TAG         Ctrl=txtSITE_TAG        Param=value </C>
        <C>Col=COMM_NO          Ctrl=hidCOMM_NO         Param=value </C>

    ">
</object>
