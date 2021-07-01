<!--*************************************************************************
* @source      : taxa110.jsp                                                *
* @description : 사업소세(종업원할)산출내역 PAGE                            *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/05/04      이승욱           최초작성                                 *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>사업소세(종업원할)산출내역(taxa110)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   자바스크립트 함수 선언부분                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">

        //버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
        var btnList = 'TFFTTTFT';

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
        
        var HEAD_TAG      = document.getElementById("cmbHEAD_TAG").value;      // 지역구분
        var PIS_YYMM_A0   = document.getElementById("txtPIS_YYMM_A0").value;   // 사무직 급여 
        var PIS_YYMM_A1F  = document.getElementById("txtPIS_YYMM_A1F").value; // 사무직 상여 From
        var PIS_YYMM_A1T  = document.getElementById("txtPIS_YYMM_A1T").value;  // 사무직 상여 To
        var PIS_YYMM_M0   = document.getElementById("txtPIS_YYMM_M0").value;   // 택배직 급여
        var PIS_YYMM_M1F  = document.getElementById("txtPIS_YYMM_M1F").value;  // 택배직 상여 From
        var PIS_YYMM_M1T  = document.getElementById("txtPIS_YYMM_M1T").value;  // 택배직 상여 To
        var PIS_YYMM_Y3   = document.getElementById("txtPIS_YYMM_Y3").value;   // 연월차 전체
        var PIS_YYMM_Y0   = document.getElementById("txtPIS_YYMM_Y0").value;   // 연월차 본사
        var PIS_YYMM_Y1   = document.getElementById("txtPIS_YYMM_Y1").value;   // 연월차 지방
        var PRN_FROM      = document.getElementById("rdoPRN_FROM").value;      // 서식
        alert(HEAD_TAG+"|"+PIS_YYMM_A0+"|"+PIS_YYMM_A1F+"|"+PIS_YYMM_A1T+"|"+PIS_YYMM_M0+"|"+PIS_YYMM_M1F+"|"+PIS_YYMM_M1T+"|"+PIS_YYMM_Y3+"|"+PIS_YYMM_Y0+"|"+PIS_YYMM_Y1+"|"+PRN_FROM);

        }   
        
        /********************************************
         * 02. 조회 함수_Item 형태의 조회                *
         ********************************************/
        function fnc_SearchItem() {

            if(document.form1.cmbHEAD_TAG.value==3){
               document.getElementById("PIS_YM_H").style.display = "";
               document.getElementById("PIS_YM_A").style.display = "none";
            } else {
               document.getElementById("PIS_YM_H").style.display = "none";
               document.getElementById("PIS_YM_A").style.display = "";
            }
        }

        /********************************************
         * 03. 저장 함수                                *
         ********************************************/
        function fnc_Save() {
        }

        /********************************************
         * 04. 삭제 함수                                *
         ********************************************/
        function fnc_Delete() {

        }

        /********************************************
         * 05. 인쇄 함수                                *
         ********************************************/
        function fnc_Print() {

        }

        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {
        }

        /********************************************
         * 07. 신규 함수                                *
         ********************************************/
        function fnc_AddNew() {

        }

        /********************************************
         * 08. 추가 함수                                *
         ********************************************/
        function fnc_Append() {
           
        }

        /********************************************
         * 09. 제거 함수                                *
         ********************************************/
        function fnc_Remove() {
          
        }

        /********************************************
         * 10. 초기화 함수                           *
         ********************************************/
        function fnc_Clear() {
//            document.getElementById("resultMessage").innerText = ' ';
            
//            dsT_AC_RETACC.ClearData();

            //날자값들 바인딩
//            var toDays = getTodayArray();
//            document.getElementById("txtSTR_YMD_SHR").value = toDays[0]+"-"+toDays[1];
//            document.getElementById("txtEND_YMD_SHR").value = toDays[0]+"-"+toDays[1];
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_RETACC.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();           
        }

        /********************************************
         * 12. 검색 조건 유효성 검사                     *
         ********************************************/
        function fnc_SearchItemCheck() {
            
        }

        /********************************************
         * 13. 저장 유효성 체크                        *
         ********************************************/
        function fnc_SaveItemCheck() {
            
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분         *
         ********************************************/
        function fnc_OnLoadProcess() {   
            //첫번째 인수 : 그리드명                                        
            //두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
            //세번째 인수 : 그리드모드(false:읽기, true:쓰기)    
            //네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)                
//            cfStyleGrid(form1.grdT_AC_RETACC,0,"true","false");      // Grid Style 적용
            
            //날자값들 바인딩
//            var toDays = getTodayArray();
//            document.getElementById("txtSTR_YMD_SHR").value = toDays[0]+"-"+toDays[1];
//            document.getElementById("txtEND_YMD_SHR").value = toDays[0]+"-"+toDays[1];
        }

        /********************************************
         * 15. 단축키 처리                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 16. Form이 Active 될 때 처리 할 일          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {
           
        }
        
        /********************************************
         * 기타 함수              *
         ********************************************/
         
                    
    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_RETACC)                |
    | 3. 사용되는 Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETACC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=SubsumExpr          value="total">
    </Object>     
     
    <!-----------------------------------------------------+
    | 1. 공통 콤보를 위한 DataSet                               |
    +------------------------------------------------------>    
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_U5"/>
       <jsp:param name="CODE_GUBUN"    value="U5"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>     
    
    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_RETACC)                |
    | 3. 사용되는 Table List(T_AC_RETACC)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETACC" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>     


    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                       *
    *                                                                                        *
    ***************************************************************************************-->  

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("검색하신 조건의 자료가 없습니다!");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount-1);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>  

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("* 작업을 완료 하였습니다!");
        fnc_SearchList();
    </script> 

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnFail()">
        cfErrorMsg(this);
    </script> 

    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onload="fnc_OnLoadProcess();">
    <!-- 파일 전송을 위해 -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">사업소세(종업원할)산출내역</td>
                    <td align="right" class="navigator">HOME/정산세무/정산세무/<font color="#000000">사업소세(종업원할)산출내역</font></td>
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
<!--                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)"><img src="/images/button/btn_ConductOn.gif" name="imgConduct" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
-->
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                            <tr>
                                <td align="center" class="searchState" width="128">지역구분</td>
                                <td width="128">
                                    <select id="cmbHEAD_TAG" style="width:80" onChange="fnc_SearchItem();">
                                        <option value="3" >전  체</option>
                                        <option value="0" >남대문 사옥</option>
                                        <option value="1" >구로사옥</option>
                                        <option value="2" >지  점</option>
                                    </select>
                                </td>
                                <td align="center"  width="*">&nbsp;</td>
                            </tr>
                        </table><HR class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="center" class="searchState" width="128">사무직 급여</td>
                                <td width="128">
                                    <input id="txtPIS_YYMM_A0" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_A0','','75','112');"></a>
                                </td>
                                <td align="center" class="searchState" width="128">사무직 상여</td>
                                <td width="256">
                                    <input id="txtPIS_YYMM_A1F" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_A1F','','75','112');"></a>
                                    ~
                                    <input id="txtPIS_YYMM_A1T" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_A1T','','75','112');"></a>
                                </td>
                                <td align="center" width="*">&nbsp;</td>
                            </tr>
                        </table><HR class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="center" class="searchState" width="128">택배직 급여</td>
                                <td width="128">
                                    <input id="txtPIS_YYMM_M0" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_M0','','75','112');"></a>
                                </td>
                                <td align="center" class="searchState" width="128">택배직 상여</td>
                                <td width="256">
                                    <input id="txtPIS_YYMM_M1F" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_M1F','','75','112');"></a>
                                    ~
                                    <input id="txtPIS_YYMM_M1T" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_M1T','','75','112');"></a>
                                </td>
                                <td align="center" width="*">&nbsp;</td>
                            </tr>
                        </table><HR class="greenTable">
                    <div id="PIS_YM_H" style="">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="center" class="searchState" width="128">연월차</td>
                                <td width="128">
                                    <input id="txtPIS_YYMM_Y3" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_Y3','','75','112');"></a>
                                </td>
                                <td align="center" width="*">&nbsp;</td>
                            </tr>
                        </table>
                    </div>
                    <div id="PIS_YM_A" style="DISPLAY:none">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="center" class="searchState" width="128">연월차</td>
                                <td align="center" class="searchState" width="64">본사</td>
                                <td width="128">
                                    <input id="txtPIS_YYMM_Y0" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_Y0','','75','112');"></a>
                                </td>
                                <td align="center" class="searchState" width="64">지방</td>
                                <td width="128">
                                    <input id="txtPIS_YYMM_Y1" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_Y1','','75','112');"></a>
                                </td>
                                <td align="center" width="*">&nbsp;</td>
                            </tr>
                        </table>
                    </div>
                    </td>
                </tr>
            </table><BR> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="center" class="searchState" width="128">서식</td>
                                <td width="192">
									<input type="radio" id="radio1" name="rdoPRN_FROM" style="border:none" value="Page1" checked>제출서식
									&nbsp;&nbsp;
                                    <input type="radio" id="radio2" name="rdoPRN_FROM" style="border:none" value="Page2" >확인서식 
                                </td>
                                <td align="center"  width="*">&nbsp;</td>
                            </tr>
                        </table>
                    </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search테이블 끝 -->


    </form>
    <!-- form 끝 -->

</body>
</html>


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
