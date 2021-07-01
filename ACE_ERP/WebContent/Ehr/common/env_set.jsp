<!--
    ************************************************************************************
    * @Source         : sela022.jsp                                                    *
    * @Description    : 공지사항 내용 PAGE                                             *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/19  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>


<html>

    <head>
    <title>공지사항 내용</title>
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

        var btnList = 'FFTFFFFT';



        var gbn     = '';
        var title   = '';
        var bbs_gbn = '';
        var seq_no  = '';
        var ref_no  = '';
        var step_no = '';
        var dept_no = '';
        var eno_no  = '';
        var eno_no  = '';


        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {


            document.getElementById("txtSUBJECT_TAG").innerText = "Windows 7 사용자 관련";
            document.getElementById("txtSRCFILE1_NM").innerText =  "AMX_20121101.zip";
            document.getElementById("txtTGTFILE1_NM").innerText =  "C:/project3/asn/file_repository/upload/201211210237033730.zip";
            document.getElementById("txtSRCFILE2_NM").innerText =  "win7_user.jpg";
            document.getElementById("txtTGTFILE2_NM").innerText =  "C:/project3/asn/file_repository/upload/2011081707564756471.jpg";


        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {


            window.close();
        }

        function fnc_link(val1, val2) {

            // 첨부 파일이 존재하는 경우만 수행하게~
            cfDownload(val1, val2);

        }

    </script>

    </head>






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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">공지사항 내용</td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="300"></col>
                    <col width="100"></col>
                    <col width="300"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">첨부파일</td>
                    <td class="padding2423" colspan="3">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE1_NM').innerText, document.getElementById('txtTGTFILE1_NM').value);"><span id="txtSRCFILE1_NM"  name="txtSRCFILE1_NM"></span></a>
                            <input type=hidden id="txtTGTFILE1_NM">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE2_NM').innerText, document.getElementById('txtTGTFILE2_NM').value);"><span id="txtSRCFILE2_NM"  name="txtSRCFILE2_NM"></span></a>
                            <input type=hidden id="txtTGTFILE2_NM">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE3_NM').innerText, document.getElementById('txtTGTFILE3_NM').value);"><span id="txtSRCFILE3_NM"  name="txtSRCFILE3_NM"></span></a>
                            <input type=hidden id="txtTGTFILE3_NM">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE4_NM').innerText, document.getElementById('txtTGTFILE4_NM').value);"><span id="txtSRCFILE4_NM"  name="txtSRCFILE4_NM"></span></a>
                            <input type=hidden id="txtTGTFILE4_NM">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE5_NM').innerText, document.getElementById('txtTGTFILE5_NM').value);"><span id="txtSRCFILE5_NM"  name="txtSRCFILE5_NM"></span></a>
                            <input type=hidden id="txtTGTFILE5_NM">
                    </td>
                </tr>

                <tr>
                    <td align="center" class="creamBold">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtSUBJECT_TAG"  name="txtSUBJECT_TAG"></span>
                    </td>
                </tr>
                <tr>
                    <td class="padding2423" colspan="4" >
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="130" rows="26" readonly>Windows 7 사용자 관련

	Components 쓰기 오류가  발생할 때  아래와 같이 조치 후 사용바랍니다.

	제어판 > 사용자 계정 > 사용자계정 컨트롤 설정  : 알리지않음으로   변경(첨부2참조) > 리부팅  후

	첨부1 (AMX_20121101.zip)을  DownLoad후 압축을 풀고

	Installer.exe 를   실행시켜 주십시요.

	참고) Windows 7 은  유해프로그램을 차단하기 위하여 사용자계정 컨트롤을 사용하여 제어합니다.

	감사합니다.
                        </textarea>
                    </td>
                </tr>
                <input type=hidden id="txtBBS_GBN">
                <input type=hidden id="txtSEQ_NO">
                <input type=hidden id="txtREF_NO">
                <input type=hidden id="txtSTEP_NO">
                <input type=hidden id="txtDEPT_NO">
            </table>
        </td>
    </tr>
</table>

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

</form>
<!-- form 끝 -->

</body>
</html>