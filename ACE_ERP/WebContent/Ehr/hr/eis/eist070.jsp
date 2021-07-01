	<!--*************************************************************************
	* @source      : eist070.jsp												*
	* @description : 인건비 배부 관리 PAGE								 	        *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2017/02/16            이동훈         	        최초작성					        *
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ page import="Ehr.common.*" %>
<%
    Configuration conf = Configuration.getInstance();
    String FILEURL = conf.get("framework.file.excel");
%>

<html>
<head>
<title>인건비 배부 관리</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">


        var today = gcurdate;
        
		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

            //이곳에 해당 코딩을 입력 하세요

            //검색조건
            var PIS_YM = document.getElementById("txtPIS_YM").value;
            var PJT_CD = document.getElementById("txtPJT_CD_SHR").value;
            var TEAM_CD = document.getElementById("txtTEAM_CD_SHR").value;
            var ENO_NO = document.getElementById("txtENO_NO_SHR").value;            
            
            //데이터셋 전송
            dsT_TS_LABORCOST.UseChangeInfo = true;
            
            dsT_TS_LABORCOST.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist070.cmd.EIST070CMD&S_MODE=SHR&PIS_YM="+PIS_YM
									            																	+"&PJT_CD="+PJT_CD
									            																	+"&TEAM_CD="+TEAM_CD
									            																	+"&ENO_NO="+ENO_NO;            

            dsT_TS_LABORCOST.Reset();

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


        }


		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {


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


			//이곳에 해당 코딩을 입력 하세요
	        if (dsT_TS_LABORCOST.CountRow < 1) {
	        	
	                alert("엑셀로 변환할 자료가 없습니다!");
	                
	                return;
	        }
	
	        form1.grdT_TS_LABORCOST.GridToExcel("인건비", '', 225);

        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {

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

			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid_New(form1.grdT_TS_LABORCOST,15,"true","true");      // Grid Style 적용

            document.getElementById("txtPIS_YM").value = gcurdate.substring(0,7);  //getTodayArray()[0]+"-"+getTodayArray()[1];

        }

        
        /********************************************
         * 15. 프로젝트 선택 팝업창   		            *
         ********************************************/
        function fnc_GetProject() {

			var obj = new String();
			
			window.showModalDialog("../../../Ehr/common/popup/project.jsp", obj, "dialogWidth:500px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			document.getElementById("txtPJT_CD_SHR").value = obj.pjt_cd;
			document.getElementById("txtPJT_NM_SHR").value = obj.pjt_nm;			

        }        

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								|
    | 2. 이름은 ds_ + 주요 테이블명(T_WL_CARDUP)			|
    | 3. 사용되는 Table List(T_WL_CARDUP) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_TS_LABORCOST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        	Value="True">
		<PARAM NAME="SubsumExpr"		VALUE="total,2:TEAM_NM,1:PJT_NM">        
        <Param Name="UseChangeInfo"   	Value="True">
        <Param Name="ViewDeletedRow"  	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_CM_PERSON)			   |
    | 3. 사용되는 Table List(T_CM_PERSON)				   |
    +------------------------------------------------------>
	<Object ID="trT_TS_LABORCOST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_TS_LABORCOST=dsT_TS_LABORCOST,I:dsT_TS_LABORCOST=dsT_TS_LABORCOST)">
	</Object>


	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_TS_LABORCOST Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_TS_LABORCOST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_TS_LABORCOST Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_TS_LABORCOST event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>


	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_TS_LABORCOST event="OnFail()">
        alert(trT_TS_LABORCOST.ErrorMsg);
    </script>
    <script for=trFILE_UPLOAD event="OnFail()">
        alert(trFILE_UPLOAD.ErrorMsg);
    </script>



	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

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
			<td height="35" class="paddingTop5" align="right">
	        	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>&nbsp;
			
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
                                <col width="70"></col>
                                <col width="100"></col>
                                <col width="70"></col>
                                <col width="180"></col>                                
                                <col width="70"></col>
                                <col width="180"></col>
                                <col width="70"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">해당년월</td>
								<td class="padding2423">
                                    <input id="txtPIS_YM" size="7" maxlength="7" onkeypress="javascript:if(event.keyCode==13) cfCheckNumber(); " onkeyup="cfDateHyphen(this);" style="ime-mode:disabled"  onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value='';} ">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YM','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgPIS_YM"  name="imgPIS_YM" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM','','10','116');"></a>
                                </td>
                                
								<td align="right" class="searchState">프로젝트&nbsp;</td>
								<td class="padding2423">					
					                <input id="txtPJT_CD_SHR" name="txtPJT_CD_SHR" size="9"  maxlength= "8" style="ime-mode:disabled"  class="input_ReadOnly" readonly >
					                <input id="txtPJT_NM_SHR" name="txtPJT_NM_SHR" size="12" maxlength= "14"  class="input_ReadOnly" readonly>
					                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPJT','','../../images/button/btn_HelpOver.gif',1)">
					                <img src="../../images/button/btn_HelpOn.gif" id="ImgPJT" name="ImgPJT" width="21" height="20" border="0" align="absmiddle" onclick="fnc_GetProject()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPJT','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
					            </td>	                                 
                                
								<td align="right" class="searchState">팀&nbsp;</td>
								<td class="padding2423">					
					                <input id="txtTEAM_CD_SHR" name="txtTEAM_CD_SHR" size="9"  maxlength= "8"   style="ime-mode:disabled"  >
					                <input id="txtTEAM_NM_SHR" name="txtTEAM_NM_SHR" size="12" maxlength= "14"  >
					                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTeam','','../../images/button/btn_HelpOver.gif',1)">
					                <img src="../../images/button/btn_HelpOn.gif" id="ImgTeam" name="ImgTeam" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commnmPopup('txtTEAM_CD_SHR','txtTEAM_NM_SHR','소속','DEPT')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTeam','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
					            </td>	                                
                                
                                <td align="right" class="searchState">사번&nbsp;</td>
                                <td class="padding2423">
                                    <input name=txtENO_NO_SHR size="10" maxlength="10" style="ime-mode:disabled" >
                                    <input name=txtENO_NM_SHR size="10" >
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
    				</tr>
    			</table>
    		</td>
    	</tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_TS_LABORCOST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:520px;">
						<param name="DataID" 				value="dsT_TS_LABORCOST">
						<param name="Editable" 				value="false">
						<param name="DragDropEnable" 		value="true">
						<param name="SortView" 				value="Left">
                        <param name="SuppressOption"    	value="1">							
						<param name="ViewSummary"  			value="1">								
						<param name="Format" 				value="						
							<C> Name='소속'				ID=TEAM_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=center, Edit=none, sort=true SumBgColor=#C3D0DB bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, suppress=2,  Value={Decode(CurLevel,2,'팀계',9999,'총계',0,TEAM_NM)}</C>
							<C> Name='프로젝트'			ID=PJT_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=300 align=left,	Edit=none, sort=true SumBgColor=#C3D0DB bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, suppress=1, Value={Decode(CurLevel,1,'소계',0,PJT_NM)}</C>
							<C> Name='사번'				ID=ENO_NO		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center,	Edit=none, sort=true SumBgColor=#C3D0DB bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}</C>
							<C> Name='성명'				ID=ENO_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center,	Edit=none, sort=true SumBgColor=#C3D0DB bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}</C>
							<C> Name='코드'				ID=PJT_CD		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center,	Edit=none, sort=true SumBgColor=#C3D0DB show=false</C>							
							<C> Name='직위'				ID=JOB_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=center,	Edit=none, sort=true SumBgColor=#C3D0DB bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}</C>							
							<C> Name='전체시간'			ID=TOTAL_TM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center,Edit=none, sort=true SumBgColor=#C3D0DB bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}</C>
							<C> Name='PJT시간'			ID=PJT_TM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center,Edit=none, sort=true SumBgColor=#C3D0DB bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}</C>
							<C> Name='전체금액'			ID=TOTAL_AMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB show=false</C>
							<C> Name='PJT금액'			ID=PJT_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}</C>
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

