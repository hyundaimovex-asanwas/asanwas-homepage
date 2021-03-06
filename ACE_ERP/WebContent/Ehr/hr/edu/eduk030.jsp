<!--
*****************************************************
* @source       : edue040.jsp
* @description : 교육신청 결재처리 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2009/10/20      임종태        최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>연간교육신청 결재목록</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TFFTFFFT';

        var today = getToday();
        var dsTemp = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			//검색조건
            var app_yn = document.getElementById("cmbAPP_YN").value;
            if(!fnc_SearchItemCheck()) return;

            dsT_DI_APPROVAL.dataid = "/servlet/GauceChannelSVL?cmd=hr.edu.k.eduk030.cmd.EDUK030CMD&S_MODE=SHR&APP_YN_SHR="+app_yn;
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

            document.getElementById("resultMessage").innerText = ' ';

			dsT_DI_APPROVAL.ClearData();


        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        if(dsTemp != "Modal"){
	            if (dsT_DI_APPROVAL.IsUpdated)  {
	                if (!fnc_ExitQuestion()) return;
	            }

	            frame = window.external.GetFrame(window);
	            frame.CloseFrame();

	        }else{
	            window.close();
	        }

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            return true;
        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_DI_APPROVAL.IsUpdated) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}
			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid(form1.grdT_DI_APPROVAL,0,"true","false")      // Grid Style 적용

            fnc_SearchList();//자동조회
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}
		/********************
         * 15. 결재 승인  *
         *******************/
		function fnc_Approval() {

			if(!CheckStatus()){
				alert("하나 이상의 항목을 선택해 주세요.");
				return;
			}
            if (confirm("결재처리를 하시겠습니까?")) {

				trT_DI_APPROVAL.KeyValue = "tr01(I:SAV=dsT_DI_APPROVAL)";
				trT_DI_APPROVAL.action   = "/servlet/GauceChannelSVL?cmd=hr.edu.k.eduk030.cmd.EDUK030CMD&S_MODE=SAV&APP_YN=Y";
				trT_DI_APPROVAL.post();
            }


		}
		/********************
         * 15. 결재 부결  *
         *******************/
		function fnc_Reject() {
			if(!CheckStatus()){
				alert("하나 이상의 항목을 선택해 주세요.");
				return;
			}
            if (confirm("부결처리를 하시겠습니까?")) {

				trT_DI_APPROVAL.KeyValue = "tr01(I:SAV=dsT_DI_APPROVAL)";
				trT_DI_APPROVAL.action   = "/servlet/GauceChannelSVL?cmd=hr.edu.k.eduk030.cmd.EDUK030CMD&S_MODE=SAV&APP_YN=N";
				trT_DI_APPROVAL.post();
            }

		}
		
		function CheckStatus(){
			var iCnt = 0;
			for(i=1;i<=dsT_DI_APPROVAL.countrow;i++){
				if(dsT_DI_APPROVAL.NameValue(i,"CKBOX") == 'T'){
					dsT_DI_APPROVAL.UserStatus(i) = 1;
					iCnt++;
				} else {
					dsT_DI_APPROVAL.UserStatus(i) = 0;
				}
//				alert("dsT_DI_APPROVAL.NameValue(i,\"CKBOX\")=="+dsT_DI_APPROVAL.NameValue(i,"CKBOX") + 
//				"\n"+"dsT_DI_APPROVAL.RowStatus("+i+")=="+dsT_DI_APPROVAL.RowStatus(i));
			}
			if(iCnt>0) return true;
			else return false;
		}

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 카피용 DataSet                             |
    | 2. 이름 : dsT_DI_APPROVAL_CP                  |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_APPROVAL)	   |
    | 3. 사용되는 Table List(T_DI_APPROVAL) 			   |
    +------------------------------------------------------>
	<Object ID="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>
    

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

	        //alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!------------------------------+
    | 그리드의 ROW를 더블클릭 할때  |
    +------------------------------->
	<script language=JavaScript for=grdT_DI_APPROVAL event="OnDblClick(row,colid)">
		if(row < 1) {
			return;
		} else if(colid != "CKBOX") {
            //if(dsT_DI_APPROVAL.NameString(row, "ENO_NO") == "<%=box.getString("SESSION_ENONO") %>") {
                //선택된 ROW를 dsT_DI_CHANGE_CP 복사하여 edue041에 dsT_DI_CHANGE_CP 넘겨준다.
    			cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_CP, "copyHeader=yes,rowFrom="+row+",rowCnt=1");

    			window.showModalDialog("/hr/edu/edue041.jsp", dsT_DI_APPROVAL_CP, "dialogWidth:870px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

                fnc_SearchList();
            //} else {
            //    alert("결재자가 아니라 조회하실 수 없습니다.");
            //}
		}
	</script>
	
	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
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

<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">연간교육신청 결재목록</td>
					<td align="right" class="navigator">HOME/기초정보/통합결재/<font color="#000000">연간교육신청 결재목록</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="imgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right">결재상태</td>
                                <td class="padding2423" align="left">
			                        <select id="cmbAPP_YN" style="width:100" onChange="fnc_SearchList();">
			                            <option value="" >전체</option>
			                            <option value="Y" >결재</option>
			                            <option value="N" >부결</option>
			                            <option value="A" selected>미결</option>
			                        </select>
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
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8" height="40">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
		<td class="paddingTop8" width="200" align="right">
	        <span id="append_btn" style="display:">
		    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)">  <img src="/images/button/btn_ApprovalOn.gif"   name="imgApproval" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Approval();"></a>
		    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)">  <img src="/images/button/btn_RejectionOn.gif"   name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Reject();"></a>
	        </span>
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
					<object id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
						<param name="DataID" value="dsT_DI_APPROVAL">
						<param name=UsingOneClick  value="1">
						<param name="Format" value='
                            <C> id="CKBOX"		width=40	name="선택"		align=center  EditStyle=checkbox Edit={Decode(APP_YN,"A","true","false")}</C>
                            <C> id="REQ_NO"		width=80	name="품의번호"		align=center     suppress=1 show=false </C>
                            <C> id="PDPT_NM"	width=95	name="소속"		align=center  Edit=none  suppress=1</C>
                            <C> id="PJOB_NM"	width=95	name="직위"		align=center Edit=none    suppress=1</C>
                            <C> id="PENO_NM"	width=95	name="상신자"		align=center Edit=none    suppress=1</C>
							<C> id="APP_STATUS"	width=80	name="결재상태"	    align=center Edit=none	     </C>
                            <C> id="APP_DATE"	width=105	name="결재일/시간"	align=center  Edit=none    </C>
							<C> id="EDU_YMD"	width=140	name="교육기간" align=center  Edit=none</C>
							<C> id="EDU_NM"		width=300	name="과정명" align=left Edit=none </C>
							<C> id="INT_NAM"	width=140	name="시행처" align=center Edit=none </C>
							<C> id="EDU_AMT"	width=140	name="교육비" align=center  Edit=none</C>
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