<!--
*****************************************************
* @source       : vlul010.jsp
* @description  : 업적평가작성 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2014/11/13     이동훈        수정
* 2016/07/05     이동훈        ERP 이사
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<% String ENO_NO     = request.getParameter("ENO_NO"); %>

<html>
<head>
<title>업적평가작성</title>
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
	    
        var GUBUN   = "";

    	var ENO_NO = "<%=request.getParameter("ENO_NO") %>";
        
        
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //검색조건 2가지
            var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //해당년도
			var ENO_NO = document.form1.txtENO_NO_SHR.value;			//사번

			fnc_Term_Query(REG_YM_SHR);

			trT_EV_ABLRST.KeyValue = "tr01(O:dsT_EV_HWORKMST=dsT_EV_HWORKMST)";
			trT_EV_ABLRST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.l.vlul010.cmd.VLUL010CMD"
                                   + "&S_MODE=SHR"
                                   + "&REG_YM_SHR="+REG_YM_SHR
                                   + "&ENO_NO="+ENO_NO;
			trT_EV_ABLRST.post();

			if(dsT_EV_HWORKMST.countrow<1){
				fnc_AddNew();
			}else{
		        ifrm.fnc_Row_Clear(2); //초기화
			}

			ifrm.fnc_SearchList();

        }


		function fnc_Term_Query(REG_YM_SHR){

			var evaym = REG_YM_SHR.substr(2,2)+REG_YM_SHR.substr(5,7);

	        dsT_EV_TERM.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.l.vlul010.cmd.VLUL010CMD&S_MODE=SHR_TERM&evaym="+evaym;
	        dsT_EV_TERM.reset();

			document.form1.txt_term.value = dsT_EV_TERM.namevalue(dsT_EV_TERM.rowposition,"COMM_NM");

		}

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

          	var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //해당년도

			if(REG_YM_SHR!='2016-11'){

					alert("고과년월을 확인 하십시요.");

					return false;
			}


			if(!ifrm.fnc_Save_Chk()) return;

			if (confirm("저장하시겠습니까?")) {

				ifrm.fnc_Save();

			}

			fnc_SearchList();
			


		}


        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요
			ifrm.fnc_Print();
            
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

            //이곳에 해당 코딩을 입력 하세요
          	var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //해당년도
          	var EMPNO 	= document.form1.txtENO_NO_SHR.value;           //피고과자

		  	if(REG_YM_SHR!='2016-11'){
				alert("고과년월을 확인 하십시요.");
				return false;
			}

			if(!fnc_Add_Chk()) false;

            trT_EV_ABLRST.KeyValue = "tr01(O:dsT_EV_ABLRST=dsT_EV_ABLRST)";
            trT_EV_ABLRST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.l.vlul010.cmd.VLUL010CMD&S_MODE=SHR_00&EMPNO="+EMPNO;
            trT_EV_ABLRST.post();

		  	i = dsT_EV_ABLRST.rowposition;

		  	fnc_SetDataHeader();

		  	dsT_EV_HWORKMST.Addrow();

			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"EVAYM")   = REG_YM_SHR;
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"EMPNO")   = dsT_EV_ABLRST.namevalue(i,"ENO_NO");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"EMPNMK")  = dsT_EV_ABLRST.namevalue(i,"ENO_NM");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"HEADCD")  = dsT_EV_ABLRST.namevalue(i,"HEAD_CD");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"HEADNM")  = dsT_EV_ABLRST.namevalue(i,"HEAD_NM");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"DIVCD")   = dsT_EV_ABLRST.namevalue(i,"DPT_CD");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"DIVNM")   = dsT_EV_ABLRST.namevalue(i,"DPT_NM");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"DEPTCD")  = dsT_EV_ABLRST.namevalue(i,"TEAM_CD");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"DEPTNMK") = dsT_EV_ABLRST.namevalue(i,"TEAM_NM");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"PAYGRD")  = dsT_EV_ABLRST.namevalue(i,"JOB_CD");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"PAYGRDNM")= dsT_EV_ABLRST.namevalue(i,"JOB_NM");

			ifrm.fnc_Row_Clear(2); //초기화
        }


        /******************
         * 07. 진짜 신규 함수  *
         ******************/
        function fnc_New() {

            //이곳에 해당 코딩을 입력 하세요
            //검색조건 2가지
            var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //해당년도
			var EMPNO = document.form1.txtENO_NO_SHR.value;				//사번

			fnc_Clear();

 			ifrm.fnc_Row_Clear(2);

          	document.form1.txtREG_YM_SHR.value = '2016-11';
          	document.form1.txt_term.value = '2016.01.01~2016.11.30';

			if(!fnc_Add_Chk()){
				fnc_SearchList();
			}else{

			}

        }

		/******************************************************************************
			Description : 추가시 체크 기존 데이타 존재시 추가 못함.
		******************************************************************************/
		function fnc_Add_Chk(){

            //검색조건 2가지
            var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //해당년도
			var ENO_NO = document.form1.txtENO_NO_SHR.value;			//사번

	        dsT_EV_HWORKCHK.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.l.vlul010.cmd.VLUL010CMD&S_MODE=SHR_CHK&REG_YM_SHR="+REG_YM_SHR+"&ENO_NO="+ENO_NO;
	        dsT_EV_HWORKCHK.reset();

			if(dsT_EV_HWORKCHK.namevalue(1,"CNT")>0){
				alert("이미 데이타가 존재합니다. 조회 후 수정하십시요.");
				return false;
			}

			return true;
		}


		/******************************************************************************
			Description : 데이타셋 헤드 설정
		******************************************************************************/
		function fnc_SetDataHeader(){

		      //업적신고MST
			if (dsT_EV_HWORKMST.countrow<1){
						  var s_temp = " EVAYM:STRING(7),EMPNO:STRING(7),EMPNMK:STRING(30),HEADCD:STRING(4),HEADNM:STRING(50),"
									 + " DIVCD:STRING(4),DIVNM:STRING(50),DEPTCD:STRING(4),DEPTNMK:STRING(50),PAYGRD:STRING(4),PAYGRDNM:STRING(50), "
									 + " WORK_1:STRING(50),STARTDT_1:STRING(8),ENDDT_1:STRING(8),PLACE_1:STRING(50),REMARK_1:STRING(100),"
									 + " WORK_2:STRING(50),STARTDT_2:STRING(8),ENDDT_2:STRING(8),PLACE_2:STRING(50),REMARK_2:STRING(100),"
									 + " WORK_3:STRING(50),STARTDT_3:STRING(8),ENDDT_3:STRING(8),PLACE_3:STRING(50),REMARK_3:STRING(100),"
									 + " WRDT:STRING(8),WRID:STRING(10),UPDT:STRING(8),UPID:STRING(10)";
			  dsT_EV_HWORKMST.SetDataHeader(s_temp);
			}
		}

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

        	
            //이곳에 해당 코딩을 입력 하세요
        	ifrm.fnc_Add();

            
        }




        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

            //이곳에 해당 코딩을 입력 하세요
 			ifrm.fnc_Delete();
        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            //dsT_EV_HWORKMST.ClearData();

            document.getElementById("resultMessage").innerText = ' ';

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_ABLRST.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }
            
        	window.close();

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

		document.getElementById("txtREG_YM_SHR").value = '2016-11';

		
        if(dsTemp != "Modal"){ //팝업이 아닌경우
            document.getElementById("txtENO_NO_SHR").value = gusrid;
            document.getElementById("txtENO_NM_SHR").value = gusrnm;	
        }else{ //팝업인 경우
            document.getElementById("txtENO_NO_SHR").value = ENO_NO;
            fnc_GetNm();
        }	  		
		
    //정성호CJ, 이상묵GJ만 조회가능하도록

    	if(gusrid != "6060002" && gusrid != "6070001" && gusrid != "6050006" && gusrid != "2020008" && gusrid != "2070020"){ 
    	
    	
			fnc_ChangeStateElement(false, "txtENO_NO_SHR");
			fnc_ChangeStateElement(false, "txtENO_NM_SHR");
			fnc_ChangeStateElement(false, "ImgEnoNo");


    	}


		fnc_SearchList();


        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }


        function fnc_GetNm() {
            fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');
            fnc_SearchList();
    }        
        
    </script>

    </head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                        |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ABLRST)                       |
    | 3. 사용되는 Table List(T_EV_ABLRST)                              |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_HWORKMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_HWORKDTL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_HWORKCHK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_TERM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton            |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_ABLRST)        |
    | 3. 사용되는 Table List(T_EV_ABLRST)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_ABLRST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(I:T_EV_ABLRST=T_EV_ABLRST)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
            alert("검색하신 조건의 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {
            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">
        if (trT_EV_ABLRST.ErrorCode != 50015) {
            cfErrorMsg(this);
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
		<td height="20" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)"><img src="../../images/button/btn_PrintOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
			&nbsp;&nbsp;&nbsp;	&nbsp;		
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)"><img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
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
                                <col width="160"></col>
                                <col width="60"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right">고과년월&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onkeypress="cfDateHyphen(this);cfCheckNumber();" value="">
                               </td>
                                <td align="right" class="searchState">사번</td>
                                <td class="padding2423">
                                    <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10" class="input_ReadOnly"  readOnly maxlength="10" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();"  onChange="fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR');">
                                    <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="12" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)">
                                    <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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

