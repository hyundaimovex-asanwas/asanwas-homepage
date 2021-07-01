<!--
*****************************************************************************
* @source      : code050.jsp                                                    *
* @description : 근로소득세율 개인설정 PAGE                                 *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2015/07/07      정영식        최초작성                                                     *
*****************************************************************************
-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>개인소득세율신청</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   자바스크립트 함수 선언부분                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">


        var today = gcurdate;

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {

            if (document.getElementById("txtENO_NO_SHR").value == "") {
                alert("사번/성명을 먼저 입력하신 다음 작업하여 주시기 바랍니다.");
                document.getElementById("txtENO_NM_SHR").focus();

                return;
            }

            dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code050.cmd.CODE050CMD&S_MODE=SHR&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
            dsT_CM_PERSON.Reset();

            if (document.getElementById("txtENO_NO_SHR").disabled == false) {
                document.getElementById("txtENO_NM_SHR").focus();
            }
        }



        /********************************************
         * 02. 조회 함수_Item 형태의 조회                *
         ********************************************/
        function fnc_SearchItem() {

        }

        /********************************************
         * 03. 저장 함수                                *
         ********************************************/
        function fnc_Save() {
            
            //패스워드변경, count초기화
            trT_CM_PERSON.KeyValue = "tr01(I:dsT_CM_PERSON=dsT_CM_PERSON)";
            
            trT_CM_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code050.cmd.CODE050CMD&S_MODE=SAV&ENO_NO="+document.getElementById("txtENO_NO_SHR").value+"&LUN_CHK="+document.getElementById("gcrdo_LUN_CHK").codevalue;

            trT_CM_PERSON.post();
            
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


        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
        	
            if ( dsT_CM_PERSON.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            
        	window.close();
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

            document.getElementById("txtENO_NO_SHR").value = gusrid;
            document.getElementById("txtENO_NM_SHR").value = gusrnm;

		    //관리자가 아니면 사번 검색은 하지 못한다.
			if(gusrid != "6060002" && gusrid != "6180001" && gusrid != "6180022" && gusrid != "2030007" && gusrid != "2070020" && gusrid != "2080003" && gusrid != "2140002" ){ 

	         	fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	         	fnc_ChangeStateElement(false, "txtENO_NM_SHR");
	         	fnc_ChangeStateElement(false, "ImgEnoNo");

			  }

			fnc_SearchList();    
			

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
        //예외 항목들
        var oExceptionList = new Array(  );

        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

        }
         /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */

        function fnc_GetNm() {
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','1','0');

        }

        function fnc_Getcd() {
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');
        }


    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)                |
    | 3. 사용되는 Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
    </Object>

    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_CM_PERSON)                |
    | 3. 사용되는 Table List(T_CM_PERSON)                      |
    +------------------------------------------------------>

    <Object ID="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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


    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
    
        if (iCount == 0)    {

        } else {

        }
    </Script>


    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>

    <Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>


    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>


    <script for=trT_CM_PERSON event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>


    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>

    <script for=trT_CM_PERSON event="OnFail()">
          cfErrorMsg(this);
    </script>


    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

    <!-- 캘린더 프레임-->
    <div class="calendar" id="ifrmcal" style="DISPLAY:none">
        <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
    </div>

    <!-- form 시작 -->
    <form name="form1">


    <!-- 버튼 테이블 시작 -->
    <table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
    <table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="blueTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <colgroup>
                                    <col width="200"></col>
                                    <col width="80"></col>
                                    <col width="140"></col>
                                    <col width=""></col>
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchState">사번&nbsp;</td>
                                    <td class="padding2423">
                                        <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9"  maxlength= "8"   onkeypress="javascript:if(event.keyCode==13) {fnc_GetNm();fnc_SearchList();}" onchange="fnc_GetNm();fnc_SearchList();" style="ime-mode:disabled"   >
                                        <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength= "14"  onkeypress="javascript:if(event.keyCode==13) {fnc_Getcd();fnc_SearchList();}" onchange="fnc_Getcd();fnc_SearchList();"  >
                                        <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup();fnc_SearchList();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                                        <input type="hidden" id="hidEMPL_DPT_CD">
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
    <table width="1000" border="0" cellspacing="0" cellpadding="0">
    	<tr>
    		<td class="paddingTop8">
    			<table width="100%" border="0" cellspacing="0" cellpadding="0">
    				<tr>
    					<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
    				</tr>
    			</table>
    		</td>
    	</tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->

	<!-- 조건 입력 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	                <colgroup>
	                    <col width="60"></col>
	                    <col width="80"></col>
	                    <col width="60"></col>
	                    <col width="120"></col>
	                    <col width="60"></col>
	                    <col width="70"></col>
	                    <col width="60"></col>
	                    <col width="70"></col>
	                    <col width="60"></col>
	                    <col width=""></col>
	                </colgroup>
	                <tr>
	                    <td align="center" class="blueBold">소득세 징수세율 </td>
	                    <td class="padding2423">
	                        <object id=gcrdo_LUN_CHK  classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:100; width:300">
								<param name=Cols	value=3>
								<param name=Format	value="1^80%,2^100%,3^120%">
							</object>

	                    </td>                     
	                </tr>
	            </table>
	        </td>
	    </tr>
        <tr>
          <td>
          <br><b>&nbsp;&nbsp;※ 2015년 07월부터 근로소득세율 개인 선택이 가능.<br>
                 &nbsp;&nbsp;※ 한 번 선택하면 해당 과세년도에는 수정 불가.<br>
                 &nbsp;&nbsp;※ 80% 선택: 매월 원천징수세액이 작으므로 연말정산 시 추가납부 할 세액이 발생할 확률이 높음.<br>
                 &nbsp;&nbsp;※100% 선택: 종전과 같음.<br>
                 &nbsp;&nbsp;※120% 선택: 매월 원천징수세액이 많아져 연말정산 시 환급세액이 발생할 확률이 높음.
             </b>
          </td>
        </tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->


    <!-- form 끝 -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->


<object id="bndT_CM_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_PERSON">
    <Param Name="BindInfo", Value='
        <C>Col=LUN_CHK          Ctrl=gcrdo_LUN_CHK        Param=codevalue    </C>
    '>
</object>
