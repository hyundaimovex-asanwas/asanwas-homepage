<!--*************************************************************************
* @source      : pire050.jsp														*
* @description : 인사 현황 검색                      									*
* @source      : pire050.jsp														*
* @description : 인사 현황 검색													*
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION									*
*----------------------------------------------------------------------------
* 2011/06/30            이동훈            	최초작성                       				 *
* 2016/04/28            이동훈            	ERP 이사									 *
***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>인사 현황</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">


		var today = gcurdate;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {


			var ls_data = "";

            var CLAS_CD_SHR = document.getElementById("cmbCLAS_CD_SHR").value;

            var FIELD_CD_SHR = document.getElementById("cmbFIELD_CD_SHR").value;
            var FIELD2_CD_SHR = document.getElementById("cmbFIELD2_CD_SHR").value;
            var FIELD3_CD_SHR = document.getElementById("cmbFIELD3_CD_SHR").value;

            var SHAPE_CD_SHR = document.getElementById("cmbSHAPE_CD_SHR").value;
            var JOB_CD_SHR = document.getElementById("cmbJOB_CD_SHR").value;
            var SEX_CD_SHR = document.getElementById("cmbSEX_CD_SHR").value;
            var YEAR_CD_SHR = document.getElementById("cmbYEAR_CD_SHR").value;



            var HIR_YMD_SHR = document.getElementById("txtHIR_YMD_SHR").value;
            var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;

            var HIRG_YMD_SHR  = document.getElementById("txtHIRG_YMD_SHR").value;
            var ENDG_YMD_SHR = document.getElementById("txtENDG_YMD_SHR").value;

            var JPR_YMD_SHR  = document.getElementById("txtJPR_YMD_SHR").value;
            var ENDJ_YMD_SHR  = document.getElementById("txtENDJ_YMD_SHR").value;

            var RET_YMD_SHR  = document.getElementById("txtRET_YMD_SHR").value;
            var ENDR_YMD_SHR  = document.getElementById("txtENDR_YMD_SHR").value;



			if (document.form1.chkHIR_YMD_SHR.checked)
				ls_data += "&HIR_YMD_SHR=" + HIR_YMD_SHR + "&END_YMD_SHR="+END_YMD_SHR;
			else
				ls_data += "";

			if (document.form1.chkHIRG_YMD_SHR.checked)
				ls_data += "&HIRG_YMD_SHR=" + HIRG_YMD_SHR + "&ENDG_YMD_SHR="+ENDG_YMD_SHR;
			else
				ls_data += "";

			if (document.form1.chkJPR_YMD_SHR.checked)
				ls_data += "&JPR_YMD_SHR=" + JPR_YMD_SHR + "&ENDJ_YMD_SHR="+ENDJ_YMD_SHR;
			else
				ls_data += "";

			if (document.form1.chkRET_YMD_SHR.checked)
				ls_data += "&RET_YMD_SHR=" + RET_YMD_SHR + "&ENDR_YMD_SHR="+ENDR_YMD_SHR;
			else
				ls_data += "";


            dsT_CM_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.e.pire050.cmd.PIRE050CMD&S_MODE=SHR"
            						+"&CLAS_CD_SHR="+CLAS_CD_SHR
            						+"&FIELD_CD_SHR="+FIELD_CD_SHR
            						+"&FIELD2_CD_SHR="+FIELD2_CD_SHR
            						+"&FIELD3_CD_SHR="+FIELD3_CD_SHR
            						+"&SHAPE_CD_SHR="+SHAPE_CD_SHR
            						+"&JOB_CD_SHR="+JOB_CD_SHR
            						+"&SEX_CD_SHR="+SEX_CD_SHR
            						+"&YEAR_CD_SHR="+YEAR_CD_SHR
 			                        + ls_data;


            dsT_CM_PERSON.reset();


        }


		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 03. 저장 함수								*
         ********************************************/
        function fnc_Save() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {

        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_CM_PERSON.CountRow < 1 ) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CM_PERSON.GridToExcel("인사 현황", '', 225);

        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {

           	document.form1.cmbCLAS_CD_SHR.selectedIndex      = 0;
           	document.form1.cmbFIELD_CD_SHR.selectedIndex      = 0;
           	document.form1.cmbFIELD2_CD_SHR.selectedIndex      = 0;
           	document.form1.cmbFIELD3_CD_SHR.selectedIndex      = 0;
           	document.form1.cmbSHAPE_CD_SHR.selectedIndex      = 0;
           	document.form1.cmbJOB_CD_SHR.selectedIndex      = 0;
           	document.form1.cmbSEX_CD_SHR.selectedIndex      = 0;
           	document.form1.cmbYEAR_CD_SHR.selectedIndex      = 0;


        	document.getElementById("resultMessage").innerText = ' ';

            dsT_CM_PERSON.ClearData();


        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {

			if (dsT_CM_PERSON.IsUpdated)  {
				
				if (!fnc_ExitQuestion())  return;
				
			}
			
        	window.close();
        	
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {
  			//이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {


			document.getElementById('txtHIR_YMD_SHR').value = gcurdate.substring(0,8)+'01';
			document.getElementById('txtEND_YMD_SHR').value = gcurdate;

			document.getElementById('txtHIRG_YMD_SHR').value = gcurdate.substring(0,8)+'01';
			document.getElementById('txtENDG_YMD_SHR').value = gcurdate;

			document.getElementById('txtJPR_YMD_SHR').value = gcurdate.substring(0,8)+'01';
			document.getElementById('txtENDJ_YMD_SHR').value = gcurdate;

			document.getElementById('txtRET_YMD_SHR').value = gcurdate.substring(0,8)+'01';
			document.getElementById('txtENDR_YMD_SHR').value = gcurdate;

            //Grid Style 적용
            cfStyleGrid_New(form1.grdT_CM_PERSON,0,"false","true");



            //본부
            for( var i = 1; i <= dsCOMMON_DPT.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_DPT.NameValue(i,"DPT_CD");
                oOption.text  = dsCOMMON_DPT.NameValue(i,"DPT_NM");
                document.getElementById("cmbFIELD_CD_SHR").add(oOption);
            }

            //부서
            for( var i = 1; i <= dsCOMMON_DPT2.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_DPT2.NameValue(i,"DPT_CD");
                oOption.text  = dsCOMMON_DPT2.NameValue(i,"DPT_NM");
                document.getElementById("cmbFIELD2_CD_SHR").add(oOption);
            }

            //팀
            for( var i = 1; i <= dsCOMMON_DPT3.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_DPT3.NameValue(i,"DPT_CD");
                oOption.text  = dsCOMMON_DPT3.NameValue(i,"DPT_NM");
                document.getElementById("cmbFIELD3_CD_SHR").add(oOption);
            }



            //근로구분형태
            for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
                document.getElementById("cmbSHAPE_CD_SHR").add(oOption);
            }

            //직위형태
            for( var i = 1; i <= dsCOMMON_A2.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbJOB_CD_SHR").add(oOption);
            }

            //남녀구분
            for( var i = 1; i <= dsCOMMON_Z2.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Z2.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Z2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbSEX_CD_SHR").add(oOption);
            }

            //년차구분
            for( var i = 1; i <= dsCOMMON_A4.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_A4.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_A4.NameValue(i,"CODE_NAME");
                document.getElementById("cmbYEAR_CD_SHR").add(oOption);
            }

            fnc_SearchList();
            
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form이 Active 될 때 처리 할 일 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {

		}

		/********************************************
         * 날짜 형식 유효성 체크                           			*
         ********************************************/
        function fncCheckDate(obj) {
			
            if (obj.value == '') return;
            
            if(!cfDateExpr(obj.value)) {
            	
                alert('유효한 날짜가 아닙니다.');
                
                obj.focus();
                
            }
            
        }


    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)		   |
    | 3. 사용되는 Table List(T_CM_PERSON) 			   	   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>


    <!-- 공통 콤보를 위한 DataSet -->

    <!-- 본부 구분 -->
    <jsp:include page="../../common/gauceDataSet_DPT.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_DPT"/>
       <jsp:param name="CODE_GUBUN"    value="SHR_DPT"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 부서 구분 -->
    <jsp:include page="../../common/gauceDataSet_DPT.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_DPT2"/>
       <jsp:param name="CODE_GUBUN"    value="SHR_DPT2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 팀 구분 -->
    <jsp:include page="../../common/gauceDataSet_DPT.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_DPT3"/>
       <jsp:param name="CODE_GUBUN"    value="SHR_DPT3"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>
    
    <!-- 근로구분 구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 직위 구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="A2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 남녀 구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Z2"/>
       <jsp:param name="CODE_GUBUN"    value="Z2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 년차 구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A4"/>
       <jsp:param name="CODE_GUBUN"    value="A4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>



    <!------------------------------+
    | 그리드의 ROW를 더블클릭 할때  |
    +------------------------------->
	<script language=JavaScript for=grdT_CM_PERSON event="OnDblClick(row,colid)">
        if(row < 1) {
            return;
        } else {
            var url = "";
            var data = new String();

            data.eno_no     = dsT_CM_PERSON.NameValue(row, "ENO_NO");
            data.mode       = "read";
            url = "../../../Ehr/hr/pir/pirc010.jsp";

            window.showModalDialog(url, data, "dialogWidth:870px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
        }
	</script>


	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->
    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_PERSON                    |
    | 3. Table List : T_CM_PERSON                |
    +----------------------------------------------->
    <Object ID ="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>
	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_PERSON.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_CM_PERSON Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trT_CM_PERSON event="OnSuccess()">
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   					   |
    +------------------------------------------------------>
	<script for=trT_CM_PERSON event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- 캘린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">


<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','../../images/button/btn_ExcelOver.gif',1)">  <img src="../../images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->






<!-- power Search테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" class="blueTable">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr>
				<td class="searchState" align="right">재직구분</td>
                <td class="padding2423" align="left">
                    <select id=cmbCLAS_CD_SHR style="WIDTH:100" >
                        <option value="A">재직</option>
                        <option value="E">퇴직</option>
                        <option value="">전체</option>
                    </select>
                </td>
                <td align="right" class="searchState">본부</td>
                <td class="padding2423" align="left">
                    <select id=cmbFIELD_CD_SHR style="WIDTH:100" >
                        <option value="">전체</option>
                    </select>
                </td>

				<td class="searchState" align="right">입사일자</td>
				<td class="padding2423" align="left" >
					<input type="text" id="txtHIR_YMD_SHR" name="txtHIR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgHIR_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgHIR_YMD_SHR" name="imgHIR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtHIR_YMD_SHR','','134','108');"></a>
				    -
					<input type="text" id="txtEND_YMD_SHR" name="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgEND_YMD_SHR" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD_SHR','','134','108');"></a>
                    <input type="checkbox" id="chkHIR_YMD_SHR" style="border:none">선택
				</td>
            </tr>

            <tr>
                <td align="right" class="searchState">팀</td>
                <td class="padding2423" align="left">
                    <select id=cmbFIELD2_CD_SHR style="WIDTH:100" >
                        <option value="">전체</option>
                    </select>
                </td>
                <td align="right" class="searchState">현장/파트</td>
                <td class="padding2423" align="left">
                    <select id=cmbFIELD3_CD_SHR style="WIDTH:100" >
                        <option value="">전체</option>
                    </select>
                </td>
                <td class="searchState" align="right">그룹입사일자</td>
				<td class="padding2423" align="left" >
					<input type="text" id="txtHIRG_YMD_SHR" name="txtHIRG_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgHIRG_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgHIRG_YMD_SHR" name="imgSTR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtHIRG_YMD_SHR','','134','108');"></a>
				    -
					<input type="text" id="txtENDG_YMD_SHR" name="txtENDG_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENDG_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgENDG_YMD_SHR" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtENDG_YMD_SHR','','134','108');"></a>
                    <input type="checkbox" id="chkHIRG_YMD_SHR" style="border:none">선택
				</td>
            </tr>

            <tr>
                <td align="right" class="searchState">근로구분</td>
                <td class="padding2423" align="left">
                    <select id=cmbSHAPE_CD_SHR style="WIDTH:100" >
                        <option value="">전체</option>
                    </select>
                </td>
                <td align="right" class="searchState">직위</td>
                <td class="padding2423" align="left">
                    <select id=cmbJOB_CD_SHR style="WIDTH:100" >
                        <option value="">전체</option>
                    </select>
                </td>
				<td class="searchState" align="right">승진일자</td>
				<td class="padding2423" align="left" >
					<input type="text" id="txtJPR_YMD_SHR" name="txtJPR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgJPR_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgJPR_YMD_SHR" name="imgJPR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtJPR_YMD_SHR','','134','108');"></a>
				    -
					<input type="text" id="txtENDJ_YMD_SHR" name="txtENDJ_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENDJ_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgENDJ_YMD_SHR" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtENDJ_YMD_SHR','','134','108');"></a>
                    <input type="checkbox" id="chkJPR_YMD_SHR" style="border:none">선택
				</td>
            </tr>


            <tr>
				<td class="searchState" align="right">성별</td>
                <td class="padding2423" align="left">
                    <select id=cmbSEX_CD_SHR style="WIDTH:100" >
                        <option value="">전체</option>
                    </select>
                </td>



                <td align="right" class="searchState">년차</td>
                <td class="padding2423" align="left">
                    <select id=cmbYEAR_CD_SHR style="WIDTH:100" >
                        <option value="">전체</option>
                    </select>
                </td>
				<td class="searchState" align="right">퇴사일자</td>
				<td class="padding2423" align="left" >
					<input type="text" id="txtRET_YMD_SHR" name="txtRET_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRET_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgRET_YMD_SHR" name="imgRET_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtRET_YMD_SHR','','134','108');"></a>
				    -
					<input type="text" id="txtENDR_YMD_SHR" name="txtENDR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENDR_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgENDR_YMD_SHR" name="imgENDR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtENDR_YMD_SHR','','134','108');"></a>
                    <input type="checkbox" id="chkRET_YMD_SHR" style="border:none">선택
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
                            <param name="DataID"                  		value="dsT_CM_PERSON">
                            <param name="EdiTABLE"                		value="false">
                            <param name="DragDropEnable"          	value="true">
                            <param name="SortView"                		value="right">
                            <param name="VIEWSUMMARY"             	value=0>
                            <param name="Format"                  		value="
                                <FC> id='{currow}'      width='45'  name='No'       			align='center' </FC>
								<FC> id='ENO_NO'		width='60'	name='사번'					align='center' </FC>
								<FC> id='OCC_NM'		width='80'	name='근로\\구분'			align='center' </FC>
								<FC> id='JOB_NM'		width='80'	name='직위'					align='center' </FC>
								<FC> id='ENO_NM'		width='70'	name='성명\\(한글)'			align='center' </FC>
								<C> id='NAM_ENG'		width='120'	name='성명\\(영문)'			align='left' </C>
								<C> id='NAM_CHI'		width='70'	name='성명\\(한자)'			align='center' </C>
								<C> id='MF_TAG'			width='60'	name='남녀'					align='center' value={if(MF_TAG='M','남자',IF(MF_TAG='F','여자',''))}</C>
								<C> id='BIR_YMD'		width='80'	name='생년\\월일'			align='center' </C>
								<C> id='BIR_NM'			width='70'	name='음양\\구분'			align='center' value={if(BIR_NM='양','양력',IF(BIR_NM='음','음력',''))}</C>
								<C> id='CET_NO'			width='120'	name='주민번호'				align='center' </C>
								<C> id='REG_NM'			width='80'	name='지역구분'				align='center' </C>
								<C> id='HEAD_NM'		width='100'	name='본부'					align='left' </C>
								<C> id='DPT_NM'			width='120'	name='팀'					align='left' </C>
								<C> id='TEAM_NM'		width='120'	name='파트/현장'			align='left' </C>
								<C> id='DPA_YMD'		width='80'	name='소속\\발령일'			align='center' </C>

								<C> id='JPR_YMD'		width='80'	name='승진일'				align='center' </C>
								<C> id='DUTY_NM'		width='80'	name='직책'					align='center' </C>
								<C> id='JIKMU_NM'		width='80'	name='직무'					align='center' </C>

								<C> id='FINJ_NM'		width='80'	name='재직구분'				align='center' </C>
								<C> id='HOB_NM'			width='100'	name='년차'					align='center' Value={Decode(HOB_NM, 0, '',HOB_NM)}</C>
								<C> id='HIR_NM'			width='80'	name='채용\\구분'			align='center' </C>
								<C> id='HIR_YMD'		width='80'	name='입사일'				align='center' </C>
								<C> id='HIRG_YMD'		width='80'	name='그룹\\입사일'			align='center' </C>
								<C> id='RETP_YMD'		width='80'	name='계약\\만료일'			align='center' </C>								
								<C> id='PER_ADR'		width='280'	name='본적'					align='left' </C>
								<C> id='ZIP_NO'			width='120'	name='우편번호\\(등본)'		align='left' mask='XXX-XXX'</C>
								<C> id='ADR_CT'			width='220'	name='주소1\\(등본)'		align='left' </C>
								<C> id='ADDRESS'	 	width='220'	name='주소2\\(등본)'		align='left' </C>
								<C> id='RZI_NO'			width='120'	name='우편번호\\(실거주)'	align='left' mask='XXX-XXX'</C>
								<C> id='RADR_CT'		width='220'	name='주소1\\(실거주)'		align='left' </C>
								<C> id='RADR'			width='220'	name='주소2\\(실거주)'		align='left' </C>
								<C> id='PHN_REG'		width='80'	name='지역번호'				align='center' show = 'false'</C>
								<C> id='PHN_NO'			width='100'	name='전화번호'				align='center' </C>
								<C> id='EM_PHN_NO'		width='100'	name='휴대폰'				align='center' </C>
								<C> id='HOBBY'			width='80'	name='취미'					align='center' </C>
								<C> id='SPEC_CD'		width='80'	name='특기'					align='center' </C>
								<C> id='WED_YMD'		width='80'	name='결혼\\기념일'			align='center' </C>
								<C> id='REL_NM'			width='80'	name='종교\\구분'			align='center' </C>
								<C> id='EDGR_NM'		width='80'	name='학력\\구분'			align='center' </C>
								<C> id='SCH_NM'			width='120'	name='학교'					align='left' </C>
								<C> id='MAJ_NM'			width='120'	name='전공'					align='left' </C>
								<C> id='GRD_NM'			width='80'	name='졸업\\구분'			align='center' </C>
								<C> id='GUR_YMD'		width='80'	name='졸업\\일자'			align='center' </C>
								<C> id='RET_YMD'		width='80'	name='퇴직\\일자'			align='center' </C>
								<C> id='RET_CD'			width='80'	name='퇴직\\사유'			align='center' show = 'false'</C>
								<C> id='MRE_AMT'		width='80'	name='중도 정산'			align='center' show = 'false'</C>
								<C> id='LSE_YY'			width='80'	name='근속년수'				align='center' </C>
								<C> id='HOL_YY'			width='80'	name='년차일수'				align='center' show = 'false'</C>
								<C> id='NPN_GRD'		width='80'	name='국민연금 등급'		align='center' show = 'false'</C>
								<C> id='ABA_NM'			width='80'	name='송금은행'				align='center' </C>
								<C> id='ACC_NO'			width='120'	name='송금계좌번호'			align='center' </C>
								<C> id='E_MAIL'			width='120'	name='E-Mail'				align='center' </C>
								<C> id='TAX_DPTNM'		width='200'	name='회계소속'				align='left' </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 테이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
