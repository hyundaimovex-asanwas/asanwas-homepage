<!--
*****************************************************
* @source       : misc210.jsp
* @description  : 직급별 인원충원 현황 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/04/26      이승욱        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>실적대비 인원충원계획(misc210)</title>
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

        var str_ymd = f.cmbPIS_YY_SHR.value;
        //var dpt_cd  = f.txtDPT_CD.value;
        //var dpt_nm  = f.txtDPT_NM.value;
        //var cd_gbn  = f.txtCD_GBN.value;
        var url = "misc210_PV.jsp?pln_yy="+str_ymd;
        window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

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

  // 엑셀로 변환 할 자료가 있는지 체크하고
  // 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

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

        for( i = -1; i<= 10; i++ ) {
            Opis_yy = document.createElement("OPTION");
            Opis_yy.value = Number(getToday().substr(0,4)) - i;
            Opis_yy.text  = Number(getToday().substr(0,4)) - i;
            document.getElementById("cmbPIS_YY_SHR").add(Opis_yy);
        }
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
          <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">직급별 인원충원 현황</td>
          <td align="right" class="navigator">HOME/경영정보/사업계획/<font color="#000000">직급별 인원충원 현황</font></td>
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
      <!-- a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a -->
      <!-- a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"</a> -->
      <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>-->
      <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>-->
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
    </td>
  </tr>
</table>
<!-- 버튼 테이블 끝 -->


<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="right" class="searchState" width="64">사업년도&nbsp;</td>
                                <td class="padding2423" width = "96">
                                    <select id="cmbPIS_YY_SHR" name="cmbPIS_YY_SHR"  onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                                </td>
                                <td class="searchState" align="right" width="*">&nbsp;</td>
                            </tr>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search테이블 끝 -->

<table border="0"><tr><td height="5"></td></tr></table>

<!--************************************************************** ezgen -->
<table border=0>
    <tr height="1">
        <td width="1">
            <table border="00" bordercolordark="white" bordercolorlight="gray" bordercolor="gray">
<!--
                <comment id="__NSID__">
                    <object id="aaa" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="1" height="1" codebase="<%=hnwcodebase%>">
                    <param name="hnwsrc"    VALUE="memb100.hnw"
                    <param name="initvalue" VALUE="[:flag]=N">
                    <param name="hidewnd"   VALUE="N">
                    <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
                    </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>
-->
           </table>
        </td>
    </tr>
</table>
<!--************************************************************** ezgen -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center" id="biz"  style="display:none">
            <input type="button" name="btnREG_nxt_SHR" value="<<" onclick="goclick('firstPage');" style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            <input type="button" name="btnREG_nxt_SHR" value="<"  onclick="goclick('prePage');"   style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            &nbsp;
            <input type="button" name="btnREG_nxt_SHR" value=">"  onclick="goclick('nextPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            <input type="button" name="btnREG_nxt_SHR" value=">>" onclick="goclick('lastPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 시작 -->
<!-- table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="paddingTop8">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
        </tr>
      </table>
    </td>
  </tr>
</table -->
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->

<!-- 내용 조회 그리드 데이블 끝-->
<input type="hidden" name="txtDOC_AUTHO" value="1">
<input type="hidden" name="flag">
<input type="hidden" name="hidGBN_OCC_CD" value="A">
<input type="hidden" name="hidGBN_GBN_CASE" value="H">
</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
