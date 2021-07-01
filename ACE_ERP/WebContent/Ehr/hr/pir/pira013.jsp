<!--
    ************************************************************************************
    * @Source         : pira013.jsp                                                    		*
    * @Description    : 인사기본3 PAGE                                                 		*
    * @Developer Desc :                                                               			*
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            	*
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            이동훈            	ERP 이사											*
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>인사기본3</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<%
    String ENO_NO = request.getParameter("ENO_NO");         //사번
%>

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
        	
            var ENONO = <%=ENO_NO%>;
            
            if (form1.ENO_NO.value == "" || (parent.dsT_CM_PERSON.CountRow < 1 && parent.dsT_CM_PERSON.RowStatus(1) != 1)) {

                dsT_CM_PERSON.ClearData();

                //fnc_ColEnabled('D');

                document.getElementById("resultMessage").innerText = '';
                
                if (parent.document.getElementById("txtENO_NO").disabled == false) {
                	
                    parent.document.getElementById("txtENO_NM").focus();
                    
                }

                //return;
            }

            dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira013.cmd.PIRA013CMD&S_MODE=SHR&ENO_NO="+parent.document.getElementById("txtENO_NO").value;
            dsT_CM_PERSON.Reset();

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

            //DataSet의 변경 여부 확인
            if (!dsT_CM_PERSON.IsUpdated ) {
//                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return true;
            }

            if(fnc_SaveItemCheck()) {

                trT_CM_PERSON.KeyValue = "SVL(I:SAV=dsT_CM_PERSON)";
                trT_CM_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira013.cmd.PIRA013CMD&S_MODE=SAV&ENO_NO="+parent.document.getElementById("txtENO_NO").value+"&HEAD_CD="+parent.document.getElementById("txtHEAD_CD").value+"&DPT_CD="+parent.document.getElementById("txtDPT_CD").value;
                trT_CM_PERSON.post();

            } else {

                return false;

            }

            return true;

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

            //이곳에 해당 코딩을 입력 하세요

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

        	//사번임시저장
			var ENO_NO = document.getElementById("ENO_NO").value;

			dsT_CM_PERSON.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';
			//document.form1.ImgZipNo.focus();

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

            var f = document.form1;


            // 우편번호 미존재하고, 주소 입력한 경우
            if (document.getElementById("txtZIP_NO").value == "" && document.getElementById("txtADDRESS").value != "") {
                alert("우편번호를 입력하지 않으셨습니다. 확인바랍니다.");
                document.getElementById("txtADDRESS").focus();
                return false;
            }

            // 우편번호 미존재하고, 주소 입력한 경우
            if (document.getElementById("txtRZI_NO").value == "" && document.getElementById("txtRADR").value != "") {
                alert("우편번호를 입력하지 않으셨습니다. 확인바랍니다.");
                document.getElementById("txtRADR").focus();
                return false;
            }

            // 이메일 CHECK
            if (!fnc_ChgEmail()) {
                document.getElementById("txtE_MAIL").focus();
                return false;
            }

            // 주거형태
            if (document.getElementById("txtHOU_CD").value != "" &&
                document.getElementById("txtHOU_NM").value == "") {
                alert("주거형태코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                document.getElementById("txtHOU_CD").focus();
                return false;
            }

            // 급여계좌은행
            if (document.getElementById("txtABA_CD").value != "" &&
                document.getElementById("txtABA_NM").value == "") {
                alert("급여계좌은행코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                document.getElementById("txtABA_CD").focus();
                return false;
            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //document.getElementById("ENO_NO").value = "";

            //fnc_ColEnabled('D');

            fnc_SearchList();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            //이곳에 해당 코딩을 입력 하세요
        }

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {

                document.getElementById("txtADDRESS").disabled   = false;
                document.getElementById("txtRADR").disabled      = false;
                document.getElementById("txtPHN_NO").disabled    = false;
                document.getElementById("txtEM_PHN_NO").disabled = false;
                document.getElementById("txtE_MAIL").disabled    = false;
                document.getElementById("txtHOU_CD").disabled    = false;
                document.getElementById("txtROM_CNT").disabled   = false;
                document.getElementById("txtHIU_NO").disabled    = false;
                document.getElementById("txtLAN_SPA").disabled   = false;
                document.getElementById("txtFLR_SPA").disabled   = false;
                document.getElementById("txtABA_CD").disabled    = false;
                form1.medMOV_AMT.enable                          = true;
                form1.medMOVP_AMT.enable                         = true;
                document.getElementById("txtACC_NO").disabled    = false;

                document.getElementById("ImgZipNo").disabled     = false;
                document.getElementById("ImgRziNo").disabled     = false;
                document.getElementById("imgCopyAddress").disabled = false;
                document.getElementById("ImgHouCd").disabled     = false;
                document.getElementById("ImgAbaCd").disabled     = false;

            }
            else if (prop == 'D') {


            	
                document.getElementById("txtADDRESS").disabled   = true;
                document.getElementById("txtRADR").disabled      = true;
                document.getElementById("txtPHN_NO").disabled    = true;
                document.getElementById("txtEM_PHN_NO").disabled = true;
                document.getElementById("txtE_MAIL").disabled    = true;
                document.getElementById("txtHOU_CD").disabled    = true;
                document.getElementById("txtROM_CNT").disabled   = true;
                document.getElementById("txtHIU_NO").disabled    = true;
                document.getElementById("txtLAN_SPA").disabled   = true;
                document.getElementById("txtFLR_SPA").disabled   = true;
                document.getElementById("txtABA_CD").disabled    = true;
                form1.medMOV_AMT.enable                          = false;
                form1.medMOVP_AMT.enable                         = false;

                document.getElementById("txtACC_NO").disabled    = true;

                document.getElementById("ImgZipNo").disabled     = true;
                document.getElementById("ImgRziNo").disabled     = true;
                document.getElementById("imgCopyAddress").disabled = true;
                document.getElementById("ImgHouCd").disabled     = true;
                document.getElementById("ImgAbaCd").disabled     = true;

            }
        }

        function fnc_ChgEmail() {
            var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;

            if (document.getElementById("txtE_MAIL").value == '') {
                return true;
            }

            if (document.getElementById("txtE_MAIL").value.search(format) == -1) {
                alert("유효한 이메일 주소가 아닙니다.");
                document.getElementById("txtE_MAIL").focus();

                return false;
            }

            return true;
        }

        function fnc_UsrpostPopup(zip_no, addr, addr2) {
        	if(zip_no=="txtZIP_NO"){
        		openDaumPostcode('1');
        	}else{
        		openDaumPostcode('2');
        	}
            
            /**20150916 jys 막음
            var no = document.getElementById(zip_no).value;

            fnc_postPopup(zip_no, addr);

            if (document.getElementById(zip_no).value != "") {
                if (document.getElementById(zip_no).value.substr(3,1) != '-') {
                    document.getElementById(zip_no).value = document.getElementById(zip_no).value.substr(0,3) + '-' + document.getElementById(zip_no).value.substr(3,3);
                }

                if (no != document.getElementById(zip_no).value) {
                    document.getElementById(addr2).value = '';
                }
            }
            **/
        }

        function fnc_CopyAddress(){

            if(document.getElementById("txtZIP_NO").value.trim() == "" &&
                document.getElementById("txtADR_CT").value.trim() == "" &&
                document.getElementById("txtADDRESS").value.trim() == ""){
                alert("복사할 주소가 없습니다.");
                return false;
            }

            document.getElementById("txtRZI_NO").value = document.getElementById("txtZIP_NO").value;
            document.getElementById("txtRADR_CT").value = document.getElementById("txtADR_CT").value;
            document.getElementById("txtRADR").value = document.getElementById("txtADDRESS").value;
        }

    </script>
    
    
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script>
    function openDaumPostcode(gb) {
        var width =500;
        var height =600;
        new daum.Postcode({
            width:width,
            height:height,
            
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
                var strpostcode="";  //이전 우편번호 ( 6자리 )
                var strzonecode="";  //신규 우편번호 ( 5자리 )
                strzonecode = data.zonecode;    
                //strpostcode = data.postcode;  
                //strpostcode = strpostcode.substring(0,3)+strpostcode.substring(4,7)
                //document.getElementById('gcem_post').text = strpostcode;
                
                if(gb=="1"){
	                document.getElementById('txtZIP_NO').value = strzonecode;
	                
	                //document.getElementById('gcem_post_1').text = data.postcode1;
	                //document.getElementById('gcem_post_2').text = data.postcode2;
	                document.getElementById('txtADR_CT').value = data.address;
	                document.getElementById('txtADDRESS').value = "";
	
	                //전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
	                //아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
	                //var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
	                //document.getElementById('addr').value = addr;
	
	                document.getElementById('txtADDRESS').focus();
	            }else{
	            	document.getElementById('txtRZI_NO').value = strzonecode;
	                document.getElementById('txtRADR_CT').value = data.address;
	                document.getElementById('txtRADR').value = "";
	                document.getElementById('txtRADR').focus();
	            
	            }
            }
        }).open({
				    left:(window.screen.width/2)-(width/2),
				    top:(window.screen.height/2)-(height/2)
				} );
    }
