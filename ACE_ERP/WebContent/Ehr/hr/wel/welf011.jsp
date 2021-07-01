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
	<title>지급장비관리(welf011)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>
<%
	String ENO_NO = request.getParameter("ENO_NO");         //사번
	String Gubun = request.getParameter("GUBUN");
	String mode = request.getParameter("mode") != null ? request.getParameter("mode") : "";
%>
	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var year = getToday().substring(0,4);
		var btnList = 'TTTTFFFF';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {


  // alert("/servlet/GauceChannelSVL?cmd=hr.wel.f.welf010.cmd.WELF010CMD&S_MODE=SHR&SUP_YMD_SHR="+SUP_YMD_SHR+"&RET_YMD_SHR="+RET_YMD_SHR+"&SERIAL_NO_SHR="+SERIAL_NO_SHR+"&USE_GBN_SHR="+USE_GBN_SHR);


			dsT_WL_VISITOR.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.f.welf010.cmd.WELF010CMD&S_MODE=SHR_01&ENO_NO_SHR=<%=ENO_NO%>";
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
			//	fnc_Message(document.getElementById("resultMessage"),"MSG_05");
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
			//	fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {


             document.getElementById("ENO_NO").value = "<%=ENO_NO%>";
              fnc_SearchList() ; //조회
			//cfStyleGrid(form1.grdT_WL_VISITOR,15,"false","right");      // Grid Style 적용-> Sort 가능
			cfStyleGrid(form1.grdT_WL_VISITOR, 0,"false","false");


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
		//	fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
		//	fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_WL_VISITOR.CountRow);
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
	//	fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
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

<body onload="fnc_OnLoadProcess();" oncontextmenu="return false">
	<!-- 캘린더 프레임-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form 시작 -->
	<form name="form1">

	<input type=hidden id="ENO_NO" size="10">

	<!-- 버튼 테이블 시작 -->
	<table width="794" border="0" cellspacing="0" cellpadding="0">
		<tr>
	        <td class="paddingTop8">
    	        <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
        	    <strong>개인별 지급장비 관리</strong>
	        </td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->





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
							<C> id="CONFIG" 	width=130	name="사양" 		sort=true align=center	Edit=none</C>
							<C> id="SUP_YMD"	width=80	name="지급일"		sort=true align=center	Edit=none</C>
							<C> id="BUY_YMD"	width=80	name="구입일"		sort=true align=center	Edit=none</C>
							<C> id="ASST_NO"	width=80	name="자산번호"		sort=true align=center	Edit=none</C>
							<C> id="ASST_AMT"	width=80	name="취득금액"		sort=true align=center	Edit=none</C>
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