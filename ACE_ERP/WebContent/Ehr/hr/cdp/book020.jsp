<!--
*****************************************************
* @source       : BOOK020.jsp
* @description : 도서구입결재현황 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2011/06/16      이동훈        최초작성
*----------------------------------------------------
* 2016/06/01    |  정영식   | 소스이전                                        *
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>도서 구입 현황</title>
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

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기

        var today = gcurdate;

        var dsTemp = window.dialogArguments;
        
        var curRowPosition = 0;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			//검색조건(기간)
			var BOOK_YMD_SHR = document.getElementById("txtBOOK_YMD_SHR").value;
			var BOOK_YME_SHR = document.getElementById("txtBOOK_YME_SHR").value;


            var app_yn = document.getElementById("cmbAPP_YN").value;
            var DPT_CD = document.getElementById("txtDPT_CD_SHR").value;
            var our_man = document.getElementById("txtOUR_MAN_SHR").value;


            if(!fnc_SearchItemCheck()) return;


            //조회 해당년월을 저장한다.
            document.getElementById("hidTAG_YM").value = BOOK_YMD_SHR;

			dsT_DI_APPROVAL.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book020.cmd.BOOK020CMD"
					                                   + "&S_MODE=SHR"
					                                   + "&BOOK_YMD_SHR="+BOOK_YMD_SHR
					                                   + "&BOOK_YME_SHR="+BOOK_YME_SHR
					                                   + "&APP_YN_SHR="+app_yn
					                                   + "&DPT_CD="+DPT_CD
					                                   + "&OUR_MAN="+our_man;

			dsT_DI_APPROVAL.reset();

			//dsT_DI_APPROVAL.RowPosition = curRowPosition;


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
            document.getElementById("cmbAPP_YN").value ='';
            document.getElementById("txtDPT_CD_SHR").value = '';
            document.getElementById("txtDPT_NM_SHR").value = '';
            document.getElementById("txtOUR_MAN_SHR").value = '';
            document.getElementById("txtOUR_MAN_NM_SHR").value = '';
			dsT_DI_APPROVAL.ClearData();

			document.getElementById("txtBOOK_YMD_SHR").focus();

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

			var BOOK_YMD_SHR = document.getElementById("txtBOOK_YMD_SHR").value; // 시작년월

            if(BOOK_YMD_SHR == ""){
                alert("검색 기간을 입력하세요!");
                document.getElementById("txtBOOK_YMD_SHR").focus();
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


        	cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"true","true")      // Grid Style 적용
        	
        	
        	dsVI_T_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=SHR_02&ENO_NO="+gusrid;
            dsVI_T_PERSON.reset();

		
			if(gusrid != "6060002" && gusrid != "6070001" && gusrid != "6050006"  && gusrid != "2070020" && gusrid != "2080003" && gusrid != "2180001" ){ 
	            document.getElementById("hidDPT_CD_ORI").value = dsVI_T_PERSON.NameValue(0,"DPT_CD");// 소속
	            document.getElementById("txtDPT_CD_SHR").value = dsVI_T_PERSON.NameValue(0,"DPT_CD");// 소속
	            document.getElementById("txtDPT_NM_SHR").value = dsVI_T_PERSON.NameValue(0,"DPT_NM");// 소속
	
	            fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
	            fnc_ChangeStateElement(false, "ImgDptCd");
			
			 }
		

            //CHECK_DATE!!!
            //창이 열릴때 현재날짜를 비교해 15일 전 / 오늘날짜를 가지고 온다.
            var todayList   = getTodayArray();
            var book_ymd    = gcurdate;

            book_ymd     = addDate("M", gcurdate, -1);
            document.getElementById("txtBOOK_YMD_SHR").value = book_ymd; // 해당년월 From
            book_ymd     = addDate("M", gcurdate, 1);
            document.getElementById("txtBOOK_YME_SHR").value = book_ymd; // 해당년월 To

            fnc_SearchList();
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
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_DI_APPROVAL                                      |
    | 3. Table List : T_DI_APPROVAL                                 |
    +----------------------------------------------->
    <Object ID="dataSet" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    <!-----------------------------------------------------+
    | 1. 조회용 DataSet(주소)              |
    | 2. 이름은 ds_ + 주요 테이블명(VI_T_CM_PERSON)      |
    | 3. 사용되는 Table List(VI_T_CM_PERSON)        |
    +------------------------------------------------------>
	 <Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	  <Param Name="Syncload"     Value="True">
	  <Param Name="UseChangeInfo"   Value="True">
	  <Param Name="ViewDeletedRow"  Value="False">
	 </Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_APPROVAL)		   |
    | 3. 사용되는 Table List(T_DI_APPROVAL)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
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

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>




    <!------------------------------+
    | 그리드의 ROW를 더블클릭 할때  |
    +------------------------------->



	<script language=JavaScript for=grdT_DI_APPROVAL event="OnDblClick(row,colid)">


        var param = new String();

		curRowPosition = dsT_DI_APPROVAL.RowPosition;

        if(row < 1) {
        	
            return;
            
        } else {


			//휴일근무 param 값 Setting
            if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "6" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "7" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "8"){
                      //변수들 정의
	            param.gun_ymd   = dsT_DI_APPROVAL.NameValue(row, "GUN_YMD");

          		param.gun_dpt   = dsT_DI_APPROVAL.NameValue(row, "GUN_DPT");

          		param.req_no    = dsT_DI_APPROVAL.NameValue(row, "REQ_NO");

            }
			
            //변수들 정의
          	param.req_no    = dsT_DI_APPROVAL.NameValue(row, "RQST_NO");

            window.showModalDialog("../../hr/cdp/book011.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

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
       <td height="35" class="paddingTop5">
           &nbsp;&nbsp;※ 해당 결재정보를 더블클릭하면 세부내역을 조회할 수 있습니다.
       </td>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
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
                                <col width="230"></col>
                                <col width="80"></col>
                                <col width="200"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
								<td align="right" class="searchState">신청일자&nbsp;</td>
                                <td class="padding2423">
									<input id="txtBOOK_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
									<!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBOOK_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgBOOK_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtBOOK_YMD_SHR','','70','110');"></a>--> ~
									<input id="txtBOOK_YME_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
									<!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBOOK_YME_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgBOOK_YME_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtBOOK_YME_SHR','','70','110');"></a>-->
                                    <input type="hidden" id="hidTAG_YM">
								</td>
								<td class="searchState" align="right">결재상태</td>
                                <td class="padding2423" align="left">
			                        <select id="cmbAPP_YN" style="width:100" onChange="fnc_SearchList();">
			                            <option value="" >전체</option>
			                            <option value="A" >상신</option>
			                            <option value="R" >저장</option>
			                            <option value="N" >부결</option>
			                            <option value="Y" >결재완료</option>
			                        </select>
                                </td>
                            </tr>
				<tr class="paddingTop5" >
					<td align="right" class="searchState">소&nbsp;&nbsp;속&nbsp;</td>


					<td class="padding2423">
                        <input id="hidDPT_CD_ORI" type="hidden">
						<input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="6" maxlength="3" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
						<input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
					</td>

					<!--
                    <td class="padding2423">
						<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3" class="input_ReadOnly"  readonly maxlength="3" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
						<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="12" class="input_ReadOnly"  readonly>
	                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','../../images/button/btn_HelpOver.gif',1)">
	                    <img src="../../images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
                    </td>
                    -->

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
                        <object id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:320px;">
                            <param name="DataID"                	value="dsT_DI_APPROVAL">
                            <param name="SortView"               value="Left">                            
                            <param name="Format"                	value="
                                <FC> id='{CUROW}'    		width=60    	name='NO'           	align=center    value={String(Currow)}</C>
                                <FC> id='APP_YN_NM' 			width=90   	name='결재구분'     	align=center </FC>
                                <FC> id='RQST_NO'  			width=90   	name='신청번호'     	align=center	MASK='XXXXXX-XXXX'  </FC>
                                <FC> id='RQST_REMARK'  	width=550   name='제목'         		align=left   </FC>
                                <FC> id='ORD_DATE'    		width=90   	name='상신일자'     	align=center    MASK='XXXX-XX-XX' </FC>
                                <C>  id='PENO_NM'    			width=80    	name='상신자'       	align=center  </C>
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