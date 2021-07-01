<!--
***********************************************************************
* @source      : welb040.jsp
* @description : 임원월별사용료관리 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/12/08      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>임원월별사용료관리(welb040)</title>
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

		var btnList = 'TFTTFFTT';
        var type = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var pis_yymm = document.getElementById('txtPIS_YM_SHR').value;

            form1.document.getElementById("grdT_WL_HDPCBOOK").focus();


			dsT_WL_HDPCBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb040.cmd.WELB040CMD&S_MODE=SHR&PIS_YY="+pis_yymm.substring(0,4)+"&PIS_MM="+pis_yymm.substring(5,7);
    		dsT_WL_HDPCBOOK.reset();

            //조회할때 초기화
            fnc_EnableElementAll(shrList);
            dsT_WL_HDPCBOOK.UseChangeInfo = true;
            type = "";

            if(dsT_WL_HDPCBOOK.NameValue(1,"JOB_NM") == null){
              fnc_ShowElement("imgConduct");
              fnc_ShowElement("Image4");
              fnc_HiddenElement("imgConfirm");
              fnc_ShowElement("Image5");
           }

        }


        /**
         * 처리 로직
         */
        function fnc_Proc() {
            var pis_yymm = document.getElementById('txtPIS_YM_SHR').value;

            if(pis_yymm == "") {
                alert("대상 년월을 입력하세요");
                return;
            }

            dsT_WL_HDPCBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb040.cmd.WELB040CMD&S_MODE=SHR_PROC&PIS_YY="+pis_yymm.substring(0,4)+"&PIS_MM="+pis_yymm.substring(5,7);
            dsT_WL_HDPCBOOK.reset();

            fnc_DisableElementAll(shrList);
            dsT_WL_HDPCBOOK.UseChangeInfo = false;  //강제로 모두 입력하게 설정(insert 처리)
            type = "PROC";
            alert("지원 대상자 확인 후 저장 버튼을 누르세요");
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

			trT_WL_HDPCBOOK.KeyValue = "tr01(I:dsT_WL_HDPCBOOK=dsT_WL_HDPCBOOK)";
			trT_WL_HDPCBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb040.cmd.WELB040CMD&S_MODE=SAV&TYPE="+type;
			trT_WL_HDPCBOOK.post();

            fnc_ShowElement("imgConfirm");
         }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

			if(dsT_WL_HDPCBOOK.CountRow < 1) {
				alert("삭제할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
			if(confirm("선택하신 [지원년월:"+dsT_WL_HDPCBOOK.NameValue(dsT_WL_HDPCBOOK.RowPosition,'PIS_YM')+" 휴대폰번호:"+dsT_WL_HDPCBOOK.NameValue(dsT_WL_HDPCBOOK.RowPosition,'PHN_NO')+"] 에 해당하는 데이터를 삭제합니다.\n삭제하시겠습니까?")){
				dsT_WL_HDPCBOOK.DeleteRow(dsT_WL_HDPCBOOK.RowPosition);

				trT_WL_HDPCBOOK2.KeyValue = "tr01(I:dsT_WL_HDPCBOOK=dsT_WL_HDPCBOOK)";
				trT_WL_HDPCBOOK2.action = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb040.cmd.WELB040CMD&S_MODE=DEL&PIS_YY="+dsT_WL_HDPCBOOK.NameValue(dsT_WL_HDPCBOOK.RowPosition,'PIS_YY')+"&PIS_MM="+dsT_WL_HDPCBOOK.NameValue(dsT_WL_HDPCBOOK.RowPosition,'PIS_MM');
				trT_WL_HDPCBOOK2.post();
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

			if (dsT_WL_HDPCBOOK.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_WL_HDPCBOOK.GridToExcel("핸드폰 보조비 내역", '', 225);

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

			document.getElementById("resultMessage").innerText = ' ';
			dsT_WL_HDPCBOOK.ClearData();

            fnc_EnableElementAll(shrList);

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_WL_HDPCBOOK.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

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
            if (!dsT_WL_HDPCBOOK.IsUpdated && dsT_WL_HDPCBOOK.UseChangeInfo) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }

            if(type == "PROC"
                    && !confirm(document.getElementById('txtPIS_YM_SHR').value+" 데이터를 신규로 생성합니다.\n기존 데이터는 초기화 됩니다. 진행하시겠습니까?"))
                return false;

			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
          function fnc_OnLoadProcess() {
 //           cfStyleGrid2(form1.grdT_WL_HDPCBOOK);      // Grid Style 적용
            cfStyleGrid(form1.grdT_WL_HDPCBOOK,15,"false","false");      // Grid Style 적용

            form1.grdT_WL_HDPCBOOK.Editable = "true";

            document.getElementById('txtPIS_YM_SHR').value = getTodayArray()[0]+"-"+getTodayArray()[1];
            document.getElementById('txtPIS_YM_SHR').focus();

        }

            //완료 시 버튼 안보이게
           function hid_button() {

           var pis_yymm = document.getElementById('txtPIS_YM_SHR').value;
           dsT_WL_HDPCBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb040.cmd.WELB040CMD&S_MODE=FINSHR&PIS_YY="+pis_yymm.substring(0,4)+"&PIS_MM="+pis_yymm.substring(5,7);
    	   dsT_WL_HDPCBOOK.reset();

           var YN_TAG = document.getElementById('hidYN_TAG').value;

      	   if(YN_TAG >0 ){
    	      fnc_HiddenElement("imgConduct");
              fnc_HiddenElement("Image4");
              fnc_HiddenElement("imgConfirm");
              fnc_HiddenElement("Image5");
    	   }
    	   else{
            fnc_ShowElement("imgConduct");
            fnc_ShowElement("Image4");
            fnc_ShowElement("imgConfirm");
            fnc_ShowElement("Image5");
            }

            fnc_SearchList();
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        var shrList = new Array(     "txtPIS_YM_SHR"
                                    ,"imgPIS_YM_SHR"
                                );


         /**
         * 완료 로직
         */
        function fnc_Fins()
        {
         if(dsT_WL_HDPCBOOK.CountRow < 1) {
				alert("조회나 처리->저장 버튼을 누르신 후 완료작업을 하십시오.");
			}
	    else{
	          var pis_yymm = document.getElementById('txtPIS_YM_SHR').value;


			trT_WL_HDPCBOOK.KeyValue = "tr01(O:dsT_WL_HDPCBOOK=dsT_WL_HDPCBOOK)";
		    trT_WL_HDPCBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb040.cmd.WELB040CMD&S_MODE=FINS&PIS_YY="+pis_yymm.substring(0,4)+"&PIS_MM="+pis_yymm.substring(5,7);
			trT_WL_HDPCBOOK.post();

			fnc_HiddenElement("imgConduct");
            fnc_HiddenElement("Image4");
            fnc_HiddenElement("imgConfirm");
            fnc_HiddenElement("Image5");


		    }
        }

        //달력 포커스 제어
          function card_con(){
           document.getElementById('grdT_WL_HDPCBOOK').focus();
           document.getElementById('txtPIS_YM_SHR').focus();
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
    | 2. 이름은 ds_ + 주요 테이블명(dsT_WL_HDPCBOOK) |
    | 3. 사용되는 Table List(T_WL_HDPCBOOK)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_HDPCBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_WL_HDPCBOOK)	|
    | 3. 사용되는 Table List(T_WL_HDPCBOOK)	            |
    +--------------------------------------------------->
    <Object ID ="trT_WL_HDPCBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    <Object ID ="trT_WL_HDPCBOOK2" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_WL_HDPCBOOK Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_WL_HDPCBOOK Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_HDPCBOOK Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[사번] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("사번에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_WL_HDPCBOOK event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>
    <script for=trT_WL_HDPCBOOK2 event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_WL_HDPCBOOK event="OnFail()">
        cfErrorMsg(this);
    </script>
    <script for=trT_WL_HDPCBOOK2 event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess(); hid_button();">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" onblur="card_con();" ></iframe>
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">임원월별사용료관리</td>
					<td align="right" class="navigator">HOME/복리후생/휴대폰관리/<font color="#000000">임원월별사용료관리</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)"><img src="/images/button/btn_ConductOn.gif" name="imgConduct" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Proc()"></a>
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
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
									<col width="70"></col>
									<col width="80"></col>
                             		<col width="*"></col>
								</colgroup>
							<tr>
								<td align="center" class="searchState">지원년월&nbsp;</td>
								<td class="padding2423">
                                    <input id="txtPIS_YM_SHR" size="7" maxlength="7" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfCheckNumber();" onkeyup="cfDateHyphen(this);" style="ime-mode:disabled" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; this.focus();} hid_button();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','10','116');"></a>
                                </td>
								<td>&nbsp;</td>
								<td>
								</td>
								<td class="padding2423">
                                      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConfirm','','/images/button/btn_OutOver.gif',1)"><img src="/images/button/btn_OutOn.gif" name="imgConfirm" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Fins()"></a>
                                      <input type="hidden" id="hidYN_TAG">
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
						<object	id="grdT_WL_HDPCBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
							<param name="DataID"	 value="dsT_WL_HDPCBOOK">
                            <param name="ColSelect"  value="true">
                            <param name="Editable"   value="true">
							<param name="Format"					value="
								<C> id={currow}		 width=55   name='NO'			align=center </C>
                                <C> id='JOB_NM'      width=90   name='직위'           align=left Edit=None </C>
                                <C> id='ENO_NO'      width=95   name='사번'           align=center Edit=None </C>
                                <C> id='ENO_NM'      width=95   name='성명'           align=center Edit=None </C>
                                <C> id='NM_GBN_VAL'  width=90   name='구분'           align=center Edit=None Value={Decode(NAME_GBN,'1','법인명의','2','개인명의')}</C></C>
                                <C> id='PHN_NO'      width=120  name='휴대폰번호'     align=left Edit=None </C>
								<C> id='PIS_YM'	     width=90	name='지원종료월'	  align=center Edit=None </C>
								<C> id='KR_USE_AMT'	 width=130	name='사용료'		  align=right BgColor='#F0FFF0'</C>
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


<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																			 *
    *                                       												 *
    ***************************************************************************************-->

<!-- T_AC_CEFBOOK 설정 테이블 -->
	<!-- T_ID_CEFBOOK 설정 테이블 -->
	<object id="bndT_WL_HDPCBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_WL_HDPCBOOK">
		<Param Name="BindInfo", Value="
			<C>Col=YN_TAG      Ctrl=hidYN_TAG     Param=value</C>
		">
	</object>