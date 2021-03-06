<!--
*****************************************************
* @source       : misa010.jsp
* @description : 본부별 인원현황 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/04/12      이승욱        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
//************************************************************** ezgen
String a1 = "";
String b1 = "";
//************************************************************** ezgen
%>



<html>
<head>
<title>본부별 인원현황(eisa010)</title>
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
    var nscp = (navigator.appName == "Netscape")
    
    var btnList = 'TFTTFFTT';
    /***********************************
     * 01. 조회 함수_List 형태의 조회  *
     ***********************************/
    function fnc_SearchList() {
        var f = document.form1;
		/*
      	if( document.form1.rdoGBN_CASE[0].checked ){
       		var GBN_CASE = "HEAD_CD";
       	} else if( document.form1.rdoGBN_CASE[1].checked ){
       		var GBN_CASE = "GBN2_TAG";
       	}
		*/
		var GBN_CASE = "HEAD_CD";
        f.rptObject.SetValue("Group GBN_CASE", GBN_CASE);
        f.rptObject.RunButton("Command_Search");
    }

    /***********************************
     * 02. 조회 함수_Item 형태의 조회  *
     ***********************************/
    function fnc_SearchItem() {

        //이곳에 해당 코딩을 입력 하세요

    }

    /******************"C:/project000/MASA(back_up)/소스/data2/htdocs2/PMSL/js/comFunction.js"
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
        var f = document.form1;
        if ( f.flag.value == "Y" ) 
        {   
             form1.aaa.RunButton('print_go');
        }
        else alert("문서조회 후 인쇄 하시기 바랍니다.");
    }

    /***********************
     * 06. 엑셀 저장 함수  *
     ***********************/
    function fnc_ToExcel() {

        var f = document.form1;
        f.rptObject.RunButton("Picture_Excel");

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
        var f = document.form1;
        f.rptObject.RunButton("Command_Cansle");

    }

    /************************
     * 11. 화면 종료(닫기)  *
     ***********************/
    function fnc_Exit() {

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

    }

    /********************************************
     * 14. Form Load 시 Default 작업 처리 부분  *
     *******************************************/
    function fnc_OnLoadProcess() {


     }

    /********************
    * 15. 단축키 처리  *
    *******************/
    function fnc_HotKey() {

      fnc_HotKey_Process(btnList, event.keyCode);

    }
    
    /********************************************
    * 날짜 형식 유효성 체크                     *
    ********************************************/
        function fncCheckDate(obj) {
            return; 
        }

    /********************************************
    * ez-gen 버튼 클릭 이벤트                   *
    ********************************************/
    function winclose()
    {
        window.close();
    }
    function goclick(x)
    {   
        if( !document.form1.aaa.RunButton(x)) alert("개체가 없습니다.");
    }    

    
    /************************************************
     * 본부 및 소속코드 팝업창 처리                 *
     ************************************************/
    function fnc_DptNmPopup(gbn) {
        
        var obj = new String();

        if (gbn == 'DEPT') {
            obj.title = '부서';
            obj.gbn   = 'DEPT2';
            
            window.showModalDialog("/common/popup/codenm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
            if(obj.comm_cd != '' && obj.comm_nm != '') {
                document.getElementById('txtDPT_CD').value  = obj.comm_cd;
                document.getElementById('txtDPT_NM').value  = obj.comm_nm;
                document.getElementById('txtCD_GBN').value  = obj.cd_gbn;
            }
        }
    }

        /*************************************************
         * 소속 및 팀코드 입력시 해당 명 DISPLAY         *
         ************************************************/
        function fnc_CommNm(gbn) {

            // 소속코드
            document.getElementById('txtCD_GBN').value  = "";
            document.getElementById('txtDPT_NM').value  = "";                        
            // 소속코드
            fnc_GetCommNm('A4', 'txtDPT_CD','txtDPT_NM');

            if (document.getElementById('txtDPT_NM').value != "") {
                document.getElementById('txtCD_GBN').value  = "A4";
            } else {
                fnc_GetCommNm('B2', 'txtDPT_CD','txtDPT_NM');
				if (document.getElementById('txtDPT_NM').value != "") {
				    document.getElementById('txtCD_GBN').value  = "B2";
                }
            }
        }

    </script>

<SCRIPT ID=clientHnwActivEvent LANGUAGE=javascript FOR="rptObject" EVENT="FireEvent(nParam1,nParam2,strParam)">
<!-- //EZgen에 FireEvent 버튼 실행시 발생됨 -->
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
</SCRIPT>
</head>
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll="auto" onkeydown = "fnc_HotKey();">
	<!-- form 시작 -->
	<form name="form1">

	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">본부별인원현황</td>
					<td align="right" class="navigator">HOME/경영정보/인원현황/<font color="#000000">본부별 인원현황</font></td>
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
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"> <img src="/images/button/btn_SearchOn.gif" name="Image3"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
      <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"> <img src="/images/button/btn_AddnewOn.gif" name="Image2"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()">    </a-->
      <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">   <img src="/images/button/btn_SaveOn.gif"   name="Image4"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()">      </a-->
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="Image1"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()">     </a>
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"><img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()">   </a>
      <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"> <img src="/images/button/btn_DeleteOn.gif" name="Image5"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()">    </a-->
      <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="Image6"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()">     </a-->
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">   <img src="/images/button/btn_ExitOn.gif"   name="Image6"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()">      </a>
    </td>
  </tr>
</table>
<!-- 버튼 테이블 끝 -->
<!-- power Search테이블 시작 
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
                     <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="searchState" align="center" class="creamBold" width="80">출력조건</td>
                                <td align="left" class="padding2423">
                                    &nbsp;&nbsp;
                                    <input type="radio" name="rdoGBN_CASE" id="rdoGBN_CASE" style="margin-bottom:-2px;border:0;" checked>사업본부별&nbsp;&nbsp;&nbsp;
                                    <input type="radio" name="rdoGBN_CASE" id="rdoGBN_CASE" style="margin-bottom:-2px;border:0;">본사구분별
                                </td>
                            </tr>
                        </table>
                    </td>
    </tr>
</table>
<!-- power Search테이블 끝 -->

        <comment id="__NSID__">
              <object id="rptObject" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
              <param name="hnwsrc"    VALUE="misa010.hnw">
              <param name="initvalue" VALUE="">
              <param name="hidewnd"   VALUE="N">
              <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
              </object>
        </comment>
		<script> __ShowEmbedObject(__NSID__); </script>
	</form>


</body>
</html>
