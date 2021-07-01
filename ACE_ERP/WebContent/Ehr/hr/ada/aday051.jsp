<!--*************************************************************************
/*--------------------------------------------------------------------------------
+ 시스템명 : 일용직 인사관리 - 결재 기안
+ 기능정의 : 결재 기안한다.
+ 프로그램ID : aday050.jsp
+ 기능정의 : 
+ 작 성 자 : 이 동 훈
+ 작성일자 : 2013.04.03
----------------------------------------------------------------------------------
+ 수정내용 : 
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------*/-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.DateUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>결재 신청(aday051.jsp)</title>
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
		var btnList = 'TTTTTFTT';
        var param = window.dialogArguments;
		var chkValid  = 'T';
		var req_no =  param.req_no;
		var yymm = req_no.substr(0,6);
		var site = req_no.substr(6,4);	
		var obj = new String();
		obj.app_cmt = "";
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

        	dsT_CA_MASTER.dataid = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday050.cmd.ADAY050CMD&S_MODE=SHR_MST"
												+ "&REQ_NO=" + req_no;			
        	dsT_CA_MASTER.reset();


        	
			dsT_CA_DETAIL.dataid = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday050.cmd.ADAY050CMD&S_MODE=SHR_DTL"
												+ "&PIS_YYMM=" + yymm
												+ "&SITE_CD=" + site;			
			dsT_CA_DETAIL.reset();


			
            dsT_DI_APPROVAL.DataID = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday050.cmd.ADAY050CMD&S_MODE=SHR_APP"
													+ "&PIS_YYMM=" + yymm
													+ "&SITE_CD=" + site;	
            dsT_DI_APPROVAL.Reset();
            
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
            //이곳에 해당 코딩을 입력 하세요
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
        function fnc_SearchItemCheck(year) {

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


            cfStyleGrid5(form1.grdT_CA_Detail,0,"false","true");      		// Grid Style 적용
        	cfStyleGrid(form1.grdT_DI_APPROVAL,0,"true","false");      	// Grid Style 적용

			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;

	        fnc_SearchList();

	        document.getElementById("txtPIS_YYMM_SHR").value = yymm.substr(0,4)+"-"+yymm.substr(4,2); // 해당년월
            document.getElementById("txtSITE_CD_SHR").value = site;       
            document.getElementById("txtSITE_NM_SHR").value = dsT_CA_MASTER.namevalue(1,"SITE_NM");  
	        
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


		/********************
         * 16. 결재 처리
         *******************/
		function fnc_SubmitApproval(kind) {

            if (!confirm(kind+" 처리를 하시겠습니까?")) return;

            var app_yn = "Y";    //결재완료여부

			if (kind == "부결") {

				app_yn = "N";

				window.showModalDialog("/hr/gun/gunc092.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			}

			dsT_DI_APPROVAL.UserStatus(1) = 1;

			dsT_DI_APPROVAL.NameValue(1,"REMARK") = obj.app_cmt;   	//결재의견 Container

			trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";

			trT_DI_APPROVAL.action = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday050.cmd.ADAY050CMD"
			                                      + "&S_MODE=UPT_APP"
			                                      + "&APP_YN="  +app_yn
			                                      + "&GUN_GBN=" +"K"
			                                      + "&REQ_NO="  +param.req_no;

			trT_DI_APPROVAL.post();

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
    | 2. 이름 : dsREQ_NO                           |
    | 3. Table List :             					|
    +----------------------------------------------->

    <Object ID="dsT_CA_MASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CA_DETAIL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					|
    | 2. 이름은 tr_ + 주요 테이블명()								|
    | 3. 사용되는 Table List()	        							|
    +--------------------------------------------------->
    <Object ID ="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!--------------------------+
    | grid에서 row를 클릭했을때      |
    +------ -------------------->
	<script for=grdT_CA_Detail event=OnDblClick(Row,Colid)>
	
        var param = new String();

  		param.cet_no = dsT_CA_DETAIL.NameValue(Row, "CET_NO");
  		param.wrk_ym = dsT_CA_DETAIL.NameValue(Row, "WRK_YM");

    	window.showModalDialog("/hr/ada/aday052.jsp", param, "dialogWidth:420px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

	</script>


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CA_MASTER Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_CA_DETAIL Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CA_DETAIL.CountRow);
        }
    </Script>

    <!----------------------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직 dsT_DI_APPROVAL |
    +----------------------------------------------------------------->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CA_MASTER Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    
    <Script For=dsT_CA_DETAIL Event="OnLoadError()">
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
		alert("처리되었습니다");
        //document.getElementById("resultMessage").innerText = "상신처리되었습니다";
		fnc_OnLoadProcess();
		fnc_HiddenElement("imgApproval");
		fnc_HiddenElement("imgRejection");		
    </script>


	<!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick 처리 - 부결사유 조회        |
    +------------------------------------------------------>
  	<script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){
		var obj = new String();
		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		window.showModalDialog("/hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
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
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">결재신청</td>
					<td align="right" class="navigator">HOME/보상관리/일용직관리/<font color="#000000">결재신청</font></td>
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
    		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)"><img src="/images/button/btn_ApprovalOn.gif"    name="imgApproval"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('결재');"></a>
    		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)"><img src="/images/button/btn_RejectionOn.gif" name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('부결');"></a>
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0" id="searchTable">
        <tr>
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <colgroup>
                            <col width="100"></col>
                            <col width="150"></col>
                            <col width="100"></col>
                            <col width=""></col>
                        </colgroup>
                        <tr>
							<td align="center" class="searchState">기준월</td>
                            <td class="padding2423">
								<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" class="input_ReadOnly" readonly>
							</td>					                        
                            <td class="searchState" align="right">소 속 &nbsp;</td>
	                        <td class="padding2423">
	                         <input id="txtSITE_CD_SHR" name="txtSITE_CD_SHR" style="width:15%" 	maxlength="4" class="input_ReadOnly" readonly>
							 <input id="txtSITE_NM_SHR" name="txtSITE_NM_SHR" size="20" maxlength="20" class="input_ReadOnly" readonly>
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


<table border="0">
	<tr>
		<td valign="top">
			<!-- 조건 입력 테이블 시작 -->
			<table width="350" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td class="paddingTop8">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                            <colgroup>
                                <col width="100"></col>
                                <col width="200"></col>
                            </colgroup>
 							<tr>
	                            <td align="center" class="creamBold">기안자</td>
                                <td class="padding2423" colspan ="3">
			                        <input id="txtENO_NO" name="txtENO_NO" size="8"  maxlength= "8"  class="input_ReadOnly"  readonly>
			                        <input id="txtENO_NM" name="txtENO_NM" size="10" maxlength= "14" class="input_ReadOnly"  readonly>
                        		</td>
							</tr>
                            <tr>
                                <td align="center" class="creamBold">부서</td>
                                <td class="padding2423" >
									<input id="txtDPT_NM" size="15" class="input_ReadOnly"  readonly>
                                </td>
                            </tr>   
                            <tr>                                                         
                                <td align="center" class="creamBold">직위</td>
                                <td class="padding2423" >
									<input id="txtJOB_NM" size="15" class="input_ReadOnly"  readonly>
                                </td>
                            </tr>
							<tr>
								<td align="center" class="creamBold">기안일</td>
                                <td class="padding2423">
			                        <input id="txtREQ_YMD" size="15"  class="input_ReadOnly"  readonly>
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
									<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:440px;height:125px;">
										<param name="DataID"				value="dsT_DI_APPROVAL">
										<param name="Format"				value="
											<C> id='REQ_NO'				width=40	name='등록번호'	align=center	show=false</C>
			            					<C> id='SEQ_NO'				width=40	name='구분'			align=center	show=false</C>
											<C> id='SEQ_NM'				width=50	name='구분'			align=center	Value={IF(SEQ_NO > '90','승인', '결재')}</C>
			            					<C> id='DPT_NM'				width=80	name='부서'			align=center	show=false</C>
											<C> id='JOB_NM'				width=60	name='직위'			align=center	</C>
											<C> id='ENO_NM'				width=70	name='성명'			align=center	</C>
											<C> id='APP_YN'				width=150	name='결재여부'	align=center	Value={DECODE(APP_YN,'Y','결재','N','부결','미결')&' '&UPT_YMD} </C>											
											<C> id='REMARK1'				width=60	name='사유'			align=center 	Color='Blue'	</C>

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
						<object	id="grdT_CA_Detail" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:230px;">
							<param name="DataID"					value="dsT_CA_DETAIL">
							<PARAM NAME="TITLEHEIGHT"		VALUE=40>
							<PARAM NAME="SORTVIEW"    		VALUE=LEFT>
							<PARAM NAME="BORDERSTYLE" 		VALUE="0">
							<PARAM NAME="INDWIDTH"			VALUE="0">
							<PARAM NAME="FILLAREA"				VALUE="true">
							<PARAM NAME="EDITABLE"				VALUE="true">
							<PARAM NAME="Colsizing"				VALUE="true">						
							<param name="ViewSummary"  		value="1">
							<param name="Format"					value="
								<C> id='{CUROW}'			width=30			name='NO'			align=center	value={String(Currow)}	SumBgColor=#C3D0DB</C>
								<C> id='SITE_NM'				width=190			name='소속'			align=left		sort = true SumBgColor=#C3D0DB SumText='총'</C>
								<C> id='ENO_NM'				width=90			name='성명'			align=center	sort = true SumBgColor=#C3D0DB SumText=@count</C>
								<C> id='CET_NO'				width=90			name='생년월일'	align=center	sort = true, SumBgColor=#C3D0DB mask='XX-XX-XX' SumText='명'</C>								
								<C> id='WRK_AMT'			width=80			name='일당'			align=center	sort = true SumBgColor=#C3D0DB</C>
								<C> id='WRK_DAY'			width=80			name='근로일수'	align=center	sort = true SumBgColor=#C3D0DB</C>
								<C> id='WRK_PAY'			width=90			name='노무비'		align=center	sort = true SumBgColor=#C3D0DB SumText=@sum</C>
                                <C> id='WRK_YM'   			width=90          	name='근로달'      align=center	sort = true, SumBgColor=#C3D0DB mask='XXXX-XX' </C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
				 <tr>
						<td> <BR><font color = "red" size = "3">
								&nbsp;&nbsp;&nbsp;* 성명을 Double Clike 하시면 해당 근로자의 근태 현황을 조회하실 수 있습니다.</font><BR>
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
<object id="bndT_CA_MASTER" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CA_MASTER">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NO   		 		Ctrl=txtENO_NO    		 	Param=value		</C>
		<C>Col=ENO_NM					Ctrl=txtENO_NM     		 	Param=value		</C>
		<C>Col=DPT_CD     		 		Ctrl=txtDPT_CD     			Param=value 		</C>
		<C>Col=DPT_NM      			Ctrl=txtDPT_NM 		     	Param=value 		</C>
		<C>Col=JOB_CD     		 		Ctrl=txtJOB_CD     			Param=value 		</C>
		<C>Col=JOB_NM					Ctrl=txtJOB_NM	   			Param=value		</C>
		<C>Col=REQ_YMD					Ctrl=txtREQ_YMD	   			Param=value		</C>

    '>
</object>



