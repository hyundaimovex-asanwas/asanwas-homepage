	<!--*************************************************************************
	* @source      : proa010.jsp												*
	* @description : 승진사항관리 PAGE												*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/17            채갑병         	        최초작성										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>승진사항관리(proa010)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TFTTFFFT';
		var next_yy = eval(getToday().substr(0,4)+"+"+1);

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			var ENO_NO_SHR = document.form1.txtENO_NO_SHR.value;
			var PMT_YY_SHR = document.form1.txtPMT_YY_SHR.value;

			if( PMT_YY_SHR == "" ){
				alert("승진년도를 입력하십시오. 예)"+next_yy);
				return;
			}

            trT_PM_PROMOTION_SHR.KeyValue = "tr01(O:dsT_PM_PROMOTION=dsT_PM_PROMOTION, O:dsT_CP_WORKLOG=dsT_CP_WORKLOG)";
            trT_PM_PROMOTION_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa010.cmd.PROA010CMD&S_MODE=SHR&ENO_NO_SHR="+ENO_NO_SHR+"&PMT_YY_SHR="+PMT_YY_SHR;
            trT_PM_PROMOTION_SHR.post();
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
			if ( !fnc_SaveItemCheck() ) {
				return;
			}

			// save
			trT_PM_PROMOTION.KeyValue = "tr01(I:dsT_PM_PROMOTION=dsT_PM_PROMOTION)";
			trT_PM_PROMOTION.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa010.cmd.PROA010CMD&S_MODE=SAV";
			trT_PM_PROMOTION.post();
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
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
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
  			document.getElementById("resultMessage").innerText = ' ';
  			document.form1.txtPENO_NO.value = "";
  			document.form1.txtPENO_NM.value = "";
  			document.form1.txtPENO_NO2.value = "";
  			document.form1.txtPENO_NM2.value = "";
  			document.form1.txtPMT_LBL_CNT.value = "";
  			document.form1.txtENO_NO_SHR.value = "";
  			document.form1.txtENO_NM_SHR.value = "";
  			//document.form1.txtPMT_YY_SHR.value = next_yy;
  			disableInput();

        	dsT_PM_RECOMMAND.ClearData();
        	dsT_PM_PROMOTION.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_PM_PROMOTION.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
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
         	if (!dsT_PM_PROMOTION.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

	        cfStyleGrid(form1.grdT_PM_PROMOTION,15,"true","false");
	        disableInput();
	        document.form1.txtPMT_YY_SHR.value = next_yy;
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
			//if (winstat == "activate") {fnc_SearchList();}   //Form이 Active 될 때 마다 재조회 처리
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

  		/********************************************
         * 총합계 계산	                       			*
         ********************************************/
        function setTotal() {

            var GOG_GAV = document.form1.txtGOG_GAV.value;//고과점수
        	var GOG_HTT = document.form1.txtGOG_HTT.value;//근속기간
        	var EDU_SCR = document.form1.txtEDU_SCR.value;//교육사항
        	var GUN_GTT = document.form1.txtGUN_GTT.value;//근태사항
        	var SAN_SCR = document.form1.txtSAN_SCR.value;//상벌사항
        	//var EXM_TIC = document.form1.txtEXM_TIC.value;//시험사항
        	var CEN_SCR = document.form1.txtCEN_SCR.value;//추천사항

        	if(GOG_GAV == "") GOG_GAV = "0";
        	if(GOG_HTT == "") GOG_HTT = "0";
        	if(EDU_SCR == "") EDU_SCR = "0";
        	if(GUN_GTT == "") GUN_GTT = "0";
        	if(SAN_SCR == "") SAN_SCR = "0";
        	//if(EXM_TIC == "") EXM_TIC = "0";
        	if(CEN_SCR == "") CEN_SCR = "0";

        	// && EXM_TIC != ""                   +EXM_TIC+"+"
        	//alert(GOG_GAV +",  "+ GOG_HTT +",  "+ EDU_SCR +",  "+ GUN_GTT +",  "+ SAN_SCR +",  "+ CEN_SCR);
        	if(GOG_GAV != "" && GOG_HTT != "" && EDU_SCR != "" && GUN_GTT != "" && SAN_SCR != "" && CEN_SCR != "" ){
	        	document.form1.txtSPC_TOT.value = eval(GOG_HTT+"+"+EDU_SCR+"+"+GUN_GTT+"+"+SAN_SCR+"+"+CEN_SCR+"+"+GOG_GAV);
        	}
        }

         /********************************************
         * 입력필드 사용 가능하게(Enable)          		 *
         ********************************************/
  		function enableInput(){
  		 	for(var i=17; i<81; i++){
  		 		if(

                    i==17 || // 년도-1
                    i==18 || // 역량-1
                    i==19 || // 년도-2
                    i==20 || // 역량-2
                    i==21 || // 년도-3
                    i==22 || // 역량-3
                    i==23 || // 년도-4
                    i==24 || // 역량-4
                    i==25 || // 년도-5
                    i==26 || // 역량-5
                    i==27 || // 성과1-1
                    i==28 || // 성과1-2
                    i==29 || // 성과1-3
                    i==30 || // 성과1-4
                    i==31 || // 성과1-5
                    i==33 || // 고과총점
                    i==34 || // 성과2-1
                    i==35 || // 성과2-2
                    i==36 || // 성과2-3
                    i==37 || // 성과2-4
                    i==38 || // 성과2-5

  		 		    i==41 || // 교육1년도
  		 		    i==42 || // 교육1코드
  		 		    i==43 || // 교육1코드명
  		 		    i==44 || // 교육2년도
  		 		    i==45 || // 교육2코드
  		 		    i==46 || // 교육2코드명
  		 		    i==47 || // 교육3년도
  		 		    i==48 || // 교육3코드
  		 		    i==49 || // 교육3코드명

  		 		    i==51 || // 무결
  		 		    i==52 || // 지각

  		 		    i==54 || // 상벌1년도
  		 		    i==55 || // 상벌1비고
  		 		    i==56 || // 상벌2년도
  		 		    i==57 || // 상벌2비고
  		 		    i==58 || // 상벌3년도
  		 		    i==59 || // 상벌3비고

  		 		    i==61 || // 시험1년도
  		 		    i==62 || // 시험1비고
  		 		    i==63 || // 시험1점수
  		 		    i==64 || // 시험2년도
  		 		    i==65 || // 시험2비고
  		 		    i==66 || // 시험2점수
  		 		    i==67 || // 시험3년도
  		 		    i==68 || // 시험3비고
  		 		    i==69 || // 시험3점수

  		 		    i==71 || // 1차 추천인 사번
  		 		    i==72 || // 1차 추천인 성명
  		 		    i==73 || // 2차 추천인 사번
  		 		    i==74 || // 2차 추천인 성명
  		 		    i==75 || // 추천점수
  		 		    i==76    // 총점
  		 		  ) continue;

  				document.form1.elements[i].readOnly = false;
	  			document.form1.elements[i].className = "";
  			}
  			document.form1.rdoEST_CD[0].disabled  = false;   // 승진여부 radioButton
  			document.form1.rdoEST_CD[1].disabled  = false;   // 승진여부 radioButton
  			form1.grdT_PM_PROMOTION.ColumnProp("EST_CD_CK","edit")  = "";
  			form1.grdT_PM_PROMOTION.ColumnProp("EST_CD_CK","HeadCheckEnable") = "true";
  		}

        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput(){
  		 	for(var i=17; i<81; i++){
  				document.form1.elements[i].readOnly = true;
	  			document.form1.elements[i].className = "input_ReadOnly";
  			}
  			document.form1.rdoEST_CD[0].disabled  = true;   // 승진여부 radioButton
  			document.form1.rdoEST_CD[1].disabled  = true;   // 승진여부 radioButton
  			form1.grdT_PM_PROMOTION.ColumnProp("EST_CD_CK","edit")  = "none";
  			form1.grdT_PM_PROMOTION.ColumnProp("EST_CD_CK","HeadCheckEnable") = "false";
  		}

  		/********************************************
         * 그리드 클릭시 라디오버튼 매핑 	        		*
         ********************************************/
  		function checkPmtStatus(row){
  			var EST_CD = dsT_PM_PROMOTION.NameValue(row, "EST_CD");
  			if(EST_CD == "Y"){
  				document.form1.rdoEST_CD[0].checked = true;
  			}else{
  				document.form1.rdoEST_CD[1].checked = true;
  			}
  		}

  		/********************************************
         * 승진여부 체크박스(on Grid) 체크여부결정       		*
         ********************************************/
  		function fnc_chgEST_CD(){
  			if( document.form1.rdoEST_CD[0].checked ){
	  			dsT_PM_PROMOTION.NameValue(dsT_PM_PROMOTION.RowPosition,'EST_CD') = 'Y';
  				dsT_PM_PROMOTION.NameValue(dsT_PM_PROMOTION.RowPosition,'EST_CD_CK') = 'T';
  			}else{
	  			dsT_PM_PROMOTION.NameValue(dsT_PM_PROMOTION.RowPosition,'EST_CD') = 'N';
  				dsT_PM_PROMOTION.NameValue(dsT_PM_PROMOTION.RowPosition,'EST_CD_CK') = 'F';
  			}
  		}

  		/********************************************
         * 추천자 존재 여부조회  					   		*
         ********************************************/
  		function fnc_SearchRecommander(row){
	  		document.form1.txtPENO_NO.value = "";
  			document.form1.txtPENO_NM.value = "";
	  		document.form1.txtPENO_NO2.value = "";
  			document.form1.txtPENO_NM2.value = "";
  			document.form1.txtPMT_LBL_CNT.value = "";

  			var ENO_NO = dsT_PM_PROMOTION.NameValue(row, "ENO_NO");
			var PMT_YY = dsT_PM_PROMOTION.NameValue(row, "PMT_YY");

			if( PMT_YY == "" ){
				alert("승진년도를 입력하십시오. 예)"+next_yy);
				return;
			}

			dsT_PM_RECOMMAND.dataid = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa010.cmd.PROA010CMD&S_MODE=SHR_01&ENO_NO="+ENO_NO+"&PMT_YY="+PMT_YY;
			dsT_PM_RECOMMAND.reset();
  		}

        /**
         * 승진사항관리 완료 처리
         */
        function fnc_Complete() {
            var PMT_YY_SHR  = document.form1.txtPMT_YY_SHR.value;

            if(dsT_CP_WORKLOG.CountRow == 1) {
                if(parseInt(dsT_CP_WORKLOG.NameValue(1, "PRO_STS")) > 2) {
                    alert("이미 승진사항관리 처리가 되었습니다.");
                    return;
                }
            } else {
                alert("승진사항관리 처리를 할 수 없습니다.");
                return;
            }

            if (dsT_PM_PROMOTION.isUpdated ) {
                alert("수정된 데이터가 있습니다. 먼저 저장부터 해주세요.");
                return false;
            }

            if(!confirm("승진사항관리 처리를 하시겠습니까?")){
                return false;
            }

            dsT_CP_WORKLOG_SAV.dataid = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa010.cmd.PROA010CMD&S_MODE=SAV_COM&PMT_YY_SHR="+PMT_YY_SHR;
            dsT_CP_WORKLOG_SAV.reset();
        }

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_PM_PROMOTION)		 	   |
    | 3. 사용되는 Table List(T_PM_PROMOTION) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_PM_PROMOTION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_PM_RECOMMAND" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_WORKLOG_SAV" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_PM_PROMOTION)			   |
    | 3. 사용되는 Table List(T_PM_PROMOTION)				   |
    +------------------------------------------------------>
	<Object ID="trT_PM_PROMOTION_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

	<Object ID="trT_PM_PROMOTION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_PM_PROMOTION Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_PM_PROMOTION.CountRow);
        }
    </Script>

	<Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">
		if(dsT_CP_WORKLOG.CountRow == 1){ // 저장
			if(dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "1") {
                disableInput();
                alert("사원별추천자관리가 완료되지 않았습니다.");
            } else if(dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "2") {
                enableInput();
            } else if(dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "3") {
                disableInput();
                alert("이미 승진사항관리 처리가 되었습니다.");
            }
		}else{
            disableInput();
			alert("승진대상자선정이 완료되지 않았습니다.");
		}
    </Script>

	<Script For=dsT_CP_WORKLOG_SAV Event="OnLoadCompleted(iCount)">
        alert("승진사항관리 처리가 되었습니다.");
        disableInput();
        dsT_CP_WORKLOG.NameValue(1, "PRO_STS") = "3";
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_PM_RECOMMAND Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

        } else {
            document.form1.txtPENO_NO.value = dsT_PM_RECOMMAND.NameValue(1, "PENO_NO");
            document.form1.txtPENO_NM.value = dsT_PM_RECOMMAND.NameValue(1, "PENO_NM");
            document.form1.txtPENO_NO2.value = dsT_PM_RECOMMAND.NameValue(1, "PENO_NO2");
            document.form1.txtPENO_NM2.value = dsT_PM_RECOMMAND.NameValue(1, "PENO_NM2");
            document.form1.txtPMT_LBL_CNT.value = dsT_PM_RECOMMAND.NameValue(1, "PMT_LBL_CNT");

        }

    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_PM_PROMOTION Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>
	<Script For=dsT_CP_WORKLOG Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>
	<Script For=dsT_CP_WORKLOG_SAV Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_PM_PROMOTION Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_CP_WORKLOG Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_CP_WORKLOG_SAV Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_PM_PROMOTION event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_PM_PROMOTION event="OnFail()">
        alert(trT_PM_PROMOTION.ErrorMsg);
    </script>

    <script language=JavaScript for=dsT_PM_PROMOTION event=OnRowPosChanged(row)>

		checkPmtStatus(row);//라디오버튼
		fnc_SearchRecommander(row);//추천자 조회

	</script>

    <script language="javascript"  for=grdT_PM_PROMOTION event=OnClick(row,colid)>

        if(colid == "EST_CD_CK" && row != "0"){
            if(dsT_PM_PROMOTION.NameValue(row,colid) == "T"){
                dsT_PM_PROMOTION.NameValue(row,"EST_CD") = "Y";
            }else{
                dsT_PM_PROMOTION.NameValue(row,"EST_CD") = "N";
            }

            checkPmtStatus(row);//라디오버튼
        }

    </script>

    <script language="javascript" for=grdT_PM_PROMOTION event=OnHeadCheckClick(Col,Colid,bCheck)>

        for(var i=1; i<=dsT_PM_PROMOTION.CountRow; i++) {
            if(bCheck == "1" || bCheck == "T"){
                dsT_PM_PROMOTION.NameValue(i, "EST_CD") = "Y";
                dsT_PM_PROMOTION.NameValue(i, "EST_CD_CK") = "T";

            }else{
                dsT_PM_PROMOTION.NameValue(i, "EST_CD") = "N";
                dsT_PM_PROMOTION.NameValue(i, "EST_CD_CK") = "F";
            }
        }

        checkPmtStatus(dsT_PM_PROMOTION.RowPosition);//라디오버튼

    </script>

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">승진사항관리</td>
					<td align="right" class="navigator">HOME/인사관리/승진/<font color="#000000">승진사항관리</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="80"></col>
							<col width="80"></col>
							<col width="80"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<td align="right" class="searchState">승진년도&nbsp;</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtPMT_YY_SHR" name="txtPMT_YY_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPMT_YY_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgPMT_YY_SHR" name="imgPMT_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPMT_YY_SHR','','102','108');"></a>
							</td>
							<td align="right" class="searchState">사번&nbsp;</td>
							<td class="padding2423" align="left">
	                            <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');">
	                            <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');">
	                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');"></a>
	                            <input type="hidden" id="hidEMPL_DPT_CD">
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
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<tr>
                    <td colspan="10">
    					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="paddingTop8">
                                    <img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle">
                                    <strong>인사정보</strong>
                                </td>
                            </tr>
                        </table>
                    </td>
				</tr>
				<tr>
					<td>
					<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
						<colgroup>
							<col width="60"></col>
							<col width="80"></col>
							<col width="60"></col>
							<col width="105"></col>
							<col width="60"></col>
							<col width="105"></col>
							<col width="60"></col>
							<col width="80"></col>
							<col width="60"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<td align="center" class="creamBold">사번</td>
							<td class="padding2423" align="left">
								<input id="txtENO_NO" size="11" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">성명</td>
							<td class="padding2423" align="left">
								<input id="txtENO_NM" size="15" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">근로구분</td>
							<td class="padding2423" align="left">
								<input type="hidden" id="hidOCC_CD">
								<input id="txtOCC_NM" size="15" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">현재직위</td>
							<td class="padding2423" align="left">
								<input type="hidden" id="hidJOB_CD">
								<input id="txtJOB_NM" size="11" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">입사일자</td>
							<td class="padding2423" align="left">
								<input id="txtHIR_YMD" size="11" class="input_ReadOnly" readonly>
							</td>
						</tr>
						<tr>
                            <td align="center" class="creamBold">퇴직일자</td>
                            <td class="padding2423" align="left">
                                <input id="txtRET_YMD" size="11" class="input_ReadOnly" readonly>
                            </td>
							<td align="center" class="creamBold">부문</td>
							<td class="padding2423" align="left">
								<input id="txtHEAD_NM" size="15" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">소속</td>
							<td class="padding2423" align="left">
								<input type="hidden" id="hidDPT_CD">
								<input id="txtDPT_NM" size="15" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">생년월일</td>
							<td class="padding2423" align="left">
								<input id="txtBIR_YMD" size="11" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">승진일자</td>
							<td class="padding2423" align="left">
								<input id="txtJPR_YMD" size="11" class="input_ReadOnly" readonly>
							</td>
						</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td class="paddingTop8" colspan="10">
					   <img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle">
					   <strong>고과사항</strong>
					</td>
				</tr>
				<tr>
					<td colspan="10">
					<table width="100%" border="1" cellspacing="2" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
					<tr>
						<td>
						<table align="center" width="98%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
						<colgroup>
							<col width="60"></col>
							<col width="90"></col>
							<col width="50"></col>
							<col width="90"></col>
							<col width="50"></col>
							<col width="90"></col>
							<col width="50"></col>
							<col width="90"></col>
							<col width="50"></col>
							<col width="80"></col>
                            <col width="65"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<td>&nbsp;&nbsp;<input id="txtGOG_YY5" size="4" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"> : </td>
							<td>역량&nbsp;&nbsp;<input id="txtGOG_Y51" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td><input id="txtGOG_YY4" size="4" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"> : </td>
							<td>역량&nbsp;&nbsp;<input id="txtGOG_Y41" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td><input id="txtGOG_YY3" size="4" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"> : </td>
							<td>역량&nbsp;&nbsp;<input id="txtGOG_Y31" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td><input id="txtGOG_YY2" size="4" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"> : </td>
							<td>역량&nbsp;&nbsp;<input id="txtGOG_Y21" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td><input id="txtGOG_YY1" size="4" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"> : </td>
							<td>역량&nbsp;&nbsp;<input id="txtGOG_Y11" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
                            <td>고과배점</td>
							<td>고과총점</td>
						</tr>
						<tr>
							<td>&nbsp;&nbsp;&nbsp;년도</td>
							<td>성과1 <input id="txtGOG_Y52" size="2   " maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;년도</td>
							<td>성과1 <input id="txtGOG_Y42" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;년도</td>
							<td>성과1 <input id="txtGOG_Y32" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;년도</td>
							<td>성과1 <input id="txtGOG_Y22" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;년도</td>
							<td>성과1 <input id="txtGOG_Y12" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
                            <td>&nbsp;<input id="txtGOG_GAV" size="5" maxLength="5" style="ime-mode:disabled" onKeypress="cfNumberCheck();" onblur="setTotal();" >&nbsp;</td>
							<td>&nbsp;<input id="txtGOG_TOT" size="5" maxLength="5" style="ime-mode:disabled" onKeypress="cfNumberCheck();">&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>성과2 <input id="txtGOG_Y53" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;</td>
							<td>성과2 <input id="txtGOG_Y43" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;</td>
							<td>성과2 <input id="txtGOG_Y33" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;</td>
							<td>성과2 <input id="txtGOG_Y23" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;</td>
							<td>성과2 <input id="txtGOG_Y13" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
                            <td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</table>
						</td>
						</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td colspan="10" class="paddingTop5">
					<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
						<colgroup>
							<col width="60"></col>
							<col width="30"></col>
							<col width="60"></col>
							<col width="165"></col>
							<col width="60"></col>
							<col width="165"></col>
							<col width="60"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<td align="center" class="creamBold">근속기간</td>
							<td class="padding2423" align="left" colspan="10">
                                <input id="txtGOG_HTT" size="3" maxLength="3" style="ime-mode:disabled" value="0" onblur="setTotal();">
							</td>
						</tr>
						<tr>
							<td align="center" class="creamBold">교육사항</td>
							<td class="padding2423" align="left">
                                <input id="txtEDU_SCR" size="3" maxLength="3" style="ime-mode:disabled" value="0" onblur="setTotal();">
                            </td>
							<td align="center" class="creamBold">교육1</td>
							<td class="padding2423" align="left">
                                <input id="txtEDU_YY1" size="4" maxLength="4" style="ime-mode:disabled" class="input_ReadOnly" readonly>년도 <input id="txtEDU_KN1" size="2" class="input_ReadOnly" readonly> <input id="txtEDU_KN1_NM" size="9" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">교육2</td>
							<td class="padding2423" align="left">
                                <input id="txtEDU_YY2" size="4" maxLength="4" style="ime-mode:disabled" class="input_ReadOnly" readonly>년도 <input id="txtEDU_KN2" size="2" class="input_ReadOnly" readonly> <input id="txtEDU_KN2_NM" size="9" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">교육3</td>
							<td class="padding2423" align="left">
                                <input id="txtEDU_YY3" size="4" maxLength="4" style="ime-mode:disabled" class="input_ReadOnly" readonly>년도 <input id="txtEDU_KN3" size="2" class="input_ReadOnly" readonly> <input id="txtEDU_KN3_NM" size="9" class="input_ReadOnly" readonly>
							</td>
						</tr>
						<tr>
							<td align="center" class="creamBold">근태사항</td>
							<td class="padding2423" align="left">
                                <input id="txtGUN_GTT" size="3" maxLength="3" style="ime-mode:disabled" value="0" onblur="setTotal();"></td>
							<td align="center" class="creamBold">무결</td>
							<td class="padding2423" align="left">
                                <input id="txtGUN_GTB" size="3" maxLength="3" value="0" class="input_ReadOnly" readonly>
                            </td>
							<td align="center" class="creamBold">지각</td>
							<td class="padding2423" align="left" colspan="5">
                                <input id="txtGUN_GTC" size="3" maxLength="3" value="0" class="input_ReadOnly" readonly>
                            </td>
						</tr>
                    </table>

                    <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                        <colgroup>
                            <col width="60"></col>
                            <col width="30"></col>
                            <col width="60"></col>
                            <col width="165"></col>
                            <col width="60"></col>
                            <col width="165"></col>
                            <col width="60"></col>
                            <col width=""></col>
                        </colgroup>
						<tr>
                            <td align="center" class="creamBold">상벌사항</td>
                            <td class="padding2423" align="left">
                                <input id="txtSAN_SCR" size="3" maxLength="3" style="ime-mode:disabled" value="0" onblur="setTotal();">
                            </td>
                            <td align="center" class="creamBold">상벌1</td>
                            <td class="padding2423" align="left">
                                <input id="txtSAN_YY1" size="4" maxLength="4" style="ime-mode:disabled" class="input_ReadOnly" readonly>년도 <input id="txtSAN_RM1" size="14" class="input_ReadOnly" readonly>
                            </td>
                            <td align="center" class="creamBold">상벌2</td>
                            <td class="padding2423" align="left">
                                <input id="txtSAN_YY2" size="4" maxLength="4" style="ime-mode:disabled" class="input_ReadOnly" readonly>년도 <input id="txtSAN_RM2" size="14" class="input_ReadOnly" readonly>
                            </td>
                            <td align="center" class="creamBold">상벌3</td>
                            <td class="padding2423" align="left">
                                <input id="txtSAN_YY3" size="4" maxLength="4" style="ime-mode:disabled" class="input_ReadOnly" readonly>년도 <input id="txtSAN_RM3" size="14" class="input_ReadOnly" readonly>
                            </td>
						</tr>
                    </table>

                    <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <colgroup>
                            <col width="60"></col>
                            <col width="30"></col>
                            <col width="60"></col>
                            <col width="165"></col>
                            <col width="60"></col>
                            <col width="165"></col>
                            <col width="60"></col>
                            <col width=""></col>
                        </colgroup>
						<tr>
							<td align="center" class="creamBold">시험사항</td>
							<td class="padding2423" align="left">
                                <input id="txtEXM_TIC" size="3" style="ime-mode:disabled" value="0" maxLength="3">
                            </td>
							<td align="center" class="creamBold">시험1</td>
							<td class="padding2423" align="left">
                                <input id="txtEXM_YY1" size="4" maxLength="4" style="ime-mode:disabled" class="input_ReadOnly" readonly>년도 <input id="txtEXM_SC1" size="7" class="input_ReadOnly" readonly> <input id="txtEXM_PNT1" size="3" class="input_ReadOnly" readonly>점
                            </td>
							<td align="center" class="creamBold">시험2</td>
							<td class="padding2423" align="left">
                                <input id="txtEXM_YY2" size="4" maxLength="4" style="ime-mode:disabled" class="input_ReadOnly" readonly>년도 <input id="txtEXM_SC2" size="7" class="input_ReadOnly" readonly> <input id="txtEXM_PNT2" size="3" class="input_ReadOnly" readonly>점
                            </td>
							<td align="center" class="creamBold">시험3</td>
							<td class="padding2423" align="left">
                                <input id="txtEXM_YY3" size="4" maxLength="4" style="ime-mode:disabled" class="input_ReadOnly" readonly>년도 <input id="txtEXM_SC3" size="7" class="input_ReadOnly" readonly> <input id="txtEXM_PNT3" size="3" class="input_ReadOnly" readonly>점
                            </td>
						</tr>
						<tr>
							<td align="center" class="creamBold">추천사항</td>
							<td class="padding2423" align="left">
                                <input id="txtCEN_SCR" size="3" maxLength="3" value="0" onblur="setTotal();">
                            </td>
							<td align="center" class="creamBold">1차추천자</td>
							<td class="padding2423" align="left">
								<input id="txtPENO_NO" size="9"  maxlength="10" class="input_ReadOnly" readonly>
								<input id="txtPENO_NM" size="13" style="text-align:center" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">2차추천자</td>
							<td class="padding2423" align="left">
								<input id="txtPENO_NO2" size="9"  maxlength="10" class="input_ReadOnly" readonly>
								<input id="txtPENO_NM2" size="13" style="text-align:center" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">추천점수</td>
							<td class="padding2423" align="left">
								<input id="txtPMT_LBL_CNT" size="3" class="input_ReadOnly" readonly>
							</td>
						</tr>
                    </table>
                </tr>
                <tr>
                    <td colspan="10" class="paddingTop5">
                    <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <colgroup>
                            <col width="60"></col>
                            <col width="30"></col>
                            <col width="60"></col>
                            <col width="165"></col>
                            <col width="60"></col>
                            <col width=""></col>
                        </colgroup>
						<tr>
							<td align="center" class="creamBold">총점</td>
							<td class="padding2423" align="left">
                                <input id="txtSPC_TOT" size="3" maxLength="3" value="0" class="input_ReadOnly" readonly>
                            </td>
							<td align="center" class="creamBold">승진여부</td>
							<td class="padding2423" align="left">
								<input type="radio" name="rdoEST_CD" id="rdoEST_CD" checked style="margin-bottom:-2px;border:0;background-color:#ffffff;" onClick="fnc_chgEST_CD()">승진
								&nbsp;&nbsp;
								<input type="radio" name="rdoEST_CD" id="rdoEST_CD" style="margin-bottom:-2px;border:0;background-color:#ffffff;" onClick="fnc_chgEST_CD()">미승진
							</td>
							<td align="center" class="creamBold">비고</td>
							<td class="padding2423" align="left"><input id="txtREMARK" size="63" maxLength="22"></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->

	<!-- 조회 상태 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop5">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
						<td class="searchState" align="right">
	                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)">  <img src="/images/button/btn_ConductOn.gif"   name="imgConduct" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Complete()"></a>
	                    </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- 조회 상태 테이블 끝 -->

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_PM_PROMOTION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:200px;">
						<param name="DataID" value="dsT_PM_PROMOTION">
						<param name="Editable" value="false">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id={currow}     width=29    name="NO"               align=center    Edit=none       </C>
                            <C> id="PMT_GBN"    width=40    name="구분"             align=center    Edit=none   value={decode(PMT_GBN, 1, "정기", 2, "특별")}</C>
                            <C> id="OCC_NM"     width=40    name="근로구분"             align=center    Edit=none                                     </C>
                            <C> id="DPT_NM"     width=105   name="소속"             align=center    Edit=none                                     </C>
                            <C> id="JOB_NM"     width=50    name="직위"             align=center    Edit=none                                     </C>
                            <C> id="ENO_NO"     width=70    name="사번"             align=center    Edit=none                                     </C>
                            <C> id="ENO_NM"     width=70    name="성명"             align=center    Edit=none                                     </C>
                            <C> id="BIR_YMD"    width=70    name="생년월일"         align=center    Edit=none                         show="false"</C>
                            <C> id="HIR_YMD"    width=70    name="입사일"           align=center    Edit=none                         show="false"</C>
                            <C> id="HIRG_YMD"   width=70    name="그룹;입사일"      align=center    Edit=none                                     </C>
                            <C> id="JPR_YMD"    width=70    name="현직;승진일"      align=center    Edit=none                                     </C>
                            <C> id="JPR_CON"    width=60    name="현직;재직기간"    align=center    Edit=none                                     </C>
                            <C> id="HIR_CON"    width=60    name="근속기간"         align=center    Edit=none                                     </C>
                            <C> id="REMARK"     width=120   name="비고"             align=left      Edit=none                         show="false"</C>
                            <C> id="SPC_TOT"    width=50    name="총점"             align=center    Edit=none                                     </C>
                            <C> id="EST_CD"     width="50"  name="승진;여부"        align=center    Edit=none   EditStyle=CheckBox    show="false"</C>
                            <C> id="EST_CD_CK"  width="50"  name="승진;여부"        align=center    Edit={Decode(EST_CD,"Y","T","F")}   EditStyle=CheckBox HeadCheckShow=true</C>
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

	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																		 *
    *                                       												 *
    ***************************************************************************************-->
	<!-- T_WL_DININGUSE 설정 테이블 -->
	<object id="bndT_PM_PROMOTION" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_PM_PROMOTION">
		<Param Name="BindInfo", Value="
			<C>Col=ENO_NO		Ctrl=txtENO_NO	    Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM    	Param=value</C>
			<C>Col=HEAD_NM		Ctrl=txtHEAD_NM		Param=value</C>
			<C>Col=OCC_CD		Ctrl=hidOCC_CD		Param=value</C>
			<C>Col=OCC_NM		Ctrl=txtOCC_NM		Param=value</C>
			<C>Col=DPT_CD		Ctrl=hidDPT_CD		Param=value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=JOB_CD		Ctrl=hidJOB_CD		Param=value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=PR_SEQ		Ctrl=hidPR_SEQ		Param=value</C>

			<C>Col=BIR_YMD		Ctrl=txtBIR_YMD		Param=value</C>
			<C>Col=HIR_YMD		Ctrl=txtHIR_YMD		Param=value</C>
			<C>Col=HIRG_YMD		Ctrl=txtHIRG_YMD	Param=value</C>

			<C>Col=JPR_YMD		Ctrl=txtJPR_YMD		Param=value</C>
			<C>Col=GOG_YY5		Ctrl=txtGOG_YY5		Param=value</C>
			<C>Col=GOG_Y51		Ctrl=txtGOG_Y51		Param=value</C>
			<C>Col=GOG_Y52		Ctrl=txtGOG_Y52		Param=value</C>
			<C>Col=GOG_Y53		Ctrl=txtGOG_Y53		Param=value</C>
			<C>Col=GOG_YY4		Ctrl=txtGOG_YY4		Param=value</C>
			<C>Col=GOG_Y41		Ctrl=txtGOG_Y41		Param=value</C>
			<C>Col=GOG_Y42		Ctrl=txtGOG_Y42		Param=value</C>
			<C>Col=GOG_Y43		Ctrl=txtGOG_Y43		Param=value</C>

			<C>Col=GOG_YY3		Ctrl=txtGOG_YY3		Param=value</C>
			<C>Col=GOG_Y31		Ctrl=txtGOG_Y31		Param=value</C>
			<C>Col=GOG_Y32		Ctrl=txtGOG_Y32		Param=value</C>
			<C>Col=GOG_Y33		Ctrl=txtGOG_Y33		Param=value</C>
			<C>Col=GOG_YY2		Ctrl=txtGOG_YY2		Param=value</C>
			<C>Col=GOG_Y21		Ctrl=txtGOG_Y21		Param=value</C>
			<C>Col=GOG_Y22		Ctrl=txtGOG_Y22		Param=value</C>
			<C>Col=GOG_Y23		Ctrl=txtGOG_Y23		Param=value</C>
			<C>Col=GOG_YY1		Ctrl=txtGOG_YY1		Param=value</C>
			<C>Col=GOG_Y11		Ctrl=txtGOG_Y11		Param=value</C>
			<C>Col=GOG_Y12		Ctrl=txtGOG_Y12		Param=value</C>
			<C>Col=GOG_Y13		Ctrl=txtGOG_Y13		Param=value</C>
			<C>Col=GOG_CNT		Ctrl=txtGOG_CNT		Param=value</C>

			<C>Col=GOG_TOT		Ctrl=txtGOG_TOT		Param=value</C>
			<C>Col=GOG_GAV		Ctrl=txtGOG_GAV		Param=value</C>
			<C>Col=GOG_HTT		Ctrl=txtGOG_HTT		Param=value</C>
			<C>Col=GUN_GTB		Ctrl=txtGUN_GTB		Param=value</C>
			<C>Col=GUN_GTC		Ctrl=txtGUN_GTC		Param=value</C>
			<C>Col=GUN_GTT		Ctrl=txtGUN_GTT		Param=value</C>

			<C>Col=EDU_YY1		Ctrl=txtEDU_YY1		Param=value</C>
			<C>Col=EDU_KN1		Ctrl=txtEDU_KN1		Param=value</C>
			<C>Col=EDU_KN1_NM	Ctrl=txtEDU_KN1_NM	Param=value</C>
			<C>Col=EDU_YY2		Ctrl=txtEDU_YY2		Param=value</C>
			<C>Col=EDU_KN2		Ctrl=txtEDU_KN2		Param=value</C>
			<C>Col=EDU_KN2_NM	Ctrl=txtEDU_KN2_NM	Param=value</C>
			<C>Col=EDU_YY3		Ctrl=txtEDU_YY3		Param=value</C>
			<C>Col=EDU_KN3		Ctrl=txtEDU_KN3		Param=value</C>
			<C>Col=EDU_KN3_NM	Ctrl=txtEDU_KN3_NM	Param=value</C>
			<C>Col=EDU_SCR		Ctrl=txtEDU_SCR		Param=value</C>

			<C>Col=SAN_YY1		Ctrl=txtSAN_YY1		Param=value</C>
			<C>Col=SAN_RM1		Ctrl=txtSAN_RM1		Param=value</C>
			<C>Col=SAN_YY2		Ctrl=txtSAN_YY2		Param=value</C>
			<C>Col=SAN_RM2		Ctrl=txtSAN_RM2		Param=value</C>
			<C>Col=SAN_YY3		Ctrl=txtSAN_YY3		Param=value</C>
			<C>Col=SAN_RM3		Ctrl=txtSAN_RM3		Param=value</C>
			<C>Col=SAN_SCR		Ctrl=txtSAN_SCR		Param=value</C>

			<C>Col=CEN_SCR		Ctrl=txtCEN_SCR		Param=value</C>

			<C>Col=EXM_YY1		Ctrl=txtEXM_YY1		Param=value</C>
            <C>Col=EXM_SC1      Ctrl=txtEXM_SC1     Param=value</C>
			<C>Col=EXM_PNT1     Ctrl=txtEXM_PNT1	Param=value</C>
			<C>Col=EXM_YY2		Ctrl=txtEXM_YY2		Param=value</C>
            <C>Col=EXM_SC2      Ctrl=txtEXM_SC2     Param=value</C>
			<C>Col=EXM_PNT2     Ctrl=txtEXM_PNT2	Param=value</C>
			<C>Col=EXM_YY3		Ctrl=txtEXM_YY3		Param=value</C>
            <C>Col=EXM_SC3      Ctrl=txtEXM_SC3     Param=value</C>
			<C>Col=EXM_PNT3     Ctrl=txtEXM_PNT3	Param=value</C>
			<C>Col=EXM_TIC		Ctrl=txtEXM_TIC		Param=value</C>

			<C>Col=SPC_TOT		Ctrl=txtSPC_TOT		Param=value</C>
			<C>Col=EXP_CD		Ctrl=txtEXP_CD		Param=value</C>
			<C>Col=EST_CD		Ctrl=txtEST_CD		Param=value</C>
			<C>Col=REMARK		Ctrl=txtREMARK		Param=value</C>

			<C>Col=EXM_CMP		Ctrl=txtEXM_CMP		Param=value</C>

		">
	</object>