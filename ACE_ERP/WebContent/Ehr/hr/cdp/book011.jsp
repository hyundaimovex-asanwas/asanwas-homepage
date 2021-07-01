<!--
*****************************************************
* @source       : BOOK011.jsp
* @description : 도서구입신청 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2011/06/15      이동훈        최초작성
*----------------------------------------------------
* 2016/06/03    |  정영식   | 소스이전                                           *
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>도서구입결재</title>
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

        var param = window.dialogArguments;
        
		var rqst_no = param.req_no;
		
		var chkValid  = 'T';
		
		var rq_seq = 0;
		
		var obj = new String();
		
		obj.app_cmt = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
        	
			//도서신청현황 정보 조회
			dsT_ED_BOOKMASTER.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD&S_MODE=SHR_11&REQ_NO="+rqst_no;
			dsT_ED_BOOKMASTER.reset();

			dsT_ED_BOOKDETAIL.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD&S_MODE=SHR_02&REQ_NO="+rqst_no;
			dsT_ED_BOOKDETAIL.reset();

            //결재자 조회
            dsT_DI_APPROVAL.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD&S_MODE=SHR_APP&REQ_NO="+rqst_no;
            dsT_DI_APPROVAL.reset();
            
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

			trT_ED_BOOKDETAIL.KeyValue = "tr01(I:dsT_ED_BOOKDETAIL=dsT_ED_BOOKDETAIL)";
			trT_ED_BOOKDETAIL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book011.cmd.BOOK011CMD&S_MODE=UPT_DETAIL&REQ_NO="+rqst_no;
			trT_ED_BOOKDETAIL.post();

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
         * 08. 유효성 검사 *
         ******************/
        function fnc_Valid() {

        }

        /******************
         * 08. 추가 함수  *
         ******************/
		function fnc_Append(){

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
        	
        	
        	dsVI_T_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=SHR_02&ENO_NO="+gusrid;
            dsVI_T_PERSON.reset();
        	

            //사용안하는 것들 막기
			fnc_SearchList();

			cfStyleGrid_New(form1.grdT_ED_BOOKDETAIL,0,"true","false");      // Grid Style 적용

			cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");      // Grid Style 적용

			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;

        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /**
         * 상신처리
         */
        function fnc_Conduct() {


            if(dsT_ED_BOOKMASTER.CountRow < 1){
              alert("상신가능한 도서구입신청내역이 없습니다");
              return;
            }

            if(dsT_ED_BOOKDETAIL.CountRow < 1){
              alert("상신가능한 도서구입신청내역이 없습니다");
              return;
            }

            //1.상신처리 조건함
            if(dsT_DI_APPROVAL.CountRow < 1) {
                alert("결재선을 지정해주세요.");
                return;
            }

            //2.상신처리

            var RQST_YMD = document.getElementById("txtRQST_YMD").value;
			var GUN_YMD = RQST_YMD.replace("-","").replace("-","")
            //var DPT_CD  = document.getElementById("hidDPT_CD_ORI").value;
			var DPT_CD  = dsVI_T_PERSON.NameValue(0,"DPT_CD");
			var REQ_NO  = dsT_ED_BOOKMASTER.NameValue(1,"RQST_NO");

			trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			trT_DI_APPROVAL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD"
                                      + "&S_MODE=UPT_APP"
                                      + "&APP_YN="  +"R"
                                      + "&GUN_YMD=" +GUN_YMD
                                      + "&GUN_GBN=" +"Q"
                                      + "&GUN_DPT=" +DPT_CD
                                      + "&REQ_NO="	+REQ_NO;

			trT_DI_APPROVAL.post();

        }





        /**
         * 결재를 처리 한다.
         */
		function fnc_SubmitApproval(kind) {

            if (!confirm(kind+" 처리를 하시겠습니까?")) return;

            var app_yn = "Y";    //결재완료여부

			if (kind == "부결") {

				app_yn = "N";

				window.showModalDialog("../../hr/gun/gunc092.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			}

			dsT_DI_APPROVAL.UserStatus(1) = 1;

			dsT_DI_APPROVAL.NameValue(1,"REMARK") = obj.app_cmt;   	//결재의견 Container

			trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";

			trT_DI_APPROVAL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book011.cmd.BOOK011CMD"
                                      + "&S_MODE=SAV_APP"
                                      + "&APP_YN="  +app_yn
                                      + "&GUN_GBN=" +"Q"
                                      + "&REQ_NO="  +param.req_no;

			trT_DI_APPROVAL.post();
			
			window.close();

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
    | 2. 이름 : dsT_ED_BOOKMASTER                   |
    | 3. Table List : T_ED_BOOKMASTER               |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOOKMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_ED_BOOKDETAIL                   |
    | 3. Table List : T_ED_BOOKDETAIL               |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOOKDETAIL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_HOLIDAY                      |
    | 3. Table List : T_DI_HOLIDAY                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!-----------------------------------------------------+
    | 1. 조회용 DataSet(주소)              |
    | 2. 이름은 ds_ + 주요 테이블명(VI_T_CM_PERSON)      |
    | 3. 사용되는 Table List(VI_T_CM_PERSON)        |
    +------------------------------------------------------>
	 <Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	  <Param Name="Syncload"     Value="True">
	  <Param Name="UseChangeInfo"   Value="True">
	  <Param Name="ViewDeletedRow"  Value="False">
	 </Object>
    

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_APPROVAL)	|
    | 3. 사용되는 Table List(T_DI_APPROVAL)	        	|
    +--------------------------------------------------->
    <Object ID ="trT_ED_BOOKDETAIL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_BOOKMASTER Event="OnLoadCompleted(iCount)">

    </Script>

    <!----------------------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직 dsT_DI_APPROVAL |
    +----------------------------------------------------------------->
    <!-- 결재선 조회 후 -->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
    
    	var SESSION_ENONO = gusrid;

		fnc_HiddenElement("imgApproval");
		fnc_HiddenElement("imgRejection");
		fnc_HiddenElement("imgReport");
		fnc_HiddenElement("imgSave");

		//fnc_InputDisabled();
		
		// 결재자 상신 상태일 경우 결재자에게 결재,부결 이미지 보여주기
		for(var i=1; i<=dsT_DI_APPROVAL.CountRow; i++) {
			var APP_YN = dsT_DI_APPROVAL.NameString(i, "APP_YN");
			var ENO_NO = dsT_DI_APPROVAL.NameString(i, "ENO_NO");
			var PENO_NO = dsT_DI_APPROVAL.NameString(i, "PENO_NO");
		
			if(ENO_NO == SESSION_ENONO && APP_YN == "A") {
				fnc_ShowElement("imgApproval");
				fnc_ShowElement("imgRejection");
				fnc_HiddenElement("imgReport");
				dsT_DI_APPROVAL.NameValue(i,"REMARK1") = "의견입력";
				break;
			}
		}

			var END_TAG = dsT_ED_BOOKMASTER.NameString(1, "END_TAG");

			//내가 기안자이고 상태가 상신일때
			if(PENO_NO == SESSION_ENONO && END_TAG == "A") {
				fnc_HiddenElement("imgReport");
			}

			//내가 기안자이고 상태가 저장일때
			if(PENO_NO == SESSION_ENONO && END_TAG == "R") {
				fnc_ShowElement("imgReport");
				fnc_ShowElement("imgSave");
			}

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_BOOKMASTER Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_APPROVAL event="OnSuccess()">
        fnc_SearchList();
        //document.getElementById("resultMessage").innerText = "처리되었습니다";
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!------------------------------------------+
    | 그리드 조회시 화면설정 변경 및 결재선 조회|   =>  2010/4/8 조건삭제      || dsT_DI_APPROVAL.NameString(1, "APP_YN") == "R"
    +------------------------------------------->
	<script language="javascript"  for=dsT_DI_HOLIDAYWORK  event=OnRowPosChanged(row)>

        var today   = fnc_covNumber(getToday());
        if(row > 0) {

                //저장상태이거나 부결일때 수정이 가능함
                if(dsT_DI_APPROVAL.NameString(1, "APP_YN") == ""
                        || dsT_DI_APPROVAL.NameString(2, "APP_YN") == "N"
                        || dsT_DI_APPROVAL.NameString(1, "APP_YN") == "N") {
                    //신규일 경우
                    if(dsT_DI_HOLIDAYWORK.RowStatus(row) == "1") {  //신규

                        fnc_EnableElementAll(elementList);

                    } else {
                        fnc_EnableElementAll(elementList, exceptionList);   //신규이외
                    }
                }

        }

	</script>

	<!-----------------------------------------------------+
    | grdT_ED_BOOKDETAIL OnClick 처리 - 홈페이지 조회      |
    +------------------------------------------------------>
  	<script language="javascript"  for=grdT_ED_BOOKDETAIL event=OnDblClick(row,colid)>

		if(colid=="HOMEPAGE"){
			var siteTag = dsT_ED_BOOKDETAIL.NameValue(row,"HOMEPAGE");

			if(siteTag == ""){
				return;
			}
			
			window.open('http://'+siteTag,'imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
			
			
		}
  	</script>


	<!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick 처리 - 부결사유 조회        |
    +------------------------------------------------------>
  	<script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){

		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		window.showModalDialog("../../hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	}

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "의견입력" ){

		window.showModalDialog("../../hr/but/buta023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

	}
  	</script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">
<input type=hidden id="txtENO_NO_SHR" size="10">
<input type=hidden id="txtENO_NM_SHR" size="10">


<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="../../images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">도서구입결재</td>
					<td align="right" class="navigator">HOME/도서구입관리/도서구입/<font color="#000000">도서구입결재</font></td>
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
    		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','../../images/button/btn_ApprovalOver.gif',1)"><img src="../../images/button/btn_ApprovalOn.gif"    name="imgApproval"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('결재');"></a>
    		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','../../images/button/btn_RejectionOver.gif',1)"><img src="../../images/button/btn_RejectionOn.gif" name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('부결');"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   		    name="imgSave"   	  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','../../images/button/btn_ReportOver.gif',1)"><img src="../../images/button/btn_ReportOn.gif"          name="imgReport"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"            name="imgExit"      width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>

		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->


<table border="0">
	<tr>
		<td valign="top">
			<!-- 조건 입력 테이블 시작 -->
			<table width="350" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td class="paddingTop8">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                            <colgroup>
                                <col width="50"></col>
                                <col width="100"></col>
                                <col width="50"></col>
                                <col width="100"></col>
                            </colgroup>
 							<tr>
	                            <td align="center" class="blueBold">신청자</td>
                                <td class="padding2423" colspan ="3">
			                        <input id="txtENO_NO" name="txtENO_NO" size="8"  maxlength= "8"   class="input_ReadOnly"  readonly>
			                        <input id="txtENO_NM" name="txtENO_NM" size="10" maxlength= "14"  class="input_ReadOnly"  readonly>
			                        <input id="hidDPT_CD_ORI" type="hidden">
                        		</td>
							</tr>
                            <tr>
                                <td align="center" class="blueBold">소속</td>
                                <td class="padding2423" >
									<input id="txtDPT_NM" size="15" class="input_ReadOnly"  readonly>
                                </td>
                                <td align="center" class="blueBold">직위</td>
                                <td class="padding2423" >
									<input id="txtJOB_NM" size="12" class="input_ReadOnly"  readonly>
                                </td>
                            </tr>
							<tr>
								<td align="center" class="blueBold">신청일</td>
                                <td class="padding2423" colspan ="3" >
			                        <input id="txtRQST_YMD" name="txtRQST_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly"  readonly">
			                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRQST_YMD','','../../images/button/btn_HelpOver.gif',1)">
			                        <img src="../../images/button/btn_HelpOn.gif" id="ImgRQST_YMD" name="ImgRQST_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRQST_YMD','','36','227');"></a>
                                </td>
							</tr>
                            <tr>
                                <td align="center" class="blueBold">용도</td>
                                <td class="padding2423" colspan ="3">
                                    <input id="txtREMARK" style="width=100%"  class="input_ReadOnly"  readonly>
                                </td>
                            </tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- 조건 입력 테이블 끝 -->
		</td>
		<td valign="top">
		<div  id="approval_btn" style="DISPLAY:">
			<table width="430" border="0">
				<tr>
			        <td class="paddingTop8">

			        	<!-- 결재선 정보 테이블 시작 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<comment id="__NSID__">
									<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:440px;height:110px;">
										<param name="DataID"				value="dsT_DI_APPROVAL">
										<param name="Format"				value="
			            					<C> id='SEQ_NO'		width=35		name='NO'			align=center	</C>
											<C> id='SEQ_NM'		width=45		name='구분'			align=center	Value={IF(SEQ_NO > '90','승인', '결재')}</C>
											<C> id='JOB_NM'		width=55		name='직위'			align=center	</C>
											<C> id='ENO_NM'		width=65		name='성명'			align=center	</C>
											<C> id='APP_YN'		width=150	name='결재여부'	align=center	Value={DECODE(APP_YN,'Y','결재','N','부결','미결')&' '&APP_YMD} </C>
											<C> id='REMARK1'	width=60		name='사유'			align=center	Color='Blue'</C>
										">
										<param name="wmode" value="transparent" >
									</object>
									</comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
			                </tr>
			            </table>
			        	<!-- 결재선 정보 테이블 끝 -->
 					</td>
				</tr>
			</table>
		</div>
		</td>
	</tr>
</table>

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="85%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>

	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_ED_BOOKDETAIL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:230px;">
							<param name="DataID"				value="dsT_ED_BOOKDETAIL">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">					
							<param name="VIEWSUMMARY"			value=1>
							<param name="Format"				value="
								<C> id='{CUROW}'			width=30				name='NO'			align=center		value={String(Currow)}	 SumBgColor=#C3D0DB</C>
								<C> id='BOOK_NM'			width=180			name='도서명'		align=center		SumBgColor=#C3D0DB 	SumText='계'	</C>
								<C> id='BOOK_PUL'			width=120			name='출판사'		align=center		SumBgColor=#C3D0DB 	</C>
								<C> id='BOOK_WRT'		width=80				name='저자'			align=center		SumBgColor=#C3D0DB 	</C>
								<C> id='BOOK_QTY'			width=70				name='수량'			align=center		edit=numeric editlimit=3 SumBgColor=#C3D0DB SumText=@sum	</C>
								<C> id='BOOK_AMT'			width=80				name='가격'			align=center		edit=numeric editlimit=6 SumBgColor=#C3D0DB SumText=@sum	</C>
                                <C> id='HOMEPAGE'    		width=120           name='홈페이지'    align=left      		SumBgColor=#C3D0DB</C>
                                <C> id='BOOK_REMARK'    width=80            name='비고'         	align=left      		SumBgColor=#C3D0DB</C>
							">
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


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<object id="bndT_ED_BOOKMASTER" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_ED_BOOKMASTER">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NO   		 	Ctrl=txtENO_NO    		 	Param=value		</C>
		<C>Col=ENO_NM				Ctrl=txtENO_NM     		 	Param=value		</C>
		<C>Col=DPT_CD     		 	Ctrl=txtDPT_CD     			Param=value 	</C>
		<C>Col=DPT_NM      			Ctrl=txtDPT_NM 		     	Param=value 	</C>
		<C>Col=JOB_CD     		 	Ctrl=txtJOB_CD     			Param=value 	</C>
		<C>Col=JOB_NM				Ctrl=txtJOB_NM	   			Param=value		</C>
		<C>Col=RQST_YMD				Ctrl=txtRQST_YMD	   		Param=value		</C>
		<C>Col=RQST_REMARK			Ctrl=txtREMARK	   			Param=value		</C>
    '>
</object>


