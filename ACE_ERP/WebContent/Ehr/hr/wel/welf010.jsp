	<!--*************************************************************************
	* @source      : welf010.jsp												*
	* @description : 지급장비관리 PAGE										    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/21            채갑병          	        최초작성			    *
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>지급장비관리(welf010)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var year = getToday().substring(0,4);
		var btnList = 'TTTTFFTT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
			//지급장비관리 정보 조회
			// var SU P_YMD_SHR    = document.getElementById("txtSU P_YMD_SHR").value;
			// var RE T_YMD_SHR    = document.getElementById("txtRE T_YMD_SHR").value;
			var USE_GBN_SHR    = document.getElementById("cmbUSE_GBN_SHR").value;
			var SERIAL_NO_SHR  = document.getElementById("txtSERIAL_NO_SHR").value;
			var ENO_NO_SHR     = document.getElementById("txtENO_NO_SHR").value;

  // alert("/servlet/GauceChannelSVL?cmd=hr.wel.f.welf010.cmd.WELF010CMD&S_MODE=SHR&SUP_YMD_SHR="+SUP_YMD_SHR+"&RET_YMD_SHR="+RET_YMD_SHR+"&SERIAL_NO_SHR="+SERIAL_NO_SHR+"&USE_GBN_SHR="+USE_GBN_SHR);

			dsT_WL_VISITOR.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.f.welf010.cmd.WELF010CMD&S_MODE=SHR&SERIAL_NO_SHR="+SERIAL_NO_SHR+"&USE_GBN_SHR="+USE_GBN_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
	//		dsT_WL_VISITOR.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.f.welf010.cmd.WELF010CMD&S_MODE=SHR_01&ENO_NO_SHR="+ENO_NO_SHR;
			dsT_WL_VISITOR.reset();
        }

        /**
         * 장비 번호가 사용가능한지 여부를 검증한다.
         */
        function fnc_ChkCardNo() {
            var SERIAL_NO = document.getElementById("txtSERIAL_NO").value;
            if(SERIAL_NO == "") {
                return;
            }
			dsCHK_SERIAL_NO.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.f.welf010.cmd.WELF010CMD&S_MODE=CHK&SERIAL_NO="+SERIAL_NO;
			dsCHK_SERIAL_NO.reset();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 03. 저장 함수								*
         ********************************************/
        function fnc_Save() {
			if ( !fnc_SaveItemCheck() ) {
				return;
			}

           //
           // trT_CP_PAYTABLE.KeyValue = "SVL(I:SAV=dsT_CP_PAYTABLE, O:dsRESULT=dsRESULT)";
		   // trT_CP_PAYTABLE.Action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga010.cmd.SAGA010CMD&S_MODE=SAV&TYPE="+savObj.type+"&APY_YMD="+savObj.apy_ymd+"&OCC_CD="+savObj.occ_cd;
		   // trT_CP_PAYTABLE.Post();


			// save
			trT_WL_VISITOR.KeyValue = "tr01(I:dsT_WL_VISITOR=dsT_WL_VISITOR)";
			trT_WL_VISITOR.action = "/servlet/GauceChannelSVL?cmd=hr.wel.f.welf010.cmd.WELF010CMD&S_MODE=SAV";
			trT_WL_VISITOR.post();
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
	        fnc_Remove();
        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_WL_VISITOR.CountColumn == 0) {
				dsT_WL_VISITOR.setDataHeader("EQUP_KIND:STRING, PUM_NM:STRING, MODEL_NO:STRING, SERIAL_NO:STRING, DPT_NM:STRING, JOB_NM:STRING, ENO_NM:STRING,  CONFIG:STRING, BUY_YMD:STRING, SUP_YMD:STRING, USE_GBN:STRING, REMARK:STRING, ASST_NO:STRING, ASST_AMT:DECIMAL(15.0), DPT_NM1:STRING, REG_NM:STRING");
			}

			// 행 추가
			dsT_WL_VISITOR.AddRow();

			// 장비번호 입력란으로 포커스 이동
			document.form1.txtSERIAL_NO.selectedIndex = 0;
			document.form1.cmbUSE_GBN.selectedIndex = 0;
			document.getElementById("txtEQUP_KIND").focus();
        }

		/********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {
	        if (dsT_WL_VISITOR.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }else{
           		var tmpMSG = "아래 행을 삭제하시겠습니까?\n";
            	tmpMSG += "SERIAL 번호   = "+dsT_WL_VISITOR.nameValue(dsT_WL_VISITOR.RowPosition, "SERIAL_NO")+"\n";

	            if( confirm(tmpMSG) ){
					var SERIAL_NO = dsT_WL_VISITOR.nameValue(dsT_WL_VISITOR.RowPosition, "SERIAL_NO");

					dsT_WL_VISITOR.DeleteRow(dsT_WL_VISITOR.RowPosition);

					// 파라미터 추가
					trT_WL_VISITOR.Parameters = "SERIAL_NO = "+SERIAL_NO;

					trT_WL_VISITOR.KeyValue = "tr01(I:dsT_WL_VISITOR=dsT_WL_VISITOR)";
					trT_WL_VISITOR.action = "/servlet/GauceChannelSVL?cmd=hr.wel.f.welf010.cmd.WELF010CMD&S_MODE=DEL";
					trT_WL_VISITOR.post();
				}
			}
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
			//document.form1.txtSUP_YMD_SHR.value = "";          // 시작일자(검색)
			//document.form1.txtRET_YMD_SHR.value = "";          // 종료일자(검색)
			document.form1.txtSERIAL_NO.selectedIndex = 0;       // Serial 번호
			document.form1.cmbUSE_GBN.selectedIndex = 0;      // 사용여부
			document.form1.cmbUSE_GBN_SHR.selectedIndex = 0;  // 사용여부(검색)

            fnc_DisableElementAll(elementList);
        	dsT_WL_VISITOR.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_WL_VISITOR.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {
         	if ( !dsT_WL_VISITOR.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
            // document.getElementById("txtSUP_YMD_SHR").value = getStrDate();
            // document.getElementById("txtRET_YMD_SHR").value = getEndDate();

			cfStyleGrid(form1.grdT_WL_VISITOR,15,"false","right");      // Grid Style 적용-> Sort 가능


            fnc_DisableElementAll(elementList);
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form이 Active 될 때 처리 할 일 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form이 Active 될 때 마다 재조회 처리
		}



        var elementList = new Array(
                                    "txtPUM_NM"
                                    );
        var exceptionList = new Array(
        					        "txtSERIAL_NO"
                                      );


        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
          function fnc_ClickEmpPopup() {
           var obj = new String();

            obj.shr_kind = "SHR_02";
            obj.eno_nm = "";

            window.showModalDialog("/common/popup/empl2.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            document.getElementById("txtENO_NO").value = obj.eno_no;
            document.getElementById("txtENO_NM").value = obj.eno_nm;
            document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            document.getElementById("txtJOB_NM").value = obj.job_nm;
       }

        /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */
        function fnc_SearchEmpNm() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetEnoNo('txtENO_NM', 'txtENO_NO','1');
            fnc_SearchEmpNo();
        }

        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var obj = new String;
            // 정규직 전체
            obj = fnc_GetEnoNm("txtENO_NO","","1");
            if(document.getElementById("txtENO_NO").value != "") {

                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
            }
        }
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_WL_VISITOR)			 	   |
    | 3. 사용되는 Table List(T_WL_VISITOR) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_WL_VISITOR" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	<Object ID="dsCHK_SERIAL_NO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_WL_VISITOR)			       |
    | 3. 사용되는 Table List(T_WL_VISITOR)				       |
    +------------------------------------------------------>
	<Object ID="trT_WL_VISITOR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_WL_VISITOR=dsT_WL_VISITOR,I:dsT_WL_VISITOR=dsT_WL_VISITOR)">
	</Object>


	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_WL_VISITOR Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_WL_VISITOR.CountRow);
        }
    </Script>

	<Script For=dsCHK_SERIAL_NO Event="OnLoadCompleted(iCount)">
        if(dsCHK_SERIAL_NO.NameString(0, "IS_USE") == "Y") {
            alert("사용할 수 없는 장비번호 입니다.");

            document.getElementById("txtSERIAL_NO").value = "";
            document.getElementById("txtSERIAL_NO").focus();
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_WL_VISITOR Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_WL_VISITOR Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_WL_VISITOR event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_WL_VISITOR event="OnFail()">
        alert(trT_WL_VISITOR.ErrorMsg);
    </script>

	<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_WL_VISITOR event=CanRowPosChange(row)>
		if ( dsT_WL_VISITOR.NameValue(row,"SERIAL_NO") == "" ) {
			alert("[ " + grdT_WL_VISITOR.GetHdrDispName('-3','SERIAL_NO') + " ]은 필수 입력사항입니다");
			return false;
		}
		if ( dsT_WL_VISITOR.NameValue(row,"EQUP_KIND") == "" ) {
			alert("[ " + grdT_WL_VISITOR.GetHdrDispName('-3','EQUP_KIND') + " ]은 필수 입력사항입니다");
			return false;
		}


	</script>

    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +----------------------------------------------------
    --<script language=JavaScript for=dsT_WL_VISITOR event=OnRowPosChanged(row)>
		fnc_DisableElementAll(elementList);
        if(row > 0) {
            //신청이거나  미반납일 경우 내역을 수정할 수 있다.
            if(dsT_WL_VISITOR.RowStatus(row) == "1"
                    || dsT_WL_VISITOR.NameValue(row, "USE_GBN") == "1") {
                fnc_EnableElementAll(elementList, exceptionList);
            }
        }
        fnc_EnableElementAll(elementList, exceptionList);
	--</script>

     -->

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">지급장비관리</td>
					<td align="right" class="navigator">HOME/기타/지급장비/<font color="#000000">지급장비관리</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
		  			<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="60"></col>
							<col width="260"></col>
							<col width="60"></col>
							<col width="150"></col>
							<col width="70"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
						    <td align="right" class="searchState"> 사&nbsp;&nbsp;번&nbsp;</td>
                            <td class="padding2423">
                                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13){fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');}" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled">
                                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="10" maxlength="10" onkeypress="if(event.keyCode==13){fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');}" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');"></a>
                            </td>
							<td class="searchState" align="right">사용구분</td>
							<td class="padding2423" align="left">
								<select id="cmbUSE_GBN_SHR" style="width='50%';" onChange="fnc_SearchList()">
									<option value="">전체</option>
									<option value="1">개인지급</option>
									<option value="2">공용지급</option>
									<option value="3">대여용</option>
								</select>
							</td>
							<td class="searchState" align="right">Serial No</td>
							<td class="padding2423" align="left">
                                <input type="text" name="txtSERIAL_NO_SHR" id="txtSERIAL_NO_SHR" size="25" maxlength="30">
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

	<!--  입력 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="70"></col>
					<col width="200"></col>
					<col width="70"></col>
					<col width="100"></col>
					<col width="70"></col>
					<col width="100"></col>
					<col width="70"></col>
					<col width="*"></col>

				</colgroup>
				<tr>
					<td align="center" class="creamBold">품명</td>
					<td class="padding2423"><input type="text" name="txtEQUP_KIND" id="txtEQUP_KIND" size="3" maxlength="3" onChange="fnc_GetCommNm('EQ', 'txtEQIP_KIND','txtPUM_NM');">
					                        <input type="text" name="txtPUM_NM"     id="txtPUM_NM" size="18" class="input_ReadOnly"  readonly>
					                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgHirCd" name="ImgHirCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtEQUP_KIND','txtPUM_NM','지급장비','EQ')"></a>
                    </td>
					<td align="center" class="creamBold">모델명</td>
					<td class="padding2423">
                        <input type="text" name="txtMODEL_NO" id="txtMODEL_NO" size="15" maxlength="30">
					</td>
					<td align="center" class="creamBold">Serial No</td>
					<td class="padding2423">
                        <input type="text" name="txtSERIAL_NO" id="txtSERIAL_NO" size="15" maxlength="30">
					</td>
					<td align="center" class="creamBold">사양</td>
					<td class="padding2423">
                        <input type="text" name="txtCONFIG" id="txtCONFIG" size="15" maxlength="30">
				</tr>
				<tr>
                    <td align="center" class="creamBold">사번</td>
                    <td class="padding2423" >
                        <input id="txtENO_NO" name="txtENO_NO" maxlength="10" size="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" maxlength="10" size="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="FindEmpl" name="FindEmpl" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()"></a>
                    </td>
					<td align="center" class="creamBold">부서</td>
					<td class="padding2423"><input id="txtDPT_NM" name="txtDPT_NM" size="12" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">직위</td>
					<td class="padding2423"><input id="txtJOB_NM" name="txtJOB_NM" size="12" class="input_ReadOnly" readonly></td>
    				<td align="center" class="creamBold">지급일자</td>
					<td class="padding2423">
						<input type="text" id="txtSUP_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSUP_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgSUP_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSUP_YMD','','150','200');"></a>
					</td>

				</tr>
				<tr>
    				<td align="center" class="creamBold">구입일자</td>
					<td class="padding2423">
						<input type="text" id="txtBUY_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBUY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgBUY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtBUY_YMD','','150','200');"></a>
					</td>
					<td align="center" class="creamBold">자산번호</td>
                    <td class="padding2423" >
                    	<input type="text" name="txtASST_NO" id="txtASST_NO" size="15" maxlength="15" >
					</td>
					<td align="center" class="creamBold">취득금액</td>
					<td class="padding2423">
						<input type="text" name="txtASST_NO" id="txtASST_AMT" size="15" maxlength="15" >
					</td>
					<td align="center" class="creamBold">사용구분</td>
					<td class="padding2423">
						<select id="cmbUSE_GBN" style="width='100%';">
							<option value="1">개인지급</option>
							<option value="2">공용지급</option>
							<option value="3">대여용</option>
						</select>
					</td>


				</tr>
				<tr>
                    <td align="center" class="creamBold">공용부서</td>
                    <td class="padding2423" >
                    	<input type="text" name="txtDPT_NM1" id="txtDPT_NM1" size="30" maxlength="30" >
                    </td>
                    <td align="center" class="creamBold">등록자</td>
                    <td class="padding2423" >
                    	<input type="text" name="txtREG_NM" id="txtREG_NM" size="15" maxlength="12" >
                    </td>
                    <td align="center" class="creamBold">비고</td>
                    <td class="padding2423" colspan="3" >
                    	<input type="text" name="txtREMARK" id="txtREMARK" size="45" maxlength="80" >
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
					<object id="grdT_WL_VISITOR" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_WL_VISITOR">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="EQUP_KIND"	width=50	name="분류"			sort=true align=center	Edit=none</C>
							<C> id="PUM_NM"		width=100	name="품명"			sort=true align=center	Edit=none</C>
							<C> id="MODEL_NO"	width=120	name="모델명"		sort=true align=center	Edit=none</C>
							<C> id="SERIAL_NO"	width=120	name="SERIAL NO"	sort=true align=center	Edit=none</C>
							<C> id="DPT_NM" 	width=80	name="소속" 		sort=true align=center	Edit=none</C>
							<C> id="JOB_NM" 	width=60	name="직위" 		sort=true align=left		Edit=none</C>
							<C> id="ENO_NM" 	width=80	name="성명" 		sort=true align=center	Edit=none</C>
							<C> id="CONFIG" 	width=130	name="사양" 		sort=true align=center	Edit=none</C>
							<C> id="BUY_YMD"	width=80	name="구입일"		sort=true align=center	Edit=none</C>
							<C> id="SUP_YMD"	width=80	name="지급일"		sort=true align=center	Edit=none</C>
							<C> id="USE_GBN"	width=80	name="사용구분"		sort=true align=center	Edit=none	EditStyle=Combo		Data = "1:개인지급,2:공용지급,3:대여용"</C>
							<C> id="ASST_NO"	width=80	name="자산번호"		sort=true align=center	Edit=none</C>
							<C> id="ASST_AMT"	width=80	name="취득금액"		sort=true align=center	Edit=none</C>
							<C> id="DPT_NM1"	width=150	name="공용지급부서"	sort=true align=center	Edit=none</C>
							<C> id="REG_NM"		width=80	name="등록사용자"	sort=true align=center	Edit=none</C>
							<C> id="REMARK"		width=150	name="비고"     	sort=true align=center	Edit=none</C>
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

	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_WL_VISITOR 설정 테이블 -->
	<object id="bndT_WL_VISITOR" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_WL_VISITOR">
		<Param Name="BindInfo", Value="
            <C>Col=ENO_NO       Ctrl=txtENO_NO      Param=value</C>
            <C>Col=ENO_NM       Ctrl=txtENO_NM      Param=value</C>
            <C>Col=DPT_NM       Ctrl=txtDPT_NM      Param=value</C>
            <C>Col=JOB_NM       Ctrl=txtJOB_NM      Param=value</C>
			<C>Col=BUY_YMD		Ctrl=txtBUY_YMD		Param=value</C>
			<C>Col=SUP_YMD		Ctrl=txtSUP_YMD		Param=value</C>
			<C>Col=EQUP_KIND	Ctrl=txtEQUP_KIND	Param=value</C>
			<C>Col=PUM_NM 		Ctrl=txtPUM_NM 		Param=value</C>
			<C>Col=MODEL_NO		Ctrl=txtMODEL_NO	Param=value</C>
			<C>Col=SERIAL_NO    Ctrl=txtSERIAL_NO	Param=value</C>
			<C>Col=CONFIG       Ctrl=txtCONFIG  	Param=value</C>
			<C>Col=REMARK       Ctrl=txtREMARK  	Param=value</C>
			<C>Col=USE_GBN		Ctrl=cmbUSE_GBN	Param=value</C>
			<C>Col=ASST_NO		Ctrl=txtASST_NO		Param=value</C>
			<C>Col=ASST_AMT		Ctrl=txtASST_AMT	Param=value</C>
			<C>Col=DPT_NM1		Ctrl=txtDPT_NM1		Param=value</C>
			<C>Col=REG_NM		Ctrl=txtREG_NM		Param=value</C>
		">
	</object>