<!-- 조건 입력 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="120"></col>
					<col width="80"></col>
					<col width="60"></col>
					<col width="180"></col>
					<col width="80"></col>
					<col width="120"></col>
					<col width="60"></col>
				</colgroup>
				<tr>
					<td align="center" class="blueBold" rowspan = 2>소 속</td>
					<td align="center" class="blueBold" rowspan = 2>직 위</td>
					<td align="center" class="blueBold" rowspan = 2>성 명</td>

		            <td align="center" class="blueBold" colspan=3><nobr>인사 이동 사항 (대상기간 : 
		            		<input id="txt_term"  type="text" style= "position:center;left:0px;width:135px;height:20px;" ReadOnly>)</nobr></td>
					<td align="center" class="blueBold" rowspan = 2>비 고</td>
				</tr>
				<tr>
					<td align="center" class="blueBold">근무 기간</td>
					<td align="center" class="blueBold">소속팀</td>
					<td align="center" class="blueBold">담당 업무</td>
				</tr>
        		<tr>
					<td class="tab15" style=""rowspan=3>
					  <input id="txt_evaym"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_headcd"  type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_divcd"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_deptcd"  type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_headnm"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:110px;height:20px;" ReadOnly>
						<input id="txt_divnm"   type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:110px;height:20px;" ReadOnly>
						<input id="txt_deptnm"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:110px;height:20px;" ReadOnly>
					</td>
					<td class="tab18" style=""rowspan=3 align="center"><nobr>
					  <input id="txt_paygrd"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width5px;height:20px;" ReadOnly>
						<input id="txt_paygrdnm" type="text"     class="txtbox"  style= "position:relative;left:0px;top:0px;width:70px;height:20px;" ReadOnly>
					</nobr></td>
					<td class="tab18" style=""rowspan=3 align="center"><nobr>
						<input id="txt_empno"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_empnmk"  type="text"     class="txtbox"  style= "position:relative;left:0px;top:0px;width:55px;height:20px;" ReadOnly>
					</nobr></td>
					<td class="tab18" style="" align="center"><nobr>
						<comment id="__NSID__">
						<object id=gcem_startdt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">
											<param name=Text					value="">
											<param name=Alignment     		value=1>
											<param name=Border        		value=true>
											<param name=Format        		value="YYYY/MM/DD">
											<param name=PromptChar    		value="_">
											<param name=BackColor     		value="#CCCCCC">
											<param name=InheritColor  		value=false>
						 </object></comment><script> __ShowEmbedObject(__NSID__); </script>&nbsp; ~
  					 <comment id="__NSID__">
						 <object id=gcem_enddt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">
											<param name=Text					value="">
											<param name=Alignment     		value=1>
											<param name=Border        		value=true>
											<param name=Format        		value="YYYY/MM/DD">
											<param name=PromptChar    		value="_">
											<param name=BackColor     		value="#CCCCCC">
											<param name=InheritColor  		value=false>
						 </object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</nobr></td>
					<td class="tab18" style="" align="center">
						<nobr><input id="txt_place_1"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:120px;height:20px;" ></nobr>
					</td>
					<td class="tab18" style="" align="center">
						<nobr><input id="txt_work_1"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:150px;height:20px;" ></nobr>
					</td>
          			<td class="tab18" style="" align="center">
          				<nobr><input id="txt_remark_1"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:150px;height:20px;" ></nobr>
				   </td>
				</tr>

				<tr>
					<td class="tab18" style="" align="center"><nobr>
						<comment id="__NSID__">
						<object id=gcem_startdt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">
											<param name=Text					value="">
											<param name=Alignment     		value=0>
											<param name=Border        		value=true>
											<param name=Format        		value="YYYY/MM/DD">
											<param name=PromptChar    		value="_">
											<param name=BackColor     		value="#CCCCCC">
											<param name=InheritColor  		value=false>
						 </object></comment><script> __ShowEmbedObject(__NSID__); </script>&nbsp; ~
  					 	 <comment id="__NSID__">
						 <object id=gcem_enddt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">
											<param name=Text					value="">
											<param name=Alignment     		value=0>
											<param name=Border        		value=true>
											<param name=Format        		value="YYYY/MM/DD">
											<param name=PromptChar    		value="_">
											<param name=BackColor     		value="#CCCCCC">
											<param name=InheritColor  		value=false>
						 </object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</nobr></td>

					<td class="tab18" style="" align="center"><nobr>
							<input id="txt_place_2"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:120px;height:20px;" >
					</nobr></td>

					<td class="tab18" style="" align="center"><nobr>
            		<input id="txt_work_2"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:150px;height:20px;" >
          			</nobr></td>

					<td class="tab18" style="" align="center"><nobr>
					    <input id="txt_remark_2"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:150px;height:20px;" >
					</nobr></td>
				</tr>
				<tr>
					<td class="tab18" style="" align="center"><nobr>
						<comment id="__NSID__">
						<object id=gcem_startdt_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">
											<param name=Text					value="">
											<param name=Alignment     		value=0>
											<param name=Border        		value=true>
											<param name=Format        		value="YYYY/MM/DD">
											<param name=PromptChar    		value="_">
											<param name=BackColor     		value="#CCCCCC">
											<param name=InheritColor  		value=false>
						 </object></comment><script> __ShowEmbedObject(__NSID__); </script>&nbsp; ~
  					 <comment id="__NSID__">
						 <object id=gcem_enddt_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">
											<param name=Text					value="">
											<param name=Alignment     		value=0>
											<param name=Border        		value=true>
											<param name=Format        		value="YYYY/MM/DD">
											<param name=PromptChar    		value="_">
											<param name=BackColor     		value="#CCCCCC">
											<param name=InheritColor  		value=false>
						 </object></comment><script> __ShowEmbedObject(__NSID__); </script>

					</nobr></td>

					<td class="tab18" style="" align="center"><nobr>
						 <input id="txt_place_3"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:120px;height:20px;" >
					</nobr></td>

					<td class="tab18" style="" align="center"><nobr>
						<input id="txt_work_3"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:150px;height:20px;" >
					</nobr></td>

					<td class="tab18" style="" align="center"><nobr>
						 <input id="txt_remark_3"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:150px;height:20px;" >
					</nobr></td>
				</tr>


			</table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr>
					<td valign="top" width="300" class="searchState"><span id="resultMessage">&nbsp;</span></td>
					<td valign="top" width="550" >* 본인 평가기준 : S(목표110%이상달성), A(100%이상), B(90%이상), C(80%이상), D(80%미만)</td>					
					<td align="right">  <!-- 추가 삭제 버튼 -->
						<img src="../../images/button/btn_AppendOn.gif" name="imgAppend" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend','','../../images/button/btn_AppendOver.gif',1)" style="cursor:hand;">
						<img src="../../images/button/btn_RemoveOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','../../images/button/btn_RemoveOver.gif',1)" style="cursor:hand;">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->




