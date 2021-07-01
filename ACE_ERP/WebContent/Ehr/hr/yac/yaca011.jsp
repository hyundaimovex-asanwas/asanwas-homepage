<!--*************************************************************************
* @source      : yaca011.jsp                                                *
* @description : 전산제출정산현황 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2013/01/22            이동훈             최초작성                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
	<jsp:include page="/Ehr/common/include/head.jsp"/>

    <title>전산제출정산현황(yaca011)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   자바스크립트 함수 선언부분                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">
        //단축키 순서
        var btnList = "T"   //조회
                    + "F"   //신규
                    + "T"   //저장(처리)
                    + "T"   //취소
                    + "T"   //엑셀
                    + "F"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        var today = getToday();                    
        var dataClassName = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca011.cmd.YACA011CMD";
        var params = null;


        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {

            params = "&S_MODE=SHR"
                + "&PIS_YY="+document.getElementById("txtPIS_YY_SHR").value
                + "&SUBMIT_SHR="+document.getElementById("cmbSUBMIT_SHR").value;        	


            dsT_AC_RETACC.dataid = dataClassName+params;
            dsT_AC_RETACC.reset();

            
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
            
            //dsT_AC_RETACC.UseChangeInfo = "false";

            //prompt(this,dsT_AC_RETACC.text);
            
            trT_AC_RETACC.KeyValue = "SAV(I:dsT_AC_RETACC=dsT_AC_RETACC)";
            
            trT_AC_RETACC.action = dataClassName+"&S_MODE=SAV";
            
            trT_AC_RETACC.post();

            
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
            if (dsT_AC_RETACC.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_RETACC.GridToExcel("전산제출정산현황", '', 225);
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
            document.getElementById("resultMessage").innerText = ' ';

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

            cfStyleGrid(form1.grdT_AC_RETACC,0,"true","true");      // Grid Style 적용

            if(today.substring(5,7) == '01' || today.substring(5,7) =='02'||today.substring(5,7) =='03' )
            {
              document.getElementById("txtPIS_YY_SHR").value =  today.substring(0,4)-1;
            }
            else
            {
              document.getElementById("txtPIS_YY_SHR").value = today.substring(0,4);
            }


            
        }

        /********************************************
         * 15. 단축키 처리                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************
         * 16. 제출 여부 변경                           *
         ********************************************/        
        function fnc_Chagne() {

            var submit_yn   = document.getElementById("cmbFUN_CNT").value;
    
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
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_RETACC)                |
    | 3. 사용되는 Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETACC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
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
      //      alert("검색하신 조건의 자료가 없습니다!");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
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
    //    alert("* 작업을 완료 하였습니다!");
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

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

    <!-- 캘린더 프레임-->
    <div class="calendar" id="ifrmcal" style="DISPLAY:none">
        <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
    </div>

    <!-- form 시작 -->
    <form name="form1">

    <!-- 타이틀 바 테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="../../images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">퇴직급여정산현황</td>
                    <td align="right" class="navigator">HOME/정산세무/정산세무/<font color="#000000">퇴직급여정산현황</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="60"></col>
					<col width="230"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
					<tr>
						<td align="right" class="searchState">귀속년도&nbsp;</td>
						<td class="padding2423">
							<input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="5" class="input_ReadOnly" readonly>
						</td>
						<td align="center" class="searchState">제출여부</td>
						<td>
							<select id="cmbSUBMIT_SHR" style="WIDTH:100" onChange="fnc_SearchList();">
									<option value="" >전체</option>
									<option value="Y">제출</option>
									<option value="N">미제출</option>
							</select>
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
          <col width="90"></col>
          <col width="50"></col>
          <col width="90"></col>
          <col width="50"></col>
          <col width="90"></col>
        </colgroup>
        <tr>
          <td align="center" class="creamBold">사&nbsp;&nbsp;번</td>
          <td class="padding2423">
            <input id=txtENO_NO name=txtENO_NO style="width:100%" class="input_ReadOnly" readonly>
          </td>
          <td align="center" class="creamBold">성&nbsp;&nbsp;명</td>
          <td class="padding2423">
            <input id=txtENO_NM name=txtENO_NM style="width:100%" class="input_ReadOnly" readonly>
          </td>
          <td align="center" class="creamBold">직&nbsp;&nbsp;위</td>
          <td class="padding2423">
            <input id=txtJOB_NM name=txtJOB_NM style="width:100%" class="input_ReadOnly" readonly>
          </td>
          <td align="center" class="creamBold">구분</td>
          <td class="padding2423" colspan="7">
            <select id="cmbFUN_CNT" name="cmbFUN_CNT" style="width:100" onChange="fnc_Chagne()">
              <option value='Y'>제출</option>
              <option value='N'>미제출</option>
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
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
                    <object id="grdT_AC_RETACC" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
                        <param name="DataID" value="dsT_AC_RETACC">
                        <param name="Editable" value="true">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id="{CUROW}"     	width=60        align=center          	name="NO"         	value={String(Currow)}</C>
                            <C> id=ENO_NO        	width=80        align=center          	name="사번"          Edit="None"</C>
                            <C> id=ENO_NM        	width=100        align=center          name="이름"          Edit="None"</C>
                            <C> id=JOB_NM        	width=90        align=center          	name="직위"          Edit="None"</C>                            
                            <C> id=DPT_NM        	width=90       align=center          	name="부서"           Edit="None"</C>
                            <C> id=TEAM_NM       	width=220        align=left          	name="팀"             Edit="None"</C>
                            <C> id=FUN_CNT       	width=130        align=center          name="제출"          Value={decode(FUN_CNT, "Y","제출","N","미제출")}</C>
                        '>
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
<!-- -->
<object id="bndT_AC_RETACC" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
  <Param Name="DataID",   Value="dsT_AC_RETACC">
  <Param Name="BindInfo", Value='
    <C>Col=ENO_NO		  Ctrl=txtENO_NO      	   	Param=value</C>
    <C>Col=ENO_NM    	  Ctrl=txtENO_NM      	   	Param=value</C>
    <C>Col=JOB_NM		  Ctrl=txtJOB_NM     	   		Param=value</C>
    <C>Col=FUN_CNT	  	  Ctrl=cmbFUN_CNT	        Param=value</C>
    '>
</object>
