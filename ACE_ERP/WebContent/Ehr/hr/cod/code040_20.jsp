<!--
***********************************************************************
* @source      : code040_20.jsp
* @description : 연봉계약서 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2018/01/02      이동훈        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>연봉계약서_20년</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
 <link href="../../common/css/style.css" rel="stylesheet" type="text/css">
 <link href="../../common/css/general.css" rel="stylesheet" type="text/css">

 <script language=javascript src="../../common/common.js"></script>
 <script language=javascript src="../../common/result.js"></script>
 <script language=javascript src="../../common/input.js"></script>
 <script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >
		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기


        var today = getToday();
        var dataClassName = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD";
        var params = null;
        var strPis_yy="2020";

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {


           dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code040.cmd.CODE040CMD&S_MODE=SHR&ENO_NO="+document.getElementById("txtENO_NO_SHR").value+"&PIS_YY="+strPis_yy;
           
           //prompt('',dsT_CM_PERSON.DataId);
           
           dsT_CM_PERSON.Reset();

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
        	
            if(!fnc_SaveItemCheck()) {
            	
            	return;
            
            }

            if(confirm("본인의 연봉을 확인하였으며, 이에 대해 비밀을 유지하겠습니다.")){
            	
	            document.getElementById("txtSIGN_NM").value =document.getElementById("txtENO_NM").value;

	            //패스워드변경, count초기화
	            trT_CM_PERSON.KeyValue = "tr01(I:dsT_CM_PERSON=dsT_CM_PERSON)";
	            
	            trT_CM_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code040.cmd.CODE040CMD&S_MODE=SAV&ENO_NO="+document.getElementById("txtENO_NO_SHR").value+"&PIS_YY="+strPis_yy+"&SIGN_NM="+document.getElementById("txtENO_NM").value+"&CON_YMD="+document.getElementById("gcemCON_YMD").text;
	            //prompt('',dsT_CM_PERSON.text);

	            trT_CM_PERSON.post();
	         }
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
        	
        	gcrp_print9.Preview();

        }

        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {

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


        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {

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
        	
			if(document.getElementById("txtSIGN_NM").value!=""){
				
			    alert("이미 서명을 하였습니다.");
			    
				return false;
				
			}

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분         *
         ********************************************/
        function fnc_OnLoadProcess() {

            //사번을 로그인한 사번으로 설정한 다음 기본정보를 가져온다.

           document.getElementById("txtENO_NO_SHR").value = gusrid;
           document.getElementById("txtENO_NM_SHR").value = gusrnm;


           if(gusrid != "6060002" && gusrid != "6180001" &&  gusrid != "2030007" && gusrid != "2070020"){ 

	         	fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	         	fnc_ChangeStateElement(false, "txtENO_NM_SHR");
	         	fnc_ChangeStateElement(false, "ImgEnoNo");

			  }

			document.getElementById("txtSIGN_NM").disabled = true;
			document.getElementById("txtSIGN_NM").className = "input_ReadOnly";           
			document.getElementById("txtSIGN_YMD").disabled = true;
			document.getElementById("txtSIGN_YMD").className = "input_ReadOnly";             
					
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
        //예외 항목들
        var oExceptionList = new Array(  );

        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
        	
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

        }
         /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */

        function fnc_GetNm() {
        	 
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','1','0');

        }

        function fnc_Getcd() {
        	
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');
        }


    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                    |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)           |
    | 3. 사용되는 Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
    </Object>

    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton               |
    | 2. 이름은 tr_ + 주요 테이블명(T_CM_PERSON)           |
    | 3. 사용되는 Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>

    <Object ID="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                  *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직      |
    +------------------------------------------------------>


    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

        } else {

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


    <!-----------------------------------------------------+
    | Transaction Successful 처리                          |
    +------------------------------------------------------>


    <script for=trT_CM_PERSON event="OnSuccess()">
    
       // fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("정상적으로 서명 처리 되었습니다.");
        
        fnc_SearchList();
        
    </script>


    <!-----------------------------------------------------+
    | Transaction Failure 처리                             |
    +------------------------------------------------------>

    <script for=trT_CM_PERSON event="OnFail()">
    
          cfErrorMsg(this);
          
    </script>


    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

    <!-- 파일 전송을 위해 -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

    <!-- 캘린더 프레임-->
    <div class="calendar" id="ifrmcal" style="DISPLAY:none">
        <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
    </div>

    <!-- form 시작 -->
    <form name="form1">


    <!-- 버튼 테이블 시작 -->
    <table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr class="blueTable">
            <td align="right" class="blueTable">사번&nbsp;</td>
            <td class="padding2423">
                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9"  maxlength= "8"   onkeypress="javascript:if(event.keyCode==13) {fnc_GetNm();fnc_SearchList();}" onchange="fnc_GetNm();fnc_SearchList();" style="ime-mode:disabled"   >
                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength= "14"  onkeypress="javascript:if(event.keyCode==13) {fnc_Getcd();fnc_SearchList();}" onchange="fnc_Getcd();fnc_SearchList();"  >
                <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup();fnc_SearchList();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                <input type="hidden" id="hidEMPL_DPT_CD">
            </td>

            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)">  <img src="../../images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

	<!-- 조건 입력 테이블 시작 -->
	<table width="1000" border="1" cellspacing="0" cellpadding="0">
        <tr>
          <td>
          <br>&nbsp;&nbsp;현대아산(주)(대표이사 사장 배국환)(이하“회사”라 함)와 근로자 <input id="txtENO_NM" name="txtENO_NM" size="6"  style="ime-mode:disabled">(이하“근로자”라 함)는 회사의 연봉제도에 동의하며 자유의사에 따라 다음과 같이 연봉계약을 체결한다. 
          <br>&nbsp;&nbsp;<strong>제1조【 연봉 적용기간 】</strong>
          <br>&nbsp;&nbsp;연봉에 대한 적용기간은  <input id="txtFROM_YMD" name="txtFROM_YMD" size="9"  style="ime-mode:disabled" >~ <input id="txtTO_YMD" name="txtTO_YMD" size="9"  style="ime-mode:disabled" >
          (<input id="txtMONTH" name="txtMONTH" size="2"  style="ime-mode:disabled">개월)로 한다.<br>

          <br>&nbsp;&nbsp;<strong>제2조【 연봉금액 】 </strong>
          	<table width="1000" border="1" cellspacing="0" cellpadding="0">
          		<tr style="text-align:center;" height ="10px">
          		    <td>구분</td>
          			<td width="150px">기본급</td>
          			<td width="150px">시간외수당</td>
          			<td width="150px">휴일근로수당</td>
          			<td width="150px">특수지수당</td>
          			<td width="150px">조정수당</td>
          			<td width="140px">계</td>
          		</tr>
          		<tr valign="middle">
          		    <td height ="5px" style="text-valign:center;text-align:center;">연봉</td>
          			<td valign=middle>
          			  <comment id="__NSID__">
          			  	<object id="gcemY01_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%" >
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemY02_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemY03_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td  style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemY04_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemY05_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td  style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemYSUM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          		</tr>
          		<tr valign="middle">
          		    <td  style="text-valign:center;text-align:center;">월급여</td>
          			<td valign=middle height ="10px">
          			  <comment id="__NSID__">
          			  	<object id="gcemP01_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%" >
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td  style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemP02_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemP03_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemP04_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemP05_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          			<td style="text-valign:center;" >
          			  <comment id="__NSID__">
          			  	<object id="gcemSUM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:0px;width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script></td>
          		</tr>
          	</table>

          <br>&nbsp;&nbsp;① 근로자의 연봉은 기본급, 시간외·휴일근로수당, 특수지수당 및 조정수당 등 각종 제 수당을 포함하여 산출하는 포괄임금산정제로 하며, 월 급여의 구성은 아래와 같다.
          <br>&nbsp;&nbsp;&nbsp;&nbsp;1. 기본급은 법정근로시간(209시간/月)에 대한 급여이다.
          <br>&nbsp;&nbsp;&nbsp;&nbsp;2. 시간외수당은 월 52시간의 연장·야간·휴일근로에 대한 급여이다.
          <br>&nbsp;&nbsp;&nbsp;&nbsp;3. 휴일근로수당은 월 18시간의 휴일근로에 대한 급여이다.
          <br>&nbsp;&nbsp;&nbsp;&nbsp;4. 특수지수당은 북측지역에 근무한 경우 발생할 수 있는 추가적 비용을 보전하기 위하여 지급하는 금품으로 평균급여의 포함에서 제외한다.
          <br>&nbsp;&nbsp;&nbsp;&nbsp;5. 조정수당은 급여체계 변동으로 발생할 수 있는 차액을 보전하기 위하여 지급 하는 한시적 수당이다.
          <br>&nbsp;&nbsp;② 상기에 포함되지 않은 기타수당(자격수당, 직책수당, 직무수당 등)은 회사가 정한 별도기준에 의하여 지급한다.
          <br>&nbsp;&nbsp;③ 본 조의 연봉금액은 제1조의 연봉 적용기간 중이라도 승진, 강격 등 신분상의 변동이나 인사평가, 징계, 근무지변동 등에 의해 연봉 조정사유가 있을 경우에는 
          <br>&nbsp;&nbsp;취업규칙 등 회사 인사규정에 따라 적용한다. <br>
          <br>&nbsp;&nbsp;<strong>제3조【 지급방법 】</strong>
          <br>&nbsp;&nbsp;① 당월 1일부터 말일까지를 급여산정기간으로 하며, 총 연봉의 12분의 1에 해당하는 금액을 매월 <input id="txtPAY_DAY" name="txtPAY_DAY" size="2"  style="ime-mode:disabled">일(지급당일이 휴일인 경우 그 전일)에 
          <br>&nbsp;&nbsp;근로자 본인 명의의 지정 계좌에 입금하는 방식으로 지급한다.
          <br>&nbsp;&nbsp;② 책정된 임금은 월 만근을 전제로 한 것이며, 근태성적에 따라 일할 공제할 수 있다.
          <br>&nbsp;&nbsp;③ 중도 입·퇴사자의 경우 해당 월의 근무일수에 따라 일할 계산하여 지급한다.   <br>
          <br>&nbsp;&nbsp;<strong>제4조【 비밀유지 】</strong>
          <br>&nbsp;&nbsp;근로자는 본인의 연봉에 관하여 타인에게 알리거나 타인의 연봉을 알려고 하지 않으며, 연봉과 관련한 제반사항에 대한 비밀을 절대로 누설하지 않는다. 
          <br>&nbsp;&nbsp;만약 연봉과 관련한 사항을 누설하는 경우 징계 사유가 될 수 있으며, 이로 인한 불이익에 이의를 제기하지 않는다.  <br>
          <br>&nbsp;&nbsp;<strong>제5조【 적   용 】 </strong>
          <br>&nbsp;&nbsp;① 근로자는 상기와 같이 책정된 연봉액에 동의하며, 상기에 명시되지 않은 내용은 회사가 정한 별도 기준에 따른다.
          <br>&nbsp;&nbsp;② 본 사항은 상기 연봉 적용기간에 한하여 적용되며, 기타 신분과 관련된 제반사항은 입사 시 체결한 근로계약서, 취업규칙 및 관련법령에 의한다.
          <br>&nbsp;&nbsp;③ 본 계약서는 기 체결한 근로계약서상의 임금관련 내용을 대체한다.   <br>
           </td>
          </tr>
          <tr>
          <td style="text-align:center;height:40px"><nobr>&nbsp;&nbsp;계약일자 : <comment id="__NSID__">
          			  	<object id="gcemCON_YMD" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="position:relative;top:10px;" >
							<param name=Alignment				value=0>
							<param name=Border					value=false>
							<param name=FORMAT					value="YYYY년MM월DD일">
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
						</object></comment><script> __ShowEmbedObject(__NSID__); </script><nobr>  <br></td>
          </tr>
          <tr>
          <td>
          <table width="1000" border="0" cellspacing="0" cellpadding="0">
          	<tr>
          		<td rowspan=3 style="text-align:center;" >(회  사) </td>
          		<td>주 &nbsp;&nbsp;&nbsp;소  :  <input id="txtCADDR" name="txtCADDR" size="30"  style="ime-mode:disabled">  </td>
          		<td rowspan=3 style="text-align:center;"> (근로자)  </td>
          		<td >소   속 : <input id="txtDPT_NM" name="txtDPT_NM" size="20"  style="ime-mode:disabled"> </td>
          		<td rowspan=3 >서  명  : <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_ConfirmOver.gif',1)">    <img src="../../images/button/btn_ConfirmOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a> </td>

          	</tr>
          	<tr>
          		<td>회 사 명 : 현대아산(주)</td>
          		<td>직   위 : <input id="txtJOB_NM" name="txtJOB_NM" size="20"  style="ime-mode:disabled"></td>
          	</tr>
          	<tr>
          		<td>대 표 자 : <input id="txtCADDR_CT" name="txtCADDR_CT" size="9"  style="ime-mode:disabled">      (인) </td>
          		<td>성   명 : <input id="txtSIGN_NM" name="txtSIGN_NM" size="6"  style="ime-mode:disabled"  class="input_ReadOnly" readonly>  (인)
          		    <input id="txtSIGN_YMD" name="txtSIGN_YMD" size="16"  style="ime-mode:disabled"  class="input_ReadOnly" readonly>
          		 </td>
          	</tr>
          </table>

         </td>

        </tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->

	</form>
    <!-- form 끝 -->





