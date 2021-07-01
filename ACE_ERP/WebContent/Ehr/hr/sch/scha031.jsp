	<!--*************************************************************************
	* @source      : scha031.jsp												*
	* @description : 학자금 신청서 처리 PAGE(POP_UP)	 								*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/18            채갑병            	최초작성
	* 2006/04/26            김학수            	인쇄부분추가
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<% String fsch_nm = request.getParameter("FSCH_NM"); %>

<html>
<head>
	<title>학자금 신청서 처리(scha031)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'FFFFFFFT';
		var img = null;  // 업로드된 사진 보여주기

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
            //이곳에 해당 코딩을 입력 하세요
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
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {
			document.form1.hnw_obj.RunButton("CommandPrint");

        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			//이곳에 해당 코딩을 입력 하세요
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
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			window.close();
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
  			//이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        	img = new Image(document.form1.viewImage);
        	// 팝업시 전달된 DataSet
			var dsTemp = window.dialogArguments;
			var v_ENO_NO  = dsTemp.NameValue(1,"ENO_NO");
			var v_ENO_NM  = dsTemp.NameValue(1,"ENO_NM");
			var v_DPT_NM  = dsTemp.NameValue(1,"DPT_NM");
			var v_JOB_NM  = dsTemp.NameValue(1,"JOB_NM");
			var v_SCH_NM  = dsTemp.NameValue(1,"SCH_NM");
			var v_MAJ_NM  = dsTemp.NameValue(1,"MAJ_NM");
			var v_FSCH_NM = '<%=fsch_nm %>';
			var v_SEL_NM  = dsTemp.NameValue(1,"SEL_NM");
			var v_BIR_YMD = dsTemp.NameValue(1,"BIR_YMD");
			var v_U_FILE  = dsTemp.NameValue(1,"UFILE_NM");

            var hnw_parm  = "[:eno_no]=" + v_ENO_NO;
			    hnw_parm += "[:eno_nm]=" + v_ENO_NM;
			    hnw_parm += "[:dpt_nm]=" + v_DPT_NM;
			    hnw_parm += "[:job_nm]=" + v_JOB_NM;
			    hnw_parm += "[:sch_nm]=" + v_SCH_NM;
			    hnw_parm += "[:maj_nm]=" + v_MAJ_NM;
			    hnw_parm += "[:fsch_nm]="+ v_FSCH_NM;
			    hnw_parm += "[:sel_nm]=" + v_SEL_NM;
			    hnw_parm += "[:bir_ymd]="+ v_BIR_YMD;
			    hnw_parm += "[:u_file]=" + v_U_FILE;
            
			document.form1.u_file.value     = hnw_parm;

			if( dsTemp.NameValue(1,"IMG_YN") == "T" ){
				img.setImage(v_U_FILE);
			}


			document.form1.txtENO_NO.value  = v_ENO_NO;
			document.form1.txtENO_NM.value  = v_ENO_NM;
			document.form1.txtDPT_NM.value  = v_DPT_NM;
			document.form1.txtJOB_NM.value  = v_JOB_NM;
			document.form1.txtSCH_NM.value  = v_SCH_NM;
			document.form1.txtMAJ_NM.value  = v_MAJ_NM;
			document.form1.txtFSCH_NM.value = v_FSCH_NM;
			document.form1.txtSEL_NM.value  = v_SEL_NM;
			document.form1.txtBIR_YMD.value = v_BIR_YMD;

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

		/**
		 * 서버의 업로드 디렉토리의 이미지를 뿌려주는 User Defined Object
		 * - usage : var obj = new Image(이미지테그의ID);
		 *               obj.setImage("서버의 이미지파일의 위치및 파일명");
		 **/
		function Image(imgTag) {
			var imgTag = imgTag;
			var action = "/servlet/JspChannelSVL?cmd=com.shift.gef.generic.cmd.RetrieveGenericImageCMD";
			var imgUrl = "";
			this.setImage = function(img) {
				imgUrl = img;
				imgTag.src = action + "&IMAGE=" +imgUrl;
			}
		}
    </script>
    <SCRIPT ID=clientHnwActivEvent LANGUAGE=javascript FOR="hnw_obj" EVENT="FireEvent(nParam1,nParam2,strParam)">
    <!-- //EZgen에 FireEvent 버튼 실행시 발생됨 -->
        var hnw_parm  = document.form1.u_file.value;
        document.form1.hnw_obj.setvalues(hnw_parm);

    </SCRIPT>

</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 학년 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_E9"/>
       <jsp:param name="CODE_GUBUN"    value="E9"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->


	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- form 시작 -->
	<form name="form1">

	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">학자금 신청서 처리</td>
					<td align="right" class="navigator">HOME/복리후생/학자금지원/<font color="#000000">학자금 신청서 처리</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_PrintOver.gif',1)">
                    <img src="/images/button/btn_PrintOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">
                    <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- 조건 입력 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="80"></col>
			<col width="100"></col>
			<col width="80"></col>
			<col width="100"></col>
			<col width="80"></col>
			<col width="100"></col>
			<col width="80"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">사번</td>
			<td class="padding2423"><input id="txtENO_NO" size="10" style="ime-mode:disabled" readonly class="input_ReadOnly"></td>
			<td align="center" class="creamBold">성명</td>
			<td class="padding2423"><input id="txtENO_NM" size="12" style="ime-mode:disabled" readonly class="input_ReadOnly"></td>
			<td align="center" class="creamBold">소속</td>
			<td class="padding2423"><input id="txtDPT_NM" size="15" style="ime-mode:disabled" readonly class="input_ReadOnly"></td>
			<td align="center" class="creamBold">직위</td>
			<td class="padding2423"><input id="txtJOB_NM" size="7"  style="ime-mode:disabled" readonly class="input_ReadOnly"></td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="paddingTop8"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle"> 수혜자녀에 대한 정보</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="60"></col>
			<col width="60"></col>
			<col width="60"></col>
			<col width="60"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">성명</td>
			<td class="padding2423"><input id="txtSEL_NM" size="12" maxLength="12" style="ime-mode:disabled" readonly class="input_ReadOnly"></td>
			<td align="center" class="creamBold">생년월일</td>
			<td class="padding2423"><input id="txtBIR_YMD" size="14" maxLength="14" style="ime-mode:disabled" readonly class="input_ReadOnly"></td>
			<td align="center" class="creamBold">학교명</td>
			<td class="padding2423"><input id="txtSCH_NM" size="12" maxLength="10" style="ime-mode:disabled" readonly class="input_ReadOnly"></td>
			<td align="center" class="creamBold">학과</td>
			<td class="padding2423"><input id="txtMAJ_NM" size="14" maxLength="10" style="ime-mode:disabled" readonly class="input_ReadOnly"></td>
			<td align="center" class="creamBold">학년</td>
			<td class="padding2423"><input id="txtFSCH_NM" size="14" maxLength="10" style="ime-mode:disabled" readonly class="input_ReadOnly"></td>
		</tr>
		<tr>
			<td colspan="10" align="center"><img id="viewImage" src="init" border="0" onerror="this.src='/images/common/none.jpg';"></td>
		</tr>
		</table>
		</td>
	</tr>
	</table>
	<input type="hidden" id="u_file">
	<!-- 조건 입력 테이블 끝 --> 
    <comment id="__NSID__">
        <object id="hnw_obj" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="0" height400" codebase="<%=hnwcodebase%>">
            <param name="hnwsrc"    VALUE="scha031.hnw">
            <param name="initvalue" VALUE="">
            <param name="hidewnd"   VALUE="N">
            <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
        </object>
    </comment><script> __ShowEmbedObject(__NSID__); </script>

	</form>
	<!-- form 끝 -->

</body>
</html>

