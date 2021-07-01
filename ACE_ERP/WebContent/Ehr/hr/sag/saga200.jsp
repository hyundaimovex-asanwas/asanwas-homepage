<!--
    ************************************************************************************
    * @source         : saga200.jsp 				                                   *
    * @description   : 개인별상세내역(구) PAGE.                                                  *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2016/09/08  |  이동훈   | erp로 이사                                               		   *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>개인별상세내역(구)</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>
	
<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'T';
        var savObj = new Array();

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var PAY_YMD_SHR = document.getElementById("txtPAY_YMD_SHR").value; // 기준년도     	
			var APY_YMD_SHR = document.getElementById("txtAPY_YMD_SHR").value; // 적용일자
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // 사번

			//기준일자가 없으면 조회 못함.
			if(APY_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("기준일자를 입력하세요.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}


	        dsT_CP_PAYTABLE.UseChangeInfo = true;
	        dsT_CP_PAYTABLE.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga200.cmd.SAGA200CMD&S_MODE=SHR&APY_YMD_SHR="+APY_YMD_SHR+"&PAY_YMD="+PAY_YMD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
	        dsT_CP_PAYTABLE.Reset();

        }
        
        /***********************************
         *        01. 년간소득액 조회  		   *
         ***********************************/
        function fnc_SearchList_Year() {

			var PAY_YMD_SHR = document.getElementById("txtPAY_YMD_SHR").value; // 기준년도 	
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // 사번

			//기준일자가 없으면 조회 못함.
			if(PAY_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("기준년도를 입력하세요.");
					document.getElementById("txtPAY_YMD_SHR").focus();
					return false;
				}
			}

            //데이터셋 전송
            dsT_CP_PAYTABLE.UseChangeInfo = true;
            dsT_CP_PAYTABLE.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga200.cmd.SAGA200CMD&S_MODE=SHR_ALL&PAY_YMD="+PAY_YMD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
            dsT_CP_PAYTABLE.Reset();

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

			var PAY_YMD_SHR = document.getElementById("txtPAY_YMD_SHR").value; // 기준년도        	
			var APY_YMD_SHR = document.getElementById("txtAPY_YMD_SHR").value; // 기준일자
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // 사번


			//기준일자가 없으면 조회 못함.
			if(APY_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("기준일자를 입력하세요.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}


	        dsT_Grid_Detail.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga200.cmd.SAGA200CMD&S_MODE=SHR&APY_YMD_SHR="+APY_YMD_SHR+"&PAY_YMD="+PAY_YMD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
	        dsT_Grid_Detail.Reset();

			var ls_temp = "CUDATE:STRING,CTITLE:STRING";

			dsT_RP_PAYTABLE.SetDataHeader(ls_temp);
			dsT_RP_PAYTABLE.Addrow();
			dsT_RP_PAYTABLE.namevalue(1,"CUDATE")=getToday();

			var yyyymmdd = document.getElementById("txtAPY_YMD_SHR").value; // 적용일자
			var yyyy = yyyymmdd.substring(0,4);
			var mm = yyyymmdd.substring(5,7);

			dsT_RP_PAYTABLE.namevalue(1,"CTITLE")= " 급여대장 [" + yyyy + "년" + mm + "월]";

			gcrp_print.Preview();

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_PAYTABLE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CP_PAYTABLE.GridToExcel("급여테이블", '', 225);

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

	        //이곳에 해당 코딩을 입력 하세요
        	window.close();

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

			document.getElementById("txtPAY_YMD_SHR").value = '2015';            	
			document.getElementById("txtAPY_YMD_SHR").value = '2015-01-25';
			document.getElementById("txtAPY_YMD_SHR").focus();
    	
        	
			fnc_ChangeGrid();      //그리드 변경 처리

        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /*****************************
         * 17. 엑셀파일 업로드 처리  *
         ****************************/
         function fnc_FileUpload() {



        }

        /*************************
         * 그리드 변경 처리      *
         ************************/
		function fnc_ChangeGrid(obj) {


			if(obj == undefined || obj.value == "1"){
				
			form1.grdT_CP_PAYTABLE.Format =
					"<FC> id='{CUROW}'			width=40		name='NO'					align=center	value={String(Currow)}		BgColor='#EEEEEE'	SubSumText=''	</FC>" +
					"<FC> id='DPT_NM'        	width=90        name='소속'         		align=center   </FC>" +
					"<FC> id='JOB_NM'        	width=65        name='직위'        			align=center   </FC>" +
					"<FC> id='ENO_NM'        	width=60        name='성명'          		align=center   SubSumText='합계' </FC>" +
					"<C> id='ENO_NO'        	width=60        name='사번'          		align=center   </C>" +
					"<C> id='CET_NO'       		width=100       name='주민번호'        		align=center   </C>" +
					"<C> id='BAS_AMT'       	width=75        name='기본급'        		align=right    </C>" +
					"<C> id='DUTY_AMT'       	width=75        name='직책수당'        		align=right    </C>" +
					"<C> id='LAW_AMT'       	width=75        name='시간외'        		align=right    </C>" +
					"<C> id='LSEV_AMT'       	width=75        name='근속수당'      		align=right    </C>" +
					"<C> id='ETC_AMT_11'      	width=90        name='자기계발비'      		align=right    </C>" +
					"<C> id='ETC_AMT_12'      	width=90        name='남북경협'      	    align=right    </C>" +
					"<C> id='BNS_AMT'       	width=75        name='상여분할'        		align=right    </C>" +
					"<C> id='ETC_AMT4'       	width=85        name='가족부양비'        	align=right    </C>" +
					"<C> id='ETC_AMT'       	width=90        name='차량유지비'     		align=right    </C>" +
					"<C> id='ETC_AMT_06'      	width=90        name='출납수당'     	    align=right    </C>" +
					"<C> id='ETC_AMT_17'      	width=90        name='운전수당'      	    align=right     </C>" +
					"<C> id='ETC_AMT_18'      	width=90        name='연장수당'      	    align=right     </C>" +
					"<C> id='ETC_AMT_20'      	width=90        name='자격수당'      	    align=right     </C>" +
					"<C> id='ETC_AMT_19'      	width=90        name='사장단수당'      		align=right     </C>" +
					"<C> id='ETC_AMT_13'      	width=90        name='특수지수당'      		align=right     </C>" +
					"<C> id='ETC_AMT_012'    	width=100       name='북측근무(계)'      	align=right     </C>" +
					"<C> id='ETC_AMT2'       	width=100       name='지역근무수당'      	align=right     </C>" +
					"<C> id='ETC_AMT_013'    	width=100       name='현장수당(계)'     	align=right     </C>" +
					"<C> id='SCH_AMT'       	width=90        name='학자금'      	    	align=right     </C>" +
					"<C> id='PPEN_AMT'       	width=75        name='개인연금'      		align=right    </C>" +
					"<C> id='ETC_AMT_HY'     	width=100       name='현장직책수당'     	align=right     </C>" +
					"<C> id='ETC_AMT3'       	width=90        name='식대'      	    	align=right     </C>" +
					"<C> id='ETC_AMT_23'     	width=90        name='전월소급'     		align=right     </C>" +
					"<C> id='ETC_AMT_BD'     	width=100       name='휴일근무수당'     	align=right     </C>" +
					"<C> id='ETC_AMT_117'    	width=100       name='승선수당'     		align=right     </C>" +
					"<C> id='ETC_AMT_BA'      	width=90        name='기타지불'      	    align=right     </C>" +
					"<C> id='SALT_AMT'      	width=75        name='급여총계'      		align=right    BgColor='#99FF99' </C>" +

					"<G> name='공제' 		BgColor='#dae0ee'   "+
					"<C> id='INCM_TAX'       	width=75       	name='소득세'      		    align=right    </C>" +
					"<C> id='CITI_TAX'       	width=75        name='주민세'        	    align=right    </C>" +
					"<C> id='NPEN_AMT'       	width=75        name='국민연금'     	    align=right    </C>" +
					"<C> id='HINU_AMT'       	width=85        name='의료보험료'      		align=right    </C>" +
					"<C> id='OLD_AMT'       	width=95        name='장기요양보험'    		align=right    </C>" +
					"<C> id='HINS_AMT'       	width=75        name='고용보험'      	    align=right    </C>" +
					"<C> id='LAB_AMT'       	width=75        name='보증보험'      	    align=right    </C>" +
					"<C> id='PPED_AMT'       	width=75        name='개인연금'     		align=right    </C>" +
					"<C> id='ETC_AMT_21'      	width=85        name='오세븐공제'     		align=right    </C>" +
					"<C> id='DHLP_AMT'       	width=75        name='공조회비'      		align=right    </C>" +
					"<C> id='LON_RPY'       	width=80        name='사내대출'       		align=right    </C>" +
					"<C> id='LON_INT'       	width=80        name='상환이자'     		align=right    </C>" +
					"<C> id='LON_RPY2'       	width=80        name='공조대출' 			align=right    </C>" +
					"<C> id='LON_INT2'       	width=80        name='상환이자'  			align=right    </C>" +
					"<C> id='ETC_AMT_A1'     	width=95        name='건강보험정산'  		align=right    </C>" +
					"<C> id='ETC_AMT_A2'      	width=95        name='고용보험정산'  		align=right    </C>" +
					"<C> id='ETC_AMT_A3'     	width=95        name='연말정산소득'  		align=right    	</C>" +
					"<C> id='ETC_AMT_A4'      	width=95        name='연말정산주민'  		align=right    	</C>" +
					"<C> id='ETC_AMT_A6'      	width=95        name='연말정산농특'  		align=right    	</C>" +					
					"<C> id='ETC_AMT_ETC'    	width=75        name='기타'      			align=right    </C>" +
					"<C> id='DDTT_AMT'       	width=80        name='공제액계'     		align=right    BgColor='#FFFF99'</C>" +
					"</G>"+
					"<C> id='PAY_AMT'       	width=85        name='실수령액'   			align=right    BgColor='#FF9999'</C>" +
					"<C> id='PIS_YYMM'       	width=120       name='지급년월'     		align=center        </C>" +					
					"<C> id='TAX_DPT2'       	width=120       name='회계소속'     		align=left          </C>" +
					"<C> id='GBN_NM'       		width=120       name='근무지'     			align=left          </C>";
			}


			//첫번째 인수 : 그리드명
			//두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)
			//네번째 인수 : sort기능 사용여부(false:미사용, true:sort사용)

			cfStyleGrid_New(form1.grdT_CP_PAYTABLE, 15,"false","true");

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
    | 2. 이름 : dsT_CP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=SubsumExpr        value="total">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : ds01T_CP_PAYTABLE                   |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="ds01T_CP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>




    <!----------------------------------------------+
    | 1. 레포트용 DataSet                     		|
    | 2. 이름 : dsT_RP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="dsT_RP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 			Value="True">
        <Param Name="UseChangeInfo" 	Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_Grid_Detail" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
    	<param name="SubsumExpr"   		value="1:TAX_DPT">
        <Param Name="Syncload" 			Value="True">
        <Param Name="UseChangeInfo" 	Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>


    <!--*************************************
    *                                      *
    *  Component에서 발생하는 Event 처리부 *
    *                                      *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYTABLE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYTABLE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>



    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYTABLE Event="OnDataError()">
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[시작일자/종료일자/직위/사번] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("적용일자/근로구분/직위/호봉에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgYearSalary','','../../images/button/btn_YearSalaryOver.gif',1)"><img src="../../images/button/btn_YearSalaryOn.gif" name="imgYearSalary" border="0" align="absmiddle" onClick="fnc_SearchList_Year()"></a>
			&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)"><img src="../../images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>

								<col width="80"></col>
								<col width="200"></col>
								<col width="80"></col>
								<col width="200"></col>
								<col width="80"></col>
								<col width="170"></col>
								<col width=""></col>
							</colgroup>
							<tr>

								<td align="center" class="searchState">기준년도</td>
								<td>
								<input id="txtPAY_YMD_SHR" style="width:83" maxlength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
								</td>
								<td align="center" class="searchState">기준일자</td>
								<td>
									<input id="txtAPY_YMD_SHR" style="width:83" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPY_YMD_SHR','','535','112');"></a>
								</td>

								<td align="center" class="searchState">사원번호</td>
								<td >
									<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();" style="ime-mode:disabled">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchList();">
									<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgENO_NO_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');fnc_SearchList();"></a>
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    <td width="80" style="padding-right:5px; padding-top:2px;">
                    </td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CP_PAYTABLE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"					value="dsT_CP_PAYTABLE">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
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




<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   #### 정 기 급 여 ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
	<PARAM NAME="MasterDataID"					VALUE="dsT_RP_PAYTABLE">
	<param name="DetailDataID"	    			value="dsT_Grid_Detail">
	<PARAM NAME="PaperSize"						VALUE="A3">
	<PARAM NAME="LandScape"						VALUE="1">
  	<PARAM NAME="PrintSetupDlgFlag" 			VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="110">
	<PARAM NAME="Format" 						VALUE="

<B>id=Header ,left=0,top=0 ,right=4101 ,bottom=170 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='CTITLE', left=1405, top=56, right=2474, bottom=143, face='HY중고딕', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=2, pencolor=#000000, Dec=0</C>
	<T>id='단위 : 원' ,left=3784 ,top=122 ,right=4001 ,bottom=169 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CUDATE', left=3704, top=82, right=4001, bottom=122, align='right', face='굴림', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Print Date:' ,left=3450 ,top=61 ,right=3699 ,bottom=122 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=4101 ,bottom=249 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=3998 ,top=3 ,right=24 ,bottom=3 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=614 ,top=3 ,right=614 ,bottom=249 </L>
	<L> left=254 ,top=3 ,right=254 ,bottom=249 </L>
	<T>id='기본급' ,left=638 ,top=13 ,right=849 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=24 ,top=3 ,right=24 ,bottom=246 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=2553 ,top=5 ,right=2553 ,bottom=249 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=4003 ,top=3 ,right=4003 ,bottom=246 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='직책수당' ,left=638 ,top=74 ,right=849 ,bottom=127 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='호봉계' ,left=635 ,top=191 ,right=849 ,bottom=249 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외' ,left=638 ,top=130 ,right=849 ,bottom=188 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지역근무수당' ,left=1389 ,top=191 ,right=1648 ,bottom=249 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근속수당' ,left=902 ,top=13 ,right=1114 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='식대' ,left=1662 ,top=191 ,right=1921 ,bottom=249 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급계' ,left=2254 ,top=191 ,right=2529 ,bottom=249 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타지급' ,left=2254 ,top=16 ,right=2529 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상여분할' ,left=2254 ,top=74 ,right=2529 ,bottom=127 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전월소급' ,left=1971 ,top=13 ,right=2201 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='휴일근무수당' ,left=1942 ,top=71 ,right=2201 ,bottom=130 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='승선수당' ,left=1958 ,top=130 ,right=2201 ,bottom=188 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현장직책수당' ,left=1662 ,top=130 ,right=1921 ,bottom=185 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='학자금' ,left=1699 ,top=74 ,right=1921 ,bottom=127 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='개인연금' ,left=1699 ,top=13 ,right=1921 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특수지수당' ,left=1389 ,top=130 ,right=1648 ,bottom=185 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사장단수당' ,left=1389 ,top=74 ,right=1648 ,bottom=127 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='남북경협수당' ,left=1389 ,top=13 ,right=1648 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자격수당' ,left=1162 ,top=196 ,right=1373 ,bottom=249 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연장수당' ,left=1162 ,top=130 ,right=1373 ,bottom=191 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='운전수당' ,left=1162 ,top=77 ,right=1373 ,bottom=135 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출납' ,left=1162 ,top=16 ,right=1373 ,bottom=74 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자기계발비' ,left=902 ,top=74 ,right=1114 ,bottom=127 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='가족부양비' ,left=902 ,top=130 ,right=1114 ,bottom=185 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량유지비' ,left=902 ,top=191 ,right=1114 ,bottom=249 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='실수령액' ,left=3778 ,top=191 ,right=3990 ,bottom=249 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소속' ,left=275 ,top=13 ,right=553 ,bottom=71 ,align='left' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=24 ,top=249 ,right=4006 ,bottom=249 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='사번' ,left=37 ,top=13 ,right=249 ,bottom=71 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직위' ,left=37 ,top=130 ,right=249 ,bottom=185 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급호' ,left=37 ,top=191 ,right=249 ,bottom=249 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=37 ,top=74 ,right=249 ,bottom=127 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='최종변동일' ,left=275 ,top=74 ,right=556 ,bottom=127 ,align='left' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=2580 ,top=130 ,right=2831 ,bottom=185 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국민연금' ,left=2836 ,top=21 ,right=3135 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='복지카페' ,left=3461 ,top=74 ,right=3709 ,bottom=127 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타공제' ,left=3741 ,top=19 ,right=3990 ,bottom=69 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제계' ,left=3778 ,top=130 ,right=3990 ,bottom=185 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공조회대출' ,left=3461 ,top=21 ,right=3709 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보증보험' ,left=3175 ,top=130 ,right=3424 ,bottom=191 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공조회비' ,left=3175 ,top=188 ,right=3424 ,bottom=238 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사내대출' ,left=3175 ,top=21 ,right=3424 ,bottom=77 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='개인연금' ,left=3175 ,top=77 ,right=3424 ,bottom=130 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='고용보험' ,left=2836 ,top=130 ,right=3135 ,bottom=183 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='건강보험' ,left=2836 ,top=74 ,right=3135 ,bottom=132 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득세' ,left=2580 ,top=74 ,right=2831 ,bottom=127 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='배부자장경' ,left=2580 ,top=16 ,right=2831 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연말정산소득' ,left=3437 ,top=130 ,right=3736 ,bottom=183 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연말정산주민' ,left=3437 ,top=191 ,right=3736 ,bottom=243 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연말정산농특' ,left=3758 ,top=71 ,right=3990 ,bottom=127 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>

	<T>id='건강보험 정산' ,left=2577 ,top=191 ,right=2839 ,bottom=243 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='고용보험 정산' ,left=2876 ,top=188 ,right=3138 ,bottom=241 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>

</B>
<B>id=default ,left=0,top=0 ,right=4101 ,bottom=224 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=619 ,top=159 ,right=857 ,bottom=212 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3752 ,top=161 ,right=3995 ,bottom=220 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3752 ,top=101 ,right=3995 ,bottom=156 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2207 ,top=159 ,right=2527 ,bottom=212 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=614 ,top=0 ,right=614 ,bottom=222 </L>
	<L> left=2556 ,top=0 ,right=2556 ,bottom=222 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=4003 ,top=0 ,right=4003 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=254 ,top=0 ,right=254 ,bottom=222 </L>
	<L> left=24 ,top=222 ,right=4003 ,bottom=222 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=24 ,top=0 ,right=24 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<C>id='{decode(curlevel,1,,ENO_NO)}', left=37, top=0, right=249, bottom=50, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,ENO_NM)}', left=37, top=56, right=249, bottom=103, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,\'소 계\',JOB_NM)}', left=37, top=106, right=249, bottom=156, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,subcount(ENO_NO))}', left=265, top=111, right=474, bottom=161, align='right', supplevel=1 ,mask='XXXX/XX/XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,\'명\')}', left=487, top=111, right=532, bottom=161, align='left', supplevel=1, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(curlevel,1,,TEAM_NM)}', left=267, top=61, right=614, bottom=156, align='left', supplevel=1, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0, Multiline=true</C>
	<C>id='{decode(curlevel,1,,DPT_NM)}', left=267, top=13, right=614, bottom=58, align='left', supplevel=1, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0, Multiline=true</C>
	<C>id='{decode(BAS_AMT,0,,BAS_AMT)}', left=627, top=0, right=852, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(DUTY_AMT,0,,DUTY_AMT)}', left=627, top=56, right=852, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(LAW_AMT,0,,LAW_AMT)}', left=627, top=106, right=852, bottom=156, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SUM_BAS_DUTY_LAW', left=627, top=159, right=852, bottom=212, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<C>id='{decode(LSEV_AMT,0,,LSEV_AMT)}', left=878, top=0, right=1114, bottom=50, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_11,0,,ETC_AMT_11)}', left=878, top=56, right=1114, bottom=106, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT4,0,,ETC_AMT4)}', left=876, top=106, right=1114, bottom=156, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT,0,,ETC_AMT)}', left=878, top=159, right=1114, bottom=212, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_06,0,,ETC_AMT_06)}', left=1135, top=0, right=1373, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_17,0,,ETC_AMT_17)}', left=1138, top=56, right=1373, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_18,0,,ETC_AMT_18)}', left=1135, top=106, right=1373, bottom=156, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_20,0,,ETC_AMT_20)}', left=1138, top=159, right=1373, bottom=212, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_12,0,,ETC_AMT_12)}', left=1394, top=0, right=1646, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_19,0,,ETC_AMT_19)}', left=1394, top=56, right=1646, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_13,0,,ETC_AMT_13)}', left=1389, top=106, right=1643, bottom=156, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT2,0,decode(ETC_AMT_099,0,,ETC_AMT_099),ETC_AMT2)}', left=1394, top=159, right=1646, bottom=212, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(PPEN_AMT,0,,PPEN_AMT)}', left=1672, top=0, right=1921, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(SCH_AMT,0,,SCH_AMT)}', left=1672, top=56, right=1921, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_HY,0,,ETC_AMT_HY)}', left=1667, top=106, right=1916, bottom=156, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT3,0,,ETC_AMT3)}', left=1672, top=159, right=1921, bottom=212, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_23,0,,ETC_AMT_23)}', left=1953, top=0, right=2199, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_BD,0,,ETC_AMT_BD)}', left=1953, top=56, right=2199, bottom=106, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_117,0,,ETC_AMT_117)}', left=1953, top=108, right=2199, bottom=159, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_BA,0,,ETC_AMT_BA)}', left=2217, top=0, right=2524, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SALT_AMT', left=2217, top=159, right=2524, bottom=209, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<C>id='{decode(BNS_AMT,0,,BNS_AMT)}', left=2217, top=56, right=2524, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SOU_CNT', left=2580, top=0, right=2606, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,\'ㅡ\')}', left=2609, top=21, right=2633, bottom=21</C>
	<C>id='DFM_CNT', left=2635, top=0, right=2662, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,\'ㅡ\')}', left=2662, top=21, right=2686, bottom=21</C>
	<C>id='CHI_CNT', left=2688, top=0, right=2715, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,\'ㅡ\')}', left=2717, top=21, right=2741, bottom=21</C>
	<C>id='TRB_CNT', left=2741, top=0, right=2770, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,\'ㅡ\')}', left=2770, top=21, right=2794, bottom=21</C>
	<C>id='GOL_CNT', left=2797, top=0, right=2823, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INCM_TAX,0,,INCM_TAX)}', left=2580, top=56, right=2831, bottom=106, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(CITI_TAX,0,,CITI_TAX)}', left=2580, top=108, right=2831, bottom=161, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(NPEN_AMT,0,,NPEN_AMT)}', left=2839, top=0, right=3135, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(HINU_AMT+OLD_AMT,0,,HINU_AMT+OLD_AMT)}', left=2839, top=56, right=3135, bottom=108, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(HINS_AMT,0,,HINS_AMT)}', left=2839, top=108, right=3135, bottom=159, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(LON_RPY+LON_INT,0,,LON_RPY+LON_INT)}', left=3175, top=0, right=3424, bottom=53, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(PPED_AMT,0,,PPED_AMT)}', left=3175, top=56, right=3424, bottom=106, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(LAB_AMT,0,,LAB_AMT)}', left=3175, top=108, right=3424, bottom=159, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(DHLP_AMT,0,,DHLP_AMT)}', left=3175, top=167, right=3424, bottom=217, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(LON_RPY2+LON_INT2,0,,LON_RPY2+LON_INT2)}', left=3474, top=0, right=3707, bottom=53, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_21,0,,ETC_AMT_21)}', left=3474, top=56, right=3707, bottom=106, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(DDTT_AMT,0,,DDTT_AMT)}', left=3757, top=103, right=3993, bottom=159, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<C>id='PAY_AMT', left=3757, top=161, right=3993, bottom=217, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<C>id='{decode(HOB_NM,0,,HOB_NM)}', left=37, top=164, right=243, bottom=214, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_A3,0,,ETC_AMT_A3)}', left=3474, top=111, right=3707, bottom=161, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_A4,0,,ETC_AMT_A4)}', left=3474, top=167, right=3707, bottom=217, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_ETC,0,,ETC_AMT_ETC)}', left=3760, top=0, right=3993, bottom=53, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_A6,0,,ETC_AMT_A6)}', left=3757, top=45, right=3990, bottom=98, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_A1,0,,ETC_AMT_A1)}', left=2577, top=167, right=2828, bottom=217, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_A2,0,,ETC_AMT_A2)}', left=2844, top=164, right=3138, bottom=214, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>

