<!--
    ************************************************************************************
    * @Source         : misb280.jsp                                                    *
    * @Description    : 고용직업분류표 PAGE                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/23  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>고용직업분류표(misb280)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'TFFTFTTT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var GBN     = document.getElementById("cmbGBN_SHR").value;
            var DPT_CD  = document.getElementById("txtDPT_CD_SHR").value;
            var ENO_NO  = document.getElementById("txtENO_NO_SHR").value;

            dsT_CM_PERSON.ClearData();

            dsT_CM_PERSON.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.b.misb280.cmd.MISB280CMD&S_MODE=SHR&GBN="+GBN+"&DPT_CD="+DPT_CD+"&ENO_NO="+ENO_NO;
            dsT_CM_PERSON.Reset();

            form1.grdT_CM_PERSON.Focus();

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

            if(fnc_SaveItemCheck()) {

                trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.mis.b.misb280.cmd.MISB280CMD&S_MODE=SAV";
                trT_CM_PERSON.post();

            }

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            //이곳에 해당 코딩을 입력 하세요

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

            if (dsT_CM_PERSON.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CM_PERSON.GridToExcel("고용직업분류표", '', 225);

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

            document.getElementById("cmbGBN_SHR").value = '1';
            document.getElementById("txtDPT_CD_SHR").value = '';
            document.getElementById("txtDPT_NM_SHR").value = '';
            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';

            document.getElementById("resultMessage").innerText = ' ';

			disableInput()

            // DataSet Clear
            dsT_CM_PERSON.ClearData();

            document.getElementById("cmbGBN_SHR").focus();

        }

        /******************************
         * 11. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 12. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            // DataSet의 변경 여부 확인
            if ( !dsT_CM_PERSON.IsUpdated ) {

                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid(form1.grdT_CM_PERSON,0,"true","false");

           document.form1.cmbGBN_SHR.selectedIndex  = 1;
           document.getElementById("cmbGBN_SHR").focus();

			// 직업분료코드종류 구분 콤보박스 생성(입력)
			for( var i = 1; i <= dsT_CM_COMMON_NS.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
				oOption.value = dsT_CM_COMMON_NS.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_NS.NameValue(i,"CODE_NAME");
				document.getElementById("cmbNSO_CD").add(oOption);
			}

			disableInput();

            document.getElementById("cmbGBN_SHR").focus();

        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

         /********************************************
         * 입력필드 사용 가능하게(Enable)          		 *
         ********************************************/
  		function enableInput(){
  			document.getElementById("cmbNSO_CD").disabled  = false;   // 직업분류코드종류
  			document.getElementById("imgExcel").disabled   = false;   // 엑셀 활성화
  		}

        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput(){
  			document.getElementById("txtDPT_NM").readOnly   = true;
  			document.getElementById("txtDPT_NM").className = "input_ReadOnly";
  			document.getElementById("txtJOB_NM").readOnly   = true;
  			document.getElementById("txtJOB_NM").className = "input_ReadOnly";
  			document.getElementById("txtENO_NO").readOnly   = true;
  			document.getElementById("txtENO_NO").className = "input_ReadOnly";
  			document.getElementById("txtENO_NM").readOnly   = true;
  			document.getElementById("txtENO_NM").className = "input_ReadOnly";
  			document.getElementById("cmbNSO_CD").disabled  = true;   // 직업분류코드종류
  			document.getElementById("imgExcel").disabled   = true;   // 엑셀 비활성화
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
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)    |
    | 3. 사용되는 Table List(T_CM_PERSON)           |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_PERSON)">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
	<!-- 가우스 데이터셋 오브젝트 [코드 리스트] : dsT_CM_COMMON_NS -->
	<object id="dsT_CM_COMMON_NS" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<param name="Syncload" value="false">
		<param name="DataId"   value="/common/codeList.jsp?CODE_GUBUN=NS">
		<param name="UseFilter"   value="false">
	</object>


    <!-- 통계청분류 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_NS"/>
       <jsp:param name="CODE_GUBUN"    value="NS"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_PERSON.CountRow );
			enableInput();
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_PERSON event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_PERSON event="OnFail()">

        cfErrorMsg(this);

    </script>

