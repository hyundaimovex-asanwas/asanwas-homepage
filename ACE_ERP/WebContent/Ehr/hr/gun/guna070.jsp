<!--
*****************************************************
* @source       : guna070.jsp
* @description : 근태현황 결재처리 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2016/06/01      이동훈        ERP 이사
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>근태결재처리</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >


        var today = gcurdate;
        
        var dsTemp = window.dialogArguments;
        
        var curRowPosition = 0;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			//검색조건(기간)
			var str_ymd = document.getElementById("txtSTR_YMD_SHR").value;
            var end_ymd = document.getElementById("txtEND_YMD_SHR").value;
            var gun_gbn = document.getElementById("cmbGUN_GBN_SHR").value;
            var app_yn = document.getElementById("cmbAPP_YN").value;
            var eno_no = document.getElementById("txtENO_NO_SHR").value;
            var our_man = document.getElementById("txtOUR_MAN_SHR").value;
            if(!fnc_SearchItemCheck()) return;

            dsT_DI_APPROVAL.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna070.cmd.GUNA070CMD&S_MODE=SHR&STR_YMD_SHR="+str_ymd+"&END_YMD_SHR="+end_ymd+"&GUN_GBN_SHR="+gun_gbn+"&APP_YN_SHR="+app_yn
												+"&ENO_NO="+eno_no+"&OUR_MAN="+our_man;
            dsT_DI_APPROVAL.reset();
            
            dsT_DI_APPROVAL.RowPosition = curRowPosition;

            document.getElementById("txtSTR_YMD_SHR").focus();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

        }

        /******************
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

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            document.getElementById("resultMessage").innerText = ' ';

			dsT_DI_APPROVAL.ClearData();

			document.getElementById("txtSTR_YMD_SHR").focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        if(dsTemp != "Modal"){
	            if (dsT_DI_APPROVAL.IsUpdated)  {
	                if (!fnc_ExitQuestion()) return;
	            }

	            window.close();

	        }else{
	        	
	            window.close();
	            
	        }

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            var str_ymd = document.getElementById("txtSTR_YMD_SHR");
            var end_ymd = document.getElementById("txtEND_YMD_SHR");

            if(str_ymd.value == "" && end_ymd.value == ""){
                alert("검색 기간을 입력하세요!");
                str_ymd.focus();
                return false;
            }
            return true;
        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_DI_APPROVAL.IsUpdated) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}
			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");      // Grid Style 적용

			document.getElementById("txtSTR_YMD_SHR").value = gcurdate;
			document.getElementById("txtEND_YMD_SHR").value = next_month(gcurdate)+"-"+gcurdate.substring(8);

			document.getElementById("txtOUR_MAN_SHR").value = gusrid;
			document.getElementById("txtOUR_MAN_NM_SHR").value = gusrnm;
			
            fnc_SearchList();//자동조회
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 카피용 DataSet                             |
    | 2. 이름 : dsT_DI_APPROVAL_CP                  |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

	        //alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!------------------------------+
    | 그리드의 ROW를 더블클릭 할때  |
    +------------------------------->
	<script language=JavaScript for=grdT_DI_APPROVAL event="OnDblClick(row,colid)">

	    curRowPosition = dsT_DI_APPROVAL.RowPosition;

		if(row < 1) {
			
			return;
			
		} else {

                //선택된 ROW를 dsT_DI_CHANGE_CP 복사하여 guna061에 dsT_DI_CHANGE_CP 넘겨준다.
    			cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_CP, "copyHeader=yes,rowFrom="+row+",rowCnt=1");

    			window.showModalDialog("../../../Ehr/hr/gun/guna071.jsp", dsT_DI_APPROVAL_CP, "dialogWidth:870px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

                fnc_SearchList();

		}
	</script>
<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">


<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="80"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
								<td class="searchState" align="right">해당기간&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','225','113');"></a> ~
                                    <input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','340','113');"></a>
                                </td>
                                <td class="searchState" align="right">결재종류</td>
                                <td class="padding2423" align="left">
			                        <select id="cmbGUN_GBN_SHR" style="width:100" >
			                            <option value="" >전체</option>
			                            <option value="C" >일일근태</option>
			                            <option value="U" >근태변경</option>
			                            <option value="A" >연차촉진제</option>
			                        </select>
                                </td>
								<td class="searchState" align="right">결재상태</td>
                                <td class="padding2423" align="left">
			                        <select id="cmbAPP_YN" style="width:100" >
			                            <option value="" >전체</option>
			                            <option value="Y" >결재</option>
			                            <option value="N" >부결</option>
			                            <option value="A" >미결</option>
			                        </select>
                                </td>
                            </tr>
							<tr class="paddingTop5" >
								<td class="searchState" align="right">상신자&nbsp;</td>
								<td >
									<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="10" maxlength="9"  onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR');" onChange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="10" onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR', 'txtENO_NM_SHR');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR');">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
								</td>
								<td class="searchState" align="right">결재자&nbsp;</td>
								<td colspan="3">
									<input id="txtOUR_MAN_SHR" name="txtOUR_MAN_SHR" size="10" maxlength="9"        onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');" onChange="fnc_GetCommonEnoNm('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');">
									<input id="txtOUR_MAN_NM_SHR" name="txtOUR_MAN_NM_SHR" size="12" maxlength="10" onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');" onchange="fnc_GetCommonEnoNo('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR')">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgOUR_MAN_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgOUR_MAN_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');"></a>
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
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
		<td align="center" width="40%" valign="bottom">
        ※결재를 원하시면 해당 근태내역을 더블클릭 하세요.
        </td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:520px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Format"				value="
                                <C> id='{CUROW}'    	width=40    name='NO'           	align=center value={String(Currow)}</C>
								<C> id='REQ_NO'     		width=100  	name='등록번호'   		align=center suppress=1 </C>
								<C> id='PENO_NM'		width=130	name='상신자'	    	align=center suppress=1</C>
								<C> id='ORD_DATE'		width=130	name='상신일시'		align=center suppress=1</C>
								<C> id='DPT_NM'			width=100	name='소속'		    	align=center suppress=2</C>
								<C> id='ENO_NM'	    	width=130	name='결재자'	    	align=center </C>
 								<C> id='APP_YN' 			width=100	name='결재상태'	    align=center Value={DECODE(APP_YN,'Y','결재','N','부결',DECODE(PENO_NO,NULL,'미상신','미결'))} </C>
								<C> id='APP_DATE'		width=130	name='결재일시'	    align=center </C>
                                <C> id='GUN_GBN_NM'	width=100	name='구분'	    		align=center  </C>
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

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