<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000"  border="1" cellspacing="0" cellpadding="0" bordercolor="#999999">
 
	<tr >
		<td style="padding-top:1px;">
			<table border=1 cellspacing="0" cellpadding="0" height="10px">
				<tr>
					<td align="center" class="blueBold" width="40px"  ROWSPAN="2">No</td>
					<td align="center" class="blueBold" width="100px" ROWSPAN="2">항 목</td>
					<td align="center" class="blueBold" width="600px" ROWSPAN="2">주요 업적 내용</td>
					<td align="center" class="blueBold" width="270px" colspan="3">본인 평가</td>
				</tr>
				<tr>
					<td align="center" class="blueBold" width="90px" >가중치(%)</td>
					<td align="center" class="blueBold" width="90px" >점수입력</td>
					<td align="center" class="blueBold" width="90px" >환산점수</td>
				</tr>
			</table>
		</td>
	</tr>


	<tr>
	 <td >
		<iframe id="ifrm" name="ifrm" src="./vlul010_ifrm.jsp" frameborder=0 style="position:relative;top:1px;width:1000;height:370px;border:1 solid #708090;"></iframe>
	 </td>
	</tr>

</table>


<!-- 내용 조회 그리드 데이블 끝-->
	<tr>
	 <td > <br> </td>
		<td align="left" class="blueBold">
			<font color="blue" size="2" bold="5" face = "Verdana"">※ 가중치의 총 합계는 </font>
			<font color="red" size="2" bold="5" face = "Verdana"">100% </font>
			<font color="blue" size="2" bold="5" face = "Verdana"">가 되도록, 점수는 </font>
			<font color="red" size="2" bold="5" face = "Verdana"">S,A,B,C,D 중 선택하여</font>
			<font color="blue" size="2" bold="5" face = "Verdana"">입력해 주시기 바랍니다. 환산점수는 </font>
			<font color="red" size="2" bold="5" face = "Verdana"">저장 후 자동계산</font>
			<font color="blue" size="2" bold="5" face = "Verdana"">됩니다.
				<br>&nbsp;&nbsp;&nbsp;기존 업적 신고 작성 자료는 고과년월을 변경 후(ex:2016-07 or 2015-11) 조회가능합니다.
			</font>
		</td>
	 </td>
	</tr>
	
