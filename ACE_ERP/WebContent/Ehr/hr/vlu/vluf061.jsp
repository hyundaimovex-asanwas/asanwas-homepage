<!--
*****************************************************
* @source       : vluf061.jsp
* @description : HRMS PAGE :: 직무기술서_등록
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/10/24     오대성        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.JSPUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>

<% String title = request.getParameter("TITLE"); %>

<head>
<title><%=title%>(vluf061)</title>
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

		var btnList = 'FFTFFFFT';
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

			if(!fnc_SaveItemCheck()) return;	//유효성 체크

			dsT_EV_DUTYSUB.ClearData();
			var temp = dsT_EV_DUTYSUB.dataid;	// importdata를 한 후 DataSet의 기존의 dataid 속성값이 지워지는 것을 방지.
			//dsT_EV_DUTYSUB_01부터 dsT_EV_DUTYSUB_07까지의 데이터셋 중 데이터가 있는 데이터 셋을 전부 dsT_EV_DUTYSUB 에 담는다.
			for(i=1;i<8;i++) {
				if(eval("dsT_EV_DUTYSUB_0"+i+".CountRow")>0) {
					eval("dsT_EV_DUTYSUB.ImportData(dsT_EV_DUTYSUB_0"+i+".ExportData(1, dsT_EV_DUTYSUB_0"+i+".CountRow, true));");
				}
			}//end for
			dsT_EV_DUTYSUB.dataid = temp;

			trT_EV_DUTYSUB.KeyValue = "tr01(I:dsT_EV_DUTYSUB=dsT_EV_DUTYSUB, I:dsT_EV_DUTYDESC=dsT_EV_DUTYDESC)";
			trT_EV_DUTYSUB.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf061.cmd.VLUF061CMD&S_MODE=SAV&DUTY_NO="+document.getElementById('cmbDUTY_NO').value+"&DUTY_CD="+document.getElementById('txtDUTY_CD').value;
			trT_EV_DUTYSUB.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete(gubun) {

			if(gubun == '1'){
				if(dsT_EV_DUTYSUB_01.CountRow < 1) {
					alert("삭제할 데이터가 존재하지 않습니다.");
					return;
				}
				if(confirm("직무내용["+dsT_EV_DUTYSUB_01.NameValue(dsT_EV_DUTYSUB_01.RowPosition,'SEQ_NO')+"]의 데이터를 삭제하시겠습니까?")){
					dsT_EV_DUTYSUB_01.DeleteRow(dsT_EV_DUTYSUB_01.RowPosition);
				}
			} else if(gubun == '2'){
				if(dsT_EV_DUTYSUB_02.CountRow < 1) {
					alert("삭제할 데이터가 존재하지 않습니다.");
					return;
				}
				if(confirm("요구전공["+dsT_EV_DUTYSUB_02.NameValue(dsT_EV_DUTYSUB_02.RowPosition,'SEQ_NO')+"]의 데이터를 삭제하시겠습니까?")){
					dsT_EV_DUTYSUB_02.DeleteRow(dsT_EV_DUTYSUB_02.RowPosition);
				}
			} else if(gubun == '3'){
				if(dsT_EV_DUTYSUB_03.CountRow < 1) {
					alert("삭제할 데이터가 존재하지 않습니다.");
					return;
				}
				if(confirm("요구경력["+dsT_EV_DUTYSUB_03.NameValue(dsT_EV_DUTYSUB_03.RowPosition,'SEQ_NO')+"]의 데이터를 삭제하시겠습니까?")){
					dsT_EV_DUTYSUB_03.DeleteRow(dsT_EV_DUTYSUB_03.RowPosition);
				}
			} else if(gubun == '4'){
				if(dsT_EV_DUTYSUB_04.CountRow < 1) {
					alert("삭제할 데이터가 존재하지 않습니다.");
					return;
				}
				if(confirm("요구지식["+dsT_EV_DUTYSUB_04.NameValue(dsT_EV_DUTYSUB_04.RowPosition,'SEQ_NO')+"]의 데이터를 삭제하시겠습니까?")){
					dsT_EV_DUTYSUB_04.DeleteRow(dsT_EV_DUTYSUB_04.RowPosition);
				}
			} else if(gubun == '5'){
				if(dsT_EV_DUTYSUB_05.CountRow < 1) {
					alert("삭제할 데이터가 존재하지 않습니다.");
					return;
				}
				if(confirm("요구기술["+dsT_EV_DUTYSUB_05.NameValue(dsT_EV_DUTYSUB_05.RowPosition,'SEQ_NO')+"]의 데이터를 삭제하시겠습니까?")){
					dsT_EV_DUTYSUB_05.DeleteRow(dsT_EV_DUTYSUB_05.RowPosition);
				}
			} else if(gubun == '6'){
				if(dsT_EV_DUTYSUB_06.CountRow < 1) {
					alert("삭제할 데이터가 존재하지 않습니다.");
					return;
				}
				if(confirm("필요교육과정["+dsT_EV_DUTYSUB_06.NameValue(dsT_EV_DUTYSUB_06.RowPosition,'SEQ_NO')+"]의 데이터를 삭제하시겠습니까?")){
					dsT_EV_DUTYSUB_06.DeleteRow(dsT_EV_DUTYSUB_06.RowPosition);
				}
			} else if(gubun == '7'){
				if(dsT_EV_DUTYSUB_07.CountRow < 1) {
					alert("삭제할 데이터가 존재하지 않습니다.");
					return;
				}
				if(confirm("자격증["+dsT_EV_DUTYSUB_07.NameValue(dsT_EV_DUTYSUB_07.RowPosition,'SEQ_NO')+"]의 데이터를 삭제하시겠습니까?")){
					dsT_EV_DUTYSUB_07.DeleteRow(dsT_EV_DUTYSUB_07.RowPosition);
				}
			}

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

			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew(gubun) {

			eval("dsT_EV_DUTYSUB_0"+gubun+".AddRow()");
			eval("dsT_EV_DUTYSUB_0"+gubun+".NameValue(dsT_EV_DUTYSUB_0"+gubun+".RowPosition,'CONTENTS_GBN')="+gubun);

			eval("document.form1.grdT_EV_DUTYSUB_0"+gubun+".SetColumn('ITEM_01');");

			if(gubun == '1'){
				document.form1.txtITEM_01.focus();
			}

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_EV_DUTYDESC.IsUpdated || dsT_EV_DUTYSUB_01.IsUpdated || dsT_EV_DUTYSUB_02.IsUpdated || dsT_EV_DUTYSUB_03.IsUpdated || dsT_EV_DUTYSUB_04.IsUpdated || dsT_EV_DUTYSUB_05.IsUpdated || dsT_EV_DUTYSUB_06.IsUpdated || dsT_EV_DUTYSUB_07.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			window.close();

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

			if('<%=title%>' != '직무기술서_등록') return false;

			var form = document.form1;

			if ( form.cmbDUTY_NO.value == "" ) {
				alert("조사회차는 필수 입력 항목입니다.");
				form.cmbDUTY_NO.focus();
				return false;
			}
			if ( form.txtDUTY_CD.value == "" ) {
				alert("직무는 필수 입력 항목입니다.");
				return false;
			}

			// 세부정보에 대한 유효성 검사
			if( dsT_EV_DUTYSUB_01.CountRow > 0 ) {
				for(i=1;i<dsT_EV_DUTYSUB_01.CountRow+1;i++){
					if(dsT_EV_DUTYSUB_01.NameValue(i,"ITEM_01") == "") {
						alert("["+i+"]의 '주요업무'는 필수 입력사항입니다.");
						return false;
					} else if (dsT_EV_DUTYSUB_01.NameValue(i,"ITEM_02") == "") {
						alert("["+i+"]의 '비중'은 필수 입력사항입니다.");
						return false;
					} else if (dsT_EV_DUTYSUB_01.NameValue(i,"ITEM_03") == "") {
						alert("["+i+"]의 '중요도'는 필수 입력사항입니다.");
						return false;
					} else if (dsT_EV_DUTYSUB_01.NameValue(i,"ITEM_04") == "") {
						alert("["+i+"]의 '세부과업'은 필수 입력사항입니다.");
						return false;
					}
				}
			}
			if( dsT_EV_DUTYSUB_02.CountRow > 0 ) {
				for(i=1;i<dsT_EV_DUTYSUB_02.CountRow+1;i++){
					if(dsT_EV_DUTYSUB_02.NameValue(i,"ITEM_01") == "") {
						alert("["+i+"]의 '요구전공'은 필수 입력사항입니다.");
						return false;
					}
				}
			}
			if( dsT_EV_DUTYSUB_03.CountRow > 0 ) {
				for(i=1;i<dsT_EV_DUTYSUB_03.CountRow+1;i++){
					if(dsT_EV_DUTYSUB_03.NameValue(i,"ITEM_01") == "") {
						alert("["+i+"]의 '요구경력'은 필수 입력사항입니다.");
						return false;
					} else if (dsT_EV_DUTYSUB_03.NameValue(i,"ITEM_02") == "") {
						alert("["+i+"]의 '경험년수'는 필수 입력사항입니다.");
						return false;
					}
				}
			}
			if( dsT_EV_DUTYSUB_04.CountRow > 0 ) {
				for(i=1;i<dsT_EV_DUTYSUB_04.CountRow+1;i++){
					if(dsT_EV_DUTYSUB_04.NameValue(i,"ITEM_01") == "") {
						alert("["+i+"]의 '요구지식'은 필수 입력사항입니다.");
						return false;
					} else if (dsT_EV_DUTYSUB_04.NameValue(i,"ITEM_02") == "") {
						alert("["+i+"]의 '수준'은 필수 입력사항입니다.");
						return false;
					}
				}
			}
			if( dsT_EV_DUTYSUB_05.CountRow > 0 ) {
				for(i=1;i<dsT_EV_DUTYSUB_05.CountRow+1;i++){
					if(dsT_EV_DUTYSUB_05.NameValue(i,"ITEM_01") == "") {
						alert("["+i+"]의 '요구기술'은 필수 입력사항입니다.");
						return false;
					} else if (dsT_EV_DUTYSUB_05.NameValue(i,"ITEM_02") == "") {
						alert("["+i+"]의 '수준'은 필수 입력사항입니다.");
						return false;
					}
				}
			}
			if( dsT_EV_DUTYSUB_06.CountRow > 0 ) {
				for(i=1;i<dsT_EV_DUTYSUB_06.CountRow+1;i++){
					if(dsT_EV_DUTYSUB_06.NameValue(i,"ITEM_01") == "") {
						alert("["+i+"]의 '교육과정명'은 필수 입력사항입니다.");
						return false;
					} else if (dsT_EV_DUTYSUB_06.NameValue(i,"ITEM_02") == "") {
						alert("["+i+"]의 '교육훈련기관'은 필수 입력사항입니다.");
						return false;
					} else if (dsT_EV_DUTYSUB_06.NameValue(i,"ITEM_03") == "") {
						alert("["+i+"]의 '소요시간'은 필수 입력사항입니다.");
						return false;
					}
				}
			}
			if( dsT_EV_DUTYSUB_07.CountRow > 0 ) {
				for(i=1;i<dsT_EV_DUTYSUB_07.CountRow+1;i++){
					if(dsT_EV_DUTYSUB_07.NameValue(i,"ITEM_01") == "") {
						alert("["+i+"]의 '자격증'은 필수 입력사항입니다.");
						return false;
					} else if (dsT_EV_DUTYSUB_07.NameValue(i,"ITEM_02") == "") {
						alert("["+i+"]의 '인증기관'은 필수 입력사항입니다.");
						return false;
					}
				}
			}
			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid(form1.grdT_EV_DUTYSUB_01,0,"false","false");     // Grid Style 적용
			cfStyleGrid(form1.grdT_EV_DUTYSUB_02,0,"true","false");      // Grid Style 적용
			cfStyleGrid(form1.grdT_EV_DUTYSUB_03,0,"true","false");      // Grid Style 적용
			cfStyleGrid(form1.grdT_EV_DUTYSUB_04,0,"true","false");      // Grid Style 적용
			cfStyleGrid(form1.grdT_EV_DUTYSUB_05,0,"true","false");      // Grid Style 적용
			cfStyleGrid(form1.grdT_EV_DUTYSUB_06,0,"true","false");      // Grid Style 적용
			cfStyleGrid(form1.grdT_EV_DUTYSUB_07,0,"true","false");      // Grid Style 적용

			var dsTemp = window.dialogArguments;

			if(dsTemp.CountRow>0){
				cfCopyDataSet(dsTemp, dsT_EV_DUTYDESC, "copyHeader=yes,rowFrom=1,rowCnt=1");
			} else {
				cfCopyDataSetHeader(dsTemp, dsT_EV_DUTYDESC);
				dsT_EV_DUTYDESC.AddRow();
			}

			//시작시 조사회차를 가져오기 위해 VLUF020CMD를 사용
			ds01T_EV_DUTYBAS.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf020.cmd.VLUF020CMD&S_MODE=SHR_01";
			ds01T_EV_DUTYBAS.Reset();

        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/*************************************************
         * 16. 직군, 직렬, 직무 및 직무코드 조회용 팝업  *
         ************************************************/
		function fnc_dutyPopup(ctrl_01, ctrl_02, ctrl_03, ctrl_04) {

			var obj = new String();

			window.showModalDialog("/common/popup/duty.jsp", obj, "dialogWidth:368px; dialogHeight:520px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(obj.duty_cd != ''){
				document.getElementById(ctrl_01).value = obj.thr_nm;
				document.getElementById(ctrl_02).value = obj.sec_nm;
				document.getElementById(ctrl_03).value = obj.duty_nm;
				document.getElementById(ctrl_04).value = obj.duty_cd;
			}

		}


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------+
    | 1. 조회 및 저장용 DataSet          |
    | 2. 이름 : dsT_EV_DUTYSUB           |
    | 3. Table List : T_EV_DUTYSUB       |
    +------------------------------------>
    <Object ID="dsT_EV_DUTYSUB" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------+
    | 1. 조회용 DataSet                  |
    | 2. 이름 : ds01T_EV_DUTYBAS         |
    | 3. Table List : T_EV_DUTYBAS       |
    +------------------------------------>
    <Object ID="ds01T_EV_DUTYBAS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!---------------------------------+
    | 1. 조회 및 저장용 DataSet        |
    | 2. 이름 : dsT_EV_DUTYSUB         |
    | 3. Table List : T_EV_DUTYSUB     |
    +---------------------------------->
    <Object ID="dsT_EV_DUTYSUB_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!---------------------------------+
    | 1. 조회 및 저장용 DataSet        |
    | 2. 이름 : dsT_EV_DUTYSUB         |
    | 3. Table List : T_EV_DUTYSUB     |
    +---------------------------------->
    <Object ID="dsT_EV_DUTYSUB_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------+
    | 1. 조회 및 저장용 DataSet          |
    | 2. 이름 : dsT_EV_DUTYSUB           |
    | 3. Table List : T_EV_DUTYSUB       |
    +------------------------------------>
    <Object ID="dsT_EV_DUTYSUB_03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------+
    | 1. 조회 및 저장용 DataSet          |
    | 2. 이름 : dsT_EV_DUTYSUB           |
    | 3. Table List : T_EV_DUTYSUB       |
    +------------------------------------>
    <Object ID="dsT_EV_DUTYSUB_04" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------+
    | 1. 조회 및 저장용 DataSet          |
    | 2. 이름 : dsT_EV_DUTYSUB           |
    | 3. Table List : T_EV_DUTYSUB       |
    +------------------------------------>
    <Object ID="dsT_EV_DUTYSUB_05" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!----------------------------------+
    | 1. 조회 및 저장용 DataSet         |
    | 2. 이름 : dsT_EV_DUTYSUB          |
    | 3. Table List : T_EV_DUTYSUB      |
    +----------------------------------->
    <Object ID="dsT_EV_DUTYSUB_06" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!----------------------------------+
    | 1. 조회 및 저장용 DataSet         |
    | 2. 이름 : dsT_EV_DUTYSUB          |
    | 3. Table List : T_EV_DUTYSUB      |
    +----------------------------------->
    <Object ID="dsT_EV_DUTYSUB_07" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!----------------------------------------------------+
    | 1. 저장용 DataSet							          |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_DUTYRSH)	      |
    | 3. 사용되는 Table List(T_EV_DUTYRSH, T_CM_DUTYMST)  |
    +----------------------------------------------------->
    <Object ID="dsT_EV_DUTYDESC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton          |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_GRDRATE)     |
    | 3. 사용되는 Table List(T_EV_GRDRATE)            |
    +------------------------------------------------->
    <Object ID ="trT_EV_DUTYSUB" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_ABLRST)">
    </Object>


	<!--*******************************************
    *                                             *
    *  Component에서 발생하는 Event 처리부        *
    *                                             *
    ********************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_DUTYSUB Event="OnLoadCompleted(iCount)">
        if (iCount < 1) {
			// dsT_EV_DUTYSUB_01부터 dsT_EV_DUTYSUB_07까지의 DataSet의 헤더를 설정한다.
			var header = "GUBUN:STRING, DUTY_NO:INT, ENO_NO:STRING, DUTY_CD:STRING, RESEARCH_GBN:STRING, CONTENTS_GBN:STRING:KEYVALUETYPE, SEQ_NO:INT:KEYVALUETYPE, ITEM_01:STRING:NOTNULL, ITEM_02:STRING, ITEM_03:STRING, ITEM_04:STRING, ITEM_05:STRING";

			for(k=1;k<8;k++) {
				eval("dsT_EV_DUTYSUB_0"+k+".setDataHeader(header);");
			}

        } else {

			//dsT_EV_DUTYSUB에서 SEQ_NO별로 시작위치와 갯수를 구한다.
			for(j=1;j<8;j++) {
				//DataSet Copy를 위한 동적 변수 생성
				eval("rowFrom"+j+"= 0");
				eval("rowCnt"+j+"= 0");
				for(i=1;i<iCount+1;i++) {
					if(dsT_EV_DUTYSUB.NameValue(i,'CONTENTS_GBN') == j) {
						if(eval("rowFrom"+j) == 0) eval("rowFrom"+j+"="+i);
						eval("rowCnt"+j+"++");
					}
				}
			}
			// SEQ_NO별로 각각의 데이터셋에 해당하는 데이터를 복사한다.
			cfCopyDataSet(dsT_EV_DUTYSUB, dsT_EV_DUTYSUB_01, "copyHeader=yes,rowFrom="+rowFrom1+",rowCnt="+rowCnt1);
			cfCopyDataSet(dsT_EV_DUTYSUB, dsT_EV_DUTYSUB_02, "copyHeader=yes,rowFrom="+rowFrom2+",rowCnt="+rowCnt2);
			cfCopyDataSet(dsT_EV_DUTYSUB, dsT_EV_DUTYSUB_03, "copyHeader=yes,rowFrom="+rowFrom3+",rowCnt="+rowCnt3);
			cfCopyDataSet(dsT_EV_DUTYSUB, dsT_EV_DUTYSUB_04, "copyHeader=yes,rowFrom="+rowFrom4+",rowCnt="+rowCnt4);
			cfCopyDataSet(dsT_EV_DUTYSUB, dsT_EV_DUTYSUB_05, "copyHeader=yes,rowFrom="+rowFrom5+",rowCnt="+rowCnt5);
			cfCopyDataSet(dsT_EV_DUTYSUB, dsT_EV_DUTYSUB_06, "copyHeader=yes,rowFrom="+rowFrom6+",rowCnt="+rowCnt6);
			cfCopyDataSet(dsT_EV_DUTYSUB, dsT_EV_DUTYSUB_07, "copyHeader=yes,rowFrom="+rowFrom7+",rowCnt="+rowCnt7);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_DUTYSUB Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_DUTYSUB Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=ds01T_EV_DUTYBAS Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            alert("직무 기초 정보에 설정된 회차가 없습니다.");
        } else {
            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
			var i;
			var oOption;

			//검색단의 콤보박스에 조사회차를 생성
			for(i=1; i <= iCount; i++){
	        	oOption = document.createElement("OPTION");
				oOption.text = ds01T_EV_DUTYBAS.NameValue(i,"DUTY_NO")+"회차";
				oOption.value = ds01T_EV_DUTYBAS.NameValue(i,"DUTY_NO");
       			document.getElementById("cmbDUTY_NO").add(oOption);
        	}

			if(dsT_EV_DUTYDESC.NameValue(1,'DUTY_NO') != '') {

				//조사회차
//				document.getElementById("cmbDUTY_NO")[dsT_EV_DUTYDESC.NameValue(1,'DUTY_NO')-1].selected = true;
				for(i=1; i <= iCount; i++){
					if(dsT_EV_DUTYDESC.NameValue(1,'DUTY_NO') == ds01T_EV_DUTYBAS.NameValue(i,"DUTY_NO")){
						document.getElementById("cmbDUTY_NO")[i-1].selected = true;
					}
				}
				document.getElementById('cmbDUTY_NO').disabled = 'disabled';
				document.getElementById('cmbDUTY_NO').style.backgroundColor = 'EEEEEE';

				//직무 조사서 세부 Item 정보 조회
				dsT_EV_DUTYSUB.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf061.cmd.VLUF061CMD&S_MODE=SHR&DUTY_NO="+dsT_EV_DUTYDESC.NameValue(1,'DUTY_NO')+"&DUTY_CD="+dsT_EV_DUTYDESC.NameValue(1,'DUTY_CD');
				dsT_EV_DUTYSUB.reset();

			} else {

				//header 생성
				var header = "GUBUN:STRING, DUTY_NO:INT, ENO_NO:STRING, DUTY_CD:STRING, RESEARCH_GBN:STRING, CONTENTS_GBN:STRING:KEYVALUETYPE, SEQ_NO:INT:KEYVALUETYPE, ITEM_01:STRING:NOTNULL, ITEM_02:STRING, ITEM_03:STRING, ITEM_04:STRING, ITEM_05:STRING";

				dsT_EV_DUTYSUB.setDataHeader(header);
				for(k=1;k<8;k++) {
					eval("dsT_EV_DUTYSUB_0"+k+".setDataHeader(header);");
				}

				//직무 검색 버튼 디스플레이
				document.all["duty"].style.display = "";

				document.form1.cmbDUTY_NO.focus();

			}
        }

		var title = '<%=title%>';
		if(title != '직무기술서_등록'){
			document.getElementById('save_btn').style.display = 'none';
			document.getElementById('searchDay').style.display = 'none';
			document.getElementById('button1').style.display = 'none';
			document.getElementById('button2').innerHTML = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
			document.getElementById('button3').innerHTML = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
			document.getElementById('button4').innerHTML = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
			document.getElementById('button5').innerHTML = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
			document.getElementById('button6').innerHTML = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
			document.getElementById('button7').innerHTML = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';

			document.getElementById('txtDUTY_YMD').readOnly = true;
			document.getElementById('txtDUTY_YMD').className="input_ReadOnly";
			document.getElementById('txtDUTY_OBJ').readOnly = true;
			document.getElementById('txtDUTY_OBJ').className="input_ReadOnly";
			document.getElementById('txtITEM_01').readOnly = true;
			document.getElementById('txtITEM_01').className="input_ReadOnly";
			document.getElementById('txtITEM_02').readOnly = true;
			document.getElementById('txtITEM_02').className="input_ReadOnly";
			document.getElementById('cmbITEM_03').disabled = true;
			document.getElementById('cmbITEM_03').className="input_ReadOnly";
			document.getElementById('txtITEM_04').readOnly = true;
			document.getElementById('txtITEM_04').className="input_ReadOnly";
			document.getElementById('txtSCH_LBL').readOnly = true;
			document.getElementById('txtSCH_LBL').className="input_ReadOnly";

			document.form1.grdT_EV_DUTYSUB_02.Editable = 'false';
			document.form1.grdT_EV_DUTYSUB_03.Editable = 'false';
			document.form1.grdT_EV_DUTYSUB_04.Editable = 'false';
			document.form1.grdT_EV_DUTYSUB_05.Editable = 'false';
			document.form1.grdT_EV_DUTYSUB_06.Editable = 'false';
			document.form1.grdT_EV_DUTYSUB_07.Editable = 'false';
		}
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=ds01T_EV_DUTYBAS Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=ds01T_EV_DUTYBAS Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
	<Script For=dsT_EV_DUTYSUB_01 Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[주요업무/비중/중요도/세부과업] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("주요업무/비중/중요도/세부과업에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------------+
	| 해당 Row가 추가 또는 삽입되었을때  |
    +------------------------------------>
	<script language=JavaScript for=dsT_EV_DUTYSUB_01 event=OnRowInserted(row)>

		dsT_EV_DUTYSUB_01.NameValue(row,'SEQ_NO') = Number(dsT_EV_DUTYSUB_01.NameValue(row-1,'SEQ_NO')) + 1;

	</script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
	<Script For=dsT_EV_DUTYSUB_02 Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[요구전공] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("요구전공에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------------+
	| 해당 Row가 추가 또는 삽입되었을때  |
    +------------------------------------>
	<script language=JavaScript for=dsT_EV_DUTYSUB_02 event=OnRowInserted(row)>

		dsT_EV_DUTYSUB_02.NameValue(row,'SEQ_NO') = Number(dsT_EV_DUTYSUB_02.NameValue(row-1,'SEQ_NO')) + 1;

	</script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
	<Script For=dsT_EV_DUTYSUB_03 Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[요구경력/경험년수] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("요구경력/경험년수에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <!-----------------------------------+
	| 해당 Row가 추가 또는 삽입되었을때  |
    +------------------------------------>
	<script language=JavaScript for=dsT_EV_DUTYSUB_03 event=OnRowInserted(row)>

		dsT_EV_DUTYSUB_03.NameValue(row,'SEQ_NO') = Number(dsT_EV_DUTYSUB_03.NameValue(row-1,'SEQ_NO')) + 1;

	</script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
	<Script For=dsT_EV_DUTYSUB_04 Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[요구지식/수준] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("요구지식/수준에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------------+
	| 해당 Row가 추가 또는 삽입되었을때  |
    +------------------------------------>
	<script language=JavaScript for=dsT_EV_DUTYSUB_04 event=OnRowInserted(row)>

		dsT_EV_DUTYSUB_04.NameValue(row,'SEQ_NO') = Number(dsT_EV_DUTYSUB_04.NameValue(row-1,'SEQ_NO')) + 1;

	</script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
	<Script For=dsT_EV_DUTYSUB_05 Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[요구기술/수준] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("요구기술/수준에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------------+
	| 해당 Row가 추가 또는 삽입되었을때  |
    +------------------------------------>
	<script language=JavaScript for=dsT_EV_DUTYSUB_05 event=OnRowInserted(row)>

		dsT_EV_DUTYSUB_05.NameValue(row,'SEQ_NO') = Number(dsT_EV_DUTYSUB_05.NameValue(row-1,'SEQ_NO')) + 1;

	</script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
	<Script For=dsT_EV_DUTYSUB_06 Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[교육과정명/교육훈련기관/소요시간] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("교육과정명/교육훈련기관/소요시간에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <!-----------------------------------+
	| 해당 Row가 추가 또는 삽입되었을때  |
    +------------------------------------>
	<script language=JavaScript for=dsT_EV_DUTYSUB_06 event=OnRowInserted(row)>

		dsT_EV_DUTYSUB_06.NameValue(row,'SEQ_NO') = Number(dsT_EV_DUTYSUB_06.NameValue(row-1,'SEQ_NO')) + 1;

	</script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
	<Script For=dsT_EV_DUTYSUB_07 Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[자격증/인증기관] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("자격증/인증기관에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------------+
	| 해당 Row가 추가 또는 삽입되었을때  |
    +------------------------------------>
	<script language=JavaScript for=dsT_EV_DUTYSUB_07 event=OnRowInserted(row)>

		dsT_EV_DUTYSUB_07.NameValue(row,'SEQ_NO') = Number(dsT_EV_DUTYSUB_07.NameValue(row-1,'SEQ_NO')) + 1;

	</script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_DUTYSUB event="OnSuccess()">
		alert("저장하였습니다.");
		//저장 후에는 데이터셋의 상태를 초기화한다.
		dsT_EV_DUTYDESC.ResetStatus()
		dsT_EV_DUTYSUB_01.ResetStatus()
		dsT_EV_DUTYSUB_02.ResetStatus()
		dsT_EV_DUTYSUB_03.ResetStatus()
		dsT_EV_DUTYSUB_04.ResetStatus()
		dsT_EV_DUTYSUB_05.ResetStatus()
		dsT_EV_DUTYSUB_06.ResetStatus()
		dsT_EV_DUTYSUB_07.ResetStatus()
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_DUTYSUB event="OnFail()">
        cfErrorMsg(this);
    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">
<input type="hidden" name="tbl1_row_cnt" value="2">

<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle"><%=title%></td>
					<td align="right" class="navigator">HOME/인사평가/직무관리/직무조사/직무기술서/<font color="#000000"><%=title%></font></td>
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
			<span id="save_btn">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			</span>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="120"></col>
                                <col width="90"></col>
                                <col width="120"></col>
                                <col width="90"></col>
                                <col width="120"></col>
                                <col width="40"></col>
                                <col width=""></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">조사회차&nbsp;</td>
                                <td class="padding2423">
									<select id="cmbDUTY_NO" name="cmbDUTY_NO" style="WIDTH: 65%">
									</select>
								</td>
                                <td align="right" class="searchState">작성일&nbsp;</td>
                                <td class="padding2423">
									<input id=txtDUTY_YMD name=txtDUTY_YMD size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
									<span id="searchDay">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image3" width="21" height="20" border="0" align="absmiddle" onClick="calendarBtn('datetype1','txtDUTY_YMD','','300','120');"></a>
									</span>
                                </td>
                                <td align="right" class="searchState"></td>
                                <td class="padding2423"></td>
								<td></td>
								<td></td>
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
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>직무정의(Job Identification)</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="90"></col>
					<col width="110"></col>
					<col width="90"></col>
					<col width="110"></col>
					<col width="90"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">직&nbsp;&nbsp;&nbsp;&nbsp;군</td>
					<td class="padding2423">
						<input id=txtTHR_NM name=txtTHR_NM style="width:100%" class="input_ReadOnly" readOnly>
					</td>
					<td align="center" class="creamBold">직&nbsp;&nbsp;&nbsp;&nbsp;렬</td>
					<td class="padding2423">
						<input id=txtSEC_NM name=txtSEC_NM style="width:100%" class="input_ReadOnly" readOnly>
					</td>
					<td align="center" class="creamBold">직&nbsp;&nbsp;&nbsp;&nbsp;무</td>
					<td class="padding2423">
						<input id=txtDUTY_NM name=txtDUTY_NM size="25" class="input_ReadOnly" readOnly>
						<input id=txtDUTY_CD name=txtDUTY_CD size="10" class="input_ReadOnly" readOnly style="TEXT-ALIGN:center">
						<span id="duty" style="display:none;">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onClick="fnc_dutyPopup('txtTHR_NM','txtSEC_NM','txtDUTY_NM','txtDUTY_CD')"></a>
						</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>직무목적(Job Objectives)</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="100"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">직무목적</td>
					<td class="padding2423">
	                    <textarea id=txtDUTY_OBJ name=txtDUTY_OBJ rows="3" cols="115" onkeyup="fc_chk_byte(this,800);"></textarea>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="50"></td>
		<td width="650"></td>
		<td width="100"></td>
	</tr>
    <tr>
        <td colspan="2" class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>직무내용(Main Tasks and Responsibilities)</strong>
		</td>
        <td align="right">
		<span id="button1">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="Image11" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew('1');return false;"></a>&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="Image12" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete('1');return false;"></a>
		</td>
    </tr>
	<tr>
		<td align="left" class="padding2423">
			<comment id="__NSID__">
			<object id="grdT_EV_DUTYSUB_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:60px;height:100px;">
				<param name="DataID"            value="dsT_EV_DUTYSUB_01">
                <param name="LineColor"         value="Silver">
                <param name="IndWidth"          value="0">
                <param Name="Editable"          value="false">
                <param name="Format"            value='
					<C> id=SEQ_NO	   width=40   name=순번			align=center  </C>
					<C> id=ITEM_01     width=224  name=주요업무		align=left  Show=false  </C>
					<C> id=ITEM_02     width=88   name=비중			align=center  Show=false  </C>
					<C> id=ITEM_03     width=88   name=중요도		align=center  Show=false  </C>
					<C> id=ITEM_04     width=370  name=세부과업		align=left  Show=false  </C>
                '>
             </object>
             </comment><script> __ShowEmbedObject(__NSID__); </script>
		</td>
		<td colspan="2">
			<table id=tbl1 width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="220"></col>
					<col width="40"></col>
					<col width="40"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">주요업무</td>
					<td align="center" class="creamBold">비중</td>
					<td align="center" class="creamBold">중요도</td>
					<td align="center" class="creamBold">세부과업</td>
				</tr>
				<tr>
					<td align="center" class="padding2423">
						<input id="txtITEM_01" name="txtITEM_01" style="width:100%" ><br><br><br><br>
					</td>
					<td align="center" class="padding2423">
						<input id="txtITEM_02" name="txtITEM_02" style="width:100%" ><br><br><br><br>
					</td>
					<td align="center" class="padding2423">
						<select id="cmbITEM_03" name="cmbITEM_03" style="width:100%">
							<option value="상" >상</option>
							<option value="중" >중</option>
							<option value="하" >하</option>
						</select><br><br><br><br>
					</td>
					<td align="center" class="padding2423">
	                    <textarea id="txtITEM_04" name="txtITEM_04" rows="4" cols="61" onkeyup="fc_chk_byte(this,500);"></textarea>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>직무요건</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="150"></col>
					<col width="250"></col>
					<col width="150"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">요구학력수준</td>
					<td class="padding2423" colspan="3">
						<input id=txtSCH_LBL name=txtSCH_LBL style="width:200">
					</td>
				</tr>
				<tr>
					<!-- <td align="center" class="creamBold">요구전공 -->
					<td align="right" class="creamBold" colspan="2">요구전공&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="button2">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="Image13" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew('2');return false;"></a>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="Image14" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete('2');return false;"></a>
					</span>
					</td>
					<td align="right" class="creamBold" colspan="2">요구경력
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="button3">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image15','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="Image15" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew('3');return false;"></a>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image16','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="Image16" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete('3');return false;"></a>
					</span>
					</td>
				</tr>
				<tr>
					<td align="center" class="padding2423" colspan="2">
						<comment id="__NSID__">
                        <object    id="grdT_EV_DUTYSUB_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:390px;height:140px;">
                            <param name="DataID"            value="dsT_EV_DUTYSUB_02">
                            <param name="LineColor"         value="Silver">
                            <param name="IndWidth"          value="0">
                            <param Name="Editable"          value="true">
                            <param name="Format"            value='
                                <C> id=ITEM_01     width=370   name=요구전공  align=left  </C>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="padding2423" colspan="2">
						<comment id="__NSID__">
                        <object    id="grdT_EV_DUTYSUB_03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:390px;height:140px;">
                            <param name="DataID"            value="dsT_EV_DUTYSUB_03">
                            <param name="LineColor"         value="Silver">
                            <param name="IndWidth"          value="0">
                            <param Name="Editable"          value="true">
                            <param name="Format"            value='
                                <C> id=ITEM_01     width=270   name=요구경력  align=left  </C>
                                <C> id=ITEM_02     width=100   name=경험년수  align=center  </C>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
				<tr>
					<td align="right" class="creamBold" colspan="2">요구지식&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="button4">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image17','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="Image17" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew('4');return false;"></a>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image18','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="Image18" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete('4');return false;"></a>
					</span>
					</td>
					<td align="right" class="creamBold" colspan="2">요구기술&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="button5">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image19','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="Image19" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew('5');return false;"></a>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="Image20" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete('5');return false;"></a>
					</span>
					</td>
				</tr>
				<tr>
					<td align="center" class="padding2423" colspan="2">
						<comment id="__NSID__">
                        <object    id="grdT_EV_DUTYSUB_04" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:390px;height:140px;">
                            <param name="DataID"            value="dsT_EV_DUTYSUB_04">
                            <param name="LineColor"         value="Silver">
                            <param name="IndWidth"          value="0">
                            <param Name="Editable"          value="true">
                            <param name="Format"            value='
                                <C> id=ITEM_01     width=270   name=요구지식  align=left  </C>
                                <C> id=ITEM_02     width=100   name=수준	  align=center  </C>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="padding2423" colspan="2">
						<comment id="__NSID__">
                        <object    id="grdT_EV_DUTYSUB_05" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:390px;height:140px;">
                            <param name="DataID"            value="dsT_EV_DUTYSUB_05">
                            <param name="LineColor"         value="Silver">
                            <param name="IndWidth"          value="0">
                            <param Name="Editable"          value="true">
                            <param name="Format"            value='
                                <C> id=ITEM_01     width=270   name=요구기술  align=left  </C>
                                <C> id=ITEM_02     width=100   name=수준	  align=center  </C>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
				<tr>
					<td align="right" class="creamBold" colspan="2">필요교육과정&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="button6">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="Image21" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew('6');return false;"></a>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image22','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="Image22" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete('6');return false;"></a>
					</span>
					</td>
					<td align="right" class="creamBold" colspan="2">자격증&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="button7">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image23','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="Image23" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew('7');return false;"></a>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image24','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="Image24" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete('7');return false;"></a>
					</span>
					</td>
				</tr>
				<tr>
					<td align="center" class="padding2423" colspan="2">
						<comment id="__NSID__">
                        <object    id="grdT_EV_DUTYSUB_06" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:390px;height:140px;">
                            <param name="DataID"            value="dsT_EV_DUTYSUB_06">
                            <param name="LineColor"         value="Silver">
                            <param name="IndWidth"          value="0">
                            <param Name="Editable"          value="true">
                            <param name="Format"            value='
                                <C> id=ITEM_01     width=150   name=교육과정명		align=left  </C>
                                <C> id=ITEM_02     width=150   name=교육훈련기관	align=left  </C>
                                <C> id=ITEM_03     width=70    name=소요기간		align=left  </C>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="padding2423" colspan="2">
						<comment id="__NSID__">
                        <object    id="grdT_EV_DUTYSUB_07" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:390px;height:140px;">
                            <param name="DataID"            value="dsT_EV_DUTYSUB_07">
                            <param name="LineColor"         value="Silver">
                            <param name="IndWidth"          value="0">
                            <param Name="Editable"          value="true">
                            <param name="Format"            value='
                                <C> id=ITEM_01     width=170   name=자격증		align=left  </C>
                                <C> id=ITEM_02     width=200   name=인증기관	align=left  </C>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
				<tr height="0">
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 -->

</form>
<!-- form 끝 -->

</body>
</html>

	<!--
	**************************************************************
	* 바인딩 컴포넌트
	**************************************************************
	-->
	<!--  테이블 -->
	<comment id="__NSID__">
	<object id="bndT_EV_DUTYRSH" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_EV_DUTYDESC">
		<Param Name="ActiveBind"		Value=true>
		<Param Name="BindInfo", Value='
			<C>Col=DUTY_NO        Ctrl=cmbDUTY_NO       Param=value</C>
			<C>Col=DUTY_YMD       Ctrl=txtDUTY_YMD      Param=value</C>
			<C>Col=THR_NM         Ctrl=txtTHR_NM        Param=value</C>
			<C>Col=SEC_NM         Ctrl=txtSEC_NM        Param=value</C>
			<C>Col=DUTY_NM        Ctrl=txtDUTY_NM       Param=value</C>
			<C>Col=DUTY_CD        Ctrl=txtDUTY_CD       Param=value</C>
			<C>Col=DUTY_OBJ       Ctrl=txtDUTY_OBJ      Param=value</C>
			<C>Col=SCH_LBL        Ctrl=txtSCH_LBL       Param=value</C>
	    '>
	</object>
	</comment><script> __ShowEmbedObject(__NSID__); </script>


	<!--
	**************************************************************
	* 바인딩 컴포넌트
	**************************************************************
	-->
	<!--  테이블 -->
	<comment id="__NSID__">
	<object id="bndT_EV_DUTYLST_01" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_EV_DUTYSUB_01">
		<Param Name="ActiveBind"		Value=true>
		<Param Name="BindInfo", Value='
			<C>Col=ITEM_01       Ctrl=txtITEM_01      Param=value</C>
			<C>Col=ITEM_02       Ctrl=txtITEM_02      Param=value</C>
			<C>Col=ITEM_03       Ctrl=cmbITEM_03      Param=value</C>
			<C>Col=ITEM_04       Ctrl=txtITEM_04      Param=value</C>
	    '>
	</object>
	</comment><script> __ShowEmbedObject(__NSID__); </script>