<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N
------------------------------------------------------------------------------>
<OBJECT id=gcrp_print9  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"			VALUE="dsT_CM_PERSON">
  	<PARAM NAME="DetailDataID"			VALUE="dsT_CM_PERSON">
	<PARAM NAME="PrintSetupDlgFlag" 	VALUE="true">
  	<PARAM NAME="Landscape"				VALUE="0">
	<PARAM NAME="PaperSize"				VALUE="A4">
	<PARAM NAME="FixPaperSize"			VALUE="TRUE">
	<param NAME="PrintMargine"      	VALUE="false">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="Format"            	VALUE="
	<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=2739 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='연봉계약서' ,left=69 ,top=79 ,right=1886 ,bottom=191 ,face='문체부 바탕체' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(인)' ,left=706 ,top=2569 ,right=778 ,bottom=2617 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=696 ,top=2495 ,right=870 ,bottom=2670</I>
	<T>id='(회  사)' ,left=79 ,top=2416 ,right=235 ,bottom=2453 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='회 사 명 :' ,left=246 ,top=2492 ,right=445 ,bottom=2529 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대 표 자 :' ,left=251 ,top=2569 ,right=450 ,bottom=2606 ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주    소 :  ' ,left=246 ,top=2416 ,right=445 ,bottom=2453 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CADDR', left=466, top=2416, right=955, bottom=2453, align='left', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='(근로자)' ,left=1021 ,top=2416 ,right=1177 ,bottom=2453 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소    속 :' ,left=1188 ,top=2416 ,right=1381 ,bottom=2453 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산(주)' ,left=466 ,top=2492 ,right=810 ,bottom=2529 ,align='left' ,face='바탕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직    위 :' ,left=1188 ,top=2492 ,right=1381 ,bottom=2529 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CADDR_CT', left=466, top=2569, right=656, bottom=2606, align='left', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='성    명 :' ,left=1188 ,top=2569 ,right=1381 ,bottom=2617 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DPT_NM', left=1389, top=2416, right=1757, bottom=2453, align='left', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='JOB_NM', left=1389, top=2495, right=1757, bottom=2532, align='left', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SIGN_NM', left=1392, top=2572, right=1759, bottom=2609, align='left', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='계약일자 : ' ,left=74 ,top=2302 ,right=913 ,bottom=2339 ,align='right' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CON_YMD', left=915, top=2302, right=1328, bottom=2339, align='left' ,mask='XXXX년XX월XX일', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='체결한 근로계약서, 취업규칙 및 관련법령에 의한다. ' ,left=122 ,top=2156 ,right=1889 ,bottom=2193 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기준에 따른다.' ,left=119 ,top=2066 ,right=1889 ,bottom=2103 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(지급당일이 휴일인 경우 그 전일)에 근로자 본인 명의의 지정 계좌에 입금하는 방식으로 지급한다.' ,left=106 ,top=1561 ,right=1902 ,bottom=1598 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='① 당월 1일부터 말일까지를 급여산정기간으로 하며, 총 연봉의 12분의 1에 해당하는 금액을 매월 25일' ,left=69 ,top=1516 ,right=1897 ,bottom=1553 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='따라 적용한다.' ,left=116 ,top=1400 ,right=1881 ,bottom=1437 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징계, 근무지변동 등에 의해 연봉 조정사유가 있을 경우에는 취업규칙 등 회사 인사규정에 ' ,left=116 ,top=1357 ,right=1881 ,bottom=1394 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수당이다.' ,left=138 ,top=1164 ,right=1876 ,bottom=1201 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금품으로 평균급여의 포함에서 제외한다. ' ,left=135 ,top=1080 ,right=1876 ,bottom=1117 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='포함하여 산출하는 포괄임금산정제로 하며, 월 급여의 구성은 아래와 같다. ' ,left=119 ,top=852 ,right=1884 ,bottom=889 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근로자는 본인의 연봉에 관하여 타인에게 알리거나 타인의 연봉을 알려고 하지 않으며, 연봉과 ' ,left=66 ,top=1786 ,right=1881 ,bottom=1823 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관련한 제반사항에 대한 비밀을 절대로 누설하지 않는다. 만약 연봉과 관련한 사항을 누설하는 경우 ' ,left=66 ,top=1831 ,right=1881 ,bottom=1868 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징계 사유가 될 수 있으며, 이로 인한 불이익에 이의를 제기하지 않는다. ' ,left=66 ,top=1876 ,right=1881 ,bottom=1913 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제3조【지급방법】' ,left=66 ,top=1466 ,right=1881 ,bottom=1503 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제5조【적   용】' ,left=71 ,top=1976 ,right=1886 ,bottom=2013 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='① 근로자는 상기와 같이 책정된 연봉액에 동의하며, 상기에 명시되지 않은 내용은 회사가 정한 별도 ' ,left=71 ,top=2019 ,right=1886 ,bottom=2056 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='② 본 사항은 상기 연봉 적용기간에 한하여 적용되며, 기타 신분과 관련된 제반사항은 입사 시 ' ,left=71 ,top=2111 ,right=1886 ,bottom=2148 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③ 본 계약서는 기 체결한 근로계약서상의 임금관련 내용을 대체한다. ' ,left=71 ,top=2199 ,right=1886 ,bottom=2236 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1. 기본급은 법정근로시간(209시간/月)에 대한 급여이다.' ,left=95 ,top=910 ,right=1879 ,bottom=947 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2. 시간외수당은 월 52시간의 연장·야간·휴일근로에 대한 급여이다.' ,left=95 ,top=953 ,right=1879 ,bottom=990 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3. 휴일근로수당은 월 18시간의 휴일근로에 대한 급여이다. ' ,left=95 ,top=995 ,right=1879 ,bottom=1032 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4. 특수지수당은 북측지역에 근무한 경우 발생할 수 있는 추가적 비용을 보전하기 위하여 지급하는 ' ,left=95 ,top=1037 ,right=1879 ,bottom=1074 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5. 조정수당은 급여체계 변동으로 발생할 수 있는 차액을 보전하기 위하여 지급하는 한시적 ' ,left=95 ,top=1122 ,right=1879 ,bottom=1159 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='② 책정된 임금은 월 만근을 전제로 한 것이며, 근태성적에 따라 일할 공제할 수 있다.' ,left=69 ,top=1606 ,right=1884 ,bottom=1643 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③ 중도 입·퇴사자의 경우 해당 월의 근무일수에 따라 일할 계산하여 지급한다. ' ,left=69 ,top=1651 ,right=1884 ,bottom=1688 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='② 상기에 포함되지 않은 기타수당(자격수당, 직책수당, 직무수당 등)은 회사가 정한 별도기준에 ' ,left=69 ,top=1220 ,right=1884 ,bottom=1257 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③ 본 조의 연봉금액은 제1조의 연봉 적용기간 중이라도 승진, 강격 등 신분상의 변동이나 인사평가,' ,left=69 ,top=1315 ,right=1884 ,bottom=1352 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제4조【비밀유지】' ,left=66 ,top=1741 ,right=1881 ,bottom=1778 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의하여 지급한다. ' ,left=119 ,top=1262 ,right=1879 ,bottom=1299 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='로 한다.' ,left=1392 ,top=452 ,right=1677 ,bottom=489 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='MONTH', left=1222, top=452, right=1389, bottom=489, align='left' ,mask='(XX개월)', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TO_YMD_1', left=886, top=452, right=1212, bottom=489, align='left' ,mask='XXXX년XX월XX일', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='~' ,left=852 ,top=452 ,right=878 ,bottom=489 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FROM_YMD_1', left=516, top=452, right=841, bottom=489, align='left' ,mask='XXXX년XX월XX일', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='연봉에 대한 적용기간은' ,left=69 ,top=452 ,right=508 ,bottom=489 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연봉제도에 동의하며 자유의사에 따라 다음과 같이 연봉계약을 체결한다.' ,left=66 ,top=323 ,right=1881 ,bottom=360 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제1조【연봉 적용기간】' ,left=66 ,top=407 ,right=1881 ,bottom=445 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제2조【연봉금액】' ,left=69 ,top=534 ,right=1884 ,bottom=572 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(이하 “근로자”라 함)는 회사의' ,left=1331 ,top=278 ,right=1881 ,bottom=315 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산(주) (대표이사 배국환) (이하 “회사”라 함)와 근로자 ' ,left=69 ,top=278 ,right=1138 ,bottom=315 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=1146, top=278, right=1323, bottom=315, align='left', face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=69 ,top=585 ,right=177 ,bottom=646 ,border=true</X>
	<X>left=175 ,top=585 ,right=460 ,bottom=646 ,border=true</X>
	<X>left=458 ,top=585 ,right=743 ,bottom=646 ,border=true</X>
	<X>left=741 ,top=585 ,right=1027 ,bottom=646 ,border=true</X>
	<X>left=1024 ,top=585 ,right=1310 ,bottom=646 ,border=true</X>
	<X>left=1307 ,top=585 ,right=1593 ,bottom=646 ,border=true</X>
	<X>left=1590 ,top=585 ,right=1876 ,bottom=646 ,border=true</X>
	<T>id='구분' ,left=74 ,top=590 ,right=172 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='① 근로자의 연봉은 기본급, 시간외·휴일근로수당, 특수지수당 및 조정수당 등 각종 제 수당을 ' ,left=69 ,top=807 ,right=1884 ,bottom=844 ,align='left' ,face='문체부 바탕체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본급' ,left=183 ,top=590 ,right=452 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외수당' ,left=466 ,top=590 ,right=736 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='휴일근로수당' ,left=749 ,top=590 ,right=1019 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특수지수당' ,left=1032 ,top=590 ,right=1302 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='조정수당' ,left=1315 ,top=590 ,right=1585 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1601 ,top=590 ,right=1871 ,bottom=643 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=69 ,top=643 ,right=177 ,bottom=704 ,border=true</X>
	<X>left=458 ,top=643 ,right=743 ,bottom=704 ,border=true</X>
	<X>left=741 ,top=643 ,right=1027 ,bottom=704 ,border=true</X>
	<X>left=1024 ,top=643 ,right=1310 ,bottom=704 ,border=true</X>
	<X>left=1307 ,top=643 ,right=1593 ,bottom=704 ,border=true</X>
	<X>left=1590 ,top=643 ,right=1876 ,bottom=704 ,border=true</X>
	<T>id='연봉' ,left=74 ,top=648 ,right=172 ,bottom=701 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=175 ,top=643 ,right=460 ,bottom=704 ,border=true</X>
	<C>id='Y01_AMT', left=183, top=651, right=455, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y02_AMT', left=463, top=651, right=736, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y03_AMT', left=746, top=651, right=1019, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y04_AMT', left=1029, top=651, right=1302, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y05_AMT', left=1312, top=651, right=1585, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YSUM_AMT', left=1598, top=651, right=1871, bottom=699, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<X>left=69 ,top=701 ,right=177 ,bottom=762 ,border=true</X>
	<X>left=458 ,top=701 ,right=743 ,bottom=762 ,border=true</X>
	<X>left=741 ,top=701 ,right=1027 ,bottom=762 ,border=true</X>
	<X>left=1024 ,top=701 ,right=1310 ,bottom=762 ,border=true</X>
	<X>left=1307 ,top=701 ,right=1593 ,bottom=762 ,border=true</X>
	<X>left=1590 ,top=701 ,right=1876 ,bottom=762 ,border=true</X>
	<T>id='월급여' ,left=74 ,top=706 ,right=172 ,bottom=759 ,face='문체부 바탕체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=175 ,top=701 ,right=460 ,bottom=762 ,border=true</X>
	<C>id='P01_AMT', left=183, top=709, right=455, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P02_AMT', left=463, top=709, right=736, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P03_AMT', left=746, top=709, right=1019, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P04_AMT', left=1029, top=709, right=1302, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P05_AMT', left=1312, top=709, right=1585, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SUM_AMT', left=1598, top=709, right=1871, bottom=757, align='right', face='바탕', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SIGN_YMD', left=1392, top=2635, right=1825, bottom=2672, align='left' , face='바탕', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>



   ">
