<!--
***********************************************************************
* @source      : guna061.jsp
* @description : 근태변경신청현황상세 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/26      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>근태변경신청현황상세(guna061)</title>
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

	<script language="javascript">

		var btnList = 'FFFFFFFT';
		var dsTemp = window.dialogArguments;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

            

			dsT_DI_CHANGE.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna061.cmd.GUNA061CMD&S_MODE=SHR&REQ_NO="+dsTemp.NameValue(1,"REQ_NO");
			dsT_DI_CHANGE.reset();

        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			*
         ********************************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

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

            var req_no  = document.getElementById("txtREQ_NO").value;
            var dpt_nm  = document.getElementById("txtDPT_NM").value;
            var chn_ymd = document.getElementById("txtCHN_YMD").value;
            var req_ymd = document.getElementById("txtREQ_YMD").value;

            var pjob_nm = document.getElementById("txtPJOB_NM").value;
            var peno_no = document.getElementById("txtPENO_NO").value;
            var peno_nm = document.getElementById("txtPENO_NM").value;
            var app_ymd = document.getElementById("txtAPP_YMD").value;
            var app_nm  = document.getElementById("txtAPP_NM").value;

            var url = "guna061_PV.jsp?req_no="+req_no+"&dpt_nm="+dpt_nm+"&chn_ymd="+chn_ymd+"&req_ymd="+req_ymd+"&pjob_nm="+pjob_nm+"&peno_no="+peno_no+"&peno_nm="+peno_nm+"&app_ymd="+app_ymd+"&app_nm="+app_nm;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {
			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
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

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 09. 제거 함수 							*
         ********************************************/
        function fnc_Remove() {

        	//이곳에 해당 코딩을 입력 하세요

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

            document.getElementById("txtREQ_NO").value = dsTemp.NameValue(1,"REQ_NO");
            document.getElementById("txtDPT_NM").value = dsTemp.NameValue(1,"DPT_NM");
            document.getElementById("txtCHN_YMD").value = dsTemp.NameValue(1,"CHN_YMD");
            document.getElementById("txtREQ_YMD").value = dsTemp.NameValue(1,"REQ_YMD");

			cfStyleGrid(form1.grdT_DI_CHANGE,0,"false","false");      // Grid Style 적용

<%
    if(box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
			if(dsTemp.NameValue(1,"END_TAG") != "Y" && dsTemp.NameValue(1,"APP_YN") == "Y"){
                document.getElementById("imgConduct").disabled = false;
                document.getElementById("imgConduct").style.display = "";
            }else{
                document.getElementById("imgConduct").disabled = true;
                document.getElementById("imgConduct").style.display = "none";
            }
<%
    }else{
%>
        document.getElementById("imgConduct").disabled = true;
        document.getElementById("imgConduct").style.display = "none";
<%
    }
%>

            fnc_SearchList();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /********************************************
         * 16. 처리 버튼                            *
         ********************************************/
        function fnc_Reflect() {

            if (!confirm("처리하시겠습니까?")){
                return;
            }
            
            //선택된 ROW를 dsT_DI_CHANGE_CP 복사하여 guna061에 dsT_DI_CHANGE_CP 넘겨준다.
            cfCopyDataSet(dsTemp, dsT_DI_CHANGE_01, "copyHeader=yes,rowFrom="+1+",rowCnt=1");

            dsT_DI_CHANGE_01.NameValue(1,"CHECKED") = "1";

            trT_DI_CHANGE.KeyValue = "tr01(I:dsT_DI_CHANGE=dsT_DI_CHANGE_01)";
            trT_DI_CHANGE.action = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna060.cmd.GUNA060CMD&S_MODE=SAV";
            trT_DI_CHANGE.post();
            
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
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_CHANGE)		 	   |
    | 3. 사용되는 Table List(T_DI_CHANGE) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_CHANGE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	
	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_CHANGE)		 	   |
    | 3. 사용되는 Table List(T_DI_CHANGE) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_CHANGE_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>


	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>
    
	<Script For=dsT_DI_CHANGE_01 Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>
    
    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton                      |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_CHANGE)        |
    | 3. 사용되는 Table List(T_DI_CHANGE)                  |
    +------------------------------------------------------>
    <Object ID="trT_DI_CHANGE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>
    
	<Script For=dsT_DI_CHANGE_01 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>
    
	<Script For=dsT_DI_CHANGE_01 Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>
    
    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_DI_CHANGE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        window.close();
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_DI_CHANGE event="OnFail()">
        cfErrorMsg(this);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">근태변경신청현황상세</td>
					<td align="right" class="navigator">HOME/근태관리/일일근태관리/<font color="#000000">근태변경신청현황상세</font></td>
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
			    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)"> <img src="/images/button/btn_ConductOn.gif" name="imgConduct"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Reflect()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

