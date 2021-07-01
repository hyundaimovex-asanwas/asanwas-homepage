<!--
*****************************************************
* @source       : gunb030.jsp
* @description : 휴가계획서입력현황 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/02/20      김학수        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>휴가계획서입력현황(gunb030)</title>
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

			var PIS_YYMM_SHR = document.getElementById("txtSTR_YMD_SHR").value;
			var DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value;
			var END_TAG_SHR = document.getElementById("cmbEND_TAG_SHR").value;

			//해당년월이 없으면 조회못함.
			if(PIS_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("해당년월을 입력하세요.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}
			//해당년월이 잘못되었으면 조회못함.
			if(PIS_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("해당년월이 잘못되었습니다.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}

            trT_DI_PLAN.KeyValue = "SVL(O:dsT_DI_PLAN=dsT_DI_PLAN)";
            trT_DI_PLAN.action = "/servlet/GauceChannelSVL?cmd=hr.gun.b.gunb030.cmd.GUNB030CMD&S_MODE=SHR&PIS_YYMM="+PIS_YYMM_SHR+"&DPT_CD="+DPT_CD_SHR+"&END_TAG="+END_TAG_SHR;
            trT_DI_PLAN.post();
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

            //이곳에 해당 코딩을 입력 하세요

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
			dsT_DI_PLAN.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
            document.getElementById("txtDPT_CD_SHR").value = "<%=box.get("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.get("SESSION_DPTNM") %>";
			document.form1.txtSTR_YMD_SHR.focus();
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

          if (dsT_DI_PLAN.IsUpdated)  {

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

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
            cfStyleGrid(form1.grdT_DI_PLAN,0,"false","false");

            document.getElementById("txtSTR_YMD_SHR").value = getToday().substr(0,7);
			document.getElementById("txtSTR_YMD_SHR").focus();


            document.getElementById("txtDPT_CD_SHR").value = "<%=box.getString("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.getString("SESSION_DPTNM") %>";
<%
    if(!box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
            fnc_ChangeStateElement(false, "txtDPT_CD_SHR");       
            fnc_ChangeStateElement(false, "ImgDptCd");       
<%
    }
%>

         }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

          fnc_HotKey_Process(btnList, event.keyCode);

        }

        /********************
           * 16. 외
         *******************/


    /********************************************
         * 날짜 형식 유효성 체크                           			*
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
            }
        }

     /********************************************
         * 종료일자에서 포커스 떠날때 신청일자와 비교       		*
         ********************************************/
        function cfCheckDateTermGUNA040(p_obj,p_stdt,p_endt) {
          if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
            if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
              alert("종료일자가 시작일자보다 큽니다.");
              document.getElementById(p_obj).value = '';
            }
          }
        }

       /********************************************
         * form onload시                       			*
         ********************************************/

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------------------------------+
    | 1. 조회용 DataSet (휴가계획서입력현황 조회)                            		                |
    | 2. 이름 : dsT_DI_PLAN                                                 |
    | 3. Table List : T_DI_PLAN, VI_T_CM_PERSON2, T_DI_YEARLY, T_CM_DEPT |
    +----------------------------------------------------------------------->
    <Object ID="dsT_DI_PLAN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_DI_PLAN                  |
    | 3. Table List : T_DI_PLAN              |
    +----------------------------------------------->
    <Object ID ="trT_DI_PLAN" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_PLAN Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

          //alert("검색하신 조건의 자료가 없습니다.");
          fnc_Message(document.getElementById("resultMessage"), "MSG_02");
   //       document.form1.txtENO_NO_SHR.focus();

        } else {

          fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
          document.form1.grdT_DI_PLAN.focus();
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_PLAN Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_PLAN Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_DI_PLAN event="OnSuccess()">

    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_DI_PLAN event="OnFail()">
        cfErrorMsg(this);
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
          <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">휴가계획서입력현황</td>
          <td align="right" class="navigator">HOME/근태관리/휴가계획관리/<font color="#000000">휴가계획서입력현황</font></td>
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
      <!--  a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a -->
      <!--  a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a -->
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
      <!-- a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a -->
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
                              <col width="20"></col>
                              <col width="80"></col>
                              <col width="120"></col>
                              <col width="80"></col>
                              <col width="220"></col>
                              <col width="80"></col>
                              <col width=""></col>
                            </colgroup>
                            <tr>
                                <td align="center">&nbsp;</td>
                                <td align="right" class="searchState">해당년월&nbsp;</td>
                                <td class="padding2423">
                                    <input type="text" id="txtSTR_YMD_SHR"  name="txtSTR_YMD_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtSTR_YMD_SHR','','108','113');">
                                    <img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
									<!-- ~
                                    <input type="text" id="txtEND_YMD_SHR"  name="txtEND_YMD_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fncCheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtEND_YMD_SHR','','224','113');">
                                    <img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
									-->
                                </td>
                                <td align="right" class="searchState">소&nbsp;&nbsp;속&nbsp;</td>
                                <td class="padding2423"><input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="6" maxlength="2" valid="key=true;type=eng" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
                                    <input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">처리구분&nbsp;</td>
                                <td class="padding2423">
									<select id="cmbEND_TAG_SHR" style="width:80" onChange="fnc_SearchList();">
										<option value="" >전체</option>
	                                    <option value="1" >미입력</option>
	                                    <option value="2" >저장</option>
	                                    <option value="3" >완료</option>
									</select>
                                </td>
                                <td align="center">&nbsp;</td>
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
            <object	id="grdT_DI_PLAN" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
              <param name="DataID"				value="dsT_DI_PLAN">
              <param name="EdiTABLE"            value="true">
              <param name="DragDropEnable"		value="true">
              <param name="SortView"            value="Left">
              <param name="VIEWSUMMARY"			value=0>
              <param name="Format"				value="
				<C> id='{CUROW}'		width=29		name='NO'					align=center			value={String(Currow)}			</C>
                <C> id='DPT_NM'         width=100       name='소속'					align=center	        Edit=None		suppress=1		</C>
                <C> id='END_TAG'        width=60		name='처리구분'      	   	align=center	        Edit=None		suppress=1		</C>
                <C> id='ENO_CNT'        width=60		name='총원'      	   	    align=right		        Edit=None		suppress=1		</C>
                <G> name='휴가계획현황'  											align=center            Edit=None		HeadBgColor='#F7DCBB'
	                <C> id='YEAR'		width=60		name='연차'      	   	    align=right			    Edit=None		suppress=1		</C>
	                <C> id='HALF'		width=60		name='반차'      	   	    align=right			    Edit=None		suppress=1		</C>
	                <C> id='ETC'		width=60	    name='기타'					align=right			    Edit=none		suppress=1		</C>
                </G>
                <C> id='ENO_NM'         width=350		name='휴가미사용자(사무직)'	align=left			    Edit=none						</C>
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
<!-- -->