</OBJECT>


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->

<object id="bndT_CM_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_PERSON">
    <Param Name="BindInfo", Value='

		 <C>Col=ENO_NM            Ctrl=txtENO_NM        Param=value   </C>
		 <C>Col=FROM_YMD          Ctrl=txtFROM_YMD      Param=value   </C>
		 <C>Col=TO_YMD            Ctrl=txtTO_YMD        Param=value   </C>
		 <C>Col=MONTH             Ctrl=txtMONTH         Param=value   </C>
		 <C>Col=P01_AMT           Ctrl=gcemP01_AMT      Param=text    </C>
		 <C>Col=P02_AMT           Ctrl=gcemP02_AMT      Param=text    </C>
		 <C>Col=P03_AMT           Ctrl=gcemP03_AMT      Param=text    </C>
		 <C>Col=P04_AMT           Ctrl=gcemP04_AMT      Param=text    </C>
		 <C>Col=P05_AMT           Ctrl=gcemP05_AMT      Param=text    </C>
		 <C>Col=SUM_AMT           Ctrl=gcemSUM_AMT      Param=text    </C>
		 <C>Col=Y01_AMT           Ctrl=gcemY01_AMT      Param=text    </C>
		 <C>Col=Y02_AMT           Ctrl=gcemY02_AMT      Param=text    </C>
		 <C>Col=Y03_AMT           Ctrl=gcemY03_AMT      Param=text    </C>
		 <C>Col=Y04_AMT           Ctrl=gcemY04_AMT      Param=text    </C>
		 <C>Col=Y05_AMT           Ctrl=gcemY05_AMT      Param=text    </C>
		 <C>Col=YSUM_AMT          Ctrl=gcemYSUM_AMT     Param=text    </C>
		 <C>Col=PAY_DAY           Ctrl=txtPAY_DAY       Param=value   </C>
		 <C>Col=CON_YMD           Ctrl=gcemCON_YMD      Param=text    </C>
		 <C>Col=CADDR             Ctrl=txtCADDR         Param=value   </C>
		 <C>Col=CADDR_CT          Ctrl=txtCADDR_CT      Param=value   </C>
		 <C>Col=SIGN_NM           Ctrl=txtSIGN_NM       Param=value   </C>
		 <C>Col=SIGN_YMD          Ctrl=txtSIGN_YMD      Param=value   </C>
		 <C>Col=DPT_NM            Ctrl=txtDPT_NM        Param=value   </C>
		 <C>Col=JOB_NM            Ctrl=txtJOB_NM        Param=value   </C>

    '>
</object>

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