<table width="800px" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
	<!-- 조건 입력 테이블 시작 -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="90"></col>
					<col width="100"></col>
					<col width="90"></col>
                    <col width="100"></col>
					<col width="90"></col>
                    <col width="100"></col>
					<col width="90"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">신청번호</td>
					<td class="padding2423">
                        <input id="txtREQ_NO" style="width:100%;" class="input_ReadOnly" readonly>
                    </td>
					<td align="center" class="creamBold">신청소속</td>
					<td class="padding2423">
                        <input id="txtDPT_NM" style="width:100%;" class="input_ReadOnly" readonly>
                    </td>
					<td align="center" class="creamBold">해당근태일</td>
					<td class="padding2423">
                        <input id="txtCHN_YMD" style="width:100%;" class="input_ReadOnly" readonly>
                    </td>
					<td align="center" class="creamBold">신청일자</td>
					<td class="padding2423">
						<input id="txtREQ_YMD" style="width:100%;" class="input_ReadOnly" readonly>
					</td>
				</tr>
            </table>
            </td>
        <tr>
            <td class="paddingTop8">
                <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                <strong>결재정보</strong>
            </td>
        </tr>
        <tr>
			<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="60"></col>
					<col width="90"></col>
					<col width="60"></col>
                    <col width="90"></col>
					<col width="60"></col>
                    <col width="90"></col>
					<col width="60"></col>
                    <col width="90"></col>
					<col width="60"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">직위</td>
					<td class="padding2423">
                        <input id="txtPJOB_NM" style="width:100%;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">사번</td>
					<td class="padding2423">
                        <input id="txtPENO_NO" style="width:100%;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">성명</td>
					<td class="padding2423">
                        <input id="txtPENO_NM" style="width:100%;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">결재일</td>
					<td class="padding2423">
                        <input id="txtAPP_YMD" style="width:100%;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">완료여부</td>
					<td class="padding2423">
                        <input id="txtAPP_NM" style="width:100%;" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->
</tr>
</table>

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td  width="100%" align="left" class="paddingTop5">
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
		<tr>
			<td class="paddingTop8" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_CHANGE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_DI_CHANGE">
						<param name="Format" value='
							<C> id="{CUROW}"	width=44	name="NO"			align=center	value={String(Currow)}</C>
							<C> id="DPT_NM"		width=100	name="소속"			align=left		</C>
							<C> id="JOB_NM"		width=60	name="직위"			align=center	</C>
							<C> id="ENO_NO"		width=70	name="사번"			align=center	</C>
							<C> id="ENO_NM"		width=65	name="성명"			align=center	</C>
							<G> name="변경전근태"  HeadBgColor="#F7DCBB"
								<C> id="BF_GUN_NM"		width=70	name="근태"	align=center	</C>
								<C> id="BF_REMARK"		width=100	name="비고"	align=left	    </C>
							</G>
							<G> name="변경후근태"  HeadBgColor="#F7DCBB"
								<C> id="GUN_NM"			width=70	name="근태"	align=center	</C>
								<C> id="REMARK" 		width=100	name="비고"	align=left	    </C>
								<C> id="REASON"			width=100	name="사유"	align=left	    </C>
							</G>
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
	*	바인딩 컴포넌트																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_DI_CHANGE 설정 테이블 -->
	<object id="bndT_DI_CHANGE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_DI_CHANGE">
		<Param Name="BindInfo", Value="
			<C>Col=PJOB_NM		Ctrl=txtPJOB_NM		Param=value</C>
            <C>Col=PENO_NO		Ctrl=txtPENO_NO		Param=value</C>
            <C>Col=PENO_NM		Ctrl=txtPENO_NM		Param=value</C>
            <C>Col=APP_YMD		Ctrl=txtAPP_YMD		Param=value</C>
            <C>Col=APP_NM		Ctrl=txtAPP_NM		Param=value</C>
		">
	</object>