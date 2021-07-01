	<!--*************************************************************************
	* @source      : welg010.jsp												*
	* @description : 기념대상자현황 PAGE	 								  		*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/29            채갑병            	최초작성						*
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%

     String ROLE_CD   = box.getString("SESSION_ROLE_CD");
     String ENO_NO    = box.get("SESSION_ENONO");

     //ROLE_CD가 관리자인지 여부
     boolean isMaster = false;

     if(ROLE_CD.equals("1001") || ROLE_CD.equals("1002")) {
    	 isMaster = true;
     }

     //경영개선부 강제 권한
     boolean open_yn = false;

     if(ENO_NO.equals("20000413") || ENO_NO.equals("20800746")) {
    	 open_yn = true;
     }

%>

<html>
<head>
	<title>기념대상자현황(welg010)</title>
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

		var btnList = 'TTTTFFTT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

<%
    if(isMaster || open_yn) {
%>
            var pis_yymm = document.getElementById("txtPIS_YM_SHR").value;
<%
    } else {
%>
            var pis_yymm = '';
<%
    }
%>
            if(document.getElementById("txtDPT_CD_SHR").value== '') {
                 var dpt_cd = '%';
            }
            else {
                 var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;
            }

            if(document.getElementById("txtENO_NO_SHR").value== '') {
                 var eno_no_shr = '%';
            }
            else {
                 var eno_no_shr = document.getElementById("txtENO_NO_SHR").value;
            }


            dsT_WL_CAKELIST.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.g.welg010.cmd.WELG010CMD&S_MODE=SHR&PIS_YY="+pis_yymm.substring(0,4)+"&PIS_MM="+pis_yymm.substring(5,7)+"&DPT_CD="+dpt_cd+"&ENO_NO_SHR="+eno_no_shr;
			dsT_WL_CAKELIST.reset();

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

			// save
			trT_WL_CAKELIST.KeyValue = "tr01(I:dsT_WL_CAKELIST=dsT_WL_CAKELIST)";
			trT_WL_CAKELIST.action = "/servlet/GauceChannelSVL?cmd=hr.wel.g.welg010.cmd.WELG010CMD&S_MODE=SAV";
			trT_WL_CAKELIST.post();

        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
	        if(dsT_WL_CAKELIST.CountRow < 1) {
	           alert("삭제할 자료가 없습니다.");
	           fnc_Message(document.getElementById("resultMessage"), "MSG_05");
	           return;
	        }
	        if(confirm("[사번:"+dsT_WL_CAKELIST.NameValue(dsT_WL_CAKELIST.RowPosition,'ENO_NO')+"]의 정보를 삭제하시겠습니까?")){
	           dsT_WL_CAKELIST.DeleteRow(dsT_WL_CAKELIST.RowPosition);

	           trT_WL_CAKELIST.keyValue = "tr01(I:dsT_WL_CAKELIST=dsT_WL_CAKELIST)";
	           trT_WL_CAKELIST.action = "/servlet/GauceChannelSVL?cmd=hr.wel.g.welg010.cmd.WELG010CMD&S_MODE=DEL";
	           trT_WL_CAKELIST.post();
            }
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
			 if (dsT_WL_CAKELIST.CountRow < 1) {
			    alert("엑셀로 변환할 자료가 없습니다!");
			    return;
			 }
			 form1.grdT_WL_CAKELIST.GridToExcel("기념일대상현황",'',225);
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {

              enableInput();

              if(dsT_WL_CAKELIST.CountColumn < 1) {
               //데이터셋의 헤더 정보 설정.
               dsT_WL_CAKELIST.setDataHeader("ENO_NO:STRING, ENO_NM:STRING, DPT_CD:STRING, JOB_CD:STRING, CAKE_DATE:STRING, CAKE_CD:STRING, REMARK:STRING, ADDRESS:STRING, EM_PHN_NO:STRING");
              }

              dsT_WL_CAKELIST.AddRow();

              document.getElementById('txtENO_NO').focus();


         }


		/*********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {
           //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
<%
    if(isMaster || open_yn) {
%>
        	document.getElementById("txtENO_NO").value = "";
        	document.getElementById("txtENO_NM").value = "";
        	document.getElementById("txtDPT_NM").value = "";
        	document.getElementById("txtJOB_NM").value = "";
        	document.getElementById("txtCAKE_DATE").value = "";
        	document.getElementById("cmbCAKE_CD").value = "";
        	document.getElementById("txtREMARK").value = "";
        	document.getElementById("txtADDRESS").value = "";
        	document.getElementById("txtEM_PHN_NO").value = "";

        	document.getElementById("txtDPT_CD_SHR").value ='';
			document.getElementById("txtDPT_NM_SHR").value ='';

			document.getElementById("txtENO_NO_SHR").value ='';
			document.getElementById("txtENO_NM_SHR").value ='';

<%
    }
%>

        	document.getElementById("resultMessage").innerText = '';
        	dsT_WL_CAKELIST.ClearData();

        	disableInput();

        	document.getElementById('txtPIS_YM_SHR').value = getTodayArray()[0]+"-"+getTodayArray()[1];
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_WL_CAKELIST.IsUpdated)  {
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
         	if (!dsT_WL_CAKELIST.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			if (document.getElementById("txtENO_NO").value == "") {
			   alert("사번은 필수 입력사항입니다.");
			   document.getElementById("txtENO_NO").focus();
			   return false;
			}
		    if (document.getElementById("txtENO_NM").value == "") {
		       alert("성명은 필수 입력사항입니다.");
		       document.getElementById("txtENO_NM").focus();
		       return false;
		    }
		    if (document.getElementById("txtCAKE_DATE").value == "") {
		       alert("기념일 날짜는 필수 입력사항입니다.");
		       document.getElementById("txtCAKE_DATE").focus();
		       return false;
		    }
		    if (document.getElementById("cmbCAKE_CD").value == "") {
		       alert("기념일 코드는 필수 입력사항입니다.");
		       document.getElementById("cmbCAKE_CD").focus();
		       return false;
		    }
		    if (document.getElementById("txtADDRESS").value == "") {
		       alert("주소는 필수 입력사항입니다.");
		       document.getElementById("txtADDRESS").focus();
               return false;
		    }
			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

           document.getElementById('txtPIS_YM_SHR').value = getTodayArray()[0]+"-"+getTodayArray()[1];
           document.getElementById('txtPIS_YM_SHR').focus();

           disableInput();

   		   cfStyleGrid(form1.grdT_WL_CAKELIST,15,"true","false");      // Grid Style 적용

<%
    if(isMaster || open_yn) {
%>
  		    for( var i = 1; i <= dsCOMMON_HH.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_HH.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_HH.NameValue(i,"CODE_NAME");
                document.getElementById("cmbCAKE_CD").add(oOption);
            }
<%
    } else   {
%>
           	document.getElementById("txtENO_NO_SHR").value = "<%=box.get("SESSION_ENONO") %>";
			document.getElementById("txtENO_NM_SHR").value = "<%=box.get("SESSION_ENONM") %>";
			document.getElementById("txtDPT_CD_SHR").value = '<%= box.get("SESSION_DPTCD")%>';
            document.getElementById("txtDPT_NM_SHR").value = '<%= box.get("SESSION_DPTNM")%>';

            //조회조건 비활성화
            document.getElementById('txtPIS_YM_SHR').readOnly = true;
			document.getElementById('txtPIS_YM_SHR').className="input_ReadOnly";
		    document.getElementById("imgPIS_YM_SHR").style.display = "none";
            document.getElementById('txtENO_NO_SHR').readOnly = true;
			document.getElementById('txtENO_NO_SHR').className="input_ReadOnly";
   			document.getElementById('txtENO_NM_SHR').readOnly = true;
			document.getElementById('txtENO_NM_SHR').className="input_ReadOnly";
 		    document.getElementById("imgENO_NO_SHR").style.display = "none";
   			document.getElementById('txtDPT_CD_SHR').readOnly = true;
			document.getElementById('txtDPT_CD_SHR').className="input_ReadOnly";
			document.getElementById("imgDPT_CD_SHR").style.display = "none";

<%
    }
%>


}

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /********************************************
         * 입력필드 사용 가능하게(Enable)*
         ********************************************/
  		function enableInput(){
	        var elementList = new Array(  "txtENO_NO"
                                         ,"txtENO_NM"
	                                     ,"txtCAKE_DATE"
                                         ,"cmbCAKE_CD"
                                         ,"txtREMARK"
                                         ,"txtADDRESS"
                                         ,"txtEM_PHN_NO" );
  			fnc_EnableElementAll(elementList);
  		}

  		function enableInput2(){
  			disableInput();
	        var elementList = new Array(  "txtENO_NO"
                                         ,"txtENO_NM"
//	                                     ,"txtCAKE_DATE"
                                         ,"cmbCAKE_CD"
                                         ,"txtREMARK"
                                         ,"txtADDRESS"
                                         ,"txtEM_PHN_NO" );
  			fnc_EnableElementAll(elementList);
  		}

  		/********************************************
         * 입력필드 사용 불가능하게(Disable)         *
         ********************************************/
  		function disableInput(){
	        var elementList = new Array(  "txtENO_NO"
                                         ,"txtENO_NM"
	                                     ,"txtCAKE_DATE"
                                         ,"cmbCAKE_CD"
                                         ,"txtREMARK"
                                         ,"txtADDRESS"
                                         ,"txtEM_PHN_NO" );

  		 	fnc_DisableElementAll(elementList);

   		}


		/***********************
         *   사원조회용 팝업 *
         **********************/
		function fnc_EmplPop() {

			var obj = new String();

            obj.shr_kind = "SHR_02";
            obj.eno_nm = "";

            window.showModalDialog("/common/popup/empl2.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
            document.getElementById("txtENO_NO").value = obj.eno_no;
            document.getElementById("txtENO_NM").value = obj.eno_nm;
            document.getElementById("txtDPT_CD").value = obj.dpt_cd;
            document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            document.getElementById("txtJOB_CD").value = obj.job_cd;
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
                document.getElementById("txtDPT_CD").value      = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
                document.getElementById("txtJOB_CD").value      = obj.job_cd;
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_CD").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
                document.getElementById("txtJOB_CD").value      = "";
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
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(T_WL_CAKELIST)		   |
    | 3. 사용되는 Table List(T_WL_CAKELIST) 			   |
    +------------------------------------------------------>
    <Object ID="dsT_WL_CAKELIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
         <param Name="Syscload"        Value="True">
         <Param Name="UseChangeInfo"   Value="True">
         <param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_WL_CAKELIST)			   |
    | 3. 사용되는 Table List(T_WL_CAKELIST)				   |
    +------------------------------------------------------>
	<Object ID="trT_WL_CAKELIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>


  <!-----------------------------------------------------+
    | 1. 카피용 DataSet							           |
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_CHASULIST)		   |
    | 3. 사용되는 Table List(T_ED_CHASULIST) 				   |
    +------------------------------------------------------>

    <!-- 교육형태 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_HH"/>
       <jsp:param name="CODE_GUBUN"    value="HH"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>



	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직		|
    +------------------------------------------------------>
	<Script For=dsT_WL_CAKELIST Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			enableInput2();
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_WL_CAKELIST.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직	|
    +------------------------------------------------------>
	<Script For=dsT_WL_CAKELIST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------>
	<Script For=dsT_WL_CAKELIST Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						|
    +------------------------------------------------------>
	<script for=trT_WL_CAKELIST event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>


	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						|
    +------------------------------------------------------>
	<script for=trT_WL_CAKELIST event="OnFail()">
        alert(trT_WL_CAKELIST.ErrorMsg);
    </script>

	<!-----------------------------------------------------+
    | 신규데이터외에 일자 수정불가 처리					   |
    +------------------------------------------------------>
	<script for=grdT_WL_CAKELIST event=OnClick(row,col)>
		var eno_no = dsT_WL_CAKELIST.ColumnValue(row,2);
		var cake_date = dsT_WL_CAKELIST.ColumnValue(row,6);

		if(eno_no == "" || cake_date == "") {
			enableInput();		// 신규
		}
		else {
			enableInput2();		// 수정
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">기념대상자현황</td>
					<td align="right" class="navigator">HOME/복리후생/기념일현황/<font color="#000000">기념대상자현황</font></td>
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
<%
    if(isMaster || open_yn){
%>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
   	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
<%
    }
%>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image7" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
								<col width="70"></col>
								<col width="80"></col>
                                <col width="70"></col>
								<col width="*"></col>
							</colgroup>
							<tr>
								<td align="center" class="searchState">대상년월&nbsp;</td>
								<td class="padding2423">
                                    <input id="txtPIS_YM_SHR" size="7" maxlength="7" onkeypress="javascript:if(event.keyCode==13) cfCheckNumber(); " onkeyup="cfDateHyphen(this);" style="ime-mode:disabled"  onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value='';} ">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgPIS_YM_SHR"  name="imgPIS_YM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','10','116');"></a>
                                </td>
                                <td class="searchState" align="right">소속별</td>
                                <td class="padding2423" align="left">
                                    <input id="txtDPT_CD_SHR" size="3" maxlength="2" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
                                    <input id="txtDPT_NM_SHR" style="width:100px" class="input_ReadOnly"  readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgDPT_CD_SHR" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
                                <td align="right" class="searchState"> 사 번&nbsp; </td>
                                <td class="padding2423">
								    <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13){fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();}cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled" >
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13){fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');"></a>
							    </td>
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
<%
    if(open_yn || isMaster ){
%>
    <!-- 조건 입력 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="60"></col>
			<col width="100"></col>
			<col width="60"></col>
			<col width="100"></col>
			<col width="50"></col>
			<col width="85"></col>
			<col width="50"></col>
			<col width="85"></col>
			<col width="80"></col>
			<col width=""></col>
		</colgroup>
		<tr>
            <td align="center" class="creamBold">사 번</td>
            <td class="padding2423">
			    <input id="txtENO_NO" name="txtENO_NO" size="10" maxlength="8" onkeypress="if(event.keyCode==13){fnc_GetEnoNm('txtENO_NO','txtENO_NM');fnc_SearchEmpNo();}cfNumberCheck();" onchange="fnc_SearchEmpNo();" style="ime-mode:disabled" >
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image11" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(txtENO_NO.disabled == true){return;} fnc_EmplPop();"></a>
            </td>
            <td align="center" class="creamBold">성명</td>
            <td class="padding2423">
				<input id="txtENO_NM" name="txtENO_NM" size="15" maxlength="10" onkeypress="if(event.keyCode==13){fnc_GetEnoNo('txtENO_NM','txtENO_NO');fnc_SearchEmpNm();}" onchange="fnc_SearchEmpNm();">
            </td>
   			<td align="center" class="creamBold">소속</td>
   			<td class="padding2423"><input type=hidden id="txtDPT_CD"><input id="txtDPT_NM" size="13" class="input_ReadOnly" readonly></td>
            <td align="center" class="creamBold">직위</td>
			<td class="padding2423"><input type=hidden id="txtJOB_CD"><input id="txtJOB_NM" size="13" class="input_ReadOnly" readonly></td>
			<td align="center" class="creamBold">날짜</td>
			<td class="padding2423"><input id="txtCAKE_DATE" size="13" maxlength="10" style="ime-mode:disabled"></td>
		</tr>
		<tr>
            <td align="center" class="creamBold">코드</td>
            <td class="padding2423">
             <select id="cmbCAKE_CD" style="width:100%" >
                    <option value=""></option>
             </select>
            </td>
            <td align="center" class="creamBold">세부내역</td>
            <td class="padding2423"><input id="txtREMARK" size="15" maxlength="15" ></td>
			<td align="center" class="creamBold">주소</td>
			<td class="padding2423" colspan="3"><input id="txtADDRESS" size="39" maxlength="39" ></td>
			<td align="center" class="creamBold">핸드폰번호</td>
			<td class="padding2423"><input id="txtEM_PHN_NO" size="13" maxlength="13"  style="ime-mode:disabled" ></td>
   		</tr>
		</table>
		</td>
	</tr>
	</table>
<%
    }
%>
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
					<object id="grdT_WL_CAKELIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">

						<param name="DataID" value="dsT_WL_CAKELIST">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"		width=34	name="NO"		   align=center	     value={String(Currow)}     </C>
							<C> id="DPT_NM"		    width=110	name="소속"	       align=legt        Edit=none  leftmargin=10   </C>
							<C> id="JOB_NM"		    width=50	name="직위"	       align=center	     Edit=none	                </C>
							<C> id="ENO_NO"			width=59	name="사번"		   align=center	     Edit=none	                </C>
							<C> id="EMO_NM"		    width=55	name="성명"	       align=center	     Edit=none	                </C>
							<C> id="CAKE_DATE"		width=70	name="날짜"	       align=center	     Edit=none	                </C>
							<C> id="CAKE_NM"	  	width=70	name="구분"	       align=center	     Edit=none  Editstyle=lookup  Data="dsT_CM_COMMON:COMM_CD:COMM_NM"   </C>
							<C> id="CAKE_YEAR"	  	width=50	name="차수"	       align=center	     Edit=none                  </C>
							<C> id="REMARK"		    width=90	name="세부내역"	   align=center	     Edit=none                  </C>
							<C> id="ADDRESS"		width=300	name="주소"	       align=left		 Edit=none 	             	</C>
							<C> id="EM_PHN_NO"		width=90	name="핸드폰번호"  align=left		 Edit=none	             	</C>
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
<!-- 기념일 관리 테이블 -->
<object id="bndT_WL_CAKELIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_WL_CAKELIST">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NO		Ctrl=txtENO_NO	     	Param=value		</C>
		<C>Col=EMO_NM       Ctrl=txtENO_NM          Param=value     </C>
	    <C>Col=DPT_NM       Ctrl=txtDPT_NM          Param=value     </C>
		<C>Col=JOB_NM       Ctrl=txtJOB_NM          Param=value     </C>
		<C>Col=CAKE_DATE	Ctrl=txtCAKE_DATE	    Param=value		</C>
		<C>Col=CAKE_CD    	Ctrl=cmbCAKE_CD	     	Param=value		</C>
		<C>Col=REMARK		Ctrl=txtREMARK	     	Param=value		</C>
		<C>Col=ADDRESS		Ctrl=txtADDRESS	     	Param=value		</C>
		<C>Col=EM_PHN_NO	Ctrl=txtEM_PHN_NO	    Param=value		</C>

    '>
</object>

