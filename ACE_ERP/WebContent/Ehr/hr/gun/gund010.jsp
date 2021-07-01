<!--
***********************************************************************
* @source      : gund010.jsp
* @description : 연차발생/미사용금액 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/20      오대성        최초작성.
* 2009/11/11      권혁수        U&I 방식으로 변경
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>연차발생/미사용금액(gund010)</title>
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

		var btnList = 'TFFTTFFT';

        var today = getToday();

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function fnc_SearchList() {

            if(!fnc_SearchItemCheck()) return;

            var f = document.form1;

			//근태변경신청현황 정보 조회
			var pis_ym = document.getElementById("txtPIS_YM_SHR").value;
            var gbn = "";
			var gbn_cd = "";
            var basis = "";
            if(f.rdoGBN_SHR[0].checked){
                gbn = "HEAD";
                gbn_cd = document.getElementById("cmbHEAD_CD_SHR").value;
            }else{
                gbn = "DPT";
                gbn_cd = document.getElementById("cmbDPT_CD_SHR").value;
            }

			dsT_DI_YEARLY.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.d.gund010.cmd.GUND010CMD&S_MODE=SHR&PIS_YM="+pis_ym+"&GBN="+gbn+"&GBN_CD="+gbn_cd+"&BASIS=DILI";
			dsT_DI_YEARLY.reset();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			*
         ********************************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 03. 저장 함수							*
         ********************************************/
        function fnc_Save() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 05. 인쇄 함수  							*
         ********************************************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_DI_YEARLY.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_DI_YEARLY.GridToExcel("연차발생/미사용금액", '', 225);

        }

		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 08. 추가 함수 							*
         ********************************************/
        function fnc_Append() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 09. 제거 함수 							*
         ********************************************/
        function fnc_Remove() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 10. 초기화 함수  						*
         ********************************************/
        function fnc_Clear() {

			document.getElementById("txtPIS_YM_SHR").value = today.substring(0,7);
			document.getElementById("cmbHEAD_CD_SHR").value = "";
            document.getElementById("cmbDPT_CD_SHR").value = "";

            document.getElementById("resultMessage").innerText = ' ';

            dsT_DI_YEARLY.ClearData();

            document.getElementById("txtPIS_YM_SHR").focus();

        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			if (dsT_DI_YEARLY.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {

	        var pis_ym = document.getElementById("txtPIS_YM_SHR");

            if(pis_ym.value == ""){
                alert("해당년월을 입력하세요!");
                pis_ym.focus();
                return false;
            }

            return true;

        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

         	//이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_DI_YEARLY,0,"false","true");      // Grid Style 적용

			     
            //본부
            for( i = 1; i <= dsT_CM_COMMON_B2.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_B2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_B2.NameValue(i,"CODE")+"  "+dsT_CM_COMMON_B2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbHEAD_CD_SHR").add(oOption);

            }
            //소속
            for( i = 1; i <= dsT_CM_COMMON_A4.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A4.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A4.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A4.NameValue(i,"CODE_NAME");
                document.getElementById("cmbDPT_CD_SHR").add(oOption);

            }

			
            document.getElementById("txtPIS_YM_SHR").value = today.substring(0,7);
            document.getElementById("txtPIS_YM_SHR").focus();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}



    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet						|
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_YEARLY)  |
    | 3. 사용되는 Table List(T_DI_YEARLY) 		    |
    +----------------------------------------------->
	<Object ID="dsT_DI_YEARLY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 본부 구분-->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_B2"/>
       <jsp:param name="CODE_GUBUN"    value="B2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 소속 구분-->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A4"/>
       <jsp:param name="CODE_GUBUN"    value="A4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_YEARLY Event="OnLoadCompleted(iCount)">

        var sum_amt = 0;

		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
            //합계금액
//            for(i=1; i<=iCount; i++){
//                sum_amt = sum_amt + dsT_DI_YEARLY.NameValue(i,"YEAR_PAY");
//            }
//
//            dsT_DI_YEARLY.AddRow();
//
//            dsT_DI_YEARLY.NameValue(dsT_DI_YEARLY.RowPosition, "JOB_NM") = "합 계";
//            dsT_DI_YEARLY.NameValue(dsT_DI_YEARLY.RowPosition, "ENO_NM") = iCount+"명";
//            dsT_DI_YEARLY.NameValue(dsT_DI_YEARLY.RowPosition, "YRP_CNT") ="";
//            dsT_DI_YEARLY.NameValue(dsT_DI_YEARLY.RowPosition, "USE_CNT") = "";
//            dsT_DI_YEARLY.NameValue(dsT_DI_YEARLY.RowPosition, "NO_CNT") = "";
//            dsT_DI_YEARLY.NameValue(dsT_DI_YEARLY.RowPosition, "YRP_PER") = "";
//            dsT_DI_YEARLY.NameValue(dsT_DI_YEARLY.RowPosition, "YEAR_PAY") = sum_amt;

        }

    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_YEARLY Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_YEARLY Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">연차발생/미사용금액</td>
					<td align="right" class="navigator">HOME/근태관리/연차관리/<font color="#000000">연차발생/미사용금액</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="60"></col>
							<col width="120"></col>
							<col width="520"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
                            <td class="searchState" align="right">해당년월&nbsp;</td>
							<td class="padding2423" align="left">
								<input id="txtPIS_YM_SHR"  name="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this)" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','500','113');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
							</td>

                            <td class="padding2423" rowspan="2">
								<table width="100%" height="100%" border="1" cellspacing="1" cellpadding="2">
									<tr>
										<td><input type="radio" id="radio11" name="rdoGBN_SHR" style="border:none" value="0" checked>본부
                                                <select id="cmbHEAD_CD_SHR" name="cmbHEAD_CD_SHR" style="WIDTH:70%">
                                                    <option value=""> </option>
                                                </select>
                                        </td>
										<td><input type="radio" id="radio12" name="rdoGBN_SHR" style="border:none" value="0">소속
                                                <select id="cmbDPT_CD_SHR" name="cmbDPT_CD_SHR" style="WIDTH:70%">
                                                    <option value=""> </option>
                                                </select>
                                        </td>

									</tr>
								</table>
							</td>

                            <td>&nbsp;</td>
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
						<td width="360" valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
					<object id="grdT_DI_YEARLY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" 					value="dsT_DI_YEARLY">
						<Param Name="ViewSummary"   		value="1" >
						<param name="SortView" 				value="Left">						
						<param name="Format" 					value='
							<C> id="{CUROW}"	width=38	name="NO"				align=center	value={String(Currow)}	</C>
                            <C> id="DPT_NM"	    width=100	name="부서"		    align=center   suppress=1 </C>
                            <C> id="TEAM_NM"	width=100	name="팀"		    	align=left       suppress=2 </C>                            
                            <C> id="JOB_NM"		width=80	name="직위"		    align=center   SumText="합 계" </C>
                            <C> id="ENO_NO"     width=65	name="사번"         	align=center    </C>
                            <C> id="ENO_NM"	    width=60	name="성명"	        align=center    </C>

                            <G> name="연차사용현황" HeadBgColor="#F7DCBB"
                                <C> id="YRP_CNT"	width=60	name="발생"	    align=right     	sumtext=@sum </C>
                                <C> id="USE_CNT"	width=60	name="사용"	    align=right     	sumtext=@sum </C>
                                <C> id="NO_CNT"	    width=60	name="미사용"		align=right    	sumtext=@sum </C>
                                <C> id="YRP_PER"		width=50	name="사용율"		align=right    	sumtext=@avg show=false</C>
                            </G>
                            <C> id="YEAR_PAY"	width=80	name="미사용;금액"   align=right   sumtext=@sum </C>
                            <C> id="HIR_YMD"	width=75	name="입사일"			align=center    </C>                            
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