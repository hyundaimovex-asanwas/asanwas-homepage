<!--
***********************************************************************
* @source      : weld030.jsp
* @description : 콘도신청처리 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/12/15      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>콘도신청처리(weld030)</title>
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

		var btnList = 'TFTTFTFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var str_ymd = document.getElementById('txtSTR_YMD_SHR').value;
			var end_ymd = document.getElementById('txtEND_YMD_SHR').value;
			var cn_cd = document.getElementById('cmbCN_CD_SHR').value;
			var rsv_gbn = document.getElementById('cmbRSV_GBN_SHR').value;
			var rst_gbn = document.getElementById('cmbRST_GBN_SHR').value;
			var season_gbn = document.getElementById('cmbSEASON_GBN_SHR').value;

			dsT_WL_CONDOUSE.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld030.cmd.WELD030CMD&S_MODE=SHR&STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&CN_CD="+cn_cd+"&RSV_GBN="+rsv_gbn+"&RST_GBN="+rst_gbn+"&SEASON_GBN="+season_gbn;
    		dsT_WL_CONDOUSE.reset();

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

			trT_WL_CONDOUSE.KeyValue = "tr01(I:dsT_WL_CONDOUSE=dsT_WL_CONDOUSE)";
			trT_WL_CONDOUSE.action = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld030.cmd.WELD030CMD&S_MODE=SAV";
			trT_WL_CONDOUSE.post();


        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

			var str_ymd = document.getElementById('txtSTR_YMD_SHR').value;
			var end_ymd = document.getElementById('txtEND_YMD_SHR').value;
			var cn_cd = document.getElementById('cmbCN_CD_SHR').value;
			var rsv_gbn = document.getElementById('cmbRSV_GBN_SHR').value;
			var rst_gbn = document.getElementById('cmbRST_GBN_SHR').value;
			var season_gbn = document.getElementById('cmbSEASON_GBN_SHR').value;


			var url = "weld030_PV.jsp?&STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&CN_CD="+cn_cd+"&RSV_GBN="+rsv_gbn+"&RST_GBN="+rst_gbn+"&SEASON_GBN="+season_gbn;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

			//이곳에 해당 코딩을 입력 하세요

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

			document.getElementById('cmbRSV_GBN_SHR').value = '13';
			document.getElementById('cmbRST_GBN_SHR').value = '';
			document.getElementById('cmbSEASON_GBN_SHR').value = '';
			document.getElementById("resultMessage").innerText = ' ';

			dsT_WL_CONDOUSE.ClearData();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid(form1.grdT_WL_CONDOUSE,15,"false","false");      // Grid Style 적용

            document.getElementById('txtSTR_YMD_SHR').value = getStrDate();
            document.getElementById('txtEND_YMD_SHR').value = getEndDate();
            document.getElementById('txtSTR_YMD_SHR').focus();



            fnc_ConstructCommonCode("dsCOMMON_CN", "cmbCN_CD_SHR", "", "전 체");
            document.getElementById('cmbRSV_GBN_SHR').value = '13';

            //창 막기
            fnc_DisableElementAll(elementList);
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        //입력창
        var elementList = new Array(     "rdoRSV_GBN"
                                        ,"cmbRST_GBN"
                                        ,"txtRSV_NO" );

        var exceptionList = new Array(   "rdoRSV_GBN" );

        /**
         * 예약번호가 있는지 없는지 여부를 검증
         */
        function chk_RSV_NO() {
            if(document.getElementById("txtRSV_NO").value == "") {
                dsT_WL_CONDOUSE.NameString(dsT_WL_CONDOUSE.RowPosition, "RSV_GBN") = "1";   //'1', '신청', '2', '취소', '3', '예약'
                dsT_WL_CONDOUSE.NameString(dsT_WL_CONDOUSE.RowPosition, "RST_GBN") = "1";   //1:미회신,2:확정,3:일반취소,4:완료취소,5:NoShow,6:미당첨
            }
        }
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_WL_CONDOUSE) |
    | 3. 사용되는 Table List(T_WL_CONDOUSE)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_CONDOUSE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- 콘도 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_CN"/>
       <jsp:param name="CODE_GUBUN"    value="CN"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_WL_CONDOUSE)	|
    | 3. 사용되는 Table List(T_WL_CONDOUSE)	            |
    +--------------------------------------------------->
    <Object ID ="trT_WL_CONDOUSE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_WL_CONDOUSE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_WL_CONDOUSE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_CONDOUSE Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_WL_CONDOUSE event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_WL_CONDOUSE event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_WL_CONDOUSE event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        //신청상태가 취소이면 결과와 예약번호를 수정못하게 막기
        if(dsT_WL_CONDOUSE.NameString(row, "RSV_GBN") != "2") {
            fnc_EnableElementAll(elementList, exceptionList);
        }
    </script>



    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_WL_CONDOUSE event=CanRowPosChange(row)>

    </script>

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">콘도신청처리</td>
					<td align="right" class="navigator">HOME/복리후생/콘도/<font color="#000000">콘도신청처리</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
		    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="90"></col>
									<col width="220"></col>
									<col width="80"></col>
									<col width="70"></col>
									<col width="100"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="center" class="searchState">신청일&nbsp;</td>
								<td class="padding2423">
									<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','15','120');"></a> ~
									<input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','125','120');"></a>
								</td>
								<td align="center" class="searchState">콘&nbsp;&nbsp;도&nbsp;</td>
								<td class="padding2423">
									<select id="cmbCN_CD_SHR" style="WIDTH:100" onChange="fnc_SearchList();">
									</select>
								</td>
								<td align="center" class="searchState">신청상태&nbsp;</td>
								<td class="padding2423">
									<select id="cmbRSV_GBN_SHR" style="WIDTH:100" onChange="fnc_SearchList();">
										<option value="">전 체</option>
										<option value="13">진행중</option>
										<option value="1">신 청</option>
										<option value="2">취 소</option>
										<option value="3">예 약</option>
									</select>
								</td>
							</tr>
							<tr>
								<td align="center" class="searchState">예약결과&nbsp;</td>
								<td class="padding2423">
									<select id="cmbRST_GBN_SHR" style="WIDTH:100" onChange="fnc_SearchList();">
										<option value="">전 체</option>
										<option value="1">미회신</option>
										<option value="2">확 정</option>
										<option value="3">일반취소</option>
										<option value="4">완료취소</option>
										<option value="5">NoShow</option>
									</select>
								</td>
								<td align="center" class="searchState">성수기구분&nbsp;</td>
								<td class="padding2423">
									<select id="cmbSEASON_GBN_SHR" style="WIDTH:100" onChange="fnc_SearchList();">
										<option value="">전 체</option>
										<option value="1">비성수기</option>
										<option value="2">성수기</option>
									</select>
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

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="120"></col>
					<col width="80"></col>
					<col width="120"></col>
					<col width="100"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">소&nbsp;&nbsp;속</td>
					<td class="padding2423">
                        <input type="text" id="txtDPT_NM" style="width:100" class="input_ReadOnly" readonly>
					</td>
					<td align="center" class="creamBold">직&nbsp;&nbsp;위</td>
					<td class="padding2423">
                        <input type="text" id="txtJOB_NM" style="width:100" class="input_ReadOnly" readonly>
					</td>
					<td align="center" class="creamBold">성&nbsp;&nbsp;명</td>
					<td class="padding2423">
                        <input type="text" id="txtENO_NM" style="width:100" class="input_ReadOnly" readonly>
					</td>
				</tr>
				<tr>
                    <td align="center" class="creamBold">이용시작일</td>
                    <td class="padding2423">
                        <input id="txtSTR_YMD" style="width:100" class="input_ReadOnly" readonly>
                    </td>
					<td align="center" class="creamBold">콘&nbsp;&nbsp;도</td>
					<td class="padding2423">
                        <input type="text" id="txtCN_NAME" style="width:100" class="input_ReadOnly" readonly>
					</td>
					<td align="center" class="creamBold">지&nbsp;&nbsp;역</td>
					<td class="padding2423">
						<input type="text" id="txtCO_NM" style="width:220" class="input_ReadOnly" readonly>
        <!--                <input type="text" id="txtEXT" style="width:100" class="input_ReadOnly" readonly>    -->
					</td>
				</tr>
                <tr>
					<td align="center" class="creamBold">이용박수</td>
					<td class="padding2423">
						<input id="txtSTAY_CNT" size="5" maxLength="2" class="input_ReadOnly" readonly>
					</td>
					<td align="center" class="creamBold">객실수</td>
					<td class="padding2423">
						<input id="txtROOM_CNT" size="5" maxLength="2" class="input_ReadOnly" readonly>
					</td>
                    <td align="center" class="creamBold">연락처</td>
                    <td class="padding2423">
                        <input id="txtENO_TEL" size="20" maxLength="20" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
					<td align="center" class="creamBold">콘도신청</td>
					<td class="padding2423" colspan="3">
                        <comment id="__NSID__">
						<object id=rdoRSV_GBN classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0
									style="height:20; width:200">
							<param name=AutoMargin	value="false">
							<param name=DataID      value="dsT_WL_CONDOUSE">
							<param name=CodeColumn  value="RSV_GBN">
							<param name=Cols		value="3">
							<param name=Format		value="1^신청,2^취소,3^예약">
                            <param name=Enable   value=false>
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="creamBold">예약결과확인</td>
					<td class="padding2423">
                        <table>
                            <tr>
                                <td>
            						<select id="cmbRST_GBN" style="WIDTH:100">
            							<option value="1">미회신</option>
                                        <option value="7">처리중</option>
            							<option value="2">확정</option>
            							<option value="3">일반취소</option>
            							<option value="4">완료취소</option>
            							<option value="5">NoShow</option>
            							<option value="6">미당첨</option>
            						</select>
                                </td>
								<td>
									&nbsp;
                                    <input id="txtRSV_NO" size="15" onchange="chk_RSV_NO()">
								</td>
							</tr>
						</table>
					</td>

			</table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 -->

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
						<object	id="grdT_WL_CONDOUSE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"					value="dsT_WL_CONDOUSE">
							<param name="Format"					value="
								<FC> id={currow}		width=35    name='NO'			align=center </FC>
								<FC> id='DPT_NM'		width=80	name='소속'			align=left Edit=none </FC>
								<FC> id='JOB_NM'		width=50	name='직위'			align=left Edit=none </FC>
								<FC> id='ENO_NM'		width=60	name='성명'			align=center Edit=none </FC>
								<C> id='CN_NAME'		width=70	name='콘도'			align=center Edit=none </C>
								<C> id='CO_NM'		width=220   name='지역'			align=left leftmargin=10 Edit=none </C>
                                <C> id='IPT_YMD'    width=70    name='신청일'       align=center Edit=none </C>
							   	<C> id='STR_YMD'	width=70	name='이용시작일'	align=center Edit=none </C>
								<C> id='STAY_CNT'	width=55	name='이용박수'		align=right Edit=none </C>
								<C> id='ROOM_CNT'	width=40	name='객실수'		align=right Edit=none </C>
								<C> id='RSV_GBN'	width=60	name='신청상태'		align=center Edit=none  Value={Decode(RSV_GBN, '1', '신청', '2', '취소', '3', '예약')}</C>
								<C> id='RSV_NO'		width=80	name='예약번호'		align=left </C>
								<C> id='RST_GBN'	width=80	name='예약결과'			align=left leftmargin=10 EditStyle=Combo Data='1:미회신,2:확정,3:일반취소,4:완료취소,5:NoShow,6:미당첨,7:처리중'</C>
								<C> id='USE_CNT'	width=55	name='이용실적'		align=right Edit=none </C>
								<C> id='ENO_TEL'	width=100	name='연락처'		align=left  Edit=none </C>
								<C> id='SEASON_GBN'	width=65	name='성수기구분'	align=center Edit=none Value={Decode(SEASON_GBN, '1', '비성수기', '2', '성수기')} </C>
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
<!-- KPI Pool 설정 테이블 -->
<object id="bndT_WL_CONDOUSE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_WL_CONDOUSE">
    <Param Name="BindInfo", Value='
        <C>Col=DPT_NM       Ctrl=txtDPT_NM          Param=value     </C>
        <C>Col=JOB_NM       Ctrl=txtJOB_NM          Param=value     </C>
        <C>Col=ENO_NM       Ctrl=txtENO_NM          Param=value     </C>
        <C>Col=STR_YMD      Ctrl=txtSTR_YMD         Param=value     </C>
        <C>Col=CN_NAME      Ctrl=txtCN_NAME         Param=value     </C>
        <C>Col=CO_NM        Ctrl=txtCO_NM           Param=value     </C>
        <C>Col=STAY_CNT     Ctrl=txtSTAY_CNT        Param=value     </C>
        <C>Col=ROOM_CNT     Ctrl=txtROOM_CNT        Param=value     </C>
        <C>Col=RSV_NO       Ctrl=txtRSV_NO          Param=value     </C>
        <C>Col=RST_GBN      Ctrl=cmbRST_GBN         Param=value     </C>
        <C>Col=ENO_TEL      Ctrl=txtENO_TEL         Param=value     </C>
    '>
</object>