</form>
<!-- form 끝 -->


</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!--  테이블 -->
<object id="bndT_EV_HWORKMST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_EV_HWORKMST">
	<Param Name="BindInfo", Value='
		<C>Col=EVAYM      		ctrl=txt_evaym		  		param=value	 </C>
		<C>Col=EMPNO      		ctrl=txt_empno		  		param=value	 </C>
		<C>Col=EMPNMK     	ctrl=txt_empnmk		  	param=value	 </C>
		<C>Col=HEADCD     		ctrl=txt_headcd		  		param=value	 </C>
		<C>Col=HEADNM     	ctrl=txt_headnm		  	param=value	 </C>
		<C>Col=DIVCD      		ctrl=txt_divcd		  		param=value	 </C>
		<C>Col=DIVNM      		ctrl=txt_divnm		  		param=value	 </C>
		<C>Col=DEPTCD     		ctrl=txt_deptcd     		param=value	 </C>
		<C>Col=DEPTNMK    	ctrl=txt_deptnm		  	param=value	 </C>
		<C>Col=PAYGRD     		ctrl=txt_paygrd     		param=value	 </C>
		<C>Col=PAYGRDNM   	ctrl=txt_paygrdnm   		param=value	 </C>
		<C>Col=WORK_1     	ctrl=txt_work_1     		param=value	 </C>
		<C>Col=STARTDT_1  	ctrl=gcem_startdt_1 	param=text   </C>
		<C>Col=ENDDT_1    	ctrl=gcem_enddt_1	  	param=text	 </C>
		<C>Col=PLACE_1    		ctrl=txt_place_1    		param=value	 </C>
		<C>Col=REMARK_1		ctrl=txt_remark_1 		param=value	 </C>
		<C>Col=WORK_2     	ctrl=txt_work_2     		param=value	 </C>
		<C>Col=STARTDT_2  	ctrl=gcem_startdt_2 	param=text   </C>
		<C>Col=ENDDT_2    	ctrl=gcem_enddt_2	  	param=text	 </C>
		<C>Col=PLACE_2    		ctrl=txt_place_2    		param=value	 </C>
		<C>Col=REMARK_2		ctrl=txt_remark_2 		param=value	 </C>
		<C>Col=WORK_3     	ctrl=txt_work_3     		param=value	 </C>
		<C>Col=STARTDT_3  	ctrl=gcem_startdt_3 	param=text   </C>
		<C>Col=ENDDT_3    	ctrl=gcem_enddt_3	  	param=text	 </C>
		<C>Col=PLACE_3    		ctrl=txt_place_3    		param=value	 </C>
		<C>Col=REMARK_3		ctrl=txt_remark_3 		param=value	 </C>
    '>
</object>




