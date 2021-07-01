<!--
*****************************************************
* @source       : codd020.jsp
* @description : 결재처리목록 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2016/04/28            이동훈            	ERP 이사			
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>결재처리목록</title>
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

        var dsTemp = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			//검색조건(기간)
			var str_ymd = document.getElementById("txtSTR_YMD_SHR").value;
            var end_ymd = document.getElementById("txtEND_YMD_SHR").value;
            var eno_no = document.getElementById("txtENO_NO_SHR").value;
            var app_yn = document.getElementById("cmbAPP_YN_SHR").value;

			
            if(!fnc_SearchItemCheck()) return;

            dsT_DI_APPROVAL.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.d.codd020.cmd.CODD020CMD&S_MODE=SHR&STR_YMD_SHR="+str_ymd+"&END_YMD_SHR="+end_ymd+"&ENO_NO_SHR="+eno_no+"&APP_YN_SHR="+app_yn;
            dsT_DI_APPROVAL.reset();

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

	            window.close();

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

        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopupSHR() {
        	
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "3");

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmpNoSHR();
            }
            
        }

        /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */
        function fnc_SearchEmpNmSHR() {
        	
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "3");
            fnc_SearchEmpNoSHR();
            
        }
        
        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNoSHR() {
        	
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "3");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO_SHR").value      = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
            } else {
                document.getElementById("txtENO_NO_SHR").value      = "";
                document.getElementById("txtENO_NM_SHR").value      = "";
            }
            
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");      // Grid Style 적용

			document.getElementById("txtSTR_YMD_SHR").value = prev_month(gcurdate)+"-"+gcurdate.substring(8);
			document.getElementById("txtEND_YMD_SHR").value = gcurdate;


            document.getElementById("txtENO_NO_SHR").value = gusrid;  
            document.getElementById("txtENO_NM_SHR").value = gusrnm;			
			
            fnc_ChangeStateElement(true, "ImgEnoNoShr");
            fnc_ChangeStateElement(true, "txtENO_NO_SHR");
            fnc_ChangeStateElement(true, "txtENO_NM_SHR");
            
			if(gusrid != "6060002" && gusrid != "6070001" && gusrid != "6050006" && gusrid != "2030007" && gusrid != "2070020" && gusrid != "2080003" && gusrid != "2140002" ){ 

	            fnc_ChangeStateElement(false, "ImgEnoNoShr");
	            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            
			}			
			
			
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
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_DI_APPROVAL                     |
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

    var param = new String();


    if(row < 1) {

        return;

    } else {

        cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_CP, "copyHeader=yes,rowFrom="+row+",rowCnt=1");

        //일일근태, 근태변경, 익월근태, 연차촉진제
        if(dsT_DI_APPROVAL.NameValue(row,"GUN_GBN") == "C" || dsT_DI_APPROVAL.NameValue(row,"GUN_GBN") == "U" || dsT_DI_APPROVAL.NameValue(row,"GUN_GBN") == "P" || dsT_DI_APPROVAL.NameValue(row,"GUN_GBN") == "A"){
            
        	window.showModalDialog("../../hr/gun/guna071.jsp", dsT_DI_APPROVAL_CP, "dialogWidth:870px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

        //국내출장
        }else if(dsT_DI_APPROVAL.NameValue(row,"GUN_GBN") == "X"){

			var url = "../../hr/but/buta025.jsp?ORD_NO=" + dsT_DI_APPROVAL.NameValue(row,"REQ_NO")+ "&PENO_NO=" + dsT_DI_APPROVAL.NameValue(row,"PENO_NO") + "&APP_STATUS=" + dsT_DI_APPROVAL.NameValue(row,"APP_STATUS") + "&APP_CMT=" + dsT_DI_APPROVAL.NameValue(row,"APP_CMT");
            window.showModalDialog(url, "Modal", "dialogWidth:870px; dialogHeight:650px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

        //경공조금
        }else if(dsT_DI_APPROVAL.NameValue(row,"GUN_GBN") == "Y"){

             var url = "../../hr/aid/aida011.jsp?REQ_NO="+dsT_DI_APPROVAL.NameString(row, "REQ_NO")+"&TYPE=TYPE2";
			cfWinOpen(url,"경공조",870,500)

        //교육신청
        }else if(dsT_DI_APPROVAL.NameValue(row,"GUN_GBN") == "M"){
			window.showModalDialog("../../hr/edu/edue041.jsp", dsT_DI_APPROVAL_CP, "dialogWidth:870px; dialogHeight:770px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

        //도서구입
        }else if(dsT_DI_APPROVAL.NameValue(row,"GUN_GBN") == "Q"){

      		param.req_no    = dsT_DI_APPROVAL.NameValue(row, "REQ_NO");
        	window.showModalDialog("../../hr/cdp/book011.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

        }
        
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
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">
<input type="hidden" id="hidEMPL_DPT_CD">


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
								<td class="searchState" align="right">상신기간&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> 
                                    <!--  
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','../../images/button/btn_HelpOver.gif',1)">
                                    <img src="../../images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','225','113');"></a> ~
                                    -->
                                    ~
                                    <input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> 
                                    <!--
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','../../images/button/btn_HelpOver.gif',1)">
                                    <img src="../../images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','340','113');"></a>
                                     -->
                                </td>
							<td class="searchState" align="right">결재자</td>
							<td class="padding2423" align="left">
								<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="7" maxlength= "7"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNoSHR()" onchange="fnc_SearchEmpNoSHR()">
                        		<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="10" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNmSHR()" onchange="fnc_SearchEmpNmSHR()">
                        		<img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoSHR" name="ImgEnoNoSHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopupSHR()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
							</td>
							<td class="searchState" align="right">결재여부</td>
							<td class="padding2423" align="left">
								<select id="cmbAPP_YN_SHR" style="width='100';" onChange="fnc_SearchList()">
									<option value="">모두</option>
									<option value="미결">미결</option>
									<option value="결재">결재</option>
									<option value="부결">부결</option>
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


<!-- 내용 조회 그리드 테이블 시작-->
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
<!-- 내용 조회 그리드 데이블 끝-->
	
	
<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Format"				value="
                                <C> id='{CUROW}'    width=40    name='NO'           	align=center    value={String(Currow)}</C>
								<C> id='GBN_NM'		width=150	name='구분'		    	align=center </C>
								<C> id='PENO_NO'		width=100	name='상신자사번'	    align=center </C>
								<C> id='PENO_NM'	width=150	name='상신자성명'	    align=center </C>
								<C> id='ENO_NO'	    width=100	name='결재자사번'   	align=center </C>
								<C> id='ENO_NM'	    width=150	name='결재자'	    	align=center </C>
 								<C> id='APP_YN' 		width=120	name='결재현황'	    align=center  </C>
 								<C> id='IPT_YMD' 	width=150	name='상신일'	    	align=center  </C>
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

