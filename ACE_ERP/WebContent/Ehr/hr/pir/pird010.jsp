<!--
    ************************************************************************************
    * @Source         : pird010.jsp                                                    *
    * @Description    : 인사기록카드 PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/05  |  박인이   | 최초작성                                               *
    * 2007/05/10  |  이승욱   | 조건수정                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>인사기록카드(pird010)</title>
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

        var btnList = 'TFFTFTFT';

        var dsTemp = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //이곳에 해당 코딩을 입력 하세요

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

            //이곳에 해당 코딩을 입력 하세요

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

            var OCC_CD =  document.getElementById("cmbOCC_CD_SHR").value;
            var PRT_SELT = document.getElementById("cmbPRT_SELT_SHR").value;
            var NO_SHR = document.getElementById("txtNO_SHR").value;

            // 개인별인경우
            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {
                if (document.getElementById("txtNO_SHR").value == "") {
                    alert("사번은 필수입력항목입니다.");
                    document.getElementById("txtNO_SHR").focus();
                    return;
                }
            }
            //출력 구분
            if(document.form1.chkPRT_GUB.checked == true) {
                var PRT_GUB = "Y";
            }else {
                var PRT_GUB = "N";
            }


            //미리보기
            if(PRT_SELT == "1" && PRT_GUB == "Y"){

            if(document.form1.cmbPRT_KIND1_SHR.checked == true) {
                var PRT_PAGE_01 = "Y" ;
			}else{
                var PRT_PAGE_01 = "N";
            }
            if(document.form1.cmbPRT_KIND2_SHR.checked == true) {
                var PRT_PAGE_02 = "Y";
			}else{
                var PRT_PAGE_02 = "N";
			}
            if(document.form1.cmbPRT_KIND3_SHR.checked == true) {
                var PRT_PAGE_03 = "Y";
			}else{
                var PRT_PAGE_03 = "N";
			}
            if(document.form1.chkPRT_YN1_SHR.checked == true) {
                var QVAL_01 = "Y";
			}else{
                var QVAL_01 = "N";
			}
            if(document.form1.chkPRT_YN2_SHR.checked == true) {
                var QVAL_02 = "Y";
			}else{
                var QVAL_02 = "N";
			}
            if(document.form1.chkPRT_YN4_SHR.checked == true) {
                var QVAL_04 = "Y";
			}else{
                var QVAL_04 = "N";
			}
            if(document.form1.chkPRT_YN7_SHR.checked == true) {
            	var QVAL_07 = "Y";
            }else{
                var QVAL_07 = "N";
			}


			var url = "pird010_PV.jsp"
			              + "?OCC_CD="+OCC_CD
                          + "&PRT_SELT="+PRT_SELT
                          + "&NO_SHR="+NO_SHR
                          + "&PRT_PAGE_01="+PRT_PAGE_01
                          + "&PRT_PAGE_02="+PRT_PAGE_02
                          + "&PRT_PAGE_03="+PRT_PAGE_03
                          + "&QVAL_01="+QVAL_01
                          + "&QVAL_02="+QVAL_02
                          + "&QVAL_04="+QVAL_04
                          + "&QVAL_07="+QVAL_07;


            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;

	        }

            //바로 출력
	        else {

            var hnwParm = "[:OCC_CD]=[:PRT_SELT]=[:NO_SHR]=[:PRT_PAGE_01]=[:PRT_PAGE_02]=[:PRT_PAGE_03]=";
            hnwParm    += "[:QVAL_01]=[:QVAL_02]=[:QVAL_04]=[:QVAL_07]=";
            document.form1.rptObject.SetValues = hnwParm;

			hnwParm = "";
            hnwParm    += "[:OCC_CD]="   + document.getElementById("cmbOCC_CD_SHR").value;
            hnwParm    += "[:PRT_SELT]=" + document.getElementById("cmbPRT_SELT_SHR").value;
            hnwParm    += "[:NO_SHR]="   + document.getElementById("txtNO_SHR").value;

            if(document.form1.cmbPRT_KIND1_SHR.checked == true) {
                hnwParm    += "[:PRT_PAGE_01]=Y";
			}else{
                hnwParm    += "[:PRT_PAGE_01]=N";
			}
            if(document.form1.cmbPRT_KIND2_SHR.checked == true) {
                hnwParm    += "[:PRT_PAGE_02]=Y";
			}else{
                hnwParm    += "[:PRT_PAGE_02]=N";
			}
            if(document.form1.cmbPRT_KIND3_SHR.checked == true) {
                hnwParm    += "[:PRT_PAGE_03]=Y";
			}else{
                hnwParm    += "[:PRT_PAGE_03]=N";
			}


            if(document.form1.chkPRT_YN1_SHR.checked == true) {
                hnwParm    += "[:QVAL_01]=Y";
			}else{
                hnwParm    += "[:QVAL_01]=N";
			}
            if(document.form1.chkPRT_YN2_SHR.checked == true) {
                hnwParm    += "[:QVAL_02]=Y";
			}else{
                hnwParm    += "[:QVAL_02]=N";
			}

            if(document.form1.chkPRT_YN4_SHR.checked == true) {
                hnwParm    += "[:QVAL_04]=Y";
			}else{
                hnwParm    += "[:QVAL_04]=N";
			}

            if(document.form1.chkPRT_YN7_SHR.checked == true) {
            	hnwParm    += "[:QVAL_07]=Y";
            }else{
                hnwParm    += "[:QVAL_07]=N";
			}


         document.form1.rptObject.SetValues = hnwParm;
         document.form1.rptObject.RunButton("CommandPrint");
         return;

         }

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            alert("개발중입니다.");

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

			//팝업으로 호출시
            if (dsTemp != null) {

                document.getElementById("cmbPRT_KIND1_SHR").checked  = true;
	            document.getElementById("cmbPRT_KIND2_SHR").checked  = false;
	            document.getElementById("cmbPRT_KIND3_SHR").checked  = false;
	            document.getElementById("chkPRT_YN1_SHR").checked  = true;
	            document.getElementById("chkPRT_YN2_SHR").checked  = true;
	            document.getElementById("chkPRT_YN4_SHR").checked  = true;
	            document.getElementById("chkPRT_YN7_SHR").checked  = true;


            }else{

	            document.getElementById("cmbOCC_CD_SHR").value    = 'AM';
	            document.getElementById("cmbPRT_KIND1_SHR").checked  = true;
	            document.getElementById("cmbPRT_KIND2_SHR").checked  = true;
	            document.getElementById("cmbPRT_KIND3_SHR").checked  = true;
	            document.getElementById("cmbPRT_SELT_SHR").value  = '1';
	            document.getElementById("txtNO_SHR").value        = '';
	            document.getElementById("txtNM_SHR").value        = '';
                document.getElementById("txtNM_SHR").className = "";
                document.getElementById("txtNM_SHR").readOnly  = false;
	            document.getElementById("chkPRT_YN1_SHR").checked  = true;
	            document.getElementById("chkPRT_YN2_SHR").checked  = true;
	            document.getElementById("chkPRT_YN4_SHR").checked  = true;
	            document.getElementById("chkPRT_YN7_SHR").checked  = true;
                document.getElementById("cmbPRT_KIND1_SHR").disabled  =  false;
                document.getElementById("cmbPRT_KIND2_SHR").disabled  =  false;
                document.getElementById("cmbPRT_KIND3_SHR").disabled  =  false;
                document.getElementById("chkPRT_GUB").checked  = false;
                document.getElementById("chkPRT_GUB").disabled = false;

                document.getElementById("cmbOCC_CD_SHR").focus();
            }

            document.getElementById("resultMessage").innerText = ' ';

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            // 근로구분 구분 검색 콤보박스 생성
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD_SHR").add(oOption);
			}
			//팝업으로 호출시
            if (dsTemp != null) {

               	//근로구분
				document.getElementById("cmbOCC_CD_SHR").value = dsTemp.NameValue(1,"OCC_CD");
            	document.getElementById("cmbOCC_CD_SHR").disabled = true;

            	//출력선택
				document.getElementById("cmbPRT_SELT_SHR").value = "1";
            	document.getElementById("cmbPRT_SELT_SHR").disabled = true;

            	//사번
            	document.getElementById("txtNO_SHR").value = dsTemp.NameValue(1,"ENO_NO");
            	document.getElementById("txtNM_SHR").value = dsTemp.NameValue(1,"ENO_NM");
                document.getElementById("txtNO_SHR").className = "input_ReadOnly";
                document.getElementById("txtNO_SHR").readOnly     = true;
                document.getElementById("txtNM_SHR").className = "input_ReadOnly";
                document.getElementById("txtNM_SHR").readOnly     = true;
                document.getElementById("ImgNo").style.display = "none";

				//기본체크 값
                document.getElementById("cmbPRT_KIND1_SHR").checked  = true;
	            document.getElementById("cmbPRT_KIND2_SHR").checked  = true;
	            document.getElementById("cmbPRT_KIND3_SHR").checked  = true;


	            document.getElementById("chkPRT_YN1_SHR").checked  = true;
	            document.getElementById("chkPRT_YN2_SHR").checked  = true;
	            document.getElementById("chkPRT_YN4_SHR").checked  = true;
	            document.getElementById("chkPRT_YN7_SHR").checked  = true;

            }else{

                document.getElementById("chkPRT_GUB").checked = true;
	            document.getElementById("cmbOCC_CD_SHR").focus();
            }

        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsTemp != null) {
                window.close();

            } else {
                frame = window.external.GetFrame(window);

                frame.CloseFrame();
            }

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

        function fnc_Popup(cd, nm){

            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {
               fnc_empl2Popup(cd, nm, '1');
            }

            else if (document.getElementById("cmbPRT_SELT_SHR").value == "2") {
              // fnc_commonCodePopup(cd, nm,'소속','A4');
               fnc_commnmPopup(cd, nm, '소속', 'DEPT');
           }

            else if (document.getElementById("cmbPRT_SELT_SHR").value == "3") {
               fnc_commonCodePopup(cd, nm,'직위','A2');
            }

        }

        function fnc_FldChange() {

            document.getElementById("txtNO_SHR").value = "";
            document.getElementById("txtNM_SHR").value = "";

            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {

                document.getElementById("txtNM_SHR").className = "";
                document.getElementById("txtNM_SHR").readOnly  = false;
                document.getElementById("chkPRT_GUB").disabled = false;

            } else{

                document.getElementById("txtNM_SHR").className = "input_ReadOnly";
                document.getElementById("txtNM_SHR").readOnly  = true;
                document.getElementById("chkPRT_GUB").checked  =  false;
                document.getElementById("chkPRT_GUB").disabled =  true;
                document.getElementById("cmbPRT_KIND1_SHR").disabled  =  false;
                document.getElementById("cmbPRT_KIND2_SHR").disabled  =  false;
                document.getElementById("cmbPRT_KIND3_SHR").disabled  =  false;


            }

        }


        //출력구분에 따른 출력선택제어
        function fnc_GUBUN() {

         if(document.getElementById("chkPRT_GUB").checked  ==  true)  {

              document.getElementById("cmbPRT_KIND1_SHR").checked  =  true;
              document.getElementById("cmbPRT_KIND2_SHR").checked  =  true;
              document.getElementById("cmbPRT_KIND3_SHR").checked  =  true;

              document.getElementById("cmbPRT_KIND1_SHR").disabled  =  true;
              document.getElementById("cmbPRT_KIND2_SHR").disabled  =  true;
              document.getElementById("cmbPRT_KIND3_SHR").disabled  =  true;

              document.getElementById("txtNM_SHR").focus();

         }
         else {

              document.getElementById("cmbPRT_KIND1_SHR").disabled  =  false;
              document.getElementById("cmbPRT_KIND2_SHR").disabled  =  false;
              document.getElementById("cmbPRT_KIND3_SHR").disabled  =  false;


         }

       }


        function fnc_GetNm() {

            // 개인별
            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {
                fnc_GetEnoNm('txtNO_SHR', 'txtNM_SHR','0','0');
            }

            // 소속별
            else if (document.getElementById("cmbPRT_SELT_SHR").value == "2") {
                fnc_GetCommNm('A4', 'txtNO_SHR','txtNM_SHR');
            }

            // 직위별
            else if (document.getElementById("cmbPRT_SELT_SHR").value == "3") {
                fnc_GetCommNm('A2', 'txtNO_SHR','txtNM_SHR','0','0');
            }

        }

        function fnc_Getcd() {

            // 개인별
            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {
	            fnc_GetEnoNo('txtNM_SHR','txtNO_SHR');
            }

        }

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)    |
    | 3. 사용되는 Table List(T_CM_PERSON)           |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_PERSON.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>
    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">인사기록카드</td>
                    <td align="right" class="navigator">HOME/인사관리/인사정보출력/<font color="#000000">인사기록카드</font></td>
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
            <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a-->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="right" >(소속/직위별인 경우 BLANK: ALL)</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="80"></col>
                    <col width="80"></col>
                    <col width="192"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
					<td class="creamBold" align="right">근로구분</td>
					<td class="padding2423" align="left">
						<select id="cmbOCC_CD_SHR" style="WIDTH: 100%">
							<option value="A">모두</option>
						</select>
					</td>
                    <td align="center" class="creamBold">출력페이지</td>
                    <td align="center" class="padding2423">
                        <input type="checkbox" name="cmbPRT_KIND1_SHR" id=cmbPRT_KIND1_SHR style="border:0" align="absmiddle" checked>1&nbsp;
                        <input type="checkbox" name="cmbPRT_KIND2_SHR" id=cmbPRT_KIND2_SHR style="border:0" align="absmiddle" checked>2&nbsp;
                        <input type="checkbox" name="cmbPRT_KIND3_SHR" id=cmbPRT_KIND3_SHR style="border:0" align="absmiddle" checked>3&nbsp;
                    </td>
                    <td align="center" class="creamBold">출력선택</td>
                    <td class="padding2423">
                        <select id=cmbPRT_SELT_SHR onchange="fnc_FldChange()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()" style="width:72">
                            <option value="1">개인별</option>
                            <option value="2">소속별</option>
                            <option value="3">직위별</option>
                        </select>
                        <input id=txtNO_SHR  name=txtNO_SHR size="8"  maxlength="8" onKeyPress="JavaScript: if(document.getElementById('cmbPRT_SELT_SHR').value == '1') cfNumberCheck(); if (event.keyCode == 13) fnc_GetNm();" onChange="fnc_GetNm();">
                        <input id=txtNM_SHR name=txtNM_SHR size="12" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_Getcd();" onchange="fnc_Getcd();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="ImgNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_Popup('txtNO_SHR','txtNM_SHR')"></a>
                    </td>
                </tr>
                <tr>
                   <td align="center" class="creamBold">출력여부</td>
                    <td class="padding2423" colspan="5">
                        <input type="checkbox" name="chkPRT_YN1_SHR"  id=chkPRT_YN1_SHR  style="border:0" align="absmiddle" checked>신체사항
                        <input type="checkbox" name="chkPRT_YN2_SHR"  id=chkPRT_YN2_SHR  style="border:0" align="absmiddle" checked>가족관계
                        <input type="checkbox" name="chkPRT_YN4_SHR"  id=chkPRT_YN4_SHR  style="border:0" align="absmiddle" checked>교육참여
                        <input type="checkbox" name="chkPRT_YN7_SHR"  id=chkPRT_YN7_SHR  style="border:0" align="absmiddle" checked>고과&nbsp;
                    </td>
                </tr>

                <tr>
                    <td align="center" class="creamBold">구&nbsp;&nbsp;&nbsp;&nbsp;분</td>
                     <td class="padding2423" colspan="5">
                         <input type="checkbox" name="chkPRT_GUB"     id=chkPRT_GUB      style="border:0" align="adsmiddle" onClick="fnc_GUBUN()"  checked>미리보기
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
                    <td valign="top" class="searchState">
                    <!--여기서부터 코딩입니다//-->
                    <comment id="__NSID__">
                      <object id="rptObject" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
                      <param name="hnwsrc"    VALUE="pird010.hnw">
                      <param name="initvalue" VALUE="">
                      <param name="hidewnd"   VALUE="N">
                      <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
                      </object>
                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                    <!--여기까지 코딩입니다//-->

                        <span id="resultMessage">&nbsp;</span>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

</form>
<!-- form 끝 -->

</body>
</html>