</script>      
</head>


    <!--********************************************************************
    * 가우스 컴포넌트 선언 및 이벤트 (트랜젝션, 데이터셋) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
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

            //fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_PERSON.CountRow);
            document.getElementById("resultMessage").innerText = '';

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_PERSON event="OnSuccess()">

//        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
          if (parent.savflag != '1') {
              parent.savflag = 1;
          }

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_PERSON event="OnFail()">

        cfErrorMsg(this);

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();"> <!-- oncontextmenu="return false"-->

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="988" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>인사기본3</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="988" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="below">
                <tr>
                    <td></td>
                </tr>
            </table>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                <colgroup>
                    <col width="74 "></col>
                    <col width="75 "></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">등본상주소</td>
                    <td align="center" class="blueBold">우편번호</td>
                    <td class="padding2423">
                        <input id="txtZIP_NO" size="7" maxlength="7" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgZipNo','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgZipNo" name="ImgZipNo" width="21" height="20" border="0" align="absmiddle" onClick="fnc_UsrpostPopup('txtZIP_NO','txtADR_CT','txtADDRESS');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">주&nbsp;&nbsp;&nbsp;&nbsp;소</td>
                    <td class="padding2423">
                         <input id="txtADR_CT" style="width:53%" class="input_ReadOnly" readonly> <input id="txtADDRESS" maxlength="60" style="width:46%"></td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">실거주지</td>
                    <td align="center" class="blueBold">우편번호</td>
                    <td class="padding2423">
                        <input id="txtRZI_NO" size="7" maxlength="7" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRziNo','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRziNo" name="ImgRziNo" width="21" height="20" border="0" align="absmiddle" onClick="fnc_UsrpostPopup('txtRZI_NO','txtRADR_CT','txtRADR')"></a>
                        &nbsp;
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCopyAddress','','../../images/button/btn_CopyAddressOver.gif',1)"><img src="../../images/button/btn_CopyAddressOn.gif" name="imgCopyAddress" width="80" height="20" border="0" align="absmiddle" onClick="fnc_CopyAddress();"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">주&nbsp;&nbsp;&nbsp;&nbsp;소</td>
                    <td class="padding2423">
                        <input id="txtRADR_CT" style="width:53%" class="input_ReadOnly" readonly> <input id="txtRADR" maxlength="60" style="width:46%"></td>
                </tr>
            </table>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="78 "></col>
                    <col width="76 "></col>
                    <col width="155"></col>
                    <col width="76 "></col>
                    <col width="155"></col>
                    <col width="100"></col>
                    <col width="150"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" >연락번호</td>
                    <td align="center" class="blueBold">전화번호</td>
                    <td class="padding2423">
                        <input id="txtPHN_NO" style="width:100%;ime-mode:disabled"  maxlength="20" onKeyPress="JavaScript: cfCheckNumber();">
                    </td>
                    <td align="center" class="blueBold">휴 대 폰</td>
                    <td class="padding2423">
                        <input id="txtEM_PHN_NO" style="width:100%;ime-mode:disabled"  maxlength="15" onKeyPress="JavaScript: cfCheckNumber();">
                    </td>
                    <td align="center" class="blueBold">E-mail</td>
                    <td class="padding2423">
                        <input id="txtE_MAIL" maxlength="40" style="width:100%" onChange="fnc_ChgEmail();">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" rowspan="3">주거정보</td>
                    <td align="center" class="blueBold">주거형태</td>
                    <td class="padding2423">
                        <input id="txtHOU_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('D3', 'txtHOU_CD','txtHOU_NM');"> <input id="txtHOU_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHouCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgHouCd" name="ImgHouCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtHOU_CD','txtHOU_NM','주거형태','D3')"></a>
                    </td>
                    <td align="center" class="blueBold">방&nbsp;&nbsp;&nbsp;&nbsp;수</td>
                    <td class="padding2423">
                        <input id="txtROM_CNT" maxlength="1" style="width:83%;ime-mode:disabled;text-align:right;" onKeyPress="JavaScript: cfNumberCheck();"> 개
                    </td>
                    <td align="center" class="blueBold">건강보험증번호</td>
                    <td class="padding2423">
                        <input id="txtHIU_NO" maxlength="15" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">대&nbsp;&nbsp;&nbsp;&nbsp;지</td>
                    <td class="padding2423">
                        <input id="txtLAN_SPA" maxlength="3" style="width:83%;ime-mode:disabled;text-align:right;" onKeyPress="JavaScript: cfNumberCheck();"> 평
                    </td>
                    <td align="center" class="blueBold">건&nbsp;&nbsp;&nbsp;&nbsp;물</td>
                    <td class="padding2423">
                        <input id="txtFLR_SPA" maxlength="3" style="width:83%;ime-mode:disabled;text-align:right;" onKeyPress="JavaScript: cfNumberCheck();"> 평
                    </td>
                    <td align="center" class="blueBold">급여계좌은행</td>
                    <td class="padding2423">
                        <input id="txtABA_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('BK', 'txtABA_CD','txtABA_NM');"> <input id="txtABA_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgAbaCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgAbaCd" name="ImgAbaCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtABA_CD','txtABA_NM','은행','BK')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">동산</td>
                    <td >
                        <table width="100%" border="0">
                            <tr>
                                <td align="left" width="75%"">
                                    <comment id="__NSID__"><object id="medMOV_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                                        <param name=Alignment            	value=2>
                                        <param name=Border               		value=true>
                                        <param name=ClipMode             	value=true>
                                        <param name=DisabledBackColor    value="#EEEEEE">
                                        <param name=Enable               		value=true>
                                        <param name=IsComma              value=true>
                                        <param name=Language             value=0>
                                        <param name=MaxLength            value=5>
                                        <param name=Numeric              value=true>
                                        <param name=ShowLiteral          value="false">
                                        <param name=Visible              value="true">
                                    </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                                <td align="left"> 만원
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="center" class="blueBold">부동산</td>
                    <td >
                        <table width="100%" border="0">
                            <tr>
                                <td align="left" width="75%"">
                                    <comment id="__NSID__"><object id="medMOVP_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                                        <param name=Alignment            value=2>
                                        <param name=Border               value=true>
                                        <param name=ClipMode             value=true>
                                        <param name=DisabledBackColor    value="#EEEEEE">
                                        <param name=Enable               value=true>
                                        <param name=IsComma              value=true>
                                        <param name=Language             value=0>
                                        <param name=MaxLength            value=5>
                                        <param name=Numeric              value=true>
                                        <param name=ShowLiteral          value="false">
                                        <param name=Visible              value="true">
                                    </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                                <td align="left"> 만원
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="center" class="blueBold">급여계좌번호</td>
                    <td class="padding2423">
                        <input id="txtACC_NO" maxlength="17" style="width:100%">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width=100%><span id="resultMessage">&nbsp;</span></td>
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

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 인사기록표 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_PERSON">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=ENO_NO         Param=value Disable=disabled</C>
        <C> Col=ZIP_NO        Ctrl=txtZIP_NO      Param=value </C>
        <C> Col=ADDRESS       Ctrl=txtADDRESS     Param=value </C>
        <C> Col=ADR_CT        Ctrl=txtADR_CT      Param=value </C>
        <C> Col=RZI_NO        Ctrl=txtRZI_NO      Param=value </C>
        <C> Col=RADR          Ctrl=txtRADR        Param=value </C>
        <C> Col=RADR_CT       Ctrl=txtRADR_CT     Param=value </C>
        <C> Col=PHN_NO        Ctrl=txtPHN_NO      Param=value </C>
        <C> Col=EM_PHN_NO     Ctrl=txtEM_PHN_NO   Param=value </C>
        <C> Col=E_MAIL        Ctrl=txtE_MAIL      Param=value </C>
        <C> Col=HOU_CD        Ctrl=txtHOU_CD      Param=value </C>
        <C> Col=HOU_NM        Ctrl=txtHOU_NM      Param=value </C>
        <C> Col=ROM_CNT       Ctrl=txtROM_CNT     Param=value </C>
        <C> Col=HIU_NO        Ctrl=txtHIU_NO      Param=value </C>
        <C> Col=LAN_SPA       Ctrl=txtLAN_SPA     Param=value </C>
        <C> Col=FLR_SPA       Ctrl=txtFLR_SPA     Param=value </C>
        <C> Col=ABA_CD        Ctrl=txtABA_CD      Param=value </C>
        <C> Col=ABA_NM        Ctrl=txtABA_NM      Param=value </C>
        <C> Col=MOV_AMT       Ctrl=medMOV_AMT     Param=text  </C>
        <C> Col=MOVP_AMT      Ctrl=medMOVP_AMT    Param=text </C>
        <C> Col=ACC_NO        Ctrl=txtACC_NO      Param=value </C>
    '>
</object>