<!--
*****************************************************
* @source       : guna120.jsp
* @description : 소속별담당자등록 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/01/30      김학수        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>사용자직무등록(guna120)</title>
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
    var nscp = (navigator.appName == "Netscape")

    var btnList = 'TFTTFFTT';
    /***********************************
     * 01. 조회 함수_List 형태의 조회  *
     ***********************************/
    function fnc_SearchList() {
        //검색조건 2가지
        var DPT_CD_SHR = document.form1.txtDPT_CD_SHR.value;            //소속
        var DIL_AUTHO_SHR = document.form1.cmbDIL_AUTHO_SHR.value;      //조회그룹

        //역량 평가 적용 결과 정보 조회
        dsT_CM_EMPLIST.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna120.cmd.GUNA120CMD&S_MODE=SHR&DPT_CD="+DPT_CD_SHR+"&DIL_AUTHO="+DIL_AUTHO_SHR;
        dsT_CM_EMPLIST.reset();
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

        if(!fnc_SaveItemCheck()) return;

        trT_CM_EMPLIST.KeyValue = "tr01(I:dsT_CM_EMPLIST=dsT_CM_EMPLIST)";
        trT_CM_EMPLIST.action = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna120.cmd.GUNA120CMD&S_MODE=SAV";
        trT_CM_EMPLIST.post();
        fnc_SearchList();
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

        if (dsT_CM_EMPLIST.CountRow < 1) {
            alert("엑셀로 변환할 자료가 없습니다!");
            return;
        }

        form1.grdT_CM_EMPLIST.GridToExcel("소속별담당자등록", '', 225);

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
        document.getElementById("cmbDIL_AUTHO_SHR").value = '';

        document.getElementById("resultMessage").innerText = ' ';
        dsT_CM_EMPLIST.ClearAll();

    }

    /************************
     * 11. 화면 종료(닫기)  *
     ***********************/
    function fnc_Exit() {

        if (dsT_CM_EMPLIST.IsUpdated)  {
            if (!fnc_ExitQuestion()) return;
        }

        frame = window.external.GetFrame(window);
        frame.CloseFrame();

    }

    /******************************
     * 12. 검색 조건 유효성 검사  *
     ******************************/
    function fnc_SearchItemCheck(year) {

  //이곳에 해당 코딩을 입력 하세요

    }

    /*************************
     * 13. 저장 유효성 체크  *
     *************************/
    function fnc_SaveItemCheck() {

    	if (!dsT_CM_EMPLIST.IsUpdated) {
        	alert("저장할 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
            return false;
    	}

      	for(var i=1; i<=dsT_CM_EMPLIST.CountRow; i++){

			var GUN_DPT_CD = dsT_CM_EMPLIST.NameValue(i,"GUN_DPT_CD");
			var DIL_AUTHO = dsT_CM_EMPLIST.NameValue(i,"DIL_AUTHO");

			if(DIL_AUTHO == "S" && GUN_DPT_CD ==""){
	             dsT_CM_EMPLIST.RowPosition = i;
	             document.form1.txtGDPT_NM.focus();
	             alert("등록구분이 일반사원일 경우 해당 근태소속를 입력 하셔야 합니다.");
	             return false;
			}
		}

    	return true;

    }

    /********************************************
     * 14. Form Load 시 Default 작업 처리 부분  *
     *******************************************/
    function fnc_OnLoadProcess() {
		cfStyleGrid(form1.grdT_CM_EMPLIST,15,"false","true")      // Grid Style 적용

        fnc_DisableElementAll(elementList);

<%
    //관리자 권한이 아니라 근태 담당자 권한 이면 자신의 부서만 사용하게 만듬.
    if(!box.getString("SESSION_DIL_AUTHO").equals("M") ) {
%>
        document.getElementById("txtDPT_CD_SHR").value = "<%=box.getString("SESSION_DPTCD") %>";
        document.getElementById("txtDPT_NM_SHR").value = "<%=box.getString("SESSION_DPTNM") %>";

        fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
        fnc_ChangeStateElement(false, "txtDPT_NM_SHR");
        fnc_ChangeStateElement(false, "imgDPT_CD_SHR");
<%
    }
%>

        document.getElementById("txtDPT_CD_SHR").focus();
     }

    /********************
         * 15. 단축키 처리  *
         *******************/
    function fnc_HotKey() {
        fnc_HotKey_Process(btnList, event.keyCode);
    }


    /**
     * 근태권한이 변경 될때
     */
    function fnc_ChagneDil_autho() {
        var dil_autho   = document.getElementById("cmbDIL_AUTHO").value;
        var dpt_cd      = dsT_CM_EMPLIST.NameValue(dsT_CM_EMPLIST.RowPosition, "DPT_CD");

        //파견이 아닐때
        if (dil_autho == "A" || dil_autho == "") {
            document.getElementById("txtGDPT_CD").value = "";
            document.getElementById("txtGDPT_NM").value = "";

            fnc_ChangeStateElement(false, "txtGDPT_CD");
            fnc_ChangeStateElement(false, "imgGDPT_CD");
        }

        //파견사원일때
        else if(dil_autho == "S") {
            document.getElementById("txtGDPT_CD").value = "<%=box.getString("SESSION_DPTCD") %>";
            document.getElementById("txtGDPT_NM").value = "<%=box.getString("SESSION_DPTNM") %>";

<%
    //관리자 권한이 아니라 근태 담당자 권한 이면 자신의 부서만 사용하게 만듬.
    if(box.getString("SESSION_DIL_AUTHO").equals("M") ) {
%>
            fnc_ChangeStateElement(true, "txtGDPT_CD");
            fnc_ChangeStateElement(true, "imgGDPT_CD");

            document.getElementById("txtGDPT_CD").focus();
<%
    } else {
%>
            fnc_ChangeStateElement(false, "txtGDPT_CD");
            fnc_ChangeStateElement(false, "imgGDPT_CD");
<%
    }
%>
        }

        //새롭게 근태 담당자 권한으로 변경이 되면 관리자를 제외한 소속부서의 사람들의 근태 담당자 권한이 사라진다.
        if(dil_autho =="A") {

            //자기 부서의 시작을 가지고 온다.
            var first_idx = dsT_CM_EMPLIST.NameValueRow("DPT_CD", dpt_cd);
            var cur_dpt_cd;
            for(var i=first_idx; i<=dsT_CM_EMPLIST.CountRow; i++) {
                cur_dpt_cd = dsT_CM_EMPLIST.NameValue(i, "DPT_CD");

                //자기부서만
                if(dpt_cd != cur_dpt_cd)
                    break;

                //자기는 뛰어넘음
                if(document.getElementById("txtENO_NO").value == dsT_CM_EMPLIST.NameValue(i, "ENO_NO"))
                    continue;

                //근태 담당자를 초기화
                if(dsT_CM_EMPLIST.NameValue(i, "DIL_AUTHO") == "A")
                    dsT_CM_EMPLIST.NameValue(i, "DIL_AUTHO") = "";

            }
        }

    }

    var elementList = new Array( "txtGDPT_CD"
                               , "imgGDPT_CD"
                               , "cmbDIL_AUTHO" );

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_CM_EMPLIST                      |
    | 3. Table List : VI_T_CM_PERSON, T_CM_EMPLIST, T_CM_DEPT                  |
    +----------------------------------------------->
    <Object ID="dsT_CM_EMPLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_CM_EMPLIST)		|
    | 3. 사용되는 Table List(T_CM_PERSON, T_CM_EMPLIST)	            |
    +--------------------------------------------------->
    <Object ID ="trT_CM_EMPLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CM_EMPLIST Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_EMPLIST event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_EMPLIST event="OnFail()">
        cfErrorMsg(this);
    </script>



    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_CM_EMPLIST event=OnRowPosChanged(row)>
        fnc_ChangeStateElement(false, "cmbDIL_AUTHO");
        fnc_ChangeStateElement(false, "txtGDPT_CD");
        fnc_ChangeStateElement(false, "imgGDPT_CD");

        if(row > 0) {
            if(!(dsT_CM_EMPLIST.NameString(row, "DIL_AUTHO") == 'M'
                    || dsT_CM_EMPLIST.NameString(row, "ROLE_CD") == '1001'
                    || dsT_CM_EMPLIST.NameString(row, "ROLE_CD") == '1002'
                    || dsT_CM_EMPLIST.NameString(row, "ROLE_CD") == '1010'
                    || dsT_CM_EMPLIST.NameString(row, "ROLE_CD") == '1011')) {

                fnc_ChangeStateElement(true, "cmbDIL_AUTHO");

                if(dsT_CM_EMPLIST.NameString(row, "DIL_AUTHO") == 'S') {
                    fnc_ChangeStateElement(true, "txtGDPT_CD");
                    fnc_ChangeStateElement(true, "imgGDPT_CD");
                }
            }
        }
    </script>



    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_CM_EMPLIST event=CanRowPosChange(row)>
        if(row > 0) {
            //근태 권한 - A.근태담당자 S.파견사원 공백.권한X
    		if(dsT_CM_EMPLIST.NameValue(row,"GUN_DPT_CD") == ""
                    && dsT_CM_EMPLIST.NameValue(row,"DIL_AUTHO") =="S"){
	             document.getElementById("txtGDPT_NM").focus();
	             alert("등록구분이 일반사원일 경우 해당 근태소속를 입력 하셔야 합니다.");
                 return false;
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
          <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">사용자직무등록</td>
          <td align="right" class="navigator">HOME/근태관리/일일근태관리/<font color="#000000">사용자직무등록</font></td>
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
      <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
      <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>-->
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
                              <col width="60"></col>
                              <col width="200"></col>
                              <col width="80"></col>
                              <col width=""></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">소속&nbsp;</td>
                                <td class="padding2423">
                                	<input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                	<input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">조회구분&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbDIL_AUTHO_SHR" name="cmbDIL_AUTHO_SHR" style="WIDTH:100" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                       <option value=''>전 체</option>
                                       <option value='A'>근태담당자</option>
                                       <option value='S'>일반사원</option>
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

<table border="0"><tr><td height="10"></td></tr></table>

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
        <colgroup>
          <col width="50"></col>
          <col width="120"></col>
          <col width="50"></col>
          <col width="90"></col>
          <col width="50"></col>
          <col width="90"></col>
          <col width="50"></col>
          <col width="90"></col>
        </colgroup>
        <tr>
          <td align="center" class="creamBold">근태소속</td>
          <td class="padding2423">
            <input id=txtGDPT_CD name=txtGDPT_CD size="3" maxlength="2" readonly class="input_ReadOnly" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('A4','txtGDPT_CD','txtGDPT_NM');" onChange="fnc_GetCommNm('A4','txtGDPT_CD','txtGDPT_NM');">
            <input id=txtGDPT_NM name=txtGDPT_NM size="14" class="input_ReadOnly" readonly>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgGDPT_CD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgGDPT_CD" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtGDPT_CD','txtGDPT_NM','소속','DEPT')"></a>
          </td>
          <td align="center" class="creamBold">사&nbsp;&nbsp;원</td>
          <td class="padding2423">
            <input id=txtENO_NO name=txtENO_NO style="width:100%" class="input_ReadOnly" readonly>
          </td>
          <td align="center" class="creamBold">성&nbsp;&nbsp;명</td>
          <td class="padding2423">
            <input id=txtENO_NM name=txtENO_NM style="width:100%" class="input_ReadOnly" readonly>
          </td>
        </tr>
        <tr>
          <td align="center" class="creamBold">직&nbsp;&nbsp;위</td>
          <td class="padding2423">
            <input id=txtJOB_NM name=txtJOB_NM style="width:100%" class="input_ReadOnly" readonly>
          </td>
          <td align="center" class="creamBold">등록구분</td>
          <td class="padding2423" colspan="7">
            <select id="cmbDIL_AUTHO" name="cmbDIL_AUTHO" style="width:100" onChange="fnc_ChagneDil_autho()" disabled=true>
              <option value=''>없음</option>
              <option value='A'>근태담당자</option>
              <option value='S'>일반사원</option>
            </select>
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
            <object	id="grdT_CM_EMPLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:280px;">
              <param name="DataID"				value="dsT_CM_EMPLIST">
              <param name="EdiTABLE"				value="false">
              <param name="DragDropEnable"		value="true">
              <param name="SortView"				value="Left">
              <param name="VIEWSUMMARY"			value=0>
              <param name="Format"				value="
				<C> id='{CUROW}'			width=44		name='NO'			align=center		value={String(Currow)}</C>
                <C> id='DPT_NM'				width=120		name='소속'	        align=center	    Edit=None	 </C>
                <C> id='JOB_NM'				width=100		name='직위'		    align=center        Edit=None	 </C>
                <C> id='ENO_NO'				width=120		name='사번'		    align=center		Edit=None	 </C>
                <C> id='ENO_NM'				width=120		name='성명'		    align=center		Edit=None	 </C>
                <C> id='HIR_YMD'				width=120		name='입사일'		align=center		Edit=none	 </C>
                <C> id='DIL_AUTHO'	    	width=120		name='등록구분'	align=center		Edit=none		Value={Decode(DIL_AUTHO,'','일반','S','일반','A','근태담당자','M','Master')} </C>
                <C> id='GUN_DPT_NM'     	width=120      name='근태소속'    align=center        Edit=None   show=false </C>
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
<input type="hidden" name="txtDIL_AUTHO" value="1">
</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- -->
<object id="bndT_CM_EMPLIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
  <Param Name="DataID",   Value="dsT_CM_EMPLIST">
  <Param Name="BindInfo", Value='
    <C>Col=GUN_DPT_CD     Ctrl=txtGDPT_CD          Param=value</C>
    <C>Col=GUN_DPT_NM     Ctrl=txtGDPT_NM  		   Param=value</C>
    <C>Col=ENO_NO		  Ctrl=txtENO_NO      	   Param=value</C>
    <C>Col=ENO_NM    	  Ctrl=txtENO_NM      	   Param=value</C>
    <C>Col=JOB_NM		  Ctrl=txtJOB_NM     	   Param=value</C>
    <C>Col=DIL_AUTHO	  Ctrl=cmbDIL_AUTHO	       Param=value</C>
    '>
</object>