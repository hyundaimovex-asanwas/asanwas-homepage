	<!--*************************************************************************
	* @source      : crua030.jsp												*
	* @description : 합격자등록 PAGE		 								    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/03      오대성          최초작성									*
    * 2007/05/09   조정호          확인처리 로직 변경                           *
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>합격자등록(crua030)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TFFTFTFT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function fnc_SearchList() {
			var f = document.form1;

			if(!fnc_SearchItemCheck()) return;

			//학자금 신청서 처리 조회
			var regyy        = f.txtREGYY_SHR.value;
			var regch        = f.txtREGCH_SHR.value;
			var reg_str      = f.txtREG_NO_STR.value;
			var reg_end      = f.txtREG_NO_END.value;
			var school       = f.cmbSCHOOL_SHR.value;
			var split_flag   = f.rdoSPLIT_FLAG_SHR.CodeValue;
			var passtag      = f.cmbPASSTAG_SHR.value;



            //채용 차수 리스트 조회
            dsT_RC_HISTORY.dataid = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua040.cmd.CRUA040CMD&S_MODE=SHR2&PIS_YY="+regyy+"&SEQ_NO="+regch;
            dsT_RC_HISTORY.reset();

            //채용지원자 리스트 조회
            dsT_RC_MASTER.dataid = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua030.cmd.CRUA030CMD"
                                 + "&S_MODE=SHR"
                                 + "&REGYY="+regyy
                                 + "&REGCH="+regch
                                 + "&REG_STR="+reg_str
                                 + "&REG_END="+reg_end
                                 + "&SCHOOL="+school
                                 + "&SPLIT_FLAG="+split_flag
                                 + "&PASSTAG="+passtag;
            dsT_RC_MASTER.reset();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 *
         ********************************************/
        function fnc_SearchItem() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 03. 저장 함수							*
         ********************************************/
        function fnc_Save() {

			if(!fnc_SaveItemCheck()) return;

			trT_RC_MASTER.KeyValue = "tr01(I:dsT_RC_MASTER=dsT_RC_MASTER)";
			trT_RC_MASTER.action = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua030.cmd.CRUA030CMD&S_MODE=SAV";
			trT_RC_MASTER.post();

        }

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 05. 인쇄 함수  							*
         ********************************************/
        function fnc_Print() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 08. 추가 함수 							*
         ********************************************/
        function fnc_Append() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 09. 제거 함수 							*
         ********************************************/
        function fnc_Remove() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 10. 초기화 함수  						*
         ********************************************/
        function fnc_Clear() {

			var f = document.form1;
			f.txtREGYY_SHR.value = getToday().substring(0,4);
			f.txtREGCH_SHR.value = "01";
			f.txtREG_NO_STR.value = "";
			f.txtREG_NO_END.value = "";
			f.cmbSCHOOL_SHR.value = "";
			f.rdoSPLIT_FLAG_SHR.CodeValue = "A";
			f.cmbPASSTAG_SHR.value = "";
        	document.getElementById("resultMessage").innerText = ' ';

        	dsT_RC_MASTER.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {

			var regyy = document.getElementById('txtREGYY_SHR');
			var regch = document.getElementById('txtREGCH_SHR');
			var reg_str = document.getElementById('txtREG_NO_STR');
			var reg_end = document.getElementById('txtREG_NO_END');

			if(regyy.value == '') {
				alert("년도는 필수 입력사항입니다!");
				regyy.focus();
				return false;
			} else if(regyy.value.length < 4) {
				alert("4자리수의 년도를 입력하세요!");
				regyy.focus();
				return false;
			}
			if(regch.value == '') {
				alert("회차는 필수 입력사항입니다!");
				regch.focus();
				return false;
			} else if(regch.value.length < 2) {
				alert("2자리수의 회차를 입력하세요!");
				regch.focus();
				return false;
			}

			if(reg_str.value != '' && reg_str.value.length < 11) {
				alert("11자리수의 수험번호를 입력하세요!");
				reg_str.focus();
				return false;
			}
			if(reg_end.value != '' && reg_end.value.length < 11) {
				alert("11자리수의 수험번호를 입력하세요!");
				reg_end.focus();
				return false;
			}

			return true;

        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

			if (!dsT_RC_MASTER.IsUpdated) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}
			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   *
         ********************************************/
        function fnc_OnLoadProcess() {
			var f = document.form1;

			f.rdoSPLIT_FLAG_SHR.CodeValue = "A";

			f.txtREGYY_SHR.value = getToday().substring(0,4);
			f.txtREGCH_SHR.value = "01";


  			//첫번째 인수 : 그리드명                             두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid(form1.grdT_RC_MASTER,15,"false","right");      // Grid Style 적용
			f.txtREGYY_SHR.focus();

		    fnc_SearchList();
                form1.grdT_RC_MASTER.ColumnProp("{currow}" , "Sort") = "false";
                form1.grdT_RC_MASTER.ColumnProp("REG_NO" , "Sort") = "false";
                form1.grdT_RC_MASTER.ColumnProp("ENO_NM" , "Sort") = "false";
                form1.grdT_RC_MASTER.ColumnProp("BIRYMD" , "Sort") = "false";
                form1.grdT_RC_MASTER.ColumnProp("SEXGU" , "Sort") = "false";
                form1.grdT_RC_MASTER.ColumnProp("SCH_YMD" , "Sort") = "false";
                form1.grdT_RC_MASTER.ColumnProp("SCH_NM" , "Sort") = "false";
                form1.grdT_RC_MASTER.ColumnProp("SCH_MAJOR" , "Sort") = "false";
                form1.grdT_RC_MASTER.ColumnProp("SCH_GRDYN" , "Sort") = "false";
                form1.grdT_RC_MASTER.ColumnProp("PASSTAG" , "Sort")   = "false";
                form1.grdT_RC_MASTER.ColumnProp("PASSTAG1" , "Sort")  = "false";
                form1.grdT_RC_MASTER.ColumnProp("PASSTAG2" , "Sort")  = "false";
                form1.grdT_RC_MASTER.ColumnProp("PASSTAG3" , "Sort")  = "false";
                form1.grdT_RC_MASTER.ColumnProp("PASSTAG4" , "Sort")  = "false";
                form1.grdT_RC_MASTER.ColumnProp("FINAL_PASS", "Sort") = "false";

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /**
         * 합격여부 일괄 반영
         */
   /*   function fnc_BatchAdjust() {
            var pro_sts = dsT_RC_HISTORY.NameString(0, "PRO_STS");
            var columnName = "";

            if(pro_sts == "3")
                columnName = "PASSTAG1";
            else if(pro_sts == "4")
                columnName = "PASSTAG2";
            else if(pro_sts == "5")
                columnName = "PASSTAG3";
            else if(pro_sts == "6")
                columnName = "PASSTAG4";

            var passtag = document.getElementById("cmbPASSTAG").value;
            document.getElementById("cmbPASSTAG").value = "";

            if(columnName != "" || dsT_RC_MASTER.CountRow == 0) {
                for(var i=1; i<=dsT_RC_MASTER.CountRow; i++) {
                    dsT_RC_MASTER.NameString(i, columnName) = passtag;
                }
            } else {
                alert("반영할 대상이 없습니다.");
            }
        }*/

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_RC_MASTER)		   |
    | 3. 사용되는 Table List(T_RC_MASTER) 			       |
    +------------------------------------------------------>
	<Object ID="dsT_RC_MASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. 조회용 DataSet                                |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_RC_HISTORY)  |
    | 3. 사용되는 Table List(T_RC_HISTORY)          |
    +----------------------------------------------->
    <Object ID="dsT_RC_HISTORY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


	<!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_RC_MASTER)		|
    | 3. 사용되는 Table List(T_RC_MASTER)	            |
    +--------------------------------------------------->
    <Object ID ="trT_RC_MASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="sample_tr01(I:dsT_RC_MASTER=dsT_RC_MASTER)">
    </Object>


	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_RC_MASTER Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

	<Script For=dsT_RC_HISTORY Event="OnLoadCompleted(iCount)">

        grdT_RC_MASTER.ColumnProp("PASSTAG1", "BgColor") = "";
        grdT_RC_MASTER.ColumnProp("PASSTAG2", "BgColor") = "";
        grdT_RC_MASTER.ColumnProp("PASSTAG3", "BgColor") = "";
        grdT_RC_MASTER.ColumnProp("PASSTAG4", "BgColor") = "";

        if (iCount == 1)    {
            var pro_sts = dsT_RC_HISTORY.NameString(0, "PRO_STS");
            var columnName;
            if(pro_sts == "3")
                columnName = "PASSTAG1";
            else if(pro_sts == "4")
                columnName = "PASSTAG2";
            else if(pro_sts == "5")
                columnName = "PASSTAG3";
            else if(pro_sts == "6")
                columnName = "PASSTAG4";

            grdT_RC_MASTER.ColumnProp(columnName, "BgColor") = "#EEEEEE";
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_RC_MASTER Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!---------------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +---------------------------------------------------------------------->
	<Script For=dsT_RC_MASTER Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

   <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_RC_MASTER event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>


    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_RC_MASTER event="OnFail()">
        if (trT_RC_MASTER.ErrorCode != 50015) {
			document.getElementById("resultMessage").innerText = ' ';
			cfErrorMsg(this);
		}
    </script>


    <!--------------------------+
    | 그리드를 더블클릭했을때  |
    +--------------------------->
    <script language=JavaScript for=grdT_RC_MASTER event=OnDblClick(row,colid)>
        var pro_sts = dsT_RC_HISTORY.NameString(0, "PRO_STS");
        var columnName;
        var passTag;

        if(pro_sts == "3")
            columnName = "PASSTAG1";
        else if(pro_sts == "4")
            columnName = "PASSTAG2";
        else if(pro_sts == "5")
            columnName = "PASSTAG3";
        else if(pro_sts == "6")
            columnName = "PASSTAG4";


        if(columnName == colid) {
            passTag = dsT_RC_MASTER.NameString(row, colid);

            if(passTag == "Y") passTag = "N";
            else passTag = "Y";

            dsT_RC_MASTER.NameString(row, colid) = passTag;
        }
    </script>

     <!--------------------------+
     | 그리드 클릭시 Y/N 변경    |
     +--------------------------->
     <script language="javascript" for=grdT_RC_MASTER event=OnClick(row,colid)>
        if(row>0 && colid.substring(0,2) =="PA" || colid.substring(0,5) == "FINAL"){
          if(dsT_RC_MASTER.NameValue(row,colid) =="Y"){
             dsT_RC_MASTER.NameValue(row,colid) = "";
          }else{
             dsT_RC_MASTER.NameValue(row,colid) = "Y";
          }
        }
     </script>


    <!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">합격자등록</td>
					<td align="right" class="navigator">HOME/기타/채용관리/<font color="#000000">합격자등록</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0" id="searchTable">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="40"></col>
							<col width="70"></col>
							<col width="100"></col>
							<col width="170"></col>
							<col width="40"></col>
							<col width="120"></col>
							<col width="60"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td align="center" class="searchState">년도&nbsp;</td>
							<td class="padding2423">
                                <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                            <input type="text" id="txtREGYY_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                        </td>
                                        <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtREGYY_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                                    </tr>
                                    <tr>
                                        <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtREGYY_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                                    </tr>
                                </table>
							</td>
							<td align="right" class="searchState">수험번호&nbsp;</td>
							<td class="padding2423">
								<input id="txtREG_NO_STR"  size="11" maxLength="11" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" style="ime-mode:disabled"> - <input id="txtREG_NO_END"  size="11" maxLength="11" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" style="ime-mode:disabled">
							</td>
							<td align="right" class="searchState">학력</td>
							<td class="padding2423">
                                <select id="cmbSCHOOL_SHR">
                                    <option value="">전 체</option>
                                    <option value="Y">대졸이상</option>
                                    <option value="N">대졸미만</option>
                                </select>
							</td>
							<td align="right" class="searchState">합격여부</td>
							<td class="padding2423">
                                <select id="cmbPASSTAG_SHR">
                                    <option value="">원서접수</option>
                                    <option value="1">서류합격</option>
                                    <option value="2">1차면접합격</option>
                                    <option value="3">2차면접합격</option>
                                    <option value="4">3차면접합격</option>
                                    <option value="5">신체검사합격</option>
                                    <option value="6">최종합격</option>
                                </select>
							</td>
						</tr>
						<tr>
							<td align="center" class="searchState">차수&nbsp;</td>
							<td class="padding2423">
								<input id="txtREGCH_SHR"  size="4" maxLength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfCheckNumber2();" style="ime-mode:disabled">
							</td>
							<td align="center" class="searchState">신입/경력구분&nbsp;</td>
							<td class="padding2423"><comment id="__NSID__">
								<object id=rdoSPLIT_FLAG_SHR classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:20; width:140">
									<param name=AutoMargin	value="true">
									<param name=Cols		value="2">
									<param name=Format		value="A^신입사원,B^경력사원">
								</object>
								</comment><script> __ShowEmbedObject(__NSID__); </script>
							</td>
							<td></td>
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
			<td class="paddingTop5">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                 <!--      <td align="right">
                           <select id="cmbPASSTAG">
                                <option value=""></option>
                                <option value="Y">Y</option>
                                <option value="N">N</option>
                            </select>
                            &nbsp;
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBatchAdjust','','/images/button/BatchAdjustOver.gif',1)"><img type="image" style="border:0" src="/images/button/BatchAdjustOn.gif"  id="imgBatchAdjust"  name="imgBatchAdjust" width="80" height="20" border="0" align="absmiddle" onClick="fnc_BatchAdjust()"></a>
                   -->
                        </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- 조회 상태 테이블 끝 -->

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_RC_MASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_RC_MASTER">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value="
                            <C> id={currow}     width='40'  name='NO'           align=center    value={String(currow)} </C>
                            <C> id='REG_NO'     width='80'  name='수험번호'     align='center'  </C>
                            <C> id='ENO_NM'     width='60'  name='성명'         align='center'  </C>
                            <C> id='BIRYMD'     width='80'  name='생년월일'     align='center'  Mask='XXXX-XX-XX'  </C>
                            <C> id='SEXGU'      width='45'  name='성별'         align='center'  Value={Decode(SEXGU,'M','남','F','여')}  </C>
                            <C> id='SCH_YMD'    width='70'  name='졸업년도'     align='center'  Mask='XXXX-XX'  </C>
                            <C> id='SCH_NM'     width='90'  name='출신교'       align='left'    </C>
                            <C> id='SCH_MAJOR'  width='90'  name='전공'         align='left'    </C>
                            <C> id='SCH_GRDYN'  width='90'  name='졸업/졸예'    align='left'    </C>
                            <C> id='TOTAL_PNT'  width='60'  name='가산점'       align='center'  </C>
                            <C> id='TOTAL_COV'  width='60'  name='환산점'       align='center'  </C>
                            <C> id='TOTAL_SUM'  width='60'  name='합계'         align='center'  </C>
                            <C> id='PASSTAG'    width='60'  name='서류'         align='center'  color={Decode(PASSTAG,'Y','#FF0000')}</C>
                            <C> id='PASSTAG1'   width='60'  name='면접1'        align='center'  color={Decode(PASSTAG1,'Y','#FF0000')}</C>
                            <C> id='PASSTAG2'   width='60'  name='면접2'        align='center'  color={Decode(PASSTAG2,'Y','#FF0000')}</C>
                            <C> id='PASSTAG3'   width='60'  name='면접3'        align='center'  color={Decode(PASSTAG3,'Y','#FF0000')}</C>
                            <C> id='PASSTAG4'   width='60'  name='신검'         align='center'  color={Decode(PASSTAG4,'Y','#FF0000')}</C>
                            <C> id='FINAL_PASS' width='60'  name='최종합격'     align='center'  color={Decode(FINAL_PASS,'Y','#FF0000')}</C>
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
