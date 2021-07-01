<!--
*****************************************************
* @source       : lawa030.jsp
* @description : HRMS PAGE :: 법무관리_채권회수진행현황명세서
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/12/14      한학현        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.JSPUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>채권회수진행현황명세서</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->

<script language="javascript" >

		var btnList = 'TFFTFFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
	        var oSTR_YMD = document.getElementById("txtORD_YMD_STR_SHR").value;
	        var oEND_YMD = document.getElementById("txtORD_YMD_END_SHR").value;

        	if(oSTR_YMD.trim() == '' || oEND_YMD.trim() == ''){
				alert("의뢰기간이 입력되지 않았습니다.");
				return false;
        	}

            //데이터셋 전송
            dsT_LW_BONDLIST.DataID  = "/servlet/GauceChannelSVL?cmd=hr.law.a.lawa030.cmd.LAWA030CMD&S_MODE=SHR"
                                    + "&HEAD_CD_SHR="+document.getElementById("txtHEAD_CD_SHR").value
                    				+ "&BOND_GBN_SHR="+document.getElementById("txtBOND_GBN_SHR").value
                    				+ "&EVENT_NM_SHR="+document.getElementById("txtEVENT_NM_SHR").value
                    				+ "&ORD_YMD_STR_SHR="+oSTR_YMD
                    				+ "&ORD_YMD_END_SHR="+oEND_YMD;
            dsT_LW_BONDLIST.Reset();
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
            if(dsT_LW_BONDLIST.CountRow == 0) {
                alert("인쇄할 데이타를 조회 후 사용하십시요.");
                return;
            }
        
			var HEAD_CD_SHR      = document.getElementById("txtHEAD_CD_SHR").value;
			var BOND_GBN_SHR     = document.getElementById("txtBOND_GBN_SHR").value;
			var EVENT_NM_SHR   	 = document.getElementById("txtEVENT_NM_SHR").value;
            var ORD_YMD_STR_SHR  = document.getElementById("txtORD_YMD_STR_SHR").value;
            var ORD_YMD_END_SHR  = document.getElementById("txtORD_YMD_END_SHR").value;
            
            //인쇄를 위해 필요한 값들을 정리한다.
            dsT_LW_BONDLIST_PRT.DataID  = "/servlet/GauceChannelSVL?cmd=hr.law.a.lawa030.cmd.LAWA030CMD"
                                        + "&S_MODE=PROC"
                                        + "&HEAD_CD_SHR="+HEAD_CD_SHR 
                                        + "&BOND_GBN_SHR="+BOND_GBN_SHR
                                        + "&EVENT_NM_SHR="+EVENT_NM_SHR
                                        + "&ORD_YMD_STR_SHR="+ORD_YMD_STR_SHR
                                        + "&ORD_YMD_END_SHR="+ORD_YMD_END_SHR;
            dsT_LW_BONDLIST_PRT.Reset();

		    var url = "lawa030_PV.jsp?HEAD_CD_SHR="+HEAD_CD_SHR+"&BOND_GBN_SHR="+BOND_GBN_SHR+"&EVENT_NM_SHR="+EVENT_NM_SHR + "&ORD_YMD_STR_SHR="+ORD_YMD_STR_SHR+"&ORD_YMD_END_SHR="+ORD_YMD_END_SHR;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {
            if (dsT_LW_BONDLIST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_LW_BONDLIST.GridToExcel("채권회수진행현황명세서", '', 225);
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

	        document.getElementById("txtHEAD_CD_SHR").value = "";
	        document.getElementById("txtHEAD_NM_SHR").value = "";
			document.getElementById("txtBOND_GBN_SHR").value = "";
			document.getElementById("txtBOND_GBN_NM_SHR").value = "";
			document.getElementById("txtEVENT_NM_SHR").value = "";

			dsT_LW_BONDLIST.ClearData();
			document.form1.txtHEAD_CD_SHR.focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_LW_BONDLIST.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

	        frame = window.external.GetFrame(window);
	        frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

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
            //Grid Style 적용
            cfStyleGrid(form1.grdT_LW_BONDLIST,15,"false","false");

<%
    //권한이 법무권한 마스터 이거나 IT 가 아니면 소속 본부만 조회 가능 - M 마스터, A 모든부서, S 소속부서
    if(box.get("SESSION_LAW_AUTHO").equals("S")) {
%>
            //소속부서의 본부코드를 조회
            fnc_GetHeadCd();
            
            fnc_ChangeStateElement(false, "txtHEAD_CD_SHR");
            fnc_ChangeStateElement(false, "img_HelpOn1");
<%
    }
%>

			//의뢰기간 기본값
   	        document.getElementById("txtORD_YMD_STR_SHR").value = getStrDate();
	        document.getElementById("txtORD_YMD_END_SHR").value = getEndDate();
        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        /****************************************
         * 검색부의 필드 변경시 관련컬럼 초기화 *
         ***************************************/
        function fnc_FldChange() {

        }


        /**
         * 소속부서의 본부를 조회한다.
         */
        function fnc_GetHeadCd(){

            if (document.all("coCommNmGDS") == null) {
                dataSet = document.createElement("<OBJECT>");
                dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
                dataSet.id = "coCommNmGDS";
                dataSet.SyncLoad = "true";

                for (var i = 0; i < document.all.length; i++) {
                    if (document.all[i].tagName == "HEAD") {
                        document.all[i].insertAdjacentElement("beforeEnd", dataSet);
                        break;
                    }
                }
            } else {
                dataSet = document.all("coCommNmGDS");
            }

            svl = "/servlet/GauceChannelSVL?cmd=common.commnm.cmd.COMMNMCMD&S_MODE=SHR" +
                  "&CD_GBN=" + "A4" +
                  "&COMM_CD=<%=box.get("SESSION_DPTCD") %>" +
                  "&UP_CD=" + "";
            dataSet.DataId = svl;
            dataSet.Reset();

            if (dataSet.countrow > 0)   {
                document.getElementById("txtHEAD_CD_SHR").value   = dataSet.NameValue(0,"UP_CD");
                fnc_GetCommNm('B2', 'txtHEAD_CD_SHR','txtHEAD_NM_SHR');
            }
        }
</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_LW_BONDLIST                                     |
    | 3. Table List : T_LW_BONDLIST                                |
    +----------------------------------------------->
    <Object ID="dsT_LW_BONDLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name="SubsumExpr"	value="total,2:HEAD_NM">
    </Object>
    
    <Object ID="dsT_LW_BONDLIST_PRT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name="SubsumExpr"	value="total,2:HEAD_NM">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_LW_BONDLIST Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_LW_BONDLIST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_LW_BONDLIST Event="OnDataError()">
        //Dataset관련 Error 처리
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
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">채권회수진행현황명세서</td>
					<td align="right" class="navigator">HOME/총무(기타)/법무관리/<font color="#000000">채권회수진행현황명세서</font></td>
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
			<a href="http://www.scourt.go.kr/" target="_blank" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgScourt','','/images/button/btn_ScourtOver.gif',1)">  <img src="/images/button/btn_ScourtOn.gif"   name="imgScourt" width="70" height="20" border="0" align="absmiddle"></a>
			&nbsp;&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
 			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>                
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="10"></col>
								<col width="70"></col>
								<col width="190"></col>
								<col width="70"></col>
								<col width="190"></col>
								<col width="70"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">사업본부</td>
                                <td>
                                    <input name=txtHEAD_CD_SHR size="6"  onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()" onChange="fnc_GetCommNm('B2', 'txtHEAD_CD_SHR','txtHEAD_NM_SHR');fnc_FldChange()">
                                    <input name=txtHEAD_NM_SHR size="14" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtHEAD_CD_SHR','txtHEAD_NM_SHR','사업본부','HEAD');"></a>
                                </td>
                                <td align="center" class="searchState">채권구분</td>
                                <td colspan="3">
                                    <input name=txtBOND_GBN_SHR size="6"  onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()" onChange="fnc_GetCommNm('H3', 'txtBOND_GBN_SHR','txtBOND_GBN_NM_SHR');fnc_FldChange()">
                                    <input name=txtBOND_GBN_NM_SHR size="14" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtBOND_GBN_SHR','txtBOND_GBN_NM_SHR','채권내역','H3');"></a>
                                </td>
								<td align="center" class="searchState">사건명</td>
								<td>
									<input name="txtEVENT_NM_SHR" class="divInput" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList()" size="23">
								</td>
							</tr>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">의뢰기간</td>
								<td colspan="5">
					        		<input id="txtORD_YMD_STR_SHR" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
			                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn3','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn3" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtORD_YMD_STR_SHR','','60','134');"></a>
									~
					        		<input id="txtORD_YMD_END_SHR" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
			                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn4','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn4" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtORD_YMD_END_SHR','','170','134');"></a>
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
						<object	id="grdT_LW_BONDLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
							<param name="DataID"					value="dsT_LW_BONDLIST">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"					value="
                                <FC>    id='HEAD_NM'        width=90        name='사업본부'         align=center            Suppress='3'        SubSumText={decode(curlevel,2,'소계',9999,'총계')}                  </FC>
                                <FC>    id='ORD_NO'         name='접수번호'           align=left              Suppress='2'       show=false                                         </FC>
                                <FC>    id='EVENT_NM'       width=200       name='사건명'           align=left              Suppress='1'       SubSumText={SubSum(CNT)}                                         </FC>
                                <C>     id='BOND_GBN_NM'    width=80        name='채권구분'         align=center                                                                                        </C>
                                <C>     id='BOND_AMT'       width=90        name='채권금액'         align=right             value={IF(BOND_AMT=0,'',BOND_AMT)}                                          </C>
                                <C>     id='SEC_LAND'       width=150       name='근저당'           align=left                                                                                          </C>
                                <C>     id='SEC_PLED'       width=150       name='질권'             align=left                                                                                          </C>
                                <C>     id='SEC_GUAR'       width=150       name='보증보험'         align=left                                                                                          </C>
                                <C>     id='SEC_CASH'       width=150       name='현금예치'         align=left                                                                                          </C>
                                <C>     id='SEC_GUOR1'      width=100       name='연대보증인1'      align=center                                                                                        </C>
                                <C>     id='SEC_GUOR2'      width=100       name='연대보증인2'      align=center                                                                                        </C>
                                <C>     id='SEC_SO'         width=150       name='기타담보'         align=left                                                                                          </C>
                                <C>     id='DPT_NM'         width=100       name='의뢰부서'         align=center                                                                                        </C>
                                <C>     id='HIS_CONT1'      width=200       name='진행사항'         align=left                                                                                                      </C>
                                <C>     id='HIS_AMT1'       width=90        name='진행금액'         align=right             value={IF(HIS_AMT1=0,'',HIS_AMT1)}                                                      </C>
                                <C>     id='HIS_CONT2'      width=200       name='예정사항'         align=left                                                                                                      </C>
                                <C>     id='HIS_AMT2'       width=90        name='예정금액'         align=right             value={IF(HIS_AMT2=0,'',HIS_AMT2)}                                                      </C>
                                <C>     id='BOND_AC_AMT'    width=90        name='現회수액'         align=right             value={IF(BOND_AC_AMT=0,'',BOND_AC_AMT)}                                                </C>
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

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>