<!--
***********************************************************************
* @source      : weld040.jsp
* @description : 콘도성수기관리 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/12/15      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>콘도성수기관리(weld040)</title>
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
		var emp_Sbutton = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var ord_year = document.getElementById('txtYEAR_SHR').value;

			if(!fnc_SearchItemCheck()) return;

			dsT_WL_CONDOSSN.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld040.cmd.WELD040CMD&S_MODE=SHR&ORD_YEAR="+ord_year;
    		dsT_WL_CONDOSSN.reset();

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

			trT_WL_CONDOSSN.KeyValue = "tr01(I:dsT_WL_CONDOSSN=dsT_WL_CONDOSSN)";
			trT_WL_CONDOSSN.action = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld040.cmd.WELD040CMD&S_MODE=SAV";
			trT_WL_CONDOSSN.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

			if(dsT_WL_CONDOSSN.CountRow < 1) {
				alert("삭제할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
			if(confirm("[관리번호:"+dsT_WL_CONDOSSN.NameValue(dsT_WL_CONDOSSN.RowPosition,'ORD_NO')+"]의 정보를 삭제하시겠습니까?")){
				dsT_WL_CONDOSSN.DeleteRow(dsT_WL_CONDOSSN.RowPosition);
				trT_WL_CONDOSSN.KeyValue = "tr01(I:dsT_WL_CONDOSSN=dsT_WL_CONDOSSN)";
				trT_WL_CONDOSSN.action = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld040.cmd.WELD040CMD&S_MODE=DEL";
				trT_WL_CONDOSSN.post();
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
			if(dsT_WL_CONDOSSN.CountColumn < 1){
				alert("조회 후 신규작성이 가능합니다!");
				return;
			}
			var maxRow = dsT_WL_CONDOSSN.CountRow;
			var ord_no = 0;

			if(maxRow < 1){
				ord_no = getToday().substring(0,4)+"-01";
			} else {
				ord_no = dsT_WL_CONDOSSN.NameMax("ORD_NO", 0, 0).substring(0,4)+ "-" +
                         lpad((parseInt(dsT_WL_CONDOSSN.NameMax("ORD_NO", 0, 0).substring(5,7))+1), 2, '0');
			}

			dsT_WL_CONDOSSN.AddRow();
            if(dsT_WL_CONDOSSN.NameValue(dsT_WL_CONDOSSN.RowPosition, 'ORD_NO') == "")
    			dsT_WL_CONDOSSN.NameValue(dsT_WL_CONDOSSN.RowPosition, 'ORD_NO') = ord_no;
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
			document.getElementById("resultMessage").innerText = ' ';

			dsT_WL_CONDOSSN.ClearData();
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_WL_CONDOSSN.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

			var ord_year = document.getElementById('txtYEAR_SHR').value;

			if(ord_year != '' && ord_year.length != 4){
				alert("연도는 반드시 4자리를 입력하셔야 합니다!");
				document.getElementById('txtYEAR_SHR').focus();
				return false;
			}
			return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_WL_CONDOSSN.IsUpdated ) {
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


			cfStyleGrid(form1.grdT_WL_CONDOSSN,15,"false","false");      // Grid Style 적용

            document.getElementById("txtYEAR_SHR").value = getTodayArray()[0];
            document.getElementById('txtYEAR_SHR').focus();

            fnc_DisableElementAll(elementList);
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}
        
        var elementList = new Array(         "txtORD_NO"
                                            ,"txtSTR_YMD"
                                            ,"txtEND_YMD"
                                            ,"txtAPP1_YMD"
                                            ,"txtAPP2_YMD" 
                                            ,"imgSTR_YMD"
                                            ,"imgEND_YMD"
                                            ,"imgAPP1_YMD"
                                            ,"imgAPP2_YMD" );
                                            
        var exceptionList = new Array(       "txtORD_NO" );
        
        var keyList = new Array(             "txtORD_NO"
                                            ,"txtSTR_YMD"
                                            ,"txtEND_YMD"
                                            ,"txtAPP1_YMD"
                                            ,"txtAPP2_YMD" );


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_WL_CONDOSSN) |
    | 3. 사용되는 Table List(T_WL_CONDOSSN)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_CONDOSSN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_WL_CONDOSSN)	|
    | 3. 사용되는 Table List(T_WL_CONDOSSN)	            |
    +--------------------------------------------------->
    <Object ID ="trT_WL_CONDOSSN" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_WL_CONDOSSN Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_WL_CONDOSSN Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_CONDOSSN Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[관리번호] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("관리번호에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_WL_CONDOSSN event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_WL_CONDOSSN event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_WL_CONDOSSN event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        
        if(row > 0) {
            //신규일 경우        
            if(dsT_WL_CONDOSSN.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else {
                fnc_EnableElementAll(elementList, exceptionList);
            }
        }
    </script>
 
    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_WL_CONDOSSN event=CanRowPosChange(row)>
        var keyName;
        var colName;
        
        if(row > 0) {
            for(var i=0; i<keyList.length; i++) {
                keyName = keyList[i];
                colName = keyName.substring(3, keyName.length);
                
                if (dsT_WL_CONDOSSN.NameString(row, colName) == "" ) {
                    alert("[ " + grdT_WL_CONDOSSN.GetHdrDispName('-3', colName) + " ]은(는) 필수 입력사항입니다");
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">콘도성수기관리</td>
					<td align="right" class="navigator">HOME/복리후생/콘도/<font color="#000000">콘도성수기관리</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
								<col width="80"></col>
								<col width="*"></col>
							</colgroup>
							<tr>
								<td align="right" class="searchState">연도&nbsp;</td>
								<td class="padding2423">
									<input id="txtYEAR_SHR"  size="4" maxLength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfCheckNumber2();" style="ime-mode:disabled">
								</td>
								<td>&nbsp;<td>
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
					<col width="60"></col>
					<col width="70"></col>
					<col width="60"></col>
					<col width="230"></col>
					<col width="60"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">관리번호</td>
					<td class="padding2423">
						<input id="txtORD_NO"  size="10" maxLength="7" style="ime-mode:disabled;text-align:center">
					</td>
					<td align="center" class="creamBold">성수기</td>
					<td class="padding2423">
						<input id="txtSTR_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD','txtSTR_YMD','txtEND_YMD'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> 
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(dsT_WL_CONDOSSN.CountColumn < 1) return; calendarBtn('datetype1','txtSTR_YMD','','150','152');"></a>
                         ~
						<input id="txtEND_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtEND_YMD','txtSTR_YMD','txtEND_YMD'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> 
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(dsT_WL_CONDOSSN.CountColumn < 1) return; calendarBtn('datetype1','txtEND_YMD','','270','152');"></a>
					</td>
					<td align="center" class="creamBold">신청기간</td>
					<td class="padding2423">
						<input id="txtAPP1_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtAPP1_YMD','txtAPP1_YMD','txtAPP2_YMD'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> 
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPP1_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgAPP1_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(dsT_WL_CONDOSSN.CountColumn < 1) return; calendarBtn('datetype1','txtAPP1_YMD','','450','152');"></a>
                         ~
						<input id="txtAPP2_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtAPP2_YMD','txtAPP1_YMD','txtAPP2_YMD'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> 
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPP2_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgAPP2_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(dsT_WL_CONDOSSN.CountColumn < 1) return; calendarBtn('datetype1','txtAPP2_YMD','','570','152');"></a>
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
						<object	id="grdT_WL_CONDOSSN" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"					value="dsT_WL_CONDOSSN">
							<param name="Format"					value="
								<C> id={currow}		width=70    name='NO'			align=center </C>
								<C> id='ORD_NO'		width=155	name='관리번호'		align=center </C>
								<C> id='STR_YMD'	width=20	name='성수기시작일'	align=center Show=false </C>
								<C> id='END_YMD'	width=20	name='성수기종료일'	align=center Show=false </C>
								<C> id='YMD'		width=270	name='성수기'		align=center Value={(STR_YMD&' ~ '&END_YMD)} </C>
								<C> id='APP1_YMD'	width=20	name='신청시작일'	align=center Show=false </C>
								<C> id='APP2_YMD'	width=20	name='신청종료일'	align=center Show=false </C>
								<C> id='APP_YMD'	width=270	name='신청기간'		align=center Value={(APP1_YMD&' ~ '&APP2_YMD)} </C>
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
<!-- KPI Pool 설정 테이블 -->
<object id="bndT_WL_CONDOSSN" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_WL_CONDOSSN">
	<Param Name="BindInfo", Value='
		<C>Col=ORD_NO		Ctrl=txtORD_NO	      	Param=value</C>
		<C>Col=STR_YMD    	Ctrl=txtSTR_YMD	     	Param=value</C>
		<C>Col=END_YMD		Ctrl=txtEND_YMD	      	Param=value</C>
		<C>Col=APP1_YMD		Ctrl=txtAPP1_YMD		Param=value</C>
		<C>Col=APP2_YMD		Ctrl=txtAPP2_YMD		Param=value</C>
    '>
</object>