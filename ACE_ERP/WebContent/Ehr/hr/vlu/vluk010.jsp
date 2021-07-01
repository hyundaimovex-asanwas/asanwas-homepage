<!--
***********************************************************************
* @source      : vluk010.jsp
* @description : 평가기간 설정 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/22      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>평가기간 설정(vluk010)</title>
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

		var btnList = 'TTTTFFTT';

        var today = '<%=box.get("SESSION_TODAY")%>';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var eva_yy = document.getElementById('txtEVA_YY_SHR').value;

            if(!fnc_SearchItemCheck()) return;  //조회 유효성 검사

			dsT_EV_RQSTYMD.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk010.cmd.VLUK010CMD&S_MODE=SHR&EVAYM="+eva_yy;
    		dsT_EV_RQSTYMD.reset();

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

			if(!fnc_SaveItemCheck()) return;	//유효성 체크

            trT_EV_RQSTYMD.KeyValue = "tr01(I:dsT_EV_RQSTYMD=dsT_EV_RQSTYMD)";
			trT_EV_RQSTYMD.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk010.cmd.VLUK010CMD&S_MODE=SAV";
			trT_EV_RQSTYMD.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

			if(dsT_EV_RQSTYMD.CountRow < 1) {
				alert("삭제할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}

			if(confirm("[년도:"+dsT_EV_RQSTYMD.NameValue(dsT_EV_RQSTYMD.RowPosition,'EVAYM')+"]의 정보를 삭제하시겠습니까?")){
				dsT_EV_RQSTYMD.DeleteRow(dsT_EV_RQSTYMD.RowPosition);
				trT_EV_RQSTYMD.KeyValue = "tr01(I:dsT_EV_RQSTYMD=dsT_EV_RQSTYMD)";
				trT_EV_RQSTYMD.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk010.cmd.VLUK010CMD&S_MODE=DEL";
				trT_EV_RQSTYMD.post();
			}

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

            //DataSet에 Header가 정의되어 있지 않는 경우
			if(dsT_EV_RQSTYMD.CountColumn < 1){
				// 데이터셋의 헤더 정보 설정.
				dsT_EV_RQSTYMD.setDataHeader("EVAYM:STRING:KEYVALUE, STR_YMD:STRING, END_YMD:STRING");
			}

            dsT_EV_RQSTYMD.AddRow();
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


        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_RQSTYMD.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            var eva_yy = document.getElementById('txtEVA_YY_SHR');

            if(eva_yy.value == "" || eva_yy.value.length < 6){
                alert("6자리수 년월을 입력하세요!");
                eva_yy.focus();
                return false;
            }

            return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            if (!dsT_EV_RQSTYMD.IsUpdated ) {
				alert("저장할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}


            //신청일, 종료일이 같은지 여부 검증
            var str_ymd;
            var end_ymd;
            var str_ymd2;
            var end_ymd2;

            for(var i=1; i<=dsT_EV_RQSTYMD.CountRow; i++) {
                str_ymd = parseInt(dsT_EV_RQSTYMD.NameString(i, "STR_YMD").replace(/-/g, ""));
                end_ymd = parseInt(dsT_EV_RQSTYMD.NameString(i, "END_YMD").replace(/-/g, ""));

                for(var j=1; j<=dsT_EV_RQSTYMD.CountRow; j++) {
                    if(i == j) continue;

                    str_ymd2 = parseInt(dsT_EV_RQSTYMD.NameString(j, "STR_YMD").replace(/-/g, ""));
                    end_ymd2 = parseInt(dsT_EV_RQSTYMD.NameString(j, "END_YMD").replace(/-/g, ""));

                    if((str_ymd  <= str_ymd2 && str_ymd2 <= end_ymd)
                            || (str_ymd  <= end_ymd2 && end_ymd2 <= end_ymd)
                            || (str_ymd2 <= str_ymd  && str_ymd  <= end_ymd2)
                            || (str_ymd2 <= end_ymd  && end_ymd  <= end_ymd2)) {
                        alert(i+"번째 줄과 "+j+"번째 줄의 기간값이 중복됩니다.\n 신청시작일와, 신청종료일을 확인해 주세요.");
                        return false;
                    }
                }
            }

			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid(form1.grdT_EV_RQSTYMD,15,"false","false");      // Grid Style 적용

			document.getElementById("txtEVA_YY_SHR").value = getToday().substring(0,7);

            fnc_DisableElementAll(elementList);
            
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		var elementList = new Array( "txtSTR_YMD"
                                    ,"txtEND_YMD"
                                    ,"imgSTR_YMD"
                                    ,"imgEND_YMD");

		var keyList = new Array(     "txtSTR_YMD"
                                    ,"txtEND_YMD");


        /**
         * 신청 시작일자를 넣을때 신청 년도를 자동으로 바인딩
         */
        function bindEVA_YY() {
            var str_ymd = document.getElementById("txtSTR_YMD").value;
            var eva_yy = "";

            if(str_ymd.length > 5) {
                eva_yy = str_ymd.substr(0,4)+str_ymd.substr(5.2);
            }
            dsT_EV_RQSTYMD.NameString(dsT_EV_RQSTYMD.RowPosition, "EVAYM") = eva_yy;
        }

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_EV_RQSTYMD)   |
    | 3. 사용되는 Table List(T_EV_RQSTYMD)		     |
    +------------------------------------------------>
    <Object ID="dsT_EV_RQSTYMD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_EV_RQSTYMD)	    |
    | 3. 사용되는 Table List(T_EV_RQSTYMD)	            |
    +--------------------------------------------------->
    <Object ID ="trT_EV_RQSTYMD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_EV_RQSTYMD Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_RQSTYMD Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_RQSTYMD Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
	    cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_RQSTYMD event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_RQSTYMD event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_EV_RQSTYMD event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        if(row > 0) {
            fnc_EnableElementAll(elementList);
        }
    </script>


    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_EV_RQSTYMD event=CanRowPosChange(row)>
        var keyName;
        var colName;

        if(row > 0) {
            for(var i=0; i<keyList.length; i++) {
                keyName = keyList[i];
                colName = keyName.substring(3, keyName.length);

                if (dsT_EV_RQSTYMD.NameString(row, colName) == "" ) {
                    alert("[ " + grdT_EV_RQSTYMD.GetHdrDispName('-3', colName) + " ]은(는) 필수 입력사항입니다");
                    document.getElementById(keyName).focus();
                    return false;
                }
            }
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

<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">평가기간설정</td>
					<td align="right" class="navigator">HOME/인사평가/역량평가/<font color="#000000">평가기간설정</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image7" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="60"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">고과년월&nbsp;</td>
								<td class="padding2423">

                                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr>
                                            <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
											    <input type="text" id="txtEVA_YY_SHR" style="ime-mode:disabled" size="7" maxlength= "7" onkeypress="javascript:if(event.keyCode==13)fnc_SearchList(); cfDateHyphen(this);  cfNumberCheck()">
                                            </td>

                                        </tr>

                                    </table>

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
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">평가시작일</td>
					<td class="padding2423">
                        <input id="txtSTR_YMD" size="10" maxlength="10" onblur="if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this); bindEVA_YY();" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imdSTR_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imdSTR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','60','180');"></a>
                    </td>
                    <td align="center" class="creamBold">평가종료일</td>
					<td class="padding2423">
                        <input id="txtEND_YMD" size="10" maxlength="10" onblur="if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','60','180');"></a>
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
						<object	id="grdT_EV_RQSTYMD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
							<param name="DataID"					value="dsT_EV_RQSTYMD">
                            <param name="Format"					value="
								<C> id={currow}				width=65    	name='NO'		    	align=center </C>
								<C> id='EVAYM'	    		width=230		name='고과년월'	    align=center mask='XXXX-XX'</C>
                                <C> id='STR_YMD' 			width=230		name='평가 시작일'	    align=center </C>
								<C> id='END_YMD'			width=230		name='평가 종료일'	    align=center </C>
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

<!-- 역량평가 기간 설정 테이블 -->
<object id="bndT_EV_RQSTYMD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_EV_RQSTYMD">
    <Param Name="BindInfo", Value='
        <C> Col=EVAYM         Ctrl=txtEVAYM      		Param=value</C>
        <C> Col=STR_YMD      Ctrl=txtSTR_YMD      Param=value</C>
        <C> Col=END_YMD      Ctrl=txtEND_YMD      Param=value</C>
    '>
</object>