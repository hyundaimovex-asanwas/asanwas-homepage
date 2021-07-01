	<!--*************************************************************************
	* @source      : welj012.jsp												*
	* @description : 통근버스노선 등록 PAGE											*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------			*
	* 2010/03/24            권혁수                      통근버스노선최초작성
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
	String eno_no = box.getString("SESSION_ENONO");         //품의자사번
	String eno_nm = box.getString("SESSION_ENONM");         //품의자사번
	String dep_cd = box.getString("SESSION_DPTCD");         //품의자사번

%>


<html>
<head>
	<title>통근버스노선등록(welj012)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TTTTFFTT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			trT_WL_BUSLINE_SHR.KeyValue = "tr05(O:dsT_WL_BUSLINE=dsT_WL_BUSLINE)";
			trT_WL_BUSLINE_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.wel.j.welj012.cmd.WELJ012CMD&S_MODE=LINE_SHR";
			trT_WL_BUSLINE_SHR.post();
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
			trT_WL_BUSLINE.KeyValue = "tr01(I:dsT_WL_BUSLINE=dsT_WL_BUSLINE,I:dsT_WL_BUSSTOP=dsT_WL_BUSSTOP)";
			trT_WL_BUSLINE.action = "/servlet/GauceChannelSVL?cmd=hr.wel.j.welj012.cmd.WELJ012CMD&S_MODE=SAVE";
			trT_WL_BUSLINE.post();
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
            // 삭제 할 자료가 있는지 체크하고
            if (dsT_WL_BUSLINE.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }
            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + dsT_WL_BUSLINE.ColumnString(dsT_WL_BUSLINE.RowPosition,2) + "] 자료를 제거하시겠습니까?") == false) return;

            dsT_WL_BUSLINE.DeleteRow(dsT_WL_BUSLINE.RowPosition);

			trT_WL_BUSLINE.KeyValue = "tr01(I:dsT_WL_BUSLINE=dsT_WL_BUSLINE,I:dsT_WL_BUSSTOP=dsT_WL_BUSSTOP)";
			trT_WL_BUSLINE.action = "/servlet/GauceChannelSVL?cmd=hr.wel.j.welj012.cmd.WELJ012CMD&S_MODE=DEL";
			trT_WL_BUSLINE.post();

	       	dsT_WL_BUSSTOP.ClearData();
        }

        function fnc_Delete1() {

        var CountRow = dsT_WL_BUSSTOP.CountRow;
        var jj;
        dsT_WL_BUSSTOP.DeleteRow(dsT_WL_BUSSTOP.RowPosition);

                     for (var i = dsT_WL_BUSSTOP.RowPosition-1; i <= CountRow; i++) {

                        if (i < 10) jj = "0" + i;
                        else jj =  i;

                        dsT_WL_BUSSTOP.NameValue(i, "SEQ") = jj;      // SEQ 순서
                    }

        }
		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {
            //이곳에 해당 코딩을 입력 하세요
        }


        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_WL_BUSLINE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_WL_BUSLINE.GridToExcel("통근버스노선목록", '', 225);

        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
        	dsT_WL_BUSLINE.AddRow();
        }

        function fnc_AddNew1() {

        var CountRow = dsT_WL_BUSSTOP.CountRow + 1;
        var jj, MAX_KEY = 0;
            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_WL_BUSSTOP.CountColumn == 0) {
                alert("먼저 노선을  선택, 조회작업을 하신 다음에 작업을 하시기 바랍니다.");
                return;
            }
            else {
            		var LINE_CD;

               if (dsT_WL_BUSSTOP.CountRow == 0) {

                    LINE_CD = dsT_WL_BUSLINE.NameValue(dsT_WL_BUSLINE.RowPosition, "LINE_CD");
                    if (LINE_CD == "") {
                       alert("노선 코드가 없습니다. 작업은 취소되었습니다."+LINE_CD);
                       return;
                    }

                    dsT_WL_BUSSTOP.AddRow();
                    dsT_WL_BUSSTOP.NameValue(1, "LINE_CD") = LINE_CD;      // 노선번호
                    dsT_WL_BUSSTOP.NameValue(1, "SEQ") = "01";
                    dsT_WL_BUSSTOP.NameValue(1, "KEY_SEQ") = 1;     //

               } else {
                    LINE_CD = dsT_WL_BUSSTOP.NameValue(1, "LINE_CD");

                    for (var i = 1; i <= CountRow; i++) {
                        if (dsT_WL_BUSSTOP.NameValue(i, "KEY_SEQ") > MAX_KEY) MAX_KEY =  dsT_WL_BUSSTOP.NameValue(i, "KEY_SEQ");
                    }
                    MAX_KEY = MAX_KEY + 1;


                    dsT_WL_BUSSTOP.InsertRow(dsT_WL_BUSSTOP.RowPosition+1);
                    dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "LINE_CD") = LINE_CD;      // 노선번호
                    dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "KEY_SEQ") = MAX_KEY;     //

                    for (var i = dsT_WL_BUSSTOP.RowPosition; i <= CountRow; i++) {
                        if (i < 10) jj = "0" + i;
                        else jj =  i;
                        dsT_WL_BUSSTOP.NameValue(i, "SEQ") = jj;      // SEQ 순서
                    }
               }

            }
        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {

        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
        	dsT_WL_BUSLINE.ClearData();
        	dsT_WL_BUSSTOP.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
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

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_WL_BUSLINE,15,"true","false");      // Grid Style 적용
            cfStyleGrid(form1.grdT_WL_BUSSTOP,15,"true","false");      // Grid Style 적용
			fnc_SearchList();
        }


		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
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
    | 2. 이름은 ds_ + 주요 테이블명(dsT_WL_BUSLINE)			 	   |
    | 3. 사용되는 Table List(dsT_WL_BUSLINE) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_WL_BUSLINE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	<Object ID="dsT_WL_BUSSTOP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_CHANGE)		       |
    | 3. 사용되는 Table List(T_DI_CHANGE)			       |
    +------------------------------------------------------>
	<Object ID="trT_WL_BUSLINE_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_WL_BUSLINE=dsT_WL_BUSLINE)">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_CHANGE)		       |
    | 3. 사용되는 Table List(T_DI_CHANGE)			       |
    +------------------------------------------------------>
	<Object ID="trT_WL_BUSLINE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(I:dsT_WL_BUSLINE=dsT_WL_BUSLINE)">
	</Object>
	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_WL_BUSLINE Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_WL_BUSLINE.CountRow);
        }
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </Script>
	<Script For=dsT_WL_BUSSTOP Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>
	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_WL_BUSLINE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_WL_BUSLINE event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_WL_BUSLINE event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_WL_BUSLINE_SHR event="OnSuccess()">
		//fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_WL_BUSLINE_SHR event="OnFail()">
        cfErrorMsg(this);
    </script>

  </script>

  <script language=JavaScript for=grdT_WL_BUSLINE event=OnDblClick(row,colid)>
			var LINE_CD = dsT_WL_BUSLINE.NameValue(row,"LINE_CD");

			trT_WL_BUSLINE_SHR.KeyValue = "tr06(O:dsT_WL_BUSSTOP=dsT_WL_BUSSTOP)";
			trT_WL_BUSLINE_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.wel.j.welj012.cmd.WELJ012CMD&S_MODE=STOP_SHR&LINE_CD="+LINE_CD;
			trT_WL_BUSLINE_SHR.post();

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
    <input type="hidden" id="hidEMPL_DPT_CD">
	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">통근버스노선관리</td>
					<td align="right" class="navigator">HOME/복리후생/통근버스/<font color="#000000">통근버스노선관리</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"     name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
					<object id="grdT_WL_BUSLINE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:200px;">
						<param name="DataID" value="dsT_WL_BUSLINE">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=29	name="NO"			align=center	value={String(Currow)}</C>
							<C> id="LINE_CD"	width=60    name="노선코드"		align=center	    </C>
							<C> id="LINE_NM"	width=100	name="노선명"		align=center	    </C>
                            <C> id="COM_NM"     width=100    name="회사명"      align=center        </C>
                            <C> id="FULL_GBN"   width=100    name="만차여부"    align=center    EditStyle=Combo Data="1:가능,2:만차" BgColor={Decode(FULL_GBN,"2","#FEB293")}</C>
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
	<!-- 조회 결과  시작-->
	<table width="550" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
						<td valign="top" align="right">
							<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew1()"></a>
				            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete1()"></a>
			            </td>
					</tr>
				</table>
			</td>

		</tr>
	</table>
	<!-- 조회 결과  끝-->

	<!-- 정류장 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_WL_BUSSTOP" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:550px;height:300px;">
						<param name="DataID" value="dsT_WL_BUSSTOP">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="SEQ"		width=60    name="순서"			align=center	    </C>
							<C> id="KEY_SEQ"		width=60    name="순서"		align=center	Edit=none   show=false  </C>
							<C> id="LINE_CD"	width=60    name="노선코드"		align=center	Edit=none   show=false  </C>
							<C> id="STOP_LOC"	width=350	name="탑승지"		align=left	    </C>
                            <C> id="STOP_TIME"  width=100   name="탑승시각"     align=center        </C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	</form>
	<!-- form 끝 -->
</body>
</html>
