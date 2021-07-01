	<!--*************************************************
	* @source      : idta011.jsp						*
	* @description : 증명서신청 PAGE 					*
	****************************************************
	* DATE            AUTHOR        DESCRIPTION			*
	*------------------------------------------------------------------
	* 2016/04/28            이동훈            	ERP 이사 *
	************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<%
    String REQ_NO = request.getParameter("REQ_NO");
%>

<html>
<head>
	<title>증명서신청</title>
	<jsp:include page="/Ehr/common/include/head.jsp"/>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">


		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
			
            dsT_ID_CEFBOOK.DataId = " ../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=SHR&REQ_NO=<%=REQ_NO %>";
            
            dsT_ID_CEFBOOK.reset();
            
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
        function fnc_Save(sts) {
			
            //상태가 신청이면 상태값을 변경 시킨다.

            if(dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition,'CEF_STS') == "B") {
            	
    			dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition,'CEF_STS') = sts;
    			
    			if(sts == "F" || sts == "E"){
    				dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition,'SPL_YMD') = gcurdate;
    			}

    			if ( !fnc_SaveItemCheck() ) {
    				return;
    			}

                //결과 메세지를 출력 하기 위해
                if(sts == "C")
                    trTypeMsg = "반송";
                else if(sts == "E")
                    trTypeMsg = "발급";


        	var REQ_NO = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "REQ_NO");
        	var rowIndex = dsT_ID_CEFBOOK.NameValueRow("REQ_NO", REQ_NO);
        	var CEF_SEC = dsT_ID_CEFBOOK.NameValue(rowIndex, "CEF_SEC");

    			// save
    			trT_ID_CEFBOOK.KeyValue = "tr01(I:dsT_ID_CEFBOOK=dsT_ID_CEFBOOK)";
    			trT_ID_CEFBOOK.action = " ../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=SAV";
    			trT_ID_CEFBOOK.post();
    			
            }

            
            //
            if(sts == "C")
    			window.close();
         
            
	        //재직증명서 출력
	        if(CEF_SEC == "01") {
	            fnc_Print1();
	        }

	        //경력증명서 출력
	        if(CEF_SEC == "02") {
	            fnc_Print2();
	        }

	        //퇴직증명서 출력
	        if(CEF_SEC == "03") {
	            fnc_Print3();
	        }

	        //출입국출력
	        if(CEF_SEC == "04") {
	            fnc_Print4();
	        }

        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {

        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print1() {


            if(dsT_ID_CEFBOOK.RowPosition == "0") return;

            // 상태에 따른 버튼 처리 - CEF_STS, 'A', '저장', 'B', '신청', 'C', '반송', 'E', '발급', 'F', '직접출력'
            var CEF_STS = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_STS");  //상태
            var CEF_SEC = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_SEC");  //증명서 종류
            var CEF_CNT = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_CNT");  //발급매수
            var CEF_RSN = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_RSN");  //발급사유
            var REQ_NO  = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "REQ_NO");   //발급번호
            
            //회사 주소 선택. 기본은 1.서울주소 
            if (document.getElementById("rdoCOM_ADD").CodeValue == "01"){
				
				dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "DRV_TAG") = "1";
				
			}else if(document.getElementById("rdoCOM_ADD").CodeValue == "02"){
				
				dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "DRV_TAG") = "2";
				
			}
            
			cfCopyDataSet(dsT_ID_CEFBOOK, dsT_ID_CEFBOOK_PRINT, "copyHeader=yes,rowFrom="+dsT_ID_CEFBOOK.RowPosition+",rowCnt=1");
            
			gcrp_print1.Preview();

        }

        function fnc_Print2() {

            if(dsT_ID_CEFBOOK.RowPosition == "0") return;

            // 상태에 따른 버튼 처리 - CEF_STS, 'A', '저장', 'B', '신청', 'C', '반송', 'E', '발급', 'F', '직접출력'
            var CEF_STS = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_STS");  //상태
            var CEF_SEC = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_SEC");  //증명서 종류
            var CEF_CNT = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_CNT");  //발급매수
            var CEF_RSN = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_RSN");  //발급사유
            var REQ_NO  = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "REQ_NO");   //발급번호
			
            //회사 주소 선택. 기본은 1.서울주소 
            if (document.getElementById("rdoCOM_ADD").CodeValue == "01"){
				
				dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "DRV_TAG") = "1";
				
			}else if(document.getElementById("rdoCOM_ADD").CodeValue == "02"){
				
				dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "DRV_TAG") = "2";
				
			}
            
			cfCopyDataSet(dsT_ID_CEFBOOK, dsT_ID_CEFBOOK_PRINT, "copyHeader=yes,rowFrom="+dsT_ID_CEFBOOK.RowPosition+",rowCnt=1");
            
			gcrp_print2.Preview();

        }

        function fnc_Print3() {

            if(dsT_ID_CEFBOOK.RowPosition == "0") return;
            // 상태에 따른 버튼 처리 - CEF_STS, 'A', '저장', 'B', '신청', 'C', '반송', 'E', '발급', 'F', '직접출력'
            var CEF_STS = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_STS");  //상태
            var CEF_SEC = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_SEC");  //증명서 종류
            var CEF_CNT = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_CNT");  //발급매수
            var CEF_RSN = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_RSN");  //발급사유
            var REQ_NO  = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "REQ_NO");   //발급번호
            
            //회사 주소 선택. 기본은 1.서울주소 
            if (document.getElementById("rdoCOM_ADD").CodeValue == "01"){
				
				dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "DRV_TAG") = "1";
				
			}else if(document.getElementById("rdoCOM_ADD").CodeValue == "02"){
				
				dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "DRV_TAG") = "2";
				
			}
            
			cfCopyDataSet(dsT_ID_CEFBOOK, dsT_ID_CEFBOOK_PRINT, "copyHeader=yes,rowFrom="+dsT_ID_CEFBOOK.RowPosition+",rowCnt=1");
            
			gcrp_print3.Preview();

        }

        function fnc_Print4() {

            if(dsT_ID_CEFBOOK.RowPosition == "0") return;
            // 상태에 따른 버튼 처리 - CEF_STS, 'A', '저장', 'B', '신청', 'C', '반송', 'E', '발급', 'F', '직접출력'
            var CEF_STS = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_STS");  //상태
            var CEF_SEC = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_SEC");  //증명서 종류
            var CEF_CNT = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_CNT");  //발급매수
            var CEF_RSN = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_RSN");  //발급사유
            var REQ_NO  = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "REQ_NO");   //발급번호
            
            //회사 주소 선택. 기본은 1.서울주소 
            if (document.getElementById("rdoCOM_ADD").CodeValue == "01"){
				
				dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "DRV_TAG") = "1";
				
			}else if(document.getElementById("rdoCOM_ADD").CodeValue == "02"){
				
				dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "DRV_TAG") = "2";
				
			}
            
			cfCopyDataSet(dsT_ID_CEFBOOK, dsT_ID_CEFBOOK_PRINT, "copyHeader=yes,rowFrom="+dsT_ID_CEFBOOK.RowPosition+",rowCnt=1");
            
			gcrp_print4.Preview();

        }



		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {

        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {

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

        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {

        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			window.close();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {

        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {
			
            if ( !dsT_ID_CEFBOOK.isUpdated ) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
            }
            return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        	
            fnc_DisableElementAll(elementList);
            fnc_HiddenElement("btnC");      //반송
            fnc_HiddenElement("btnE");      //발급


            // 용도 구분 검색 콤보박스 생성
			for( var i = 1; i <= dsT_CM_COMMON_R4.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
				oOption.value = dsT_CM_COMMON_R4.NameValue(i,"CODE");
				oOption.text  = dsT_CM_COMMON_R4.NameValue(i,"CODE_NAME");
				document.getElementById("cmbCEF_RSN").add(oOption);
			}

            fnc_SearchList();
            
        }


		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        //입력 element들
        var elementList = new Array(     "txtHIR_CNT"
                                        ,"txtEXP_CNT"
                                        ,"txtRET_CNT"
                                        ,"txtCAR_CNT"
                                        ,"txtREMARK"
                                        ,"rdoCEF_SEC"
                                        ,"txtCEF_CNT"
                                        ,"cmbCEF_RSN"
                                        ,"txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo");


    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(T_ID_CEFBOOK)			   |
    | 3. 사용되는 Table List(T_ID_CEFBOOK) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_ID_CEFBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">

	</Object>

	<Object ID="dsT_ID_CEFBOOK_UPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>


	<Object ID="dsT_ID_CEFBOOK_PRINT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_ID_CEFBOOK)			   |
    | 3. 사용되는 Table List(T_ID_CEFBOOK)				   |
    +------------------------------------------------------>
	<Object ID="trT_ID_CEFBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsO=dsT_ID_CEFBOOK)">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 용도 구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R4"/>
       <jsp:param name="CODE_GUBUN"    value="R4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 증명서 구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R3"/>
       <jsp:param name="CODE_GUBUN"    value="R3"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_ID_CEFBOOK Event="OnLoadCompleted(iCount)">
		if (iCount != 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_ID_CEFBOOK.CountRow);

        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_ID_CEFBOOK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_ID_CEFBOOK Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_ID_CEFBOOK event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("* "+trTypeMsg+" 작업을 완료 하였습니다!");
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_ID_CEFBOOK event="OnFail()">
        alert(trT_ID_CEFBOOK.ErrorMsg);
    </script>

    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_ID_CEFBOOK event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        fnc_HiddenElement("btnC");      //반송
        fnc_HiddenElement("btnE");      //발급

        if(row > 0) {
            var CEF_STS = dsT_ID_CEFBOOK.NameString(dsT_ID_CEFBOOK.RowPosition, "CEF_STS");

            //신청 상태가 아니면 상태 변경 하지 못함
            if(CEF_STS == "B")
                fnc_ShowElement("btnC");    //반송

            //상태가 신청이거나 발급이거나 직접출력일 경우 발급버튼 안보이게
            if(CEF_STS == "B"
                    || CEF_STS == "E"
                    || CEF_STS == "F" )
        	fnc_ShowElement("btnE");      //발급

        }
    </script>

	<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_ID_CEFBOOK event=CanRowPosChange(row)>
		if ( dsT_ID_CEFBOOK.NameValue(row,"ENO_NO") == "" ) {
			alert("[ " + grdT_ID_CEFBOOK.GetHdrDispName('-3','ENO_NO') + " ]은 필수 입력사항입니다");
			return false;
		}
		if ( dsT_ID_CEFBOOK.NameValue(row,"CEF_CNT") == "" ) {
			alert("[ " + grdT_ID_CEFBOOK.GetHdrDispName('-3','CEF_CNT') + " ]는 필수 입력사항입니다");
			return false;
		}
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
            <td height="35" class="paddingTop5" width="260" align="right">
                <img src="../../images/button/btn_SendbackOn.gif" id="btnC" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save('C');" style="cursor:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnC','','../../images/button/btn_SendbackOver.gif',1)">
                <img src="../../images/button/btn_IssueOn.gif"    id="btnE" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save('E');" style="cursor:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnE','','../../images/button/btn_IssueOver.gif',1)">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->


	<!-- 조건 입력 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<colgroup>
		<col width="398"></col>
		<col width="4"></col>
		<col width="398"></col>
	</colgroup>
	<tr>
		<td colspan="3" class="paddingTop5">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="180"></col>
			<col width="60"></col>
			<col width="100"></col>
			<col width="60"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="blueBold">신청번호</td>
			<td class="padding2423" align="left">
				<input id="txtREQ_NO" name="txtREQ_NO" size="12"  maxlength="10" style="ime-mode:disabled" onKeypress="cfNumberCheck();" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="blueBold">사번</td>
            <td class="padding2423">
                <input id="txtENO_NO" name="txtENO_NO" size="9" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                <input id="txtENO_NM" name="txtENO_NM" size="9" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
            </td>
			<td align="center" class="blueBold">직위</td>
			<td class="padding2423" align="left">
				<input id="txtJOB_NM" name="txtJOB_NM" size="10" class="input_ReadOnly" readonly  maxlength="10" style="ime-mode:disabled" onKeypress="cfNumberCheck();">
                <input type="hidden" id="hidJOB_CD">
			</td>
			<td align="center" class="blueBold">부서</td>
			<td class="padding2423" align="left">
				<input id="txtDPT_NM" name="txtDPT_NM" size="15" class="input_ReadOnly" readonly  maxlength="10" style="ime-mode:disabled" onKeypress="cfNumberCheck();">
                <input type="hidden" id="hidDPT_CD">
			</td>
		</tr>
		<tr>
			<td align="center" class="blueBold">본적</td>
			<td class="padding2423" align="left" colspan="3">
				<input id="txtPER_ADR" name="txtPER_ADR" style="ime-mode:disabled;width:100%;" onKeypress="cfNumberCheck();" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="blueBold">주소</td>
			<td class="padding2423" align="left" colspan="3">
				<input id="txtADDRESS" name="txtADDRESS" style="ime-mode:disabled;width:100%;" onKeypress="cfNumberCheck();" class="input_ReadOnly" readonly>
			</td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="paddingTop5">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="60"></col>
			<col width="140"></col>
			<col width="60"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="blueBold">증명서<br>종류</td>
			<td class="padding2423" align="left" colspan="3">

                <comment id="__NSID__">
                    <object id=rdoCEF_SEC classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="width:200;height:90;">
                        <param name=AutoMargin  value="true">
                        <param name=Cols        value="1">
                        <param name=Format      value="01^재직증명서,02^경력증명서,03^퇴직증명서,04^출입국증명서">
                    </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>

			</td>
		</tr>
		<tr>
			<td align="center" class="blueBold">발급부수</td>
			<td class="padding2423" colspan="3">
				<input id="txtCEF_CNT" size="4"  maxlength="2" style="ime-mode:disabled">
			</td>
		</tr>
		<tr>
			<td align="center" class="blueBold">용도</td>
			<td class="padding2423" colspan="3">
				<select id="cmbCEF_RSN" style="width:50%"></select>
				&nbsp;
			</td>
		</tr>
		<tr>
			<td align="center" class="blueBold">비고</td>
			<td class="padding2423" colspan="3">
				<input type="text" id="txtREMARK" style="width:100%" class="input_ReadOnly" readonly>
			</td>
		</tr>
		<tr>
			<td align="center" class="blueBold">상태</td>
			<td class="padding2423">
				<input type="text" id="txtCEF_STS_NM" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="blueBold">신청일자</td>
			<td class="padding2423">
				<input type="text" id="txtREQ_YMD" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
		</tr>
		<tr>
			<td align="center" class="blueBold">발급번호</td>
			<td class="padding2423">
				<input type="text" id="txtCEF_NO" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="blueBold">발급일자</td>
			<td class="padding2423">
				<input type="text" id="txtSPL_YMD" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
		</tr>
		<tr>
			<td align="center" class="blueBold">회사주소</td>
			<td class="padding2423" align="left" colspan="3">
                <comment id="__NSID__">
                    <object id="rdoCOM_ADD" classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="width:300;height:50;">
                        <param name=AutoMargin  value="true">
                        <param name=Cols        value="1">
                        <param name=Format      value="01^서울시 종로구 율곡로 194,02^강원도 고성군 현내면 화진포서길 10" >
                    </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>
			</td>
		</tr>			
		
		</table>
		</td>
		<td>&nbsp;</td>
		<td class="paddingTop5">
		<table width="100%" height="220px" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse; vertical-align:top;" bordercolor="#999999" class="table_cream">
		<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
			<colgroup>
				<col width="300"></col>
				<col width="*"></col>
			</colgroup>
			</table>
		</td>
		</tr>
		</table>
		</td>
	</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->

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

	</form>
	<!-- form 끝 -->



<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### 재 직 증 명 서 ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print1  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="DetailDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 	VALUE="true">
  	<PARAM NAME="Landscape"				VALUE="0">
	<PARAM NAME="PaperSize"				VALUE="A4">
	<PARAM NAME="FixPaperSize"			VALUE="TRUE">
	<param NAME="PrintMargine"      	VALUE="false">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="Format"            	VALUE="
	<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2756 ,face='Arial' ,size=10 ,penwidth=1
		<X>left=38 ,top=319 ,right=1944 ,bottom=2656 ,border=true ,penstyle=solid ,penwidth=1</X>
		<X>left=38 ,top=2187 ,right=363 ,bottom=2656 ,border=true</X>
		<X>left=38 ,top=1353 ,right=1944 ,bottom=1525 ,border=true</X>
		<X>left=38 ,top=1012 ,right=1944 ,bottom=1184 ,border=true</X>
		<X>left=38 ,top=844 ,right=1944 ,bottom=1016 ,border=true</X>
		<X>left=38 ,top=675 ,right=1944 ,bottom=847 ,border=true</X>
		<X>left=38 ,top=506 ,right=1944 ,bottom=678 ,border=true</X>
		<I>id='../../Common/img/icon.jpg' ,left=741 ,top=2656 ,right=1219 ,bottom=2756</I>
		<L> left=694 ,top=247 ,right=1291 ,bottom=247 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=38 ,top=319 ,right=38 ,bottom=2653 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=41 ,top=319 ,right=1941 ,bottom=319 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=41 ,top=2656 ,right=1941 ,bottom=2656 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=1944 ,top=319 ,right=1944 ,bottom=2653 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=38 ,top=319 ,right=38 ,bottom=2656 </L>
		<L> left=1941 ,top=319 ,right=1941 ,bottom=2656 </L>
		<L> left=322 ,top=322 ,right=322 ,bottom=1522 </L>
		<L> left=984 ,top=675 ,right=984 ,bottom=1012 </L>
		<L> left=1309 ,top=678 ,right=1309 ,bottom=1016 </L>
		<L> left=119 ,top=2278 ,right=119 ,bottom=2656 </L>
		<L> left=41 ,top=2466 ,right=359 ,bottom=2466 </L>
		<L> left=38 ,top=2275 ,right=363 ,bottom=2275 </L>

		<C>id='CEF_NO', left=38, top=241, right=506, bottom=306, align='left' ,mask='제 XXXXXXXXX 호', face='굴림', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='PER_ADR', left=344, top=384, right=1922, bottom=450, align='left', face='굴림', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ADDRESS', left=344, top=559, right=1922, bottom=625, align='left', face='굴림', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='DPT_NM', left=344, top=725, right=975, bottom=791, align='left', face='굴림', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JOB_NM', left=1334, top=725, right=1925, bottom=791, align='left', face='굴림', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ENO_NM', left=344, top=894, right=975, bottom=959, align='left', face='굴림', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CET_NO', left=1334, top=894, right=1925, bottom=959, align='left' , face='굴림', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CEF_RSN_NM', left=344, top=1062, right=1922, bottom=1128, align='left', face='굴림', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='HIR_YMD', left=344, top=1234, right=725, bottom=1300, align='left' , mask='XXXX년 XX월 XX일',face='굴림', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='REMARK', left=344, top=1370, right=1025, bottom=1510, align='left' ,face='굴림', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='SPL_YMD2', left=1319, top=2025, right=1819, bottom=2094, align='right' ,mask='XXXX년 XX월 XX일 ', face='굴림', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>


		<T>id='재 직 증 명 서' ,left=25 ,top=91 ,right=1959 ,bottom=237 ,face='HY견고딕' ,size=26 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='생년월일' ,left=994 ,top=894 ,right=1306 ,bottom=959 ,face='굴림' ,size=12 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='직     위' ,left=994 ,top=725 ,right=1306 ,bottom=791 ,face='굴림' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='확   인' ,left=63 ,top=2200 ,right=334 ,bottom=2266 ,face='굴림' ,size=13 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='담' ,left=44 ,top=2487 ,right=119 ,bottom=2547 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='당' ,left=44 ,top=2578 ,right=119 ,bottom=2637 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='자' ,left=44 ,top=2403 ,right=119 ,bottom=2456 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='인' ,left=44 ,top=2347 ,right=119 ,bottom=2397 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='확' ,left=44 ,top=2287 ,right=119 ,bottom=2341 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='본     적' ,left=47 ,top=378 ,right=316 ,bottom=444 ,face='굴림' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='주     소' ,left=47 ,top=553 ,right=316 ,bottom=619 ,face='굴림' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='소     속' ,left=47 ,top=719 ,right=316 ,bottom=784 ,face='굴림' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='성     명' ,left=47 ,top=887 ,right=316 ,bottom=953 ,face='굴림' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='용     도' ,left=47 ,top=1062 ,right=316 ,bottom=1128 ,face='굴림' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='입 사 일' ,left=47 ,top=1228 ,right=316 ,bottom=1294 ,face='굴림' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='비     고' ,left=47 ,top=1397 ,right=316 ,bottom=1462 ,face='굴림' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='상기 사실을 증명함.' ,left=344, top=1547, right=1934, bottom=1644 ,face='굴림' ,align='left',size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>

		<C>id='{decode(DRV_TAG,1,\'서울시 종로구 율곡로 194\',2,\'강원도 고성군 현내면 화진포서길 10\',\'서울시 종로구 율곡로 194\')}' ,left=1101 ,top=2225 ,right=1900 ,bottom=2323 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C>
	    <T>id='현 대 아 산 주 식 회 사' , align='left' ,left=1101 ,top=2336 ,right=1840 ,bottom=2434 ,face='HY견고딕' ,size=14   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='대 표 이 사    이 백 훈' , align='left' ,left=1101 ,top=2445 ,right=1840 ,bottom=2543 ,face='HY견고딕' ,size=14  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<I>id='../../images/common/new_attampt1.gif' ,left=1582 ,top=2281 ,right=1886 ,bottom=2572</I>
		<I>id='../../images/common/icon.jpg' ,left=741 ,top=2700 ,right=1219 ,bottom=2800</I>


	</B>
">
</OBJECT>



<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### 경 력 증 명 서 ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print2  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="DetailDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 	VALUE="true">
  	<PARAM NAME="Landscape"				VALUE="0">
	<PARAM NAME="PaperSize"				VALUE="A4">
	<PARAM NAME="FixPaperSize"			VALUE="TRUE">
	<param NAME="PrintMargine"      	VALUE="false">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="Format"            	VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2799 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=741 ,top=2614 ,right=1220 ,bottom=2712</I>
	<X>left=37 ,top=270 ,right=1942 ,bottom=2606 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=37 ,top=2135 ,right=362 ,bottom=2606 ,border=true</X>
	<X>left=37 ,top=1302 ,right=1942 ,bottom=1302 ,border=true</X>
	<X>left=37 ,top=1130 ,right=1942 ,bottom=1304 ,border=true</X>
	<X>left=37 ,top=963 ,right=1942 ,bottom=1135 ,border=true</X>
	<X>left=37 ,top=794 ,right=1942 ,bottom=966 ,border=true</X>
	<X>left=37 ,top=455 ,right=1942 ,bottom=627 ,border=true</X>
	<X>left=37 ,top=624 ,right=1942 ,bottom=796 ,border=true</X>
	<L> left=37 ,top=270 ,right=37 ,bottom=2601 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=42 ,top=270 ,right=1939 ,bottom=270 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=42 ,top=2606 ,right=1939 ,bottom=2606 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1942 ,top=270 ,right=1942 ,bottom=2601 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=984 ,top=455 ,right=984 ,bottom=796 </L>
	<L> left=1275 ,top=455 ,right=1275 ,bottom=796 </L>
	<L> left=37 ,top=270 ,right=37 ,bottom=2606 </L>
	<L> left=1939 ,top=270 ,right=1939 ,bottom=2606 </L>
	<L> left=119 ,top=2228 ,right=119 ,bottom=2606 </L>
	<L> left=42 ,top=2416 ,right=357 ,bottom=2416 </L>
	<L> left=37 ,top=2225 ,right=355 ,bottom=2225 </L>
	<C>id='CEF_NO', left=34, top=191, right=503, bottom=257, align='left' ,mask='제 XXXXXXXXX 호', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SPL_YMD2', left=1320, top=2024, right=1818, bottom=2093, align='right' ,mask='XXXX년 XX월 XX일 ', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=696 ,top=198 ,right=1291 ,bottom=198 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='경 력 증 명 서' ,left=24 ,top=42 ,right=1958 ,bottom=188 ,face='HY견고딕' ,size=26 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확   인' ,left=64 ,top=2148 ,right=333 ,bottom=2215 ,face='굴림' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담' ,left=45 ,top=2437 ,right=119 ,bottom=2498 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='당' ,left=45 ,top=2529 ,right=119 ,bottom=2588 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자' ,left=45 ,top=2352 ,right=119 ,bottom=2405 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인' ,left=45 ,top=2297 ,right=119 ,bottom=2347 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확' ,left=45 ,top=2236 ,right=119 ,bottom=2291 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DRV_TAG,1,\'서울시 종로구 율곡로 194\',2,\'강원도 고성군 현내면 화진포서길 10\',\'서울시 종로구 율곡로 194\')}' ,left=1101 ,top=2225 ,right=1900 ,bottom=2323 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C>
	<T>id='현 대 아 산 주 식 회 사' ,left=1101 ,top=2336 ,right=1839 ,bottom=2434 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대 표 이 사    이 백 훈' ,left=1101 ,top=2445 ,right=1839 ,bottom=2543 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/new_attampt1.gif' ,left=1582 ,top=2281 ,right=1886 ,bottom=2572</I>
	<I>id='../../images/common/icon.jpg' ,left=741 ,top=2699 ,right=1220 ,bottom=2799</I>
	<T>id='상기 사실을 증명함.' ,left=344 ,top=1389 ,right=1934 ,bottom=1484 ,align='left' ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='REMARK', left=325, top=1185, right=1008, bottom=1262, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='비     고' ,left=45 ,top=1188 ,right=320 ,bottom=1254 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RET_YMD', left=1286, top=1024, right=1667, bottom=1093, align='left' ,mask='XXXX년 XX월 XX일', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='퇴사일' ,left=987 ,top=1024 ,right=1275 ,bottom=1090 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='HIR_YMD', left=328, top=1024, right=712, bottom=1090, align='left' ,mask='XXXX년 XX월 XX일', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='입 사 일' ,left=45 ,top=1021 ,right=320 ,bottom=1087 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CEF_RSN_NM', left=328, top=852, right=1908, bottom=915, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='용     도' ,left=45 ,top=852 ,right=320 ,bottom=918 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CET_NO', left=1286, top=685, right=1908, bottom=751, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='생년월일' ,left=987 ,top=685 ,right=1275 ,bottom=751 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=328, top=680, right=963, bottom=746, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='성     명' ,left=45 ,top=677 ,right=320 ,bottom=743 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='JOB_NM', left=1286, top=513, right=1876, bottom=582, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='직     위' ,left=987 ,top=516 ,right=1275 ,bottom=582 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DPT_NM', left=328, top=513, right=963, bottom=582, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='소     속' ,left=45 ,top=511 ,right=320 ,bottom=574 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ADDRESS', left=328, top=344, right=1908, bottom=407, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='주     소' ,left=45 ,top=344 ,right=320 ,bottom=410 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=984 ,top=963 ,right=984 ,bottom=1135 </L>
	<L> left=1275 ,top=968 ,right=1275 ,bottom=1135 </L>
	<L> left=320 ,top=273 ,right=320 ,bottom=1304 </L>
</B>

">
</OBJECT>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### 퇴직 증 명 서 ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print3  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="DetailDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 	VALUE="true">
  	<PARAM NAME="Landscape"				VALUE="0">
	<PARAM NAME="PaperSize"				VALUE="A4">
	<PARAM NAME="FixPaperSize"			VALUE="TRUE">
	<param NAME="PrintMargine"      	VALUE="false">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="Format"            	VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2799 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=37 ,top=270 ,right=1945 ,bottom=2606 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=37 ,top=2138 ,right=362 ,bottom=2606 ,border=true</X>
	<X>left=37 ,top=1302 ,right=1945 ,bottom=1302 ,border=true</X>
	<X>left=37 ,top=1130 ,right=1945 ,bottom=1307 ,border=true</X>
	<X>left=37 ,top=963 ,right=1945 ,bottom=1135 ,border=true</X>
	<X>left=37 ,top=794 ,right=1945 ,bottom=966 ,border=true</X>
	<X>left=37 ,top=455 ,right=1945 ,bottom=627 ,border=true</X>
	<X>left=37 ,top=624 ,right=1945 ,bottom=796 ,border=true</X>
	<L> left=37 ,top=270 ,right=37 ,bottom=2604 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=40 ,top=270 ,right=1942 ,bottom=270 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=40 ,top=2606 ,right=1942 ,bottom=2606 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1945 ,top=270 ,right=1945 ,bottom=2604 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=323 ,top=273 ,right=323 ,bottom=1304 </L>
	<L> left=984 ,top=455 ,right=984 ,bottom=796 </L>
	<L> left=1275 ,top=455 ,right=1275 ,bottom=796 </L>
	<L> left=1275 ,top=963 ,right=1275 ,bottom=1135 </L>
	<L> left=984 ,top=963 ,right=984 ,bottom=1135 </L>
	<L> left=37 ,top=270 ,right=37 ,bottom=2606 </L>
	<L> left=1942 ,top=270 ,right=1942 ,bottom=2606 </L>
	<L> left=119 ,top=2228 ,right=119 ,bottom=2606 </L>
	<L> left=40 ,top=2416 ,right=360 ,bottom=2416 </L>
	<L> left=37 ,top=2225 ,right=357 ,bottom=2225 </L>
	<C>id='CEF_NO', left=34, top=191, right=503, bottom=257, align='left' ,mask='제 XXXXXXXXX 호', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SPL_YMD2', left=1320, top=2024, right=1818, bottom=2093, align='right' ,mask='XXXX년 XX월 XX일 ', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=693 ,top=196 ,right=1291 ,bottom=196 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='퇴 직 증 명 서' ,left=24 ,top=40 ,right=1958 ,bottom=188 ,face='HY견고딕' ,size=26 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확   인' ,left=64 ,top=2151 ,right=333 ,bottom=2217 ,face='굴림' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담' ,left=45 ,top=2437 ,right=119 ,bottom=2498 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='당' ,left=45 ,top=2527 ,right=119 ,bottom=2588 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자' ,left=45 ,top=2352 ,right=119 ,bottom=2405 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인' ,left=45 ,top=2297 ,right=119 ,bottom=2347 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확' ,left=45 ,top=2236 ,right=119 ,bottom=2291 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DRV_TAG,1,\'서울시 종로구 율곡로 194\',2,\'강원도 고성군 현내면 화진포서길 10\',\'서울시 종로구 율곡로 194\')}' ,left=1101 ,top=2225 ,right=1900 ,bottom=2323 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C>
	<T>id='현 대 아 산 주 식 회 사' ,left=1101 ,top=2336 ,right=1839 ,bottom=2434 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대 표 이 사    이 백 훈' ,left=1101 ,top=2445 ,right=1839 ,bottom=2543 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/new_attampt1.gif' ,left=1582 ,top=2281 ,right=1886 ,bottom=2572</I>
	<I>id='../../images/common/icon.jpg' ,left=741 ,top=2699 ,right=1220 ,bottom=2799</I>
	<T>id='상기 사실을 증명함.' ,left=344 ,top=1389 ,right=1934 ,bottom=1484 ,align='left' ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='JOB_NM', left=1286, top=513, right=1876, bottom=582, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CET_NO', left=1286, top=685, right=1876, bottom=751, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RET_YMD', left=1286, top=1024, right=1667, bottom=1093, align='left' ,mask='XXXX년 XX월 XX일', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='퇴사일' ,left=987 ,top=1024 ,right=1275 ,bottom=1090 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='생년월일' ,left=987 ,top=685 ,right=1275 ,bottom=751 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직     위' ,left=987 ,top=516 ,right=1275 ,bottom=582 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ADDRESS', left=328, top=344, right=1908, bottom=407, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DPT_NM', left=328, top=513, right=963, bottom=582, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM', left=328, top=680, right=963, bottom=746, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CEF_RSN_NM', left=328, top=852, right=1908, bottom=915, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HIR_YMD', left=328, top=1024, right=712, bottom=1090, align='left' ,mask='XXXX년 XX월 XX일', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=325, top=1185, right=1008, bottom=1262, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='비     고' ,left=45 ,top=1188 ,right=320 ,bottom=1254 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='입 사 일' ,left=45 ,top=1019 ,right=320 ,bottom=1085 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='용     도' ,left=45 ,top=852 ,right=320 ,bottom=918 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성     명' ,left=45 ,top=677 ,right=320 ,bottom=743 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소     속' ,left=45 ,top=511 ,right=320 ,bottom=574 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주     소' ,left=45 ,top=344 ,right=320 ,bottom=410 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

">
</OBJECT>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### 출 국 (확인) 증 명 서 ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print4  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="DetailDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 	VALUE="true">
  	<PARAM NAME="Landscape"				VALUE="0">
	<PARAM NAME="PaperSize"				VALUE="A4">
	<PARAM NAME="FixPaperSize"			VALUE="TRUE">
	<param NAME="PrintMargine"      	VALUE="false">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="Format"            	VALUE="
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2799 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=37 ,top=320 ,right=1945 ,bottom=2656 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=37 ,top=2188 ,right=362 ,bottom=2656 ,border=true</X>
	<X>left=37 ,top=1011 ,right=1945 ,bottom=1183 ,border=true</X>
	<X>left=37 ,top=844 ,right=1945 ,bottom=1016 ,border=true</X>
	<X>left=37 ,top=675 ,right=1945 ,bottom=847 ,border=true</X>
	<X>left=37 ,top=505 ,right=1945 ,bottom=677 ,border=true</X>
	<I>id='../../Common/img/icon.jpg' ,left=741 ,top=2656 ,right=1220 ,bottom=2754</I>
	<L> left=37 ,top=320 ,right=37 ,bottom=2654 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=40 ,top=320 ,right=1942 ,bottom=320 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=40 ,top=2656 ,right=1942 ,bottom=2656 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1945 ,top=320 ,right=1945 ,bottom=2654 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=37 ,top=320 ,right=37 ,bottom=2656 </L>
	<L> left=1942 ,top=320 ,right=1942 ,bottom=2656 </L>
	<L> left=323 ,top=323 ,right=323 ,bottom=1352 </L>
	<L> left=984 ,top=505 ,right=984 ,bottom=847 </L>
	<L> left=1310 ,top=505 ,right=1310 ,bottom=847 </L>
	<L> left=119 ,top=2278 ,right=119 ,bottom=2656 </L>
	<L> left=40 ,top=2466 ,right=360 ,bottom=2466 </L>
	<L> left=37 ,top=2275 ,right=362 ,bottom=2275 </L>
	<T>id='출 국 (확인) 증 명 서' ,left=24 ,top=90 ,right=1958 ,bottom=238 ,face='HY견고딕' ,size=26 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확   인' ,left=64 ,top=2199 ,right=333 ,bottom=2265 ,face='굴림' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담' ,left=45 ,top=2487 ,right=119 ,bottom=2548 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='당' ,left=45 ,top=2577 ,right=119 ,bottom=2638 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자' ,left=45 ,top=2402 ,right=119 ,bottom=2455 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인' ,left=45 ,top=2347 ,right=119 ,bottom=2397 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확' ,left=45 ,top=2286 ,right=119 ,bottom=2342 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DRV_TAG,1,\'서울시 종로구 율곡로 194\',2,\'강원도 고성군 현내면 화진포서길 10\',\'서울시 종로구 율곡로 194\')}' ,left=1101 ,top=2225 ,right=1900 ,bottom=2323 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C>
	<T>id='현 대 아 산 주 식 회 사' ,left=1101 ,top=2336 ,right=1839 ,bottom=2434 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대 표 이 사    이 백 훈' ,left=1101 ,top=2445 ,right=1839 ,bottom=2543 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/new_attampt1.gif' ,left=1582 ,top=2281 ,right=1886 ,bottom=2572</I>
	<I>id='../../images/common/icon.jpg' ,left=741 ,top=2699 ,right=1220 ,bottom=2799</I>
	<L> left=537 ,top=241 ,right=1437 ,bottom=241 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='CEF_NO', left=37, top=241, right=505, bottom=307, align='left' ,mask='제 XXXXXXXXX 호', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SPL_YMD2', left=1320, top=2024, right=1818, bottom=2093, align='right' ,mask='XXXX년 XX월 XX일 ', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='상기 사실을 증명함.' ,left=344 ,top=1389 ,right=1934 ,bottom=1484 ,align='left' ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CEF_RSN_NM', left=344, top=1244, right=1921, bottom=1310, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='END_YMD', left=743, top=1074, right=1225, bottom=1140, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='STR_YMD', left=344, top=1074, right=725, bottom=1140, align='left' ,mask='XXXXXXXXXX  ~', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CITY', left=344, top=902, right=1921, bottom=968, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CET_NO', left=1334, top=736, right=1926, bottom=799, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM', left=1334, top=566, right=1926, bottom=632, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM', left=344, top=736, right=976, bottom=799, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DPT_NM', left=344, top=566, right=976, bottom=632, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADDRESS', left=344, top=400, right=1921, bottom=466, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='생년월일' ,left=995 ,top=736 ,right=1307 ,bottom=799 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직     위' ,left=995 ,top=566 ,right=1307 ,bottom=632 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='용     도' ,left=48 ,top=1238 ,right=315 ,bottom=1304 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부임기간' ,left=48 ,top=1069 ,right=315 ,bottom=1135 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부 임 지' ,left=48 ,top=902 ,right=315 ,bottom=968 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성     명' ,left=48 ,top=728 ,right=315 ,bottom=794 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소     속' ,left=48 ,top=561 ,right=315 ,bottom=624 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주     소' ,left=48 ,top=394 ,right=315 ,bottom=460 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=32 ,top=1352 ,right=1947 ,bottom=1355 ,border=true</X>
</B>

">
</OBJECT>

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_ID_CEFBOOK 설정 테이블 -->
	<object id="bndT_ID_CEFBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_ID_CEFBOOK">
		<Param Name="BindInfo", Value="
			<C>Col=REQ_NO		Ctrl=txtREQ_NO		Param=value</C>
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
			<C>Col=JOB_CD		Ctrl=hidJOB_CD		Param=value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=DPT_CD		Ctrl=hidDPT_CD		Param=value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=PER_ADR		Ctrl=txtPER_ADR		Param=value</C>
			<C>Col=ADDRESS		Ctrl=txtADDRESS		Param=value</C>

			<C>Col=CEF_RSN		Ctrl=cmbCEF_RSN		Param=value</C>
			<C>Col=REQ_YMD		Ctrl=txtREQ_YMD		Param=value</C>
			<C>Col=SPL_YMD		Ctrl=txtSPL_YMD		Param=value</C>
			<C>Col=CEF_NO		Ctrl=txtCEF_NO		Param=value</C>
			<C>Col=CEF_STS_NM	Ctrl=txtCEF_STS_NM	Param=value</C>
			<C>Col=CEF_SEC		Ctrl=rdoCEF_SEC		Param=CodeValue</C>
			<C>Col=CEF_CNT		Ctrl=txtCEF_CNT		Param=value</C>
			<C>Col=REMARK		Ctrl=txtREMARK		Param=value</C>
		">
	</object>