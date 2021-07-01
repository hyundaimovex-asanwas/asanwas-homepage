<!--
    ******************************************************************
    * @Source              : coda010.jsp                                                                       *
    * @Description        : 회사정보입력                                                                                          *
    * @Font                   :                                                                                      *
    * @Developer Desc :                                                                                          *
    *******************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                               *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            이동훈            	ERP 이사															   *
    *******************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>

<jsp:include page="/Ehr/common/include/head.jsp"/>

<title>회사정보입력</title>
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

  

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

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
        	
			if(fnc_SaveItemCheck()) {
				
				trT_CM_COMPANY.KeyValue = "SVL(I:dsT_CM_COMPANY=dsT_CM_COMPANY)";
				trT_CM_COMPANY.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.a.coda010.cmd.CODA010CMD&S_MODE=SAV";
				trT_CM_COMPANY.post();
				
			} else {
				return;
			}
			
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

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

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
	        if (dsT_CM_COMPANY.IsUpdated)  {
	            if (!fnc_ExitQuestion()) return;
	        }

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
        	
   			var f = document.form1;

			//DataSet의 변경 여부 확인
			if (!dsT_CM_COMPANY.IsUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
		    	return false;
			}

			var i = 1;//row는 하나뿐이다.
			var oGUBUN, oGUBUN_NM, oCOMP_NM, oPRESIDENT_NM, oTAX_NO, oCORP_NO, oCAPITAL_TOT, oSTR_YMD, oACC_STDT, oACC_ENDT, oPAY_DAY;

			oGUBUN = dsT_CM_COMPANY.NameValue(i,"GUBUN");
			if(oGUBUN.trim() == ""){
				alert("회계단위를 입력해주세요." );
				document.getElementById("txtGUBUN").focus();
				return false;
			}

			oGUBUN_NM = dsT_CM_COMPANY.NameValue(i,"GUBUN_NM");
			if(oGUBUN_NM.trim() == ""){
				alert("회계단위명을 입력해주세요." );
				document.getElementById("txtGUBUN_NM").focus();
				return false;
			}

			oCOMP_NM = dsT_CM_COMPANY.NameValue(i,"COMP_NM");
			if(oCOMP_NM.trim() == ""){
				alert("회사명을 입력해주세요." );
				document.getElementById("txtCOMP_NM").focus();
				return false;
			}

			oPRESIDENT_NM = dsT_CM_COMPANY.NameValue(i,"PRESIDENT_NM");
			if(oPRESIDENT_NM.trim() == ""){
				alert("대표자명을 입력해주세요." );
				document.getElementById("txtPRESIDENT_NM").focus();
				return false;
			}

			oTAX_NO = dsT_CM_COMPANY.NameValue(i,"TAX_NO");
			if(oTAX_NO.trim().length != 10){
				alert("사업자번호를 형식(XXX-XX-XXXXX)에 맞게 입력해주세요." );
				document.medTAX_NO.Focus();
				return false;
			}

			oCORP_NO = dsT_CM_COMPANY.NameValue(i,"CORP_NO");
			if(oCORP_NO.trim().length != 13){
				alert("법인등록번호를 형식(XXXXXX-XXXXXXX)에 맞게 입력해주세요." );
				document.medCORP_NO.Focus();
				return false;
			}

			oCAPITAL_TOT = dsT_CM_COMPANY.NameValue(i,"CAPITAL_TOT");
			if(oCAPITAL_TOT.toString().trim().length == 0 || oCAPITAL_TOT == 0){
				alert("자본총계를 입력해주세요." );
				document.getElementById("txtCAPITAL_TOT").focus();
				return false;
			}

			oSTR_YMD = dsT_CM_COMPANY.NameValue(i,"STR_YMD");
			if(!cfDateExpr(oSTR_YMD) && oSTR_YMD.trim().length != 0){
				alert("회사설립일이  잘못되었습니다." );
				document.getElementById("txtSTR_YMD").focus();
				return false;
			}

			oACC_STDT = dsT_CM_COMPANY.NameValue(i,"ACC_STDT");
			if(!cfDateExpr(oACC_STDT) && oACC_STDT.trim().length != 0){
				alert("회계기간시작일이 잘못되었습니다." );
				document.getElementById("txtACC_STDT").focus();
				return false;
			}

			oACC_ENDT = dsT_CM_COMPANY.NameValue(i,"ACC_ENDT");
			if(!cfDateExpr(oACC_ENDT) && oACC_ENDT.trim().length != 0){
				alert("회계기간종료일이 잘못되었습니다." );
				document.getElementById("txtACC_ENDT").focus();
				return false;
			}

			oACC_STDT = parseInt(oACC_STDT.replaceStr("-",""));
			oACC_ENDT = parseInt(oACC_ENDT.replaceStr("-",""));
			if(oACC_STDT > oACC_ENDT){
				alert("종료일이 시작일보다 빠릅니다." );
				document.getElementById("txtACC_ENDT").focus();
				return false;
			}

			oPAY_DAY = dsT_CM_COMPANY.NameValue(i,"PAY_DAY");
			if(!(oPAY_DAY > 0 && oPAY_DAY <= 31)){
				alert("급여지급일이 잘못되었습니다." );
				document.getElementById("txtPAY_DAY").focus();
				return false;
			}

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
        	
            //Grid Style 적용
            //cfStyleGrid(form1.grdT_EV_KPIPOOL,15,"false","right");

            //form load시 무조건 본사정보 조회
            var f = document.form1;
            
			//if (!valid(form1)) return;//Validation 수행
			try {
				
				dsT_CM_COMPANY.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.a.coda010.cmd.CODA010CMD&S_MODE=SHR";
				dsT_CM_COMPANY.Reset();

				//현재 값이 없다면 저장하기 위한 row추가
				if(dsT_CM_COMPANY.CountRow == 0){
					dsT_CM_COMPANY.AddRow();
					//신규작성일때 회계구분으로 포커스
           			document.getElementById("txtGUBUN").focus();
				}else{//현재 값이 있다면 들어온다.

				// 전화번호와 팩스번호 "-" 없애달라는 요구사항으로 관련부분 삭제

	            }
			} catch ( exception ) {
				fcWindowsXpSp2Notice(false);
				return;
			}

        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

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
    | 2. 이름 : dsT_CM_COMPANY                                  |
    | 3. Table List : T_CM_COMPANY                                 |
    +----------------------------------------------->
    <Object ID="dsT_CM_COMPANY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_CM_COMPANY                                    |
    | 3. Table List : T_CM_COMPANY                                 |
    +----------------------------------------------->
    <Object ID ="trT_CM_COMPANY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CM_COMPANY Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_CM_COMPANY Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_CM_COMPANY Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_CM_COMPANY event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_CM_COMPANY event="OnFail()">
        cfErrorMsg(this);
    </script>

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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
            <table width="1000" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" bgcolor="">
				<colgroup>
					<col width="100"></col>
					<col width="400"></col>
					<col width="100"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="blueBold">회계단위</td>
					<td class="padding2423"><input id="txtGUBUN" style="width:50" maxlength="2"></td>
					<td align="center" class="blueBold">회계단위명</td>
					<td class="padding2423"><input id="txtGUBUN_NM" style="width:100%" maxlength="100"></td>
				</tr>
				<tr>
					<td align="center" class="blueBold">회사명</td>
					<td class="padding2423"><input id="txtCOMP_NM" style="width:100%" maxlength="100"></td>
					<td align="center" class="blueBold">회사명(영문)</td>
					<td class="padding2423"><input id="txtCOMP_ENM" style="width:100%" maxlength="100"></td>
				</tr>
				<tr>
					<td align="center" class="blueBold">대표자</td>
					<td class="padding2423"><input id="txtPRESIDENT_NM" style="width:100%" maxlength="50"></td>
					<td align="center" class="blueBold">대표자(영문)</td>
					<td class="padding2423"><input id="txtPRESIDENT_ENM" style="width:100%" maxlength="50"></td>
				</tr>
				<tr>
					<td align="center" class="blueBold">사업자번호</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medTAX_NO" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:50%">
							<param name=Alignment					value=0>
							<param name=Border						value=true>
							<param name=ClipMode						value=true>
							<param name=DisabledBackColor			value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=Format						value="000-00-00000">
							<param name=IsComma					value=false>
							<param name=Language					value=0>
							<param name=Numeric						value=false>
							<param name=PromptChar					value=" ">
							<param name=ShowLiteral					value="false">
							<param name=Visible							value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="blueBold">법인등록번호</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medCORP_NO" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:50%">
							<param name=Alignment					value=0>
							<param name=Border						value=true>
							<param name=ClipMode						value=true>
							<param name=DisabledBackColor			value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=Format						value="000000-0000000">
							<param name=IsComma					value=false>
							<param name=Language					value=0>
							<param name=Numeric						value=false>
							<param name=PromptChar					value=" ">
							<param name=ShowLiteral					value="false">
							<param name=Visible							value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
				<tr>
					<td align="center" class="blueBold">업태</td>
					<td class="padding2423"><input id="txtBUSI_COND" style="width:100%" maxlength="50"></td>
					<td align="center" class="blueBold">종목</td>
					<td class="padding2423"><input id="txtBUSI_ITEM" style="width:100%" maxlength="50"></td>
				</tr>
				<tr>
					<td align="center" class="blueBold">주소</td>
					<td class="padding2423" colspan="3">
						<input id="txtPOST_NO" style="width:60" class="input_ReadOnly" readonly maxlength="7">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onClick="fnc_postPopup('txtPOST_NO','txtADDRESS_HD')"></a>
						<input id="txtADDRESS_HD" style="width:281" class="input_ReadOnly" readonly>
						<input id="txtADDRESS_DT" style="width:310" maxlength="100">
					</td>
				</tr>
				<tr>
					<td align="center" class="blueBold">전화번호</td>
					<td class="padding2423"><input id="txtTEL_NO" style="width:100%" maxlength="15"></td>
					<td align="center" class="blueBold">팩스번호</td>
					<td class="padding2423"><input id="txtFAX_NO" style="width:100%" maxlength="15"></td>
				</tr>
				<tr>
					<td align="center" class="blueBold">URL</td>
					<td class="padding2423"><input id="txtCOMP_URL" style="width:100%" maxlength="50"></td>
					<td align="center" class="blueBold">홈택스ID</td>
					<td class="padding2423"><input id="txtHOMETAX_ID" style="width:100%" maxlength="50"></td>
				</tr>
				<tr>
					<td align="center" class="blueBold">법인종류</td>
					<td class="padding2423">
						<select id="cmbCORP_KIND" style="width:100%" >
							<option value="" >선택</option>
							<option value="1" >1.중소기업</option>
							<option value="2" >2.일 반</option>
							<option value="3" >3.상 장</option>
							<option value="4" >4.비상장대기업집단</option>
							<option value="5" >5.공 공</option>
							<option value="6" >6.비영리</option>
							<option value="7" >7.개 인</option>
						</select>
					</td>
					<td align="center" class="blueBold">법인구분</td>
					<td class="padding2423">
						<select id="cmbCORP_GBN" style="width:100%">
							<option value="" >선택</option>
							<option value="1" >1.내국법인</option>
							<option value="2" >2.외국법인</option>
							<option value="3" >3.외투법인</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="center" class="blueBold">소재지구분</td>
					<td class="padding2423">
						<select id="cmbLOCATION_GBN" style="width:100%">
							<option value="" >선택</option>
							<option value="1" >1.특별시</option>
							<option value="2" >2.광역시</option>
							<option value="3" >3.시</option>
							<option value="4" >4.군</option>
						</select>
					</td>
					<td align="center" class="blueBold">관할세무서</td>
					<td class="padding2423">
						<select id="cmbTAX_OFFICE" style="width:100%">
							<option value="" >선택</option>
							<option value="종로" >(101) 종로</option>
							<option value="남대문" >(104) 남대문</option>
							<option value="마포" >(105) 마포</option>
							<option value="용산" >(106) 용산</option>
							<option value="영등포" >(107) 영등포</option>
							<option value="동작" >(108) 동작</option>
							<option value="강서" >(109) 강서</option>
							<option value="서대문" >(110) 서대문</option>
							<option value="구로" >(113) 구로</option>
							<option value="반포" >(114) 반포</option>
							<option value="양천" >(117) 양천</option>
							<option value="금천" >(119) 금천</option>
							<option value="삼성" >(120) 삼성</option>
							<option value="인천" >(121) 인천</option>
							<option value="북인천" >(122) 북인천</option>
							<option value="안양" >(123) 안양</option>
							<option value="수원" >(124) 수원</option>
							<option value="평택" >(125) 평택</option>
							<option value="이천" >(126) 이천</option>
							<option value="의정부" >(127) 의정부</option>
							<option value="고양" >(128) 고양</option>
							<option value="성남" >(129) 성남</option>
							<option value="부천" >(130) 부천</option>
							<option value="남인천" >(131) 남인천</option>
							<option value="남양주" >(132) 남양주</option>
							<option value="안산" >(134) 안산</option>
							<option value="동수원" >(135) 동수원</option>
							<option value="서인천" >(137) 서인천</option>
							<option value="동안양" >(138) 동안양</option>
							<option value="시흥" >(140) 시흥</option>
							<option value="파주" >(141) 파주</option>
							<option value="중부" >(201) 중부</option>
							<option value="동대문" >(204) 동대문</option>
							<option value="성동" >(206) 성동</option>
							<option value="성북" >(209) 성북</option>
							<option value="도봉" >(210) 도봉</option>
							<option value="강남" >(211) 강남</option>
							<option value="강동" >(212) 강동</option>
							<option value="서초" >(214) 서초</option>
							<option value="송파" >(215) 송파</option>
							<option value="노원" >(217) 노원</option>
							<option value="역삼" >(220) 역삼</option>
							<option value="춘천" >(221) 춘천</option>
							<option value="삼척" >(222) 삼척</option>
							<option value="홍천" >(223) 홍천</option>
							<option value="원주" >(224) 원주</option>
							<option value="영월" >(225) 영월</option>
							<option value="강릉" >(226) 강릉</option>
							<option value="속초" >(227) 속초</option>
							<option value="청주" >(301) 청주</option>
							<option value="영동" >(302) 영동</option>
							<option value="충주" >(303) 충주</option>
							<option value="제천" >(304) 제천</option>
							<option value="대전" >(305) 대전</option>
							<option value="공주" >(307) 공주</option>
							<option value="논산" >(308) 논산</option>
							<option value="홍성" >(310) 홍성</option>
							<option value="예산" >(311) 예산</option>
							<option value="천안" >(312) 천안</option>
							<option value="보령" >(313) 보령</option>
							<option value="서대전" >(314) 서대전</option>
							<option value="서산" >(316) 서산</option>
							<option value="군산" >(401) 군산</option>
							<option value="전주" >(402) 전주</option>
							<option value="익산" >(403) 익산</option>
							<option value="정읍" >(404) 정읍</option>
							<option value="남원" >(407) 남원</option>
							<option value="광주" >(408) 광주</option>
							<option value="북광주" >(409) 북광주</option>
							<option value="서광주" >(410) 서광주</option>
							<option value="목포" >(411) 목포</option>
							<option value="나주" >(412) 나주</option>
							<option value="해남" >(415) 해남</option>
							<option value="순천" >(416) 순천</option>
							<option value="여수" >(417) 여수</option>
							<option value="동대구" >(502) 동대구</option>
							<option value="서대구" >(503) 서대구</option>
							<option value="북대구" >(504) 북대구</option>
							<option value="경주" >(505) 경주</option>
							<option value="포항" >(506) 포항</option>
							<option value="영덕" >(507) 영덕</option>
							<option value="안동" >(508) 안동</option>
							<option value="김천" >(510) 김천</option>
							<option value="상주" >(511) 상주</option>
							<option value="영주" >(512) 영주</option>
							<option value="구미" >(513) 구미</option>
							<option value="남대구" >(514) 남대구</option>
							<option value="경산" >(515) 경산</option>
							<option value="중부산" >(602) 중부산</option>
							<option value="서부산" >(603) 서부산</option>
							<option value="부산진" >(605) 부산진</option>
							<option value="북부산" >(606) 북부산</option>
							<option value="동래" >(607) 동래</option>
							<option value="마산" >(608) 마산</option>
							<option value="창원" >(609) 창원</option>
							<option value="울산" >(610) 울산</option>
							<option value="거창" >(611) 거창</option>
							<option value="통영" >(612) 통영</option>
							<option value="진주" >(613) 진주</option>
							<option value="김해" >(615) 김해</option>
							<option value="제주" >(616) 제주</option>
							<option value="수영" >(617) 수영</option>
							<option value="동울산" >(620) 동울산</option>
							<option value="금정" >(621) 금정</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="center" class="blueBold">관할구청</td>
					<td class="padding2423" colspan="3"><input id="txtWARD_OFFICE" style="width:39%" maxlength="100"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
        <td class="paddingTop8">
            <table width="1000" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" bgcolor="">
				<colgroup>
					<col width="100"></col>
					<col width="200"></col>
					<col width="100"></col>
					<col width="120"></col>
					<col width="100"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="blueBold">자본총계</td>
					<td>
						<table width="100%" border="0" >
							<tr>
								<td width="80%">
									<comment id="__NSID__"><object id="medCAPITAL_TOT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
										<param name=Alignment					value=2>
										<param name=Border						value=true>
										<param name=ClipMode						value=true>
										<param name=DisabledBackColor			value="#EEEEEE">
										<param name=Enable						value=true>
										<param name=IsComma					value=true>
										<param name=Language					value=0>
										<param name=MaxLength					value=12>
										<param name=Numeric						value=true>
										<param name=ShowLiteral					value="false">
										<param name=Visible							value="true">
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
								<td align="left">원</td>
							</tr>
						</table>
					</td>
					<td align="center" class="blueBold">종업원수</td>
					<td>
						<table width="100%" border="0" >
							<tr>
								<td width="70%">
									<comment id="__NSID__"><object id="medEMPLOYEE_TOT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
										<param name=Alignment					value=2>
										<param name=Border						value=true>
										<param name=ClipMode						value=true>
										<param name=DisabledBackColor			value="#EEEEEE">
										<param name=Enable						value=true>
										<param name=IsComma					value=true>
										<param name=Language					value=0>
										<param name=MaxLength					value=6>
										<param name=Numeric						value=true>
										<param name=ShowLiteral					value="false">
										<param name=Visible							value="true">
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
								<td align="left">명</td>
							</tr>
						</table>
					</td>
					<td align="center" class="blueBold">회사설립일</td>
					<td class="padding2423">
						<input id="txtSTR_YMD" style="width:70%;padding-left:20" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD','','625','205');"><img src="../../images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle"></a>
					</td>
				</tr>
				<tr>
					<td align="center" class="blueBold">회계기간</td>
					<td class="padding2423" colspan="3">
						<input id="txtACF_QUT" style="width:30;text-align:right" maxlength="2" onkeypress="cfNumberCheck();" style="ime-mode:disabled">&nbsp;기&nbsp;&nbsp;
						<input id="txtACC_STDT" style="width:100;padding-left:20"  maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn3','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtACC_STDT','','150','230');"><img src="../../images/button/btn_HelpOn.gif" name="img_HelpOn3" width="21" height="20" border="0" align="absmiddle"></a>
						&nbsp;~&nbsp;
						<input id="txtACC_ENDT" style="width:100;padding-left:20" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn4','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtACC_ENDT','','305','230');"><img src="../../images/button/btn_HelpOn.gif" name="img_HelpOn4" width="21" height="20" border="0" align="absmiddle"></a>
					</td>
					<td align="center" class="blueBold">급여지급일</td>
					<td class="padding2423">매월&nbsp;<input id="txtPAY_DAY" style="width:30;text-align:right" maxlength="2" onkeypress="cfNumberCheck();" style="ime-mode:disabled">&nbsp;일</td>
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

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


    <!--**************************************************************************************
    *                                                                                                                                                          *
    *  Non Visible Component 선언부(Bind Component)                                                                            				*
    *                                                                                                                                                          *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 저장 및 조회용 Bind                                               |
    | 2. 이름 : bndT_CM_COMPANY                                   |
    | 3. Table List : T_CM_COMPANY                                 |
    +----------------------------------------------->
	<object id="bndT_CM_COMPANY" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   		Value="dsT_CM_COMPANY">
		<Param Name="BindInfo", 		Value="
			<C>Col='GUBUN'						Ctrl='txtGUBUN'					Param=value</C>
			<C>Col='GUBUN_NM'					Ctrl='txtGUBUN_NM'				Param=value</C>
			<C>Col='COMP_NM'					Ctrl='txtCOMP_NM'				Param=value</C>
			<C>Col='COMP_ENM'					Ctrl='txtCOMP_ENM'				Param=value</C>
			<C>Col='PRESIDENT_NM'			Ctrl='txtPRESIDENT_NM'			Param=value</C>
			<C>Col='PRESIDENT_ENM'			Ctrl='txtPRESIDENT_ENM'		Param=value</C>
			<C>Col='TAX_NO'						Ctrl='medTAX_NO'				Param=text	</C>
			<C>Col='CORP_NO'					Ctrl='medCORP_NO'				Param=text	</C>
			<C>Col='BUSI_COND'					Ctrl='txtBUSI_COND'				Param=value</C>
			<C>Col='BUSI_ITEM'					Ctrl='txtBUSI_ITEM'				Param=value</C>
			<C>Col='POST_NO'					Ctrl='txtPOST_NO'					Param=value</C>
			<C>Col='ADDRESS_HD'				Ctrl='txtADDRESS_HD'			Param=value</C>
			<C>Col='ADDRESS_DT'				Ctrl='txtADDRESS_DT'			Param=value</C>
			<C>Col='TEL_NO'						Ctrl='txtTEL_NO'					Param=value</C>
			<C>Col='FAX_NO'						Ctrl='txtFAX_NO'					Param=value</C>
			<C>Col='COMP_URL'					Ctrl='txtCOMP_URL'				Param=value</C>
			<C>Col='HOMETAX_ID'				Ctrl='txtHOMETAX_ID'			Param=value</C>
			<C>Col='CORP_KIND'					Ctrl='cmbCORP_KIND'			Param=value</C>
			<C>Col='CORP_GBN'					Ctrl='cmbCORP_GBN'				Param=value</C>
			<C>Col='LOCATION_GBN'			Ctrl='cmbLOCATION_GBN'		Param=value</C>
			<C>Col='TAX_OFFICE'				Ctrl='cmbTAX_OFFICE'			Param=value</C>
			<C>Col='WARD_OFFICE'				Ctrl='txtWARD_OFFICE'			Param=value</C>
			<C>Col='CAPITAL_TOT'				Ctrl='medCAPITAL_TOT'			Param=text	</C>
			<C>Col='EMPLOYEE_TOT'			Ctrl='medEMPLOYEE_TOT'		Param=text	</C>
			<C>Col='STR_YMD'					Ctrl='txtSTR_YMD'				Param=value</C>
			<C>Col='ACF_QUT'					Ctrl='txtACF_QUT'					Param=value</C>
			<C>Col='ACC_STDT'					Ctrl='txtACC_STDT'				Param=value</C>
			<C>Col='ACC_ENDT'					Ctrl='txtACC_ENDT'				Param=value</C>
			<C>Col='PAY_DAY'					Ctrl='txtPAY_DAY'					Param=value</C>
	    ">
	</object>
