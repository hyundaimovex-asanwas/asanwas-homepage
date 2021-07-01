<!--
***********************************************************************
* @source      : sagb080.jsp
* @description : 철야당직비현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/31      오대성        최초작성.
* 2007/04/23      김학수        인쇄부분추가.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>철야당직비현황(sagb080)</title>
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

        //버튼순서  : 조회  신규  저장  취소  엑셀  인쇄  삭제  닫기
        var btnList = 'T' + 'F' + 'F' + 'T' + 'T' + 'F' + 'F' + 'T';    

        var today = getToday();

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function fnc_SearchList() {

			//근태변경신청현황 정보 조회
            var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;
			var str_yymm = document.getElementById("txtSTR_YYMM_SHR").value; // 시작년월
			var end_yymm = document.getElementById("txtEND_YYMM_SHR").value; // 종료년월
			var app_yn  = document.getElementById("cmbAPP_YN_SHR").value;

			//시작년월이 없으면 조회못함.
			if(str_yymm.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작년월을 입력하세요.");
					document.getElementById("txtSTR_YYMM_SHR").focus();
					return false;
				}
			}
			//시작년월이 잘못되었으면 조회못함.
			if(str_yymm.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작년월이 잘못되었습니다.");
					document.getElementById("txtSTR_YYMM_SHR").focus();
					return false;
				}
			}

			//종료년월이 없으면 조회못함.
			if(end_yymm.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료년월을 입력하세요.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
				}
			}
			//종료년월이 잘못되었으면 조회못함.
			if(end_yymm.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료년월이 잘못되었습니다.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
				}
			}

			//종료년월이 시작년월보다 크면 않된다.
			if(parseInt(end_yymm.replaceStr("-","")) < parseInt(str_yymm.replaceStr("-",""))){
					alert("종료년월이 시작년월보다 빠릅니다.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
			}
			
			dsT_CP_NIGHTDUTY.dataid = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb080.cmd.SAGB080CMD&S_MODE=SHR&DPT_CD="+dpt_cd+"&STR_YYMM="+str_yymm+"&END_YYMM="+end_yymm+"&APP_YN="+app_yn;
			dsT_CP_NIGHTDUTY.reset();
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

            var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;
			var str_yymm = document.getElementById("txtSTR_YYMM_SHR").value; // 시작년월
			var end_yymm = document.getElementById("txtEND_YYMM_SHR").value; // 종료년월
			var app_yn  = document.getElementById("cmbAPP_YN_SHR").value;

            var url = "sagb080_PV.jsp?DPT_CD="+dpt_cd+"&STR_YYMM="+str_yymm+"&END_YYMM="+end_yymm+"&APP_YN="+app_yn;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_CP_NIGHTDUTY.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CP_NIGHTDUTY.GridToExcel("철야당직비현황", '', 225);

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
			document.getElementById("txtDPT_CD_SHR").value = "";
            document.getElementById("txtDPT_NM_SHR").value = "";
			document.getElementById("cmbAPP_YN_SHR").value = "";
			
            document.getElementById("resultMessage").innerText = ' ';

        	dsT_CP_NIGHTDUTY.ClearData();

            document.getElementById("txtSTR_YYMM_SHR").focus();
        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {
			if (dsT_CP_NIGHTDUTY.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);

			frame.CloseFrame();
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
        
         	if ( !dsT_CP_NIGHTDUTY.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			
			return true;
			
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {
			cfStyleGrid(form1.grdT_CP_NIGHTDUTY,0,"true","false");      // Grid Style 적용
            
            document.getElementById("txtSTR_YYMM_SHR").value = today.substring(0,7);
            document.getElementById("txtEND_YYMM_SHR").value = today.substring(0,7);
            
            document.getElementById("txtSTR_YYMM_SHR").focus();
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /********************************************
         * 16. 처리 버튼							*
         ********************************************/
		function fnc_Reflect() {

            if ( !dsT_CP_NIGHTDUTY.isUpdated ) {
                alert("처리할 자료가 없습니다!");
				document.getElementById("resultMessage").innerText = "* 처리할 자료가 없습니다!";
                return;
			}

            trT_CP_NIGHTDUTY.KeyValue = "tr01(I:dsT_CP_NIGHTDUTY=dsT_CP_NIGHTDUTY)";
			trT_CP_NIGHTDUTY.action = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb080.cmd.SAGB080CMD&S_MODE=SAV";
			trT_CP_NIGHTDUTY.post();

		}

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(T_CP_NIGHTDUTY)	   |
    | 3. 사용되는 Table List(T_CP_NIGHTDUTY) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_CP_NIGHTDUTY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_CP_NIGHTDUTY)	   |
    | 3. 사용되는 Table List(T_CP_NIGHTDUTY)		       |
    +------------------------------------------------------>
	<Object ID="trT_CP_NIGHTDUTY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_CP_NIGHTDUTY=dsT_CP_NIGHTDUTY,I:dsT_CP_NIGHTDUTY=dsT_CP_NIGHTDUTY)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_CP_NIGHTDUTY Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_CP_NIGHTDUTY Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trT_CP_NIGHTDUTY event="OnSuccess()">
        fnc_SearchList();
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   					   |
    +------------------------------------------------------>
	<script for=trT_CP_NIGHTDUTY event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-----------------------------------------------------+
    | Grid Head Check event 처리                                   |
    +------------------------------------------------------>
    <script language="javascript" for=grdT_CP_NIGHTDUTY event=OnHeadCheckClick(Col,Colid,bCheck)>
        for(var i=1; i<=dsT_CP_NIGHTDUTY.CountRow; i++) {
        
        	if(dsT_CP_NIGHTDUTY.NameValue(i, "END_TAG") != "Y" 
                    && dsT_CP_NIGHTDUTY.NameValue(i, "APP_YN") == "Y"){
	            dsT_CP_NIGHTDUTY.NameValue(i, "CHECKED") = bCheck;
            }
        }

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">철야당직비현황</td>
					<td align="right" class="navigator">HOME/근태관리/철야당직/<font color="#000000">철야당직비현황</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
							<col width="220"></col>
							<col width="60"></col>
							<col width="180"></col>
							<col width="70"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">해당기간&nbsp;</td>
							<td class="padding2423" align="left">
								<input id="txtSTR_YYMM_SHR" size="7" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtSTR_YYMM_SHR','','75','112');"></a>
								&nbsp;~&nbsp;
								<input id="txtEND_YYMM_SHR" size="7" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtEND_YYMM_SHR','','190','112');"></a>
							</td>
                            <td class="searchState" align="right">소&nbsp;&nbsp;속&nbsp;</td>
							<td class="padding2423" align="left">
								<input id="txtDPT_CD_SHR" size="3" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" style="ime-mode:disabled"  onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input id="txtDPT_NM_SHR" size="12" class="input_ReadOnly" readonly>
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
							</td>
							<td class="searchState" align="right">결재구분&nbsp;</td>
							<td class="padding2423" align="left">
								<select id="cmbAPP_YN_SHR"  style="width='60%';" onChange="fnc_SearchList()">
									<option value="">전체</option>
									<option value="1">미상신</option>
									<option value="2">미결</option>
									<option value="3">결재</option>
									<option value="4">부결</option>
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
			<td class="paddingTop5">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="360" valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
						<td valign="top" align="right" class="searchState">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)"> <img src="/images/button/btn_ConductOn.gif" name="imgConduct"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Reflect()"></a>
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
					<object id="grdT_CP_NIGHTDUTY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:380px;">
						<param name="DataID" value="dsT_CP_NIGHTDUTY">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id={currow}		width=39    name="NO"		align=center </C>
                            <C> id="DPT_NM"		width=100	name="소속"		    align=left      LeftMargin=10 Edit=none </C>
                            <C> id="JOB_NM"		width=60	name="직위"		    align=center    Edit=none </C>
                            <C> id="ENO_NO"	    width=70	name="사번"         align=center    Edit=none </C>
                            <C> id="ENO_NM"	    width=70	name="성명"	        align=center    Edit=none </C>
							<C> id="DUTY_CNT"	width=70	name="당직일수"		align=right 	Edit=none</C>
                            <C> id="DUTY_AMT"	width=70	name="당직수당"		align=right 	Edit=none</C>
                            <C> id="REMARK" 	width=140	name="비고" 		align=left   	Edit=none</C>
							<C> id="APP_YN_NM"	width=60	name="결재유무"		align=center	Edit=none	</C>
							<C> id="END_TAG"	width=60	name="반영여부"	    align=center	Edit=none Value={Decode(END_TAG,"Y","반영","미반영")}</C>
                            <C> id="CHECKED"	width=40	name="Chk"		    align=center	HeadCheckShow=true Editstyle="CheckBox"  Edit={Decode(END_TAG,"Y",0,Decode(APP_YN, "Y", 1, 0))} </C>
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