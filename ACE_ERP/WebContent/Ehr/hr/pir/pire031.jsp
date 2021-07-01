<!--
    ************************************************************************************
    * @Source         : pire031.jsp                                                     *
    * @Description    : 자격증/전공선택 PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2008/08/20  |  김경주   | 최초작성                                               *
    * 2008/08/20  |  김경주   | 공통팝업으로 이동                                      *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<% String cd_gbn = request.getParameter("CD_GBN");  %>

<html>

    <head>
    <title>자격증/전공선택(pire031)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        //버튼순서  : 조회  신규  저장  취소  엑셀  인쇄  삭제  닫기
        var btnList = 'F' + 'F' + 'F' + 'F' + 'F' + 'F' + 'F' + 'T';

		var dsTemp = window.dialogArguments;


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

         var cd_gbn = '<%=cd_gbn%>';

           if(cd_gbn == "H1"){
                 var grdText = "자격증";
                 dsT_CM_COMMON.DataID = "/servlet/GauceChannelSVL?cmd=hr.pir.e.pire031.cmd.PIRE031CMD&S_MODE=SHR_01";
	             dsT_CM_COMMON.Reset();
           }else{
                 var grdText = "전공";
                 dsT_CM_COMMON.DataID = "/servlet/GauceChannelSVL?cmd=hr.pir.e.pire031.cmd.PIRE031CMD&S_MODE=SHR_02";
	             dsT_CM_COMMON.Reset();
           }

           document.getElementById("title").innerText = grdText;

           form1.grdT_CM_COMMON.Format  = "<C> id='COMM_CD'      width=80    align=center     name='코드'        rightmargin=10</C>";
           form1.grdT_CM_COMMON.Format += "<C> id='COMM_NM'      width=170   align=left       name="+grdText+"   rightmargin=10</C>";

           cfStyleGrid(form1.grdT_CM_COMMON,0,"false","false");      // Grid Style 적용

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

			//이곳에 해당 코딩을 입력 하세요

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

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

            var cd_gbn = '<%=cd_gbn%>';
            var comm_cd;

         if(dsT_CM_COMMON.NameValue(dsT_CM_COMMON.RowPosition, 'CD_GBN') == cd_gbn){
                COMM_CD = dsT_CM_COMMON.NameValue(dsT_CM_COMMON.RowPosition, 'COMM_CD');
				for(i=1;i<dsT_CM_COMMON_CP.CountRow+1;i++){
					if(dsT_CM_COMMON_CP.NameValue(i, 'COMM_CD') == COMM_CD) {
						alert("이미 선택하셨습니다!");
						return;
					}
				}
				//선택된 ROW를 복사
				dsT_CM_COMMON_CP.AddRow();
				dsT_CM_COMMON_CP.NameValue(dsT_CM_COMMON_CP.RowPosition, 'COMM_CD') = dsT_CM_COMMON.NameValue(dsT_CM_COMMON.RowPosition, 'COMM_CD');
				dsT_CM_COMMON_CP.NameValue(dsT_CM_COMMON_CP.RowPosition, 'COMM_NM') = dsT_CM_COMMON.NameValue(dsT_CM_COMMON.RowPosition, 'COMM_NM');
			}

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

            dsT_CM_COMMON_CP.DeleteRow(dsT_CM_COMMON_CP.RowPosition);

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************************
         * 11. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 12. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 13. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            window.close();

        }

		/********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

 			cfStyleGrid(form1.grdT_CM_COMMON,0,"false","false");
			form1.grdT_CM_COMMON.DragDropEnable  = "false";

 			fnc_SearchList();

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

		/********************
         * 16. 확인버튼 처리  *
         *******************/
         function fnc_Confirm() {

            cfCopyDataSet(dsT_CM_COMMON_CP, dsTemp, "copyHeader=yes,rowFrom=1,rowCnt="+dsT_CM_COMMON_CP.CountRow);
   		    dsT_CM_COMMON_CP.ClearAll();
   			fnc_Exit();

          }

        /**
         * 텍스트 검색을 조회
         */
        function fnc_AddCommCd() {

            var cd_gbn = '<%=cd_gbn%>';
            var comm_nm = document.getElementById("txtCOMM_NM_SHR").value;

            dsT_CM_COMMON.DataID = "/servlet/GauceChannelSVL?cmd=hr.pir.e.pire031.cmd.PIRE031CMD&S_MODE=SHR_03&cd_gbn="+cd_gbn+"&&comm_nm="+comm_nm;
	        dsT_CM_COMMON.Reset();

	 }

    </script>
    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->


    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CM_COMMON)    |
    | 3. 사용되는 Table List(T_CM_COMMON)             |
    +----------------------------------------------->
    <Object ID="dsT_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!----------------------------------------------+
    | 1. 카피용 DataSet                             |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CM_COMMON)    |
    | 3. 사용되는 Table List(T_CM_COMMON)             |
    +----------------------------------------------->
    <Object ID="dsT_CM_COMMON_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_CM_COMMON Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        }
        else {

			cfCopyDataSetHeader(dsT_CM_COMMON, dsT_CM_COMMON_CP);
			//dsT_CM_COMMON_CP.SetDataHeader("COMM_CD:STRING:KEYVALUE, COMM_NM:STRING");

			//alert("countrow : "+dsTemp.CountRow+"\n"+dsTemp.ExportData(1, dsTemp.CountRow, true));
			//이미 선택한 소속들이 있으면 다시 보여준다.
			if(dsTemp.CountRow != 0){
				for(i=1;i<=dsTemp.CountRow;i++){
					dsT_CM_COMMON_CP.AddRow();
					dsT_CM_COMMON_CP.NameValue(dsT_CM_COMMON_CP.RowPosition, 'COMM_CD') = dsTemp.NameValue(i, 'COMM_CD');
					dsT_CM_COMMON_CP.NameValue(dsT_CM_COMMON_CP.RowPosition, 'COMM_NM') = dsTemp.NameValue(i, 'COMM_NM');
				}
			}

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_COMMON Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

	<!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_COMMON_CP Event="OnDataError()">

        if (this.ErrorCode == 50019) {
	        alert("중복값이 존재합니다!");
			fnc_Remove();
        } else {
		    cfErrorMsg(this);
	    }

	</Script>

	<!-----------------------------+
    | 트리 뷰를 더블 클릭 했을 때  |
    +------------------------------>
	<script language=JavaScript for=tvT_CM_COMMON event=OnDblClick()>

	  fnc_Append();

	</script>



<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 타이틀 바 테이블 시작 -->
<table width="650" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">항목선택</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="650" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<table width="650" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td>
			<!-- 내용 조회 트리 시작-->
			<table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td width="250" class="paddingTop8">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="center" class="greenTable">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="center" class="searchState"><span id="title">명</span>&nbsp;</td>
                                            <td class="padding2423">
                                                <input type="text" name="txtCOMM_NM_SHR" id="txtCOMM_NM_SHR" maxlength="20" onkeypress="if(event.keyCode==13) fnc_AddCommCd();">
                                                <input type="hidden" name="txtCOMM_CD_SHR" id="txtCOMM_CD_SHR">
                                                <input type="text" style="display:none">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object id="tvT_CM_COMMON" classid=CLSID:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2 style="width:250px;height:300px">
							<param name=DataID		value="dsT_CM_COMMON">
							<param name=TextColumn	value="COMM_NM">
							<param name=ExpandLevel	value="0">
							<param name=BorderStyle  value="2">
							<param name=UseImage      value="false">

							<!-- <param name=UseImage		value="true">
							<param name=ImgDataID		value="idsT_CM_DUTYMST">
							<param name=ImgCColumn	value="ImgC">
							<param name=ImgDColumn	value="ImgD">
							<param name=ImgOColumn	value="ImgO"> -->
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			<!-- 내용 조회 트리 끝-->
    </td>
	<td>
			<!-- 내용 조회 트리 시작-->
			<table width="100" border="0" cellspacing="0" cellpadding="0">
				<tr height="40" align="center">
					<td>
	                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="imgAppend" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
					</td>
				</tr>
				<tr height="40" align="center">
					<td>
	                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()"></a>
					</td>
				</tr>
				<tr align="center">
					<td height="60">&nbsp;
					</td>
				</tr>
				<tr height="40" align="center">
					<td>
	                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConfirm','','/images/button/btn_ConfirmOver.gif',1)"><img src="/images/button/btn_ConfirmOn.gif" name="imgConfirm" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Confirm()"></a>
					</td>
				</tr>
				<tr height="40" align="center">
					<td>
	                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
					</td>
				</tr>
			</table>
			<!-- 내용 조회 트리 끝-->
    </td>
    <td>
        <!-- 내용 조회 그리드 테이블 시작-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
        				<comment id="__NSID__">
        				<object	id="grdT_CM_COMMON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:270;height:350px;">
        					<param name="DataID"				value="dsT_CM_COMMON_CP">
        					<param name="EdiTABLE"				value="false">
        					<param name="DragDropEnable"		value="true">
        					<param name="SortView"				value="Left">
        					<param name="VIEWSUMMARY"			value=0>
        					<param name="Format"				value="
        							">
        				</object>
        				</comment><script> __ShowEmbedObject(__NSID__); </script>
        			</td>
        		</tr>
        	</table>
        <!-- 내용 조회 그리드 데이블 끝-->
    </td>
</tr>
</table>

</form>
<!-- form 끝 -->

</body>
</html>