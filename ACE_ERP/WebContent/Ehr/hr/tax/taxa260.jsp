	<!--*************************************************************************
	* @source      : taxa260.jsp												*
	* @description : 증명서발급처리 PAGE 										    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/16            채갑병          	        최초작성
	* 2007/07/21            조정호          	        로직변경
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>증명서발급처리(taxa260)</title>
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

        //단축키 순서
        var btnList = "T"   //조회
                    + "F"   //신규
                    + "F"   //저장
                    + "T"   //취소
                    + "F"   //엑셀
                    + "T"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
            var STR_YMD     = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD     = document.getElementById("txtEND_YMD_SHR").value;
            var CEF_STS     = document.getElementById("cmbCEF_STS_SHR").value;

            dsT_AC_CEFBOOK.DataId = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa260.cmd.TAXA260CMD"
                                  + "&S_MODE=SHR"
                                  + "&STR_YMD="+STR_YMD
                                  + "&END_YMD="+END_YMD
                                  + "&CEF_STS="+CEF_STS;
            dsT_AC_CEFBOOK.reset();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {

        }

		/********************************************
         * 03. 저장 함수								*
         ********************************************/
        function fnc_Save() {
        	//이곳에 해당 코딩을 입력 하세요
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


            if(dsT_AC_CEFBOOK.CountRow == 0) {
                alert("대상 건이 없습니다.");
                return;
            }
             trT_AC_CEFBOOK.KeyValue = "service_tr06(I:dsT_AC_CEFBOOK=dsT_AC_CEFBOOK)";
             trT_AC_CEFBOOK.action   = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa260.cmd.TAXA260CMD"
                                     + "&S_MODE=SAV";
             trT_AC_CEFBOOK.post();

            var url = "taxa260_PV.jsp";
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;


        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
            //이곳에 해당 코딩을 입력 하세요
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

            document.getElementById("cmbCEF_STS_SHR").selectedIndex = 0;

			dsT_AC_CEFBOOK.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
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
	        //이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_AC_CEFBOOK, 0, "true", "false");      // Grid Style 적용

            document.getElementById("txtSTR_YMD_SHR").value = getStrDate();
            document.getElementById("txtEND_YMD_SHR").value = getToday();

            document.getElementById("cmbCEF_STS_SHR").value = "B";
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
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
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_EXAMINATION)			   |
    | 3. 사용되는 Table List(T_CM_EXAMINATION) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_AC_CEFBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="false">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_CEFBOOK)		   |
    | 3. 사용되는 Table List(T_AC_CEFBOOK)		       |
    +------------------------------------------------------>
	<Object ID="trT_AC_CEFBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 용도 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R4"/>
       <jsp:param name="CODE_GUBUN"    value="R4"/>
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
	<Script For=dsT_AC_CEFBOOK Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_CEFBOOK.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_AC_CEFBOOK Event="OnLoadError()">
    </Script>

	<Script For=dsVI_T_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_AC_CEFBOOK Event="OnDataError()">
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_AC_CEFBOOK event="OnSuccess()">
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_AC_CEFBOOK event="OnFail()">
        alert(trT_AC_CEFBOOK.ErrorMsg);
    </script>


    <!-----------------------------------------------------+
    | 그리드의 ROW를 더블클릭 시 처리                              |
    +------------------------------------------------------>
    <script language=JavaScript for=grdT_AC_CEFBOOK event="OnDblClick(row,colid)">
        if(row < 1) {
            return;
        } else {
            var REQ_NO = dsT_AC_CEFBOOK.NameValue(row, "REQ_NO");

            var url = "/hr/tax/taxa261.jsp?&REQ_NO="+REQ_NO;
            window.showModalDialog(url, "", "dialogWidth:850px; dialogHeight:380px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            fnc_SearchList();
        }
    </script>

    <!-----------------------------------------------------+
    | header를 클릭했을때 미반영 데이타 모두 체크
    +------------------------------------------------------>
    <script language="javascript" for=grdT_AC_CEFBOOK event=OnHeadCheckClick(Col,Colid,bCheck)>

        if(Colid == "IS_CHK" && dsT_AC_CEFBOOK.CountRow > 0) {
            for(var i=1; i<=dsT_AC_CEFBOOK.CountRow; i++) {

                if(bCheck == "1") {
                    dsT_AC_CEFBOOK.NameString(i, "IS_CHK") = "T";
                } else {
                    dsT_AC_CEFBOOK.NameString(i, "IS_CHK") = "F";
                }
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">소득증명원발급처리</td>
                    <td align="right" class="navigator">HOME/정산세무/소득증명원출력/<font color="#000000">소득증명원발급처리</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="70"></col>
					<col width="220"></col>
					<col width="70"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">조회기간</td>
					<td class="padding2423" align="left">
						<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','55','110');"></a> ~
						<input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','170','110');"></a>
					</td>
                    <td class="searchState" align="right">조회조건</td>
                    <td class="padding2423" align="left">
                        <select id="cmbCEF_STS_SHR" style="WIDTH: 80px" onChange="fnc_SearchList()">
                            <option value="">모두</option>
                            <option value="A">저장</option>
                            <option value="B">신청</option>
                            <option value="C">반송</option>
                            <option value="E">발급</option>
                            <option value="F">직접출력</option>
                        </select>
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

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_AC_CEFBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_AC_CEFBOOK">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id={currow}		width=25	name="NO"			align=center	Edit=none	 </C>
                            <C> id="IS_CHK"     width=50    name="대상"             align=center    EditStyle=CheckBox,Pointer=Hand     HeadCheckShow=true      HeadCheck=true</C>
							<C> id="REQ_NO"		width=65	name="신청번호"		align=center	Edit=none	 </C>
							<C> id="DPT_NM"		width=80 	name="부서"			align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="JOB_NM"		width=60	name="직위"			align=center	Edit=none	 </C>
							<C> id="ENO_NM"		width=60	name="성명"			align=center	Edit=none	 </C>
							<C> id="CEF_SEC_NM" width=130	name="증명서종류"		align=center	Edit=none	 </C>
							<C> id="CEF_RSN_NM" width=130	name="용도"			align=center	Edit=none	 </C>
                            <C> id="CEF_STS_NM" width=40    name="상태"           align=center    Edit=none   </C>
                            <C> id="CEF_NO"     width=70    name="발급번호"     align=center    Edit=none    </C>
							<C> id="SPL_YMD"	width=70	name="발급일"			align=center	Edit=none	 </C>
                            <C> id="CEF_CNT"    width=35    name="매수"           align=center    Edit=none    </C>
                            <C> id="IPT_YMD"     width=70    name="신청일"     align=center    Edit=none    </C>
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