</B>
<B>id=LDFooter ,left=0,top=0 ,right=4101 ,bottom=222 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=4003 ,top=0 ,right=4003 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=4006 ,top=0 ,right=29 ,bottom=0 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=2553 ,top=0 ,right=2553 ,bottom=222 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=614 ,top=0 ,right=614 ,bottom=222 </L>
	<L> left=254 ,top=0 ,right=254 ,bottom=222 </L>
	<L> left=24 ,top=0 ,right=24 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<X>left=614 ,top=167 ,right=876 ,bottom=209 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2215 ,top=167 ,right=2535 ,bottom=209 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3747 ,top=116 ,right=3998 ,bottom=164 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3747 ,top=167 ,right=3998 ,bottom=209 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='합 계' ,left=50 ,top=103 ,right=222 ,bottom=153 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='총원' ,left=278 ,top=103 ,right=423 ,bottom=153 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='Count' ,left=394 ,top=103 ,right=516 ,bottom=153 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<T>id='명' ,left=521 ,top=103 ,right=574 ,bottom=153 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='{Sum(BAS_AMT)}' ,left=638 ,top=5 ,right=868 ,bottom=56 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{Sum(DUTY_AMT)}' ,left=651 ,top=66 ,right=868 ,bottom=119 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(LAW_AMT)}' ,left=651 ,top=122 ,right=868 ,bottom=172 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(SUM_BAS_DUTY_LAW)}' ,left=624 ,top=167 ,right=873 ,bottom=209 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<S>id='{Sum(LSEV_AMT)}' ,left=886 ,top=5 ,right=1130 ,bottom=56 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(ETC_AMT_11)}' ,left=889 ,top=61 ,right=1130 ,bottom=108 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(ETC_AMT4)}' ,left=889 ,top=116 ,right=1130 ,bottom=164 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(ETC_AMT)}' ,left=889 ,top=175 ,right=1130 ,bottom=220 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT_06)}' ,left=1151 ,top=3 ,right=1392 ,bottom=61 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT_17)}' ,left=1151 ,top=61 ,right=1392 ,bottom=116 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT_18)}' ,left=1151 ,top=119 ,right=1392 ,bottom=169 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT_20)}' ,left=1151 ,top=172 ,right=1392 ,bottom=222 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(ETC_AMT_12)}' ,left=1418 ,top=5 ,right=1670 ,bottom=56 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(ETC_AMT_19)}' ,left=1418 ,top=61 ,right=1670 ,bottom=114 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(ETC_AMT_13)}' ,left=1418 ,top=116 ,right=1670 ,bottom=167 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(ETC_AMT_999)}' ,left=1418 ,top=169 ,right=1670 ,bottom=220 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(PPEN_AMT)}' ,left=1688 ,top=0 ,right=1937 ,bottom=64 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(SCH_AMT)}' ,left=1688 ,top=61 ,right=1937 ,bottom=114 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT_HY)}' ,left=1688 ,top=111 ,right=1937 ,bottom=161 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT3)}' ,left=1688 ,top=169 ,right=1937 ,bottom=220 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(ETC_AMT_23)}' ,left=1953 ,top=5 ,right=2204 ,bottom=61 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{SUM(ETC_AMT_BD)}' ,left=1953 ,top=61 ,right=2204 ,bottom=111 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{SUM(ETC_AMT_117)}' ,left=1953 ,top=114 ,right=2204 ,bottom=164 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{SUM(BNS_AMT)}' ,left=2215 ,top=64 ,right=2535 ,bottom=114 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(SALT_AMT)}' ,left=2215 ,top=167 ,right=2529 ,bottom=209 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<S>id='{Sum(INCM_TAX)}' ,left=2580 ,top=56 ,right=2831 ,bottom=106 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(CITI_TAX)}' ,left=2580 ,top=114 ,right=2831 ,bottom=164 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(NPEN_AMT)}' ,left=2839 ,top=0 ,right=3135 ,bottom=50 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{SUM(HINU_AMT+OLD_AMT)}', left=2839, top=56, right=3135, bottom=106, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<S>id='{SUM(HINS_AMT)}' ,left=2839 ,top=114 ,right=3135 ,bottom=164 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{Sum(LAB_AMT)}', left=3159, top=119, right=3408, bottom=169, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<S>id='{Sum(DHLP_AMT)}' ,left=3159 ,top=169 ,right=3408 ,bottom=220 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT_21)}' ,left=3469 ,top=64 ,right=3709 ,bottom=114 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT_A3)}' ,left=3469 ,top=119 ,right=3709 ,bottom=167 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT_A4)}' ,left=3469 ,top=172 ,right=3709 ,bottom=220 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(DDTT_AMT)}' ,left=3752 ,top=114 ,right=3993 ,bottom=161 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<S>id='{SUM(PAY_AMT)}' ,left=3752 ,top=167 ,right=3993 ,bottom=209 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<L> left=24 ,top=222 ,right=4006 ,bottom=222 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=4003 ,top=222 ,right=26 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<S>id='{SUM(ETC_AMT_BA)}' ,left=2223 ,top=8 ,right=2537 ,bottom=64 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{SUM(PPED_AMT)}' ,left=3159 ,top=58 ,right=3408 ,bottom=108 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{SUM(LON_RPY+LON_INT)}', left=3159, top=3, right=3408, bottom=53, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{SUM(LON_RPY2+LON_INT2)}', left=3466, top=5, right=3707, bottom=56, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{Sum(ETC_AMT_A6)}', left=3749, top=64, right=3990, bottom=106, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{SUM(ETC_AMT_ETC)}', left=3749, top=8, right=3990, bottom=50, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<S>id='{Sum(ETC_AMT_A1)}' ,left=2588 ,top=167 ,right=2828 ,bottom=214 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT_A2)}' ,left=2844 ,top=167 ,right=3135 ,bottom=214 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>


</B>
<B>id=Footer ,left=0 ,top=2769 ,right=4101 ,bottom=2870 ,face='Tahoma' ,size=12 ,penwidth=1
	<T>id='#p/#t' ,left=773 ,top=3 ,right=3580 ,bottom=82</T>
</B>





">
</OBJECT>




</body>
</html>