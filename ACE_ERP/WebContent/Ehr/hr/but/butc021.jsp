<!--
***********************************************************************
* @source      : butc021.jsp
* @description : 여비계산서 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2010/02/05      권혁수        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
	String status = request.getParameter("STATUS");         //결재진행상태
	String role_cd = box.getString("SESSION_ROLE_CD");         //롤권한
	System.out.println("status [" + status + "]");
	System.out.println("role_cd [" + role_cd + "]");
%>

<html>
<head>
	<title>여비계산서(butc021)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->

	<script language="javascript">

		var btnList = 'FFFFTFFT';

        var dsTemp = window.dialogArguments;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function fnc_SearchList() {

            //여비계산서 조회
            dsT_DI_DISPATCH_ACCOUNT.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.c.butc021.cmd.BUTC021CMD&S_MODE=SHR_01&ORD_NO="+dsTemp.NameValue(1,"ORD_NO");
            dsT_DI_DISPATCH_ACCOUNT.reset();

        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			*
         ********************************************/
        function fnc_SearchItem() {
        }

		/********************************************
         * 03. 저장 함수							*
         ********************************************/
        function fnc_Save() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {

        	//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 05. 인쇄 함수  							*
         ********************************************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 08. 추가 함수 							*
         ********************************************/
        function fnc_Append() {
        }

		/********************************************
         * 09. 제거 함수 							*
         ********************************************/
        function fnc_Remove() {
        }

		/********************************************
         * 10. 초기화 함수  						*
         ********************************************/
        function fnc_Clear() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

            if (dsT_DI_DISPATCH_ACCOUNT.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}

			window.close();

        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {
			cfStyleGrid(form1.grdT_DI_DISPATCH_ACCOUNT,0,"true","false");      // Grid Style 적용

			fnc_SearchList();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /********************************************
         * 16. 데이터셋 설정(fnc_compareDS도 같이 수정해야 함)*
         ********************************************/
		function fnc_SettingDS() {

		}

        /********************************************
         * 16. 데이터셋 비교(fnc_SettingDS도 같이 수정해야 함)*
         ********************************************/
		function fnc_compareDS() {

		}

        /********************************************
         * 17. 합계금액 계산						*
         ********************************************/
		function fnc_TotAccount() {

		}

        /********************************************
         * 18. '처리'버튼 처리  					*
         ********************************************/
		function fnc_Reflect() {
		}

        /********************************************
         * 19. '인사팀확인'버튼 처리  					*
         ********************************************/
		function fnc_InsaConfirm() {
			var today = getToday();     //시스템날짜
			apprdate=prompt("전표처리및 여비계산서를 확인하시겠습니까? \n전기일자를 확인바랍니다.",today);


//cfDateExpr(apprdate)
			if(apprdate == null){
			  alert("작업은 취소되었습니다");
			  return
			}else{
			  //alert("apprdate:"+apprdate);
			}

			if(cfDateExpr(apprdate)){
				trT_DI_DISPATCH_ACCOUNT.KeyValue = "tr02(I:dsT_DI_DISPATCH_ACCOUNT=dsT_DI_DISPATCH_ACCOUNT)";
				trT_DI_DISPATCH_ACCOUNT.action = "/servlet/GauceChannelSVL?cmd=hr.but.c.butc021.cmd.BUTC021CMD&S_MODE=PROC"+"&APPRDATE="+apprdate;
				trT_DI_DISPATCH_ACCOUNT.post();

			}else{
			}
		}
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->
    <!------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			    |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_DISPATCH)	|
    | 3. 사용되는 Table List(T_DI_DI_DISPATCH)	            |
    +------------------------------------------------------->
    <Object ID ="trT_DI_DISPATCH_ACCOUNT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

	<!------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							    |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_DISPATCH_ACCOUNT)|
    | 3. 사용되는 Table List(T_DI_DISPATCH_ACCOUNT) 		|
    +------------------------------------------------------->
	<Object ID="dsT_DI_DISPATCH_ACCOUNT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->
    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_DISPATCH_ACCOUNT event="OnSuccess()">
        cfErrorMsg(this);
		window.close();
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_DISPATCH_ACCOUNT event="OnFail()">
        cfErrorMsg(this);
		window.close();
    </script>
	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DISPATCH_ACCOUNT Event="OnLoadCompleted(iCount)">
		   var APP_STATUS = dsTemp.NameValue(1,"APP_STATUS");
		   //alert("<%=role_cd%>");
		   //alert(APP_STATUS);
			if( ("1001" == "<%=role_cd%>" || "1002" == "<%=role_cd%>") && (APP_STATUS == 4 || APP_STATUS == 7) ){
				//alert("처리모드");
				grdT_DI_DISPATCH_ACCOUNT.ColumnProp("TRANS_GBN", "Edit") = "Any";
			}else{
				//alert("읽기모드");
				grdT_DI_DISPATCH_ACCOUNT.ColumnProp("TRANS_GBN", "Edit") = "none";
			}
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_DISPATCH_ACCOUNT Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------------------------------------------------------+
    | Grid상에서 Editable상태에서 하나의 Cell에 입력을 완료한 후, 다음 Cell로 포커스를 옮길 때 발생하는 Event  |
    +---------------------------------------------------------------------------------------------------------->
	<script language=JavaScript for="grdT_DI_DISPATCH_ACCOUNT" event="OnCloseUp(row,colid)">
		if(colid == "TRANS_GBN"){
			var TRANS_GBN = dsT_DI_DISPATCH_ACCOUNT.NameValue(row, "TRANS_GBN");
			var ORG_TRANS_GBN = dsT_DI_DISPATCH_ACCOUNT.OrgNameValue(row, "TRANS_GBN");
			if(ORG_TRANS_GBN == "Y"){
				alert("이미 전표처리되었습니다");
				dsT_DI_DISPATCH_ACCOUNT.NameValue(row, "TRANS_GBN") = ORG_TRANS_GBN;
				return;
			}
			if(TRANS_GBN == "Y"){
				fnc_InsaConfirm();
			}
		}
	</script>


	<!-----------------------------------------------------+
    | Grid 에서 날짜 선택했을때 근태코드 가져오기						   |
    +------------------------------------------------------>

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
	<table width="700" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">파견비명세서</td>
					<td align="right" class="navigator">HOME/근태관리/파견관리/<font color="#000000">파견비명세서</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 타이틀 바 테이블 끝 -->

	<!-- 버튼 테이블 시작 -->
	<table width="700" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" width="300">
			    <span id="helpMessage">&nbsp;</span>

			</td>
			<td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="700" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_DISPATCH_ACCOUNT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:700px;height:315px;">
						<param name="DataID" value="dsT_DI_DISPATCH_ACCOUNT">
						<Param Name="ViewSummary"   value="1" >
						<param name="Format" value='
							<G>name=파견비산출내역	HeadBgColor=#F7DCBB
							<C> id="{CUROW}"	width=40	name="NO"		align=center	value={String(Currow)}</C>
							<C> id="YYYY"	    width=60	name="년"		align=center	    Edit=none SumText="합 계" suppress=1 </C>
							<C> id="MM"			width=40	name="월"		align=center	Edit=none </C>
                            <C> id="PAY_DAY"	width=100	name="지급일"	align=center	Edit=none sumtext=@sum</C>
							<C> id="EAT_AMT"	width=100	name="식비"	align=center    Edit=none sumtext=@sum</C>
                            <C> id="ETC_AMT"	width=100	name="잡비"		align=right Edit=none     sumtext=@sum</C>
                            <C> id="COST_AMT"	width=100	name="지급계(월)"		align=right     Edit=none sumtext=@sum</C>
							</G>
                            <C> id="TRANS_GBN"	width=100	name="전표처리"	align=center	EditStyle=Combo Data="Y:처리,N:미처리"</C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
        <tr>
			<td  width="50%" align="left" class="paddingTop5">
				※ 파견비 : 월정액 * 70%
			</td>
		</tr>
        <tr>
			<td  width="50%" align="left" class="paddingTop5">
				<!-- 조회 상태 테이블 시작 -->
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<!-- 조회 상태 테이블 끝 -->
			</td>
		</tr>
	</table>
	<!-- 내용 조회 그리드 데이블 끝-->
	</form>
	<!-- form 끝 -->
</body>
</html>