<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">고용직업분류표</td>
                    <td align="right" class="navigator">HOME/경영정보/통계현황/<font color="#000000">고용직업분류표</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="ImgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="110"></col>
                                <col width="70"></col>
                                <col width="220"></col>
                                <col width="70"></col>
                                <col width="220"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">구분&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <select id="cmbGBN_SHR">
                                        <option value="0">전체</option>
                                        <option value="1">재직자</option>
                                        <option value="2">퇴사자</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">부서</td>
                                <td class="padding2423"><input name=txtDPT_CD_SHR size="3"  maxlength="3" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input name=txtDPT_NM_SHR size="20" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image11" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">사번</td>
                                <td class="padding2423"><input name=txtENO_NO_SHR size="10"  maxlength="10" style="ime-mode:disabled" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','1','1');"> <input name=txtENO_NM_SHR size="12" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR','','','','','2')"></a>
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
					<td align="center" class="creamBold">소속</td>
					<td class="padding2423">
						<input type="text" id="txtDPT_NM" style="width='100%'">
					</td>
					<td align="center" class="creamBold">직위</td>
					<td class="padding2423">
						<input type="text" id="txtJOB_NM" style="width='100%'">
					</td>
					<td align="center" class="creamBold">사번</td>
					<td class="padding2423">
						<input type="text" id="txtENO_NO" style="width='100%'">
					</td>
					<td align="center" class="creamBold">성명</td>
					<td class="padding2423">
						<input type="text" id="txtENO_NM" style="width='100%'">
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">고용직업분류</td>
					<td class="padding2423" colspan="7">
						<select id="cmbNSO_CD" style="width:210" onchange="document.getElementById('txtNSO_NM').value = this.options[this.selectedIndex].text">
							<option></option>
						</select>
						<input type="hidden" id="txtNSO_NM" name="txtNSO_NM">
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
        <td class="paddingTop5">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                            <param name="DataID"                  value="dsT_CM_PERSON">
                            <param name="EdiTABLE"                value="true">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=50    name='순번'          align=center  Edit='None' </C>
                                <C> id='HEAD_NM'      width=120   name='본부'          align=left    Edit='None' </C>
                                <C> id='DPT_NM'       width=120   name='소속'          align=left    Edit='None' </C>
                                <C> id='JOB_NM'       width=100   name='직위'          align=center  Edit='None' </C>
                                <C> id='ENO_NO'       width=80   name='사번'          align=center  Edit='None' </C>
                                <C> id='ENO_NM'       width=80   name='성명'          align=center  Edit='None' </C>
                                <C> id='NSO_CD'       width=40    name='코드'          align=left    Edit='None' </C>
                                <C> id='NSO_NM'       width=190   name='고용직업분류'  align=left    Edit='None' </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!--                                 <C> id='NSO_CD'       width=190   name='고용직업분류'    align=left    EditStyle=Lookup  Data='dsCOMMON_NS:CODE:CODE_NAME'</C> -->

<!-- 내용 조회 그리드 테이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<object id="bndT_CM_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CM_PERSON">
	<Param Name="BindInfo", Value="
		<C>Col=DPT_NM     		 	Ctrl=txtDPT_NM	     		 	Param=value 		</C>
		<C>Col=JOB_NM	     	 	Ctrl=txtJOB_NM	     		 	Param=value 		</C>
		<C>Col=ENO_NO				Ctrl=txtENO_NO    		 		Param=value	 		</C>
		<C>Col=ENO_NM				Ctrl=txtENO_NM 		   	 		Param=value	 		</C>
		<C>Col=NSO_CD				Ctrl=cmbNSO_CD	 	   	 		Param=value		 	</C>
		<C>Col=NSO_NM				Ctrl=txtNSO_NM	 	   	 		Param=value		 	</C>
    ">
</object>